cask "micmixer" do
  version "1.0.0"
  sha256 "b2b2005227c2abaa1c407c82a2304a05efa061a91c6709199413127be32eab79"

  url "https://github.com/amenocturne/mic-mixer/releases/download/v#{version}/MicMixer.app.zip"
  name "MicMixer"
  desc "Menu bar app that mixes system audio + microphone into a virtual device"
  homepage "https://github.com/amenocturne/mic-mixer"

  depends_on macos: ">= :sequoia"

  app "MicMixer.app"

  zap trash: [
    "~/Library/Preferences/com.amenocturne.micmixer.plist",
  ]
end
