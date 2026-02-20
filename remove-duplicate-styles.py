import os
import re
import glob

# Patterns to remove - these are now in global.css
patterns = [
    # back-to-top block
    r'  /\* Back to top \*/\s*\n  \.back-to-top \{[^}]+\}\s*\n\s*\n  \.back-to-top:hover \{[^}]+\}',
    # section-title block  
    r'  /\* Section titles? \*/\s*\n  \.section-title \{[^}]+\}',
    # back-to-top without comment
    r'  \.back-to-top \{[^}]+\}\s*\n\s*\n  \.back-to-top:hover \{[^}]+\}',
    # section-title without comment
    r'  \.section-title \{[^}]+\}',
]

files = glob.glob('src/pages/da/**/*.astro', recursive=True)
files.sort()

for filepath in files:
    with open(filepath, 'r') as f:
        content = f.read()
    
    original = content
    for pattern in patterns:
        content = re.sub(pattern, '', content, flags=re.MULTILINE)
    
    # Clean up extra blank lines left behind
    content = re.sub(r'\n{3,}', '\n\n', content)
    
    if content != original:
        with open(filepath, 'w') as f:
            f.write(content)
        print(f"Cleaned: {filepath}")
    else:
        print(f"Skipped: {filepath}")

print("\nDone!")
