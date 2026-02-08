import type { APIRoute } from 'astro';
import { getCollection } from 'astro:content';

export const prerender = false;

async function safeGetCollection(name: string) {
  try {
    return await getCollection(name as any);
  } catch {
    return [];
  }
}

export const GET: APIRoute = async ({ url }) => {
  const query = url.searchParams.get('q') || '';
  const lang = url.searchParams.get('lang') || 'da';

  if (query.trim().length < 2) {
    return new Response(JSON.stringify({ results: [], query, lang }), {
      status: 200,
      headers: { 'Content-Type': 'application/json' }
    });
  }

  try {
    const searchQuery = query.toLowerCase();

    const [blogPosts, videos, podcasts, resources, deals] = await Promise.all([
      getCollection('blog'),
      safeGetCollection('videos'),
      safeGetCollection('podcasts'),
      safeGetCollection('resources'),
      safeGetCollection('deals'),
    ]);

    const matchText = (text: string | undefined) =>
      text ? text.toLowerCase().includes(searchQuery) : false;
    const stripLang = (slug: string) => slug.replace(`${lang}/`, '');

    const results = [
      ...blogPosts
        .filter(post => post.data.language === lang)
        .filter(post =>
          matchText(post.data.title) ||
          matchText(post.data.description) ||
          matchText(post.data.author) ||
          matchText(post.data.tags?.join(' ')) ||
          matchText(post.body)
        )
        .map(post => ({
          type: 'blog',
          title: post.data.title,
          description: post.data.description,
          url: `/${lang}/blog/${stripLang(post.slug)}`,
        })),

      ...(videos as any[])
        .filter(v => v.data.language === lang)
        .filter(v =>
          matchText(v.data.title) ||
          matchText(v.data.description) ||
          matchText(v.data.tags?.join(' ')) ||
          matchText(v.body)
        )
        .map(v => ({
          type: 'video',
          title: v.data.title,
          description: v.data.description,
          url: `/${lang}/videos/${stripLang(v.slug)}`,
        })),

      ...(podcasts as any[])
        .filter(p => p.data.language === lang)
        .filter(p =>
          matchText(p.data.title) ||
          matchText(p.data.description) ||
          matchText(p.data.tags?.join(' ')) ||
          matchText(p.body)
        )
        .map(p => ({
          type: 'podcast',
          title: p.data.title,
          description: p.data.description,
          url: `/${lang}/podcasts/${stripLang(p.slug)}`,
        })),

      ...(resources as any[])
        .filter(r => r.data.language === lang)
        .filter(r =>
          matchText(r.data.title) ||
          matchText(r.data.description) ||
          matchText(r.data.tags?.join(' ')) ||
          matchText(r.body)
        )
        .map(r => ({
          type: 'resource',
          title: r.data.title,
          description: r.data.description,
          url: `/${lang}/resources/${stripLang(r.slug)}`,
        })),

      ...(deals as any[])
        .filter(d => d.data.language === lang)
        .filter(d =>
          matchText(d.data.companyName) ||
          matchText(d.data.description) ||
          matchText(d.body)
        )
        .map(d => ({
          type: 'deal',
          title: d.data.companyName,
          description: d.data.description,
          url: `/${lang}/deals/${stripLang(d.slug)}`,
        })),
    ];

    return new Response(JSON.stringify({ results, query, lang }), {
      status: 200,
      headers: { 'Content-Type': 'application/json' }
    });
  } catch (error) {
    return new Response(JSON.stringify({ results: [], error: String(error) }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' }
    });
  }
};