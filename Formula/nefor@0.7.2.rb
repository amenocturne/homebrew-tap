class NeforAT072 < Formula
  desc "Agentic runtime with Lua-composed tools, providers, and workflows"
  homepage "https://github.com/amenocturne/nefor"
  version "0.7.2"
  license "MIT"

  keg_only :versioned_formula


  on_macos do
    on_arm do
      # slot: MACOS_ARM64
      url "https://github.com/amenocturne/nefor/releases/download/v0.7.2/nefor-aarch64-apple-darwin.tar.gz"
      sha256 "27763ce452be7c19b89df4517a10adebfce777af4acea72e6f7d9ab68c0d587e"
    end
  end

  on_linux do
    on_intel do
      # slot: LINUX_X86_64
      url "https://github.com/amenocturne/nefor/releases/download/v0.7.2/nefor-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7e9c80ba179f7a5fcc47e41a1312bfb9883ce791ab25be4ef9336815f72ca28f"
    end
    on_arm do
      # slot: LINUX_ARM64
      url "https://github.com/amenocturne/nefor/releases/download/v0.7.2/nefor-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "70b5279bff93189d7e674b61abcb189a3fca094043e91d78ba5976f3e0502d9b"
    end
  end

  def install
    bin.install "bin/nefor", "bin/mag"
    (share/"nefor/plugins").install Dir["share/nefor/plugins/*"]
    (share/"nefor/runtime").install Dir["share/nefor/runtime/*"]
    (share/"nefor/examples/nefor-agent").install Dir["share/nefor/examples/nefor-agent/*"]
    share.install "share/nefor/LICENSE", "share/nefor/README.md"
    share.install "share/nefor/CHANGELOG.md" if File.exist?("share/nefor/CHANGELOG.md")
  end

  def caveats
    <<~EOS
      This is a keg-only versioned formula. To use it without linking:
        #{opt_bin}/nefor

      To scaffold a config for this version:
        mkdir -p ~/.config/nefor
        cp -R #{share}/nefor/examples/nefor-agent/. ~/.config/nefor/
    EOS
  end

  test do
    assert_match "nefor", shell_output("#{bin}/nefor --version 2>&1")
  end
end
