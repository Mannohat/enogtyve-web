#!/bin/bash

# Refactor index.astro into components
# This script creates the component structure and moves code into separate files

echo "Starting refactor..."

# Create directory structure
mkdir -p components/home
mkdir -p scripts

echo "Created directory structure"

# 1. Create HeroSection component
cat > components/home/HeroSection.astro << 'EOF'
---
const { lang } = Astro.props;
---

<section class="hero">
	<h1>VELKOMMEN TIL ENOGTYVE</h1>
	<p class="subtitle">
		Dansk Bitcoin Fællesskab
	</p>
	<p class="hero-description">
		Formålet med Enogtyve.org er at skabe en platform for danskere med interesse for Bitcoin, hvor alle er velkomne til at bidrage, dele viden og lære. Hjemmesiden vil løbende blive opdateret med relevant Bitcoin-indhold på dansk.
	</p>

	<div class="hero-buttons">
		<a href={`/${lang}/blog/penges-historie`} class="hero-btn">Hvad er penge?</a>
		<a href={`/${lang}/blog/hvad-er-bitcoin`} class="hero-btn">Hvad er Bitcoin?</a>
	</div>

	<div class="search-wrapper">
		<div class="search-box">
			<input
				type="search"
				placeholder="Søg efter indhold på siden her..."
				id="search-input"
				autocomplete="off"
			/>
			<button type="button">Søg</button>
		</div>
	</div>
</section>

<style>
	.hero {
		text-align: center;
		padding: clamp(2rem, 5vh, 3rem) 0 clamp(1.5rem, 4vh, 2.5rem);
		display: flex;
		flex-direction: column;
		justify-content: center;
	}

	.hero h1 {
		font-size: clamp(2rem, 6vw, 3.5rem);
		color: var(--primary);
		margin-bottom: 0.75rem;
		font-weight: 700;
		letter-spacing: -0.02em;
	}

	.subtitle {
		font-size: clamp(1.1rem, 2.5vw, 1.5rem);
		color: var(--text-light);
		margin-bottom: 1.25rem;
		font-weight: 300;
	}

	.hero-description {
		max-width: 700px;
		margin: 0 auto 1.75rem;
		padding: 0 1rem;
		font-size: clamp(0.95rem, 2vw, 1.05rem);
		line-height: 1.6;
		color: var(--text-light);
		font-weight: 400;
	}

	.hero-buttons {
		display: flex;
		gap: 1rem;
		justify-content: center;
		flex-wrap: wrap;
		max-width: 600px;
		margin: 0 auto 2rem;
		padding: 0 1rem;
	}

	.hero-btn {
		padding: 0.75rem 1.5rem;
		border-radius: 8px;
		font-weight: 600;
		font-size: 0.95rem;
		cursor: pointer;
		transition: all 0.3s ease;
		border: 2px solid;
		text-decoration: none;
		display: inline-block;
		background: rgba(247, 147, 26, 0.1);
		color: var(--text);
		border-color: rgba(247, 147, 26, 0.3);
	}

	.hero-btn:hover {
		background: rgba(247, 147, 26, 0.2);
		border-color: var(--primary);
		transform: translateY(-2px);
		box-shadow: 0 4px 12px rgba(247, 147, 26, 0.2);
	}

	.search-wrapper {
		max-width: 600px;
		margin: 0 auto;
		position: relative;
		width: 100%;
		padding: 0 1rem;
	}

	@media (max-width: 767px) {
		.hero-buttons {
			flex-direction: column;
			align-items: stretch;
		}

		.hero-btn {
			width: 100%;
		}
	}
</style>
EOF

echo "Created HeroSection.astro"

# 2. Create IntroAccordion component
cat > components/home/IntroAccordion.astro << 'EOF'
<section class="introduction-unified">
	<div class="intro-container">
		<h2>Om Bitcoin</h2>
		
		<div class="intro-accordion">
			<div class="accordion-item special-intro">
				<button class="accordion-header-clickable" id="intro-header">
					<span class="accordion-title">Introduktion</span>
					<span class="accordion-icon">▼</span>
				</button>
				<div class="accordion-content-static" id="intro-content">
					<p>Bitcoin er et netværk, som er vokset til i dag at være det sikreste decentraliserede computernetværk i verden. Netværket har et indbygget aktiv, som kaldes bitcoin. Én bitcoin (BTC) består af 100.000.000 satoshi (sats) – lidt ligesom vi har 100 øre til én dansk krone. Man kan derfor eje en brøkdel af en bitcoin, helt ned til 1/100.000.000 af 1 BTC.</p>
					
					<div class="expandable-content" id="intro-expandable">
						<p>Bitcoin er ikke en virksomhed, og Bitcoin har ingen direktør. Ligesom fysisk guld behøver man altså ikke at stole på nogen, hvis man ejer satoshis og opbevarer dem korrekt i egen varetægt. I sektionen med vejledninger kan du læse mere om, hvordan du bør opbevare bitcoin.</p>
						
						<p>Bitcoin er aldrig blevet hacket. Hvis folk har mistet bitcoin, er det altså ikke Bitcoin, der ikke har fungeret efter hensigten, men derimod brugeren, som har begået en fejl, eller en tredjepart – for eksempel en onlinebørs – som har haft en sårbarhed eller måske slet ikke har haft de bitcoin, de har solgt til deres brugere. Det kan sammenlignes med at sælge guld til sin nabo, men i stedet for at give guldet udlevere en seddel, hvorpå der står, at guldet kan indløses senere. Denne konstellation ender oftest i det, der kaldes fraktioneret reserve, hvor mængden af guld eller bitcoin i forhold til udstedte gældsbeviser bliver mindre og mindre over tid – med andre ord et svindelnummer.</p>
						
						<p>Bitcoin kan være komplekst at forstå. Én ting er at forstå, hvordan det teknisk fungerer; noget andet er at forstå, hvad der ligger forud for Bitcoins tilblivelse, hvilke problemer Bitcoin løser, samt hvilket potentiale og hvilken indflydelse Bitcoin har på verden som helhed – både nu og i fremtiden.</p>
					</div>
					
					<button class="expand-btn" id="intro-expand-btn">
						<span class="btn-text">Læs mere</span>
						<span class="btn-icon">▼</span>
					</button>
				</div>
			</div>

			<div class="accordion-item">
				<button class="accordion-header" data-target="intro-2">
					<span class="accordion-title">Bitcoin, ikke krypto</span>
					<span class="accordion-icon">▼</span>
				</button>
				<div class="accordion-content" id="intro-2">
					<p>Du har måske hørt folk og medier tale om "krypto" og bitcoin, som om det var én og samme ting. Det er det ikke. Der er Bitcoin, og så er der en lang række kryptoprojekter, hvoraf mange er fup og fidus. Bitcoin er en kryptovaluta, men ingen andre kryptovalutaer er bitcoin.</p>
					
					<p>Bitcoin adskiller sig på flere afgørende måder, og uden at gå dybere i detaljer i denne introduktion kan det kort siges, at Bitcoin er den eneste, som med sin Proof of Work (PoW)-konsensusmekanisme har en dimension, der forbinder den digitale verden med den fysiske. Har du hørt om bitcoin mining, er det netop relateret til dette, og heri ligger også forklaringen på, hvorfor bitcoin ofte kaldes digitalt guld.</p>
					
					<p>Der vil til evig tid aldrig eksistere mere end 21 millioner bitcoin – deraf også navnet på denne hjemmeside, "Enogtyve". Ud af de 21 millioner er omtrent 19 millioner i omløb i dag, og det antages, at et sted mellem 4 og 6 millioner af disse er gået tabt som følge af uagtsomhed eller uvidenhed samt den lave værdi, bitcoin blev tillagt i sine tidlige år.</p>
				</div>
			</div>

			<div class="accordion-item">
				<button class="accordion-header" data-target="intro-3">
					<span class="accordion-title">Bitcoin er en ny teknologi</span>
					<span class="accordion-icon">▼</span>
				</button>
				<div class="accordion-content" id="intro-3">
					<p>Bitcoin-netværket har kun eksisteret i relativt kort tid og er stadig en ny teknologi. Set i et større perspektiv er Bitcoin kun lige begyndt. De seneste år har der været en betydelig udvikling af teknologier, som bygger oven på Bitcoin, og som muliggør en bred vifte af nye funktioner og anvendelser. Der er ingen grund til at tro, at denne udvikling vil aftage i de kommende år.</p>
					
					<p>Mennesker, samfund, virksomheder og regeringer verden over begynder gradvist at anerkende og forstå, at Bitcoin er en betydelig opdagelse, som ikke kan sidestilles med noget andet, vi kender. Netop derfor kan det være vanskeligt både at forklare og forstå, hvad Bitcoin egentlig er for en størrelse. Som Satoshi Nakamoto skrev, er det svært at forklare Bitcoin, fordi der ikke findes noget oplagt at sammenligne det med.</p>
				</div>
			</div>
		</div>
	</div>
</section>

<style>
	.introduction-unified {
		padding: clamp(2.5rem, 6vh, 4rem) 0;
		background: linear-gradient(180deg, rgba(247, 147, 26, 0.02) 0%, transparent 100%);
	}

	.intro-container {
		max-width: 900px;
		margin: 0 auto;
		padding: 0 1rem;
	}

	.intro-container h2 {
		font-size: clamp(1.75rem, 4vw, 2.25rem);
		color: var(--text);
		margin-bottom: 1.5rem;
		font-weight: 600;
		text-align: center;
	}

	.intro-accordion {
		background: rgba(255, 255, 255, 0.02);
		border: 1px solid rgba(247, 147, 26, 0.2);
		border-radius: 16px;
		overflow: hidden;
	}

	.accordion-item {
		border-bottom: 1px solid rgba(247, 147, 26, 0.1);
	}

	.accordion-item:last-child {
		border-bottom: none;
	}

	.special-intro {
		background: rgba(247, 147, 26, 0.03);
	}

	.accordion-header-clickable {
		width: 100%;
		display: flex;
		justify-content: space-between;
		align-items: center;
		padding: 1.25rem 1.5rem;
		background: transparent;
		border: none;
		cursor: pointer;
		transition: all 0.3s ease;
		text-align: left;
	}

	.accordion-header-clickable:hover {
		background: rgba(247, 147, 26, 0.06);
	}

	.accordion-header-clickable.active {
		background: rgba(247, 147, 26, 0.08);
	}

	.accordion-header-clickable .accordion-icon {
		color: var(--primary);
		font-size: 0.9rem;
		transition: transform 0.3s ease;
	}

	.accordion-header-clickable.active .accordion-icon {
		transform: rotate(180deg);
	}

	.accordion-content-static {
		max-height: 0;
		overflow: hidden;
		transition: max-height 0.4s ease-out, padding 0.3s ease-out;
		padding: 0 1.5rem;
	}

	.accordion-content-static.active {
		max-height: 2000px;
		padding: 1.5rem;
		transition: max-height 0.5s ease-in, padding 0.3s ease-in;
	}

	.expandable-content {
		max-height: 0;
		overflow: hidden;
		transition: max-height 0.4s ease-out, opacity 0.3s ease-out;
		opacity: 0;
	}

	.expandable-content.expanded {
		max-height: 2000px;
		opacity: 1;
		transition: max-height 0.5s ease-in, opacity 0.4s ease-in;
	}

	.expand-btn {
		display: flex;
		align-items: center;
		gap: 0.5rem;
		margin: 1rem auto 0;
		padding: 0.65rem 1.25rem;
		background: rgba(247, 147, 26, 0.1);
		border: 1px solid rgba(247, 147, 26, 0.3);
		border-radius: 8px;
		color: var(--primary);
		font-weight: 600;
		font-size: 0.9rem;
		cursor: pointer;
		transition: all 0.3s ease;
	}

	.expand-btn:hover {
		background: rgba(247, 147, 26, 0.15);
		border-color: var(--primary);
		transform: translateY(-2px);
	}

	.expand-btn .btn-icon {
		transition: transform 0.3s ease;
		font-size: 0.75rem;
	}

	.expand-btn.expanded .btn-icon {
		transform: rotate(180deg);
	}

	.accordion-header {
		width: 100%;
		display: flex;
		justify-content: space-between;
		align-items: center;
		padding: 1.25rem 1.5rem;
		background: rgba(247, 147, 26, 0.03);
		border: none;
		cursor: pointer;
		transition: all 0.3s ease;
		text-align: left;
	}

	.accordion-header:hover {
		background: rgba(247, 147, 26, 0.06);
	}

	.accordion-header.active {
		background: rgba(247, 147, 26, 0.08);
	}

	.accordion-title {
		font-size: clamp(1rem, 2.5vw, 1.15rem);
		font-weight: 600;
		color: var(--text);
	}

	.accordion-icon {
		color: var(--primary);
		font-size: 0.9rem;
		transition: transform 0.3s ease;
	}

	.accordion-header.active .accordion-icon {
		transform: rotate(180deg);
	}

	.accordion-content {
		max-height: 0;
		overflow: hidden;
		transition: max-height 0.4s ease-out, padding 0.3s ease-out;
		padding: 0 1.5rem;
	}

	.accordion-content.active {
		max-height: 2000px;
		padding: 1.5rem;
		transition: max-height 0.5s ease-in, padding 0.3s ease-in;
	}

	.accordion-content p,
	.accordion-content-static p,
	.expandable-content p {
		font-size: clamp(0.95rem, 2vw, 1.05rem);
		line-height: 1.7;
		color: var(--text-light);
		margin-bottom: 1rem;
	}

	.accordion-content p:last-child,
	.expandable-content p:last-child {
		margin-bottom: 0;
	}

	.accordion-content-static > p:first-child {
		margin-top: 0;
	}
</style>

<script>
	// Introduction section functionality
	const introHeader = document.getElementById('intro-header');
	const introContent = document.getElementById('intro-content');
	const introExpandBtn = document.getElementById('intro-expand-btn');
	const introExpandable = document.getElementById('intro-expandable');

	// Open the intro section by default
	introHeader?.classList.add('active');
	introContent?.classList.add('active');

	// Header click toggles entire section
	introHeader?.addEventListener('click', () => {
		const isActive = introHeader.classList.contains('active');
		
		if (isActive) {
			introHeader.classList.remove('active');
			introContent?.classList.remove('active');
			introExpandable?.classList.remove('expanded');
			introExpandBtn?.classList.remove('expanded');
			if (introExpandBtn) {
				introExpandBtn.querySelector('.btn-text')!.textContent = 'Læs mere';
			}
		} else {
			introHeader.classList.add('active');
			introContent?.classList.add('active');
		}
	});

	// Expand button toggles extra content or closes section
	introExpandBtn?.addEventListener('click', (e) => {
		e.stopPropagation();
		const isExpanded = introExpandable?.classList.contains('expanded');
		
		if (isExpanded) {
			introHeader?.classList.remove('active');
			introContent?.classList.remove('active');
			introExpandable?.classList.remove('expanded');
			introExpandBtn.classList.remove('expanded');
			introExpandBtn.querySelector('.btn-text')!.textContent = 'Læs mere';
		} else {
			introExpandable?.classList.add('expanded');
			introExpandBtn.classList.add('expanded');
			introExpandBtn.querySelector('.btn-text')!.textContent = 'Læs mindre';
		}
	});

	// Accordion functionality for other items
	const accordionHeaders = document.querySelectorAll('.accordion-header');
	
	accordionHeaders.forEach(header => {
		header.addEventListener('click', () => {
			const targetId = header.getAttribute('data-target');
			const content = document.getElementById(targetId);
			const isActive = header.classList.contains('active');
			
			accordionHeaders.forEach(h => {
				h.classList.remove('active');
				const targetContent = document.getElementById(h.getAttribute('data-target') || '');
				targetContent?.classList.remove('active');
			});
			
			if (!isActive) {
				header.classList.add('active');
				content?.classList.add('active');
			}
		});
	});
</script>
EOF

echo "Created IntroAccordion.astro"

# 3. Create StatsSection component
cat > components/home/StatsSection.astro << 'EOF'
<section class="stats-section">
	<div class="stats-grid">
		<div class="stat-tile">
			<div class="stat-value">—</div>
			<div class="stat-label">Medlemmer</div>
		</div>
		<div class="stat-tile">
			<div class="stat-value">—</div>
			<div class="stat-label">Artikler</div>
		</div>
		<div class="stat-tile">
			<div class="stat-value">—</div>
			<div class="stat-label">Videoer</div>
		</div>
		<div class="stat-tile">
			<div class="stat-value">—</div>
			<div class="stat-label">Events</div>
		</div>
	</div>
</section>

<style>
	.stats-section {
		padding: clamp(2.5rem, 6vh, 4rem) 0;
		background: linear-gradient(180deg, transparent 0%, rgba(247, 147, 26, 0.03) 50%, transparent 100%);
		border-top: 1px solid rgba(247, 147, 26, 0.1);
		border-bottom: 1px solid rgba(247, 147, 26, 0.1);
	}

	.stats-grid {
		display: grid;
		grid-template-columns: repeat(auto-fit, minmax(140px, 1fr));
		gap: clamp(1.25rem, 3vw, 2rem);
		max-width: 900px;
		margin: 0 auto;
		padding: 0 1rem;
	}

	.stat-tile {
		text-align: center;
		padding: 1.5rem 1rem;
		border-radius: 12px;
		background: rgba(255, 255, 255, 0.02);
		border: 1px solid rgba(247, 147, 26, 0.15);
		transition: all 0.3s ease;
	}

	.stat-tile:hover {
		background: rgba(247, 147, 26, 0.05);
		border-color: rgba(247, 147, 26, 0.3);
		transform: translateY(-2px);
	}

	.stat-value {
		font-size: clamp(1.75rem, 4vw, 2.5rem);
		font-weight: 700;
		color: var(--primary);
		margin-bottom: 0.5rem;
		line-height: 1;
	}

	.stat-label {
		font-size: 0.85rem;
		color: var(--text-light);
		text-transform: uppercase;
		letter-spacing: 0.05em;
		font-weight: 500;
	}

	@media (max-width: 767px) {
		.stats-grid {
			grid-template-columns: repeat(2, 1fr);
		}
	}
</style>
EOF

echo "Created StatsSection.astro"

# 4. Create ShowcaseGrid component (will be large, so abbreviated here)
cat > components/home/ShowcaseGrid.astro << 'EOF'
<section class="content-showcase">
	<div class="showcase-grid">
		<div class="showcase-box featured-news">
			<div class="box-header">
				<h3>🎯 Seneste Nyt</h3>
				<span class="box-badge">Live</span>
			</div>
			<div class="box-content">
				<div class="news-item placeholder">
					<div class="news-date">DD/MM/ÅÅÅÅ</div>
					<div class="news-title">Overskrift kommer her</div>
					<div class="news-excerpt">Kort beskrivelse af nyheden...</div>
				</div>
				<div class="news-item placeholder">
					<div class="news-date">DD/MM/ÅÅÅÅ</div>
					<div class="news-title">Endnu en spændende nyhed</div>
					<div class="news-excerpt">Mere indhold på vej...</div>
				</div>
				<div class="news-item placeholder">
					<div class="news-date">DD/MM/ÅÅÅÅ</div>
					<div class="news-title">Fællesskabsopdatering</div>
					<div class="news-excerpt">Stay tuned for mere...</div>
				</div>
			</div>
		</div>

		<div class="showcase-box community-pulse">
			<div class="box-header">
				<h3>⚡ Community Puls</h3>
			</div>
			<div class="box-content">
				<div class="pulse-stats">
					<div class="pulse-item">
						<div class="pulse-icon">💬</div>
						<div class="pulse-info">
							<div class="pulse-number">—</div>
							<div class="pulse-label">Kommentarer i dag</div>
						</div>
					</div>
					<div class="pulse-item">
						<div class="pulse-icon">👥</div>
						<div class="pulse-info">
							<div class="pulse-number">—</div>
							<div class="pulse-label">Aktive brugere</div>
						</div>
					</div>
					<div class="pulse-item">
						<div class="pulse-icon">🔥</div>
						<div class="pulse-info">
							<div class="pulse-number">—</div>
							<div class="pulse-label">Hot topics</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="showcase-box trending">
			<div class="box-header">
				<h3>📈 Trending Nu</h3>
			</div>
			<div class="box-content">
				<div class="trending-list">
					<div class="trending-item placeholder">
						<span class="trending-rank">#1</span>
						<span class="trending-title">Populær artikel titel</span>
						<span class="trending-views">— visninger</span>
					</div>
					<div class="trending-item placeholder">
						<span class="trending-rank">#2</span>
						<span class="trending-title">Video der går viralt</span>
						<span class="trending-views">— visninger</span>
					</div>
					<div class="trending-item placeholder">
						<span class="trending-rank">#3</span>
						<span class="trending-title">Diskussion af ugen</span>
						<span class="trending-views">— visninger</span>
					</div>
				</div>
			</div>
		</div>

		<div class="showcase-box upcoming-events">
			<div class="box-header">
				<h3>📅 Kommende Events</h3>
			</div>
			<div class="box-content">
				<div class="event-list">
					<div class="event-item placeholder">
						<div class="event-date-block">
							<div class="event-day">—</div>
							<div class="event-month">MÅN</div>
						</div>
						<div class="event-details">
							<div class="event-title">Event titel kommer her</div>
							<div class="event-time">00:00 - 00:00</div>
						</div>
					</div>
					<div class="event-item placeholder">
						<div class="event-date-block">
							<div class="event-day">—</div>
							<div class="event-month">MÅN</div>
						</div>
						<div class="event-details">
							<div class="event-title">Næste meetup</div>
							<div class="event-time">00:00 - 00:00</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<style>
	.content-showcase {
		padding: clamp(2.5rem, 6vh, 4rem) 0;
		background: linear-gradient(180deg, transparent 0%, rgba(247, 147, 26, 0.02) 100%);
	}

	.showcase-grid {
		display: grid;
		grid-template-columns: repeat(auto-fit, minmax(min(100%, 300px), 1fr));
		gap: clamp(1.25rem, 3vw, 1.75rem);
		max-width: 1200px;
		margin: 0 auto;
		padding: 0 1rem;
	}

	.showcase-box {
		background: rgba(255, 255, 255, 0.02);
		border: 1px solid rgba(247, 147, 26, 0.15);
		border-radius: 12px;
		padding: 0;
		overflow: hidden;
		transition: all 0.3s ease;
	}

	.showcase-box:hover {
		border-color: rgba(247, 147, 26, 0.3);
		transform: translateY(-4px);
		box-shadow: 0 8px 24px rgba(247, 147, 26, 0.15);
	}

	.box-header {
		padding: 1.25rem;
		border-bottom: 1px solid rgba(247, 147, 26, 0.1);
		display: flex;
		justify-content: space-between;
		align-items: center;
		background: rgba(247, 147, 26, 0.03);
	}

	.box-header h3 {
		margin: 0;
		font-size: 1rem;
		font-weight: 600;
		color: var(--text);
	}

	.box-badge {
		font-size: 0.65rem;
		padding: 0.25rem 0.65rem;
		background: var(--primary);
		color: #000;
		border-radius: 12px;
		font-weight: 700;
		text-transform: uppercase;
		letter-spacing: 0.05em;
	}

	.box-content {
		padding: 1.25rem;
	}

	.news-item {
		padding: 0.85rem 0;
		border-bottom: 1px solid rgba(247, 147, 26, 0.08);
	}

	.news-item:last-child {
		border-bottom: none;
		padding-bottom: 0;
	}

	.news-date {
		font-size: 0.7rem;
		color: var(--primary);
		font-weight: 600;
		margin-bottom: 0.25rem;
		text-transform: uppercase;
	}

	.news-title {
		font-weight: 600;
		font-size: 0.95rem;
		color: var(--text);
		margin-bottom: 0.25rem;
	}

	.news-excerpt {
		font-size: 0.85rem;
		color: var(--text-light);
		line-height: 1.4;
	}

	.pulse-stats {
		display: flex;
		flex-direction: column;
		gap: 1rem;
	}

	.pulse-item {
		display: flex;
		align-items: center;
		gap: 0.85rem;
		padding: 0.85rem;
		background: rgba(247, 147, 26, 0.05);
		border-radius: 10px;
		border: 1px solid rgba(247, 147, 26, 0.1);
	}

	.pulse-icon {
		font-size: 1.75rem;
		line-height: 1;
	}

	.pulse-info {
		flex: 1;
	}

	.pulse-number {
		font-size: 1.35rem;
		font-weight: 700;
		color: var(--primary);
		line-height: 1;
		margin-bottom: 0.25rem;
	}

	.pulse-label {
		font-size: 0.8rem;
		color: var(--text-light);
	}

	.trending-list {
		display: flex;
		flex-direction: column;
		gap: 0.65rem;
	}

	.trending-item {
		display: grid;
		grid-template-columns: auto 1fr auto;
		gap: 0.85rem;
		align-items: center;
		padding: 0.65rem;
		background: rgba(247, 147, 26, 0.03);
		border-radius: 8px;
		border: 1px solid rgba(247, 147, 26, 0.1);
	}

	.trending-rank {
		font-weight: 700;
		color: var(--primary);
		font-size: 1rem;
	}

	.trending-title {
		color: var(--text);
		font-weight: 500;
		font-size: 0.9rem;
	}

	.trending-views {
		font-size: 0.8rem;
		color: var(--text-light);
	}

	.event-list {
		display: flex;
		flex-direction: column;
		gap: 0.85rem;
	}

	.event-item {
		display: flex;
		gap: 0.85rem;
		padding: 0.85rem;
		background: rgba(247, 147, 26, 0.03);
		border-radius: 10px;
		border: 1px solid rgba(247, 147, 26, 0.1);
	}

	.event-date-block {
		text-align: center;
		min-width: 55px;
		padding: 0.5rem;
		background: var(--primary);
		color: #000;
		border-radius: 8px;
		font-weight: 700;
	}

	.event-day {
		font-size: 1.35rem;
		line-height: 1;
	}

	.event-month {
		font-size: 0.7rem;
		text-transform: uppercase;
		margin-top: 0.25rem;
	}

	.event-details {
		flex: 1;
	}

	.event-title {
		font-weight: 600;
		font-size: 0.95rem;
		color: var(--text);
		margin-bottom: 0.25rem;
	}

	.event-time {
		font-size: 0.8rem;
		color: var(--text-light);
	}

	.placeholder {
		opacity: 0.6;
	}

	@media (max-width: 767px) {
		.showcase-grid {
			grid-template-columns: 1fr;
		}
	}

	@media (min-width: 768px) {
		.showcase-grid {
			grid-template-columns: repeat(2, 1fr);
		}

		.featured-news {
			grid-column: 1 / -1;
		}
	}
</style>
EOF

echo "Created ShowcaseGrid.astro"

# 5. Create FeatureGrid component
cat > components/home/FeatureGrid.astro << 'EOF'
---
const { lang } = Astro.props;
---

<section class="featured">
	<h2>Udforsk</h2>
	<div class="feature-grid">
		<a href={`/${lang}/blog`} class="feature-card">
			<h3>📝 Blog</h3>
			<p>Læs artikler og bidrag fra fællesskabet</p>
		</a>

		<a href={`/${lang}/videos`} class="feature-card">
			<h3>🎥 Videoer</h3>
			<p>Lær gennem uddannelsesvideoer</p>
		</a>

		<a href={`/${lang}/podcasts`} class="feature-card">
			<h3>🎙️ Podcasts</h3>
			<p>Lyt til dybdegående samtaler</p>
		</a>

		<a href={`/${lang}/resources`} class="feature-card">
			<h3>📚 Ressourcer</h3>
			<p>Find værktøjer og guides</p>
		</a>

		<a href={`/${lang}/rabat`} class="feature-card">
			<h3>💰 Rabat med enogtyve</h3>
			<p>Spar penge med vores partnere</p>
		</a>

		<a href={`/${lang}/support`} class="feature-card">
			<h3>❤️ Støt os</h3>
			<p>Hjælp fællesskabet med at vokse</p>
		</a>
	</div>
</section>

<style>
	.featured {
		padding: clamp(2.5rem, 6vh, 4rem) 0;
	}

	.featured h2 {
		text-align: center;
		font-size: clamp(1.75rem, 4vw, 2.25rem);
		margin-bottom: clamp(1.75rem, 5vh, 3rem);
		font-weight: 600;
		color: var(--text);
	}

	.feature-grid {
		display: grid;
		grid-template-columns: repeat(auto-fit, minmax(min(100%, 280px), 1fr));
		gap: clamp(1.25rem, 3vw, 1.75rem);
		max-width: 1200px;
		margin: 0 auto;
		padding: 0 1rem;
	}

	.feature-card {
		padding: clamp(1.5rem, 4vw, 2rem);
		border: 1px solid rgba(247, 147, 26, 0.2);
		border-radius: 12px;
		transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
		text-align: center;
		background: rgba(255, 255, 255, 0.01);
		position: relative;
		overflow: hidden;
		display: flex;
		flex-direction: column;
		justify-content: center;
		min-height: 140px;
		text-decoration: none;
	}

	.feature-card::before {
		content: '';
		position: absolute;
		top: 0;
		left: 0;
		right: 0;
		bottom: 0;
		background: radial-gradient(circle at center, rgba(247, 147, 26, 0.05), transparent);
		opacity: 0;
		transition: opacity 0.3s ease;
	}

	.feature-card:hover::before,
	.feature-card:focus::before {
		opacity: 1;
	}

	.feature-card:hover,
	.feature-card:focus {
		border-color: var(--primary);
		transform: translateY(-6px);
		box-shadow: 0 12px 24px rgba(247, 147, 26, 0.15);
		background: rgba(247, 147, 26, 0.03);
	}

	.feature-card h3 {
		color: var(--text);
		margin-bottom: 0.65rem;
		font-size: clamp(1.05rem, 2.5vw, 1.2rem);
		font-weight: 600;
		position: relative;
	}

	.feature-card p {
		color: var(--text-light);
		margin: 0;
		font-size: clamp(0.88rem, 2vw, 0.95rem);
		line-height: 1.5;
		position: relative;
	}

	@media (max-width: 767px) {
		.feature-grid {
			grid-template-columns: 1fr;
		}
	}
</style>
EOF

echo "Created FeatureGrid.astro"

# 6. Create CTASection component
cat > components/home/CTASection.astro << 'EOF'
---
const { lang } = Astro.props;
---

<section class="cta-section">
	<div class="cta-box">
		<div class="cta-content">
			<h2>💬 Fællesskab & samtale</h2>
			<p class="cta-text">
				Uanset om du er ny eller har været med længe, har du helt sikkert noget at byde ind med. Hop med i snakken i vores Telegram-gruppe (link herunder), og kig dig endelig lidt omkring på siden, hvor du finder idéer til videre udforskning af Bitcoin.
			</p>
			<div class="cta-buttons">
				<a href="#" class="btn-primary">Telegramgruppe</a>
				<a href={`/${lang}/resources`} class="btn-secondary">Støt op om Enogtyve</a>
			</div>
		</div>
	</div>
</section>

<style>
	.cta-section {
		padding: clamp(2.5rem, 6vh, 4rem) 0 clamp(3rem, 8vh, 5rem);
	}

	.cta-box {
		max-width: 800px;
		margin: 0 auto;
		padding: 0 1rem;
	}

	.cta-content {
		text-align: center;
		padding: clamp(2rem, 5vw, 3rem);
		background: linear-gradient(135deg, rgba(247, 147, 26, 0.1), rgba(247, 147, 26, 0.05));
		border: 2px solid rgba(247, 147, 26, 0.3);
		border-radius: 16px;
		position: relative;
		overflow: hidden;
	}

	.cta-content::before {
		content: '';
		position: absolute;
		top: -50%;
		left: -50%;
		width: 200%;
		height: 200%;
		background: radial-gradient(circle, rgba(247, 147, 26, 0.1), transparent 70%);
		animation: pulse 4s ease-in-out infinite;
	}

	@keyframes pulse {
		0%, 100% { transform: scale(1); opacity: 0.5; }
		50% { transform: scale(1.1); opacity: 0.8; }
	}

	.cta-content h2 {
		position: relative;
		font-size: clamp(1.5rem, 4vw, 2rem);
		color: var(--text);
		margin-bottom: 1.25rem;
		font-weight: 700;
	}

	.cta-text {
		position: relative;
		font-size: clamp(1rem, 2.5vw, 1.1rem);
		color: var(--text-light);
		margin-bottom: 2rem;
		line-height: 1.7;
		max-width: 650px;
		margin-left: auto;
		margin-right: auto;
	}

	.cta-buttons {
		position: relative;
		display: flex;
		gap: 1rem;
		justify-content: center;
		flex-wrap: wrap;
	}

	.btn-primary, .btn-secondary {
		padding: 0.85rem 1.85rem;
		border-radius: 8px;
		font-weight: 600;
		font-size: 0.95rem;
		cursor: pointer;
		transition: all 0.3s ease;
		border: 2px solid;
		text-decoration: none;
		display: inline-block;
	}

	.btn-primary {
		background: var(--primary);
		color: #000;
		border-color: var(--primary);
	}

	.btn-primary:hover {
		transform: translateY(-2px);
		box-shadow: 0 8px 20px rgba(247, 147, 26, 0.4);
	}

	.btn-secondary {
		background: transparent;
		color: var(--text);
		border-color: rgba(247, 147, 26, 0.5);
	}

	.btn-secondary:hover {
		background: rgba(247, 147, 26, 0.1);
		border-color: var(--primary);
		transform: translateY(-2px);
	}

	@media (max-width: 767px) {
		.cta-buttons {
			flex-direction: column;
		}

		.btn-primary, .btn-secondary {
			width: 100%;
		}
	}
</style>
EOF

echo "Created CTASection.astro"

# 7. Create search handler script
cat > scripts/searchHandler.ts << 'EOF'
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
EOF

echo "Created searchHandler.ts"

# 8. Create new simplified index.astro
cat > index-refactored.astro << 'EOF'
---
import BaseLayout from "../layouts/BaseLayout.astro";
import HeroSection from "../components/home/HeroSection.astro";
import IntroAccordion from "../components/home/IntroAccordion.astro";
import StatsSection from "../components/home/StatsSection.astro";
import ShowcaseGrid from "../components/home/ShowcaseGrid.astro";
import FeatureGrid from "../components/home/FeatureGrid.astro";
import CTASection from "../components/home/CTASection.astro";

const lang = "da";
---

<BaseLayout title="Hjem" lang={lang}>
	<div class="container">
		<HeroSection lang={lang} />
		<IntroAccordion />
		<StatsSection />
		<ShowcaseGrid />
		<FeatureGrid lang={lang} />
		<CTASection lang={lang} />
	</div>
</BaseLayout>

<style>
	@media (prefers-reduced-motion: no-preference) {
		@media (min-width: 768px) {
			.container {
				scroll-snap-type: y proximity;
			}
			
			:global(section) {
				scroll-snap-align: start;
			}
		}
	}

	:global(.search-results-dropdown) {
		position: absolute;
		top: calc(100% + 0.5rem);
		left: 0;
		width: 100%;
		background: #1a1a1a;
		border-radius: 8px;
		max-height: 400px;
		overflow-y: auto;
		z-index: 1000;
		box-shadow: 0 8px 32px rgba(0, 0, 0, 0.5);
		border: 1px solid rgba(247, 147, 26, 0.2);
	}

	:global(.search-result-item) {
		display: flex;
		gap: 1rem;
		padding: 1rem;
		border-bottom: 1px solid rgba(247, 147, 26, 0.1);
		transition: background 0.2s ease;
		color: var(--text);
		align-items: flex-start;
		text-decoration: none;
	}

	:global(.search-result-item:last-child) {
		border-bottom: none;
	}

	:global(.search-result-item:hover) {
		background: rgba(247, 147, 26, 0.1);
	}

	:global(.result-tag) {
		font-size: 0.7rem;
		padding: 0.25rem 0.5rem;
		background: var(--primary);
		color: #000;
		border-radius: 4px;
		font-weight: 700;
		text-transform: uppercase;
		flex-shrink: 0;
		letter-spacing: 0.03em;
	}

	:global(.result-content) {
		flex: 1;
	}

	:global(.result-title) {
		font-weight: 600;
		margin-bottom: 0.25rem;
		color: var(--text);
	}

	:global(.result-description) {
		font-size: 0.9rem;
		color: var(--text-light);
		line-height: 1.4;
	}

	:global(.search-no-results) {
		padding: 1.5rem;
		text-align: center;
		color: var(--text-light);
	}
</style>

<script>
	import { initializeSearch } from "../scripts/searchHandler";
	initializeSearch();
</script>
EOF

echo "Created index-refactored.astro"

echo ""
echo "✅ Refactor complete!"
echo ""
echo "Created files:"
echo "  - components/home/HeroSection.astro"
echo "  - components/home/IntroAccordion.astro"
echo "  - components/home/StatsSection.astro"
echo "  - components/home/ShowcaseGrid.astro"
echo "  - components/home/FeatureGrid.astro"
echo "  - components/home/CTASection.astro"
echo "  - scripts/searchHandler.ts"
echo "  - index-refactored.astro (new simplified index)"
echo ""
echo "Original file reduced from ~1000 lines to ~100 lines!"
echo ""
echo "To use the refactored version:"
echo "  mv index.astro index-old.astro"
echo "  mv index-refactored.astro index.astro"
