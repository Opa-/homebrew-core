class Osc < Formula
  include Language::Python::Virtualenv

  desc "Command-line interface to work with an Open Build Service"
  homepage "https://openbuildservice.org"
  url "https://github.com/openSUSE/osc/archive/refs/tags/1.9.0.tar.gz"
  sha256 "9c6d03e98524db84fe7f5e285cfb1ab2cd256913ad8d825eda0303acb7326167"
  license "GPL-2.0-or-later"
  head "https://github.com/openSUSE/osc.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "4190de84cdf3b2986710a2568ca4d720b4888dc109703a95c84527b457669e73"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "4190de84cdf3b2986710a2568ca4d720b4888dc109703a95c84527b457669e73"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "4190de84cdf3b2986710a2568ca4d720b4888dc109703a95c84527b457669e73"
    sha256 cellar: :any_skip_relocation, sonoma:         "80cb7356575689ca9bd7bc9ac64c1d55dc5c1522499d69adc964c88d14327806"
    sha256 cellar: :any_skip_relocation, ventura:        "80cb7356575689ca9bd7bc9ac64c1d55dc5c1522499d69adc964c88d14327806"
    sha256 cellar: :any_skip_relocation, monterey:       "80cb7356575689ca9bd7bc9ac64c1d55dc5c1522499d69adc964c88d14327806"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bc80e64f4b581cfc07e01dae65ac8028d241c9f651cd3916d5a789054b6db549"
  end

  depends_on "cryptography"
  depends_on "python@3.12"

  uses_from_macos "curl"
  uses_from_macos "libffi"

  resource "rpm" do
    url "https://files.pythonhosted.org/packages/44/1b/ef44b5e2fae8e398bfc58f38c25a6f0a10ea147e3e4970b7e66154017d1d/rpm-0.2.0.tar.gz"
    sha256 "b92285f65c9ddf77678cb3e51aa67827426408fac34cdd8d537d8c14e3eaffbf"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/43/6d/fa469ae21497ddc8bc93e5877702dca7cb8f911e337aca7452b5724f1bb6/urllib3-2.2.2.tar.gz"
    sha256 "dd505485549a7a552833da5e6063639d0d177c04f23bc3864e41e5dc5f612168"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    test_config = testpath/"oscrc"
    ENV["OSC_CONFIG"] = test_config

    test_config.write <<~EOS
      [general]
      apiurl = https://api.opensuse.org

      [https://api.opensuse.org]
      credentials_mgr_class=osc.credentials.TransientCredentialsManager
      user=brewtest
      pass=
    EOS

    output = shell_output("#{bin}/osc status 2>&1", 1).chomp
    assert_match "Directory '.' is not a working copy", output
    assert_match "Please specify a command", shell_output("#{bin}/osc 2>&1", 2)
  end
end
