#!/bin/bash
# Run this from your project root (where src/ is)
# Preview first with: bash reorganize.sh --dry-run

DRY_RUN=false
if [ "$1" = "--dry-run" ]; then
    DRY_RUN=true
    echo "=== DRY RUN — no files will be moved ==="
    echo ""
fi

move_file() {
    local src="$1"
    local dest="$2"
    local dest_dir=$(dirname "$dest")

    if [ ! -f "$src" ]; then
        echo "⚠️  SKIP (not found): $src"
        return
    fi

    if [ "$DRY_RUN" = true ]; then
        echo "  $src"
        echo "    → $dest"
        echo ""
    else
        mkdir -p "$dest_dir"
        mv "$src" "$dest"
        echo "✅ $src → $dest"
    fi
}

echo "========================================"
echo "  1. Create /velkommen/ folder"
echo "     Move FUD/Fakta from kom-igang"
echo "========================================"
move_file "src/pages/da/kom-igang/fud-facts.astro" "src/pages/da/velkommen/fud-facts.astro"

echo ""
echo "========================================"
echo "  2. Move pages INTO /kom-igang/"
echo "     From: ressources"
echo "========================================"
move_file "src/pages/da/ressources/begreber-ord.astro" "src/pages/da/kom-igang/begreber-ord.astro"
move_file "src/pages/da/ressources/bitcoin-boeger-dansk.astro" "src/pages/da/kom-igang/bitcoin-boeger-dansk.astro"

echo ""
echo "========================================"
echo "  3. Move pages INTO /laer-mere/"
echo "     From: kom-igang, ressources, udforsk"
echo "========================================"
move_file "src/pages/da/kom-igang/lightning.astro" "src/pages/da/laer-mere/lightning.astro"
move_file "src/pages/da/kom-igang/liquid.astro" "src/pages/da/laer-mere/liquid.astro"
move_file "src/pages/da/kom-igang/ecash.astro" "src/pages/da/laer-mere/ecash.astro"
move_file "src/pages/da/kom-igang/bitcoin-og-din-forretning.astro" "src/pages/da/laer-mere/bitcoin-og-din-forretning.astro"
move_file "src/pages/da/ressources/quotes-dansk.astro" "src/pages/da/laer-mere/quotes-dansk.astro"
move_file "src/pages/da/udforsk/bitcoin-services-og-produkter.astro" "src/pages/da/laer-mere/bitcoin-services-og-produkter.astro"

echo ""
echo "========================================"
echo "  4. Move pages INTO /udforsk/"
echo "     From: ressources"
echo "========================================"
move_file "src/pages/da/ressources/nyheder.astro" "src/pages/da/udforsk/nyheder.astro"
move_file "src/pages/da/ressources/ressources-english.astro" "src/pages/da/udforsk/ressources-english.astro"
move_file "src/pages/da/ressources/bitcoin-ressources.astro" "src/pages/da/udforsk/bitcoin-ressources.astro"

echo ""
echo "========================================"
echo "  5. Move pages INTO /faellesskab/"
echo "     From: ressources"
echo "========================================"
move_file "src/pages/da/ressources/initiativer-danmark.astro" "src/pages/da/faellesskab/initiativer-danmark.astro"

echo ""
echo "========================================"
echo "  6. Rename podcasts for cleaner URL"
echo "     /podcasts/podcasts → /podcasts/index"
echo "========================================"
move_file "src/pages/da/podcasts/podcasts.astro" "src/pages/da/podcasts/index.astro"

echo ""
echo "========================================"
echo "  Summary"
echo "========================================"
echo ""
echo "Folders that should now be EMPTY (safe to delete):"
echo "  src/pages/da/ressources/"
echo ""
echo "Remaining structure:"

if [ "$DRY_RUN" = false ]; then
    echo ""
    find src/pages -type f -name "*.astro" -o -name "*.ts" | sort
    echo ""
    echo "✅ Done! Now replace your Header.astro with the updated version."
    echo ""
    echo "⚠️  IMPORTANT: Check individual pages for internal links that"
    echo "   may reference old paths (e.g., /da/kom-igang/lightning"
    echo "   should now be /da/laer-mere/lightning)."
    echo ""
    echo "You can search for broken internal links with:"
    echo '  grep -r "kom-igang/lightning\|kom-igang/liquid\|kom-igang/ecash\|kom-igang/fud-facts\|kom-igang/bitcoin-og-din-forretning\|ressources/" src/pages/ --include="*.astro"'
else
    echo ""
    echo "Run without --dry-run to execute the moves."
fi
