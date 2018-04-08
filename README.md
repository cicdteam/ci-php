# Docker image used as builder for PHP projects

Please look at branches and checkout to what you need

### 7.2 Alpine version

Installed

- git
- bash
- docker
- kubectl

Installed PHP extentions

```
$ docker run -it --rm pure/ci-php:7.2-alpine php -m
[PHP Modules]
apcu
bcmath
Core
ctype
curl
date
dom
fileinfo
filter
ftp
gd
hash
iconv
intl
json
libxml
mbstring
mongodb
mysqlnd
openssl
pcre
PDO
pdo_mysql
pdo_pgsql
pdo_sqlite
pgsql
Phar
posix
readline
redis
Reflection
session
SimpleXML
sockets
sodium
SPL
sqlite3
standard
tokenizer
xml
xmlreader
xmlwriter
Zend OPcache
zip
zlib

[Zend Modules]
Zend OPcache
```
