return {
    s({
        trig = "sst",
        dscr = "Starter code, just the shebang, basically",
    },
    {
        t({"#!/usr/bin/env python3.11", "", ""}), i(0),
    }),
    s({
        trig = "pri",
        dscr = "Print function",
    },
    {
        t("print(f\""), i(1), t("\")"),
    }),
    s({
        trig = "spri",
        dscr = "Simple print function",
    },
    {
        t("print("), i(1), t(")"),
    }),
}
