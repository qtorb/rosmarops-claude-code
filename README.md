# RosmarOps for Claude Code

Each time you open a Claude Code session, RosmarOps tells you in one line what changed in what your agents can do: new `allow` rules, hooks, MCP servers, skills or subagents, in your user settings or in the project you just opened. If nothing changed, it says nothing.

`/rosmarops` shows your latest result and the command to run a full review in your terminal.

## What it needs
RosmarOps installed on this computer: https://rosmarops.com
This plugin does not include RosmarOps. It calls the program you installed, so updates and the integrity check stay with the program.

## Install
In a Claude Code session:
/plugin install rosmarops --marketplace qtorb/rosmarops-claude-code

Or from your shell:
claude plugin marketplace add qtorb/rosmarops-claude-code
claude plugin install rosmarops@rosmarops

## What it does not do
- It does not use the network.
- It does not change your settings or your files.
- It never blocks a session: if RosmarOps takes more than a second, it stays silent.
- It does not read the content of your files, your keys or your conversations.

## Status line
A plugin cannot set Claude Code's status line. To add it, open your RosmarOps report and follow «What RosmarOps has installed».

## Uninstall
/plugin uninstall rosmarops

## License
AGPL-3.0, like RosmarOps. Methodology and trust model: https://rosmarops.com
