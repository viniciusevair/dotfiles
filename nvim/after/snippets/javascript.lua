return {
    s({
        trig = "mmatrix",
        dscr = "Create a matrix filled with zeroes.",
    },
    {
        t("let "), i(1, "matrix"), t(" = Array.from({ length: "),
        i(2, "rows"), t(" }, () => new Array("), i(3, "columns"),
        t(").fill(0));"),
    }),
}
