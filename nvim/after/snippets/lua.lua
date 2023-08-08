return {
    s({
        trig = "mksnip",
        dscr = "Create a snippet!"
    }, 
    {
        t("s({"),
        t({ '', '\ttrig = "' }), i(1, "trigger"), t('",'),
        t({ '', '\tdscr = "' }), i(2, "description"), t('",'),
        t({ '', '},', '{', '\t' }), i(3, "snippet"), t({ '', '}),' }),
    }),

    s({
        trig = "kmp",
        dscr = "Prepare a keymap",
    },
    {
        t("vim.keymap.set(\""), i(1, "n"), t("\", \""), i(2, "<Shortcut>"),
        t("\", \""), i(3, "<Command>"), t("\")"),
    }),
}
