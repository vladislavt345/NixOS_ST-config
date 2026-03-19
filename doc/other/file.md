Критично

- **direnv + nix-direnv** — автоматически подгружает окружение при входе в папку проекта. Основной инструмент для изоляции dev-окружений на NixOS
- **Git config в home-manager** — `user.name`, `user.email`, `signing`, алиасы
- **SSH ключи + agenix** — нормальное управление ключами
- **Docker/Podman** — контейнеры для тестов и стендов

## Важно для Wayland/Hyprland

- **Менеджер уведомлений** — `mako` или `dunst`
- **Менеджер буфера обмена** — `cliphist` + `wl-clipboard`
- **Дефолтные приложения** — xdg-mime (какой браузер, редактор открывать по умолчанию)
- **Шрифты** — JetBrains Mono / Nerd Fonts для терминала и редакторов

## Полезно для разработки

- **Password manager** — Bitwarden (уже есть в nixpkgs)
- **`devShells` в flake** — изолированные окружения под каждый проект
- **Keyring** — `gnome-keyring` или `kwallet` для хранения credentials приложений
