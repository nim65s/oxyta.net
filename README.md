# Ateliers Docker

[Pad](https://mypads.framapad.org/mypads/?/mypads/group/altermediatic-toulouse-deatm79d/pad/view/docker-atelier-acqwh7km)

## All

- add `include /etc/nginx/sites-enabled/*` to /etc/nginx/nginx.conf in http section
- `mkdir /etc/nginx/sites-enabled/ /srv/letsencrypt`

## Etherpad

```
cd etherpad
export MYSQL_ROOT_PASSWORD=$(openssl rand -base64 32)
ln -s nginx.conf /etc/nginx/sites-enabled/etherpad
systemctl restart nginx
certbot certonly --email <me souviens plus> --webroot -w /srv/letsencrypt/ --agree-tos -d www.pad.oxyta.net -d pad.oxyta.net
docker-compose up
```


## Nextcloud

```
cd nextcloud
export MYSQL_ROOT_PASSWORD=$(openssl rand -base64 32)
export MYSQL_PASSWORD=$(openssl rand -base64 32)