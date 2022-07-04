## на машине *-nat
wget http://download.astralinux.ru/astra/stable/smolensk/security-updates/1.6/20211126SE16/20211126SE16.iso
sudo mkdir /srv/ftp/pub/upd10
sudo mount /home/student/20211126SE16.iso /srv/ftp/pub/upd10

## на клиенте (предварительно скопируйте на него astra-update_1.15+ci24_amd64.deb)
sudo dpkg -i astra-update_1.15+ci24_amd64.deb
sudo vim /etc/apt/sources.list

cat /etc/apt/sources.list
'''
#deb cdrom:[OS Astra Linux 1.6 smolensk - amd64 DVD ]/ smolensk contrib main non-free
deb ftp://192.168.0.1/pub/distr/ smolensk contrib main non-free
deb ftp://192.168.0.1/pub/upd10/ smolensk contrib main non-free
'''

sudo apt update
sudo astra-update -a -r
