# flake.nix — структура и решения

## Зачем flake

`flake.nix` — точка входа конфига. Фиксирует все зависимости в `flake.lock`,
делает конфиг воспроизводимым: одинаковый `nixpkgs`, одинаковые пакеты на любой машине.

## Inputs

```nix
nixpkgs        # основной источник пакетов, ветка nixos-unstable
home-manager   # управление юзерским окружением (dotfiles, программы)
zen-browser    # браузер, не в nixpkgs — подключён как отдельный flake
noctalia       # кастомный шелл-скрипт, внешний flake
noctalia-qs    # quick-start утилита от noctalia
```

Все inputs, которые сами тянут nixpkgs, переопределяются через `inputs.nixpkgs.follows = "nixpkgs"` —
чтобы не тащить несколько версий nixpkgs и не раздувать `/nix/store`.

## Outputs

Один хост: `nixosConfigurations.nixos`. Содержит:
- `./configuration.nix` — системный конфиг
- `home-manager.nixosModules.home-manager` — интеграция HM как NixOS-модуля
- inline-конфиг HM: `useGlobalPkgs`, `useUserPackages`, точка входа `./modules/home`

### useGlobalPkgs и useUserPackages

| Опция | Что делает |
|---|---|
| `useGlobalPkgs = true` | HM использует тот же `pkgs` что и система, не создаёт свой |
| `useUserPackages = true` | пакеты из `home.packages` ставятся в профиль юзера, а не в HM-профиль |

Оба рекомендуется включать при NixOS-интеграции.

## specialArgs

```nix
specialArgs = { inherit inputs; };
```

Пробрасывает `inputs` во все модули — нужно чтобы в `configuration.nix` можно было обращаться
к пакетам из внешних flake (например `inputs.zen-browser.packages.*.default`).

## Обновление lock-файла

```bash
# обновить все inputs
sudo nix flake update

# обновить конкретный input
sudo nix flake update home-manager
```

Обязательно от `sudo` — `/etc/nixos/.git` принадлежит root.
