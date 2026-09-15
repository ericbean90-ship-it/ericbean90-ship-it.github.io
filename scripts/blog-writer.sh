#!/bin/zsh
# 블로그 글쓰기 다이얼로그 → Claude Code 배포 실행

TITLE=$(osascript <<'APPLESCRIPT'
tell application "System Events" to activate
text returned of (display dialog "블로그 제목:" default answer "" with title "내블로그" buttons {"취소", "다음"} default button 2)
APPLESCRIPT
)

[[ $? -ne 0 || -z "$TITLE" ]] && exit 0

CONTENT=$(osascript <<'APPLESCRIPT'
tell application "System Events" to activate
text returned of (display dialog "내용 메모 (간단하게 써도 됩니다):" default answer "" with title "내블로그" buttons {"취소", "발행"} default button 2)
APPLESCRIPT
)

[[ $? -ne 0 || -z "$CONTENT" ]] && exit 0

cat > /tmp/myblog-prompt.txt <<PROMPT
다음 메모를 바탕으로 블로그 글을 작성해서 추가하고 커밋 후 푸시해줘.

제목: ${TITLE}
내용 메모: ${CONTENT}

규칙:
- 기존 블로그 글 스타일 참고 (src/content/blog/2026/06/ 의 글들)
- 한글 본문 먼저, --- 구분선 후 영어 번역
- 파일 위치: src/content/blog/2026/06/
- slug: 영어 케밥케이스 (파일명 = slug)
- draft: false
- 커밋 메시지: "Add blog post: ${TITLE}"
- 커밋 후 git push origin main
PROMPT

osascript -e 'display notification "Claude가 글을 작성하고 배포합니다..." with title "내블로그"'

osascript <<'APPLESCRIPT'
tell application "Terminal"
  activate
  do script "/Users/igyudong/claude/QsCursorRoot/cursorstudy/blog/scripts/blog-deploy.sh"
end tell
APPLESCRIPT
