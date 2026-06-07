// 블로그 글 조회·slug·태그·카테고리 유틸
import { getCollection, type CollectionEntry } from 'astro:content';

export type BlogPost = CollectionEntry<'blog'>;

export function resolveSlug(post: BlogPost): string {
  if (post.data.slug) return post.data.slug;
  const parts = post.id.split('/');
  const filename = parts[parts.length - 1];
  return filename.replace(/\.mdx?$/, '');
}

export async function getPublishedPosts(): Promise<BlogPost[]> {
  const posts = await getCollection('blog');
  return posts
    .filter((post) => !post.data.draft)
    .sort((a, b) => b.data.date.valueOf() - a.data.date.valueOf());
}

export function groupPostsByMonth(posts: BlogPost[]): [string, BlogPost[]][] {
  const map = new Map<string, BlogPost[]>();

  for (const post of posts) {
    const date = post.data.date;
    const key = `${date.getFullYear()}년 ${date.getMonth() + 1}월`;
    const group = map.get(key) ?? [];
    group.push(post);
    map.set(key, group);
  }

  return [...map.entries()];
}

export async function getAllTags(): Promise<{ tag: string; count: number }[]> {
  const posts = await getPublishedPosts();
  const counts = new Map<string, number>();

  for (const post of posts) {
    for (const tag of post.data.tags) {
      counts.set(tag, (counts.get(tag) ?? 0) + 1);
    }
  }

  return [...counts.entries()]
    .map(([tag, count]) => ({ tag, count }))
    .sort((a, b) => b.count - a.count || a.tag.localeCompare(b.tag, 'ko'));
}

export async function getAllCategories(): Promise<{ category: string; count: number }[]> {
  const posts = await getPublishedPosts();
  const counts = new Map<string, number>();

  for (const post of posts) {
    const { category } = post.data;
    counts.set(category, (counts.get(category) ?? 0) + 1);
  }

  return [...counts.entries()]
    .map(([category, count]) => ({ category, count }))
    .sort((a, b) => b.count - a.count || a.category.localeCompare(b.category, 'ko'));
}

export function toUrlSlug(value: string): string {
  return value;
}

export function fromUrlSlug(slug: string): string {
  return slug;
}

export function formatDate(date: Date): string {
  return new Intl.DateTimeFormat('ko-KR', {
    year: 'numeric',
    month: 'long',
    day: 'numeric',
  }).format(date);
}

export function getAdjacentPosts(
  posts: BlogPost[],
  current: BlogPost,
): { prev: BlogPost | null; next: BlogPost | null } {
  const index = posts.findIndex((post) => resolveSlug(post) === resolveSlug(current));
  return {
    prev: index > 0 ? posts[index - 1] : null,
    next: index >= 0 && index < posts.length - 1 ? posts[index + 1] : null,
  };
}
