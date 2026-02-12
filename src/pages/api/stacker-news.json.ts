export const prerender = true;
export async function GET() {
  return new Response(JSON.stringify([]), {
    headers: { "Content-Type": "application/json" },
  });
}
