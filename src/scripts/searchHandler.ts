export function initializeSearch() {
	const searchInput = document.getElementById("search-input") as HTMLInputElement;
	let searchTimeout: number;
	let pagefindInstance: any = null;
  
	if (!searchInput) return;
  
	const resultsDropdown = document.createElement("div");
	resultsDropdown.className = "search-results-dropdown";
	resultsDropdown.style.display = "none";
  
	const searchWrapper = searchInput.closest('.search-wrapper');
	searchWrapper?.appendChild(resultsDropdown);

	function clearResults() {
		while (resultsDropdown.firstChild) {
			resultsDropdown.removeChild(resultsDropdown.firstChild);
		}
	}

	function renderNoResults(message: string) {
		clearResults();
		const el = document.createElement("div");
		el.className = "search-no-results";
		el.textContent = message;
		resultsDropdown.appendChild(el);
		resultsDropdown.style.display = "block";
	}

	function safeHref(raw: unknown): string | null {
		if (typeof raw !== "string") return null;
		try {
			const u = new URL(raw, window.location.origin);
			if (u.protocol !== "http:" && u.protocol !== "https:") return null;
			return u.toString();
		} catch {
			return null;
		}
	}
  
	async function loadPagefind() {
		if (pagefindInstance) return pagefindInstance;
		try {
		  const module = await import(
			/* @vite-ignore */
			window.location.origin + '/pagefind/pagefind.js'
		  );
		  await module.init();
		  pagefindInstance = module;
		  return pagefindInstance;
		} catch {
		  console.error('Pagefind not loaded — have you built the site?');
		  return null;
		}
	  }
  
	async function performLiveSearch(query: string) {
	  if (query.length < 2) {
		resultsDropdown.style.display = "none";
		return;
	  }
  
	  const pf = await loadPagefind();
	  if (!pf) {
		renderNoResults("Søgning ikke tilgængelig");
		return;
	  }
  
	  try {
		const search = await pf.search(query);
		const results = await Promise.all(
		  search.results.slice(0, 6).map((r: any) => r.data())
		);
  
		if (results.length === 0) {
		  renderNoResults("Ingen resultater fundet");
		  return;
		}

		clearResults();
		const frag = document.createDocumentFragment();
		for (const result of results) {
			const a = document.createElement("a");
			a.className = "search-result-item";
			a.href = safeHref(result?.url) || "#";

			const content = document.createElement("div");
			content.className = "result-content";

			const title = document.createElement("div");
			title.className = "result-title";
			title.textContent = result?.meta?.title ? String(result.meta.title) : "Untitled";

			const desc = document.createElement("div");
			desc.className = "result-description";
			desc.textContent = result?.excerpt ? String(result.excerpt) : "";

			content.appendChild(title);
			content.appendChild(desc);
			a.appendChild(content);
			frag.appendChild(a);
		}
		resultsDropdown.appendChild(frag);
		resultsDropdown.style.display = "block";
	  } catch (error) {
		console.error("Search error:", error);
	  }
	}
  
	searchInput.addEventListener("input", (e) => {
	  const target = e.target as HTMLInputElement;
	  clearTimeout(searchTimeout);
	  searchTimeout = window.setTimeout(() => {
		performLiveSearch(target.value.trim());
	  }, 300);
	});
  
	document.addEventListener("click", (e) => {
	  if (!searchWrapper?.contains(e.target as Node)) {
		resultsDropdown.style.display = "none";
	  }
	});
  
	searchInput.addEventListener("keydown", (e) => {
	  if (e.key === "Escape") {
		resultsDropdown.style.display = "none";
		searchInput.value = "";
	  }
	});
  }