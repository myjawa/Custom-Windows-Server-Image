#!/bin/bash

# Function to display menu and get user choice
display_menu() {
    echo "Please select the Windows Server version:"
    echo "1. Windows Server 2016"
    echo "2. Windows Server 2019"
    echo "3. Windows Server 11"
    read -p "Enter your choice: " choice
}

# Update package repositories and upgrade existing packages
apt-get update && apt-get upgrade -y

# Install QEMU and its utilities
apt-get install qemu -y
apt install qemu-utils -y
apt install qemu-system-x86-xen -y
apt install qemu-system-x86 -y
apt install qemu-kvm -y

echo "QEMU installation completed successfully."

# Get user choice
display_menu

case $choice in
    1)
        # Windows Server 2016
        img_file="windows2016.img"
        iso_link="https://go.microsoft.com/fwlink/p/?LinkID=2195174&clcid=0x409&culture=en-us&country=US"
        iso_file="windows2016.iso"
        ;;
    2)
        # Windows Server 10
        img_file="windows10.img"
        iso_link="https://software.download.prss.microsoft.com/dbazure/Win10_22H2_English_x64v1.iso?t=a858b7e4-08fd-496c-b6c6-d277bbc3850b&P1=1726375186&P2=601&P3=2&P4=yyKH5xXt0mx%2b04hZKeLukwb1SCnWBg9dq3kOosMq3YnARr7hdGWZVWIZCA%2bRHPMFMUIqD9lw226ncd%2f%2b3zGMKcbdx7zi%2buroJuVYbsOgqmQf5zFoT6y%2fidGHjxi8NvRj42blVM8Dj1fSU31DTayheMw%2fiCJ9YLPFSu9DcA8ut0q4XNMLvDlG1%2fkgAQXTmCxT%2f2xexhgatBHOLUpuvzAqFWOhVnd2jHP4fITSsSdob97YX0GLMXd%2bfiJPxq3nqOhnISKQT0%2f7X4wVb4UEUGFKFffY9xHlMLaNcmIK726vOceNTRiNWsk%2fetgDbNU4hFliQI2ng0foMAQ42uHwPK7Suw%3d%3d"
        iso_file="Win10_22H2_English_x64v1.iso"
        ;;
    3)
        # Windows Server 11
        img_file="windows11.img"
        iso_link="https://software.download.prss.microsoft.com/dbazure/Win11_23H2_English_x64v2.iso?t=66403d5d-38b9-4344-b596-efeb1df7c859&P1=1726371480&P2=601&P3=2&P4=ZQTi%2bxM9n%2ffxFsWOqd%2b8YSaSn6XxyFmFiIqNRzioezu5719gnmCThqXmOncn0lr2VyshjvRdRhCxtX10sQHspPcBoTALrU9O11bSgahhXdAOoq2tEFJNcqoWqfdnJGoEh%2fMvBIZ53CC9VGnukvy5WOLd3GoOkEe4UcAnaZK34%2fsNVnvX36%2bz1Po0kYd05J0kUPoJfo1wVVcTH298Huhj3VGxN8MAY8kq%2bBrgyZe2PNtVblc4ly7xr5DvBgVYqlm4OxqJb21LN0z1lsxeNDZv23GZ2TtK2NZystHBEItkCSuBYieG6yvZ7MEMX0y6yL7TGcQldOm2He%2fLTYfbc1HMWQ%3d%3d"
        iso_file="Win11_23H2_English_x64v2.iso"
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

echo "Selected Windows Server version: $img_file"

# Create a raw image file with the chosen name
qemu-img create -f raw "$img_file" 50G

echo "Image file $img_file created successfully."

# Download Virtio driver ISO
wget -O virtio-win.iso 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.215-1/virtio-win-0.1.215.iso'

echo "Virtio driver ISO downloaded successfully."

# Download Windows ISO with the chosen name
wget -O "$iso_file" "$iso_link"

echo "Windows ISO downloaded successfully."
