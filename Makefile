file := node_exporter-0.18.1.linux-amd64
phony: install

install:
	useradd -M -r -s /bin/false node_exporter || true
	wget https://github.com/prometheus/node_exporter/releases/download/v0.18.1/$(file).tar.gz
	install -o node_exporter -g node_exporter $(file)/node_exporter /usr/local/bin
	install node_exporter.service /etc/systemd/system
	systemctl daemon-reload
	systemctl enable --now node_exporter.service
	firewall-cmd --add-port 9100/tcp
	firewall-cmd --add-port 9100/tcp --permanent
