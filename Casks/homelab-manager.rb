# Written by app/tools/make_cask.py in merlijntishauser/homelab-ops for
# v0.4.1. Do not edit by hand: cut a release there and run it again.
cask "homelab-manager" do
  version "0.4.1"
  sha256 "10b31697e551cbf8405b92932c6a2da118851de17989e46bb7fbc087c8000204"

  # The source repo is private: the asset is fetched through the GitHub API
  # with the token Homebrew already knows (HOMEBREW_GITHUB_API_TOKEN, a token
  # with read access to the repo, for example the one `gh auth token` prints).
  # The API ignores the version parameter; it is there because Homebrew's
  # audit wants a URL with the version in it, or no checksum at all.
  url "https://api.github.com/repos/merlijntishauser/homelab-ops/releases/assets/664855630?version=#{version}",
      header: [
        "Accept: application/octet-stream",
        "Authorization: Bearer #{ENV.fetch("HOMEBREW_GITHUB_API_TOKEN", "")}",
      ]
  name "Homelab Manager"
  desc "Homelab as a rack: capacity, baseline checklist, confirmed updates and reboots"
  homepage "https://github.com/merlijntishauser/homelab-ops"

  depends_on arch: :arm64
  depends_on macos: :sequoia

  app "Homelab Manager.app"

  zap trash: [
    "~/Library/Containers/org.gargleblaster.HomelabManager",
    "~/Library/Preferences/org.gargleblaster.HomelabManager.plist",
  ]

  caveats <<~EOS
    Set HOMEBREW_GITHUB_API_TOKEN to a GitHub token that can read
    merlijntishauser/homelab-ops before installing; the download goes through the API.
    Developer ID signed and notarized.
  EOS
end
