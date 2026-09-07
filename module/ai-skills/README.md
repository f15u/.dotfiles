# Update Skills

1. `cd /home/f15u/.dotfiles`
2. `pnpx skills update --project --yes`
3. `git add .agents/skills skills-lock.json`
4. Review changes.
5. `sudo nixos-rebuild switch --flake .#nixos`
