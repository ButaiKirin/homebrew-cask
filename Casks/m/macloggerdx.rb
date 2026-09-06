cask "macloggerdx" do
  version "6.62"
  sha256 "78b19625c3dbf04cf8fc0dace65a1ed6093936525f0904881916e9bdf63171cb"

  url "https://www.dogparksoftware.com/files/MacLoggerDX#{version.no_dots}.dmg"
  name "MacLoggerDX"
  desc "Ham radio logging and rig control software"
  homepage "https://www.dogparksoftware.com/MacLoggerDX.html"

  livecheck do
    url :homepage
    regex(/Download:\s*v?(\d+(?:\.\d+)+)[\s<]/im)
  end

  conflicts_with cask: "macloggerdx@beta"
  depends_on :macos

  app "MacLoggerDX.app"

  uninstall quit: "com.dogparksoftware.MacLoggerDX"

  zap trash: [
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/com.dogparksoftware.macloggerdx.sfl*",
    "~/Library/Caches/com.apple.helpd/Generated/MacLoggerDX Help*",
    "~/Library/Caches/com.dogparksoftware.MacLoggerDX",
    "~/Library/HTTPStorages/com.dogparksoftware.MacLoggerDX",
    "~/Library/Preferences/com.dogparksoftware.MacLoggerDX*.plist",
    "~/Library/WebKit/com.dogparksoftware.MacLoggerDX",
  ]
end
