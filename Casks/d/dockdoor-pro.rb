cask "dockdoor-pro" do
  version "1.3.4"
  sha256 "bba6d0eb72bea19d776e8a0ef943e2affe6201e0d375c6b5fad33a19cf421f81"

  url "https://downloads.dockdoor.net/v/#{version}/DockDoorPro.dmg"
  name "DockDoor Pro"
  desc "Dock replacement with widgets, profiles and window previews"
  homepage "https://pro.dockdoor.net/"

  livecheck do
    url "https://pro.dockdoor.net/appcast.xml"
    strategy :sparkle
  end

  auto_updates true
  depends_on macos: :sonoma

  app "DockDoor Pro.app"

  uninstall quit: "com.ejbills.DockDoorPro"

  zap trash: [
    "~/Library/Application Support/DockDoorPro",
    "~/Library/Caches/com.ejbills.DockDoorPro",
    "~/Library/HTTPStorages/com.ejbills.DockDoorPro",
    "~/Library/Preferences/com.ejbills.DockDoorPro.plist",
  ]
end
