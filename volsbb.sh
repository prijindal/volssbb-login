nmcli radio wifi off
nmcli radio wifi on

nmcli connection delete 'VIT2.4G'
nmcli connection delete 'VIT2.4G 1'

nmcli radio wifi off
nmcli radio wifi on

sleep 1

nmcli device wifi rescan
nmcli device wifi list

sleep 1

nmcli device wifi connect 'VIT2.4G' &&

sh login.sh
