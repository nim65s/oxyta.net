# Ateliers Docker

[Pad](https://mypads.framapad.org/mypads/?/mypads/group/altermediatic-toulouse-deatm79d/pad/view/docker-atelier-acqwh7km)

## Install

```
# Install docker
# See https://docs.docker.com/engine/installation/linux/docker-ce/debian/#install-using-the-repository
apt install \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common

curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -

echo \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable" \
   > /etc/apt/source.list.d/docker.list

apt update && apt install docker-ce msmtp python-pip

# install docker-compose
pip install docker-compose

# Start docker
systemctl start docker
systemctl enable docker

# Change SSH port (because 22 will be used by gitlab)
echo 'Port 222' >> /etc/ssh/sshd_config
systemctl restart sshd

# Add keys
cd
git clone https://framagit.org/altermediatic/keys.git
cd .ssh
rm -f authorized_keys
ln -s ../keys/ssh authorized_keys

# Add this repo
cd
git clone https://framagit.org/altermediatic/docker-atelier.git
cd docker-atelier

# Configure environment variables in setup.sh then run it
./setup.sh

# Deploy Services
# Note: docker-compose's traefik.docker.network contains references to the project's name (see https://github.com/containous/traefik/issues/2348)
docker-compose -d -p oxyta up
```

## Configure mail

[doc](mail)

## Update homepage

docker-compose build --no-cache