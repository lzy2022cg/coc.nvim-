call plug#begin('~/.vim/plugged')
" Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

"中间是我自己加的
set number
nmap \w :wq<CR>
nmap \q :q<CR>
set guicursor=a:block
colorscheme elflord
set hlsearch     "打开vim的搜索结果高亮提示
set cindent      "打开vim的「cindent」自动缩进功能
set tabstop=4 "将「tabstop 设为「4」
set shiftwidth=4 "设置自动缩进为4
"
hi CocFloating ctermfg=253 ctermbg=16

"

"vim使用但nvim不使用的
" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" utf-8 byte sequence
"set encoding=utf-8
" Some servers have issues with backup files, see #649
"set nobackup
"set nowritebackup

"设置状态栏和状态栏的信息
set laststatus=2
set statusline=%#filepath#[%{expand('%:p')}][%{strlen(&fenc)?&fenc:&enc},\ %{&ff},\%{strlen(&filetype)?&filetype:'plain'}]%{FileSize()}%{IsBinary()}%=%#position#%c,%l/%L\ [%3p%%]

hi filepath cterm=none ctermbg=238 ctermfg=40
hi filetype cterm=none ctermbg=238 ctermfg=45
hi filesize cterm=none ctermbg=238 ctermfg=225
hi position cterm=none ctermbg=238 ctermfg=228

function IsBinary()
    if (&binary == 0)
        return ""
    else
        return "[BINARY]"
    endif
endfunction

function FileSize()
    let bytes = getfsize(expand("%:p"))
    if bytes <= 0
        return "[EMPTY]"
    endif
    if bytes < 1024
        return "[" . bytes . "B]"
    elseif bytes < 1048576
        return "[" . (bytes / 1024) . "KB]"
    else
        return "[" . (bytes / 1048576) . "MB]"
    endif
endfunction

"更新光标时间
set updatetime=400

"为了避免诊断信息出现或解决时文字发生移动，应始终显示标志列（即 Vim 窗口左侧的竖线列）
set signcolumn=no 

"通过Tab键来选择自动补全列表
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

"[g 和 ]g 用于导航到代码的诊断位置，可以在不同的错误和警告之间切换；
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" 用于导航到代码的定义位置，可以让你快速跳到函数、类和变量等的定义处；
nmap <silent> gd <Plug>(coc-definition)
"用于导航到代码的类型定义位置；
nmap <silent> gy <Plug>(coc-type-definition)
"用于导航到代码的实现位置；
nmap <silent> gi <Plug>(coc-implementation)
"用于导航到代码的引用位置；
nmap <silent> gr <Plug>(coc-references)

"K 用于在预览窗口中显示代码的文档注释
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

"自动补全列表弹出时间
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming, <leader>rn: 假设你有一个变量名为foo，它在某个Python文件中多次出现。 现在你想将这个变量名改为bar，但你不想一个个手动修改所有的出现。你可以将光标放在foo上，然后按下<leader>rn，这时一个输入框会弹出，你输入新的变量名bar并按下回车键，coc.nvim插件就会将所有的foo重命名为bar。
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

let g:coc_snippet_next = '<c-g>'

"表示将文本包装到屏幕宽度，从而避免文本超出屏幕而需要水平滚动
set wrap
"控制鼠标
set mouse=a
set selection=exclusive
set selectmode=mouse,key
set t_Co=256
set showmode
map <C-n> :call SwitchMouseMode()<CR>
map! <C-n> <Esc>:call SwitchMouseMode()<CR>
function SwitchMouseMode()
    if (&mouse == "a")
            let &mouse = ""
        echo "Mouse is disabled."
    else
        let &mouse = "a
        echo "Mouse is enabled."
    endif
endfunction

map <C-f> :call SwitchFullSimpleMode()<CR>
map! <C-f> <Esc>:call SwitchFullSimpleMode()<CR>
function SwitchFullSimpleMode()
    if (&mouse == "a")
        let &mouse = ""
        set nocindent
        set nonumber
        set wrap
        echo "Switch to simple mode.(nomouse, nonumber, nocindent, wrap)"
    else
        let &mouse = "a"
        set cindent
        set number
        set nowrap
        echo "Switch to full mode.(mouse, number, cindent, nowrap)"
    endif
endfunction

map <F5> :call CompileRunGcc()<CR>
" 设置编译运行命令函
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec '!gcc % -o %<'
        exec '!./%<'
    elseif &filetype == 'cpp'
        exec '!g++ % -o %<'
        exec '!./%<'
    elseif &filetype == 'python'
        exec '!python3 %'
    elseif &filetype == 'java'
        exec '!javac % && java %<'
    elseif &filetype == 'sh'
        exec '!bash %'
    endif
endfunc

" 设置快捷键 F5 来编译并执行代码
nnoremap <F5> :call CompileRunGcc()<CR>

func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec '!gcc % -o %<'
        exec '!time ./%<'
    elseif &filetype == 'cpp'
        exec '!g++ % -o %<'
        exec '!time ./%<'
    elseif &filetype == 'python'
        exec '!time python3 %'
        elseif &filetype == 'java'
                exec '!time java %'
    elseif &filetype == 'sh'
        :!time bash %
    endif
endfunc

"定位到上次打开的地方
if has("autocmd")
  autocmd BufReadPost *
        \ if line("'\"") >= 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
endif

