require "language/node"

class Gitmoji < Formula
  desc "Interactive command-line tool for using emoji in commit messages"
  homepage "https://gitmoji.dev"
  url "https://registry.npmjs.org/gitmoji-cli/-/gitmoji-cli-8.2.0.tgz"
  sha256 "72cd1051b7079fb8eae7b4d37dd05214290954b8c0fa15de98803803944f0020"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "e83103b70e544abcb7ef7b7ec4b5a4e54d19a5011295904d1f947f12fa948c7b"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e83103b70e544abcb7ef7b7ec4b5a4e54d19a5011295904d1f947f12fa948c7b"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "e83103b70e544abcb7ef7b7ec4b5a4e54d19a5011295904d1f947f12fa948c7b"
    sha256 cellar: :any_skip_relocation, ventura:        "e8e12ca85a66868daede0cd3c308c588cd47c94c601ffa9e9112818d13b93a75"
    sha256 cellar: :any_skip_relocation, monterey:       "e8e12ca85a66868daede0cd3c308c588cd47c94c601ffa9e9112818d13b93a75"
    sha256 cellar: :any_skip_relocation, big_sur:        "e8e12ca85a66868daede0cd3c308c588cd47c94c601ffa9e9112818d13b93a75"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e83103b70e544abcb7ef7b7ec4b5a4e54d19a5011295904d1f947f12fa948c7b"
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match ":bug:", shell_output("#{bin}/gitmoji --search bug")
  end
end
