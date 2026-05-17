class Nefor < Formula
  desc "Agent harness substrate — NCP-speaking engine with Lua composition"
  homepage "https://github.com/amenocturne/nefor"
  version "0.1.6"
  license "MIT"

  on_macos do
    on_arm do
      # slot: MACOS_ARM64
      url "https://github.com/amenocturne/nefor/releases/download/v0.1.6/nefor-aarch64-apple-darwin.tar.gz"
      sha256 "4bc35f0b09773629973125c250d59f95abfbe089206ab61836068a848b1483b8"
    end
  end

  on_linux do
    on_intel do
      # slot: LINUX_X86_64
      url "https://github.com/amenocturne/nefor/releases/download/v0.1.6/nefor-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8d6b18b2eeacbca534db85091f6d3ccb9fcc91af62e42738c654a948bd2b5ae1"
    end
    on_arm do
      # slot: LINUX_ARM64
      url "https://github.com/amenocturne/nefor/releases/download/v0.1.6/nefor-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d996da9bf3b2352e366d7ecba16e869843080ddc82a9a5c8d4de85efb1d377ed"
    end
  end

  # `brew install --HEAD amenocturne/tap/nefor` builds the latest main
  # commit from source. Mirrors `just install-nefor source` semantics.
  head do
    url "https://github.com/amenocturne/nefor.git", branch: "main"
    depends_on "rust" => :build
  end

  def install
    if build.head?
      # HEAD path: cargo build the workspace, then install binaries +
      # starter into Homebrew's prefix. Matches the tarball layout so
      # the engine resolver finds plugins via exe_relative_share_plugins.
      system "cargo", "build", "--release", "--workspace", "--locked"
      bin.install "target/release/nefor"
      %w[basic-tools generic-provider generic-tool mock-plugin
         nefor-combinators nefor-tui openai-provider
         reasoner-graph tool-gate].each do |p|
        (share/"nefor/plugins").install "target/release/#{p}"
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
    assert_match "nefor", shell_output("#{bin}/nefor --version 2>&1", 0)
  end
end
