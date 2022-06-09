#!/bin/bash
RED="\e[31m"
BLUE="\e[34m"
GREEN="\e[32m"
ENDCOLOR="\e[0m"
PASS='$6$slXu6C.kEflFB4/U$1fUGAzR6.k2IScFItK88.w49e5kRGbPEPY0gOUAD7IMDr4wLpvihEl7RVj5.P4T6iBgX3Fy4UXePtLRpOOE5m/'
DEVIDE='=======---------------------------------------------------======='

## Скрипт создает хэш для пароля
## python3 hash.py

## Задания лабы 2
echo -e "${BLUE}${DEVIDE}${ENDCOLOR}"
echo "Пароль на все учетные записи password"
echo "для создания хеша альтернативного пароля используйте скрипт hash.py и поменяйте значение переменной \$PASS"
echo $PASS
echo -e "${BLUE}${DEVIDE}${ENDCOLOR}"

echo -e "${GREEN}"
read -n 1 -p "Создаем пользователей user1,user2,user3,user4: "
echo -e "${ENDCOLOR}" 1>&2
useradd -d /home/user1 -k /etc/skel -s /bin/bash -m -p $PASS user1 
useradd -d /home/user2 -k /etc/skel -s /bin/bash -m -p $PASS user2
useradd -d /home/user3 -k /etc/skel -s /bin/bash -m -p $PASS user3
useradd -d /home/user4 -k /etc/skel -s /bin/bash -m -p $PASS user4
pdpl-user -l 0:1 -i 63 -c 0x1:0x1 user1
pdpl-user -l 0:2 -i 63 -c 0x1:0x3 user2
pdpl-user -l 0:3 -i 63 -c 0x2:0x2 user3
pdpl-user -l 0:3 -i 63 -c 0x3:0x3 user4
chage -m 180 -W 5 user2
echo $DEVIDE

echo -e "${GREEN}"
read -n 1 -p "Создаем  пользователя user10: " AMSURE 
echo -e "${ENDCOLOR}" 1>&2
useradd -d /home/user10 -k /etc/skel -s /bin/bash -m -p $PASS user10
chage -m 180 -W 5 user10
pdpl-user -l 0:3 -i 63 -c 0x1:0x1 user10
usermod -a -G astra-admin,lpadmin user10
echo $DEVIDE

echo -e "${GREEN}"
read -n 1 -p "Создаем группу group3,group4 и добавить пользователя user3 в эти группы:" AMSURE 
echo -e "${ENDCOLOR}" 1>&2
addgroup group3;addgroup group4
usermod -a -G group3,group4 user3
echo $DEVIDE

echo ""
echo -e "${GREEN}Проверяем /etc/group:${ENDCOLOR}"
cat /etc/group|grep "^group3" --color=auto
cat /etc/group|grep "^group4" --color=auto
echo $DEVIDE

echo ""
echo -e "${GREEN}Уровни доступа:${ENDCOLOR}"
cat /etc/parsec/mac_levels
echo $DEVIDE

echo ""
echo -e "${GREEN}Неиерархические категории:${ENDCOLOR}"
cat /etc/parsec/mac_categories;echo
echo $DEVIDE

echo ""
echo -e "${GREEN}UID пользователя user1:${ENDCOLOR}"
cat /etc/passwd|grep "^user1:"|cut -d: -f3
echo $DEVIDE

echo -e "${RED}"
read -n 1 -p "Удаляем пользователя из группы group3,group4: " AMSURE 
echo -e "${ENDCOLOR}" 1>&2
gpasswd -d user3 group3;gpasswd -d user3 group4
echo $DEVIDE

echo -e "${RED}"
read -n 1 -p "Удаляем группы group3,group4: " AMSURE 
echo -e "${ENDCOLOR}" 1>&2
delgroup group3; delgroup group4
echo $DEVIDE

echo ""
echo -e "${RED}"
read -n 1 -p "Удаляем пользователей user1,user2,user3,user4,user10: " AMSURE 
echo -e "${ENDCOLOR}" 1>&2
userdel -r user1;userdel -r user2;userdel -r user3;userdel -r user4;userdel -r user10
echo $DEVIDE
