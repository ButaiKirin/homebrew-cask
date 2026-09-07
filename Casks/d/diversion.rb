cask "diversion" do
  arch arm: "arm64", intel: "amd64"

  version "1.6.15"
  sha256 arm:   "e10c2467c6da4220199020956ad58597745937349639ff74c9156a84376138b7",
         intel: "65410945112cfb9071f716a27ed974caf81eeaa8a7e8c6119dba5ae4d8c3278c"

  url "https://get.diversion.dev/update/dv/v#{version}/darwin-#{arch}.gz"
  name "Diversion CLI"
  desc "Cloud-native version control CLI and agent"
  homepage "https://www.diversion.dev/"

  livecheck do
    url "https://get.diversion.dev/update/dv/darwin-arm64.json"
    strategy :json do |json|
      json["Version"]&.sub(/^v/, "")
    end
  end

  depends_on macos: :big_sur

  binary "darwin-#{arch}", target: "dv"

  uninstall launchctl: "diversion.dv.agent"

  zap trash: [
    "~/.diversion",
    "~/Library/Caches/diversion",
    "~/Library/LaunchAgents/diversion.dv.agent.plist",
  ]
end
