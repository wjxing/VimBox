" use vim --cmd "let loaded_shabit=1"
if !exists('loaded_shabit')
    finish
elseif !has("win32")
    finish
endif

" molokai
set t_Co=256
colo molokai
set cursorline

set guifont=Bitstream_Vera_Sans_Mono:h10:cANSI
set gfw=Microsoft_YaHei_Mono:h10.5:cGB2312
