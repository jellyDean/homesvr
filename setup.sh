sudo pacman -Syy
sudo pacman -S nginx php-fpm ssmtp --noconfirm
sudo systemctl start nginx
sudo systemctl start php-fpm
sudo systemctl enable nginx
sudo systemctl enable php-fpm
sudo cp -R /vagrant/src/* /srv/http
sudo cp /vagrant/nginx.conf /etc/nginx/nginx.conf
sudo cp /vagrant/revaliases /etc/ssmtp/revaliases
sudo cp /vagrant/ssmtp.conf /etc/ssmtp/ssmtp.conf
sudo systemctl restart nginx
sudo systemctl restart php-fpm