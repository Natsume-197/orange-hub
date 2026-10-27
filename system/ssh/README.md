# SSH

Key-only login. Allow `22/tcp` from `<LAN_CIDR>`; use Tailscale from elsewhere. Merge `sshd_config.snippet` into `/etc/ssh/sshd_config`, then reload ssh.
