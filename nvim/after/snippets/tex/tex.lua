return {
  s({
    trig = "sst",
    dscr = "Start a new document",
  },
  {
    t("\\documentclass{"), i(1, "article"), t("}"),
    t({ "", "", "\\begin{document}", "", "" }), i(0),
    t({ "", "", "\\end{document}" }),
  }),

  s({
    trig = "\\grafo",
    dscr = "Start a graph tikz drawing",
  },
  {
    t("\\begin{tikzpicture}[node distance={15mm}, thick, "),
    t({ "main/.style = {draw, circle}]", "" }), i(0),
    t({ "", "\\end{tikzpicture}" })
  }),
}
