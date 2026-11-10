#!/usr/bin/env bash
# Gera index.html (página autônoma para hospedar) a partir de src/links.html (fragmento usado na prévia do Artifact).
set -euo pipefail
cd "$(dirname "$0")"
perl -0e '
  local $/; open my $f, "<:raw", "src/links.html" or die; my $s = <$f>;
  my $i = index($s, "<canvas"); die "no <canvas>" if $i < 0;
  my ($head, $body) = (substr($s, 0, $i), substr($s, $i));
  $head =~ s/^<meta name="claude:viewport-fit-sides"[^\n]*\n//m;
  # tags only the hosted site needs (favicon, share card); kept out of the Artifact preview
  open my $g, "<:raw", "src/head-site.html" or die; my $site = <$g>;
  $head =~ s/(<meta name="description"[^\n]*\n)/$1$site/ or die "no description meta";
  print "<!doctype html>\n<html lang=\"en\">\n<head>\n<meta charset=\"utf-8\">\n<meta name=\"viewport\" content=\"width=device-width, initial-scale=1, viewport-fit=cover\">\n<meta name=\"theme-color\" content=\"#0c0a09\">\n$head</head>\n<body>\n$body</body>\n</html>\n";
' > index.html
echo "index.html gerado ($(wc -c < index.html) bytes)"
