@echo off
chcp 65001 >nul
:: 65001 - UTF-8
echo Заранее выключите нахуй всякие обходы.
pause


cd /d "%~dp0"

set BIN=%~dp0bin\

start "RKNHook" /min "%BIN%winws.exe" --wf-tcp=80,443 --wf-udp=443,50000-65535 ^
--filter-udp=443 --hostlist="1.txt" --dpi-desync=fake,disorder2 --dpi-desync-cutoff=d4 --dpi-desync-udplen-increment=10 --dpi-desync-repeats=6 --dpi-desync-udplen-pattern=0xDEADBEEF --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
--filter-udp=50000-65535 --dpi-desync=fake,tamper --dpi-desync-any-protocol --dpi-desync-cutoff=d4 --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
--filter-tcp=80 --hostlist="1.txt" --dpi-desync=fake,split2 --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --new ^
--filter-tcp=443 --hostlist="1.txt" --dpi-desync=fake,disorder2 --dpi-desync-autottl=1 --dpi-desync-fooling=md5sig --dpi-desync-fake-tls="%BIN%tls_clienthello_www_google_com.bin"
set BIN=%~dp0bin\
set ARGS=--wf-tcp=443 --wf-udp=443,50000-65535 ^