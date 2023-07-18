#!/bin/bash

echo ...
echo ...
echo getting Apache to you

# //------- get and install httpd
sudo apt-get update
sudo apt install apache2 -y

# //------- allow Apache to pass inner fw
ufw allow 'Apache'

# //-------- start service
sudo systemctl start apache2

# //-- enable httpd service to start at boot
sudo systemctl enable apache2

# //-- restart apache 
sudo systemctl restart apache2

# //-- wait 5 seconds to let apache2 restart and do the next step
sleep 5 

# //-- check status of apache service
sudo systemctl status apache2


sudo apt-get update
#install gnome desktop
#sudo apt-get install ubuntu-desktop -y
#install xrdp
sudo apt-get install xrdp -y

#using xfce if you are using Ubuntu version later than Ubuntu 12.04LTS
sudo apt-get install xfce4 -y
#sudo apt-get install xubuntu-desktop -y
sudo echo xfce4-session >/root/.xsession
sudo sed -i '/\/etc\/X11\/Xsession/i xfce4-session' /etc/xrdp/startwm.sh
sudo service xrdp restart