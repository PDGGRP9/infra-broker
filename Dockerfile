FROM eclipse-mosquitto:2.0

COPY mosquitto.conf /defaults/mosquitto.conf
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 1883 9001

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]