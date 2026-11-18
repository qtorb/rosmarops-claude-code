---
name: rosmarops
description: Show the latest RosmarOps result and the command to run a full review.
---

If this session's context has a line that starts with "RosmarOps latest result:", show the person the rest of that line as it is.
Otherwise, run `rosmarops statusline` and show its one line as it is. If that command cannot run because of the sandbox, say that the latest result is shown when a new Claude Code session starts.
Then tell them that a full review runs in their own terminal, outside Claude Code, with: `rosmarops run`
Do not run `rosmarops run` yourself, and do not run any other command.
If `rosmarops` is not found, tell them RosmarOps is not installed on this computer and that they can get it at https://rosmarops.com. Say nothing else about it.
Answer in the language the person uses.
