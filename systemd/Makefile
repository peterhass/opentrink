install:
	mkdir -p ~/.config/systemd/user
	install --mode=664 ./opentrink.service ~/.config/systemd/user/
	systemctl --user daemon-reload
	systemctl --user enable opentrink.service
	systemctl --user restart opentrink.service
	echo "Do not forget allow running the service without login: loginctl enable-linger"
