#!/bin/bash
# GitHub Maintenance Script
# Syncs repos, runs tests, security scans, and dependency checks

LOG_FILE="/home/hijirii/.openclaw/workspace/logs/github-maintenance.log"
REPOS_DIR="/home/hijirii/.openclaw/workspace/repos"
REPORT_DIR="/home/hijirii/.openclaw/workspace/logs"

REPOS=(
  "hijirii/test-terraform-reviewer"
  "hijirii/nero-presentation"
  "charisbit/dtype.info"
  "charisbit/net-rewire"
  "charisbit/presenter"
  "charisbit/researcher"
  "charisbit/terraform-reviewer"
  "charisbit/browser-operator"
  "charisbit/biobot"
)

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

log "========== 开始维护任务 =========="
log "=== 开始同步代码 ==="

# Sync each repo
for repo in "${REPOS[@]}"; do
  repo_name=$(basename "$repo")
  repo_path="$REPOS_DIR/$repo_name"
  
  log "处理仓库: $repo"
  
  if [ -d "$repo_path" ]; then
    cd "$repo_path"
    git pull origin $(git rev-parse --abbrev-ref HEAD) >> "$LOG_FILE" 2>&1
    if [ $? -eq 0 ]; then
      log "完成: $repo_name"
    else
      log "⚠ 更新失败: $repo_name"
    fi
  else
    git clone "https://github.com/$repo.git" "$repo_path" >> "$LOG_FILE" 2>&1
    if [ $? -eq 0 ]; then
      log "完成: $repo_name"
    else
      log "⚠ 克隆失败: $repo_name"
    fi
  fi
done

log "=== 开始回归测试 ==="

# Run tests for repos that have them
for repo_path in "$REPOS_DIR"/*; do
  repo_name=$(basename "$repo_path")
  
  if [ -f "$repo_path/Makefile" ]; then
    log "回归测试: $repo_name (make test)..."
    cd "$repo_path"
    if make test >> "$LOG_FILE" 2>&1; then
      log "✓ Makefile 测试通过: $repo_name"
    else
      log "✗ Makefile 测试失败: $repo_name"
    fi
  elif [ -f "$repo_path/pytest.ini" ] || [ -f "$repo_path/setup.py" ] || [ -d "$repo_path/tests" ]; then
    log "回归测试: $repo_name (pytest)..."
    cd "$repo_path"
    if python3 -m pytest >> "$LOG_FILE" 2>&1; then
      log "✓ Pytest 通过: $repo_name"
    else
      log "✗ Pytest 失败: $repo_name"
    fi
  else
    log "⚠ 跳过 $repo_name（无 tests/ 目录或需要额外依赖）"
  fi
done

log "=== 安全扫描 ==="
cd "$REPOS_DIR"
if [ -f "package-lock.json" ]; then
  npm audit >> "$LOG_FILE" 2>&1 || log "⚠ npm audit 完成（见上方输出）"
fi

log "=== 依赖更新检查 ==="
cd "$REPOS_DIR"
for repo_path in "$REPOS_DIR"/*; do
  repo_name=$(basename "$repo_path}")
  
  if [ -f "$repo_path/package.json" ] && [ -f "$repo_path/package-lock.json" ]; then
    if npm outdated "$repo_name" >> "$LOG_FILE" 2>&1; then
      :
    fi
  fi
done

# Generate simple report
REPORT_FILE="$REPORT_DIR/maintenance-report-$(date '+%Y%m%d').txt"
log "报告已生成: $REPORT_FILE"
echo "GitHub Maintenance Report - $(date)" > "$REPORT_FILE"
echo "================================" >> "$REPORT_FILE"

log "========== 维护任务完成 =========="
