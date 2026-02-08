export function initializeSearch() {
	const searchInput = document.getElementById("search-input") as HTMLInputElement;
	let searchTimeout: number;

	if (!searchInput) return;

	// Create results dropdown
	const resultsDropdown = document.createElement("div");
	resultsDropdown.className = "search-results-dropdown";
	resultsDropdown.style.display = "none";
	
	const searchWrapper = searchInput.closest('.search-wrapper');
	searchWrapper?.appendChild(resultsDropdown);

	async function performLiveSearch(query: string) {
		if (query.length < 2) {
			resultsDropdown.style.display = "none";
			return;
		}
		
		console.log('Searching for:', query); // ADD THIS LINE

		try {
			const response = await fetch(
				`/api/search.json?q=${encodeURIComponent(query)}&lang=da`,
			);
			const data = await response.json();

			if (data.results.length === 0) {
				resultsDropdown.innerHTML =
					'<div class="search-no-results">Ingen resultater fundet</div>';
				resultsDropdown.style.display = "block";
				return;
			}

			const typeLabels: Record<string, string> = {
				blog: "Blog",
				video: "Video",
				podcast: "Podcast",
				resource: "Ressource",
				deal: "Rabat",
			};

			const resultsHTML = data.results
				.slice(0, 6)
				.map(
					(result: any) => `
				<a href="${result.url}" class="search-result-item">
					<span class="result-tag">${typeLabels[result.type] || "Indhold"}</span>
					<div class="result-content">
						<div class="result-title">${result.title}</div>
						<div class="result-description">${result.description.substring(0, 80)}...</div>
					</div>
				</a>
			`,
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
