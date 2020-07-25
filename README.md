# config-dump
These are the default programs and their configurations that I desire for Windows, MacOS, and GNU/Linux systems.
This readme will provide my defaults, and the rest of the repo config files may be dropped to their respective locations.  There is some education on sane defaults and backup here for those interested in what I do.

## Linux Distros of Choice:
1. Fedora
* Pros: Best security, cutting edge, DNF dependency resolution, mostly just works
* Cons: DNF bash completion, too hardened sometimes
2. Debian
* Pros: Great performance, secure, stable or rolling
* Cons: Bad defaults and older packages
3. Pop_OS!
* Pros: Just works for most things
* Cons: Wayland sucks here, very non-standard configurations, annoying console messages that can't be fixed even with kernel commandline, sysctl.conf, or systemd configurations 

#### For GNU/Linux
* Native package manager
* Bash scripting

#### For Windows
* Chocolatey package manager
* Powershell scripting

#### For MacOS
* Homebrew and Homebrew Cask
* Bash scripting

## Preferred Backup Solution:
Write the disk and compress (You can easily shrink 512GiB+ to around 5GiB give or take a few GiBs).  PC will get hot and CPU may throttle.  This is the best, simple, and pure UNIX way to go about backing up quickly and reliably while saving space.  It will reliably clone ANYTHING that's on a disk including MacOS and Windows.  I'd recommend trimming on an SSD and file system checking via fsck -f when completed.
```
# dd if=/dev/nvme1n1 bs=1M | pigz -c > /path/to/nvme1n1.img.gz
```
To restore:
```
# pigz -dc /path/to/nvme1n1.img.gz | dd of=/dev/nvme1n1
```
Fsck the restored partitions for sanity:
```
# fsck -f /dev/nvme1n1p1
# fsck -f /dev/nvme1n1p2
# fsck -f /dev/nvme1n1pX
```
When booted into the restored system:
```
# fstrim -av
```

## System tweaks:
1. /etc/systemd/systemd/system.conf
* DefaultTimeoutStartSec=10s
* DefaultTimeoutStopSec=10s
2. /etc/systemd/journald.conf
* ForwardToWall=no
3. /etc/sysctl.conf
* vm.swappiness=1
* kernel.printk=0 0 0 0
* kernel.sysrq=1
4. /etc/tlp.conf
* DISK_DEVICES="nvme0n1 nvme1n1 sda"

## Visudo
Defaults        insults
summonholmes 10x-Orange-G= NOPASSWD: /sbin/poweroff,/sbin/powertop,/sbin/reboot, /bin/dnf update -y, /bin/dnf autoremove -y

## EFIStub & Improved Boot Times
To bypass grub and UEFI bios, EFISTUB does wonders.  On an optimus laptop, you can toggle between Intel and NVIDIA by removing blacklisted NVIDIA modules here:
```
# efibootmgr -c -d /dev/nvme0n1 -p 1 --label "Fedora EFI Intel" --loader '\efi\efistub\bootx64.efi' -u "root=UUID=8a25e69b-f3e4-49e6-ba02-32be826fdd3c ro quiet plymouth.enable=0 loglevel=0 vga=current udev.log_priority=0 rd.udev.log_priority=0 rd.systemd.show_status=false systemd.show_status=false vt.global_cursor_default=0 i915.fastboot=1 rd.driver.blacklist=nouveau module_blacklist=nouveau,nvidia,nvidia_uvm,nvidia_modeset,nvidia_drm drm_kms_helper.edid_firmware=DP-1:edid/3840x2160R.bin LANG=en_US.UTF-8 initrd=\\EFI\\efistub\\initramfs.img"
```
* vmlinuz.x86_64 is copied to /boot/efi/EFI/efistub/bootx64.efi
* initramfs is copied to /boot/efi/EFI/efistub/initramfs.img

## Packages to install:
1. Firefox
2. Evolution/Thunderbird
3. Slack
4. Discord
5. VSCode
6. Miniconda3
7. Dropbox
8. KeepassXC
9. Bleachbit
10. dconf-editor
11. qt5c5
12. kvantum
13. build-essential
14. ufw
15. intel-va-drive, va/vdpau info
16. ungoogled-chromium
17. zsh
18. gstreamer-plugins
19. zip/unzip/unrar/p7zip
20. thermald
21. tuned-utils
22. neofetch
23. celluloid
24. rhythmbox
25. inxi
26. htop
27. nvme-cli
28. loginized
29. glib2-devel
30. gnome-tweaks
31. Libreoffice
32. git
33. pigz

### Fedora Install Command
```
$ sudo dnf install @development-tools @hardware-support NetworkManager-openvpn-gnome adwaita-qt5 akmod-nvidia android-tools bash-completion celluloid chrome-gnome-shell chromium-browser-privacy curl discord eog evince evolution-ews ffmpeg ffmpegthumbnailer file-roller fira-code-fonts firefox fwupd gdm gedit git glib2-devel gnome-calendar gnome-firmware gnome-font-viewer gnome-menus gnome-screenshot gnome-shell gnome-system-monitor gnome-terminal gnome-terminal-nautilus gnome-themes-extra gnome-tweaks gnome-user-share gstreamer1-libav gstreamer1-plugin-openh264 gstreamer1-plugins-bad-free gstreamer1-plugins-bad-free-extras gstreamer1-plugins-bad-freeworld gstreamer1-plugins-good-extras gstreamer1-plugins-ugly gstreamer1-vaapi gvfs-mtp htop https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm intel-media-driver inxi keepassxc kernel-modules-extra libreoffice-calc libreoffice-impress libreoffice-writer libva-intel-driver libva-intel-hybrid-driver libva-utils libva-vdpau-driver libvdpau-va-gl mesa-libd3d mesa-vdpau-drivers microcode_ctl nano nautilus nautilus-dropbox neofetch p7zip qt5ct rhythmbox sqlite terminus-fonts-console thermald transmission-gtk tuned-utils unrar unzip util-linux-user vdpauinfo wget xdg-user-dirs-gtk xdg-utils xorg-x11-drv-intel xorg-x11-drv-libinput xorg-x11-drv-nvidia-cuda youtube-dl zip zsh
```

## Conda packages to install:
1. Scikit-learn
2. Colorama
3. Termcolor
4. Plotly
5. Scipy
6. Seaborn
7. Virtualenv
8. Openpyxl
9. Xlrd
10. Sqlalchemy
11. yapf
12. psycopg2
13. pandas
14. jupyter
15. flake8

## Firefox Settings
1. Restore previous session
2. Play DRM content
3. Search engine to DuckDuckGo
4. Disable Logins and Passwords
5. Disable Data Collection
6. Install Extensions
* HTTPS Everywhere
* UBlock Origin
* Privacy Badger
* Dark Reader
* KeepassXC
* Gnome Extensions
* H264ify
7. about:config (I know I can do a lot more but am lazy and it breaks stuff)
* layers.acceleration.force-enabled True
* gfx.webrender.all True
* media.ffvpx.enabled False
* widget.wayland-dmabuf-vaapi.enabled True

## Windows Task Scheduler & Chocolatey
I auto-update all non-Windows apps when I log in with a ps1 script.
Task Scheduler will read it with these settings:
1. Name + Description: Upgrade All
2. Run whether user is logged in or not
3. Do not store password
4. Run with highest priveleges
5. Triggers: At log on
6. Actions: Start a program
* Program/script: C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
* Add Arguments: -ExecutionPolicy Bypass C:\Users\summonholmes\Scripts\update.ps1
7. Disable AC power check

## Apps installed via Chocolatey:
* discord
* FiraCode
* Firefox
* foobar2000
* git
* keepassxc
* miniconda3
* mpc-hc
* nomacs
* notepadplusplus
* Office365Business
* open-shell
* pia
* qbittorrent
* retroarch
* simplewall
* steam
* sumatrapdf
* vscode
* 7zip
* adb
* cmder

## Apps installed via Brew Cask:
* android-file-transfer
* android-platform-tools
* balenaetcher
* discord
* dropbox
* firefox
* font-fira-code
* iina
* keepassxc
* keka
* microsoft-office
* osxfuse
* pgadmin4
* slack
* visual-studio-code
* zoomus

## Apps installed via Homebrew:
* ext4fuse
* htop
* imagemagick
* neofetch
* postgresql
* youtube-dl

### Add the shell script to automator to auto-update all packages

## Last Steps
1. Add online accounts
2. Log into Slack and Discord
3. Log into Youtube, Messenger, Reddit, Gitlab, and Github
