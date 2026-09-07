cask "firefox@nightly" do
  version "157.0a1,2026-09-07-09-26-17"

  language "ca" do
    sha256 "20501ec1c957f1a64d85381dae5905842985d2ebaf779c101a64a2ff25834565"
    "ca"
  end
  language "cs" do
    sha256 "f9bf6a3935809557818b6c1d24b0bea89777818cd10503ce72c750028d8262e8"
    "cs"
  end
  language "de" do
    sha256 "bd5be14b644264944dc2c98ed9c05fe6d24526fdde34bea27ec58bed27829205"
    "de"
  end
  language "en-CA" do
    sha256 "a807b56cf1fb4f02a620909900fc007ab371b1e797dec6efaf8a3e2d37a8f96f"
    "en-CA"
  end
  language "en-GB" do
    sha256 "467fb58d872fe9866167edc712ed93329f0b7351a79eede08a887097a1bed580"
    "en-GB"
  end
  language "en", default: true do
    sha256 "65497f7b185a1739c4869694a907465c594e08946ee5ac623c90ad232647baf4"
    "en-US"
  end
  language "es" do
    sha256 "a8585313ad3bcc2ba85e5b11e5dce4a26f15497c406b6a718f1ac2135280d6df"
    "es-ES"
  end
  language "fr" do
    sha256 "a08130029d464d8a123c499cd0a4c75bc0096f9a0408ed4279c593ed28c1bf90"
    "fr"
  end
  language "it" do
    sha256 "922a3f8e408e5df4fed96627fa872f80a8597941f4398e64cfc9805c9ec1678e"
    "it"
  end
  language "ja" do
    sha256 "c3ef0790812058325cc18a7759835f4d968e8ade0c89112c5294a54d1ac618d2"
    "ja-JP-mac"
  end
  language "ko" do
    sha256 "90025a68ed1298d2b13fb01b2869864738a4fd110968d0cb383001f7e32aa896"
    "ko"
  end
  language "nl" do
    sha256 "6a20a22153942a837e80ae2e039537f744c795b234730ad6615576745da39bb0"
    "nl"
  end
  language "pt-BR" do
    sha256 "a7ba5b3b7dc0c7b9dd4d96c2c08b88163dceb52044501ec85e60d66b1484dbac"
    "pt-BR"
  end
  language "ru" do
    sha256 "4830d69d219d46857ff5141664473631bed5243bb352d9ac4914b33fdc0e9572"
    "ru"
  end
  language "uk" do
    sha256 "428e2c45c80fa2212cc7ed93797016497f38ffe882abd176f60b8e0cd8ab1851"
    "uk"
  end
  language "zh-TW" do
    sha256 "a0b68168be580cf13763bc211a287f7740f38b1dd765b85ded3d9adf54dfd8ce"
    "zh-TW"
  end
  language "zh" do
    sha256 "9203e04c5825baeff831567ae193ec678deaf3ec90d9f6df4bc0044e28e0d56d"
    "zh-CN"
  end

  url "https://ftp.mozilla.org/pub/firefox/nightly/#{version.csv.second.split("-").first}/#{version.csv.second.split("-").second}/#{version.csv.second}-mozilla-central#{"-l10n" if language != "en-US"}/firefox-#{version.csv.first}.#{language}.mac.dmg"
  name "Mozilla Firefox Nightly"
  desc "Web browser"
  homepage "https://www.mozilla.org/firefox/channel/desktop/#nightly"

  livecheck do
    url "https://product-details.mozilla.org/1.0/firefox_versions.json"
    regex(%r{/(\d+(?:[._-]\d+)+)[^/]*/firefox}i)
    strategy :json do |json, regex|
      version = json["FIREFOX_NIGHTLY"]
      next if version.blank?

      content = Homebrew::Livecheck::Strategy.page_content("https://ftp.mozilla.org/pub/firefox/nightly/latest-mozilla-central/firefox-#{version}.en-US.mac.buildhub.json")
      next if content[:content].blank?

      build_json = Homebrew::Livecheck::Strategy::Json.parse_json(content[:content])
      build = build_json.dig("download", "url")&.[](regex, 1)
      next if build.blank?

      "#{version},#{build}"
    end
  end

  auto_updates true
  depends_on :macos

  app "Firefox Nightly.app"

  zap trash: [
        "/Library/Logs/DiagnosticReports/firefox_*",
        "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/org.mozilla.firefox.sfl*",
        "~/Library/Application Support/CrashReporter/firefox_*",
        "~/Library/Application Support/Firefox",
        "~/Library/Caches/Firefox",
        "~/Library/Caches/Mozilla/updates/Applications/Firefox",
        "~/Library/Caches/org.mozilla.firefox",
        "~/Library/Preferences/org.mozilla.firefox.plist",
        "~/Library/Preferences/org.mozilla.nightly.plist",
        "~/Library/Saved Application State/org.mozilla.firefox.savedState",
        "~/Library/WebKit/org.mozilla.firefox",
      ],
      rmdir: [
        "~/Library/Application Support/Mozilla", #  May also contain non-Firefox data
        "~/Library/Caches/Mozilla",
        "~/Library/Caches/Mozilla/updates",
        "~/Library/Caches/Mozilla/updates/Applications",
      ]
end
