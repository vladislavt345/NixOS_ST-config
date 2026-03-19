# Home Manager — управление юзерским окружением

## Зачем

NixOS управляет системой (сервисы, ядро, системные пакеты).
Home Manager управляет **пользовательским окружением**: dotfiles, программы, переменные среды.

Без HM dotfiles либо хардкодятся через `environment.etc` + `systemd.tmpfiles` (костыль),
либо живут вне nix и не воспроизводимы.

## Как подключён

Через NixOS-модуль в `flake.nix` — HM применяется вместе с `nixos-rebuild switch`,
отдельная команда `home-manager switch` не нужна.

```nix
home-manager.nixosModules.home-manager
{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.stryer = import ./modules/home;
}
```

## Структура

```
modules/home/
├── default.nix        # точка входа: импорты, home.username, stateVersion
└── features/
    ├── hyprland/      # конфиг wm через xdg.configFile
    ├── kitty/         # конфиг терминала
    ├── waybar/        # конфиг бара
    └── zsh/           # конфиг шелла через programs.zsh
```

## Ключевые опции

### Dotfiles
```nix
xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
```
Кладёт файл в `~/.config/hypr/hyprland.conf`. Управляется nix, при `nixos-rebuild` обновляется.

### Программы
```nix
programs.zsh = {
  enable = true;
  oh-my-zsh.enable = true;
  plugins = [ ... ];
};
```
HM сам генерирует `.zshrc` — не нужно писать его руками.

### Пакеты
```nix
home.packages = [ pkgs.hyprpaper pkgs.bibata-cursors ];
```
Пакеты только для этого юзера, не попадают в системный профиль.

## Важно: system vs home

Некоторые вещи **обязаны** быть на системном уровне:

| Системный (`configuration.nix`) | Домашний (`modules/home/`) |
|---|---|
| `programs.zsh.enable = true` | `programs.zsh` плагины, oh-my-zsh |
| `users.users.stryer.shell = pkgs.zsh` | `.zshrc`, алиасы, env |
| `programs.hyprland.enable = true` | конфиг `hyprland.conf` |
| `programs.niri.enable = true` | конфиг `config.kdl` |

`programs.zsh.enable = true` на системном уровне нужен чтобы создался `/etc/zshenv` —
без него zsh не подхватывает Nix-окружение при логине.

## stateVersion

```nix
home.stateVersion = "25.05";
```

Зафиксирован при первом подключении HM. **Не менять** — отвечает за совместимость
форматов данных приложений, не за версию пакетов.

## Применение

```bash
sudo nixos-rebuild switch
```

HM применяется автоматически вместе с системой.
