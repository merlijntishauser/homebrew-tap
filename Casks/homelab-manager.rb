# Written by app/tools/make_cask.py in merlijntishauser/homelab-ops for
# v0.2.2. Do not edit by hand: cut a release there and run it again.
cask "homelab-manager" do
  version "0.2.2"
  sha256 "044db04691a6d355da8a8e01e1f0e31b5d5feaf527d6a69d5863311259efe1ff"

  # The source repo is private: the asset is fetched through the GitHub API
  # with the token Homebrew already knows (HOMEBREW_GITHUB_API_TOKEN, a token
  # with read access to the repo, for example the one `gh auth token` prints).
  url "https://api.github.com/repos/merlijntishauser/homelab-ops/releases/assets/650578921",
      header: [
        "Accept: application/octet-stream",
        "Authorization: Bearer #{ENV.fetch("HOMEBREW_GITHUB_API_TOKEN", "")}",
      ]
  name "Homelab Manager"
  desc "The homelab as a rack: capacity, baseline checklist, confirmed updates and reboots"
  homepage "https://github.com/merlijntishauser/homelab-ops"

  depends_on macos: :sequoia
  depends_on arch: :arm64

  app "Homelab Manager.app"

  zap trash: [
    "~/Library/Preferences/org.gargleblaster.HomelabManager.plist",
    "~/Library/Containers/org.gargleblaster.HomelabManager",
  ]

  caveats <<~EOS
    Set HOMEBREW_GITHUB_API_TOKEN to a GitHub token that can read
    merlijntishauser/homelab-ops before installing; the download goes through the API.
    Developer ID signed and notarized.
  EOS
end
