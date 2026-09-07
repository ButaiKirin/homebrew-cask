cask "mixxx@snapshot" do
  arch arm: "arm", intel: "intel"

  sha256 arm:   "1a20b01d655acc358c457f56a9e7f5eef8c1374ec0d35259d726952772b445ad",
         intel: "3884d507c5ff04a4f08558deb4efca35a8a57b0f54b8811be2aeedd87657da26"

  on_arm do
    version "2.7-alpha-382-g759d616b76"
  end
  on_intel do
    version "2.7-alpha-382-g759d616b76"
  end

  url "https://downloads.mixxx.org/snapshots/main/mixxx-#{version}-macos#{arch}.dmg"
  name "Mixxx"
  desc "Open-source DJ software"
  homepage "https://www.mixxx.org/"

  livecheck do
    url "https://downloads.mixxx.org/snapshots/main/manifest.json"
    strategy :json do |json|
      json.dig("macos-macos#{arch}", "git_describe")
    end
  end

  conflicts_with cask: "mixxx"
  depends_on macos: :big_sur

  app "Mixxx.app"

  zap trash: [
    "~/Library/Application Scripts/org.mixxx.mixxx",
    "~/Library/Containers/org.mixxx.mixxx",
    "~/Music/Mixxx",
  ]
end
