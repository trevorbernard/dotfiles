#!/bin/bash

sudo add-apt-repository -y ppa:cassou/emacs
sudo add-apt-repository -y ppa:webupd8team/java

echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo tee -a /usr/bin/debconf-set-selections

sudo apt-get update
sudo apt-get -y install emacs24 oracle-java8-installer git

sudo wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -O /usr/local/bin/lein && sudo chmod +x /usr/local/bin/lein

git clone https://github.com/trevorbernard/dot-files.git
cp -r dot-files/* .
cp dot-files/.lein/profiles.clj .lein/
git clone https://github.com/trevorbernard/emacs.git .emacs.d
