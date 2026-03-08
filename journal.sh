#!/bin/bash

# Usage: ./journal.sh "today" or ./journal.sh "04022026" or ./journal.sh "4 feb 2026"

INPUT="$1"
JOURNAL="journal.markdown"

# Parse date - handles "today", "yesterday", ddmmyyyy, or natural language
if [ "$INPUT" = "today" ]; then
    DATE=$(date +%d%m%Y)
    DISPLAY_DATE=$(date +%Y-%m-%d)
elif [ "$INPUT" = "yesterday" ]; then
    DATE=$(date -v-1d +%d%m%Y)
    DISPLAY_DATE=$(date -v-1d +%Y-%m-%d)
elif [[ "$INPUT" =~ ^[0-9]{8}$ ]]; then
    # ddmmyyyy format
    DAY=${INPUT:0:2}
    MONTH=${INPUT:2:2}
    YEAR=${INPUT:4:4}
    DATE="$INPUT"
    DISPLAY_DATE="$YEAR-$MONTH-$DAY"
else
    # Try natural language with date command
    DISPLAY_DATE=$(date -j -f "%d %b %Y" "$INPUT" +%Y-%m-%d 2>/dev/null) || \
    DISPLAY_DATE=$(date -j -f "%B %d %Y" "$INPUT" +%Y-%m-%d 2>/dev/null) || \
    DISPLAY_DATE=$(date -j -f "%d %B %Y" "$INPUT" +%Y-%m-%d 2>/dev/null)

    if [ -z "$DISPLAY_DATE" ]; then
        echo "Couldn't parse date: $INPUT"
        echo "Try: today, yesterday, 04022026, or '4 feb 2026'"
        exit 1
    fi
fi

# Check if date already exists
if grep -q "## $DISPLAY_DATE" "$JOURNAL"; then
    echo "Entry for $DISPLAY_DATE already exists. Opening for editing..."
else
    # Add new entry after the toc div closing, before first ---
    # Insert new date in toc and new section

    # Add to jump links
    sed -i '' "s|</div>|<a href=\"#$DISPLAY_DATE\">$DISPLAY_DATE</a>\n</div>|" "$JOURNAL"

    # Add new entry section after first ---
    sed -i '' "0,/^---$/{ /^---$/a\\
\\
## $DISPLAY_DATE\\
\\
\\
\\
---
}" "$JOURNAL"
fi

# Open in default editor
${EDITOR:-nano} "$JOURNAL"

# After editing, commit and push
read -p "Ship it? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    git add "$JOURNAL"
    git commit -m "ship journal"
    git push origin
    echo "Shipped!"
fi
