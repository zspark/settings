set vimpath=D:\Program Files (x86)\Vim\
set rcfile=_vimrc
set vimfiles=vimfiles
set dic=dic

set file1=vim74\gvimfullscreen.dll
set file2=vim74\vimtweak.dll

@echo exe...
mklink "%vimpath%"%rcfile% %~dp0%rcfile%
mklink /D "%vimpath%"%vimfiles% %~dp0%vimfiles%
mklink /D "%vimpath%"%dic% %~dp0%dic%
mklink "%vimpath%"%file1% %~dp0%file1%
mklink "%vimpath%"%file2% %~dp0%file2%
@echo
