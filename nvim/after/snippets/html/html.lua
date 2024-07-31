return {
    s({
        trig = "sst",
        dscr = "Starter code",
    },
    {
        t({"<!DOCTYPE html>", "<html lang=\"pt\">", "\t<head>",
        "\t\t<meta charset=\"UTF-8\">",
        "\t\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">",
        "\t\t<meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">",
        "\t\t<link rel=\"stylesheet\" href=\"style.css\">",
        "\t\t<title>"}), i(1), t({"</title>", "\t</head>", "\t<body>", "\t\t"}),
        i(2), t({"", "\t<script src=\"index.js\"></script>", "\t</body>", "</html>"}),
    }),

    s({
        trig = "<>>",
        dscr = "Create a tag with single line",
        regTrig = "false",
        priority = 100,
        snippetType = "autosnippet"
    },
    {
        t("<"), i(1, "tag"), i(3), t(">"), i(2), i(4), t("</"), rep(1), t(">"),
    }),

    s({
        trig = "<<>",
        dscr = "Create a tag with multiple line",
        regTrig = "false",
        priority = 101,
        snippetType = "autosnippet"
    },
    {
        t("<"), i(1, "tag"), t(" />"),
    }),

    s({
        trig = "lcm",
        dscr = "One line commentary",
    },
    {
        t("<!-- "), i(1), t(" -->"),
    }),
}
