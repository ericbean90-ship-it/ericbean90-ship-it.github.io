# MyBlog — Claude Code 워크플로

이 저장소(`ericbean90-ship-it.github.io`)는 **Claude Code로 글을 쓰고 배포하는 것**을 기본 워크플로로 합니다.

## 프로젝트

- **스택**: Astro 6 + TypeScript, 정적 사이트 (SSG)
- **배포**: GitHub Pages — https://ericbean90-ship-it.github.io/
- **CI**: `main` push → `.github/workflows/deploy.yml` → `npm run build` → Pages

## 글 추가 (Claude Code에게 시키기)

1. `src/content/blog/YYYY/MM/` 아래 `.md` 파일 생성
2. frontmatter + 마크다운 본문 작성
3. `npm run build` 로 빌드 확인 (필요 시)
4. `git add` → `commit` → `push origin main` → Actions 자동 배포

### frontmatter

```yaml
---
title: "한국어 제목"   # 또는 "한국어 / English Title"
date: 2026-06-07
category: "개발"
tags: ["태그1", "tag2"]
description: "목록·카드용 한 줄 요약"
slug: "url-slug"
draft: false
---
```

- **URL**: `/blog/{slug}/` (월별 폴더 경로는 URL에 안 들어감)
- **draft: true** → 빌드·사이트에서 제외

### 본문 스타일

- **한국어**: 경어체(해요체)
- **영어**: 한국어 본문 아래 `---` 구분 후 영어 섹션 ( **`## English` 헤딩 쓰지 않음** )
- 기존 글(`src/content/blog/`) 톤·구조 참고

### 예시 요청 (오빠 → Claude Code)

```
블로그 글 하나 써서 추가해줘.
주제: …
한국어 경어체 + --- 아래 영어 버전.
커밋하고 push까지 해줘.
```

## 로컬 미리보기

```bash
npm install
npm run dev
```

→ http://localhost:4321 (포트 충돌 시 4322 등 터미널 출력 확인)

## 디렉터리

```
src/content/blog/YYYY/MM/*.md   ← 글
src/pages/                      ← Home, About, Blog, tags, categories
src/lib/blog.ts                 ← slug·태그·카테고리 집계
src/components/ Header, Footer, PostCard
src/layouts/BaseLayout.astro
```

## 배포 확인

- Actions: https://github.com/ericbean90-ship-it/ericbean90-ship-it.github.io/actions
- 반영 후: `https://ericbean90-ship-it.github.io/blog/{slug}/`

## 하지 않는 것

- `dist/` 커밋하지 않음 (Actions가 빌드)
- 5050 Flask 글쓰기 App은 **사용하지 않음** — 글 작성·배포는 Claude Code만
