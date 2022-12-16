sudo systemctl start NetworkManager.service
sudo nmcli dev wifi connect $WIFI_SSID password $WIFI_PASSWD
