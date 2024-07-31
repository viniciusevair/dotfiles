return {
    s({
        trig = "sst",
        dscr = "Code starter",
    },
    {
        t({ "public class Main {", "\tpublic static void main(String args[]) {", "\t\t" }),
        i(1), t({ "", "\t}", "}" }),
    }),

    s({
        trig = "setF",
        dscr = "Create a set function",
    },
    {
        i(1, "public"), t(" void set"), i(2, "Function"), t(" ("), i(3),
        t({ ") {", "\t" }), i(4), t({"", "}"})
    }),

    s({
        trig = "getF",
        dscr = "Create a get function",
    },
    {
        i(1, "public"), t(" "), i(2, "int"), t(" get"), i(3, "Function"), t(" ("), i(4),
        t({ ") {", "\treturn this." }), i(5), t({"", "}"})
    }),
}
