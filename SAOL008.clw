

   MEMBER('SAOL.clw')                                      ! This is a MEMBER module

                     MAP
                       INCLUDE('SAOL008.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('SAOL007.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('SAOL009.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('SAOL010.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('SAOL011.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('SAOL012.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('SAOL018.INC'),ONCE        !Req'd for module callout resolution
                     END


!!! <summary>
!!! Generated from procedure template - Source
!!! </summary>
GenerarInstaladores  PROCEDURE  (idInstalador)             ! Declare Procedure
! Local Data
L:Major                 LONG
L:Minor                 LONG
L:Release               LONG
L:Build                 LONG
L:Fecha                 LONG
L:Hora                  LONG

Indice               LONG

HayVersion           BYTE
HayReleaseDll        BYTE

CantidadErrores			LONG
CantidadErroresISS		LONG
CantidadErroresFTP		LONG

CurrentPath				CSTRING(FILE:MaxFilePath)

QComponentes            QUEUE,PRE(QCOM)
idComponente            	LONG
Descripcion						CSTRING(FILE:MaxFilePath)
Path                       CSTRING(FILE:MaxFilePath)
ZipPath                    CSTRING(FILE:MaxFilePath)
ZipName                    CSTRING(FILE:MaxFilePath)
FtpPath                    CSTRING(FILE:MaxFilePath)
FtpName                    CSTRING(FILE:MaxFilePath)
Major                      LONG
Minor                      LONG
Release                    LONG
Build                      LONG
Fecha                      LONG
Hora                       LONG
Estado                     BYTE
								END

EstadoComponente     BYTE

QComxIns                QUEUE,PRE(QCXI)
idInstalador               LONG
idComponente               LONG
Major                      LONG
Minor                      LONG
Release                    LONG
Build                      LONG
Fecha                      LONG
Hora                       LONG
Estado                     BYTE
								END

QInstaladores				QUEUE,PRE(QINS)
idInstalador               LONG
Descripcion                CSTRING(FILE:MaxFilePath)
CUIT                       LIKE(SAOL_CLI:CUIT)
CentroEmision					LIKE(SAOL_INS:CentroEmision)
Referencia						CSTRING(101)
ISSPath                    CSTRING(FILE:MaxFilePath)
Path                       CSTRING(FILE:MaxFilePath)
Renombrar                  CSTRING(FILE:MaxFilePath)
ZipPath                    CSTRING(FILE:MaxFilePath)
ZipName                    CSTRING(FILE:MaxFilePath)
FtpPath                    CSTRING(FILE:MaxFilePath)
FtpName                    CSTRING(FILE:MaxFilePath)
Fecha                      LONG
Hora                       LONG
								END

QVersionesInstaladores	QUEUE,PRE(QVXI)
idInstalador               LONG
Major                      LONG
Minor                      LONG
Release                    LONG
Build                      LONG
Fecha                      LONG
Hora                       LONG
								END

QGitHub                 QUEUE,PRE(QGH)
Descripcion                CSTRING(FILE:MaxFilePath)
Comando                    CSTRING(FILE:MaxFilePath)
								END

QPaths               QUEUE,PRE(QPAT)
Path                       CSTRING(FILE:MaxFilePath)
								END
QFtpPaths               QUEUE,PRE(QFTPPAT)
Path                       CSTRING(FILE:MaxFilePath)
								END

ISSFileName					STRING(FILE:MaxFilePath),STATIC

ISS_File						FILE,DRIVER('ASCII','/FILEBUFFERS=8'),NAME(ISSFileName),PRE(ISS),CREATE,THREAD
Record							RECORD,PRE()
Linea									STRING(2048)
									END
								END


Loc:Path						CSTRING(FILE:MaxFilePath)
Loc:Descripcion			CSTRING(FILE:MaxFilePath)

Progreso						LONG
ProgresoParcial			LONG
ProgressWindow          WINDOW,AT(,,282,69),CENTER,FONT('Arial', 8,, FONT:bold, CHARSET:ANSI),GRAY,DOUBLE
									PROGRESS, AT(9,5,262,8), USE(Progreso), RANGE(0,100)
									STRING('Analizando scripts de instalación ... Espere por favor ...'), AT(9,16,262), USE(?String1), CENTER
									ENTRY(@s255), AT(10,27,261,10), USE(SAOL_INS:Descripcion), MSG('Descripcion del Instalador'), |
										SKIP, TIP('Descripcion del Instalador'), READONLY, CENTER
									PROGRESS, AT(9,42,262,8), USE(ProgresoParcial), RANGE(0,100)
									STRING(''), AT(9,54,262,10), USE(?StringProgresoParcial), CENTER
								END

TiempoInicio            LONG
TiempoFin               LONG

Zip                  ZipClassType

! Opciones de generación
Compilar             	BYTE(0)
Comprimir               BYTE(1)
CrearTPS                BYTE(1)
SubirFTP                BYTE(1)
SubirCompulsivamente    BYTE(0)
ActualizarInfoDB        BYTE(1)
AvanzarBuild            BYTE(1)
EnviarMail              BYTE(0)
Compulsiva           	BYTE(0)
CompulsivaInstalador    BYTE(0)
CompulsivaComponentes   BYTE(0)
CompulsivaModificados   BYTE(0)
IncluirComentados       BYTE(0)

! FTP
PermitirConnectionTypesCero      BYTE
dwConnectionTypes    ULONG

RemoteFileHandle     ULONG
LocalFileHandle      ULONG
FTPTransferType      ULONG(FTP_TRANSFER_TYPE_BINARY)
Filename             CSTRING(FILE:MaxFilePath)
LocalFilename        CSTRING(FILE:MaxFilePath)
RemoteFilename       CSTRING(2048)
DataBuffer           CSTRING(129)
LocalBytesToRead     ULONG(128)
LocalBytesRead       ULONG
RemoteBytesWritten   ULONG
TotalBytesWritten    ULONG
Comienzo    			LONG
T                    LONG
K                    LONG

InternetSession         ULONG
FTPHandle               ULONG
FileSize                ULONG

QDirectory QUEUE(FILE:Queue),PRE(QDIR)
           END

SAOL_CUIT				FILE,DRIVER('TOPSPEED'),RECLAIM,OWNER('poiewq'),ENCRYPT,NAME('SAOL_CUIT.TPS'),PRE(SAOL_CUIT),CREATE
PorReferencia            KEY(SAOL_CUIT:Referencia),DUP,NOCASE
Record                   RECORD,PRE()
Referencia                  CSTRING(101)
PathTPSFTP                    CSTRING(FILE:MaxFilePath)
PathDestino							CSTRING(FILE:MaxFilePath)
                         END
							END

INS_View             VIEW(SAOL_Instaladores)
								JOIN(SAOL_SXC:PorID,SAOL_INS:idSoftwarexCliente)
									JOIN(SAOL_CLI:PorID,SAOL_SXC:idCliente)
									END
								END
							END

QCuit                QUEUE,PRE(QCUIT)
CUIT                    LIKE(SAOL_CLI:CUIT)
CentroEmision				LIKE(SAOL_INS:CentroEmision)
							END

HayComponentesModificados BYTE

EsEjecutable BYTE

  CODE
IF NOT OpcionesGeneracion(Compilar,Comprimir,CrearTPS,SubirFTP,SubirCompulsivamente, |
				ActualizarInfoDB,AvanzarBuild,EnviarMail,Compulsiva,CompulsivaInstalador, |
				CompulsivaComponentes,CompulsivaModificados,IncluirComentados)
		RETURN False
	END

	TiempoInicio = CLOCK()
		
	CurrentPath = LONGPATH()

	FREE(QComponentes)
	FREE(QComxIns)
	FREE(QInstaladores)
	FREE(QVersionesInstaladores)
	FREE(QPaths)
	FREE(QFTPPaths)
	FREE(QCUIT)

	! Path para el Log
	QFTPPAT:Path = '/saol/log/'
	DO VerificarExistenciaPathsFTP

	Progreso   = 0
	OPEN(ProgressWindow)
	OPEN(INS_View)
	CantidadErrores = 0
	IF idInstalador
		INS_View{PROP:Filter} = 'SAOL_INS:id = ' & idInstalador
	END
	INS_View{PROP:Order} = '+SAOL_INS:Descripcion'
	SET(INS_View)
   !region LOOP Instaladores
	LOOP
		NEXT(INS_View)
		IF ERRORCODE()
			BREAK
		END
		IF idInstalador 
			IF SAOL_INS:id <> idInstalador
				BREAK
			END
		ELSE
			IF ~SAOL_INS:Procesar
				CYCLE	
			END
		END
		
		DO MostrarProgreso
		
		! Este instalador hay que procesarlo ...
		! 1) Verificar la existencia del ISS
		IF EXISTS(SAOL_INS:PathISS)
			ISSFileName = SAOL_INS:PathISS
			OPEN(ISS_File,40H)
			IF ERRORCODE()
				GrabarLog(SAOL_INS:id,'Error al abrir Script de Instalación',SAOL_INS:PathISS & ': ' & ERRORCODE())
				CantidadErrores += 1
			ELSE
				CantidadErroresISS = 0
				LOGOUT(1,SAOL_Instaladores,SAOL_Componentes,SAOL_ComponentesxInstalador)
				! Antes de nada, marcar todos los componentes como NO PROCESAR
				! de tal forma que los componentes que ya no forman parte del instalador sean ignorados
				SAOL_CXI:idInstalador = SAOL_INS:id
				SET(SAOL_CXI:PorIdInstalador,SAOL_CXI:PorIdInstalador)
				LOOP
					NEXT(SAOL_ComponentesxInstalador)
					IF ERRORCODE() OR SAOL_CXI:idInstalador <> SAOL_INS:id
						BREAK
					END
					SAOL_CXI:Procesar = 0 ! Componente (por ahora) no existe
					PUT(SAOL_ComponentesxInstalador)
				END
				HayReleaseDll = False
				HayComponentesModificados = False
				CFiles# = False
				CSetup# = False
				SET(ISS_File)
            !region LOOP ISS_File
				LOOP
					NEXT(ISS_File)
					IF ERRORCODE()
						BREAK
					END
					CASE UPPER(CLIP(ISS:Linea)) 
						OF '[FILES]'
						   CFiles# = True
							CYCLE
						OF '[SETUP]'
						   CSetup# = True
							CYCLE
					END
					IF CFiles# AND ~CSetup#
						IF UPPER(LEFT(ISS:Linea,7)) = 'SOURCE:' OR (IncluirComentados AND UPPER(LEFT(ISS:Linea,8)) = ';SOURCE:')
						   IF UPPER(LEFT(ISS:Linea,8)) = ';SOURCE:'
								Loc:Path = UPPER(SUB(ISS:Linea,10,INSTRING(';',ISS:Linea,1,2)-10))
						   ELSE
								Loc:Path = UPPER(SUB(ISS:Linea,9,INSTRING(';',ISS:Linea,1,1)-9))
						   END
							n# = LEN(CLIP(Loc:Path))-INSTRING('\',Loc:Path,-1,LEN(CLIP(Loc:Path)))
							Loc:Descripcion = SUB(CLIP(Loc:Path),-n#,n#)
							! 1) Verificar la existencia del componente
							SAOL_COM:Path = CLIP(Loc:Path)
							IF EXISTS(SAOL_COM:Path)
								GET(SAOL_Componentes,SAOL_COM:PorPath)
								IF ERRORCODE()
									! No existe ... crearlo
									SAOL_COM:Descripcion     = CLIP(Loc:Descripcion)
									SAOL_COM:Path			 	 = CLIP(Loc:Path)
									SAOL_COM:Major           = 0
									SAOL_COM:Minor           = 0
									SAOL_COM:Release         = 0
									SAOL_COM:Build           = 0
									SAOL_COM:FechaGeneracion = 0
									SAOL_COM:HoraGeneracion  = 0
									SAOL_COM:Procesar        = 1 ! Componente existente
									IF Access:SAOL_Componentes.Insert() <> Level:Benign
										GrabarLog(SAOL_INS:id,'Error al grabar nuevo Componente',CLIP(Loc:Path))
										CantidadErrores += 1
										CantidadErroresISS += 1
										CYCLE
									END
									! Reposicionar ...
									SAOL_COM:Path = CLIP(Loc:Path)
									GET(SAOL_Componentes,SAOL_COM:PorPath)
								ELSE
									SAOL_COM:Procesar = 1 ! Componente existente
									PUT(SAOL_Componentes)
								END
								! Verificar existencia de Componentes por Instalador
								SAOL_CXI:idInstalador = SAOL_INS:id
								SAOL_CXI:idComponente = SAOL_COM:id
								GET(SAOL_ComponentesxInstalador,SAOL_CXI:PorInstaladorComponente)
								IF ERRORCODE()
									SAOL_CXI:idInstalador    = SAOL_INS:id
									SAOL_CXI:idComponente    = SAOL_COM:id
									SAOL_CXI:Major           = 0
									SAOL_CXI:Minor           = 0
									SAOL_CXI:Release         = 0
									SAOL_CXI:Build           = 0
									SAOL_CXI:FechaGeneracion = 0
									SAOL_CXI:HoraGeneracion  = 0
									SAOL_CXI:Procesar        = 1 ! Componente Existente
									IF Access:SAOL_ComponentesxInstalador.Insert() <> Level:Benign
										GrabarLog(SAOL_INS:id,'Error al grabar nuevo Componente por Instalador',Loc:Path)
										CantidadErrores += 1
										CantidadErroresISS += 1
										CYCLE
									END
									! Reposicionar ...
									SAOL_CXI:idInstalador = SAOL_INS:id
									SAOL_CXI:idComponente = SAOL_COM:id
									GET(SAOL_ComponentesxInstalador,SAOL_CXI:PorInstaladorComponente)
								ELSE
									SAOL_CXI:Procesar = 1 ! Componente Existente
									PUT(SAOL_ComponentesxInstalador)
								END
								! Ahora comparar versión en archivo con versión actual,
								! si la versión actual fuera superior, marcar como Procesar = 2 (componente modificado)
								! y guardar en una cola global Versión, Fecha y Hora
								! Después, al zipear el componente, marcar como Procesar=3 (componente comprimido)
								! Al final, al subir a FTP, marcar como Procesar=4 (componente subido al FTP) y actualizar
								! Versión, Fecha y Hora desde cola global
								L:Major   = 0
								L:Minor   = 0
								L:Release = 0
								L:Build   = 0
								L:Fecha   = 0
                        L:Hora    = 0
                        EsEjecutable = False
								! Ver si ya está el componente ...
								QCOM:idComponente = SAOL_CXI:idComponente
								GET(QComponentes,+QCOM:idComponente)
								IF ERRORCODE()
									IF GetFileVersion(Loc:Path,L:Major,L:Minor,L:Release,L:Build,L:Fecha,L:Hora,EsEjecutable)
										HayVersion = True
									ELSE
										HayVersion = False
									END
								ELSE
									L:Major      = QCOM:Major 
									L:Minor      = QCOM:Minor
									L:Release    = QCOM:Release
									L:Build      = QCOM:Build
									L:Fecha      = QCOM:Fecha
									L:Hora       = QCOM:Hora
									IF L:Major OR L:Minor OR L:Release OR L:Build
										HayVersion = True
									ELSE
										HayVersion = False
									END
								END
								IF HayVersion = True
									IF UPPER(SAOL_COM:Descripcion) = 'RELEASE.DLL' OR |
										(~HayReleaseDll AND UPPER(SAOL_COM:Descripcion) = 'DATOS.DLL')
										HayReleaseDll = True
										QVXI:idInstalador = SAOL_INS:id
										GET(QVersionesInstaladores,+QVXI:idInstalador)
										IF ERRORCODE()
											QVXI:idInstalador = SAOL_INS:id
											QVXI:Major        = L:Major
											QVXI:Minor        = L:Minor
											QVXI:Release      = L:Release
											QVXI:Build        = L:Build
											QVXI:Fecha        = L:Fecha
											QVXI:Hora         = L:Hora 
											ADD(QVersionesInstaladores,+QVXI:idInstalador)
											ASSERT(~ERRORCODE())
										ELSE
											QVXI:Major        = L:Major
											QVXI:Minor        = L:Minor
											QVXI:Release      = L:Release
											QVXI:Build        = L:Build
											QVXI:Fecha        = L:Fecha
											QVXI:Hora         = L:Hora 
											PUT(QVersionesInstaladores)
											ASSERT(~ERRORCODE())
										END
									END
									IF SubirCompulsivamente OR CompulsivaInstalador OR CompulsivaComponentes OR (L:Major > SAOL_COM:Major) OR |
										(L:Major = SAOL_COM:Major AND L:Minor > SAOL_COM:Minor) OR |
										(L:Major = SAOL_COM:Major AND L:Minor = SAOL_COM:Minor AND L:Release > SAOL_COM:Release) OR |
										(L:Major = SAOL_COM:Major AND L:Minor = SAOL_COM:Minor AND L:Release = SAOL_COM:Release AND L:Build > SAOL_COM:Build)
										SAOL_COM:Procesar = 2 ! Componente modificado
										PUT(SAOL_Componentes)
										
										EstadoComponente = 2 ! Componente modificado
										HayComponentesModificados = True
									ELSE
										EstadoComponente = 1 ! Componente existente
									END
									DO CargarComponente
									IF SubirCompulsivamente OR CompulsivaInstalador OR CompulsivaComponentes OR (L:Major > SAOL_CXI:Major) OR |
										(L:Major = SAOL_CXI:Major AND L:Minor > SAOL_CXI:Minor) OR |
										(L:Major = SAOL_CXI:Major AND L:Minor = SAOL_CXI:Minor AND L:Release > SAOL_CXI:Release) OR |
										(L:Major = SAOL_CXI:Major AND L:Minor = SAOL_CXI:Minor AND L:Release = SAOL_CXI:Release AND L:Build > SAOL_CXI:Build)
										SAOL_CXI:Procesar = 2 ! Componente modificado
										PUT(SAOL_ComponentesxInstalador)
										
										EstadoComponente = 2 ! Componente modificado
										HayComponentesModificados = True
									ELSE
										EstadoComponente = 1 ! Componente existente
									END
									DO CargarComponentexInstalador
								ELSE
									IF EsEjecutable OR ~L:Fecha
										GrabarLog(SAOL_INS:id,'Error al obtener versión de Componente',CLIP(Loc:Path))
										CantidadErrores += 1
										CantidadErroresISS += 1
										CYCLE
									ELSE
										IF SubirCompulsivamente OR CompulsivaInstalador OR CompulsivaComponentes OR (L:Fecha > SAOL_COM:FechaGeneracion) OR |
											(L:Fecha = SAOL_COM:FechaGeneracion AND L:Hora > SAOL_COM:HoraGeneracion)
											SAOL_COM:Procesar = 2 ! Componente modificado
											PUT(SAOL_Componentes)
											
											EstadoComponente = 2 ! Componente modificado
											HayComponentesModificados = True
										ELSE
											EstadoComponente = 1 ! Componente existente
										END
										DO CargarComponente
										IF SubirCompulsivamente OR CompulsivaInstalador OR CompulsivaComponentes OR (L:Fecha > SAOL_CXI:FechaGeneracion) OR |
											(L:Fecha = SAOL_CXI:FechaGeneracion AND L:Hora > SAOL_CXI:HoraGeneracion)
											SAOL_CXI:Procesar = 2 ! Componente modificado
											PUT(SAOL_ComponentesxInstalador)
											
											EstadoComponente = 2 ! Componente modificado
											HayComponentesModificados = True
										ELSE
											EstadoComponente = 1 ! Componente existente
										END
										DO CargarComponentexInstalador
									END
								END
							ELSE
								GrabarLog(SAOL_INS:id,'No Existe el Componente',CLIP(Loc:Path))
								CantidadErrores += 1
								CantidadErroresISS += 1
								CYCLE
							END
						END
					END
					IF CSetup#
						IF UPPER(LEFT(ISS:Linea,19)) = 'OUTPUTBASEFILENAME='
							SAOL_INS:OutputBaseFilename = UPPER(SUB(ISS:Linea,20,LEN(CLIP(ISS:Linea))-19))
							PUT(SAOL_Instaladores)
						END
						IF UPPER(LEFT(ISS:Linea,10)) = 'OUTPUTDIR='
							SAOL_INS:OutputDir = UPPER(SUB(ISS:Linea,11,LEN(CLIP(ISS:Linea))-10))
							PUT(SAOL_Instaladores)
						END
						IF UPPER(LEFT(ISS:Linea,15)) = 'DEFAULTDIRNAME='
							SAOL_INS:DefaultDirName = UPPER(SUB(ISS:Linea,16,LEN(CLIP(ISS:Linea))-15))
							PUT(SAOL_Instaladores)
						END
					END
					DO MostrarProgreso
				END
            !endregion				
				IF CantidadErroresISS OR ~HayComponentesModificados
					IF CantidadErroresISS
						MESSAGE('No se generará el Instalador. ' & CantidadErroresISS & ' errores||' & SAOL_INS:Descripcion,'Atención !',ICON:Hand)
						GrabarLog(SAOL_INS:id,'No se generará el Instalador. ' & CantidadErroresISS & ' errores',CLIP(SAOL_INS:PathISS))
					ELSE
						MESSAGE('No se generará el Instalador, no hay componentes modificados.||' & SAOL_INS:Descripcion,'Atención !',ICON:Asterisk)
						GrabarLog(SAOL_INS:id,'No se generará el Instalador, no hay componentes modificados.',CLIP(SAOL_INS:PathISS))
					END
					
					QINS:idInstalador = SAOL_INS:id
					GET(QInstaladores,+QINS:idInstalador)
					IF NOT ERRORCODE()
						DELETE(QInstaladores)
						ASSERT(NOT ERRORCODE())
					END
					ROLLBACK
				ELSE
					COMMIT
				END
				CLOSE(ISS_File)
			END
		ELSE
			GrabarLog(SAOL_INS:id,'No Existe el Script de Instalación',SAOL_INS:PathISS)
			CantidadErrores += 1
		END
	END
   !endregion		
   
	IF RECORDS(QInstaladores)
		! A esta altura, tengo en las colas: Instaladores a generar, Componentes a zipear y subir.
		SORT(QInstaladores,+QINS:Descripcion)

		! Crear Directorios necesarios para guardar los zip
		DO CrearDirectorios
		
		IF Compilar
			! Crear instaladores ...
			?String1{PROP:Text} = 'Generando Instaladores ... Espere por favor ...'
			?Progreso{PROP:RangeHigh} = RECORDS(QInstaladores)
			Progreso = 0
			LOOP I# = 1 TO RECORDS(QInstaladores)
				GET(QInstaladores,I#)
				ASSERT(~ERRORCODE())
				YIELD

				SAOL_INS:Descripcion = QINS:Descripcion
				DO MostrarProgreso

				RUN('"C:\Program Files (x86)\Inno Setup 5\Compil32.exe" /cc "' & QINS:ISSPath & '"',1)
				IF RUNCODE()
					GrabarLog(QINS:idInstalador,'Error al ejecutar Compilador: ' & RUNCODE(),QINS:ISSPath)
					CantidadErrores += 1
					QINS:Fecha = 0
					QINS:Hora  = 0
				ELSE
					QINS:Fecha = TODAY()
					QINS:Hora  = CLOCK()
				END
				PUT(QInstaladores)
				ASSERT(~ERRORCODE())
				
				YIELD
			END
		END
			
		IF Comprimir

			! Zipear componentes e instaladores ...
			?String1{PROP:Text} = 'Comprimiendo archivos ... Espere por favor ...'
			?Progreso{PROP:RangeHigh} = RECORDS(QInstaladores)
			Progreso = 0
			LOOP I# = 1 TO RECORDS(QInstaladores)
				GET(QInstaladores,I#)
				ASSERT(~ERRORCODE())

				SAOL_INS:Descripcion = QINS:Descripcion
				DO MostrarProgreso
				
				IF Compilar
					! renombrar para evitar error -168
					REMOVE(QINS:Renombrar)
					RENAME(QINS:Path,QINS:Renombrar)
					YIELD
					DO Esperar
					?StringProgresoParcial{PROP:Text} = QINS:Renombrar
					DISPLAY(?StringProgresoParcial)
					!Zip.Init(,,,,,,LIC:UserName,LIC:UserPin)
					Zip.Init(ProgressWindow,?ProgresoParcial,,?StringProgresoParcial,,,LIC:UserName,LIC:UserPin)
					! Define the zip archive name
					!message('Zip Name = ' & QINS:ZipPath & '\' & QINS:ZipName)
					Zip.SetArchiveName(QINS:ZipPath & '\' & QINS:ZipName)
					! Define all files to be zipped up
					!message('Archivo a zipear = ' & QINS:Renombrar)
					Zip.DefineFileSpec(QINS:Renombrar)
					! Set Compression Level
					z# = Zip.SetCompressionLevel(5)
					! Add flag
					Zip.AddFlag(ZIP_QUIET_FLAG)
					! Verify Password
					R# = Zip.SetPassword('poiewq')
					! Execute zip command
					R# = Zip.LSZExecute(zm_ADD)
					IF R#
						GrabarLog(QINS:idInstalador,'ZIP Instalador Error: ' & Zip.GetLastError(),QINS:Path)
						CantidadErrores += 1
					ELSE
						! Comprimido ... Borrar instalador ...
						REMOVE(QINS:Renombrar)
					END
					Zip.Kill()
				END

				QCXI:idInstalador = QINS:idInstalador
				GET(QComxIns,+QCXI:idInstalador)
				P# = POINTER(QComxIns)
				LOOP
					IF QCXI:idInstalador <> QINS:idInstalador
						BREAK
					END
					QCOM:idComponente = QCXI:idComponente
					GET(QComponentes,+QCOM:idComponente)
					ASSERT(~ERRORCODE())
					IF QCOM:Estado = 2
						?StringProgresoParcial{PROP:Text} = QCOM:Path
						DISPLAY(?StringProgresoParcial)
						!Zip.Init(,,,,,,LIC:UserName,LIC:UserPin)
						Zip.Init(ProgressWindow,?ProgresoParcial,,?StringProgresoParcial,,,LIC:UserName,LIC:UserPin)
						! Define the zip archive name
						Zip.SetArchiveName(QCOM:ZipPath & '\' & QCOM:ZipName)
						! Define all files to be zipped up
						Zip.DefineFileSpec(QCOM:Path)
						! Set Compression Level
						z# = Zip.SetCompressionLevel(5)
						! Add flag
						Zip.AddFlag(ZIP_QUIET_FLAG)
						! Verify Password
						R# = Zip.SetPassword('poiewq')
						! Execute zip command
						R# = Zip.LSZExecute(zm_ADD)
						IF R#
							GrabarLog(QINS:idInstalador,'ZIP Componente Error: ' & Zip.GetLastError(),QCOM:ZipPath & '\' & QCOM:ZipName)
							CantidadErrores += 1
						ELSE
							QCOM:Estado = 3 ! Comprimido
							PUT(QComponentes)
							ASSERT(NOT ERRORCODE())
						END
						Zip.Kill()
					END
					
					P# += 1
					GET(QComxIns,P#)
					IF ERRORCODE()
						BREAK
					END
				END
			END
		END
			
		IF CrearTPS
			! Crear TPS con información ...
			?String1{PROP:Text} = 'Creando TPS para FTP ... Espere por favor ...'
			?Progreso{PROP:RangeHigh} = RECORDS(QInstaladores) + RECORDS(QCuit)
			Progreso = 0
			LOOP Indice = 1 TO RECORDS(QInstaladores)
				GET(QInstaladores,Indice)
				ASSERT(~ERRORCODE())

				SAOL_INS:Descripcion = QINS:Descripcion
				DO MostrarProgreso

				CREATE(SAOL_FTP_Release)
				CREATE(SAOL_FTP_Componentes)
				OPEN(SAOL_FTP_Release,12H)
				OPEN(SAOL_FTP_Componentes,12H)

				LOGOUT(1,SAOL_FTP_Release,SAOL_FTP_Componentes)

				QVXI:idInstalador = QINS:idInstalador
				GET(QVersionesInstaladores,+QVXI:idInstalador)
				IF ERRORCODE()
					FTP_REL:Major      = 0
					FTP_REL:Minor      = 0
					FTP_REL:Build      = 0
					FTP_REL:Release    = 0
				ELSE
					FTP_REL:Major      = QVXI:Major
					FTP_REL:Minor      = QVXI:Minor
					FTP_REL:Build      = QVXI:Build
					FTP_REL:Release    = QVXI:Release
				END
				FTP_REL:Compulsiva    = CompulsivaInstalador
				FTP_REL:Path          = CLIP(QINS:FtpPath) & '/' & CLIP(QINS:FtpName)
				IF Access:SAOL_FTP_Release.Insert() <> Level:Benign
					GrabarLog(QINS:idInstalador,'Error al grabar FTP_RELEASE',QINS:ISSPath)
					CantidadErrores += 1
				END
				
				QCXI:idInstalador = QINS:idInstalador
				CLEAR(QCXI:idComponente)
				GET(QComxIns,+QCXI:idInstalador)
				P# = POINTER(QComxIns)
				LOOP
					IF QCXI:idInstalador <> QINS:idInstalador
						BREAK
					END
					QCOM:idComponente = QCXI:idComponente
					GET(QComponentes,+QCOM:idComponente)
					ASSERT(~ERRORCODE())
					
					FTP_COM:Nombre     = QCOM:Descripcion
					FTP_COM:Major      = QCXI:Major
					FTP_COM:Minor      = QCXI:Minor
					FTP_COM:Build      = QCXI:Build
					FTP_COM:Release    = QCXI:Release
					FTP_COM:Fecha      = QCXI:Fecha
					FTP_COM:Hora       = QCXI:Hora
					FTP_COM:Path       = QCOM:FtpPath & '/' & QCOM:FtpName
					FTP_COM:Compulsiva = CHOOSE(CompulsivaComponentes OR CompulsivaModificados,True,False)
					IF Access:SAOL_FTP_Componentes.Insert() <> Level:Benign
						GrabarLog(QINS:idInstalador,'Error al grabar FTP_COMPONENTES',QINS:ISSPath)
						CantidadErrores += 1
					END
					
					P# += 1
					IF P# > RECORDS(QComxIns)
						BREAK
					END
					GET(QComxIns,P#)
					IF ERRORCODE()
						BREAK
					END
				END
				COMMIT
				CLOSE(SAOL_FTP_Componentes)
				CLOSE(SAOL_FTP_Release)
				YIELD

				?StringProgresoParcial{PROP:Text} = 'SAOL_FTP.TPS'
				DISPLAY(?StringProgresoParcial)

				!Zip.Init(,,,,,,LIC:UserName,LIC:UserPin)
				Zip.Init(ProgressWindow,?ProgresoParcial,,?StringProgresoParcial,,,LIC:UserName,LIC:UserPin)
				! Define the zip archive name
				Zip.SetArchiveName(CurrentPath & '\tps\' & CLIP(QINS:Descripcion) & '.zip')
				! Define all files to be zipped up
				Zip.DefineFileSpec(CurrentPath & '\SAOL_FTP.TPS')
				! Set Compression Level
				z# = Zip.SetCompressionLevel(5)
				! Add flag
				Zip.AddFlag(ZIP_QUIET_FLAG)
				! Verify Password
				R# = Zip.SetPassword('poiewq')
				! Execute zip command
				R# = Zip.LSZExecute(zm_ADD)
				IF R#
					GrabarLog(QINS:idInstalador,'ZIP SAOL_FTP.tps - Error: ' & Zip.GetLastError(),QINS:Path)
					CantidadErrores += 1
				ELSE
					! Comprimido ... Borrar tps ...
					REMOVE(CurrentPath & '\SAOL_FTP.TPS')
					IF ERRORCODE()
						GrabarLog(QINS:idInstalador,'Error al borrar SAOL_FTP.TPS',QINS:ISSPath)
						CantidadErrores += 1
					END
				END
				Zip.Kill()
			END

			! Crear TPS con información de SISTEMAS INSTALADOS por CUIT
			LOOP Indice = 1 TO RECORDS(QCuit)
				GET(QCuit,Indice)
				ASSERT(~ERRORCODE())

				SAOL_INS:Descripcion = 'C.U.I.T.: ' & FORMAT(QCUIT:CUIT,@P##-########-#P) & |
					                    CHOOSE(QCUIT:CentroEmision=0,'',' - C.E.: ' & FORMAT(QCUIT:CentroEmision,@N04))
				DO MostrarProgreso

				CREATE(SAOL_CUIT)
				OPEN(SAOL_CUIT,42H)
				INS_View{PROP:Filter} = 'SAOL_CLI:CUIT = ''' & QCUIT:CUIT & '''' & |
					                     ' AND SAOL_INS:CentroEmision = ' & QCUIT:CentroEmision & |
					                     ' AND SAOL_INS:Estado = 1'
				SET(INS_View)
				LOOP
					NEXT(INS_View)
					IF ERRORCODE()
						BREAK
					END
					SAOL_CUIT:Referencia  = SAOL_INS:Referencia
					SAOL_CUIT:PathTPSFTP  = '/saol/' & FtpPath(CLIP(SAOL_INS:Descripcion)) & '.zip'
					SAOL_CUIT:PathDestino = SAOL_INS:DefaultDirName
					ADD(SAOL_CUIT)
					ASSERT(~ERRORCODE())
				END
				CLOSE(SAOL_CUIT)
				YIELD
				! Comprimir
				?StringProgresoParcial{PROP:Text} = 'SAOL_CUIT.TPS'
				DISPLAY(?StringProgresoParcial)

				!Zip.Init(,,,,,,LIC:UserName,LIC:UserPin)
				Zip.Init(ProgressWindow,?ProgresoParcial,,?StringProgresoParcial,,,LIC:UserName,LIC:UserPin)
				! Define the zip archive name
				Zip.SetArchiveName(CurrentPath & '\tps\' & QCUIT:CUIT & |
					                CHOOSE(QCUIT:CentroEmision=0,'','_' & FORMAT(QCUIT:CentroEmision,@N04)) & '.zip')
				! Define all files to be zipped up
				Zip.DefineFileSpec(CurrentPath & '\SAOL_CUIT.TPS')
				! Set Compression Level
				z# = Zip.SetCompressionLevel(5)
				! Add flag
				Zip.AddFlag(ZIP_QUIET_FLAG)
				! Verify Password
				R# = Zip.SetPassword('poiewq')
				! Execute zip command
				R# = Zip.LSZExecute(zm_ADD)
				IF R#
					GrabarLog(0,'ZIP SAOL_CUIT.tps Error: ' & Zip.GetLastError(),QCUIT:CUIT)
					CantidadErrores += 1
				ELSE
					REMOVE(CurrentPath & '\SAOL_CUIT.TPS')
				END
				Zip.Kill()
			END
		END
			
		IF SubirFTP
			! Subir al FTP los archivos ...
			DO ConectarseFTP
			IF ~CantidadErroresFTP
				DO CrearDirectoriosFTP
				IF ~CantidadErroresFTP
					DO BorrarCuitFTP
					IF ~CantidadErroresFTP
						?Progreso{PROP:RangeHigh} = RECORDS(QInstaladores)
						Progreso = 0
						LOOP Indice = 1 TO RECORDS(QInstaladores)
							GET(QInstaladores,Indice)
							ASSERT(~ERRORCODE())

							SAOL_INS:Descripcion = QINS:Descripcion
							
							! Transferir Archivo TPS
							?String1{PROP:Text} = 'Transfiriendo archivo TPS (SAOL_FTP) al Servidor FTP ... Espere por favor ...'
							DO MostrarProgreso
							FileName       = CLIP(QINS:Descripcion) & '.zip'
							LocalFilename  = CurrentPath & '\tps\' & FileName
							RemoteFilename = '/saol/' & FtpPath(QINS:Descripcion) & '.zip'
							!MESSAGE('VOY A TRANSFERIR ' & LocalFilename)
							DO TransferirFTP
							IF CantidadErroresFTP
								BREAK
							END
							! Ahora Instalador ...
							IF Compilar
								 ?String1{PROP:Text} = 'Transfiriendo Instalador al Servidor FTP ... Espere por favor ...'
								DISPLAY
								FileName       = QINS:ZipName
								LocalFilename  = QINS:ZipPath & '\' & QINS:ZipName
								RemoteFilename = QINS:FtpPath & '/' & QINS:FtpName
								!MESSAGE('VOY A TRANSFERIR INSTALADOR' & LocalFilename)
								DO TransferirFTP
								IF CantidadErroresFTP
									BREAK
								END
							END
							
							! Ahora Componentes ...
							 ?String1{PROP:Text} = 'Transfiriendo Componentes al Servidor FTP ... Espere por favor ...'
							DISPLAY
							QCXI:idInstalador = QINS:idInstalador
							GET(QComxIns,+QCXI:idInstalador)
							P# = POINTER(QComxIns)
							LOOP
								IF QCXI:idInstalador <> QINS:idInstalador
									BREAK
								END
								QCOM:idComponente = QCXI:idComponente
								GET(QComponentes,+QCOM:idComponente)
								ASSERT(~ERRORCODE())
								IF QCOM:Estado = 3
									FileName       = QCOM:ZipName
									LocalFilename  = QCOM:ZipPath & '\' & QCOM:ZipName
									RemoteFilename = QCOM:FtpPath & '/' & QCOM:FtpName
									!MESSAGE('VOY A TRANSFERIR COMPONENTE' & LocalFilename)
									DO TransferirFTP
									IF CantidadErroresFTP
										BREAK
									END
									
									QCOM:Estado = 4 ! Subido al FTP
									PUT(QComponentes)
									ASSERT(NOT ERRORCODE())
								END
								
								P# += 1
								GET(QComxIns,P#)
								IF ERRORCODE()
									BREAK
								END
							END
							IF CantidadErroresFTP
								BREAK
							END
						END
						IF ~CantidadErroresftp
							?String1{PROP:Text} = 'Transfiriendo archivo TPS (SAOL_CUIT) al Servidor FTP ... Espere por favor ...'
							?Progreso{PROP:RangeHigh} = RECORDS(QInstaladores)
							Progreso = 0
							LOOP Indice = 1 TO RECORDS(QCuit)
								GET(QCuit,Indice)
								ASSERT(~ERRORCODE())

								SAOL_INS:Descripcion = 'C.U.I.T.: ' & FORMAT(QCUIT:CUIT,@P##-########-#P) & |
									                    CHOOSE(QCUIT:CentroEmision=0,'',' - C.E.: ' & FORMAT(QCUIT:CentroEmision,@N04))
								DO MostrarProgreso

								FileName       = CLIP(QCUIT:CUIT) & |
					                			  CHOOSE(QCUIT:CentroEmision=0,'','_' & FORMAT(QCUIT:CentroEmision,@N04)) & '.zip'
								LocalFilename  = CurrentPath & '\tps\' & FileName
								RemoteFilename = '/saol/' & FtpPath(CLIP(QCUIT:CUIT)) & |
					                			  CHOOSE(QCUIT:CentroEmision=0,'','_' & FORMAT(QCUIT:CentroEmision,@N04)) & '.zip'
								!MESSAGE('VOY A TRANSFERIR ' & LocalFilename)
								DO TransferirFTP
								IF CantidadErroresFTP
									BREAK
								END
							END
						END
					END
				END
			END
			DO DesconectarseFTP
         IF NOT CantidadErroresFTP AND ActualizarInfoDB
				! Actualizar GITHUB
				?String1{PROP:Text} = 'Actualizando versiones publicadas en GITHUB ... Espere por favor ...'
				?Progreso{PROP:RangeHigh} = RECORDS(QGitHub)
				Progreso = 0
				LOOP I# = 1 TO RECORDS(QGitHub)
					GET(QGitHub,I#)
               ASSERT(~ERRORCODE())

               YIELD

               SAOL_INS:Descripcion = QGH:Descripcion
               DO MostrarProgreso

               RUN(QGH:Comando,1)
               IF RUNCODE()
                  GrabarLog(QGH:Descripcion,'Error al ejecutar GITHUB.CMD: ' & RUNCODE(),QGH:Comando)
               END
               YIELD
            END
            
				! Actualizar info de versiones en DB
				?String1{PROP:Text} = 'Actualizando versiones publicadas en Base de Datos ... Espere por favor ...'
				?Progreso{PROP:RangeHigh} = RECORDS(QInstaladores)
				Progreso = 0
				LOOP I# = 1 TO RECORDS(QInstaladores)
					GET(QInstaladores,I#)
					ASSERT(~ERRORCODE())

					SAOL_INS:Descripcion = QINS:Descripcion
					DO MostrarProgreso

					LOGOUT(1,SAOL_Instaladores,SAOL_ComponentesxInstalador,SAOL_Componentes)
					SAOL_INS:id = QINS:idInstalador
					GET(SAOL_Instaladores,SAOL_INS:PorID)
					IF NOT ERRORCODE()
						QVXI:idInstalador = QINS:idInstalador
						GET(QVersionesInstaladores,+QVXI:idInstalador)
						IF ERRORCODE()
							QVXI:Major   = 0
							QVXI:Minor   = 0
							QVXI:Release = 0
							QVXI:Build   = 0
						END
						SAOL_INS:GeneradoFecha = QVXI:Fecha
						SAOL_INS:GeneradoHora  = QVXI:Hora
						SAOL_INS:Major         = QVXI:Major
						SAOL_INS:Minor         = QVXI:Minor
						SAOL_INS:Release       = QVXI:Release
						SAOL_INS:Build         = QVXI:Build
						PUT(SAOL_Instaladores)
						IF AvanzarBuild AND CLIP(SAOL_INS:ReleaseIni)
							PUTINI('FileVersion','VIFileVersionLL',SAOL_INS:Build+1,SAOL_INS:ReleaseIni)
							PUTINI('FileVersion','VIFileVersionStr',CLIP(SAOL_INS:Major & '.' & SAOL_INS:Minor & '.' & |
								    SAOL_INS:Release & '.' & (SAOL_INS:Build+1)),SAOL_INS:ReleaseIni)
							PUTINI('ProductVersion','VIProductVersionLL',SAOL_INS:Build+1,SAOL_INS:ReleaseIni)
							PUTINI('ProductVersion','VIProductVersionStr',CLIP(SAOL_INS:Major & '.' & SAOL_INS:Minor & '.' & |
									 SAOL_INS:Release & '.' & (SAOL_INS:Build+1)),SAOL_INS:ReleaseIni)
						END
					END
					
					QCXI:idInstalador = QINS:idInstalador
					CLEAR(QCXI:idComponente)
					GET(QComxIns,+QCXI:idInstalador)
					P# = POINTER(QComxIns)
					LOOP
						IF QCXI:idInstalador <> QINS:idInstalador
							BREAK
						END
						! Componentes
						QCOM:idComponente = QCXI:idComponente
						GET(QComponentes,+QCOM:idComponente)
						ASSERT(~ERRORCODE())
						IF QCOM:Estado < 5
							SAOL_COM:id = QCXI:idComponente
							GET(SAOL_Componentes,SAOL_COM:PorID)
							IF NOT ERRORCODE()
								SAOL_COM:Major           = QCOM:Major
								SAOL_COM:Minor           = QCOM:Minor
								SAOL_COM:Release         = QCOM:Release
								SAOL_COM:Build           = QCOM:Build
								SAOL_COM:FechaGeneracion = QCOM:Fecha
								SAOL_COM:HoraGeneracion  = QCOM:Hora
								PUT(SAOL_Componentes)
							END
							QCOM:Estado = 5
							PUT(QComponentes)
							ASSERT(NOT ERRORCODE())
						END
						! Componentes por Instalador
						SAOL_CXI:idInstalador = QCXI:idInstalador
						SAOL_CXI:idComponente = QCXI:idComponente 
						GET(SAOL_ComponentesxInstalador,SAOL_CXI:PorInstaladorComponente)
						IF NOT ERRORCODE()
							SAOL_CXI:Major           = QCXI:Major
							SAOL_CXI:Minor           = QCXI:Minor
							SAOL_CXI:Release         = QCXI:Release
							SAOL_CXI:Build           = QCXI:Build
							SAOL_CXI:FechaGeneracion = QCXI:Fecha
							SAOL_CXI:HoraGeneracion  = QCXI:Hora
							PUT(SAOL_ComponentesxInstalador)
						END
						
						P# += 1
						IF P# > RECORDS(QComxIns)
							BREAK
						END
						GET(QComxIns,P#)
						IF ERRORCODE()
							BREAK
						END
					END
					COMMIT
				END
			END
		END	
	END
	CLOSE(INS_View)
	CLOSE(ProgressWindow)

	FREE(QComponentes)
	FREE(QComxIns)
	FREE(QInstaladores)
	FREE(QVersionesInstaladores)
	FREE(QPaths)
	FREE(QCUIT)

	IF CantidadErrores = 0
		TiempoFin = CLOCK()	
		MESSAGE('Proceso realizado correctamente.||Tiempo empleado: ' & FORMAT(TiempoFin-TiempoInicio,@t4),'Atención !',ICON:Asterisk)
	ELSE
		MESSAGE('Se produjeron ' & CantidadErrores & ' errores en el Proceso.','VERIFIQUE !',ICON:Exclamation)
	END

	RETURN CHOOSE(CantidadErrores=0,True,False)
MostrarProgreso      ROUTINE
	Progreso += 1
	IF Progreso > ?Progreso{PROP:RangeHigh}
		Progreso = 1
	END
	DISPLAY
	EXIT
CargarComponentexInstalador    ROUTINE

	QINS:idInstalador = SAOL_CXI:idInstalador
	GET(QInstaladores,+QINS:idInstalador)
	IF ERRORCODE()
		QINS:idInstalador  = SAOL_CXI:idInstalador
		QINS:Descripcion   = CLIP(SAOL_INS:Descripcion)
		QINS:Referencia    = CLIP(SAOL_INS:Referencia)
		QINS:CUIT          = SAOL_CLI:CUIT
		QINS:CentroEmision = SAOL_INS:CentroEmision
		QINS:Path          = CLIP(SAOL_INS:OutputDir) & '\' & CLIP(SAOL_INS:OutputBaseFilename) & '.exe'
		QINS:Renombrar     = CLIP(SAOL_INS:OutputDir) & '\' & CleanPath(SAOL_INS:OutputBaseFilename) & '.exe'
		! Setear ZipPath y FtpPath
		inicio# = INSTRING('\',QINS:Path,1,1)
		fin#    = INSTRING('\',QINS:Path,-1,LEN(QINS:Path))
		IF inicio# = fin#
			! NADA PARA CREAR
			QINS:FtpPath = '\'
			QINS:ZipPath = CurrentPath & '\zip\'
		ELSE
			QINS:FtpPath = QINS:Path[inicio# : fin#-1]
			QINS:ZipPath = CurrentPath & '\zip' & QINS:FtpPath
		END
		!message('ZipPath INSTALADOR=' & QINS:ZipPath)
		QINS:ZipName = CLIP(SAOL_INS:Descripcion) & '.zip'
		QINS:FtpPath = '\saol' & QINS:FtpPath
		QINS:FtpPath = FtpPath(QINS:FtpPath)
		QINS:FtpName = CLIP(SAOL_INS:Descripcion)
		QINS:FtpName = FtpPath(QINS:FtpName) & '.zip'
		QINS:ISSPath = SAOL_INS:PathISS
		QINS:Fecha   = 0
		QINS:Hora    = 0
		ADD(QInstaladores,+QINS:idInstalador)
		ASSERT(~ERRORCODE())
		QFTPPAT:Path = QINS:FtpPath
		DO VerificarExistenciaPathsFTP
		
		QCUIT:CUIT          = QINS:CUIT
		QCUIT:CentroEmision = QINS:CentroEmision
		GET(QCuit,+QCUIT:CUIT,+QCUIT:CentroEmision)
		IF ERRORCODE()
			QCUIT:CUIT          = QINS:CUIT
			QCUIT:CentroEmision = QINS:CentroEmision
			ADD(QCuit,+QCUIT:CUIT,+QCUIT:CentroEmision)
			ASSERT(~ERRORCODE())
		END
	END

	QCXI:idInstalador = SAOL_CXI:idInstalador
	QCXI:idComponente = SAOL_CXI:idComponente
	GET(QComxIns,+QCXI:idInstalador,+QCXI:idComponente)
	IF ERRORCODE()
		QCXI:idInstalador = SAOL_CXI:idInstalador
		QCXI:idComponente = SAOL_CXI:idComponente
		QCXI:Major        = L:Major
		QCXI:Minor        = L:Minor
		QCXI:Release      = L:Release
		QCXI:Build        = L:Build
		QCXI:Fecha        = L:Fecha
		QCXI:Hora         = L:Hora
		QCXI:Estado       = EstadoComponente
		ADD(QComxIns,+QCXI:idInstalador,+QCXI:idComponente)
		ASSERT(~ERRORCODE())
	END
	EXIT
CargarComponente     ROUTINE

	QCOM:idComponente = SAOL_CXI:idComponente
	GET(QComponentes,+QCOM:idComponente)
	IF ERRORCODE()
		QCOM:idComponente = SAOL_CXI:idComponente
		QCOM:Descripcion  = CLIP(SAOL_COM:Descripcion)
		QCOM:Path         = SAOL_COM:Path
		! Setear ZipPath y FtpPath
		inicio# = INSTRING('\',QCOM:Path,1,1)
		fin#    = INSTRING('\',QCOM:Path,-1,LEN(QCOM:Path))
		IF inicio# = fin#
			! NADA PARA CREAR
			QCOM:FtpPath = '\'
			QCOM:ZipPath = CurrentPath & '\zip\'
		ELSE
			QCOM:FtpPath = QCOM:Path[inicio# : fin#-1]
			QCOM:ZipPath = CurrentPath & '\zip' & QCOM:FtpPath
			QPAT:Path = QCOM:ZipPath
			DO VerificarExistenciaPaths
		END
		!message('ZipPath COMPONENTE=' & QCOM:ZipPath)
		QCOM:ZipName      = CLIP(SAOL_COM:Descripcion)
		QCOM:ZipName      = CleanPath(QCOM:ZipName) & '.zip'
		QCOM:FtpPath      = '\saol' & QCOM:FtpPath
		QCOM:FtpPath      = FtpPath(QCOM:FtpPath)
		QCOM:FtpName      = QCOM:ZipName
		QCOM:Major        = L:Major
		QCOM:Minor        = L:Minor
		QCOM:Release      = L:Release
		QCOM:Build        = L:Build
		QCOM:Fecha        = L:Fecha
		QCOM:Hora         = L:Hora
		QCOM:Estado       = EstadoComponente
		ADD(QComponentes,+QCOM:idComponente)
		ASSERT(~ERRORCODE())

		QFTPPAT:Path = QCOM:FtpPath
		DO VerificarExistenciaPathsFTP
	END
	EXIT
CrearDirectorios     ROUTINE
	
	QPAT:Path = CurrentPath & '\tps'
	IF CrearDirectorio(QPAT:Path)
	END
	LOOP I# = 1 TO RECORDS(QPaths)
		GET(QPaths,I#)
		ASSERT(~ERRORCODE())
		IF CrearDirectorio(QPAT:Path)
		END
	END
	LOOP I# = 1 TO RECORDS(QInstaladores)
		GET(QInstaladores,I#)
		ASSERT(~ERRORCODE())
		IF CrearDirectorio(QINS:ZipPath)
		END
	END
	EXIT
CrearDirectoriosFTP     ROUTINE
	
	?String1{PROP:Text} = 'Verificando existencia de Carpetas FTP ... Espere por favor ...'
	?Progreso{PROP:RangeHigh} = RECORDS(QFtpPaths)
	Progreso = 0

	LOOP I# = 1 TO RECORDS(QFtpPaths)
		GET(QFtpPaths,I#)
		ASSERT(~ERRORCODE())
		SAOL_INS:Descripcion = QFTPPAT:Path
		DO MostrarProgreso
		
		R# = FtpCreateDirectory(FTPHandle,QFTPPAT:Path)
		IF R# <> 1 AND R# <> 0
			GrabarLogFTP(LOG_ERROR,'No pudo crearse carpeta remota: ' & R# & ' - Error: ' & GetLastError(),'',QFTPPAT:Path)
			CantidadErrores    += 1
			CantidadErroresFTP += 1
			BREAK
		END
	END

	EXIT
ConectarseFTP        ROUTINE
  DATA
ModoFTP             BYTE
  CODE
	
	?String1{PROP:Text} = 'Conectando al servidor FTP ... Espere por favor ...'
	DISPLAY

	CantidadErroresFTP = 0
	A# = InternetAttemptConnect(0)
!	IF ~A#
!	   hwHandler = Window{PROP:HANDLE}
!	   A# = InternetAutoDial(INTERNET_AUTODIAL_FORCE_ONLINE,hwHandler)
!	END

	IF NOT InternetGetConnectedState(dwConnectionTypes,0)
		CantidadErrores    += 1
		CantidadErroresFTP += 1
		GrabarLog(0,'Error de Conexión a Internet','No pudo conectarse a Internet')
		EXIT
	ELSE
		!PermitirConnectionTypesCero = CHOOSE(GETINI('Configuracion','Permitir Tipo Conexion Cero','SI','.\Transfer.ini')='SI',True,False)
		PermitirConnectionTypesCero = True
		IF PermitirConnectionTypesCero AND dwConnectionTypes = 0
			! No controlar tipo de conexión
		ELSE
			IF NOT BAND(INTERNET_CONNECTION_MODEM+INTERNET_CONNECTION_LAN+INTERNET_CONNECTION_PROXY,dwConnectionTypes)
				CantidadErrores    += 1
				CantidadErroresFTP += 1
				GrabarLog(0,'Error de Conexión a Internet','No es un tipo válido de conexión a Internet: ' & dwConnectionTypes)
				EXIT
			END
		END
	END
	
	InternetSession = InternetOpen('SAOL',INTERNET_OPEN_TYPE_DIRECT,,,0)
   IF InternetSession
      !GrabarLogFTP(LOG_INFO,'Se conectó a Internet.','Sesión N° ' & InternetSession,'')
   ELSE
		CantidadErrores    += 1
		CantidadErroresFTP += 1
      GrabarLog(0,'No se pudo conectar a Internet.','Error: ' & GetLastError())
      EXIT
	END
	! Leer configuración de Servidor FTP
	OPEN(FTP_RemoteSite,42H)
	SET(FTP_RemoteSite)
	NEXT(FTP_RemoteSite)
	CLEAR(FTPHandle)
   LOOP ModoFTP = 1 TO 2
      CASE ModoFTP
         OF 1 ! Probar Modo Pasivo
         	FTPHandle = InternetConnect(InternetSession,FTPRS:Host,CHOOSE(FTPRS:Port=0,INTERNET_DEFAULT_FTP_PORT,FTPRS:Port),FTPRS:Usuario,FTPRS:Clave,INTERNET_SERVICE_FTP,INTERNET_FLAG_PASSIVE,0)
         OF 2 ! Probar Modo Activo
         	FTPHandle = InternetConnect(InternetSession,FTPRS:Host,CHOOSE(FTPRS:Port=0,INTERNET_DEFAULT_FTP_PORT,FTPRS:Port),FTPRS:Usuario,FTPRS:Clave,INTERNET_SERVICE_FTP,0,0)
      END
      IF FTPHandle
         BREAK
      END
   END
	IF FTPHandle
		!GrabarLogFTP(LOG_INFO,'Se conectó al servidor FTP.',FTPRS:Host,'')
	ELSE
		CantidadErrores    += 1
		CantidadErroresFTP += 1
		GrabarLogFTP(LOG_ERROR,'No se pudo abrir la conexión FTP. Error:' & GetLastError(),'','')
	END
	CLOSE(FTP_RemoteSite)

	EXIT
DesconectarseFTP ROUTINE
   A# = InternetAutoDialHangup(0)
TransferirFTP        ROUTINE
	
	DATA
I     LONG
	CODE
	TotalBytesWritten = 0
	FREE(QDirectory)
   DIRECTORY(QDirectory,LocalFilename,ff_:NORMAL+ff_:READONLY+ff_:HIDDEN+ff_:SYSTEM)
	GET(QDirectory,1)
	FileSize = QDirectory.size
	FREE(QDirectory)
	!message('Transferir ' & LocalFilename & ' al ftp ' & RemoteFilename & '|Tamaño: ' & FileSize)
	?StringProgresoParcial{PROP:Text} = 'Transfiriendo ' & Filename & ' ...'
	DISPLAY()
	RemoteFileHandle = FTPOpenFile(FTPHandle,RemoteFilename,GENERIC_WRITE,FTPTransferType,0)
	IF RemoteFileHandle
		LocalFileHandle = CreateFile(LocalFilename,GENERIC_READ,0,0,OPEN_EXISTING,0,0)
		IF LocalFileHandle
			?ProgresoParcial{PROP:RangeHigh} = FileSize
			ProgresoParcial                  = 0
			Comienzo = CLOCK()
			I = 0
			DISPLAY()
			LOOP
				IF KEYBOARD()
					ASK()
					IF KEYCODE() = EscKey
						IF MESSAGE('Desea detener la transmisión ?','Atención !',ICON:Question,|
									  BUTTON:YES+BUTTON:NO,BUTTON:NO) = BUTTON:YES
							DO Salir
							GrabarLogFTP(LOG_ERROR,'Cancelado por el operador',Filename,RemoteFilename)
							CantidadErrores    += 1
							CantidadErroresFTP += 1
							BREAK
						END
					END
				END
				IF ReadFile(LocalFileHandle,DataBuffer,LocalBytesToRead,LocalBytesRead,0)
					IF LocalBytesRead = 0
						DO Salir
						DO ProcedureReturn
						BREAK
					ELSE
						InternetWriteFile(RemoteFileHandle,DataBuffer,LocalBytesRead,RemoteBytesWritten)
						TotalBytesWritten += RemoteBytesWritten
						ProgresoParcial = TotalBytesWritten
						K = (TotalBytesWritten / 1024) / ((CLOCK() - Comienzo) / 100)
						?StringProgresoParcial{PROP:Text} = 'Transfiriendo ' & Filename & ' ... ' & CLIP(LEFT(FORMAT(K,@N_10.1))) & ' kb/s'
						DISPLAY()
						YIELD()
						I += 1
						IF I > 99
							I = 0
						END
					END
				ELSE
					DO Salir
					DO ProcedureReturn
					BREAK
				END
			END
		ELSE
			DO ProcedureReturn
		END
	ELSE
		GrabarLogFTP(LOG_ERROR,'No pudo abrirse archivo remoto: ' & GetLastError(),Filename,RemoteFilename)
		CantidadErrores    += 1
		CantidadErroresFTP += 1
	END
	EXIT
		
ProcedureReturn ROUTINE
	InternetCloseHandle(RemoteFileHandle)
	IF TotalBytesWritten <> FileSize
		GrabarLogFTP(LOG_ERROR,'Error de tamaño: ' & FileSize & ' => ' & TotalBytesWritten,|
						 Filename,RemoteFilename)
		CantidadErrores    += 1
		CantidadErroresFTP += 1
	ELSE
!		GrabarLogFTP(LOG_INFO,'Se envió archivo correctamente. (' & |
!					 	CLIP(LEFT(FORMAT(T,@N_10.1))) & ' seg. - ' & CLIP(LEFT(FORMAT(K,@N_10.1))) & ' kb/s)',|
!					 	Filename,RemoteFilename)
	END
	EXIT
	
Salir ROUTINE

	T = (CLOCK() - Comienzo) / 100
	K = (TotalBytesWritten / 1024) / T
	CloseHandle(LocalFileHandle)
	EXIT
		
BorrarCuitFTP        ROUTINE

	?String1{PROP:Text} = 'Borrando archivos TPS (SAOL_CUIT) del FTP ... Espere por favor ...'
	?Progreso{PROP:RangeHigh} = RECORDS(QCuit)
	Progreso = 0

	LOOP I# = 1 TO RECORDS(QCuit)
		GET(QCuit,I#)
		ASSERT(~ERRORCODE())
		
		SAOL_INS:Descripcion = 'C.U.I.T.: ' & FORMAT(QCUIT:CUIT,@P##-########-#P) & |
									  CHOOSE(QCUIT:CentroEmision=0,'',' - C.E.: ' & FORMAT(QCUIT:CentroEmision,@N04))
		DO MostrarProgreso
		RemoteFilename = '/saol/' & CLIP(QCUIT:CUIT) & |
			              CHOOSE(QCUIT:CentroEmision=0,'','_' & FORMAT(QCUIT:CentroEmision,@N04)) & '.zip'
		R# = FtpDeleteFile(FTPHandle,RemoteFilename)
		IF R# <> 1 AND R# <> 0
			GrabarLogFTP(LOG_ERROR,'Error al borrar archivo (SAOL_CUIT) del FTP: ' & R# & ' - Error: ' & GetLastError(),'',RemoteFilename)
			CantidadErrores    += 1
			CantidadErroresFTP += 1
			BREAK
		END
	END

	EXIT
	
VerificarExistenciaPaths   ROUTINE
	DATA
L:Inicio    LONG
L:Posicion  LONG
Directorio  CSTRING(FILE:MaxFilePath)
PathIntermedio  CSTRING(FILE:MaxFilePath)
	CODE
		
	Directorio = QPAT:Path
	L:Inicio = 1
	IF Directorio[LEN(Directorio)] <> '\'
		Directorio = Directorio & '\'
	END
	LOOP
		L:Posicion = INSTRING('\',Directorio,1,L:Inicio)
		IF L:Posicion = 0
			BREAK
		ELSE		
			PathIntermedio = SUB(Directorio,1,L:Posicion)
			L:Inicio = L:Posicion + 1
			QPAT:Path = PathIntermedio
			GET(QPaths,+QPAT:Path)
			IF ERRORCODE()
				QPAT:Path = PathIntermedio
				ADD(QPaths,+QPAT:Path)
				ASSERT(~ERRORCODE())
			END
		END
	END
	EXIT


VerificarExistenciaPathsFtp   ROUTINE
	DATA
L:Inicio    LONG
L:Posicion  LONG
Directorio  CSTRING(FILE:MaxFilePath)
PathIntermedio  CSTRING(FILE:MaxFilePath)
	CODE
		
	Directorio = QFTPPAT:Path
	L:Inicio = 1
	IF Directorio[LEN(Directorio)] <> '/'
		Directorio = Directorio & '/'
	END
	LOOP
		L:Posicion = INSTRING('/',Directorio,1,L:Inicio)
		IF L:Posicion = 0
			BREAK
		ELSE		
			PathIntermedio = SUB(Directorio,1,L:Posicion)
			L:Inicio = L:Posicion + 1
			QFTPPAT:Path = PathIntermedio
			GET(QFtpPaths,+QFTPPAT:Path)
			IF ERRORCODE()
				QFTPPAT:Path = PathIntermedio
				ADD(QFtpPaths,+QFTPPAT:Path)
				ASSERT(~ERRORCODE())
			END
		END
	END
	EXIT


Esperar ROUTINE
	DATA
EspereWindow WINDOW,AT(,,1,1),CENTER,TIMER(50)
     END
	CODE
	OPEN(EspereWindow)
	EspereWindow{PROP:Hide} = True
	ACCEPT
	   CASE EVENT()
	      OF EVENT:Timer
	         BREAK
	   END
	END
	CLOSE(EspereWindow)
	EXIT
