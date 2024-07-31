return {
  s({
    trig = "str",
    dscr = "Standard string declaration",
  },
  {
    t("std::string"),
  }),

  s({
    trig = "endll",
    dscr = "Standard endline output",
  },
  {
    t("std::endl;"),
  }),

  s({
    trig = "coutt",
    dscr = "description",
  },
  {
    t("std::cout << "), i(1, "text"), t(" << std::endl;"),
  }),
}
