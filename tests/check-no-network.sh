#!/bin/sh
# BV-253 §A.7: no file of the plugin may reach the network. It fails when a
# file holds curl, wget, Invoke-WebRequest, http:// or https://, except the
# links to rosmarops.com and github.com/qtorb in README.md,
# .claude-plugin/plugin.json and skills/rosmarops/SKILL.md.
# Not scanned: .git, LICENSE (the AGPL-3.0 text, kept identical to
# qtorb/rosmarops) and the checks themselves (tests/, .github/), which hold
# these words as patterns.
set -eu
cd "$(dirname "$0")/.."
status=0
files=$(find . -type f -not -path './.git/*' -not -path './tests/*' -not -path './.github/*' -not -name LICENSE | sort)
for f in $files; do
  case "$f" in
    ./README.md|./.claude-plugin/plugin.json|./skills/rosmarops/SKILL.md) allowed=1 ;;
    *) allowed=0 ;;
  esac
  if grep -nE 'curl|wget|Invoke-WebRequest' "$f"; then
    echo "FAIL: $f calls a download tool"; status=1
  fi
  urls=$(grep -oE 'https?://[^ )`"<>]*' "$f" | sed 's/[.,;:]*$//' || true)
  for u in $urls; do
    case "$u" in
      https://rosmarops.com|https://rosmarops.com/*|https://github.com/qtorb/*)
        if [ "$allowed" -eq 0 ]; then echo "FAIL: $f links $u"; status=1; fi ;;
      *) echo "FAIL: $f links $u"; status=1 ;;
    esac
  done
done
[ "$status" -eq 0 ] && echo "ok: no network in the plugin"
exit "$status"
