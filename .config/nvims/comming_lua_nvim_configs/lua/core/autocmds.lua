local function _1_()
  vim.b.miniindentscope_disable = true
  return nil
end
vim.api.nvim_create_autocmd("FileType", { callback = _1_, pattern = { "dashboard", "lazy", "mason" } })

local function _2_()
  local floating = (vim.api.nvim_win_get_config(0).relative ~= "")
  return vim.diagnostic.config({ virtual_lines = not floating, virtual_text = floating })
end
vim.api.nvim_create_autocmd("WinEnter", { callback = _2_ })

local function _3_()
  require("ufo").detach()
  vim.opt_local.foldenable = false
  vim.opt_local.foldcolumn = "0"
  return nil
end
vim.api.nvim_create_autocmd("FileType",
  { callback = _3_, pattern = { "nvcheatsheet", "neo-tree", "aerial", "leetcode.nvim" } })

local function _4_()
  vim.opt_local.number = false
  vim.opt_local.relativenumber = false
  return nil
end
vim.api.nvim_create_autocmd("FileType", { callback = _4_, pattern = "oil" })

local function _5_()
  vim.opt_local.foldmethod = "manual"
  vim.opt_local.foldenable = false
  return nil
end
vim.api.nvim_create_autocmd("FileType", { callback = _5_, pattern = { "oil", "neo-tree" } })

local function _6_()
  vim.opt.expandtab = false
  return nil
end
vim.api.nvim_create_autocmd("FileType", { callback = _6_, pattern = { "cmake" } })

local function _7_()
  vim.opt.wrap = true
  return nil
end
vim.api.nvim_create_autocmd("FileType", { callback = _7_, pattern = { "tex" } })

local function sync_lsp_lines_on_split_change()
  local lsp_lines_on = false
  local function set_lsp_lines()
    return require("lsp_lines").toggle()
  end
  return vim.api.nvim_create_autocmd("WinEnter", { callback = set_lsp_lines })
end
sync_lsp_lines_on_split_change()
local function _8_()
  vim.opt_local.colorcolumn = ""
  return nil
end
vim.api.nvim_create_autocmd("FileType",
  { callback = _8_, pattern = { "markdown", "text", "json", "dashboard", "lazy", "mason", "neeotree", "leetcode.nvim", "aerial", "nvcheatsheet", "oil", "fennel" } })
vim.api.nvim_create_autocmd("User", { callback = "On_open", pattern = "ZenMode" })
vim.api.nvim_create_autocmd("User", { callback = "On_close", pattern = "ZenMode" })
return vim.api.nvim_create_autocmd("CmdlineEnter", { command = "normal! zx", pattern = "*" })
