prom/memcached-exporter                 latest              33f646e4fced        9 days ago          16.2MB
prom/prometheus                         latest              d5b9d7ed160a        2 weeks ago         138MB
prom/pushgateway                        latest              20e6dcae675f        4 weeks ago         19.2MB
prom/cloudwatch-exporter                latest              1ae3cdb4721b        5 weeks ago         212MB
prom/mysqld-exporter                    latest              432cdd0a0e7c        5 weeks ago         17.5MB
prom/statsd-exporter                    latest              6f220c0814d1        5 weeks ago         17.3MB
prom/prom2json                          latest              4d457e2210cc        6 weeks ago         14MB
prom/consul-exporter                    latest              1cbb01d6740a        7 weeks ago         17.6MB
prom/busybox                            latest              6411f746fb8f        7 weeks ago         2.68MB
prom/alertmanager                       latest              ce3c87f17369        8 weeks ago         51.9MB
prom/node-exporter                      latest              e5a616e4b9cf        3 months ago        22.9MB
prom/graphite-exporter                  latest              77c91d2072f3        3 months ago        16.9MB
prom/blackbox-exporter                  latest              d3a00aea3a01        5 months ago        17.6MB
prom/influxdb-exporter                  latest              8b6281a5fc7f        6 months ago        14.9MB
prom/snmp-exporter                      latest              1aaeafc1d80c        6 months ago        16.6MB
prom/haproxy-exporter                   latest              79886155b514        7 months ago        15.3MB
prom/collectd-exporter                  latest              98678887c9cb        19 months ago       13.7MB
prom/prometheus-cli                     latest              c3aa9fba795e        2 years ago         20.6MB


prometheus部署到kubernetes
kubernetes 版本v1.15(v1.14可用)

部署顺序
rbac-setup.yaml -> configmap.yaml -> prometheus.deploy.yaml -> prometheus.svc.yaml

prometheus.yaml是prometheus运行用的配置文件







