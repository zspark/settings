set vimpath=C:\Program Files (x86)\vim\
set rcfile=_vimrc
set vimfiles=vimfiles

set file1=vim81\gvimfullscreen.dll
set file2=vim81\vimtweak.dll

@echo exe...
mklink "%vimpath%"%rcfile% %~dp0%rcfile%
mklink /D "%vimpath%"%vimfiles% %~dp0%vimfiles%
mklink "%vimpath%"%file1% %~dp0%file1%
mklink "%vimpath%"%file2% %~dp0%file2%
@echo
