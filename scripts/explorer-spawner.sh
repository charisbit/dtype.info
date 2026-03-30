#!/bin/bash
# Explorer spawner - runs every 5 minutes via cron
# Creates a new explorer agent session with a rotating theme

THEMES=("量子计算最新进展" "人工智能技术突破" "日本科技新闻" "开源社区动态" "编程语言趋势" "机器人技术发展" "生物科技前沿" "太空探索新闻" "网络安全动态" "经济学市场趋势" "哲学思想内容" "基督教神学深度文章")

# Get minute-based index (0-11)
MINUTE=$(date +%M)
INDEX=$((MINUTE / 5 % 12))
THEME="${THEMES[$INDEX]}"

# Generate session ID based on time
SESSION_ID=$(date +%Y%m%d%H%M)

echo "[Explorer-Spawner] $(date) | Theme: $THEME | Session: $SESSION_ID"

# Use sessions_spawn via openclaw CLI
openclaw sessions spawn \
  --label "explorer-$SESSION_ID" \
  --runtime subagent \
  --task "Explorer task - theme: $THEME. Execute this: ~/.cargo/bin/agent-browser connect 9222 && ~/.cargo/bin/agent-browser open 'https://duckduckgo.com/?q=$(echo $THEME | sed 's/ /+/g')' && sleep 4 && ~/.cargo/bin/agent-browser screenshot /tmp/explore-$SESSION_ID.png && echo 'Done' && ls /tmp/explore-$SESSION_ID.png" \
  2>&1 | head -10

echo "[Explorer-Spawner] Done spawning explorer-$SESSION_ID for theme: $THEME"