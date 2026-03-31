# OpenClaw 权限笔记

## 重要：.openclaw 目录权限

`.openclaw` 目录如果设为 700，会导致 nginx 的 www-data 用户无法穿过目录读取子文件夹（如博客）。

**现象**：访问 hijirii.tail10e651.ts.net:4000 返回 404，error.log 显示 `Permission denied`

**修复**：
```bash
chmod 755 /home/hijirii/.openclaw
```

**何时检查**：每次 `openclaw update` 或 gateway 重启后，确认权限仍然正常。
