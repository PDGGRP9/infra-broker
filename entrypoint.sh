#!/bin/sh
set -eu

CONFIG_DIR="/mosquitto/config"
DEFAULT_CONFIG="/defaults/mosquitto.conf"
RUNTIME_CONFIG="${CONFIG_DIR}/mosquitto.conf"
PASSWORD_FILE="${CONFIG_DIR}/password_file"

mkdir -p "${CONFIG_DIR}" /mosquitto/data /mosquitto/log

# Always refresh the runtime config from the image so an old volume cannot
# keep a stale Mosquitto configuration without listeners.
cp "${DEFAULT_CONFIG}" "${RUNTIME_CONFIG}"

if [ -z "${MQTT_USER:-}" ] || [ -z "${MQTT_PASSWORD:-}" ]; then
  echo "MQTT_USER et MQTT_PASSWORD sont requis pour démarrer le broker."
  exit 1
fi

mosquitto_passwd -b -c "${PASSWORD_FILE}" "${MQTT_USER}" "${MQTT_PASSWORD}"
chmod 0644 "${PASSWORD_FILE}"

if id mosquitto >/dev/null 2>&1; then
  chown mosquitto:mosquitto "${PASSWORD_FILE}" || true
fi

exec /usr/sbin/mosquitto -c "${RUNTIME_CONFIG}"