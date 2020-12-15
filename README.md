# lazyautomation
These are the default programs and configurations that I desire for Windows, MacOS, and GNU/Linux systems.
This readme will provide my defaults, while the rest of the repo config files may be dropped to their respective locations.  There is some education here on sane defaults and backup for those interested.

## Linux Distros of Choice:
1. Pop_OS!
* Pros: As of release 20.10, it just works and has everything I need to get going right away.  system76-power is the only non-trivial working solution for Microsoft Windows level power management on my Gigabyte Aero 15x.  Out of the box Optimus support, dev tools, non-free repos, and minimal programs installed.
* Cons: Wayland works very poorly
2. Fedora
* Pros: Mostly just works and cutting edge.  The COPR repos for system76-power and kernel-longterm-5.4 are crucial.  This distro is closest to what I believe Linux on the desktop should be - semi-rolling like Windows, MacOS, Android, iOS.
* Cons: DNF bash completion has always been abysmal.  Kernel updates are unpreditable - NVME and Laptop suspend break frequently on my Gigabyte Aero 15x.  Surprisingly, I've never had any issues using NVIDIA with Fedora.
3. Debian
* Pros: Great performance and stability.  No surprises, ever.
* Cons: Very bad defaults for a desktop or laptop: fstrim, tmpfs, swappiness, systemd timeouts, are not enabled properly.  With older software, bugs may exist for the lifetime of the entire release - and this can't be remedied with flatpak and backports if the issue is desktop specific.

#### For GNU/Linux
* Native package manager
* Shell scripting

#### For Windows
* Chocolatey package manager
* Powershell scripting

#### For MacOS
* Homebrew and Homebrew Cask
* Shell scripting

## Preferred Backup Solution:
Copy the disk and compress (You can easily shrink 512GiB+ to around 5GiB give or take a few GiBs).  PC will get hot and CPU may throttle.  This is the best, simple, and most pure UNIX way to go about backing up quickly and reliably while saving space.  This will reliably clone ANYTHING that's on a disk including Linux, MacOS, and Windows.  I'd recommend trimming on an SSD and file system checking via fsck -f before copying, as well as when restoring from backup.
```bash
# dd if=/dev/nvme0n1 bs=1M | pigz -c > /path/to/nvme0n1.img.gz
```
To restore:
```bash
# pigz -dc /path/to/nvme0n1.img.gz | dd of=/dev/nvme0n1 bs=1M
```
Fsck the restored partitions for sanity:
```bash
# fsck -f /dev/nvme0n1p1
# fsck -f /dev/nvme0n1p2
# fsck -f /dev/nvme0n1pX
```
When booted into the restored system:
```bash
# fstrim -av
```

## System tweaks (Linux):
1. /etc/systemd/systemd/system.conf
* DefaultTimeoutStartSec=10s
* DefaultTimeoutStopSec=10s
2. /etc/systemd/journald.conf
* ForwardToWall=no
3. /etc/sysctl.conf
* vm.swappiness=1
* kernel.printk=0 0 0 0
* kernel.sysrq=1

## System tweaks (Windows):
1. gpedit
* Allow Telemetry - Security
2. regedit
* HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation - RealTimeIsUniversal - QWORD - 1

## Visudo (Linux)
Defaults        insults
summonholmes 10x-Orange-G= NOPASSWD: /sbin/poweroff,/sbin/powertop,/sbin/reboot,/bin/apt update,/bin/apt dist-upgrade,/bin/apt autoremove,/bin/systemctl suspend,/bin/apt-get update,/bin/apt-get dist-upgrade -y,/bin/apt-get autoremove -y

## EFIStub & Improved Boot Times
To bypass grub and UEFI bios, use EFISTUB.  On an optimus laptop, you can toggle between Intel and NVIDIA by blacklisting NVIDIA modules, shown below:
```bash
# # Disable NVIDIA graphics
# efibootmgr -c -d /dev/nvme0n1 -p 1 --label "Fedora EFI Intel" --loader '\efi\efistub\bootx64.efi' -u "root=UUID=8a25e69b-f3e4-49e6-ba02-32be826fdd3c ro quiet plymouth.enable=0 loglevel=0 vga=current udev.log_priority=0 rd.udev.log_priority=0 rd.systemd.show_status=false systemd.show_status=false vt.global_cursor_default=0 i915.fastboot=1 rd.driver.blacklist=nouveau module_blacklist=nouveau,nvidia,nvidia_uvm,nvidia_modeset,nvidia_drm LANG=en_US.UTF-8 initrd=\\EFI\\efistub\\initramfs.img"
```
* vmlinuz.x86_64 is copied to /boot/efi/EFI/efistub/bootx64.efi
* initramfs is copied to /boot/efi/EFI/efistub/initramfs.img

## Packages to install:

### Pop!_OS Install Commands
```bash
$ sudo apt remove libreoffice-* -y
$ sudo apt remove geary totem -y
$ sudo apt install celluloid code evolution-ews ffmpegthumbnailer fonts-firacode gir1.2-gmenu-3.0 gnome-tweaks graphicsmagick-imagemagick-compat gstreamer1.0-libav gstreamer1.0-plugins-bad gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly htop inxi neofetch p7zip python3-pip rhythmbox syncthing unrar vainfo vdpauinfo zsh -y
$ sudo apt install ./bleachbit*
$ sudo apt install ./protonmail-bridge*
```

### Flatpak Install Commands
```bash
flatpak install com.discordapp.Discord org.keepassxc.KeePassXC org.libreoffice.LibreOffice com.slack.Slack com.transmissionbt.Transmission -y
```

## Conda packages to install:
```bash
$ conda install colorama flake8 jupyter keyring openpyxl pandas plotly psycopg2 scikit-learn scipy seaborn sqlalchemy termcolor virtualenv xlrd yapf -y && conda update --all -y && conda clean --all -y
```

## Windows Task Scheduler & Chocolatey
Auto-update all non-Windows apps when logged in with a ps1 script.
Task Scheduler will read it with these settings:
1. Name + Description: Upgrade All
2. Run whether user is logged in or not
3. Run with highest priveleges
4. Triggers: At log on - Specific User - Enabled
5. Actions: Start a program
* Program/script: C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
* Add Arguments: -ExecutionPolicy Bypass C:\Users\summonholmes\Scripts\update.ps1
6. Disable AC power check

## Apps installed via Chocolatey:
```
λ choco install 7zip adb bleachbit Cmder discord epicgameslauncher ffmpeg FiraCode Firefox foobar2000 git keepassxc miniconda3 mpc-hc msvisualcplusplus2013-redist nomacs notepadplusplus office365business open-shell pia qbittorrent retroarch simplewall slack steam sumatrapdf synctrayzor ungoogled-chromium vscode youtube-dl -y
```

## Apps installed via Brew Cask:
```
$ brew cask install android-file-transfer android-platform-tools balenaetcher discord firefox font-fira-code iina keepassxc keka osxfuse pdftotext pgadmin4 slack syncthing visual-studio-code webex-meetings zoomus -y
```

## Apps installed via Homebrew:
```
$ brew install ext4fuse htop imagemagick neofetch postgresql youtube-dl -y
```

### Add the shell script to automator to auto-update all packages
* Utilities > Run Shell Script > /bin/sh
- Add contents of update_all.sh in the MacOS folder
