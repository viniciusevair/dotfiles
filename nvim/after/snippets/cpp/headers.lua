return {
    s({
        trig = "ifndef",
        dscr = "Inclusion guard",
    },
    {
        t("#ifndef __"), i(1),
        t({"", "#define __"}), rep(1),
        t({"", ""}), i(0),
        t({"", "#endif"}),
    }),

    s({
        trig = "sst",
        dscr = "Standard code starter.",
    },
    {
        t({ "#include <iostream>", "" }),
        t({ "", "int main(int argc, char *argv[]) {", "\t" }), i(0),
        t({ "", "", "\treturn 0;", "}" }),
    }),

    s({
        trig = "sls1",
        dscr = "Standard libraries loader.",
    },
    {
        t({ "#include <iostream>" }), 
    }),

    s({
        trig = "#inca",
        dscr = "Include a \"library\".",
    },
    {
        t("#include \""), i(1, "mylib.h"), t("\""),
    }),

    s({
        trig = "#incb",
        dscr = "Include a <library>.",
        priority = 2000,
    },
    {
        t("#include <"), i(1, "stdio.h"), t(">"),
    }),

    s({
        trig = "#def",
        dscr = "Define a MACRO.",
    },
    {
        t("#define "), i(1),
    }),

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
}
