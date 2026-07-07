class NeforAT040 < Formula
  desc "Agentic runtime with Lua-composed tools, providers, and workflows"
  homepage "https://github.com/amenocturne/nefor"
  version "0.4.0"
  license "MIT"

  keg_only :versioned_formula


  on_macos do
    on_arm do
      # slot: MACOS_ARM64
      url "https://github.com/amenocturne/nefor/releases/download/v0.4.0/nefor-aarch64-apple-darwin.tar.gz"
      sha256 "5e6922bead8ed39424c49e510a36a6bb88e90e4eeaeba68143c3b51522dc9cfc"
    end
  end

  on_linux do
    on_intel do
      # slot: LINUX_X86_64
      url "https://github.com/amenocturne/nefor/releases/download/v0.4.0/nefor-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c2bed9404aec3114ec6a80a00a2e9fb32c955d2199c973b73b15b3ff627c3369"
    end
    on_arm do
      # slot: LINUX_ARM64
      url "https://github.com/amenocturne/nefor/releases/download/v0.4.0/nefor-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8f16a4b35e551891714c44631f2ee0ec51e57b8c064292a12e713bb7cfd08e95"
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
