local stages = require("notify.stages.slide")("top_down")
require("notify").setup({
    render = "compact",
    stages = {
        function(...)
            local opts = stages[1](...)
            if opts then
                opts.border = { "◈", "—", "◈", " ", "◈", "—", "◈", " ", }
            end
            return opts
        end,
        unpack(stages, 2),
    },

    timeout = 2500,
    max_height = function()
        return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
        return math.floor(vim.o.columns * 0.75)
    end,
    background_colour = "#000000",
})
