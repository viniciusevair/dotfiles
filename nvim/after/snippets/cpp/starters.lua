return {
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
        t({ "#include <stdio.h>", "#include <stdlib.h>" }), 
    }),

    s({
        trig = "incla",
        dscr = "Include a \"library\".",
    },
    {
        t("#include \""), i(1, "mylib.h"), t("\""),
    }),

    s({
        trig = "inclb",
        dscr = "Include a <library>.",
        priority = 2000,
    },
    {
        t("#include <"), i(1, "stdio.h"), t(">"),
    }),

    s({
        trig = "def",
        dscr = "Define a MACRO.",
    },
    {
        t("#define "), i(1),
    }),
}
