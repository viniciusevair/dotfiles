-- Weird file as some plugin specs gets override by lazy runtime order

-- Fix for Noice float window not having a cursor.
vim.api.nvim_set_hl(0, "NoiceCursor", { bg = "#ffffff", bold = true, fg = "#000000" })

-- Indent Blankline highlight colors.
vim.api.nvim_set_hl(0, "IndentBlankLineContextChar", {fg = "#ebc06d", bg = "none"})
--vim.api.nvim_set_hl(0, "IndentBlankLineChar", {fg = "#666666", bg = "none"})

-- Prettier config
vim.g['prettier#quickfix_enabled'] = '0'
vim.g['prettier#exec_cmd_async'] = '1'
vim.g['prettier#config#single_quote'] = 'true'
vim.g['prettier#config#trailing_comma'] = 'es5'

-- Notify colortable. It's the default but its good to have here just in case.
vim.api.nvim_set_hl(0, "NotifyINFOBorder",  { fg = "#4F6752"  })
vim.api.nvim_set_hl(0, "NotifyINFOIcon",    { fg = "#A9FF68"  })
vim.api.nvim_set_hl(0, "NotifyINFOTitle",   { fg = "#A9FF68"  })
vim.api.nvim_set_hl(0, "NotifyINFOBody",    { link = "Normal" })

vim.api.nvim_set_hl(0, "NotifyERRORBorder", { fg = "#8A1F1F"  })
vim.api.nvim_set_hl(0, "NotifyERRORIcon",   { fg = "#F70067"  })
vim.api.nvim_set_hl(0, "NotifyERRORTitle",  { fg = "#F70067"  })
vim.api.nvim_set_hl(0, "NotifyERRORBody",   { link = "Normal" })

vim.api.nvim_set_hl(0, "NotifyWARNBorder",  { fg = "#79491D"  })
vim.api.nvim_set_hl(0, "NotifyWARNIcon",    { fg = "#F79000"  })
vim.api.nvim_set_hl(0, "NotifyWARNTitle",   { fg = "#F79000"  })
vim.api.nvim_set_hl(0, "NotifyWARNBody",    { link = "Normal" })

vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", { fg = "#8B8B8B"  })
vim.api.nvim_set_hl(0, "NotifyDEBUGIcon",   { fg = "#8B8B8B"  })
vim.api.nvim_set_hl(0, "NotifyDEBUGTitle",  { fg = "#8B8B8B"  })
vim.api.nvim_set_hl(0, "NotifyDEBUGBody",   { link = "Normal" })

vim.api.nvim_set_hl(0, "NotifyTRACEBorder", { fg = "#4F3552"  })
vim.api.nvim_set_hl(0, "NotifyTRACEIcon",   { fg = "#D484FF"  })
vim.api.nvim_set_hl(0, "NotifyTRACETitle",  { fg = "#D484FF"  })
vim.api.nvim_set_hl(0, "NotifyTRACEBody",   { link = "Normal" })
