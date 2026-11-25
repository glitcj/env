# Review notebooks

Use the destination specified by the calling skill. Keep the explanation high-level and easy to scan. Add detail when the user asks for it. Use tables and simple diagrams where they clarify the explanation.

Add runnable cells when they help the reader understand or experiment. Put a code cell containing only `# ----- student scratchpad -----` immediately after each runnable example.

Use Graphviz DOT for diagrams and embed rendered PNGs in the notebook so they work offline. Keep diagrams to 3–7 boxes. Use yellow for a decision, green for a good outcome, and red for a bad outcome.

Build the notebook with a small Python generator. Import `render_dot.py` from the `high` skill folder, where this guide lives. Its `dot_md()` helper needs the Graphviz `dot` command and returns Markdown with the PNG embedded as a data URI and the editable DOT source in a collapsed section.

```python
import sys

sys.path.insert(0, "<high skill folder>")
from render_dot import dot_md

cell = "## Overview\n\n" + dot_md("digraph { a -> b }", alt="a leads to b")
```

Before handing over the notebook, run each example cell and visually inspect a rendered PNG when you include a diagram.
