cask "skills-manager" do
  arch arm: "aarch64", intel: "x64"

  version "1.37.1"
  sha256 arm:   "c8079704b009c18ae6e3500afe83c31d44b8347c61d06d5b52d3a0d60226f9fb",
         intel: "167f91002022bdc2cb73869c7cdaed3b2a4c8e42d5ee15f9768100515ee7aae6"

  url "https://github.com/xingkongliang/skills-manager/releases/download/v#{version}/skills-manager_#{version}_#{arch}.dmg"
  name "Skills Manager"
  desc "Manage, sync, and organise AI agent skills across coding tools"
  homepage "https://github.com/xingkongliang/skills-manager"

  auto_updates true
  depends_on :macos

  app "skills-manager.app"

  zap trash: [
    "~/.skills-manager",
    "~/Library/Caches/com.agentskills.desktop",
    "~/Library/Logs/com.agentskills.desktop",
    "~/Library/Preferences/com.agentskills.desktop.plist",
    "~/Library/WebKit/com.agentskills.desktop",
  ]
end
