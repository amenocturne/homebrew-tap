class Nefor < Formula
  desc "Agentic runtime with Lua-composed tools, providers, and workflows"
  homepage "https://github.com/amenocturne/nefor"
  version "0.7.2"
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
