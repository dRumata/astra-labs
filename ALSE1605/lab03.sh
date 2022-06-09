#!/bin/bash
RED="\e[31m"
BLUE="\e[34m"
GREEN="\e[32m"
ENDCOLOR="\e[0m"
PASS='$6$slXu6C.kEflFB4/U$1fUGAzR6.k2IScFItK88.w49e5kRGbPEPY0gOUAD7IMDr4wLpvihEl7RVj5.P4T6iBgX3Fy4UXePtLRpOOE5m/'
DEVIDE='=======---------------------------------------------------======='

## Скрипт создает хэш для пароля
## python3 hash.py

## Задания лабы 3
echo -e "${BLUE}${DEVIDE}${ENDCOLOR}"
echo "Пароль на все учетные записи password"
echo "для создания хеша альтернативного пароля используйте скрипт hash.py и поменяйте значение переменной \$PASS"
echo $PASS
echo -e "${BLUE}${DEVIDE}${ENDCOLOR}"

echo -e "${GREEN}"
read -n 1 -p "Создаем Уровень 4: "
echo -e "${ENDCOLOR}" 1>&2
userlev -a 4 Уровень_4
echo $DEVIDE

echo ""
echo -e "${GREEN}Список уровней:${ENDCOLOR}"
cat /etc/parsec/mac_levels
echo $DEVIDE

echo -e "${GREEN}"
read -n 1 -p "Создаем пользователей user1: "
echo -e "${ENDCOLOR}" 1>&2
useradd -d /home/user1 -k /etc/skel -s /bin/bash -m -p $PASS user1 
pdpl-user -l 0:4 -i 63 -c 0x1:0x1 user1

echo -e "${GREEN}"
read -n 1 -p "Удаляем категории и создаем новые: "
echo -e "${ENDCOLOR}" 1>&2
usercat -d 1;usercat -d 2;usercat -d 4
usercat -a 0x1 Otdel1;usercat -a 0x2 Otdel2;usercat -a 0x4 Upravlenie
echo $DEVIDE
cat /etc/parsec/mac_categories

echo -e "${GREEN}"
read -n 1 -p "Создаем пользователей user2,rukoffice1. Группу office1: "
echo -e "${ENDCOLOR}" 1>&2
addgroup office1
useradd -d /home/user2 -g office1 -k /etc/skel -s /bin/bash -m -p $PASS user2
useradd -d /home/rukoffice1 -g office1 -k /etc/skel -s /bin/bash -m -p $PASS rukoffice1 
usermod -g office1 user1
pdpl-user -l 0:3 -i 63 -c 0x2:0x2 user2
pdpl-user -l 0:3 -i 63 -c 0x4:0x7 rukoffice1
usermod -a -G astra-console user1
usermod -a -G astra-console user2
usermod -a -G astra-console rukoffice1
echo $DEVIDE

echo -e "${GREEN}"
read -n 1 -p "Создаем структуру каталогов в /home/work: "
echo -e "${ENDCOLOR}" 1>&2
mkdir -p /home/work/otdel{1,2}
mkdir /home/work/upr

chown sa:office1 /home/work
chmod 750 /home/work
pdpl-file 3:0:Otdel1,Otdel2,Upravlenie:ccnr /home/work

chown user1:office1 /home/work/otdel1
chmod 770 /home/work/otdel1
pdpl-file 3:0:Otdel1:ccnr /home/work/otdel1

chown user2:office1 /home/work/otdel2
chmod 770 /home/work/otdel2
pdpl-file 3:0:Otdel2:ccnr /home/work/otdel2

mkdir /home/work/{otdel{1,2},upr}/u{1,2,3} &&
pdpl-file 3:0:Upravlenie:ccnr /home/work/upr
pdpl-file 1:0:Upravlenie:0 /home/work/upr/u1
pdpl-file 2:0:Upravlenie:0 /home/work/upr/u2
pdpl-file 3:0:Upravlenie:0 /home/work/upr/u3

chown rukoffice1:office1 /home/work/upr/u{1,2,3}
chmod 770 /home/work/upr/u{1,2,3}
apt install -y tree

echo $DEVIDE
tree /home/work/
echo $DEVIDE