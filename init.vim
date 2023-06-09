" === basic settings
" file type plugin indent on
syntax on
set nobackup
set hidden
set number
set relativenumber
set cursorline
set scrolloff=8
set updatetime=300
set shortmess+=c
set signcolumn=yes
set ignorecase
set smartcase
set noshowmode
set splitright
set splitbelow
set shiftwidth=2
set softtabstop=2
set tabstop=2
set autoindent
set list
set autochdir
set listchars=tab:\|\ ,trail:▫
set spelllang=en_us
inoremap <C-m> <c-g>u<ESC>[s1z=`]a<c-g>u
autocmd BufRead,BUfNewFIle *.tex setlocal spell

" set pumblend=15 ==> confict with colorscheme


" === map
let mapleader=" "
noremap ; :
inoremap jk <ESC>
vnoremap jk <ESC>
noremap ` ~
noremap s <nop>

nnoremap H 0
nnoremap L $

nnoremap <Leader>hl :nohlsearch<CR>
noremap <Leader>rc :source $HOME/.config/nvim/init.vim<CR>

" compile
noremap R :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'python'
		set splitbelow
		:sp
		:term python3 %
	endif
endfunc

" ==== vim-plug =====
call plug#begin('$HOME/.config/nvim/plugged')

" start
Plug 'goolord/alpha-nvim'

" Themes
Plug 'morhetz/gruvbox'
Plug 'connorholyday/vim-snazzy'

" nvim-tree
Plug 'nvim-tree/nvim-tree.lua'

" Tex
Plug 'lervag/vimtex'

" Snips
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'


" coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" nvim-treesitter
Plug 'nvim-treesitter/nvim-treesitter'

" floaterm
Plug 'voldikss/vim-floaterm'

" goyo
Plug 'junegunn/goyo.vim'



call plug#end()



"" ======= Settings for plugins ====

" ultsnips
let g:UltiSnipsExpandTrigger="<nop>"

" goyo

" vimtex
"
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
set conceallevel=1
let g:tex_conceal='abdmg'
let maplocalleader = " "
let g:vitex_quickfix_mode = 0

map <Leader>lt :VimtexTocToggle<CR>
let g:vimtex_toc_config = {
\ 'name' : 'TOC',
\ 'layers' : ['content', 'todo', 'include'],
\ 'split_width' : 25,
\ 'todo_sorted' : 0,
\ 'show_help' : 0,
\ 'show_numbers' : 1,
\}

" coc-nvim
let g:coc_global_extensions = [
			\ 'coc-vimlsp',
			\ 'coc-json',
			\ 'coc-vimtex',
			\ 'coc-snippets',
			\ 'coc-translator']
" tab to trigger & <CR> to select & <c-o> to suggest
" default select the first trigger, <c-u> to break
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-o> coc#refresh()

" jump to error
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

nmap mm <Plug>(coc-translator-p)
vmap mm <Plug>(coc-translator-pv)

"nmap mr <Plug>(coc-translator-r)
"vmap mr <Plug>(coc-translator-rv)
"map me <Plug>(cog-translator-e)
"
"

" cog-snippets
imap <C-l> <Plug>(coc-snippets-expand)
vmap <C-j> <Plug>(coc-snippets-select)
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'

" floaterm
noremap tt :FloatermNew<CR>

" vim-tree sitter
" alpha-vim
"
" tree
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
nnoremap <Leader>e :NvimTreeToggle<CR>
lua << EOF
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
	view = {
		mappings = {
			list = {
			{ key ="P", action= "cd" },
			{ key ="<Tab>", action= "expand" },
			{ key ="A", action= "create" },
			{ key ="<Esc>", action= "close" },
			{ key ="<BS>", action= "dir_up" },
		},
	},
		float = {
			enable = true,
			open_win_config = function()
			local columns = vim.o.columns
			local lines = vim.o.lines
			local width = math.max(math.floor(columns * 0.5), 50)
			local height = math.max(math.floor(lines * 0.5), 20)
			local left = math.ceil((columns - width) * 0.5)
			local top = math.ceil((lines - height) * 0.5 - 2)
			return { relative = "editor", border = "rounded", width = width, height = height, row = top, col = left }
			end,
		}
	}
})
EOF


" ===== Final =====
colorscheme gruvbox
exec "nohls"
