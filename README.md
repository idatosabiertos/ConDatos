# ConDatos [![Build Status](https://travis-ci.org/idatosabiertos/ConDatos.svg?branch=master)](https://travis-ci.org/idatosabiertos/ConDatos)

## REQUERIMIENTOS / REQUIREMENTS
1. Postgres
2. Ruby 2.3.1
3. Bundler
4. SendGrid

## INSTALACIÓN / INSTALLATION
1. $`git clone https://github.com/idatosabiertos/ConDatos` 
2. $`bundle install`
3.
    - $ `export PG_DB_URL=postgres://localhost:5432/ogp` 
    - $ `export PG_USER='yourUsername'` 
    - $ `export PG_PWD='yourPassword'` 
    - $ `export CONTACT_EMAIL='destiny@email.com'` 
    - $ `export SENDGRID_APIKEY='yourApiKey'` 
4. $`psql -c "CREATE DATABASE ogp;" -U postgres`
5. $`rake db:create_inscriptions`
6. $`shotgun`
7. Navegar a / Navigate to `http://localhost:9393`

### Vagrant  [/vagrant](https://github.com/idatosabiertos/ConDatos/tree/master/vagrant)
 **Requerimientos / Requirements**
 - [Vagrant](https://www.vagrantup.com/downloads.html)
 - [VirtualBox](https://www.virtualbox.org/wiki/Downloads)  

#### **Pasos / Steps:**
1. $`git clone https://github.com/idatosabiertos/ConDatos`
2. $`cd ConDatos/vagrant`
3. $`vagrant up` 
4. Navegar a / Navigate to `http://localhost:9393` en la maquina host / on host machine.