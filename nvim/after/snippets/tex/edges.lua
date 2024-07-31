return {
  s({
    trig = "\\edge",
    dscr = "Draw a direct edge between two vertexes",
  },
  {
    t("\\draw ("), i(1, "a"), t(") -- ("), i(2, "b"), t(");"),
  }),

  s({
    trig = "\\dedge",
    dscr = "Draw a direct edge between two vertexes",
  },
  {
    t("\\draw[->] ("), i(1, "a"), t(") -- ("), i(2, "b"), t(");"),
  }),

  s({
    trig = "\\aedge",
    dscr = "Draw a direct edge between two vertexes",
  },
  {
    t("\\draw ("), i(1, "a"), t(") to [out = "), i(3, "90"),
    t(", in = "), i(4, "90"), t(", looseness = "), i(5, "5"), t("] ("),
    i(2, "b"), t(");"),
  }),

  s({
    trig = "\\adedge",
    dscr = "Draw a direct edge between two vertexes",
  },
  {
    t("\\draw[->] ("), i(1, "a"), t(") to [out = "), i(3, "90"),
    t(", in = "), i(4, "90"), t(", looseness = "), i(5, "5"), t("] ("),
    i(2, "b"), t(");"),
  }),

  s({
    trig = "\\wedge",
    dscr = "Draw a direct edge between two vertexes",
  },
  {
    t("\\draw ("), i(1, "a"),
    t(") -- node[midway, "), i(3, "above right"), t(", sloped, pos = "),
    i(4, "0.5"), t("] "), t("{"), i(5, "+1"), t("} ("), i(2, "b"), t(");"),
  }),

  s({
    trig = "\\awedge",
    dscr = "Draw a direct edge between two vertexes",
  },
  {
    t("\\draw ("), i(1, "a"), t(") to [out = "), i(3, "90"),
    t(", in = "), i(4, "90"), t(", looseness = "), i(5, "5"), t("] "),
    t("node[midway, "), i(6, "above right"), t(", sloped, pos = "),
    i(7, "0.5"), t("] "), t("{"), i(8, "+1"), t("} ("), i(2, "b"), t(");"),
  }),

  s({
    trig = "\\adwedge",
    dscr = "Draw a direct edge between two vertexes",
  },
  {
    t("\\draw[->] ("), i(1, "a"), t(") to [out = "), i(3, "90"),
    t(", in = "), i(4, "90"), t(", looseness = "), i(5, "5"), t("] "),
    t("node[midway, "), i(6, "above right"), t(", sloped, pos = "),
    i(7, "0.5"), t("] "), t("{"), i(8, "+1"), t("} ("), i(2, "b"), t(");"),
  }),
}
