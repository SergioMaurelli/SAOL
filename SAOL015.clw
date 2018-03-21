

   MEMBER('SAOL.clw')                                      ! This is a MEMBER module


   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABUTIL.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('SAOL015.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('SAOL014.INC'),ONCE        !Req'd for module callout resolution
                     END


!!! <summary>
!!! Generated from procedure template - Window
!!! Instaladores
!!! </summary>
SAOL_Instaladores:Ficha PROCEDURE 

CurrentTab           STRING(80)                            !
ActionMessage        CSTRING(40)                           !
LOC:VERSION          STRING(20)                            !
LOC:CLIENTE          STRING(100)                           !
LOC:SOFTWARE         STRING(100)                           !
EnhancedFocusManager EnhancedFocusClassType
History::SAOL_INS:Record LIKE(SAOL_INS:RECORD),THREAD
QuickWindow          WINDOW('Actualizar Instaladores'),AT(,,358,213),FONT('Arial',9,,FONT:bold,CHARSET:ANSI),DOUBLE, |
  CENTER,GRAY,IMM,MDI,HLP('ActualizarSAOL_INSTALADORES'),SYSTEM
                       SHEET,AT(6,4,350,190),USE(?CurrentTab:3)
                         TAB('&Instalador'),USE(?Tab:5)
                           PROMPT('Software:'),AT(22,22),USE(?SAOL_SOF:Nombre:Prompt),TRN
                           ENTRY(@s100),AT(59,22,258,10),USE(SAOL_SOF:Nombre),READONLY,SKIP
                           PROMPT('Cliente:'),AT(29,36),USE(?SAOL_CLI:Nombre:Prompt),TRN
                           ENTRY(@s100),AT(59,36,258,10),USE(SAOL_CLI:Nombre),READONLY,SKIP
                           BUTTON('...'),AT(322,21,25,26),USE(?BuscarSoftware)
                           PROMPT('Descripción:'),AT(13,51),USE(?SAOL_INS:Descripcion:Prompt:3),TRN
                           ENTRY(@s255),AT(59,51,287,10),USE(SAOL_INS:Descripcion,,?SAOL_INS:Descripcion:3),MSG('Descripcio' & |
  'n del Instalador'),REQ,TIP('Descripcion del Instalador')
                           PROMPT('Centro de Emisión habilitado para instalar:'),AT(58,64),USE(?SAOL_INS:CentroEmision:Prompt), |
  RIGHT,TRN
                           ENTRY(@n04b),AT(202,64,,10),USE(SAOL_INS:CentroEmision),RIGHT(2),TIP('Centro de Emisión' & |
  ' de Instalación'),MSG('Centro de Emisión de Instalación')
                           PROMPT('Referencia:'),AT(17,78),USE(?SAOL_INS:Referencia:Prompt),TRN
                           ENTRY(@s100),AT(59,78,287,10),USE(SAOL_INS:Referencia),REQ,TIP('Referencia'),MSG('Referencia')
                           PROMPT('Path ISS:'),AT(25,93),USE(?SAOL_INS:PathISS:Prompt:3),TRN
                           ENTRY(@s255),AT(59,93,273,10),USE(SAOL_INS:PathISS,,?SAOL_INS:PathISS:3),MSG('Path del A' & |
  'rchivo de Inno setup'),READONLY,REQ,SKIP,TIP('Path del Archivo de Inno setup')
                           BUTTON('...'),AT(337,92,12,12),USE(?LookupFile)
                           PROMPT('Contacto:'),AT(23,107),USE(?SAOL_INS:Contacto:Prompt),LEFT,TRN
                           ENTRY(@s60),AT(59,107,273,10),USE(SAOL_INS:Contacto),LEFT,TIP('Contacto'),MSG('Contacto')
                           PROMPT('Email:'),AT(34,122),USE(?SAOL_INS:Email:Prompt),LEFT,TRN
                           ENTRY(@s255),AT(59,122,273,10),USE(SAOL_INS:Email),LEFT,TIP('Correo Electrónico a donde' & |
  ' avisar de una nueva versión'),MSG('Correo Electrónico a donde avisar de una nueva versión')
                           PROMPT('INI Versión:'),AT(17,135),USE(?SAOL_INS:ReleaseIni:Prompt),LEFT,TRN
                           ENTRY(@s255),AT(59,135,273,10),USE(SAOL_INS:ReleaseIni),LEFT,TIP('Archivo INI donde se ' & |
  'encuentra la info de versión (para avanzar BUILD)'),MSG('Archivo INI donde se encuentra la info de versión (para avanzar BUILD)')
                           BUTTON('...'),AT(337,135,12,12),USE(?LookupFile:2)
                           OPTION('Estado:'),AT(278,149,,40),USE(SAOL_INS:Estado),BOXED,TIP('Estado'),TRN,MSG('Estado')
                             RADIO('Activo'),AT(284,155),USE(?SAOL_INS:Estado:Radio0),VALUE('1'),TRN
                             RADIO('Inactivo'),AT(284,165),USE(?SAOL_INS:Estado:Radio1),VALUE('0'),TRN
                             RADIO('De baja'),AT(284,175),USE(?SAOL_INS:Estado:Radio2),VALUE('9'),TRN
                           END
                         END
                         TAB('Ultima Generación'),USE(?TAB1),HIDE
                           PROMPT('Generado Fecha:'),AT(11,29),USE(?SAOL_INS:GeneradoFecha:Prompt),TRN
                           ENTRY(@d6b),AT(70,29,42,10),USE(SAOL_INS:GeneradoFecha),RIGHT(1),MSG('Fecha de la últim' & |
  'a generación'),READONLY,TIP('Fecha de la última generación')
                           PROMPT('Generado Hora:'),AT(15,44),USE(?SAOL_INS:GeneradoHora:Prompt),TRN
                           ENTRY(@t4b),AT(70,44,34,10),USE(SAOL_INS:GeneradoHora),RIGHT(1),MSG('Hora de la última ' & |
  'generación'),READONLY,TIP('Hora de la última generación')
                           PROMPT('Versión:'),AT(39,58),USE(?LOC:VERSION:Prompt),TRN
                           ENTRY(@s20),AT(70,58,87,10),USE(LOC:VERSION),LEFT(2),READONLY
                           PROMPT('Major:'),AT(45,77),USE(?SAOL_INS:Major:Prompt),TRN
                           ENTRY(@n_4),AT(70,77,24,10),USE(SAOL_INS:Major),RIGHT(1),MSG('Major de la Versión'),TIP('Major de la Versión')
                           PROMPT('Minor:'),AT(45,90),USE(?SAOL_INS:Minor:Prompt),TRN
                           ENTRY(@n_4),AT(70,90,24,10),USE(SAOL_INS:Minor),RIGHT(1),MSG('Minor de la Versión'),TIP('Minor de la Versión')
                           PROMPT('Release:'),AT(37,102),USE(?SAOL_INS:Release:Prompt),TRN
                           ENTRY(@n_4),AT(70,102,24,10),USE(SAOL_INS:Release),RIGHT(1),MSG('Release de la Versión'),TIP('Release de' & |
  ' la Versión')
                           PROMPT('Build:'),AT(47,115),USE(?SAOL_INS:Build:Prompt),TRN
                           ENTRY(@n_4),AT(70,115,24,10),USE(SAOL_INS:Build),RIGHT(1),MSG('Build de la Versión'),TIP('Build de la Versión')
                         END
                       END
                       BUTTON('&OK'),AT(167,196,60,14),USE(?OK),DEFAULT,MSG('Aceptar los cambios y cerrar la ventana'), |
  TIP('Aceptar los cambios y cerrar la ventana')
                       BUTTON('Can&celar'),AT(231,196,60,14),USE(?Cancel),MSG('Anular los cambios'),TIP('Anular los cambios')
                       BUTTON('Ay&uda'),AT(295,196,60,14),USE(?Help),MSG('Ayuda'),STD(STD:Help),TIP('Ayuda')
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Reset                  PROCEDURE(BYTE Force=0),DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
ToolbarForm          ToolbarUpdateClass                    ! Form Toolbar Manager
FileLookup7          SelectFileClass
FileLookup8          SelectFileClass
CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
                    END

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Ask PROCEDURE

  CODE
  CASE SELF.Request                                        ! Configure the action message text
  OF ViewRecord
    ActionMessage = 'Ver Instalador'
  OF InsertRecord
    ActionMessage = 'Agregar un Instalador'
  OF ChangeRecord
    ActionMessage = 'Cambiar un Instalador'
  END
  QuickWindow{PROP:Text} = ActionMessage                   ! Display status message in title bar
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('SAOL_Instaladores:Ficha')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?SAOL_SOF:Nombre:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(SAOL_INS:Record,History::SAOL_INS:Record)
  SELF.AddHistoryField(?SAOL_INS:Descripcion:3,3)
  SELF.AddHistoryField(?SAOL_INS:CentroEmision,20)
  SELF.AddHistoryField(?SAOL_INS:Referencia,4)
  SELF.AddHistoryField(?SAOL_INS:PathISS:3,5)
  SELF.AddHistoryField(?SAOL_INS:Contacto,19)
  SELF.AddHistoryField(?SAOL_INS:Email,17)
  SELF.AddHistoryField(?SAOL_INS:ReleaseIni,18)
  SELF.AddHistoryField(?SAOL_INS:Estado,16)
  SELF.AddHistoryField(?SAOL_INS:GeneradoFecha,6)
  SELF.AddHistoryField(?SAOL_INS:GeneradoHora,7)
  SELF.AddHistoryField(?SAOL_INS:Major,8)
  SELF.AddHistoryField(?SAOL_INS:Minor,9)
  SELF.AddHistoryField(?SAOL_INS:Release,10)
  SELF.AddHistoryField(?SAOL_INS:Build,11)
  SELF.AddUpdateFile(Access:SAOL_Instaladores)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:SAOL_Instaladores.SetOpenRelated()
  Relate:SAOL_Instaladores.Open                            ! File SAOL_Instaladores used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:SAOL_Instaladores
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.CancelAction = Cancel:Cancel+Cancel:Query         ! Confirm cancel
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  SELF.Open(QuickWindow)                                   ! Open window
  IF SELF.Request = ChangeRecord
  	SAOL_CLI:id = SAOL_SXC:idCliente
  	GET(SAOL_Clientes,SAOL_CLI:PorID)
  	LOC:CLIENTE = SAOL_CLI:Nombre
  	SAOL_SOF:id = SAOL_SXC:idSoftware
  	GET(SAOL_Software,SAOL_SOF:PorID)
  	LOC:SOFTWARE = SAOL_SOF:Nombre
  END
  LOC:VERSION = SAOL_INS:Major & '.' & SAOL_INS:Minor & '.' & SAOL_INS:Release & '.' & SAOL_INS:Build
  Do DefineListboxStyle
  IF SELF.Request = ViewRecord                             ! Configure controls for View Only mode
    ?SAOL_SOF:Nombre{PROP:ReadOnly} = True
    ?SAOL_CLI:Nombre{PROP:ReadOnly} = True
    DISABLE(?BuscarSoftware)
    ?SAOL_INS:Descripcion:3{PROP:ReadOnly} = True
    ?SAOL_INS:CentroEmision{PROP:ReadOnly} = True
    ?SAOL_INS:Referencia{PROP:ReadOnly} = True
    ?SAOL_INS:PathISS:3{PROP:ReadOnly} = True
    DISABLE(?LookupFile)
    ?SAOL_INS:Contacto{PROP:ReadOnly} = True
    ?SAOL_INS:Email{PROP:ReadOnly} = True
    ?SAOL_INS:ReleaseIni{PROP:ReadOnly} = True
    DISABLE(?LookupFile:2)
    ?SAOL_INS:GeneradoFecha{PROP:ReadOnly} = True
    ?SAOL_INS:GeneradoHora{PROP:ReadOnly} = True
    ?LOC:VERSION{PROP:ReadOnly} = True
    ?SAOL_INS:Major{PROP:ReadOnly} = True
    ?SAOL_INS:Minor{PROP:ReadOnly} = True
    ?SAOL_INS:Release{PROP:ReadOnly} = True
    ?SAOL_INS:Build{PROP:ReadOnly} = True
  END
  INIMgr.Fetch('SAOL_Instaladores:Ficha',QuickWindow)      ! Restore window settings from non-volatile store
  ToolBarForm.HelpButton=?Help
  SELF.AddItem(ToolbarForm)
  FileLookup7.Init
  FileLookup7.ClearOnCancel = True
  FileLookup7.Flags=BOR(FileLookup7.Flags,FILE:LongName)   ! Allow long filenames
  FileLookup7.SetMask('InnoSetup Scripts','*.iss')         ! Set the file mask
  FileLookup7.DefaultDirectory='S:\Instaladores\Scripts'
  FileLookup7.WindowTitle='Seleccionar Script InnoSetup'
  FileLookup8.Init
  FileLookup8.ClearOnCancel = True
  FileLookup8.Flags=BOR(FileLookup8.Flags,FILE:LongName)   ! Allow long filenames
  FileLookup8.SetMask('Ini','*.ini')                       ! Set the file mask
  FileLookup8.DefaultDirectory='S:\AppC8'
  FileLookup8.WindowTitle='Seleccionar Archivo Ini con Información de Versión'
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
    Relate:SAOL_Instaladores.Close
  END
  IF SELF.Opened
    INIMgr.Update('SAOL_Instaladores:Ficha',QuickWindow)   ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF QuickWindow{Prop:AcceptAll} THEN RETURN.
  SAOL_SXC:id = SAOL_INS:idSoftwarexCliente                ! Assign linking field value
  Access:SAOL_SoftwarexCliente.Fetch(SAOL_SXC:PorID)
  SAOL_CLI:id = SAOL_SXC:idCliente                         ! Assign linking field value
  Access:SAOL_Clientes.Fetch(SAOL_CLI:PorID)
  SAOL_SOF:id = SAOL_SXC:idSoftware                        ! Assign linking field value
  Access:SAOL_Software.Fetch(SAOL_SOF:PorID)
  PARENT.Reset(Force)


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord                             ! In View Only mode always signal RequestCancelled
    ReturnValue = RequestCancelled
  END
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
    OF ?BuscarSoftware
      	GlobalRequest = SelectRecord
      	AsignarProductosACliente:Browse()
      	IF GlobalResponse = RequestCompleted
      		SAOL_INS:idSoftwarexCliente = SAOL_SXC:id
      		SAOL_CLI:id = SAOL_SXC:idCliente
      		GET(SAOL_Clientes,SAOL_CLI:PorID)
      		IF ~CLIP(SAOL_INS:Email)
      			SAOL_INS:Email = SAOL_CLI:Email
      		END
      		IF ~CLIP(SAOL_INS:Contacto)
      			SAOL_INS:Contacto = SAOL_CLI:Contacto
      		END
      		ThisWindow.Reset(1)
      	END
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?LookupFile
      ThisWindow.Update
      SAOL_INS:PathISS = FileLookup7.Ask(1)
      DISPLAY
    OF ?LookupFile:2
      ThisWindow.Update
      SAOL_INS:ReleaseIni = FileLookup8.Ask(1)
      DISPLAY
    OF ?OK
      ThisWindow.Update
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
         POST(EVENT:CloseWindow)
      END
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

