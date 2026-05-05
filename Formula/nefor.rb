class Nefor < Formula
  desc "Agent harness substrate — NCP-speaking engine with Lua composition"
  homepage "https://github.com/amenocturne/nefor"
  url "https://github.com/amenocturne/nefor/releases/download/v0.1.2/nefor-aarch64-apple-darwin.tar.gz"
  sha256 "f4881af09533da6cc9deacdb3831e28557a0c53128b566b8ee20a1d1d6d443f1"
  version "0.1.2"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "bin/nefor"
    (share/"nefor/plugins").install Dir["share/nefor/plugins/*"]
    (share/"nefor/starter").install Dir["share/nefor/starter/*"]
    share.install "share/nefor/LICENSE", "share/nefor/README.md", "share/nefor/CHANGELOG.md"
  end

  def caveats
    <<~EOS
      To finish setup, scaffold a config:
        mkdir -p ~/.config/nefor
        cp #{share}/nefor/starter/*.lua ~/.config/nefor/
      Then run: nefor
    EOS
  end

  test do
    assert_match "nefor", shell_output("#{bin}/nefor --help 2>&1", 0)
  end
end
