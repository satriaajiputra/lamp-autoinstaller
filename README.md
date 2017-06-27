# lamp-autoinstaller
LAMP Auto Installer Script for >= Ubuntu 14.04 and Debian Wheezy

## Features
* PHP v7.0
* MySQL Server
* phpMyAdmin
* Screenfetch Ubuntu
* Composer Installed
* Other? Request via issue.

## Quick Setup
To use this auto installer script, you must login as root user.
For first, login as root and go to root folder
```bash
cd root
```

### For Ubuntu
And execute this command
```bash
wget -O install.sh "https://raw.githubusercontent.com/satriaajiputra/lamp-autoinstaller/master/src/ubuntu/install.sh" && chmod +x install.sh && ./install.sh
```

### For Debian Wheezy
```bash
wget -O install.sh "https://raw.githubusercontent.com/satriaajiputra/lamp-autoinstaller/master/src/debian/install.sh" && chmod +x install.sh && ./install.sh
```
