class NeforAT073 < Formula
  desc "Agentic runtime with Lua-composed tools, providers, and workflows"
  homepage "https://github.com/amenocturne/nefor"
  version "0.7.3"
  license "MIT"

  keg_only :versioned_formula


  on_macos do
    on_arm do
      # slot: MACOS_ARM64
      url "https://github.com/amenocturne/nefor/releases/download/v0.7.3/nefor-aarch64-apple-darwin.tar.gz"
      sha256 "c02ef85b3dfa17f4902c7bcf97524cb485253536ff8439764d9dbdaab1dd2c2f"
    end
  end

  on_linux do
    on_intel do
      # slot: LINUX_X86_64
      url "https://github.com/amenocturne/nefor/releases/download/v0.7.3/nefor-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "69fdb697aeba3152abfafad07627ade5221eb78a4528b2e1edc16254743d5b4b"
    end
    on_arm do
      # slot: LINUX_ARM64
      url "https://github.com/amenocturne/nefor/releases/download/v0.7.3/nefor-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0e0b9e7f0ae6da5f3c6c7f53f5e78f7a0601e2dc9733dcf9cefc8765a7b39924"
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
