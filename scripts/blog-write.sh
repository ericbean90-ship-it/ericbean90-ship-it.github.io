#!/bin/zsh
# 내블로그 — Terminal 입력 + Claude 배포

export PATH="/Users/igyudong/claude/.local/bin:/opt/homebrew/bin:/usr/local/bin:$PATH"
cd /Users/igyudong/claude/QsCursorRoot/cursorstudy/blog

clear
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "         내블로그 — 새 글 쓰기"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
printf "제목: "
read TITLE

if [[ -z "$TITLE" ]]; then
  echo "제목이 없습니다. 종료합니다."
  exit 1
fi

echo ""
echo "내용 메모를 입력하세요."
echo "  (여러 줄 가능 — 빈 줄 입력하면 완료)"
echo ""

CONTENT=""
while IFS= read -r line; do
  [[ -z "$line" ]] && break
  CONTENT="${CONTENT}${line}\n"
done

if [[ -z "$CONTENT" ]]; then
  echo "내용이 없습니다. 종료합니다."
  exit 1
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Claude가 글을 작성하고 배포합니다..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

PROMPT="다음 메모를 바탕으로 블로그 글을 작성해서 추가하고 커밋 후 푸시해줘.

제목: ${TITLE}
내용 메모: ${CONTENT}

규칙:
- 기존 블로그 글 스타일 참고 (src/content/blog/2026/06/ 의 글들)
- 한글 본문 먼저, --- 구분선 후 영어 번역
- 파일 위치: src/content/blog/2026/06/
- slug: 영어 케밥케이스 (파일명 = slug)
- draft: false
- 커밋 메시지: Add blog post: ${TITLE}
- 커밋 후 git push origin main"

claude --dangerously-skip-permissions -p "$PROMPT"

if [[ $? -eq 0 ]]; then
  echo ""
  echo "✅ 배포 완료!"
  osascript -e 'display notification "배포 완료! 블로그에서 확인하세요." with title "내블로그"'
else
  echo ""
  echo "❌ 오류 발생. 위 메시지를 확인하세요."
fi
