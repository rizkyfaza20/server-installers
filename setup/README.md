*Linux Setup*
=======================

Linux Environment Building

INSTALLATION
------------

Select your Linux distribution to download and execute the installer as below:

> You can make installer executable by `$ chmod +x ./installer` then `$ ./installer`.

### Ubuntu 16.04 LTS

> IPv6 Disabling  
> SSH PasswordAuthentication enabling  
> Sudoer User creating

```
$ bash <(wget -qO- https://raw.githubusercontent.com/yidas/server-installers/master/setup/ubuntu16.04.sh)
```

### Ubuntu 18.04 LTS

> IPv6 Disabling  
> SSH PasswordAuthentication enabling  
> Sudoer User creating

```
$ bash <(wget -qO- https://raw.githubusercontent.com/yidas/server-installers/master/setup/ubuntu18.04.sh)
```
### Ubuntu Server (Common)

At this installer contain on how to install JDK, Elasticsearch, Keycloak etc.

```
bash <(wget -qO- https://raw.githubusercontent.com/rizkyfaza20/server-installers/development/setup/ubuntu-linux.sh)
```
