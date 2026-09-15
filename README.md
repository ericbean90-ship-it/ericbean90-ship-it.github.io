# MyBlog (Astro + GitHub Pages)

Node(Astro) 정적 블로그. **글 작성·배포는 [Claude Code](./CLAUDE.md) 워크플로**를 사용합니다.

- **사이트**: https://ericbean90-ship-it.github.io/
- **저장소**: `ericbean90-ship-it/ericbean90-ship-it.github.io`

## Claude Code로 글 쓰기 (기본)

저장소 루트에서 Claude Code 실행 후 예:

```
블로그 글 추가해줘. 주제: …
한국어(경어체) + --- 아래 영어. 커밋·push까지.
```

자세한 규칙: **[CLAUDE.md](./CLAUDE.md)**

## 로컬 미리보기

```bash
npm install
npm run dev
```

## 수동 배포 (Claude Code 없을 때)

```bash
git add .
git commit -m "글 게시: 제목"
git push origin main
```

`main` push → GitHub Actions → Pages 배포 (1~2분)

## 기능

- Home / About / Blog
- 월별 폴더 `src/content/blog/YYYY/MM/`, URL `/blog/{slug}/`
- tags · categories 분류 페이지
- DM Sans + Noto Serif KR, Shiki 코드 하이라이트

## 글 형식

`src/content/blog/2026/06/example.md`:

```yaml
---
title: "제목"
date: 2026-06-07
category: "개발"
tags: ["태그"]
description: "한 줄 요약"
slug: "example"
draft: false
---
```

## 구조

```
src/
  content/blog/YYYY/MM/*.md
  pages/
  components/
  layouts/
  lib/blog.ts
```
