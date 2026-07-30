# Broker MQTT

Ce service Mosquitto reste volontairement minimal: il authentifie les producteurs et consommateurs MQTT, puis laisse l'orchestrator gérer la génération des trames et leur persistance en base.

Contrat de topic utilisé par l'orchestrator:

- `bracelets/<device_uid>/measurements` pour les trames de mesures principales
- le payload JSON contient au minimum `device_uid`, `serial_number`, `captured_at`, `heart_rate_bpm`, `spo2_percent` et `step_count`

Le broker n'écrit pas directement en base; il transporte les messages vers le service de pont MQTT→PostgreSQL dans `infra-orchestrator`.