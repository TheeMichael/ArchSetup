https://www.youtube.com/watch?v=rUEnS1zj1DM
https://www.youtube.com/watch?v=CwLCcRY-xac


Get Arch iso
https://archlinux.org/download/

Check the sha256 sum
    sha256sum ./isofile

Sync Clock
    timedatectl set-ntp true

Partition drives

    lsblk # shows disks
    cfdisk /dev/driveletter

Set lable type:
    use gpt

Make boot partition 128M primary, set as bootable (Might want something like 256 or 512 because gnome screams at you)
Make other partitions, basically just 1 more that has all the rest to be simple, primary
Both Id types are 83 Linux
Write the changes in cfdisk then quit

Now need to set partition as ext4 for both partitions
    mkfs.ext4 /dev/drivepartition1
    mkfs.ext4 /dev/drivepartition2

Mount root folder to /mnt
    mount /dev/drivepartition2 /mnt

Make a folder /mnt/boot to mount your boot partition to
    mkdir /mnt/boot
    mount /dev/drivepartition1 /mnt/boot

Use pacstrap to install arch linux for you lol
    pacstrap /mnt base base-devel linux linux-firmware vim nano

Make an fstab file. This contains all the linux will want to load.
The -U will set the UUIDs as the identifier instead of sda1 sda2 etc. Much better practice to do so. Writes into ouput file /mnt/etc/fstabS
    genfstab -U /mnt >> /mnt/etc/fstab

Now change root into arch installation. Changes root directory to /mnt and then runs bash shell
    arch-chroot /mnt /bin/bash

Install a network manager and grub
    pacman -S networkmanager grub

Use systemd to start NetworkManager upon booting
    systemctl enable NetworkManager

Now configure grub to know what to actually boot
    grub-install /dev/drive # should be something like /dev/sda without the partition, just the actual drive

    #may need to do this if on VM
    # grub-install /dev/drive --force

Generare grub config files
    grub-mkconfig -o /boot/grub/grub.cfg

Now set password for a root user
    passwd

Select language locale
    nano /etc/locale.gen

    uncomment   en_US.UTF-8 UTF-8
                en_US ISO-8859-1
Now generate it with
    locale-gen


Set the hostname
    nano /etc/hostname
Write whatever hostname and exit


Set timezone
ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime

exit chroot
    exit

unmount root and boot
    umount -R /mnt
    reboot

Generate locale.conf
    Do this
        localectl set-locale LANG=en_US.UTF-8
    OR this
        echo "LANG=en_US.UTF-8" > /etc/locale.conf

Add user
    useradd -m virt
    passwd virt

Give user groups
    usermod -aG wheel,audio,video,optical,storage virt

Install sudo
    pacman -S sudo git

Add user to sudoers
    EDITOR=nano visudo
Uncomment "# %wheel ALL=(ALL:ALL) ALL"


Enable multilib in:
/etc/pacman.conf

    [multilib]
    Include = /etc/pacman.d/mirrorlist


END BASIC INSTALL

############################
run script:
Login in as user
    cd ~
    git clone https://www.github.com/TheeMichael/ArchSetup
    cd ArchSetup
    bash ./setup.sh

In script use sequence:
    Enter 
    2 
    2 
    1 
    1
############################


Next run 
    extensions.sh


Set Background
Set Autoscroll on Firefox


Possible titlebar fix
https://askubuntu.com/questions/1435776/how-to-have-light-theme-with-dark-window-titlebar-on-ubuntu-22-04


Disable smooth scroll
gsettings set org.gnome.desktop.peripherals.mouse natural-scroll false


Workspaces on all monitors
gsettings set org.gnome.mutter workspaces-only-on-primary false


getting man pages
    sudo pacman -S man-pages man-db
    mandb
    man pacman


May need to install package for viewing ntfs filesystems
It worked without it install, but I guess pacman removed it at some point
    pacman -S ntfs-3g