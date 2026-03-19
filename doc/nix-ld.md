# nix-ld — поддержка сторонних динамических бинарников

## Проблема

NixOS использует нестандартные пути к dynamic linker (интерпретатору ELF-бинарников).
Обычные Linux-программы, скомпилированные под generic glibc, прописывают внутри себя путь вида:

```
/lib64/ld-linux-x86-64.so.2
```

Этого пути в NixOS не существует, поэтому при запуске такого бинарника ОС выдаёт ошибку:

```
Could not start dynamically linked executable: ...
NixOS cannot run dynamically linked executables intended for generic linux environments out of the box.
```

## Как это проявилось

Zed Editor автоматически скачивает агентов (Codex, Gemini и др.) как pre-built бинарники под generic Linux.
При попытке запустить `codex-acp` Zed получал ошибку запуска → "server shut down unexpectedly" / "error loading codex".

Сам бинарник лежит по пути:
```
~/.local/share/zed/external_agents/codex/v<версия>/codex-acp
```

## Решение

Включён `nix-ld` — он создаёт stub dynamic linker по стандартным путям (`/lib64/ld-linux-x86-64.so.2`),
который перенаправляет запросы к настоящему линкеру из nix store.

```nix
programs.nix-ld.enable = true;
```

## Когда это нужно

Всегда, когда нужно запустить бинарник, скачанный не через nix:
- агенты и расширения редакторов (Zed, VSCode extensions)
- проприетарные CLI-утилиты
- pre-built бинарники из интернета (без исходников)

Альтернативы (не используем):
- `patchelf` — ручной патч бинарника, слетает при обновлениях
- `steam-run` — FHS-окружение, не подходит для автозапускаемых процессов

## Проверка

Убедиться, что бинарник запускается:

```bash
~/.local/share/zed/external_agents/codex/v<версия>/codex-acp --help
```

Если бинарник выводит usage (даже с ошибкой про аргументы) — линкер работает.
Если `No such file or directory` при наличии самого файла — nix-ld не включён или не применён (`nixos-rebuild switch`).

## Применение

После изменения конфига требуется:

```bash
sudo nixos-rebuild switch
```

Перезагрузка не нужна — достаточно `switch`. После этого Zed подхватывает агента без перезапуска.
