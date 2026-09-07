cask "open-science" do
  arch arm: "arm64", intel: "x64"

  version "0.26.0"
  sha256 arm:   "d6d38790a5a0e94b1406914cea2546775d1ebfde42042fd0cff5f699955af8d8",
         intel: "e8cd62b5b58cfc2a98aa1cd94bc5f4b064bfd1e15a5f4864ceb0acd283b16c27"

  url "https://github.com/aipoch/open-science/releases/download/v#{version}/aipoch-open-science-#{version}-mac-#{arch}.dmg"
  name "Open Science"
  desc "AI research workbench with scientific agents and notebooks"
  homepage "https://aipoch.com/open-science"

  livecheck do
    url :url
    regex(/^v?(\d+\.\d+\.\d+)$/i)
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :monterey

  app "Open Science.app"

  uninstall quit: "com.aipoch.open-science"
end
