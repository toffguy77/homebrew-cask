cask "wireshark" do
  version "3.4.0"
  sha256 "b0a09d499de618de8f17a0456047dd3839b78c3a57e64b6caf5a55ae5c398d8a"

  url "https://2.na.dl.wireshark.org/osx/Wireshark%20#{version}%20Intel%2064.dmg"
  appcast "https://www.wireshark.org/update/0/Wireshark/0.0.0/macOS/x86-64/en-US/stable.xml"
  name "Wireshark"
  desc "Network protocol analyzer"
  homepage "https://www.wireshark.org/"

  auto_updates true
  conflicts_with cask: "wireshark-chmodbpf"
  depends_on macos: ">= :sierra"

  app "Wireshark.app"
  pkg "Install ChmodBPF.pkg"
  pkg "Add Wireshark to the system path.pkg"

  uninstall_preflight do
    system_command "/usr/sbin/installer",
                   args: [
                     "-pkg", "#{staged_path}/Uninstall ChmodBPF.pkg",
                     "-target", "/"
                   ],
                   sudo: true
    system_command "/usr/sbin/installer",
                   args: [
                     "-pkg", "#{staged_path}/Remove Wireshark from the system path.pkg",
                     "-target", "/"
                   ],
                   sudo: true
  end

  uninstall pkgutil: "org.wireshark.*"

  zap trash: [
    "~/Library/Caches/org.wireshark.Wireshark",
    "~/Library/Cookies/org.wireshark.Wireshark.binarycookies",
    "~/Library/Preferences/org.wireshark.Wireshark.plist",
    "~/Library/Saved Application State/org.wireshark.Wireshark.savedState",
    "~/.config/wireshark",
  ]
end
