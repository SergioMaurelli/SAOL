

   MEMBER('SAOL.clw')                                      ! This is a MEMBER module


   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('SAOL001.INC'),ONCE        !Local module procedure declarations
                     END


!!! <summary>
!!! Generated from procedure template - Window
!!! Software
!!! </summary>
SAOL_Software:Ficha PROCEDURE 

CurrentTab           STRING(80)                            !
ActionMessage        CSTRING(40)                           !
EnhancedFocusManager EnhancedFocusClassType
History::SAOL_SOF:Record LIKE(SAOL_SOF:RECORD),THREAD
QuickWindow          WINDOW('Actualizar Software'),AT(,,358,56),FONT('Arial',9,,FONT:bold,CHARSET:ANSI),DOUBLE, |
  CENTER,GRAY,IMM,MDI,HLP('ActualizarSAOL_SOFTWARE'),SYSTEM
                       SHEET,AT(4,4,350,30),USE(?CurrentTab)
                         TAB('General'),USE(?Tab:1)
                           PROMPT('Nombre:'),AT(9,21),USE(?SAOL_SOF:NOMBRE:Prompt),TRN
                           ENTRY(@s100),AT(41,21,310,10),USE(SAOL_SOF:Nombre)
                         END
                       END
                       BUTTON('&OK'),AT(166,38,60,14),USE(?OK),DEFAULT,MSG('Aceptar los cambios y cerrar la ventana'), |
  TIP('Aceptar los cambios y cerrar la ventana')
                       BUTTON('Can&celar'),AT(230,38,60,14),USE(?Cancel),MSG('Anular los cambios'),TIP('Anular los cambios')
                       BUTTON('Ay&uda'),AT(294,38,60,14),USE(?Help),MSG('Ayuda'),STD(STD:Help),TIP('Ayuda')
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
    ActionMessage = 'Ver Software'
  OF InsertRecord
    ActionMessage = 'Agregar un Software'
  OF ChangeRecord
    ActionMessage = 'Cambiar un Software'
  END
  QuickWindow{PROP:Text} = ActionMessage                   ! Display status message in title bar
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('SAOL_Software:Ficha')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?SAOL_SOF:NOMBRE:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(SAOL_SOF:Record,History::SAOL_SOF:Record)
  SELF.AddHistoryField(?SAOL_SOF:Nombre,2)
  SELF.AddUpdateFile(Access:SAOL_Software)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:SAOL_Software.Open                                ! File SAOL_Software used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:SAOL_Software
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
    ?SAOL_SOF:Nombre{PROP:ReadOnly} = True
  END
  INIMgr.Fetch('SAOL_Software:Ficha',QuickWindow)          ! Restore window settings from non-volatile store
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
    Relate:SAOL_Software.Close
  END
  IF SELF.Opened
    INIMgr.Update('SAOL_Software:Ficha',QuickWindow)       ! Save window data to non-volatile store
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

