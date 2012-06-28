" просматриваем ман-страницы в отдельном окне vim'a с подсвечиванием и т.п.
" Эта директива должна быть в начале файла .vimrc, иначе она перезапишет
" остальные настройки.
"-------------------------------------------------------------------------
" :Man man
"-------------------------------------------------------------------------
" Local mappings:
" CTRL-] Jump to the manual page for the word under the cursor.
" CTRL-T Jump back to the previous manual page.

:runtime! ftplugin/man.vim

filetype off
call pathogen#infect()
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()
filetype plugin indent on
"-------------------------------------------------------------------------------------------------------

set nobackup                            "не создавать файлы с резервной копией (filename.txt~)"
set history=50                          "сохранять 50 строк в истории командной строки
set ruler                               "постоянно показывать позицию курсора
set incsearch                           "показывать первое совпадение при наборе шаблона
set hlsearch                            "подсветка найденного
"set mouse=a                             "используем мышку
set autoindent                          "включаем умные отступы
set smartindent
set ai                                  "при начале новой строки, отступ копируется из предыдущей
set ignorecase                          "игнорируем регистр символов при поиске
set background=dark                     "фон терминала - темный
set ttyfast                             "коннект с терминалом быстрый
set visualbell                          "мигаем вместо пищания
set showmatch                           "показываем открывающие и закрывающие скобки
set shortmess+=tToOI                    "убираем заставку при старте
set rulerformat=%(%l,%c\ %p%%%)         "формат строки состояния строка х столбец, сколько прочитано файла в %
set wrap                                "не разрывать строку при подходе к краю экрана
set linebreak                           "переносы между видимыми на экране строками только между словами
set tabstop=4                           "размер табуляции
set shiftwidth=4                        "число пробелов, используемых при автоотступе
set expandtab                           "Заменяем табуляции пробелами (use :retab dude)
set t_Co=256                            "включаем поддержку 256 цветов
set wildmenu                            "красивое автодополнение
set wcm=<Tab>                           "WTF? but all work
set whichwrap=<,>,[,],h,l               "не останавливаться курсору на конце строки
set autowrite                           "автоматом записывать изменения в файл при переходе к другому файлу
set encoding=utf8                       "кодировка по дефолту
set termencoding=utf8                   "Кодировка вывода на терминал
set fileencodings=utf8,cp1251,koi8r     "Возможные кодировки файлов (автоматическая перекодировка)
set showcmd showmode                    "показывать незавершенные команды и текущий режим
set splitbelow                          "новое окно появляется снизу
set autochdir                           "текущий каталог всегда совпадает с содержимым активного окна
set stal=2                              "постоянно выводим строку с табами
set tpm=100                             "максимальное количество открытых табов
set wak=yes                             "используем ALT как обычно, а не для вызова пункта мени
set dir=~/.vim/swapfiles                "каталог для сохранения своп-файлов
set noex                                "не читаем файл конфигурации из текущей директории
set ssop+=resize                        "сохраняем в сессии размер окон Vim'а
"set list                                "Отображаем табуляции и конечные пробелы...
set listchars=tab:→→,trail:⋅
"set listchars=trail:⋅
set clipboard=unnamed                   "использовать иксовый буфер как основной
"-------------------------------------------------------------------------------------

colorscheme baycomb                     "цветовая схема для терминала
syntax on                               "включаем подсветку синтаксиса
"в конце файла   filetype plugin indent on               "включаем автообнаружение типа файла

"colorscheme solarized
if has ("gui_running")
    "убираем меню и тулбар
    set guioptions-=m
    set guioptions-=T
    "убираем скроллбары
    set guioptions-=r
    set guioptions-=l
    "используем консольные диалоги вместо графических
    set guioptions+=c
    "антиалиасинг для шревтоф
    set antialias
    "прячем курсор
    set mousehide
    "Так не выводятся ненужные escape последовательности в :shell
    set noguipty
    "подсветка текущей строки
    set cursorline
    "font
    set guifont=Terminus
    "используем эту цветовую схему
    set background=light
    "colorscheme darkspectrum
else
    set background=dark
endif

"Don't use Ex mode, use Q for formatting
map Q gq

"---------------------------------------------------------------------------------------------------

autocmd FileType text setlocal textwidth=80 "устанавливаем ширину в 80 знаков для текстовых файлов
au FileType c,cc,h,sh au BufWinEnter * let w:m1=matchadd('ErrorMsg', '\%>80v.\+', -1) "Подсвечиваем 81 символ и т.д.

"При редактировании файла всегда переходить на последнюю известную
"позицию курсора. Если позиция ошибочная - не переходим.
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" Если есть makefile - собираем makeом.
" Иначе используем gcc для текущего файла.
if filereadable("Makefile")
    set makeprg=make
else
    set makeprg=gcc\ -Wall\ -o\ %<\ %
endif

"----------------------------------------------------------------------------

" формат строки с ошибкой для gcc и sdcc, это нужно для errormarker
let &errorformat="%f:%l:%c: %t%*[^:]:%m,%f:%l: %t%*[^:]:%m," . &errorformat

" Некоторые настройки для плагина TagList
let g:Tlist_Show_One_File=1                         " показывать информацию только по одному файлу
let g:Tlist_GainFocus_On_ToggleOpen=1               " получать фокус при открытии
let g:Tlist_Compact_Format=1
let g:Tlist_Close_On_Select=0                       " не закрывать окно после выбора тега
let g:Tlist_Auto_Highlight_Tag=1                    " подсвечивать тег, на котором сейчас находимся

"-----------------------------------------------------------------------------

" Несколько удобных биндингов для С
au FileType c,cc,h inoremap {<CR> {<CR>}<Esc>O
au FileType c,cc,h inoremap #m int main(int argc, char * argv[]) {<CR>return 0;<CR>}<CR><Esc>2kO
au FileType c,cc,h inoremap #d #define 
au FileType c,cc,h inoremap #e #endif /*  */<Esc>hhi
au FileType c,cc,h inoremap #" #include ""<Esc>i
au FileType c,cc,h inoremap #< #include <><Esc>i
au FileType c,cc,h inoremap #f /* FIXME:  */<Esc>hhi
au FileType c,cc,h inoremap #t /*TODO:  */<Esc>hhi
au FileType c,cc,h inoremap ;; <END>;<CR>
au FileType c,cc,h inoremap " ""<Left>
au FileType c,cc,h inoremap ' ''<Left>
au FileType c,cc,h inoremap ( ()<Left>
au FileType c,cc,h inoremap [ []<Left>
au FileType c,cc,h inoremap (; ();<CR>
au FileType c,cc,h inoremap ({ () {<CR>}<Esc>O
au FileType c,cc,h inoremap /*<Space> /*  */<Esc>3ha
" Биндинги для LaTeX
au FileType tex inoremap %- %---------------------------------------------------------------------------<CR>
au FileType tex inoremap %= %===========================================================================<CR>
au FileType tex inoremap { {}<Left>
au FileType tex inoremap \bei \begin{itemize}<CR>
au FileType tex inoremap \ei \end{itemize}<CR>
au FileType tex inoremap \bee \begin{enumerate}<CR>
au FileType tex inoremap \ee \end{enumerate}<CR>
au FileType tex inoremap \it \item 

"----------------------------------------------------------------------------------------------"

" Close buffer without saving
"map <Esc><Esc> :q!<CR>

" Auto adding by Tab (use Shift-TAB)
imap <S-Tab> <C-N>

" Так получим более полную информацию, чем просто <C-g>
map <C-g> g<C-g>

" Открытие\закрытие новой вкладки
imap <C-t>t <Esc>:tabnew<CR>a
nmap <C-t>t :tabnew<CR>

" Выводим красиво оформленную man-страницу прямо в Vim
" в отдельном окне (см. начало этого файла)
nmap <S-k> :exe ":Man " expand("<cword>")<CR>

" показать\спрятать номера строк
imap <C-c>n <Esc>:set<Space>nu!<CR>a
nmap <C-c>n :set<Space>nu!<CR>

" Запуск проверки правописания
menu Spl.next ]s
menu Spl.prev [s
menu Spl.word_good zg
menu Spl.word_wrong zw
menu Spl.word_ignore zG
imap <C-c>s <Esc>:setlocal spell spelllang=ru,en<CR>a
nmap <C-c>s :setlocal spell spelllang=ru,en<CR>
imap <C-c>ss <Esc>:setlocal spell spelllang=<CR>a
nmap <C-c>ss :setlocal spell spelllang=<CR>
map  <C-c>sm :emenu Spl.<TAB>

" Compile programs using Makefile (and do not jump to first error)
au FileType c,cc,h,s imap <C-c>m <Esc>:make!<CR>a
au FileType c,cc,h,s nmap <C-c>m :make!<CR>
" Use LaTeX to compile LaTeX sources
au FileType tex map <C-c>m :!pdflatex -shell-escape "%"<CR>

" List of errors
imap <C-c>l <Esc>:copen<CR>
nmap <C-c>l :copen<CR>

" Work with vim-projects
nmap <silent> <C-c>p <Plug>ToggleProject

" work with taglist
imap <C-c>t <Esc>:TlistToggle<CR>:TlistUpdate<CR>
nmap <C-c>t :TlistToggle<CR>:TlistUpdate<CR>

" Create new project
menu NewProj.C++ :!cp -r ~/.vim/mproj/c++/* .<CR>:e ./src/main.cpp<CR>
menu NewProj.C :!cp -r ~/.vim/mproj/c/* .<CR>:e ./main.c<CR>
menu NewProj.LaTeX :!cp -r ~/.vim/mproj/latex/* .<CR>:e ./report.tex<CR>
map <C-c>np :emenu NewProj.<TAB>

"Add existing project to project tree
"Works through ass, but WORKS!
function! ProjectAdd()
    let s:pproj_name=inputdialog('Enter the name of new project: ')
    if strlen(s:pproj_name) == 0
        return
    endif
    let s:pproject_str_wcwd=s:pproj_name . "=" . getcwd() . " CD=. filter=\"*\" {"
    "for calc this variable now
    silent echo s:pproject_str_wcwd
    Project
    let s:pendln=line("$")
    call setline(s:pendln+1, s:pproject_str_wcwd)
    call setline(s:pendln+2, "}")
    unlet s:pendln
    unlet s:pproject_str_wcwd
    unlet s:pproj_name
endfunction
map <C-c>add :execute ProjectAdd()<CR>

"Вставляем свой заголовок в файл
function FileHeader()
    let s:num=0
    let s:filename=" * @file " . bufname("%")
    "strftime format only for Unix - not portable
    let s:currdate=" * @date " . strftime("%d %B %Y %X")
    call append(s:num,"/**")
    call append(s:num+1,s:filename)
    call append(s:num+2," * @brief")
    call append(s:num+3," * @author Fedor Gagarin <fgagarin@gmail.com")
    call append(s:num+4,s:currdate)
    call append(s:num+5," *")
    call append(s:num+6," * ")
    call append(s:num+7," */")
    unlet s:num
    unlet s:filename
    unlet s:currdate
endfunction
map <C-c>h :execute FileHeader()<CR>

"переключаемся между соответствующими *.c и *.h файлами
"в текущем каталоге (a.vim)
imap <C-c>sw <Esc>:AT<CR>
nmap <C-c>sw :AT<CR>

"Генерируем tags файл
map <C-c>gt :!ctags -a *.c *.h<CR>
map <C-c>gT :!ctags -Ra *.c *.h<CR>

"Включаем/выключаем показ табов и пробелов в конце строки
imap <C-c>e <Esc>:set<Space>list!<CR>
nmap <C-c>e :set<Space>nolist!<CR>


