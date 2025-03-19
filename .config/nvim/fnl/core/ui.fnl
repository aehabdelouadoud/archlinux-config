; NOTE: Coloscheme settings
(vim.cmd "let g:gruvbox_material_background = 'soft'")
(vim.cmd "colorscheme gruvbox-material")
(set vim.opt.laststatus 3)

; NOTE: My custom highlights
(vim.api.nvim_set_hl 0 "@lisp_punctuation_right.bracket" {:fg "#655D51"})
(vim.api.nvim_set_hl 0 "@conceal" {:fg "#D2A256"})
(vim.api.nvim_set_hl 0 "@tag" {:fg "#D8A657"})
(vim.api.nvim_set_hl 0 "@string" {:fg "#D6B593"})
(vim.api.nvim_set_hl 0 "@macro" {:fg "#7DAEA3"})

(vim.api.nvim_set_hl 0 "FloatBorder" {:fg "#D8A657"})


; (vim.api.nvim_set_hl 0 "@variable" {:fg "#EAA159"})
; (vim.api.nvim_set_hl 0 "NeoTreeNormalNC" {:fg "#32302F"})
; (vim.api.nvim_set_hl 0 "NeoTreeNormal" {:fg "#32302F"})
; (vim.api.nvim_set_hl 0 "@lisp_punctuation_left.bracket" {:fg "#D2A256"})

