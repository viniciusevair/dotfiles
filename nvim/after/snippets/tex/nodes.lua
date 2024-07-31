return {
  s({
    trig = "\\node",
    dscr = "Write a node",
  },
  {
    t("\\node[main] ("), i(1, "nodeID"), t(") {$"), i(2, "nodeLabel"), t("$};"),
  }),

  s({
    trig = "\\nar",
    dscr = "Write a node",
  },
  {
    t("\\node[main] ("), i(1, "nodeID"), t(") [above right of = "),
    i(3, "n"), t("] {$"), i(2, "nodeLabel"), t("$};"),
  }),

  s({
    trig = "\\nal",
    dscr = "Write a node",
  },
  {
    t("\\node[main] ("), i(1, "nodeID"), t(") [above left of = "),
    i(3, "n"), t("] {$"), i(2, "nodeLabel"), t("$};"),
  }),

  s({
    trig = "\\nabove",
    dscr = "Write a node",
  },
  {
    t("\\node[main] ("), i(1, "nodeID"), t(") [above of = "),
    i(3, "n"), t("] {$"), i(2, "nodeLabel"), t("$};"),
  }),

  s({
    trig = "\\nbr",
    dscr = "Write a node",
  },
  {
    t("\\node[main] ("), i(1, "nodeID"), t(") [below right of = "),
    i(3, "n"), t("] {$"), i(2, "nodeLabel"), t("$};"),
  }),

  s({
    trig = "\\nbl",
    dscr = "Write a node",
  },
  {
    t("\\node[main] ("), i(1, "nodeID"), t(") [below left of = "),
    i(3, "n"), t("] {$"), i(2, "nodeLabel"), t("$};"),
  }),

  s({
    trig = "\\nbelow",
    dscr = "Write a node",
  },
  {
    t("\\node[main] ("), i(1, "nodeID"), t(") [below of = "),
    i(3, "n"), t("] {$"), i(2, "nodeLabel"), t("$};"),
  }),

  s({
    trig = "\\nright",
    dscr = "Write a node",
  },
  {
    t("\\node[main] ("), i(1, "nodeID"), t(") [right of = "),
    i(3, "n"), t("] {$"), i(2, "nodeLabel"), t("$};"),
  }),

  s({
    trig = "\\nleft",
    dscr = "Write a node",
  },
  {
    t("\\node[main] ("), i(1, "nodeID"), t(") [left of = "),
    i(3, "n"), t("] {$"), i(2, "nodeLabel"), t("$};"),
  }),
}
