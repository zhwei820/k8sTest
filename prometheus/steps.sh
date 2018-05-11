docker run -d -p 9090:9090 \
-v /root/back/k8s/k8s-app/app/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml \
prom/prometheus \
--web.enable-lifecycle \
--config.file=/etc/prometheus/prometheus.yml