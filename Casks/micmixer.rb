cask "micmixer" do
  version "1.0.1"
  sha256 "ca96b7cf341fb5fcc163dc6930b9b56c289cc4503041810681a4c4c2cf7f367d"

  url "https://github.com/amenocturne/mic-mixer/releases/download/v#{version}/MicMixer.app.zip"
  name "MicMixer"
  desc "Menu bar app that mixes system audio + microphone into a virtual device"
  homepage "https://github.com/amenocturne/mic-mixer"

  depends_on macos: ">= :sequoia"

  app "MicMixer.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/MicMixer.app"]
  end

  caveats <<~EOS
    MicMixer requires two macOS permissions on first launch:
      - Screen & System Audio Recording (for capturing app audio)
      - Microphone (for mixing in your mic)
    Grant both when prompted, then click the menu bar icon to get started.
  EOS

  zap trash: [
    "~/Library/Preferences/com.amenocturne.micmixer.plist",
  ]
end
