exports.handler = async function () {
  try {
    const res = await fetch("https://stacker.news/api/graphql", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        query: `{ items(sub: "bitcoin", limit: 4) {
          items { id title url createdAt user { name } }
        } }`,
      }),
    });
    if (!res.ok) throw new Error(`GraphQL ${res.status}`);
    const json = await res.json();
    const items = json?.data?.items?.items;
    if (!Array.isArray(items)) throw new Error("unexpected payload");
    const posts = items.map((item) => ({
      title: item.title || "",
      link: item.url || `https://stacker.news/items/${item.id}`,
      pubDate: item.createdAt || "",
      author: item.user?.name || "",
    }));
    return {
      statusCode: 200,
      headers: {
        "Content-Type": "application/json",
        "Cache-Control": "public, max-age=300",
      },
      body: JSON.stringify(posts),
    };
  } catch (e) {
    return {
      statusCode: 500,
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify([]),
    };
  }
};
