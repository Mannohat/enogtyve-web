export default async (req) => {
    try {
      const res = await fetch("https://stacker.news/~bitcoin/rss");
      const xml = await res.text();
      const items = [...xml.matchAll(/<item>([\s\S]*?)<\/item>/g)];
      const posts = items.slice(0, 4).map((match) => {
        const title = (match[1].match(/<title>(.*?)<\/title>/) || [])[1] || "";
        const link = (match[1].match(/<guid>(.*?)<\/guid>/) || [])[1] || "#";
        const pubDate = (match[1].match(/<pubDate>(.*?)<\/pubDate>/) || [])[1] || "";
        const author = (match[1].match(/<atom:name>(.*?)<\/atom:name>/) || [])[1] || "";
        return { title, link, pubDate, author };
      });
      return new Response(JSON.stringify(posts), {
        headers: { "Content-Type": "application/json", "Cache-Control": "public, max-age=300" },
      });
    } catch (e) {
      return new Response(JSON.stringify([]), { status: 500, headers: { "Content-Type": "application/json" } });
    }
  };