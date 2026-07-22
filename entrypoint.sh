#!/bin/sh
set -eu

CONFIG_DIR="/mosquitto/config"
DEFAULT_CONFIG="/defaults/mosquitto.conf"
RUNTIME_CONFIG="${CONFIG_DIR}/mosquitto.conf"
PASSWORD_FILE="${CONFIG_DIR}/password_file"

mkdir -p "${CONFIG_DIR}" /mosquitto/data /mosquitto/log

if [ ! -f "${RUNTIME_CONFIG}" ]; then
  cp "${DEFAULT_CONFIG}" "${RUNTIME_CONFIG}"
fi

if [ -z "${MQTT_USER:-}" ] || [ -z "${MQTT_PASSWORD:-}" ]; then
  echo "MQTT_USER et MQTT_PASSWORD sont requis pour démarrer le broker."
  exit 1
fi

mosquitto_passwd -b -c "${PASSWORD_FILE}" "${MQTT_USER}" "${MQTT_PASSWORD}"

exec /usr/sbin/mosquitto -c "${RUNTIME_CONFIG}"