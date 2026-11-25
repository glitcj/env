"""Render a Graphviz DOT diagram to a PNG embedded in markdown.

Why: ```mermaid blocks in notebook markdown cells do NOT render in most viewers
(VS Code without extensions, classic Jupyter...). A PNG embedded as a data URI
renders everywhere, offline, and nothing leaves the machine.

Needs: `brew install graphviz` (the `dot` binary).

Usage from a notebook generator script:
    import sys; sys.path.insert(0, "<this folder>")
    from render_dot import dot_md
    cell_source = "## Title\n\n" + dot_md('digraph { A -> B }', alt="A to B")

Returns markdown: the image, then the DOT source in a collapsed <details> so the
diagram stays editable. The default style (white background, rounded light
boxes, Helvetica) is prepended for you, so just write nodes and edges.
"""
import base64, subprocess

STYLE = """
  bgcolor="white"; rankdir=LR; pad=0.3; nodesep=0.5; ranksep=0.7;
  node [shape=box, style="rounded,filled", fillcolor="#f3f6fa", color="#8a9bb0",
        fontname="Helvetica", fontsize=13, margin="0.25,0.15"];
  edge [color="#6b7a8c", fontname="Helvetica", fontsize=11, arrowsize=0.8];
"""

def dot_png(src: str, dpi: int = 110) -> bytes:
    src = src.strip()
    # inject the default style right after the opening brace
    head, _, body = src.partition("{")
    full = f"{head}{{{STYLE}{body}"
    return subprocess.run(["dot", "-Tpng", f"-Gdpi={dpi}"], input=full.encode(),
                          capture_output=True, check=True).stdout

def dot_md(src: str, alt: str = "diagram", dpi: int = 110) -> str:
    png = base64.b64encode(dot_png(src, dpi)).decode()
    return (f"![{alt}](data:image/png;base64,{png})\n\n"
            f"<details><summary>diagram source (graphviz)</summary>\n\n```dot\n{src.strip()}\n```\n\n</details>")

if __name__ == "__main__":
    import sys
    sys.stdout.buffer.write(dot_png(sys.stdin.read()))
