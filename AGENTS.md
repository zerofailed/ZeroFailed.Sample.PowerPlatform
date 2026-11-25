# Agent Instructions

<!-- >>> ai-agent-devcontainer -->
## Git worktrees

Create all git worktrees in the `/home/vscode/worktrees` folder.
<!-- <<< ai-agent-devcontainer -->

## Multi-root workspace

This repo is often worked on alongside its sibling ZeroFailed Power Platform repos, all of them mounted under `/workspaces/` in one shared dev container. Each one is a separate git repository, so run git commands from inside this repo, and put worktrees in `/home/vscode/worktrees/<repo>/<branch>`.
