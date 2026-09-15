#!/bin/zsh
# Claude Code 호출 → 블로그 글 작성 + 배포

export PATH="/Users/igyudong/claude/.local/bin:/opt/homebrew/bin:/usr/local/bin:$PATH"

cd /Users/igyudong/claude/QsCursorRoot/cursorstudy/blog

PROMPT=$(cat /tmp/myblog-prompt.txt)

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  내블로그 — Claude가 글을 씁니다"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

claude --dangerously-skip-permissions -p "$PROMPT"

if [[ $? -eq 0 ]]; then
  echo ""
  echo "✅ 배포 완료!"
  osascript -e 'display notification "배포 완료! 블로그에서 확인하세요." with title "내블로그"'
else
  echo ""
  echo "❌ 오류 발생"
  osascript -e 'display notification "오류가 발생했습니다. 터미널을 확인하세요." with title "내블로그"'
fi
