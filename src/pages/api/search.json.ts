import type { APIRoute } from 'astro';
import { getCollection } from 'astro:content';

export const GET: APIRoute = async ({ url }) => {
  const query = url.searchParams.get('q') || '';
  const lang = url.searchParams.get('lang') || 'da';

  try {
    const allBlogPosts = await getCollection('blog');
    const blogPosts = allBlogPosts.filter(post => post.id.startsWith(`${lang}/`));
    
    const searchQuery = query.toLowerCase();
    const results = blogPosts
      .filter(post => {
        const title = post.data.title.toLowerCase();
        const description = post.data.description.toLowerCase();
        return title.includes(searchQuery) || description.includes(searchQuery);
      })
      .map(post => ({
        type: 'blog',
        title: post.data.title,
        description: post.data.description,
        slug: post.slug,
        url: `/${lang}/blog/${post.slug.replace(`${lang}/`, '')}`
      }));

    return new Response(JSON.stringify({ 
      results, 
      debugUrl: {
        href: url.href,
        search: url.search,
        searchParams: Array.from(url.searchParams.entries())
      },
      query,
      lang
    }), {
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