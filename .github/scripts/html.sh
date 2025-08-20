#!/bin/sh
# Originally from https://github.com/p-sira/SVLMD/blob/main/.github/scripts/inject_html.sh

file="build/index.html"

title="Somme4096の文章置き場"
description="(Experimental) personal website of Somme4096."

# Escape HTML characters
title_escaped=$(echo "$title" | sed 's/&/\&amp;/g; s/"/\&quot;/g')
description_escaped=$(echo "$description" | sed 's/&/\&amp;/g; s/"/\&quot;/g')

sed -i "s/<meta property=\"og:title\"[^>]*>/<meta property=\"og:title\" content=\"$title_escaped\">/" "$file"
sed -i "s/<meta property=\"og:description\"[^>]*>/<meta property=\"og:description\" content=\"$description_escaped\">/" "$file"
sed -i "s/<meta name=\"description\"[^>]*>/<meta name=\"description\" content=\"$description_escaped\">/" "$file"
echo "Inject HTML: Replaced meta information"

script='<script>
  document.title = document.title + " | Somme4096の実験的なウェブサイト";
</script>'

# Escape for sed insertion
escaped=$(echo "$script" | sed 's/[&\\]/\\&/g; s/\//\\\//g' | sed ':a;N;$!ba;s/\n/\\n/g')

# Inject before </body>
sed -i "s#</body>#$escaped\n</body>#" "$file"
echo "Inject HTML: Injected title-replacing script."
