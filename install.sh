#!/bin/bash
#
# README.md
#
# this script will automatically compile xfce4
# warning don't run as sudo ./install.sh
# time and date will set to Indonesia/Jakarta, if you need to use others, you can adjust it after compile
# sudo with asking password will be gone, stop washing your time!
# i don't use vim, vim will be replaced with nano
# include icon, theme and background will be set to Flat ZOMG Dark, Adwaita dark PONIES and Azure Server (default)
# shell default bash will be replaced with zsh
# add extra font PlusJakartaSans
# warning pre configure user if you don't like this, you can configure it after compile
# automatically startx after compile
#
# MIT License
#
# Copyright (c) Azure Linux Desktop Experience.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE
 
cd ~
clear
echo -e "\e[32mwellcome - xfce4 installer! \e[0m"
sleep 2
sudo timedatectl set-timezone Asia/Jakarta
echo "$(whoami) ALL=(ALL:ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$(whoami)
mkdir .config
mkdir pre
sudo mkdir /usr/share/themes
sudo mkdir /usr/share/icons
sudo mkdir /usr/share/backgrounds
sudo mkdir /usr/share/fonts
cd ~/pre
git clone --recurse-submodules https://github.com/cilegordev/Azure-Linux-Desktop-Experience
cd Azure-Linux-Desktop-Experience/azurelinux-repo && sudo rm -rfv /etc/yum.repos.d/* && sudo mv -v *.repo /etc/yum.repos.d && cd ~/pre
cd Azure-Linux-Desktop-Experience/Flat-Adwaita && sudo mv -v Adwaita-dark-PONIES /usr/share/themes && sudo mv -v Flat-ZOMG-dark /usr/share/icons && cd ~/pre
cd Azure-Linux-Desktop-Experience && sudo mv -v img0.png /usr/share/backgrounds/ && cd ~/pre
cd Azure-Linux-Desktop-Experience && cp -v .zshrc ~ && cp -rv xfce4 ~/.config && sudo mv -v zsh* /usr/share/ && cd ~/pre
cd Azure-Linux-Desktop-Experience/neofetch && sudo make install && cd ~/pre
sudo mkdir /usr/share/fonts/PlusJakartaSans && cd Azure-Linux-Desktop-Experience/PlusJakartaSans/fonts/ttf/ && sudo mv -v *.ttf /usr/share/fonts/PlusJakartaSans && cd ~/pre
#dependencies-required!
sudo dnf -y install adwaita* alsa* asciidoc* cairo* cryptsetup-devel dbus* dejavu* desktop-file-utils* device-mapper* drm* doxygen e2fsprogs* flac* *font* fribidi* gdbm* gdk* glibmm* gnome* gnutls* gobject-introspection* gperf* graphene* gsettings* gspell* gst* gtk* harfbuzz* htop hwdata* intltool* iso-codes* itstool* jansson* kernel-drivers* kmod* libICE* libSM* libX* libXtst* libarchive* libatasmart* libyaml* libburn* libbytesize* libcanberra* libcap* libcdio* libdbus* libdvd* libedit* libexif* libgcrypt* libgudev* libinput* libisofs* libjpeg* libltdl* libndp* linux-firmware* libnotify* libnvme* libogg* libpng* libpsl* librs* libsecret* libsndfile* libsoup* libusb* libva* libvorbis* libvpx* libvte* libxcrypt* libxk* lynx lz* mesa* meson* mm-common mobile* nasm* ncurses* ndctl* newt* nspr* nss* nano pam* pcre2* perl-XML-Parser* polkit* ppp* pulseaudio* python3-devel python3-gobject* python3-pexpect python3-psutil sound* upower* vala* vte* vulkan* wayland* xcb* xcursor-themes xdg* xkeyboard* xmlto xorg* zsh --skip-broken && cd ~/pre
sudo ln -sv /usr/bin/gcc /usr/bin/c99
sudo dnf -y remove vim meson
#driver-for-bare-metal!
#your proc/gpu #git clone https://gitlab.freedesktop.org/xorg/driver/xf86-video-... && cd xf86-video-... && ./autogen.sh && ./configure --prefix=/usr --sysconfdir=/etc && sudo make install && cd ~/pre
git clone https://gitlab.freedesktop.org/xorg/driver/xf86-video-fbdev && cd xf86-video-fbdev && ./autogen.sh && ./configure --prefix=/usr --sysconfdir=/etc && sudo make install && cd ~/pre
git clone https://gitlab.freedesktop.org/xorg/driver/xf86-video-vesa && cd xf86-video-vesa && ./autogen.sh && ./configure --prefix=/usr --sysconfdir=/etc && sudo make install && cd ~/pre
#xfce4-component!
git clone https://github.com/mesonbuild/meson && cd meson && sudo chmod +x setup.py && sudo python3 setup.py install && cd ~/pre
cd Azure-Linux-Desktop-Experience/gtk-layer-shell && mkdir build && cd build && meson setup .. --prefix=/usr --sysconfdir=/etc --buildtype=release && sudo ninja install && sudo ldconfig && cd ~/pre
wget https://dri.freedesktop.org/libdrm/libdrm-2.4.124.tar.xz && tar -xvf libdrm-2.4.124.tar.xz && cd libdrm-2.4.124.tar.xz && mkdir build && cd build && meson setup .. --prefix=/usr --sysconfdir=/etc && sudo ninja install && cd ~/pre
git clone https://gitlab.freedesktop.org/wayland/wayland && cd wayland && mkdir build && cd build && meson setup .. --prefix=/usr --sysconfdir=/etc --buildtype=release && sudo ninja install && cd ~/pre
git clone https://gitlab.freedesktop.org/wayland/wayland-protocols && cd wayland-protocols && mkdir build && cd build && meson setup .. --prefix=/usr --sysconfdir=/etc --buildtype=release && sudo ninja install && cd ~/pre
git clone https://gitlab.freedesktop.org/wayland/wayland-utils && cd wayland-utils && mkdir build && cd build && meson setup .. --prefix=/usr --sysconfdir=/etc --buildtype=release && sudo ninja install && cd ~/pre
git clone https://gitlab.freedesktop.org/emersion/libdisplay-info && cd libdisplay-info && mkdir build && cd build && meson setup .. --prefix=/usr --sysconfdir=/etc --buildtype=release && sudo ninja install && cd ~/pre
git clone https://gitlab.freedesktop.org/emersion/libliftoff && cd libliftoff && mkdir build && cd build && meson setup .. --prefix=/usr --sysconfdir=/etc --buildtype=release && sudo ninja install && cd ~/pre
git clone https://github.com/kennylevinsen/seatd && cd seatd && mkdir build && cd build && meson setup .. --prefix=/usr --sysconfdir=/etc --buildtype=release && sudo ninja install && cd ~/pre
git clone https://gitlab.freedesktop.org/wlroots/wlroots && cd wlroots && git checkout 0.18 && mkdir build && cd build && meson setup .. --prefix=/usr --sysconfdir=/etc --buildtype=release && sudo ninja install && cd ~/pre
git clone https://github.com/labwc/labwc && cd labwc && mkdir build && cd build && meson setup .. --prefix=/usr --sysconfdir=/etc --buildtype=release && sudo ninja install && cd ~/pre
wget https://archive.xfce.org/xfce/4.20pre2/src/libxfce4util-4.19.5.tar.bz2 && tar -xf libxfce4util-4.19.5.tar.bz2 && cd libxfce4util-4.19.5 && ./configure --prefix=/usr --sysconfdir=/etc && sudo make install && cd ~/pre
wget https://archive.xfce.org/xfce/4.20pre2/src/xfconf-4.19.5.tar.bz2 && tar -xf xfconf-4.19.5.tar.bz2 && cd xfconf-4.19.5 && ./configure --prefix=/usr --sysconfdir=/etc && sudo make install && cd ~/pre
wget https://archive.xfce.org/xfce/4.20pre2/src/libxfce4ui-4.19.7.tar.bz2 && tar -xf libxfce4ui-4.19.7.tar.bz2 && cd libxfce4ui-4.19.7 && ./configure --prefix=/usr --sysconfdir=/etc && sudo make install && cd ~/pre
wget https://archive.xfce.org/xfce/4.20pre2/src/exo-4.19.2.tar.bz2 && tar -xf exo-4.19.2.tar.bz2 && cd exo-4.19.2 && ./configure --prefix=/usr --sysconfdir=/etc && sudo make install && cd ~/pre
wget https://archive.xfce.org/xfce/4.20pre2/src/garcon-4.19.3.tar.bz2 && tar -xf garcon-4.19.3.tar.bz2 && cd garcon-4.19.3 && ./configure --prefix=/usr --sysconfdir=/etc && sudo make install && cd ~/pre
wget https://download.gnome.org/sources/libwnck/43/libwnck-43.1.tar.xz && tar -xf libwnck-43.1.tar.xz && cd libwnck-43.1 && mkdir build && cd build && meson setup .. --prefix=/usr --sysconfdir=/etc --buildtype=release && sudo ninja install && cd ~/pre
wget https://archive.xfce.org/xfce/4.20pre2/src/xfce4-dev-tools-4.19.4.tar.bz2 && tar -xf xfce4-dev-tools-4.19.4.tar.bz2 && cd xfce4-dev-tools-4.19.4 && ./configure --prefix=/usr --sysconfdir=/etc && sudo make install && cd ~/pre
wget https://archive.xfce.org/xfce/4.20pre2/src/libxfce4windowing-4.19.10.tar.bz2 && tar -xf libxfce4windowing-4.19.10.tar.bz2 && cd libxfce4windowing-4.19.10 && ./configure --prefix=/usr --sysconfdir=/etc && sudo make install && cd ~/pre
wget https://archive.xfce.org/xfce/4.20pre2/src/xfce4-panel-4.19.7.tar.bz2 && tar -xf xfce4-panel-4.19.7.tar.bz2 && cd xfce4-panel-4.19.7 && ./configure --prefix=/usr --sysconfdir=/etc && sudo make install && cd ~/pre 
wget https://archive.xfce.org/src/apps/xfce4-panel-profiles/1.0/xfce4-panel-profiles-1.0.14.tar.bz2 && tar -xf xfce4-panel-profiles-1.0.14.tar.bz2 && cd xfce4-panel-profiles-1.0.14 && ./configure --prefix=/usr && sudo make install && cd ~/pre 
wget https://download.gnome.org/sources/gsettings-desktop-schemas/47/gsettings-desktop-schemas-47.tar.xz && tar -xf gsettings-desktop-schemas-47.tar.xz && cd gsettings-desktop-schemas-47 && sed -i -r 's:"(/system):"/org/gnome\1:g' schemas/*.in && mkdir build && cd build && meson setup .. --prefix=/usr --sysconfdir=/etc --buildtype=release && sudo ninja install && cd ~/pre
wget https://archive.xfce.org/xfce/4.20pre2/src/thunar-4.19.5.tar.bz2 && tar -xf thunar-4.19.5.tar.bz2 && cd thunar-4.19.5 && ./configure --prefix=/usr --sysconfdir=/etc && sudo make install && sudo ldconfig && cd ~/pre
wget https://archive.xfce.org/xfce/4.20pre2/src/thunar-volman-4.19.1.tar.bz2 && tar -xf thunar-volman-4.19.1.tar.bz2 && cd thunar-volman-4.19.1 && ./configure --prefix=/usr --sysconfdir=/etc && sudo make install && cd ~/pre
wget https://archive.xfce.org/xfce/4.20pre2/src/tumbler-4.19.3.tar.bz2 && tar -xf tumbler-4.19.3.tar.bz2 && cd tumbler-4.19.3 && ./configure --prefix=/usr --sysconfdir=/etc && sudo make install && cd ~/pre 
wget https://archive.xfce.org/xfce/4.20pre2/src/xfce4-appfinder-4.19.4.tar.bz2 && tar -xf xfce4-appfinder-4.19.4.tar.bz2 && cd xfce4-appfinder-4.19.4 && ./configure --prefix=/usr --sysconfdir=/etc && sudo make install && cd ~/pre
wget https://archive.xfce.org/xfce/4.20pre2/src/xfce4-power-manager-4.19.5.tar.bz2 && tar -xf xfce4-power-manager-4.19.5.tar.bz2 && cd xfce4-power-manager-4.19.5 && ./configure --prefix=/usr --sysconfdir=/etc && sudo make install && cd ~/pre
wget https://archive.xfce.org/xfce/4.20pre2/src/xfce4-settings-4.19.4.tar.bz2 && tar -xf xfce4-settings-4.19.4.tar.bz2 && cd xfce4-settings-4.19.4 && ./configure --prefix=/usr --sysconfdir=/etc && sudo make install && cd ~/pre
wget https://archive.xfce.org/xfce/4.20pre2/src/xfdesktop-4.19.7.tar.bz2 && tar -xf xfdesktop-4.19.7.tar.bz2 && cd xfdesktop-4.19.7 && ./configure --prefix=/usr --sysconfdir=/etc && sudo make install && cd ~/pre
wget https://archive.xfce.org/xfce/4.20pre2/src/xfwm4-4.19.1.tar.bz2 && tar -xf xfwm4-4.19.1.tar.bz2 && cd xfwm4-4.19.1 && ./configure --prefix=/usr --sysconfdir=/etc && sudo make install && cd ~/pre
wget https://archive.xfce.org/xfce/4.20pre2/src/xfce4-session-4.19.4.tar.bz2 && tar -xf xfce4-session-4.19.4.tar.bz2 && cd xfce4-session-4.19.4 && ./configure --prefix=/usr --sysconfdir=/etc && sudo make install && cd ~/pre
#xfce4-apps!
wget https://gstreamer.freedesktop.org/src/gstreamer/gstreamer-1.24.9.tar.xz && tar -xvf gstreamer-1.24.9.tar.xz && cd gstreamer-1.24.9 && mkdir build && cd build && meson setup .. --prefix=/usr --sysconfdir=/etc --buildtype=release -D gst_debug=false && sudo ninja install && cd ~/pre
wget https://gstreamer.freedesktop.org/src/gst-plugins-base/gst-plugins-base-1.24.9.tar.xz && tar -xvf gst-plugins-base-1.24.9.tar.xz && cd gst-plugins-base-1.24.9 && mkdir build && cd build && meson setup .. --prefix=/usr --sysconfdir=/etc --buildtype=release --wrap-mode=nodownload && sudo ninja install && cd ~/pre
wget https://gstreamer.freedesktop.org/src/gst-plugins-good/gst-plugins-good-1.24.9.tar.xz && tar -xvf gst-plugins-good-1.24.9.tar.xz && cd gst-plugins-good-1.24.9 && mkdir build && cd build && meson setup .. --prefix=/usr --sysconfdir=/etc --buildtype=release && sudo ninja install && cd ~/pre
wget https://gstreamer.freedesktop.org/src/gst-plugins-bad/gst-plugins-bad-1.24.9.tar.xz && tar -xvf gst-plugins-bad-1.24.9.tar.xz && cd gst-plugins-bad-1.24.9 && mkdir build && cd build && meson setup .. --prefix=/usr --sysconfdir=/etc --buildtype=release -D gpl=enabled && sudo ninja install && cd ~/pre
wget https://www.freedesktop.org/software/fontconfig/release/fontconfig-2.15.0.tar.xz && tar -xvf fontconfig-2.15.0.tar.xz && cd fontconfig-2.15.0 && ./configure --prefix=/usr --sysconfdir=/etc && sudo make install && cd ~/pre
wget https://download.gnome.org/sources/pango/1.55/pango-1.55.0.tar.xz && tar -xvf pango-1.55.0.tar.xz && cd pango-1.55.0 && mkdir build && cd build && meson setup .. --prefix=/usr --sysconfdir=/etc --buildtype=release && sudo ninja install && cd ~/pre
wget https://download.gnome.org/sources/gtk/4.17/gtk-4.17.0.tar.xz && tar -xvf gtk-4.17.0.tar.xz && cd gtk-4.17.0 && mkdir build && cd build && meson setup --prefix=/usr --sysconfdir=/etc --buildtype=release -D broadway-backend=true -D introspection=enabled -D vulkan=disabled && sudo ninja install && cd ~/pre
cd Azure-Linux-Desktop-Experience/gtk4-layer-shell && mkdir build && cd build && meson setup .. --prefix=/usr --sysconfdir=/etc --buildtype=release && sudo ninja install && sudo ldconfig && cd ~/pre
wget https://download.gnome.org/sources/gtksourceview/4.8/gtksourceview-4.8.4.tar.xz && tar -xvf gtksourceview-4.8.4.tar.xz && cd gtksourceview-4.8.4 && mkdir build && cd build && meson setup .. --prefix=/usr --sysconfdir=/etc --buildtype=release && sudo ninja install && cd ~/pre
wget https://archive.xfce.org/src/apps/mousepad/0.6/mousepad-0.6.3.tar.bz2 && tar -xvf mousepad-0.6.3.tar.bz2 && cd mousepad-0.6.3 && ./configure --prefix=/usr --sysconfdir=/etc && sudo make install && sudo ldconfig && cd ~/pre
wget https://archive.xfce.org/src/apps/xfce4-terminal/0.9/xfce4-terminal-0.9.1.tar.bz2 && tar -xvf xfce4-terminal-0.9.1.tar.bz2 && cd xfce4-terminal-0.9.1 && ./configure --prefix=/usr --sysconfdir=/etc && sudo make install && sudo ldconfig && cd ~/pre
wget https://archive.xfce.org/src/apps/xfce4-taskmanager/1.5/xfce4-taskmanager-1.5.7.tar.bz2 && tar -xvf xfce4-taskmanager-1.5.7.tar.bz2 && cd xfce4-taskmanager-1.5.7 && ./configure --prefix=/usr --sysconfdir=/etc && sudo make install && sudo ldconfig && cd ~/pre
wget https://archive.xfce.org/src/apps/parole/4.18/parole-4.18.1.tar.bz2 && tar -xvf parole-4.18.1.tar.bz2 && cd parole-4.18.1 && ./configure --prefix=/usr --sysconfdir=/etc && sudo make install && sudo ldconfig && cd ~/pre
wget https://archive.xfce.org/src/apps/xfburn/0.7/xfburn-0.7.2.tar.bz2 && tar -xvf xfburn-0.7.2.tar.bz2 && cd xfburn-0.7.2 && ./configure --prefix=/usr --sysconfdir=/etc && sudo make install && sudo ldconfig && cd ~/pre
wget https://archive.xfce.org/src/apps/ristretto/0.13/ristretto-0.13.2.tar.bz2 && tar -xvf ristretto-0.13.2.tar.bz2 && cd ristretto-0.13.2 && ./configure --prefix=/usr --sysconfdir=/etc && sudo make install && sudo ldconfig && cd ~/pre
cd Azure-Linux-Desktop-Experience/xarchiver && ./configure --prefix=/usr --sysconfdir=/etc && sudo make install && sudo ldconfig && cd ~/pre
wget https://archive.xfce.org/src/apps/xfce4-screenshooter/1.11/xfce4-screenshooter-1.11.1.tar.bz2 && tar -xvf xfce4-screenshooter-1.11.1.tar.bz2 && cd xfce4-screenshooter-1.11.1 && ./configure --prefix=/usr --sysconfdir=/etc && sudo make install && cd ~/pre
wget https://archive.xfce.org/src/apps/xfce4-notifyd/0.9/xfce4-notifyd-0.9.6.tar.bz2 && tar -xvf xfce4-notifyd-0.9.6.tar.bz2 && cd xfce4-notifyd-0.9.6 && ./configure --prefix=/usr --sysconfdir=/etc && sudo make install && cd ~/pre
wget https://archive.xfce.org/src/panel-plugins/xfce4-pulseaudio-plugin/0.4/xfce4-pulseaudio-plugin-0.4.8.tar.bz2 && tar -xvf xfce4-pulseaudio-plugin-0.4.8.tar.bz2 && cd xfce4-pulseaudio-plugin-0.4.8 && ./configure --prefix=/usr && sudo make install && cd ~/pre
wget https://www.freedesktop.org/software/accountsservice/accountsservice-22.08.8.tar.xz && tar -xvf accountsservice-22.08.8.tar.xz && cd accountsservice-22.08.8 && mkdir build && cd build && meson setup .. --prefix=/usr --sysconfdir=/etc --buildtype=release && sudo ninja install && cd ~/pre
wget https://archive.xfce.org/src/panel-plugins/xfce4-whiskermenu-plugin/2.8/xfce4-whiskermenu-plugin-2.8.3.tar.bz2 && tar -xvf xfce4-whiskermenu-plugin-2.8.3.tar.bz2 && cd xfce4-whiskermenu-plugin-2.8.3 && mkdir build && cd build && cmake .. --install-prefix=/usr && sudo make install && cd ~/pre
cd Azure-Linux-Desktop-Experience/mugshot && sudo chmod +x setup.py && sudo python3 setup.py install && cd ~/pre
wget https://archive.xfce.org/src/panel-plugins/xfce4-cpugraph-plugin/1.2/xfce4-cpugraph-plugin-1.2.8.tar.bz2 && tar -xvf xfce4-cpugraph-plugin-1.2.8.tar.bz2 && cd xfce4-cpugraph-plugin-1.2.8 && ./configure --prefix=/usr --sysconfdir=/etc && sudo make install && cd ~/pre
wget https://archive.xfce.org/src/panel-plugins/xfce4-clipman-plugin/1.6/xfce4-clipman-plugin-1.6.6.tar.bz2 && tar -xvf xfce4-clipman-plugin-1.6.6.tar.bz2 && cd xfce4-clipman-plugin-1.6.6 && ./configure --prefix=/usr --sysconfdir=/etc && sudo make install && cd ~/pre
#extended-apps!
wget https://github.com/storaged-project/libblockdev/releases/download/3.2.1/libblockdev-3.2.1.tar.gz && tar -xvf libblockdev-3.2.1.tar.gz && cd libblockdev-3.2.1 && ./configure --prefix=/usr --sysconfdir=/etc --without-escrow && sudo make install && sudo ldconfig && cd ~/pre
wget https://github.com/storaged-project/udisks/releases/download/udisks-2.10.1/udisks-2.10.1.tar.bz2 && tar -xvf udisks-2.10.1.tar.bz2 && cd udisks-2.10.1 && ./configure --prefix=/usr --sysconfdir=/etc && sudo make install && cd ~/pre
wget https://download.gnome.org/sources/gcr/4.3/gcr-4.3.0.tar.xz && tar -xvf gcr-4.3.0.tar.xz && cd gcr-4.3.0 && mkdir build && cd build && meson setup .. --prefix=/usr --sysconfdir=/etc --buildtype=release -D gtk_doc=false && sudo ninja install && sudo ldconfig && cd ~/pre
wget https://download.gnome.org/sources/gvfs/1.56/gvfs-1.56.1.tar.xz && tar -xvf gvfs-1.56.1.tar.xz && cd gvfs-1.56.1 && mkdir build && cd build && meson setup .. --prefix=/usr --sysconfdir=/etc --buildtype=release -D onedrive=false -D fuse=false -D gphoto2=false -D afc=false -D bluray=false -D nfs=false -D mtp=false -D smb=false -D tmpfilesdir=no -D dnssd=false -D goa=false -D google=false && sudo ninja install && sudo ldconfig && cd ~/pre
wget https://download.gnome.org/sources/atkmm/2.36/atkmm-2.36.3.tar.xz && tar -xvf atkmm-2.36.3.tar.xz && cd atkmm-2.36.3 && mkdir build && cd build && meson setup .. --prefix=/usr --sysconfdir=/etc --buildtype=release && sudo ninja install && cd ~/pre
wget https://www.cairographics.org/releases/cairomm-1.16.0.tar.xz && tar -xvf cairomm-1.16.0.tar.xz && cd cairomm-1.16.0 && ./autogen.sh --prefix=/usr --sysconfdir=/etc && sudo make install && cd ~/pre
wget https://download.gnome.org/sources/pangomm/2.54/pangomm-2.54.0.tar.xz && tar -xvf pangomm-2.54.0.tar.xz && cd pangomm-2.54.0 && mkdir build && cd build && meson setup .. --prefix=/usr --sysconfdir=/etc --buildtype=release && sudo ninja install && cd ~/pre
wget https://download.gnome.org/sources/gtkmm/4.16/gtkmm-4.16.0.tar.xz && tar -xvf gtkmm-4.16.0.tar.xz && cd gtkmm-4.16.0 && ./autogen.sh --prefix=/usr --sysconfdir=/etc && sudo make install && cd ~/pre
wget https://www.freedesktop.org/software/pulseaudio/pavucontrol/pavucontrol-6.1.tar.xz && tar -xvf pavucontrol-6.1.tar.xz && cd pavucontrol-6.1 && mkdir build && cd build && meson setup .. --prefix=/usr --sysconfdir=/etc --buildtype=release -D lynx=false && sudo ninja install && cd ~/pre
wget https://download.gnome.org/sources/NetworkManager/1.51/NetworkManager-1.51.4.tar.xz && tar -xvf NetworkManager-1.51.4.tar.xz && cd NetworkManager-1.51.4 && mkdir build && cd build && meson setup .. --prefix=/usr --sysconfdir=/etc --buildtype=release -D libaudit=no -D modem_manager=false && sudo ninja install && cd ~/pre
wget https://download.gnome.org/sources/libnma/1.10/libnma-1.10.6.tar.xz && tar -xvf libnma-1.10.6.tar.xz && cd libnma-1.10.6 && ./autogen.sh --prefix=/usr --sysconfdir=/etc && sudo make install && cd ~/pre
wget https://download.gnome.org/sources/network-manager-applet/1.36/network-manager-applet-1.36.0.tar.xz && tar -xvf network-manager-applet-1.36.0.tar.xz && cd network-manager-applet-1.36.0 && mkdir build && cd build && meson setup .. --prefix=/usr --sysconfdir=/etc --buildtype=release -D appindicator=no -D wwan=false && sudo ninja install && cd ~/pre
wget https://launchpad.net/python-distutils-extra/trunk/2.39/+download/python-distutils-extra-2.39.tar.gz && tar -xvf python-distutils-extra-2.39.tar.gz && cd python-distutils-extra-2.39 && sudo chmod +x setup.py && sudo python3 setup.py install && cd ~/pre
wget https://ftp.mozilla.org/pub/firefox/releases/133.0/linux-x86_64/id/firefox-133.0.tar.bz2 && tar -xvf firefox-133.0.tar.bz2 && sudo mv -v firefox /opt && sudo ln -sv /opt/firefox/firefox /bin && sudo ln -sv /opt/firefox/firefox-bin /bin/mozilla-firefox && cd ~/pre
#setup-wayland!
echo -e "XTerm*mainMenu: true \nXTerm*ToolBar: true \nXTerm*Background: black \nXTerm*Foreground: white" | tee -a ~/.Xdefaults
echo -e "pulseaudio --start \nexec dbus-launch startxfce4 --wayland" | tee -a ~/.xinitrc
echo -e 'if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then\n    startx\nfi' >> ~/.bash_profile
echo -e 'if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then\n    startx\nfi' >> ~/.zprofile
chsh -s $(which zsh)
sudo rm -rf /etc/profile.d/debuginfod.sh
sudo glib-compile-schemas /usr/share/glib-2.0/schemas
sudo systemctl enable NetworkManager.service
sudo systemctl start NetworkManager.service
clear
echo -e "\e[31mdone - trying to running xfce4! \e[0m"
sleep 1
startx
