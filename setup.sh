#!/bin/sh

set -x

apk add samba-dc samba-winbind-clients
rm /etc/samba/smb.conf

samba-tool domain provision \
  --server-role=dc \
  --dns-backend=SAMBA_INTERNAL \
  --realm=example.com \
  --domain=EXAMPLE \
  --adminpass=ohfie3Uahe
sed -i '/\[global\]/a ldap server require strong auth = no' /etc/samba/smb.conf
sed -i '/\[global\]/a log level = 3' /etc/samba/smb.conf

samba-tool user setexpiry Administrator --noexpiry
samba-tool user create user1 Password1
samba-tool user setexpiry user1 --noexpiry
samba-tool user create user2 Password2
samba-tool user setexpiry user2 --noexpiry
samba-tool user create user3 Password3
samba-tool user setexpiry user3 --noexpiry

samba-tool group add group1
samba-tool group addmembers group1 user1
samba-tool group addmembers group1 user3

samba-tool group add group2
samba-tool group addmembers group2 user2
samba-tool group addmembers group2 user3

samba-tool group add group3
samba-tool group addmembers group3 user3
