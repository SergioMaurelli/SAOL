    MODULE('WININET.LIB')
     InternetCloseHandle(ULONG hInet),BOOL,RAW,PASCAL,PROC,NAME('InternetCloseHandle')
     InternetConnect(ULONG hInternetSession,*CSTRING lpszServerName,USHORT nServerPort,<*CSTRING lpszUserName>,<*CSTRING lpszPassword>,ULONG dwService,ULONG dwFlags,ULONG dwContext),ULONG,RAW,PASCAL,NAME('InternetConnectA')
     InternetGetLastResponseInfo(*ulong,*cstring,*ulong),bool,pascal,raw,name('InternetGetLastResponseInfoA')
     InternetFindNextFile(ULONG hFind, *WIN32_FIND_DATA),BOOL,RAW,PASCAL,NAME('InternetFindNextFileA')
     InternetOpen(STRING,ULONG dwAccessType,<*CSTRING lpszProxyName>,<*CSTRING lpszProxyByPass>,ULONG dwFlags),ULONG,RAW,PASCAL,NAME('InternetOpenA')
     InternetReadFile(ULONG hFile,*CSTRING lpBuffer,ULONG dwNumberOfBytesToRead,*ULONG lpNumberOfBytesRead),LONG,RAW,PASCAL,PROC,NAME('InternetReadFile')
     InternetWriteFile(ULONG hFile,*CSTRING lpBuffer,ULONG dwNumberOfBytesToWrite,*ULONG lpNumberOfBytesWritten),LONG,RAW,PASCAL,PROC,NAME('InternetWriteFile')
     InternetSetStatusCallback(unsigned,*InetCallB),long,pascal,name('InternetSetStatusCallback')
     InternetSetOption(ulong,ulong,ulong,ulong),bool,pascal,raw,name('InternetSetOptionA')
     InternetAttemptConnect(ulong),ulong,pascal,raw,name('InternetAttemptConnect')

     FtpCreateDirectory(unsigned,*cstring),bool,pascal,raw,name('FtpCreateDirectoryA'),dll(dll_mode)
     FtpDeleteFile(unsigned,*cstring),bool,pascal,raw,name('FtpDeleteFileA'),dll(dll_mode)
     FtpFindFirstFile(ULONG hFtpSession,*CSTRING lpszSearchFile,*WIN32_FIND_DATA,ULONG dwFlags,ULONG dwContext),ULONG,RAW,PASCAL,NAME('FtpFindFirstFileA')
     FtpGetCurrentDirectory(ULONG hFtpSession,*CSTRING lpszCurrentDirectory,*ULONG lpdwCurrentDirectory),BOOL,RAW,PASCAL,NAME('FtpGetCurrentDirectoryA')
     FtpGetFile(unsigned,*cstring,*cstring,bool,ulong,ulong,ulong),bool,pascal,raw,name('FtpGetFileA'),dll(dll_mode)
     FtpOpenFile(ULONG hFTPSession,*CSTRING lpszFilename,ULONG fdwAccess,ULONG dwFlags,ULONG dwContext),ULONG,RAW,PASCAL,PROC,NAME('FtpOpenFileA')
     FtpPutFile(unsigned,*cstring,*cstring,ulong,ulong),bool,pascal,raw,name('FtpPutFileA'),dll(dll_mode)
     FtpRemoveDirectory(unsigned,*cstring),bool,pascal,raw,name('FtpRemoveDirectoryA'),dll(dll_mode)
     FtpRenameFile(unsigned,*cstring,*cstring),bool,pascal,raw,name('FtpRenameFileA'),dll(dll_mode)
     FtpSetCurrentDirectory(ULONG hFtpSession,*CSTRING lpszDirectory),BOOL,RAW,PASCAL,NAME('FtpSetCurrentDirectoryA')
   END
   MODULE('WINDOWS')
    InetCallB(unsigned,ulong,ulong,ulong,ulong),pascal,type
     FileTimeToLocalFileTime(ulong,ulong),BOOL,PASCAL,RAW
     FileTimeToSystemTime(ulong,ulong),BOOL,PASCAL,RAW
     FileTimeToDosDateTime(ulong,*signed,*signed),BOOL,PASCAL,RAW
     _lopen(*cstring,SIGNED),PASCAL,RAW
     _lcreat(*cstring,SIGNED),PASCAL,RAW
     _hwrite(HFILE,*cstring,long),long,PASCAL,RAW
     _lclose(HFILE),PASCAL
     _llseek(HFILE, LONG, SIGNED),LONG,PASCAL
     _lread(HFILE, *LPSTR, signed),PASCAL,RAW
     File_Exists(*CSTRING),Signed,Pascal,Raw,Name('File_Exists')
     Delete_File(*CSTRING),Signed,Pascal,Raw,Name('Delete_File')
     Create_Directory(*CSTRING),Signed,Pascal,Raw,Name('Create_Directory')
     Delete_Directory(*CSTRING),Signed,Pascal,Raw,Name('Delete_Directory')
     Copy_File(*CSTRING,*CSTRING),Signed,Pascal,Raw,Name('Copy_File')
     Run_Wait(*CSTRING,INTEGER),Signed,Pascal,Raw,Name('Run_Wait')
     Run_NoWait(*CSTRING,INTEGER),Signed,Pascal,Raw,Name('Run_NoWait')
     Rename_File(*CSTRING,*CSTRING),Signed,Pascal,Raw,Name('Rename_File')
     Free_Space(INTEGER),Long,Pascal,Raw,Name('Free_Space')
     Play_Wave(*CSTRING),Long,Pascal,Raw,Name('Play_Wave')
     FormatMessage(ulong,*lpvoid,ulong,ulong,*cstring,ulong,ulong),pascal,raw
     SndPlaySound(*CSTRING,UNSIGNED),BOOL,PROC,pascal,raw,NAME('sndPlaySoundA')
     ShellExecute(UNSIGNED,LONG,*CSTRING,LONG,*CSTRING,SIGNED),UNSIGNED,PASCAL,RAW,NAME('SHELLEXECUTEA')
     GetLastError(),ULONG,RAW,PASCAL,NAME('GetLastError')
     GetLogicalDrives(),PASCAL,NAME('GetLogicalDrives')
     GetLogicalDriveStrings(ulong,*CSTRING),PASCAL,RAW,NAME('GetLogicalDriveStringsA')
     BringWindowToTop(ULONG),BYTE,RAW,PASCAL,NAME('BringWindowToTop'),PROC
     CloseHandle(UNSIGNED hObject),BOOL,RAW,PASCAL,PROC,NAME('CloseHandle')
     CreateFile(*CSTRING lpFileName,ULONG dwDesiredAccess,ULONG dwShareMode,ULONG LPSECURITY_ATTRIBUTES,ULONG dwCreationDisposition,ULONG dwFlagsAndAttributes,UNSIGNED hTemplateFile),UNSIGNED,RAW,PASCAL,PROC,NAME('CreateFileA')
     FindFirstFile(*CSTRING lpFile,*WIN32_FIND_DATA),ULONG,RAW,PASCAL,NAME('FindFirstFileA')
     FindNextFile(ULONG hFindFile,*WIN32_FIND_DATA),BOOL,RAW,PASCAL,NAME('FindNextFileA')
     GetCurrentDirectory(ULONG GetCurrentDirectory,*CSTRING lpBuffer),ULONG,RAW,PASCAL,NAME('GetCurrentDirectoryA')
     ReadFile(UNSIGNED hFile,*? lpBuffer,ULONG nNumberOfBytesToRead,*ULONG lpNumberOfBytesRead,ULONG LPOVERLAPPED),BOOL,RAW,PASCAL,PROC,NAME('ReadFile')
     WriteFile(UNSIGNED hFile,*? lpBuffer,ULONG nNumberOfBytesToWrite,*ULONG lpNumberOfBytesWritten,ULONG LPOVERLAPPED),BOOL,RAW,PASCAL,PROC,NAME('WriteFile')
   END
   MODULE('WININET.DLL')
     InternetAutodial(ULONG,ULONG),PASCAL,BYTE
     ! Si se conecta a traves de la conexión por defecto devuelve 1
     InternetAutodialHangup(ULONG),PASCAL,BYTE
     ! Si se desconecta devuelve 1 de lo contrario 0. El parmetro debe ser 0
     InternetDial(SIGNED,ULONG,ULONG,ULONG,ULONG),PASCAL,ULONG
     ! Inicia una conexion a traves de modem (dial-up)
     InternetGetConnectedState(*ULONG lpdwFlags,ULONG dwReserved),BOOL,RAW,PASCAL,NAME('InternetGetConnectedState')
     ! Obtiene el estado de la conexión
     InternetGoOnline(*CSTRING,SIGNED,ULONG),PASCAL,BYTE
     ! Pide permiso al usuario para pasar al estado de conectado a una URL
     InternetHangUp(ULONG,ULONG),PASCAL,DWORD
     ! Cuelga una conexión establecida anteriormente
   END