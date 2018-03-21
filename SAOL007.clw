

   MEMBER('SAOL.clw')                                      ! This is a MEMBER module


   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('SAOL007.INC'),ONCE        !Local module procedure declarations
                     END


!!! <summary>
!!! Generated from procedure template - Window
!!! Window
!!! </summary>
OpcionesGeneracion PROCEDURE (Compilar,Comprimir,CrearTPS,SubirFTP,SubirCompulsivamente,ActualizarInfoDB,AvanzarBuild,EnviarMail,Compulsiva,CompulsivaInstalador,CompulsivaComponentes,CompulsivaModificados,IncluirComentados)

Loc:Compilar         BYTE                                  !Compilar
Loc:SubirCompulsivamente BYTE(0)                           !Subir compulsivamente los componentes aunque no hayan cambiado las versiones
Loc:Comprimir        STRING(20)                            !Comprimir Archivos
Loc:CrearTPS         BYTE                                  !Crear TPS con información de versiones para subir al FTP
Loc:SubirFTP         BYTE                                  !Subir archivos comprimidos al FTP
Loc:ActualizarInfo   BYTE                                  !Actualizar información de versiones en la BD
Loc:AvanzarBuild     BYTE                                  !Avanzar Build
Loc:EnviarMail       BYTE                                  !Enviar email al cliente
Loc:TipoActualizacion BYTE                                 !Tipo de Actualización
Loc:IncluirComentados BYTE                                 !Incluir Sentencias SOURCE Comentadas
Loc:Retorno          BYTE                                  !
EnhancedFocusManager EnhancedFocusClassType
QuickWindow          WINDOW('Opciones de Generación'),AT(,,258,203),FONT('Arial',9,,FONT:bold,CHARSET:ANSI),DOUBLE, |
  CENTER,GRAY,IMM,HLP('OpcionesGeneracion'),SYSTEM
                       BUTTON('&OK'),AT(98,186,49,14),USE(?Ok)
                       BUTTON('&Cancelar'),AT(152,186,49,14),USE(?Cancel)
                       BUTTON('&Ayuda'),AT(204,186,49,14),USE(?Help),STD(STD:Help)
                       CHECK('Compilar Instaladores'),AT(7,7),USE(Loc:Compilar),RIGHT,TIP('Compilar Instaladores'), |
  VALUE('1','0')
                       CHECK('Comprimir Archivos'),AT(7,20),USE(Loc:Comprimir),RIGHT,TIP('Comprimir Archivos'),VALUE('1', |
  '0')
                       CHECK('Crear TPS con información de versiones para subir al FTP'),AT(15,34,202),USE(Loc:CrearTPS), |
  RIGHT,TIP('Crear TPS'),VALUE('1','0')
                       CHECK('Subir Compulsivamente'),AT(162,47,91),USE(Loc:SubirCompulsivamente),RIGHT,TIP('Subir comp' & |
  'ulsivamente los componentes aunque no hayan cambiado las versiones'),VALUE('1','0')
                       CHECK('Subir archivos comprimidos al FTP'),AT(24,47),USE(Loc:SubirFTP),RIGHT,TIP('Subir arch' & |
  'ivos comprimidos al FTP'),VALUE('1','0')
                       CHECK('Actualizar información de versiones en la BD'),AT(32,60,160),USE(Loc:ActualizarInfo), |
  RIGHT,TIP('Actualizar información de versiones en la BD'),VALUE('1','0')
                       CHECK('Avanzar Build'),AT(42,73,58),USE(Loc:AvanzarBuild),RIGHT,TIP('Avanzar Build'),VALUE('1', |
  '0')
                       CHECK('Enviar email al cliente'),AT(54,86),USE(Loc:EnviarMail),RIGHT,TIP('Enviar email ' & |
  'al cliente'),VALUE('1','0')
                       OPTION('Tipo de Actualización'),AT(7,99,246,58),USE(Loc:TipoActualizacion),BOXED,TIP('Tipo de Ac' & |
  'tualización')
                         RADIO('Normal'),AT(13,108),USE(?Loc:TipoActualizacion:Radio0)
                         RADIO('Compulsiva con Instalador'),AT(13,118),USE(?Loc:TipoActualizacion:Radio1)
                         RADIO('Compulsiva con Componentes'),AT(13,129),USE(?Loc:TipoActualizacion:Radio2)
                         RADIO('Compulsiva con Componentes Modificados'),AT(13,140),USE(?Loc:TipoActualizacion:Radio3)
                       END
                       CHECK('Incluir Componentes Comentados'),AT(123,108,124),USE(Loc:IncluirComentados),MSG('Incluir Se' & |
  'ntencias SOURCE Comentadas'),TIP('Incluir Sentencias SOURCE Comentadas'),VALUE('1','0')
                       PROMPT('Host:'),AT(10,166),USE(?FTPRS:Host:Prompt)
                       ENTRY(@s255),AT(31,166,219,10),USE(FTPRS:Host),LEFT(2),MSG('HOST Servidor FTP'),REQ,TIP('HOST Servidor FTP')
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
                     END


  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop
  RETURN(Loc:Retorno)

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('OpcionesGeneracion')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Ok
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Ok,RequestCancelled)                    ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Ok,RequestCompleted)                    ! Add the close control to the window manger
  END
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:FTP_RemoteSite.Open                               ! File FTP_RemoteSite used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Open(QuickWindow)                                   ! Open window
  Loc:Compilar             = Compilar
  Loc:Comprimir            = Comprimir
  Loc:CrearTPS             = CrearTPS
  Loc:SubirFTP             = SubirFTP
  Loc:SubirCompulsivamente = SubirCompulsivamente
  Loc:ActualizarInfo       = ActualizarInfoDB
  Loc:AvanzarBuild         = AvanzarBuild
  Loc:EnviarMail           = EnviarMail
  Loc:IncluirComentados    = IncluirComentados
  Loc:TipoActualizacion = 1
  IF CompulsivaModificados
     Loc:TipoActualizacion = 4
  ELSE
     IF CompulsivaComponentes
        Loc:TipoActualizacion = 3
     ELSE
        IF CompulsivaInstalador
           Loc:TipoActualizacion = 2
        END
     END
  END
  FTPRS:id = 1
  GET(FTP_RemoteSite,FTPRS:PorId)
  			
  Do DefineListboxStyle
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('OpcionesGeneracion',QuickWindow)           ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  IF ?Loc:Comprimir{Prop:Checked}
    ENABLE(?Loc:CrearTPS)
  END
  IF NOT ?Loc:Comprimir{PROP:Checked}
    DISABLE(?Loc:CrearTPS)
    DISABLE(?Loc:SubirFTP)
    DISABLE(?Loc:ActualizarInfo)
    DISABLE(?Loc:AvanzarBuild)
    DISABLE(?Loc:EnviarMail)
  END
  IF ?Loc:CrearTPS{Prop:Checked}
    ENABLE(?Loc:SubirFTP)
  END
  IF NOT ?Loc:CrearTPS{PROP:Checked}
    DISABLE(?Loc:SubirFTP)
    DISABLE(?Loc:SubirCompulsivamente)
    DISABLE(?Loc:ActualizarInfo)
    DISABLE(?Loc:AvanzarBuild)
    DISABLE(?Loc:EnviarMail)
  END
  IF ?Loc:SubirFTP{Prop:Checked}
    ENABLE(?Loc:ActualizarInfo)
    ENABLE(?Loc:SubirCompulsivamente)
  END
  IF NOT ?Loc:SubirFTP{PROP:Checked}
    DISABLE(?Loc:ActualizarInfo)
    DISABLE(?Loc:AvanzarBuild)
    DISABLE(?Loc:EnviarMail)
    DISABLE(?Loc:SubirCompulsivamente)
  END
  IF ?Loc:ActualizarInfo{Prop:Checked}
    ENABLE(?Loc:AvanzarBuild)
  END
  IF NOT ?Loc:ActualizarInfo{PROP:Checked}
    DISABLE(?Loc:AvanzarBuild)
    DISABLE(?Loc:EnviarMail)
  END
  IF ?Loc:AvanzarBuild{Prop:Checked}
    ENABLE(?Loc:EnviarMail)
  END
  IF NOT ?Loc:AvanzarBuild{PROP:Checked}
    DISABLE(?Loc:EnviarMail)
  END
  SELF.SetAlerts()
    SYSTEM{PROP:Icon} = '~saol.ico'
    IF CLIP(0{PROP:Icon}) = ''
        0{PROP:Icon} = '~saol.ico'
    END
  EnhancedFocusManager.Init(1,8454143,1,0,8454143,1,8454143,8421504,2,8454143,8421504,0,8421504,'»',8)
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:FTP_RemoteSite.Close
  END
  IF SELF.Opened
    INIMgr.Update('OpcionesGeneracion',QuickWindow)        ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
    CASE ACCEPTED()
    OF ?Ok
      	Compilar         = Loc:Compilar
      	Comprimir        = Loc:Comprimir
      	IF Comprimir
      		CrearTPS      = Loc:CrearTPS
      		IF CrearTPS
      			SubirFTP   = Loc:SubirFTP
      			IF SubirFTP
      				SubirCompulsivamente = Loc:SubirCompulsivamente
      				ActualizarInfoDB = Loc:ActualizarInfo
      				IF ActualizarInfoDB
      					AvanzarBuild = Loc:AvanzarBuild
      					IF AvanzarBuild
      						EnviarMail = Loc:EnviarMail
      					ELSE
      						EnviarMail = False
      					END
      				ELSE
      					AvanzarBuild = False
      					EnviarMail   = False
      				END
      			ELSE
      				SubirCompulsivamente = False
      				ActualizarInfoDB     = False
      				AvanzarBuild         = False
      				EnviarMail   	      = False
      			END
      		ELSE
      			SubirFTP             = False
      			SubirCompulsivamente = False
      			ActualizarInfoDB     = False
      			AvanzarBuild         = False
      			EnviarMail           = False
      		END	
      	ELSE
      		CrearTPS             = False
      		SubirFTP             = False
      		SubirCompulsivamente = False
      		ActualizarInfoDB     = False
      		AvanzarBuild         = False
      		EnviarMail   	      = False
      	END
      	CASE Loc:TipoActualizacion
      	OF 1
      		Compulsiva            = False
      		CompulsivaInstalador  = False
      		CompulsivaComponentes = False
      	   CompulsivaModificados = False
      	OF 2
      		Compulsiva            = True
      		CompulsivaInstalador  = True
      		CompulsivaComponentes = False
      	   CompulsivaModificados = False
      	OF 1
      		Compulsiva            = True
      		CompulsivaInstalador  = False
      		CompulsivaComponentes = True
      	   CompulsivaModificados = False
      	OF 1
      		Compulsiva            = True
      		CompulsivaInstalador  = False
      		CompulsivaComponentes = False
      		CompulsivaModificados = True
      	END
      	IncluirComentados = Loc:IncluirComentados
      	PUT(FTP_RemoteSite)
      	Loc:Retorno = True
      	POST(EVENT:CloseWindow)
      
      
    OF ?Cancel
      	Loc:Retorno = False
      	POST(EVENT:CloseWindow)
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?Loc:Comprimir
      IF ?Loc:Comprimir{PROP:Checked}
        ENABLE(?Loc:CrearTPS)
      END
      IF NOT ?Loc:Comprimir{PROP:Checked}
        DISABLE(?Loc:CrearTPS)
        DISABLE(?Loc:SubirFTP)
        DISABLE(?Loc:ActualizarInfo)
        DISABLE(?Loc:AvanzarBuild)
        DISABLE(?Loc:EnviarMail)
      END
      ThisWindow.Reset
    OF ?Loc:CrearTPS
      IF ?Loc:CrearTPS{PROP:Checked}
        ENABLE(?Loc:SubirFTP)
      END
      IF NOT ?Loc:CrearTPS{PROP:Checked}
        DISABLE(?Loc:SubirFTP)
        DISABLE(?Loc:SubirCompulsivamente)
        DISABLE(?Loc:ActualizarInfo)
        DISABLE(?Loc:AvanzarBuild)
        DISABLE(?Loc:EnviarMail)
      END
      ThisWindow.Reset
    OF ?Loc:SubirFTP
      IF ?Loc:SubirFTP{PROP:Checked}
        ENABLE(?Loc:ActualizarInfo)
        ENABLE(?Loc:SubirCompulsivamente)
      END
      IF NOT ?Loc:SubirFTP{PROP:Checked}
        DISABLE(?Loc:ActualizarInfo)
        DISABLE(?Loc:AvanzarBuild)
        DISABLE(?Loc:EnviarMail)
        DISABLE(?Loc:SubirCompulsivamente)
      END
      ThisWindow.Reset
    OF ?Loc:ActualizarInfo
      IF ?Loc:ActualizarInfo{PROP:Checked}
        ENABLE(?Loc:AvanzarBuild)
      END
      IF NOT ?Loc:ActualizarInfo{PROP:Checked}
        DISABLE(?Loc:AvanzarBuild)
        DISABLE(?Loc:EnviarMail)
      END
      ThisWindow.Reset
    OF ?Loc:AvanzarBuild
      IF ?Loc:AvanzarBuild{PROP:Checked}
        ENABLE(?Loc:EnviarMail)
      END
      IF NOT ?Loc:AvanzarBuild{PROP:Checked}
        DISABLE(?Loc:EnviarMail)
      END
      ThisWindow.Reset
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  EnhancedFocusManager.TakeEvent()
  ReturnValue = PARENT.TakeEvent()
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

