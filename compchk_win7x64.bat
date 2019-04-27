@echo off
set ddkpath=C:\WinDDK\7600.16385.1\bin\x86
set incpath=C:\WinDDK\7600.16385.1\inc
set libpath=C:\WinDDK\7600.16385.1\lib
set binpath=.\bin\compchk_win7x64
set objpath=.\bin\compchk_win7x64\Intermediate

echo ===========Start Generating===========
echo Project: CRC32 demo

echo ===========Start Compiling============
%ddkpath%\amd64\cl.exe .\main.c /I"%incpath%\api" /I"%incpath%\crt" /Zi /nologo /W3 /WX /Od /Oy- /D"_msvc" /D"_MBCS" /Zc:wchar_t /Zc:forScope /FAcs /Fa"%objpath%\main.cod" /Fo"%objpath%\main.obj" /Fd"%objpath%\vc90.pdb" /GS- /Gr /TC /c /errorReport:queue

%ddkpath%\amd64\ml64.exe /W3 /WX /Zf /Zd /Fo"%objpath%\crc32.obj" /c /nologo .\crc32_x64.asm

echo ============Start  Linking============
%ddkpath%\amd64\link.exe "%objpath%\main.obj" "%objpath%\crc32.obj" /LIBPATH:"%libpath%\win7\amd64" /LIBPATH:"%libpath%\Crt\amd64" "msvcrt.lib" /NOLOGO /DEBUG /PDB:"%objpath%\crc32_demo.pdb" /OUT:"%binpath%\crc32_demo.exe" /SUBSYSTEM:CONSOLE /ENTRY:"main" /Machine:AMD64 /ERRORREPORT:QUEUE
echo Completed!

echo ============Start Signing============
%ddkpath%\signtool.exe sign /v /f .\ztnxtest.pfx /t http://timestamp.globalsign.com/scripts/timestamp.dll %binpath%\crc32_demo.exe

pause