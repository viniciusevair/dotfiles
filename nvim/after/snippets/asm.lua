return {
    s({
        trig = "sst",
        dscr = "Start an assembly code",
    },
    {
        t({ ".section .data", ".section .bss", ".section .text", ".globl main",
            "", "main:", "\t" }),
    }),

    s({
        trig = "<FS",
        dscr = "Start a function",
        snippetType = "autosnippet",
    },
    {
        t({ "pushq %rbp\t\t\t\t\t# Guarda a posição do %rbp.",
            "movq %rsp, %rbp\t\t\t\t# Move %rsp para a posição do %rbp.",
            "subq $" }), i(1, "0"),
            t(", %rsp"),
    }),

    s({
        trig = ">FE",
        dscr = "End a function",
        snippetType = "autosnippet",
    },
    {
        t( "addq $" ), i(1, "0"), t({ ", %rsp",
           "popq %rbp\t\t\t\t\t# Recupera a posição do %rbp.",
           "ret\t\t\t\t\t\t\t# Retorna ao chamador." }),
    }),
    s({
        trig = "pri",
        dscr = "Print something with the write syscall",
    },
    {
        t("movq $"), i(1, "CHAR_TO_PRINT"), t(", %rdi"),
        t({ "", "movq $" }), i(2, "PRINT_SIZE"), t(", %rsi"),
        t({ "", "call imprimeChar" }),

    }),
}
