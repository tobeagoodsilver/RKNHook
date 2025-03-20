@echo off@echo off
chcp 65001 >nul
:: 65001 - UTF-8

:: Admin rights check
echo СУКА АЛЛО БЛЯТЬ ПИСАЛ ЧЕРНЫМ ПО БЕЛОМУ ЧТО НАДО БЛЯТЬ ОТ ИМЕНИ АДМИНИСТРАТОРА.
echo Нажмите любую клавишу, чтобы продолжить создание сервиса.
pause

set BIN=%~dp0bin\
set ARGS=--wf-tcp=80,443 --wf-udp=443,50000-65535 ^
--filter-udp=443 --hostlist=\"%~dp01.txt\" --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
--filter-udp=50000-65535 --ipset=\"%~dp02.txt\" --dpi-desync=fake --dpi-desync-any-protocol --dpi-desync-cutoff=d3 --dpi-desync-repeats=6 --new ^
--filter-tcp=80 --hostlist="\%~dp01.txt\" --dpi-desync=fake,split2 --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --new ^
--filter-tcp=443 --hostlist=\"%~dp01.txt\" --dpi-desync=fake,split --dpi-desync-autottl=5 --dpi-desync-repeats=6 --dpi-desync-fooling=badseq --dpi-desync-fake-tls=\"%BIN%tls_clienthello_www_google_com.bin\"


set SRVCNAME=RKNHook

net stop %SRVCNAME%
sc delete %SRVCNAME%
sc create %SRVCNAME% binPath= "\"%BIN%winws.exe\" %ARGS%" DisplayName= "LOLSOSU : %SRVCNAME%" start= auto
sc description %SRVCNAME% ""
sc start %SRVCNAME%

pause