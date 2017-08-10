function install {
    echo installing $1
    shift
    apt-get -y install "$@" >/dev/null 2>&1
}

echo adding swap file
fallocate -l 2G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo '/swapfile none swap defaults 0 0' >> /etc/fstab

sudo apt-get install curl
gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable

source /etc/profile.d/rvm.sh
rvm requirements

rvm install 2.3.1
rvm use 2.3.1 --default 

sudo chmod 757 -R /usr/local/rvm/gems
gem install bundler

install Git git

cd /opt
sudo mkdir idatosabiertos
sudo chmod 757 -R /opt/idatosabiertos
cd idatosabiertos
sudo git clone https://github.com/idatosabiertos/ConDatos.git
sudo git checkout develop
cd ConDatos
sudo apt-get -y install libpq-dev
bundle install

export PG_DB_URL=postgres://localhost:5432/ogp
export PG_USER='postgres'
export PG_PWD='postgres'

export CONTACT_EMAIL='destiny@mail.com'
export SENDGRID_APIKEY='yourApiKey'

sudo apt-get -y install postgresql postgresql-contrib
sudo -u postgres bash -c "psql -c \"CREATE ROLE root WITH SUPERUSER;\""
sudo -u postgres bash -c "psql -c \"ALTER ROLE root WITH LOGIN;\""
sudo -u postgres bash -c "psql -c \"CREATE DATABASE ogp;\""
rake db:create_inscriptions

shotgun --host=0.0.0.0
echo 'Navegar a / Navigate to `http://localhost:9393` en la maquina host / on host machine.'