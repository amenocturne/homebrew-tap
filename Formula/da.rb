class Da < Formula
  desc "yes. — classify a bash command as approve/defer/deny under explicit policies"
  homepage "https://github.com/amenocturne/da"
  url "https://github.com/amenocturne/da/releases/download/v0.2.1/da-aarch64-apple-darwin.tar.gz"
  sha256 "2ab4714780f7e6509e30137b7e1434c8d534d035ddfddbc5a68278a023b281cf"
  version "0.2.1"
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
