" Vim-Plug plugin manager setup
call plug#begin('~/.vim/plugged')

" Gruvbox Material theme plugin
Plug 'sainnhe/gruvbox-material'

" Initialize plugin system
call plug#end()

" Enable syntax highlighting
syntax enable

" Important!!
if has('termguicolors')
    set termguicolors
endif

" For dark version.
set background=dark

" Set contrast.
" This configuration option should be placed before `colorscheme gruvbox-material`.
" Available values: 'hard', 'medium'(default), 'soft'
let g:gruvbox_material_background = 'soft'

" For better performance
let g:gruvbox_material_better_performance = 1

colorscheme gruvbox-material

" Enable line numbers
set relativenumber
set number

" Enable auto-indentation
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

