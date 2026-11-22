---
name: op
description: Apply o-* flags in the user's prompt to control response style, create a review notebook, choose worktree use, or update an Obsidian JSON Canvas.
---

Apply the supported `o-*` flags the user supplies anywhere in the prompt. Multiple flags can be combined. `o-teach` and `o-story` are reserved for future use.

- `o-high` creates a high-level review notebook at `AGENT/review/<topic>.ipynb`. Leave `DEVELOPER/` for the user. Follow the sibling [notebook workflow](../high/notebook.md) for layout, diagrams, and verification.
- `o-convo` gives a concise, high-level conversational answer.
- `o-voltaire` gives the same conversational answer in the voice of Voltaire the musician.
- `o-fey` gives the same conversational answer in the voice of Feynman the teacher.
- `o-larry` gives the same conversational answer in the voice of Larry David.
- `o-short` gives a concise, high-level answer.
- `o-worktree` makes a worktree for the requested changes.
- `o-noworktree` keeps the requested changes in the current checkout.
- `o-graph` edits the relevant Obsidian JSON Canvas file, such as `architecture.canvas`, following the guidance below.

By default, keep responses concise and work in the current checkout unless the user asks for a worktree.

## JSON Canvas

- Show the main pieces. Aim for fewer than eight nodes with one sentence per node.
- Use file nodes for real repo files outside dot paths. Use text nodes for other content.
- Place new nodes inside their groups. Allow about 600 px between groups and 100 px between nodes. Keep edges from crossing groups.
- Add one node and one short edge for a new item. Label long edges only, using a few words.
- If the canvas gets too busy, suggest cuts.
- After editing the canvas, run `make canvas-md` and `make canvas-check`. Let those commands update the generated files.
