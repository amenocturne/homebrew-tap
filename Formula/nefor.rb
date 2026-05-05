class Nefor < Formula
  desc "Agent harness substrate — NCP-speaking engine with Lua composition"
  homepage "https://github.com/amenocturne/nefor"
  url "https://github.com/amenocturne/nefor/releases/download/v0.1.3/nefor-aarch64-apple-darwin.tar.gz"
  sha256 "876cac5c34e84280e3a81d3603670ebe886eb18ae4a7add06149d8c63a0c1702"
  version "0.1.3"
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
