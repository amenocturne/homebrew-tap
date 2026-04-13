cask "micmixer" do
  version "1.0.0"
  sha256 "3015b2fe70f3ce9f1df08d22dcb23815e7e31cd6fd7eb22ad720ed7b57474579"

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
