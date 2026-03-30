# TOOLS.md - Local Notes

Skills define _how_ tools work. This file is for _your_ specifics — the stuff that's unique to your setup.

## What Goes Here

Things like:

- Camera names and locations
- SSH hosts and aliases
- Preferred voices for TTS
- Speaker/room names
- Device nicknames
- Anything environment-specific

## Examples

```markdown
### Cameras

- living-room → Main area, 180° wide angle
- front-door → Entrance, motion-triggered

### SSH

- home-server → 192.168.1.100, user: admin

### TTS

- Preferred voice: "Nova" (warm, slightly British)
- Default speaker: Kitchen HomePod
```

## Why Separate?

Skills are shared. Your setup is yours. Keeping them apart means you can update skills without losing your notes, and share skills without leaking your infrastructure.

---

## 🔧 Browser Automation (agent-browser)

当使用 `~/.cargo/bin/agent-browser` 连接 Chrome 时：
- **协议**: CDP (Chrome DevTools Protocol)
- **端口**: 9222
- **连接方式**: `agent-browser connect 9222`
- **前提**: Chrome 需以 `--remote-debugging-port=9222` 启动

**常用命令**:
```bash
~/.cargo/bin/agent-browser connect 9222
~/.cargo/bin/agent-browser open "https://..."
~/.cargo/bin/agent-browser screenshot /path/to/save.png
~/.cargo/bin/agent-browser click <ref>
~/.cargo/bin/agent-browser snapshot  # 查看页面结构
~/.cargo/bin/agent-browser press Control+t  # 新标签
```

---

## 🔍 Web Search 优先级

**重要**: web_search 被检测为机器人失败率高。正确顺序：

1. **优先**: curl/API（arXiv、GitHub API 等）
2. **其次**: agent-browser + Chrome（用于搜索）
3. **最后**: web_search（仅作为最后备选）

### agent-browser 命令
```bash
~/.cargo/bin/agent-browser connect 9222
~/.cargo/bin/agent-browser open "https://duckduckgo.com/?q=搜索内容"
sleep 4
~/.cargo/bin/agent-browser screenshot /tmp/result.png
```

Add whatever helps you do your job. This is your cheat sheet.
