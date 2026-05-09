class Da < Formula
  desc "yes. — classify a bash command as approve/defer/deny under explicit policies"
  homepage "https://github.com/amenocturne/da"
  url "https://github.com/amenocturne/da/releases/download/v0.1.0/da-aarch64-apple-darwin.tar.gz"
  sha256 "bd0fac590dea7dcbc0328e3832cc0949188cc7d69158fed31bb301956da1bea0"
  version "0.1.0"
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
