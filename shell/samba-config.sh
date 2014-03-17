#!/bin/bash

#安装配置samba
#sudo apt-get install samba cifs-utils
#配置共享
#smbpasswd -a <user-name>
#cp -p /etc/samba/smb.conf /etc/samba/smb.conf.bak
#vi /etc/samba/smb.conf
#打开语句security = user，并增加username map = /etc/samba/smbusers

#在文件最后增加共享的文件夹的配置：
#[<user-name>]
#        comment = <user-name>
#        path = /home/<user-name>
#        public = yes
#        writeable = yes
#        valid users = <user-name>
#        create mask = 0770
#        directory mask = 0770
#        force user = <user-name>
#        force group = <user-name>
#        available = yes
#        browseable = yes
#        veto files=/.*/
#  
# 修改完后，重启samba:
# smbd restart
# 关闭防火墙：
# ufw disable
# 关闭selinux:
# setenforce 0
#
#创建所有用户都可以访问的文件夹共享：
#mkdir /home/public
#chmod 777 /home/public
#smb.conf中：security = user修改为security = share
#添加：
#[public]
#        comment = public
#        path = /home/public
#        public = yes
#        writeable = yes
#        create mask = 0777
#        directory mask = 0777
#        available = yes 
#        browseable = yes
#        veto files=/.*/
#

name=$1
if [ -z "$name" ]; then
	echo "samba-config.sh <user-name>"
	exit 1
fi

id user >/dev/null 2>&1
if [ $? != 0 ]; then
	echo "error: $name is not exist!"
	exit 2
fi

smbpasswd -a $name

(
cat << EOF


#-------------------
[$name]
        comment = $name
        path = /home/$name
        public = yes
        writeable = yes
        valid users = $name
        create mask = 0770
        directory mask = 0770
        force user = $name
        force group = $name
        available = yes
        browseable = yes
        veto files=/.*/
EOF
) >> /etc/samba/smb.conf

echo "add samba user $name ok!"

smbd restart
