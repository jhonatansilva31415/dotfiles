call plug#begin()
Plug 'morhetz/gruvbox'
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'joshdick/onedark.vim'
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rakr/vim-one'
Plug 'Omnisharp/omnisharp-vim' " C# dev
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'
Plug 'peitalin/vim-jsx-typescript'
Plug 'puremourning/vimspector' " debug in neovim
Plug 'mxw/vim-jsx'
Plug 'dart-lang/dart-vim-plugin'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'branch': 'release/0.x'
    \ }
call plug#end()

" Vim inspector 
let g:vimspector_enable_mappings='HUMAN'

syntax on
let g:airline_theme='one'
colorscheme one
set background=dark " for the dark version
set relativenumber

" Test git script 
" For Neovim 0.1.3 and 0.1.4 - https://github.com/neovim/neovim/pull/2198
if (has('nvim'))
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif

" For Neovim > 0.1.5 and Vim > patch 7.4.1799 - https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162
" Based on Vim patch 7.4.1770 (`guicolors` option) - https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd
" https://github.com/neovim/neovim/wiki/Following-HEAD#20160511
if (has('termguicolors'))
  set termguicolors
endif

set encoding=UTF-8
set hidden
set number
set relativenumber
set mouse=a
set inccommand=split
set tabstop=2
set shiftwidth=2
set expandtab

let mapleader="\<space>"
" Vimspector
nnoremap <leader>dd :call vimspector#Launch()
" Fuzy search
nnoremap <leader>fs :FZF<cr>
" Remap save vim to space space
nnoremap <leader><leader> :update<cr>
nnoremap <leader>x :call delete(expand('%'))
"" FZF settings 

nnoremap <leader>fp :call fzf#run(fzf#vim#with_preview({'options': '--reverse --prompt "Select file from my PERSONAL notes directory: "', 'down': 20, 'dir': '/storage/docs/notes/personal', 'sink': 'e' }))<CR>| " open file from my PERSONAL notes directory
nnoremap <leader>fw :call fzf#run(fzf#vim#with_preview({'options': '--reverse --prompt "Select file from my WORK notes directory: "', 'down': 20, 'dir': '/storage/docs/notes/work', 'sink': 'e' }))<CR>| " open file from my WORK notes directory

command! -bang -nargs=* Zettel call fzf#vim#grep( 'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1, fzf#vim#with_preview({'dir': '$HOME/second_brain/zettels'}), <bang>0)
nnoremap <F2> :Zettel()<CR>| " function key: open zettelkasten notes searching by word

command! -bang -nargs=* ProjectFilesRG call fzf#vim#grep( 'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1, fzf#vim#with_preview({'dir': '$HOME/second_brain'}), <bang>0)
nnoremap <F2> :ProjectFilesRG()<CR>| " function key: open second brain folder to search inside files

command! -bang ProjectFiles call fzf#vim#files('$HOME/second_brain', <bang>0)
nnoremap <F1> :ProjectFiles<CR>| " function key: open second brain folder to search for files

"-------------------------------------------
"" Coc settings 
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


" TSX and JSX
" set filetypes as typescriptreact
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact

" dark red
hi tsxTagName guifg=#E06C75
hi tsxComponentName guifg=#E06C75
hi tsxCloseComponentName guifg=#E06C75

" orange
hi tsxCloseString guifg=#F99575
hi tsxCloseTag guifg=#F99575
hi tsxCloseTagName guifg=#F99575
hi tsxAttributeBraces guifg=#F99575
hi tsxEqual guifg=#F99575

" yellow
hi tsxAttrib guifg=#F8BD7F cterm=italic
