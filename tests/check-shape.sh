#!/bin/sh
# BV-253 §A.7: the plugin carries nothing that runs code beyond its one hook.
# It fails if bin/ exists, if plugin.json declares anything but the keys of
# §A.1, or if hooks/hooks.json is anything but the SessionStart hook of §A.3.
set -eu
cd "$(dirname "$0")/.."
status=0
if [ -e bin ]; then echo "FAIL: bin/ exists"; status=1; fi
keys=$(jq -r 'keys_unsorted | sort | join(",")' .claude-plugin/plugin.json)
want="author,description,displayName,homepage,license,name,repository,version"
if [ "$keys" != "$want" ]; then echo "FAIL: plugin.json keys $keys, want $want"; status=1; fi
hooks=$(jq -c '.' hooks/hooks.json)
want_hooks='{"hooks":{"SessionStart":[{"hooks":[{"type":"command","command":"rosmarops","args":["session-check"],"timeout":3}]}]}}'
if [ "$hooks" != "$want_hooks" ]; then echo "FAIL: hooks.json is $hooks"; status=1; fi
for d in agents commands monitors; do
  if [ -e "$d" ]; then echo "FAIL: $d/ exists"; status=1; fi
done
for f in .mcp.json .lsp.json; do
  if [ -e "$f" ]; then echo "FAIL: $f exists"; status=1; fi
done
[ "$status" -eq 0 ] && echo "ok: plugin shape"
exit "$status"
