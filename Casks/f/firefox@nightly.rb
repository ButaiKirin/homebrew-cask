cask "firefox@nightly" do
  version "157.0a1,2026-09-06-09-30-52"

  language "ca" do
    sha256 "3db433eb41ecb26019424ca5f790ac770ca0b3ea472e3c5c49b5550525bd023b"
    "ca"
  end
  language "cs" do
    sha256 "ff78596dd91dd9ae613f4ffdd8a7149c2ca1590022fa18ba8f75d540bac8c9cd"
    "cs"
  end
  language "de" do
    sha256 "cbc95108244985a4ad0f66b71725a0bf1edbfde7bccdb75618c1be2a24dd92e6"
    "de"
  end
  language "en-CA" do
    sha256 "c4c6ffd62979bb7c2971f7839bd7a97f7d758062b5af59970b42e05a58787dc0"
    "en-CA"
  end
  language "en-GB" do
    sha256 "a9a79e353da881ae5ad0959f7c0f2e3ce825f905a6569ea74f4b1c6e572978f0"
    "en-GB"
  end
  language "en", default: true do
    sha256 "45dacf08004b0c819e418314532c03298211555fb8cfdf60a414aef625b33505"
    "en-US"
  end
  language "es" do
    sha256 "0b603555ef5e1b88a60ead7845bfd132a005c6f6c10e6027e8e88483c87e6473"
    "es-ES"
  end
  language "fr" do
    sha256 "8d65c87fc09644473b7a976d27b4f70b16913e2372ef06ded0ff8b80935842e0"
    "fr"
  end
  language "it" do
    sha256 "ba5112b6e63ed3665c24912e63549216395184f68b55647b0994b2ab2a23c11e"
    "it"
  end
  language "ja" do
    sha256 "21053a84d30d80e08671f59821b62bcee1c149dea6f698ff6190a72a52048b74"
    "ja-JP-mac"
  end
  language "ko" do
    sha256 "6ba51d8c99d21377e80866e781fccbdefe9bb1ab2c51ef7f3bf0833b6618ae92"
    "ko"
  end
  language "nl" do
    sha256 "0421462ad24b2c77464d0151cc58811488bc50cc615670e318d1bd59d017583d"
    "nl"
  end
  language "pt-BR" do
    sha256 "eef21c68bf3a938f62dc5bd5d501225fc208508218b7465ab769ce839f79bd05"
    "pt-BR"
  end
  language "ru" do
    sha256 "cca6e348ad23d877bfc93223224f6b0075d403d0e52abb21192112ac97db163a"
    "ru"
  end
  language "uk" do
    sha256 "19b4680f102dd945577b6867b137f93db012cf233af2c1c13037861dfa081787"
    "uk"
  end
  language "zh-TW" do
    sha256 "00620fc1b1a40dad047a6a9b9d29a30ca5ea16b0dd57e647addb85566a408bde"
    "zh-TW"
  end
  language "zh" do
    sha256 "4c1c0c9e0d3969ea2e6a70788cfe4df9faf75c59d5235c0d3fd470946675b622"
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
