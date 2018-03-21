

   MEMBER('SAOL.clw')                                      ! This is a MEMBER module


   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('SAOL005.INC'),ONCE        !Local module procedure declarations
                     END


!!! <summary>
!!! Generated from procedure template - Window
!!! Clientes
!!! </summary>
SAOL_Clientes:Ficha PROCEDURE 

CurrentTab           STRING(80)                            !
ActionMessage        CSTRING(40)                           !
EnhancedFocusManager EnhancedFocusClassType
History::SAOL_CLI:Record LIKE(SAOL_CLI:RECORD),THREAD
QuickWindow          WINDOW('Actualizar Cliente'),AT(,,358,146),FONT('Arial',9,,FONT:bold,CHARSET:ANSI),DOUBLE, |
  CENTER,GRAY,IMM,MDI,HLP('ActualizarSAOL_CLIENTES'),SYSTEM
                       SHEET,AT(4,4,350,123),USE(?CurrentTab)
                         TAB('General'),USE(?Tab:1)
                           PROMPT('Nombre:'),AT(12,21),USE(?SAOL_CLI:Nombre:Prompt),TRN
                           ENTRY(@s100),AT(45,21,303,10),USE(SAOL_CLI:Nombre),LEFT(2),REQ
                           PROMPT('Contacto:'),AT(9,36),USE(?SAOL_CLI:Contacto:Prompt),LEFT,TRN
                           ENTRY(@s60),AT(45,36,245,10),USE(SAOL_CLI:Contacto),LEFT,TIP('Contacto'),MSG('Contacto')
                           PROMPT('CUIT:'),AT(23,50),USE(?SAOL_CLI:CUIT:Prompt),TRN
                           ENTRY(@P##-########-#Pb),AT(45,50,57,10),USE(SAOL_CLI:CUIT),RIGHT(2),REQ
                           PROMPT('Email:'),AT(20,64),USE(?SAOL_CLI:Email:Prompt),LEFT,TRN
                           ENTRY(@s255),AT(45,65,303,10),USE(SAOL_CLI:Email),LEFT,TIP('Email'),MSG('Email')
                           OPTION('Estado:'),AT(287,79,62,42),USE(SAOL_CLI:Estado),BOXED,TIP('Estado'),TRN,MSG('Estado')
                             RADIO('Habilitado'),AT(290,88,50),USE(?SAOL_CLI:Estado:Radio0),VALUE('1'),TRN
                             RADIO('Inhabilitado'),AT(290,98,50),USE(?SAOL_CLI:Estado:Radio1),VALUE('0'),TRN
                             RADIO('De baja'),AT(290,108,50),USE(?SAOL_CLI:Estado:Radio2),VALUE('9'),TRN
                           END
                         END
                       END
                       BUTTON('&OK'),AT(166,131,60,14),USE(?OK),DEFAULT,MSG('Aceptar los cambios y cerrar la ventana'), |
  TIP('Aceptar los cambios y cerrar la ventana')
                       BUTTON('Can&celar'),AT(230,131,60,14),USE(?Cancel),MSG('Anular los cambios'),TIP('Anular los cambios')
                       BUTTON('Ay&uda'),AT(294,131,60,14),USE(?Help),MSG('Ayuda'),STD(STD:Help),TIP('Ayuda')
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
ToolbarForm          ToolbarUpdateClass                    ! Form Toolbar Manager
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
    ActionMessage = 'Ver registro de Cliente'
  OF InsertRecord
    ActionMessage = 'Agregar Cliente'
  OF ChangeRecord
    ActionMessage = 'Cambiar Cliente'
  END
  QuickWindow{PROP:Text} = ActionMessage                   ! Display status message in title bar
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('SAOL_Clientes:Ficha')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?SAOL_CLI:Nombre:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(SAOL_CLI:Record,History::SAOL_CLI:Record)
  SELF.AddHistoryField(?SAOL_CLI:Nombre,2)
  SELF.AddHistoryField(?SAOL_CLI:Contacto,5)
  SELF.AddHistoryField(?SAOL_CLI:CUIT,3)
  SELF.AddHistoryField(?SAOL_CLI:Email,4)
  SELF.AddHistoryField(?SAOL_CLI:Estado,6)
  SELF.AddUpdateFile(Access:SAOL_Clientes)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:SAOL_Clientes.Open                                ! File SAOL_Clientes used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:SAOL_Clientes
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
  Do DefineListboxStyle
  IF SELF.Request = ViewRecord                             ! Configure controls for View Only mode
    ?SAOL_CLI:Nombre{PROP:ReadOnly} = True
    ?SAOL_CLI:Contacto{PROP:ReadOnly} = True
    ?SAOL_CLI:CUIT{PROP:ReadOnly} = True
    ?SAOL_CLI:Email{PROP:ReadOnly} = True
  END
  INIMgr.Fetch('SAOL_Clientes:Ficha',QuickWindow)          ! Restore window settings from non-volatile store
  ToolBarForm.HelpButton=?Help
  SELF.AddItem(ToolbarForm)
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
    Relate:SAOL_Clientes.Close
  END
  IF SELF.Opened
    INIMgr.Update('SAOL_Clientes:Ficha',QuickWindow)       ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


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
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
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

