return {
  s({
    trig = "str",
    dscr = "Standard string declaration",
  },
  {
    t("std::string"),
  }),

  s({
    trig = "endl",
    dscr = "Standard endline output",
  },
  {
    t("std::endl"),
  }),

  s({
    trig = "coutt",
    dscr = "description",
  },
  {
    t("std::cout << "), i(1, "text"), t(" << std::endl;"),
  }),

  s({
    trig = "xmln",
    dscr = "description",
  },
  {
    t("pugi::xml_node"),
  }),
}
