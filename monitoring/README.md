# Monitoring

[InfluxDB](https://docs.influxdata.com/influxdb/)
[Telegraf](https://docs.influxdata.com/telegraf/)
[Grafana](https://grafana.com/)

## Configure

```
sudo mkdir -p ${CHATONS_ROOT_DIR:-/srv/chatons}/${CHATONS_SERVICE:-monitoring}/grafana
sudo chown 472:472 ${CHATONS_ROOT_DIR:-/srv/chatons}/${CHATONS_SERVICE:-monitoring}/grafana
```

## Deploy
```
docker-compose up -d
```

## Configure

- Add data source Influx DB from url http://influxdb:8086 on database telegraf
- import dashboards 928 & 3467
