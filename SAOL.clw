   PROGRAM



   INCLUDE('ABERROR.INC'),ONCE
   INCLUDE('ABFILE.INC'),ONCE
   INCLUDE('ABUTIL.INC'),ONCE
   INCLUDE('EFOCUS.INC'),ONCE
   INCLUDE('ERRORS.CLW'),ONCE
   INCLUDE('KEYCODES.CLW'),ONCE
   INCLUDE('ABFUZZY.INC'),ONCE
   INCLUDE('StAbTag.TRN', 'Strings'),ONCE
INCLUDE('WINTYPES.TXT')
INCLUDE('WININETC.CLW')
INCLUDE('TRANSFER.EQU')

   MAP
     MODULE('Windows API')
SystemParametersInfo PROCEDURE (LONG uAction, LONG uParam, *? lpvParam, LONG fuWinIni),LONG,RAW,PROC,PASCAL,DLL(TRUE),NAME('SystemParametersInfoA')
     END
     MODULE('SAOL_BC.CLW')
DctInit     PROCEDURE                                      ! Initializes the dictionary definition module
DctKill     PROCEDURE                                      ! Kills the dictionary definition module
     END
!--- Application Global and Exported Procedure Definitions --------------------------------------------
     MODULE('SAOL003.CLW')
Main                   PROCEDURE   !SAOL - Sistema de Actualizaciones On-Line
     END
     MODULE('SAOL$TAG.CLW')
       INCLUDE('STABTAG2.CLW','ProgramMap:User')
       INCLUDE('STABTAG2.CLW','ProgramMap:PtrM')
       INCLUDE('STABTAG2.CLW','ProgramMap:PosM')
       INCLUDE('STABTAG2.CLW','ProgramMap:PtrF')
       INCLUDE('STABTAG2.CLW','ProgramMap:PosF')
       INCLUDE('STABTAG2.CLW','ProgramMap:TagSet')
     END!MODULE
     
     
     	INCLUDE('WININET.CLW')
     
     	MODULE('win32')
          CreateDirectory(*CSTRING lpPathName, LONG ),BOOL,PASCAL,RAW,NAME('CreateDirectoryA')
          SetFileAttributesA(*CSTRING,ULONG),BOOL,PASCAL,RAW
          GetFileAttributesA(*CSTRING),ULONG,PASCAL,RAW
          GetFileVersionInfoSize(Long,Long),Long,Raw,Pascal,Name('GetFileVersionInfoSizeA')
          GetFileVersionInfo(Long,Long,Long,Long),Bool,Raw,Pascal,Name('GetFileVersionInfoA')
          VerQueryValue(Long,Long,Long,Long),Bool,Raw,Pascal,Name('VerQueryValueA')
          GetDesktopWindow(),HWND,PASCAL
       end
     
       Module('c functions')
          memcpy(Long,Long,Long),Raw,Name('_memcpy'),Proc
          strcpy(Long,Long),CString,Raw,Name('_strcpy'),Proc
       End
     
       Module('')
          GetProcessHeap(),UnSigned,Raw,Pascal,Name('GetProcessHeap'),Proc
          HeapAlloc(UnSigned,UnSigned,UnSigned),UnSigned,Raw,Pascal,Name('HeapAlloc'),Proc
          HeapFree(UnSigned,UnSigned,UnSigned),UnSigned,Raw,Pascal,Name('HeapFree'),Proc
       End
     
       Module('netapi32.DLL')
          Netbios(*NET_CONTROL_BLOCK),Byte,Raw,Pascal,Name('Netbios'),Proc
       End
     module('CCTAPI')
     OMIT('***',_WIDTH32_)
     FindWindow(<*CSTRING>,*CSTRING),UNSIGNED,PASCAL,RAW
     ***
      COMPILE('***',_WIDTH32_)
       FindWindow(<*CSTRING>,*CSTRING),UNSIGNED,PASCAL,RAW,NAME('FindWindowA')
     ***
     IsIconic(UNSIGNED),SIGNED,PASCAL,proc
     ShowWindow(UNSIGNED, SIGNED),SIGNED,PASCAL,proc,NAME('SHOWWINDOW')
     OpenIcon(UNSIGNED),SIGNED,PASCAL,proc
     end
       MODULE('WIN API PROTOTYPES')                        ! ABC Free apiSubclass template
          !CallWindowProc(LONG,UNSIGNED,UNSIGNED,UNSIGNED,LONG),LONG,RAW,PASCAL,NAME('CallWindowProcA')
          CallWindowProc(LONG,UNSIGNED,UNSIGNED,UNSIGNED,LONG),LONG,PASCAL,NAME('CallWindowProcA') ! apiSubclass (ABC Free)
          SetWindowLong(UNSIGNED,SIGNED,LONG),LONG,RAW,PASCAL,NAME('SetWindowLongA') ! apiSubclass (ABC Free)
                                                           ! ABC Free apiSubclass template
       END                                                 ! apiSubclass (ABC Free)
   END

GLO:PathDeArchivos   GROUP,PRE(GLO)
ConfigGlobal           STRING(100)
FTP_Config             CSTRING(61)
FTP_ItemxTransferSet   CSTRING(61)
FTP_RemoteFolder       CSTRING(61)
FTP_RemoteSite         CSTRING(61)
FTP_ScheduledTransfer  CSTRING(61)
FTP_Transfer           CSTRING(61)
FTP_TransferItem       CSTRING(61)
FTP_TransferLog        CSTRING(61)
FTP_TransferSet        CSTRING(61)
                     END
SilentRunning        BYTE(0)                               ! Set true when application is running in 'silent mode'

   INCLUDE( 'ALSZCLA.INC' ),ONCE

   INCLUDE( 'ALSUZCLA.INC' ),ONCE

 INCLUDE( 'LSZIP.LIC' ),ONCE
!region File Declaration
SAOL_Clientes        FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('SAOL_CLIENTES.TPS'),PRE(SAOL_CLI),BINDABLE,CREATE,THREAD !                    
PorID                    KEY(SAOL_CLI:id),NOCASE,OPT,PRIMARY !                    
PorNombre                KEY(SAOL_CLI:Nombre),DUP,NOCASE   !                    
Record                   RECORD,PRE()
id                          LONG                           !                    
Nombre                      CSTRING(100)                   !                    
CUIT                        STRING(11)                     !                    
Email                       CSTRING(256)                   !Email               
Contacto                    CSTRING(61)                    !Contacto            
Estado                      BYTE                           !Estado              
                         END
                     END                       

SAOL_Instaladores    FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('SAOL_INSTALADORES.TPS'),PRE(SAOL_INS),BINDABLE,CREATE,THREAD !                    
PorID                    KEY(SAOL_INS:id),NOCASE,OPT,PRIMARY !Por ID del Instalador
PorIDSoftwarexCliente    KEY(SAOL_INS:idSoftwarexCliente),DUP,NOCASE,OPT !                    
PorDescripcion           KEY(SAOL_INS:Descripcion),NOCASE,OPT !Por Descripción del Instalador
Record                   RECORD,PRE()
id                          LONG                           !ID del Instalador   
idSoftwarexCliente          LONG                           !ID del Software     
Descripcion                 CSTRING(256)                   !Descripcion del Instalador
Referencia                  CSTRING(101)                   !Referencia          
PathISS                     CSTRING(256)                   !Path del Archivo de Inno setup
GeneradoFecha               LONG                           !Fecha de la última generación
GeneradoHora                LONG                           !Hora de la última generación
Major                       LONG                           !Major de la Versión 
Minor                       LONG                           !Minor de la Versión 
Release                     LONG                           !Release de la Versión
Build                       LONG                           !Build de la Versión 
Procesar                    BYTE                           !Marca para procesar o no el instalador
OutputDir                   CSTRING(256)                   !                    
OutputBaseFilename          CSTRING(256)                   !                    
DefaultDirName              CSTRING(256)                   !                    
Estado                      BYTE                           !Estado              
Email                       CSTRING(256)                   !Correo Electrónico a donde avisar de una nueva versión
ReleaseIni                  CSTRING(256)                   !Archivo INI donde se encuentra la info de versión (para avanzar BUILD)
Contacto                    CSTRING(61)                    !Contacto            
CentroEmision               SHORT                          !Centro de Emisión de Instalación
                         END
                     END                       

FTP_RemoteSite       FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('FTP_RemoteSite.TPS'),PRE(FTPRS),BINDABLE,CREATE,THREAD !Servidores FTP Remotos
PorId                    KEY(FTPRS:id),OPT,PRIMARY         !Por Id              
PorDescripcion           KEY(FTPRS:Descripcion),NOCASE     !Por Descripción     
Record                   RECORD,PRE()
id                          LONG                           !id del Sitio Remoto 
Descripcion                 CSTRING(41)                    !Descripción         
Host                        CSTRING(256)                   !HOST Servidor FTP   
Usuario                     CSTRING(41)                    !Usuario             
Clave                       CSTRING(41)                    !Clave de acceso     
Port                        LONG                           !Puerto FTP          
                         END
                     END                       

FTP_ScheduledTransfer FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('FTP_ScheduledTransfer.TPS'),PRE(FTPST),BINDABLE,CREATE,THREAD !Transferencias Programadas
PorId                    KEY(FTPST:id),OPT,PRIMARY         !Por id              
PorTransferSet           KEY(FTPST:idTransferSet),DUP,NOCASE,OPT !Por Conjunto de Transferencia
PorEstPT                 KEY(FTPST:Estado,FTPST:FechaPT,FTPST:HoraPT),DUP,NOCASE,OPT !Por Estado/Próxima Transferencia
PorEstOrden              KEY(FTPST:Estado,FTPST:Orden),DUP,NOCASE,OPT !Por Estado/Orden    
Record                   RECORD,PRE()
id                          LONG                           !id unívoco de la transferencia programada
idTransferSet               LONG                           !id unívoco del conjunto de transferencia
PrimeraTransferencia        GROUP                          !                    
Fecha                         LONG                         !Fecha de Primera Transferencia
Hora                          LONG                         !Hora de la Primera Transferencia
                            END                            !                    
Repetir                     BYTE                           !Repetición          
RepetirCada                 GROUP                          !                    
Horas                         LONG                         !Horas               
Minutos                       LONG                         !Minutos             
                            END                            !                    
Parar                       LONG                           !Para cuando sean las ...
TransferirLosDias           GROUP                          !                    
Lunes                         BYTE                         !Lunes               
Martes                        BYTE                         !Martes              
Miercoles                     BYTE                         !Miércoles           
Jueves                        BYTE                         !Jueves              
Viernes                       BYTE                         !Viernes             
Sabado                        BYTE                         !Sábado              
Domingo                       BYTE                         !Domingo             
                            END                            !                    
DiaDeLaSemana               BYTE                           !Día de la Semana    
DiaDelMes                   BYTE                           !Día del mes         
BorrarOrigen                BYTE                           !Borrar Archivo Origen de la Transferencia
SoloActualizar              BYTE                           !Solo actualizar destino de la transferencia
DesconectarAlFinalizar      BYTE                           !Desconectar de internet al finalizar la transferencia
CorrerAplicacion            BYTE                           !Correr Aplicación al terminar la transferencia
Aplicacion                  CSTRING(256)                   !Aplicación a ejecutar
Parametros                  CSTRING(256)                   !Parámetros a pasar a la aplicación
MandarEmail                 BYTE                           !Mandar Email al terminar la transferencia
SoloEnErrores               BYTE                           !Solo enviar Email si hubo errores
Email                       CSTRING(256)                   !Dirección de Email  
Estado                      BYTE                           !Estado              
Orden                       LONG                           !Orden               
PermitirTransferenciaCompulsiva BYTE                       !Permitir Transferencia Compulsiva
UltimaTransferencia         GROUP                          !                    
FechaUT                       LONG                         !Fecha de Ultima Transferencia
HoraUT                        LONG                         !Hora de Ultima Transferencia
                            END                            !                    
ProximaTransferencia        GROUP                          !Fecha de Próxima Transferencia Programada
FechaPT                       LONG                         !Fecha de Próxima Transferencia
HoraPT                        LONG                         !Hora de Próxima Transferencia Programada
                            END                            !                    
                         END
                     END                       

FTP_TransferItem     FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('FTP_TransferItem.TPS'),PRE(FTPTI),BINDABLE,CREATE,THREAD !Items de Transferencia
PorId                    KEY(FTPTI:id),OPT,PRIMARY         !Por Id              
PorRemoteSite            KEY(FTPTI:idRemoteSite),DUP,NOCASE,OPT !Por Sitio Remoto    
Record                   RECORD,PRE()
id                          LONG                           !id unívoco de item de transferencia
Direccion                   BYTE                           !Dirección de Transferencia
idRemoteSite                LONG                           !id del Sitio Remoto 
CarpetaRemota               CSTRING(256)                   !Carpeta Remota      
ArchivoRemoto               CSTRING(256)                   !Archivo Remoto      
CarpetaLocal                CSTRING(256)                   !Carpeta Local       
ArchivoLocal                CSTRING(256)                   !Archivo Local       
Comprimir                   BYTE                           !Comprimir           
Descomprimir                BYTE                           !Descomprimir        
ArchivoComprimido           CSTRING(256)                   !Nombre del Archivo Comprimido
ClaveArchivoComprimido      CSTRING(256)                   !Clave de encriptación del Archivo Comprimido
BorrarOrigen                BYTE                           !Borrar Archivo Origen de la Transferencia
SoloActualizar              BYTE                           !Solo actualizar destino de la transferencia
TipoAccionEspecial          BYTE                           !Tipo de Acción Especial
Aplicacion                  CSTRING(256)                   !Aplicación a ejecutar
Parametros                  CSTRING(256)                   !Parámetros a pasar a la aplicación
                         END
                     END                       

FTP_RemoteFolder     FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('FTP_RemoteFolder.TPS'),PRE(FTPRF),BINDABLE,CREATE,THREAD !Carpetas Remotas de Servidores FTP
PorId                    KEY(FTPRF:id),OPT,PRIMARY         !Por Id              
PorRemoteSite            KEY(FTPRF:idRemoteSite,FTPRF:Carpeta),DUP,NOCASE,OPT !Por Servidor        
Record                   RECORD,PRE()
id                          LONG                           !id unívoco de carpeta
idRemoteSite                LONG                           !id del Sitio Remoto 
Carpeta                     CSTRING(256)                   !Carpeta Remota      
                         END
                     END                       

FTP_TransferLog      FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('FTP_TransferLog.TPS'),PRE(FTPTL),BINDABLE,CREATE,THREAD !Log de Transferencias
PorId                    KEY(FTPTL:id),OPT,PRIMARY         !Por Id              
PorFecHor                KEY(FTPTL:Fecha,FTPTL:Hora),DUP,NOCASE,OPT !Por Fecha/Hora      
PorTransferItem          KEY(FTPTL:idTransferItem),DUP,NOCASE,OPT !Por Item de Transferencia
PorScheduledTransfer     KEY(FTPTL:idScheduledTransfer),DUP,NOCASE,OPT !Por Transferencia Programadas
Record                   RECORD,PRE()
id                          LONG                           !id unívoco del log  
Tipo                        BYTE                           !Tipo de Log         
Fecha                       LONG                           !Fecha               
Hora                        LONG                           !Hora                
idRemoteSite                LONG                           !id del Sitio Remoto 
Descripcion                 CSTRING(256)                   !Descripción del evento
Archivo                     CSTRING(256)                   !Archivo             
Carpeta                     CSTRING(256)                   !Carpeta             
idTransferItem              LONG                           !id unívoco de item de transferencia
idScheduledTransfer         LONG                           !id unívoco de la transferencia programada
                         END
                     END                       

FTP_TransferSet      FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('FTP_TransferSet.TPS'),PRE(FTPTS),BINDABLE,CREATE,THREAD !Conjuntos de Transferencia
PorId                    KEY(FTPTS:id),OPT,PRIMARY         !Por Id              
PorDescripcion           KEY(FTPTS:Descripcion),NOCASE,OPT !Por Descripción     
Record                   RECORD,PRE()
id                          LONG                           !id unívoco del conjunto de transferencia
Descripcion                 CSTRING(41)                    !Descripción del Conjunto de Transferencia
                         END
                     END                       

FTP_Transfer         FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('FTP_Transfer.TPS'),PRE(FTPT),BINDABLE,CREATE,THREAD !Transferencias      
PorId                    KEY(FTPT:id),OPT,PRIMARY          !Por id              
PorRemoteSite            KEY(FTPT:idRemoteSite),DUP,NOCASE,OPT !Por Servidor FTP    
PorTransferItem          KEY(FTPT:idTransferItem),DUP,NOCASE,OPT !Por Item de Transferencia
PorScheduledTransfer     KEY(FTPT:idScheduledTransfer,FTPT:idTransferItem),DUP,NOCASE,OPT !Por Transferencia Programada
PorInternetSession       KEY(FTPT:InternetSession,FTPT:id),DUP,NOCASE,OPT !Por Sesión Internet 
Record                   RECORD,PRE()
id                          LONG                           !id de transferencia 
Descripcion                 CSTRING(61)                    !Descripción         
InternetSession             ULONG                          !Sesión Internet     
Direccion                   BYTE                           !Dirección de Transferencia
idRemoteSite                LONG                           !id del Sitio Remoto 
Carpeta                     CSTRING(256)                   !Carpeta             
Archivo                     CSTRING(256)                   !Archivo             
Size                        LONG                           !Tamaño              
Elapsed                     LONG                           !Tiempo Transcurrido 
Remaining                   LONG                           !Tiempo Restante     
Rate                        REAL                           !Tasa de transferencia
SentReceived                LONG                           !Enviado/Recibido    
Estado                      BYTE                           !Estado              
idTransferItem              LONG                           !id unívoco de item de transferencia
idScheduledTransfer         LONG                           !id unívoco de la transferencia programada
InicioTransferencia         GROUP                          !Inicio de la Transferencia
Fecha                         LONG                         !Fecha de Inicio de Transferencia
Hora                          LONG                         !Hora de Inicio de Transferencia
                            END                            !                    
                         END
                     END                       

FTP_ItemxTransferSet FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('FTP_ItemxTransferSet.TPS'),PRE(FTPIxTS),BINDABLE,CREATE,THREAD !Items de Conjuntos de Transferencia
PorId                    KEY(FTPIxTS:id),OPT,PRIMARY       !Por Id              
PorOrden                 KEY(FTPIxTS:idTransferSet,FTPIxTS:Orden),DUP,NOCASE,OPT !Por Orden           
PorTransferSet           KEY(FTPIxTS:idTransferSet,FTPIxTS:idTransferItem),DUP,NOCASE,OPT !Por Conjunto de Transferencia
PorTransferItem          KEY(FTPIxTS:idTransferItem,FTPIxTS:idTransferSet),DUP,NOCASE,OPT !Por Item de Transferencia
Record                   RECORD,PRE()
id                          LONG                           !id unívoco del item x conjunto de transferencia
idTransferSet               LONG                           !id unívoco del conjunto de transferencia
idTransferItem              LONG                           !id unívoco de item de transferencia
Orden                       LONG                           !Orden               
                         END
                     END                       

SAOL_SoftwarexCliente FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('SAOL_SOFTWAREXCLIENTE.TPS'),PRE(SAOL_SXC),BINDABLE,CREATE,THREAD !                    
PorID                    KEY(SAOL_SXC:id),NOCASE,OPT,PRIMARY !                    
PorClienteSoftware       KEY(SAOL_SXC:idCliente,SAOL_SXC:idSoftware),NOCASE,OPT !Por Cliente/Software
PorCliente               KEY(SAOL_SXC:idCliente),DUP,NOCASE !                    
PorSoftware              KEY(SAOL_SXC:idSoftware),DUP,NOCASE !                    
Record                   RECORD,PRE()
id                          LONG                           !                    
idCliente                   LONG                           !                    
idSoftware                  LONG                           !                    
FechaCompra                 LONG                           !Fecha de Compra     
FechaSubscripcionSAOL       LONG                           !Fecha de Subscripción a SAOL
FechaVencimientoSubscripcionSAOL LONG                      !Fecha de Vencimiento de Subscripción a SAOL
                         END
                     END                       

SAOL_ComponentesxInstalador FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('SAOL_COMPONENTESXINSTALADOR.TPS'),PRE(SAOL_CXI),BINDABLE,CREATE,THREAD !Componentes por instalador
PorId                    KEY(SAOL_CXI:id),NOCASE,OPT,PRIMARY !                    
PorInstaladorComponente  KEY(SAOL_CXI:idInstalador,SAOL_CXI:idComponente),NOCASE,OPT !Por Instalador/Componente
PorIdComponente          KEY(SAOL_CXI:idComponente),DUP,NOCASE !                    
PorIdInstalador          KEY(SAOL_CXI:idInstalador),DUP,NOCASE !                    
Record                   RECORD,PRE()
id                          LONG                           !                    
idInstalador                LONG                           !                    
idComponente                LONG                           !                    
Major                       LONG                           !                    
Minor                       LONG                           !                    
Release                     LONG                           !                    
Build                       LONG                           !                    
FechaGeneracion             LONG                           !                    
HoraGeneracion              LONG                           !                    
Procesar                    BYTE                           !                    
                         END
                     END                       

SAOL_Componentes     FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('SAOL_COMPONENTES.TPS'),PRE(SAOL_COM),BINDABLE,CREATE,THREAD !                    
PorID                    KEY(SAOL_COM:id),NOCASE,OPT,PRIMARY !                    
PorDescripcion           KEY(SAOL_COM:Descripcion),DUP,NOCASE !                    
PorPath                  KEY(SAOL_COM:Path),NOCASE,OPT     !Por Path            
Record                   RECORD,PRE()
id                          LONG                           !                    
Descripcion                 CSTRING(101)                   !                    
Path                        CSTRING(256)                   !Path en donde se encuentra el componente
Major                       LONG                           !                    
Minor                       LONG                           !                    
Release                     LONG                           !                    
Build                       LONG                           !                    
FechaGeneracion             LONG                           !                    
HoraGeneracion              LONG                           !                    
Procesar                    BYTE                           !                    
                         END
                     END                       

SAOL_Software        FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('SAOL_SOFTWARE.TPS'),PRE(SAOL_SOF),BINDABLE,CREATE,THREAD !                    
PorID                    KEY(SAOL_SOF:id),NOCASE,OPT,PRIMARY !                    
PorNombre                KEY(SAOL_SOF:Nombre),NOCASE       !                    
Record                   RECORD,PRE()
id                          LONG                           !                    
Nombre                      CSTRING(101)                   !                    
                         END
                     END                       

TagSet_              FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('TagSet_.tps'),PRE(TS_),BINDABLE,CREATE,THREAD !                    
TblKey                   KEY(TS_:Tbl),NOCASE,PRIMARY       !                    
UsrTblKey                KEY(TS_:Usr,TS_:Tbl),DUP,NOCASE,OPT !                    
UsrSourceDateKey         KEY(TS_:Usr,TS_:Source,TS_:Date),DUP,NOCASE,OPT !                    
Record                   RECORD,PRE()
Tbl                         SHORT                          !                    
Usr                         LONG                           !                    
Source                      STRING(50)                     !                    
Date                        LONG                           !                    
Count                       LONG                           !                    
Description                 STRING(250)                    !                    
                         END
                     END                       

TagFile_             FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('TagFile_.tps'),PRE(TF_),BINDABLE,CREATE,THREAD !                    
PtrKey                   KEY(TF_:Usr,TF_:Tbl,TF_:Ptr),NOCASE,OPT,PRIMARY !                    
ValKey                   KEY(TF_:Usr,TF_:Tbl,TF_:Val),DUP,NOCASE,OPT !                    
Record                   RECORD,PRE()
Usr                         LONG                           !                    
Tbl                         SHORT                          !                    
Ptr                         LONG                           !                    
Val                         STRING(10)                     !                    
                         END
                     END                       

TagFilePos_          FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('TagFilePos_.tps'),PRE(TP_),BINDABLE,CREATE,THREAD !                    
PosKey                   KEY(TP_:Usr,TP_:Tbl,TP_:Pos),NOCASE,OPT,PRIMARY !                    
ValKey                   KEY(TP_:Usr,TP_:Tbl,TP_:Val),DUP,NOCASE,OPT !                    
Record                   RECORD,PRE()
Usr                         LONG                           !                    
Tbl                         SHORT                          !                    
Pos                         STRING(256)                    !                    
Val                         STRING(10)                     !                    
                         END
                     END                       

SAOL_FTP_Release     FILE,DRIVER('TOPSPEED'),RECLAIM,OWNER('poiewq'),ENCRYPT,NAME('SAOL_FTP.TPS\!Release'),PRE(FTP_REL),BINDABLE,CREATE,THREAD !                    
PorID                    KEY(FTP_REL:id),NOCASE,OPT,PRIMARY !                    
Record                   RECORD,PRE()
id                          LONG                           !                    
Major                       SHORT                          !                    
Minor                       SHORT                          !                    
Release                     SHORT                          !                    
Build                       SHORT                          !                    
Path                        CSTRING(256)                   !Path del archivo en el FTP
Compulsiva                  BYTE                           !                    
                         END
                     END                       

SAOL_FTP_Componentes FILE,DRIVER('TOPSPEED'),RECLAIM,OWNER('poiewq'),ENCRYPT,NAME('SAOL_FTP.TPS\!Componentes'),PRE(FTP_COM),BINDABLE,CREATE,THREAD !                    
PorID                    KEY(FTP_COM:id),NOCASE,OPT,PRIMARY !                    
Record                   RECORD,PRE()
id                          LONG                           !                    
Nombre                      CSTRING(81)                    !Nombre del Componente
Major                       SHORT                          !                    
Minor                       SHORT                          !                    
Release                     SHORT                          !                    
Build                       SHORT                          !                    
Fecha                       LONG                           !                    
Hora                        LONG                           !                    
Path                        CSTRING(256)                   !                    
Compulsiva                  BYTE                           !                    
                         END
                     END                       

SAOL_Passcode        FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('SAOL_PASSCODE.TPS'),PRE(SAOL_PASS),BINDABLE,CREATE,THREAD !                    
PorID                    KEY(SAOL_PASS:id),NOCASE,OPT,PRIMARY !                    
PorCliente               KEY(SAOL_PASS:idcliente),DUP,NOCASE !                    
PorSoftware              KEY(SAOL_PASS:idSoftware),DUP,NOCASE !                    
Record                   RECORD,PRE()
id                          LONG                           !                    
idcliente                   LONG                           !                    
idSoftware                  LONG                           !                    
Fecha                       LONG                           !                    
Hora                        LONG                           !                    
NombrePC                    CSTRING(41)                    !                    
UsuarioquePidio             CSTRING(41)                    !                    
CodigoMaquina               LONG                           !Código de Máquina   
TipoPasscode                BYTE                           !                    
FechaVencimiento            LONG                           !                    
Passcode                    LONG                           !                    
Observaciones               CSTRING(256)                   !                    
                         END
                     END                       

SAOL_Log             FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('SAOL_LOG.TPS'),PRE(SAOL_LOG),BINDABLE,CREATE,THREAD !Log de Errores de Generación
PorID                    KEY(SAOL_LOG:id),NOCASE,OPT,PRIMARY !Por Id              
PorInstalador            KEY(SAOL_LOG:idInstalador),DUP,NOCASE,OPT !Por Instalador      
PorDescripcion           KEY(SAOL_LOG:Descripcion),DUP,NOCASE,OPT !Por Descripción     
Observaciones               MEMO(1000)                     !Observaciones       
Record                   RECORD,PRE()
id                          LONG                           !id                  
idInstalador                LONG                           !                    
Fecha                       LONG                           !Fecha               
Hora                        LONG                           !Hora                
Descripcion                 CSTRING(31)                    !Descripción         
                         END
                     END                       

!endregion

Access:SAOL_Clientes &FileManager,THREAD                   ! FileManager for SAOL_Clientes
Relate:SAOL_Clientes &RelationManager,THREAD               ! RelationManager for SAOL_Clientes
Access:SAOL_Instaladores &FileManager,THREAD               ! FileManager for SAOL_Instaladores
Relate:SAOL_Instaladores &RelationManager,THREAD           ! RelationManager for SAOL_Instaladores
Access:FTP_RemoteSite &FileManager,THREAD                  ! FileManager for FTP_RemoteSite
Relate:FTP_RemoteSite &RelationManager,THREAD              ! RelationManager for FTP_RemoteSite
Access:FTP_ScheduledTransfer &FileManager,THREAD           ! FileManager for FTP_ScheduledTransfer
Relate:FTP_ScheduledTransfer &RelationManager,THREAD       ! RelationManager for FTP_ScheduledTransfer
Access:FTP_TransferItem &FileManager,THREAD                ! FileManager for FTP_TransferItem
Relate:FTP_TransferItem &RelationManager,THREAD            ! RelationManager for FTP_TransferItem
Access:FTP_RemoteFolder &FileManager,THREAD                ! FileManager for FTP_RemoteFolder
Relate:FTP_RemoteFolder &RelationManager,THREAD            ! RelationManager for FTP_RemoteFolder
Access:FTP_TransferLog &FileManager,THREAD                 ! FileManager for FTP_TransferLog
Relate:FTP_TransferLog &RelationManager,THREAD             ! RelationManager for FTP_TransferLog
Access:FTP_TransferSet &FileManager,THREAD                 ! FileManager for FTP_TransferSet
Relate:FTP_TransferSet &RelationManager,THREAD             ! RelationManager for FTP_TransferSet
Access:FTP_Transfer  &FileManager,THREAD                   ! FileManager for FTP_Transfer
Relate:FTP_Transfer  &RelationManager,THREAD               ! RelationManager for FTP_Transfer
Access:FTP_ItemxTransferSet &FileManager,THREAD            ! FileManager for FTP_ItemxTransferSet
Relate:FTP_ItemxTransferSet &RelationManager,THREAD        ! RelationManager for FTP_ItemxTransferSet
Access:SAOL_SoftwarexCliente &FileManager,THREAD           ! FileManager for SAOL_SoftwarexCliente
Relate:SAOL_SoftwarexCliente &RelationManager,THREAD       ! RelationManager for SAOL_SoftwarexCliente
Access:SAOL_ComponentesxInstalador &FileManager,THREAD     ! FileManager for SAOL_ComponentesxInstalador
Relate:SAOL_ComponentesxInstalador &RelationManager,THREAD ! RelationManager for SAOL_ComponentesxInstalador
Access:SAOL_Componentes &FileManager,THREAD                ! FileManager for SAOL_Componentes
Relate:SAOL_Componentes &RelationManager,THREAD            ! RelationManager for SAOL_Componentes
Access:SAOL_Software &FileManager,THREAD                   ! FileManager for SAOL_Software
Relate:SAOL_Software &RelationManager,THREAD               ! RelationManager for SAOL_Software
Access:TagSet_       &FileManager,THREAD                   ! FileManager for TagSet_
Relate:TagSet_       &RelationManager,THREAD               ! RelationManager for TagSet_
Access:TagFile_      &FileManager,THREAD                   ! FileManager for TagFile_
Relate:TagFile_      &RelationManager,THREAD               ! RelationManager for TagFile_
Access:TagFilePos_   &FileManager,THREAD                   ! FileManager for TagFilePos_
Relate:TagFilePos_   &RelationManager,THREAD               ! RelationManager for TagFilePos_
Access:SAOL_FTP_Release &FileManager,THREAD                ! FileManager for SAOL_FTP_Release
Relate:SAOL_FTP_Release &RelationManager,THREAD            ! RelationManager for SAOL_FTP_Release
Access:SAOL_FTP_Componentes &FileManager,THREAD            ! FileManager for SAOL_FTP_Componentes
Relate:SAOL_FTP_Componentes &RelationManager,THREAD        ! RelationManager for SAOL_FTP_Componentes
Access:SAOL_Passcode &FileManager,THREAD                   ! FileManager for SAOL_Passcode
Relate:SAOL_Passcode &RelationManager,THREAD               ! RelationManager for SAOL_Passcode
Access:SAOL_Log      &FileManager,THREAD                   ! FileManager for SAOL_Log
Relate:SAOL_Log      &RelationManager,THREAD               ! RelationManager for SAOL_Log

FuzzyMatcher         FuzzyClass                            ! Global fuzzy matcher
GlobalErrorStatus    ErrorStatusClass,THREAD
GlobalErrors         ErrorClass                            ! Global error manager
INIMgr               INIClass                              ! Global non-volatile storage manager
GlobalRequest        BYTE(0),THREAD                        ! Set when a browse calls a form, to let it know action to perform
GlobalResponse       BYTE(0),THREAD                        ! Set to the response from the form
VCRRequest           LONG(0),THREAD                        ! Set to the request from the VCR buttons

Dictionary           CLASS,THREAD
Construct              PROCEDURE
Destruct               PROCEDURE
                     END

lCurrentFDSetting    LONG                                  ! Used by window frame dragging
lAdjFDSetting        LONG                                  ! ditto

  CODE
  GlobalErrors.Init(GlobalErrorStatus)
  FuzzyMatcher.Init                                        ! Initilaize the browse 'fuzzy matcher'
  FuzzyMatcher.SetOption(MatchOption:NoCase, 1)            ! Configure case matching
  FuzzyMatcher.SetOption(MatchOption:WordOnly, 0)          ! Configure 'word only' matching
  INIMgr.Init('.\SAOL.INI', NVD_INI)                       ! Configure INIManager to use INI file
  DctInit
  SYSTEM{PROP:Icon} = 'saol.ico'
  SystemParametersInfo (38, 0, lCurrentFDSetting, 0)       ! Configure frame dragging
  IF lCurrentFDSetting = 1
    SystemParametersInfo (37, 0, lAdjFDSetting, 3)
  END
  Main
  INIMgr.Update
  IF lCurrentFDSetting = 1
    SystemParametersInfo (37, 1, lAdjFDSetting, 3)
  END
  INIMgr.Kill                                              ! Destroy INI manager
  FuzzyMatcher.Kill                                        ! Destroy fuzzy matcher


Dictionary.Construct PROCEDURE

  CODE
  IF THREAD()<>1
     DctInit()
  END


Dictionary.Destruct PROCEDURE

  CODE
  DctKill()

