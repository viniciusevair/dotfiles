return {
    s({
        trig = "sst",
        dscr = "Start an assembly code",
    },
    {
        t({ ".section .data", ".section .bss", ".section .text", ".globl _start" }),
    }),

    s({
        trig = "<FS",
        dscr = "Start a function",
        snippetType = "autosnippet",
    },
    {
        t({ "pushq %rbp", "movq %rsp, %rbp", "subq $" }), i(1, "0"), t(", %rsp"),
    }),
}
