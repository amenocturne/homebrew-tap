class Nefor < Formula
  desc "Agentic runtime with Lua-composed tools, providers, and workflows"
  homepage "https://github.com/amenocturne/nefor"
  version "0.7.3"
  license "MIT"

  # `brew install --HEAD amenocturne/tap/nefor` builds the latest main
  # commit from source. Mirrors `just install-nefor source` semantics.
  head do
    url "https://github.com/amenocturne/nefor.git", branch: "main"
    depends_on "rust" => :build
  end

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
    if build.head?
      system "cargo", "install", *std_cargo_args(path: "engine")
      plugin_root = buildpath/"homebrew-plugin-root"
      %w[basic-tools generic-provider generic-tool mock-plugin
         nefor-combinators nefor-tui openai-provider
         reasoner-graph tool-gate].each do |p|
        system "cargo", "install", *std_cargo_args(root: plugin_root, path: "plugins/#{p}")
        (share/"nefor/plugins").install plugin_root/"bin/#{p}"
      end
      (share/"nefor/starter").install Dir["starter/*"]
      share.install "LICENSE", "README.md"
    else
      # Tarball path: assets are pre-laid-out exactly as we want.
      bin.install "bin/nefor"
      (share/"nefor/plugins").install Dir["share/nefor/plugins/*"]
      (share/"nefor/starter").install Dir["share/nefor/starter/*"]
      share.install "share/nefor/LICENSE", "share/nefor/README.md"
      share.install "share/nefor/CHANGELOG.md" if File.exist?("share/nefor/CHANGELOG.md")
    end
  end

  def caveats
    <<~EOS
      To finish setup, scaffold a config:
        mkdir -p ~/.config/nefor
        cp -R #{share}/nefor/starter/. ~/.config/nefor/
      Then run: nefor
    EOS
  end

  test do
    assert_match "nefor", shell_output("#{bin}/nefor --version 2>&1")
  end
end
