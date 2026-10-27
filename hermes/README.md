# Hermes

User units for the gateway and the dashboard. State stays in `<HERMES_HOME>` (not in this repo). Memory API: `127.0.0.1:${HINDSIGHT_API_PORT}`. Dashboard: `127.0.0.1:${HERMES_DASHBOARD_PORT}`.

```sh
cp .env.example <HERMES_HOME>/dashboard.env && chmod 600 <HERMES_HOME>/dashboard.env
cp systemd/*.service ~/.config/systemd/user/
systemctl --user enable --now hermes-gateway hermes-dashboard
```

After an update, restart both units. Keep `PATH` aligned with `<HERMES_HOME>`.
