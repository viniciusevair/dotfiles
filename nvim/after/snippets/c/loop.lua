return {
    s({
        trig = "while",
        dscr = "While function with single argument",
    },
    {
        t("while("), i(1, "condition"), t(")"),
        t({ "", "\t" }), i(0),
    }),

    s({
        trig = "mwhile",
        dscr = "While function with multiple arguments",
    },
    {
        t("while("), i(1, "condition"), t(") {"),
        t({ "", "\t" }), i(0),
        t({ "", "}" })
    }),

    s({
        trig = "for",
        dscr = "For function with single argument",
    },
    {
        t("for("), i(1, "i = 0"), t("; "), i(2, "i < n"), t("; "), i(3, "i++"),
        t(")"), t({ "", "\t" }), i(0),
    }),

    s({
        trig = "mfor",
        dscr = "For function with multiple argument",
    },
    {
        t("for("), i(1, "i = 0"), t("; "), i(2, "i < n"), t("; "), i(3, "i++"),
        t(") {"), t({ "", "\t" }), i(0),
        t({ "", "}" })
    }),
}
