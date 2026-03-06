exports.handler = async function (event) {
  if (event.httpMethod !== "POST") {
    return { statusCode: 405, body: "Method Not Allowed" };
  }

  const token = process.env.GH_ISSUES_TOKEN;
  if (!token) {
    return { statusCode: 500, body: "Token not configured" };
  }

  let payload;
  try {
    payload = JSON.parse(event.body);
  } catch {
    return { statusCode: 400, body: "Invalid JSON" };
  }

  const res = await fetch("https://api.github.com/repos/Mannohat/enogtyve-web/issues", {
    method: "POST",
    headers: {
      "Authorization": "Bearer " + token,
      "Content-Type": "application/json",
      "Accept": "application/vnd.github+json",
    },
    body: JSON.stringify(payload),
  });

  return {
    statusCode: res.ok ? 200 : res.status,
    body: res.ok ? "ok" : "error",
  };
};
