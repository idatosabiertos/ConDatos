# ConDatos

## PREQUISITES
- Postgres
- Ruby 2.3.1
- Bundler
- SendGrid

## INSTALATION
- Clone the repo
- Under ConDatos directory run $ bundle install
- Set environment variables:
    - $ export PG_DB_URL=postgres://localhost:5432/ogp
    - $ export PG_USER='yourUsername'
    - $ export PG_PWD='yourPassword'
    - $ export CONTACT_EMAIL='destiny@email.com'
    - $ export SENDGRID_APIKEY='yourApiKey'
- Create 'ogp' database in postgres  
- Create inscriptions table  $ rake db:create_inscriptions
- Start the server $ shotgun
- navigate to localhost:9393

## VAGRANT
### -VagrantFile
    Vagrant.configure('2') do |config|
      config.vm.box      = 'yourBoxHere' 
      config.vm.hostname = 'rails-dev-box'

      config.vm.network 'private_network', ip: '192.168.56.4'
      config.vm.network :forwarded_port, guest: 9393, host: 9393
      config.vm.network :forwarded_port, guest: 80, host: 8080

      config.vm.provision :shell, path: 'bootstrap.sh', keep_color: true

      config.vm.provider 'virtualbox' do |v|
        v.memory = 2048
        v.cpus = 2
      end
    end

### -Bootstrap.sh
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

    cd /usr
    sudo mkdir idatosabiertos
    sudo chmod 757 -R /usr/idatosabiertos
    cd idatosabiertos
    sudo git clone https://github.com/idatosabiertos/ConDatos.git
    sudo git checkout develop
    cd ConDatos
    sudo apt-get -y install libpq-dev
    bundle install

    export PG_DB_URL=postgres://localhost:5432/ogp
    export PG_USER='yourUsername'
    export PG_PWD='yourPassword'

    export CONTACT_EMAIL='destiny@mail.com'
    export SENDGRID_APIKEY='yourApiKey'

    sudo apt-get -y install postgresql postgresql-contrib
    echo 'CREATE DATABASE ogp;' > db_create.sql
    psql -U postgres postgres -f ./db_create.sql
    rake db:create_inscriptions

    echo 'all set, rock on!'
