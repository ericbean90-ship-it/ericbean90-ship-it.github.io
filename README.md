# Blog (Astro + GitHub Pages)

Node(Astro)로 만든 정적 블로그예요. 마크다운으로 글을 쓰고 GitHub Pages 루트(`username.github.io`)에 배포합니다.

## 기능

- **Home / About / Blog** 메뉴
- 글 파일 **월별 폴더** (`src/content/blog/YYYY/MM/`)
- URL은 **`/blog/{slug}/`** (폴더 월 정보와 분리)
- frontmatter **category**, **tags** → 분류 페이지
- GitHub Actions로 Pages 자동 배포

## 로컬 실행

```bash
cd blog
npm install
npm run dev
```

빌드:

```bash
npm run build
npm run preview
```

## 글 작성

`src/content/blog/2025/06/파일명.md`:

```yaml
---
title: "글 제목"
date: 2025-06-07
category: "개발"
tags: ["Node", "Astro"]
description: "한 줄 요약"
slug: "원하는-url"   # 선택. 없으면 파일명 사용
draft: false
---
```

## GitHub Pages 배포

1. GitHub에 **`username.github.io`** 저장소 생성
2. 이 `blog/` 폴더 내용을 저장소 **루트**에 push
3. Repo → Settings → Pages → Source: **GitHub Actions**
4. `main` push 시 `.github/workflows/deploy.yml`이 빌드·배포

`astro.config.mjs`의 `site` URL을 본인 `https://username.github.io`로 바꿔 주세요.

## 구조

```
src/
  content/blog/YYYY/MM/*.md
  pages/           # Home, About, Blog, tags, categories
  components/
  layouts/
  lib/blog.ts      # slug, 태그·카테고리 집계
```
