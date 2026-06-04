class NeforAT030 < Formula
  desc "Agentic runtime with Lua-composed tools, providers, and workflows"
  homepage "https://github.com/amenocturne/nefor"
  version "0.3.0"
  license "MIT"

  keg_only :versioned_formula

  on_macos do
    on_arm do
      # slot: MACOS_ARM64
      url "https://github.com/amenocturne/nefor/releases/download/v0.3.0/nefor-aarch64-apple-darwin.tar.gz"
      sha256 "2c028d5445150e9096d6a470559686afceb8a57cebfbc18e12e4ece87cd4a6bc"
    end
  end

  on_linux do
    on_intel do
      # slot: LINUX_X86_64
      url "https://github.com/amenocturne/nefor/releases/download/v0.3.0/nefor-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e27f780df4c75bc7143564b87045c9039b6c365ccd8d396a202d1924030db3b8"
    end
    on_arm do
      # slot: LINUX_ARM64
      url "https://github.com/amenocturne/nefor/releases/download/v0.3.0/nefor-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c8008b85d1d689324159623cb554525dcbbf2690fa6a958b3e08efd6a78b499b"
    end
  end

  def install
    bin.install "bin/nefor"
    (share/"nefor/plugins").install Dir["share/nefor/plugins/*"]
    (share/"nefor/starter").install Dir["share/nefor/starter/*"]
    share.install "share/nefor/LICENSE", "share/nefor/README.md"
    share.install "share/nefor/CHANGELOG.md" if File.exist?("share/nefor/CHANGELOG.md")
  end

  def caveats
    <<~EOS
      This is a keg-only versioned formula. To use it without linking:
        #{opt_bin}/nefor

      To scaffold a config for this version:
        mkdir -p ~/.config/nefor
        cp -R #{share}/nefor/starter/. ~/.config/nefor/
    EOS
  end

  test do
    assert_match "nefor", shell_output("#{bin}/nefor --version 2>&1")
  end
end
