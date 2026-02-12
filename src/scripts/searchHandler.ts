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
		resultsDropdown.innerHTML =
		  '<div class="search-no-results">Søgning ikke tilgængelig</div>';
		resultsDropdown.style.display = "block";
		return;
	  }
  
	  try {
		const search = await pf.search(query);
		const results = await Promise.all(
		  search.results.slice(0, 6).map((r: any) => r.data())
		);
  
		if (results.length === 0) {
		  resultsDropdown.innerHTML =
			'<div class="search-no-results">Ingen resultater fundet</div>';
		  resultsDropdown.style.display = "block";
		  return;
		}
  
		const resultsHTML = results
		  .map(
			(result: any) => `
			<a href="${result.url}" class="search-result-item">
			  <div class="result-content">
				<div class="result-title">${result.meta?.title || 'Untitled'}</div>
				<div class="result-description">${result.excerpt || ''}</div>
			  </div>
			</a>
		  `
		  )
		  .join("");
  
		resultsDropdown.innerHTML = resultsHTML;
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