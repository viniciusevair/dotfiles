return {
    s({
        trig = "cmt",
        dscr = "Simple comment block",
    },
    {
        t("/* "), i(0), t(" */"),
    }),

    s({
        trig = "lcmt",
        dscr = "Long comment block",
    },
    {
        t({ "/*", " * " }), i(0), t({ "", " */" }),
    }),

    s({
        trig = "ifi",
        dscr = "If function with single argument",
    },
    {
        t("if("), i(1, "condition"), t(")"),
        t({ "", "\t" }), i(0),
    }),

    s({
        trig = "if",
        dscr = "If function with multiple arguments",
    },
    {
        t("if("), i(1, "condition"), t(") {"),
        t({ "", "\t" }), i(0),
        t({ "", "}" })
    }),

    s({
        trig = "mlc",
        dscr = "Allocate a memory dinamically",
    },
    {
        t("if(! ("), i(1, "ptr"), t(" = malloc(sizeof("), i(2, "int"),
        t(")))) {"),
        t({ "", "\tfprintf(stderr, \"Erro ao alocar memória\");", "\treturn " }),
        i(3, "NULL"), t({ ";", "}" }),
    }),

    s({
        trig = "clc",
        dscr = "Allocate a block of memory dinamically",
    },
    {
        t("if(! ("), i(1, "ptr"), t(" = calloc("), i(2, "1"), t(", sizeof("),
        i(3, "int"), t(")))) {"), 
        t({ "", "\tfprintf(stderr, \"Erro ao alocar memória\");", "\treturn " }),
        i(4, "NULL"), t({ ";", "}" }),
    }),

    s({
        trig = "null",
        dscr = "Writes NULL in full caps.",
    },
    {
        t("NULL"),
    }),

    s({
        trig = "return",
        dscr = "Prepare a return value.",
    },
    {
        t("return "), i(1, "NULL"), t(";"),
    }),

    s({
        trig = "pri",
        dscr = "Generic printf",
    },
    {
        t("printf(\""), i(1, "text"), t("\\n\""), i(2), t(");"),
    }),
}
