class Da < Formula
  desc "yes. — classify a bash command as approve/defer/deny under explicit policies"
  homepage "https://github.com/amenocturne/da"
  url "https://github.com/amenocturne/da/releases/download/v0.0.0/da-aarch64-apple-darwin.tar.gz"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  version "0.0.0"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "bin/da"
    (share/"da").install Dir["share/da/*"]
  end

  test do
    assert_match "da", shell_output("#{bin}/da --version 2>&1", 0)
  end
end
