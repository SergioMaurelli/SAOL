

   MEMBER('SAOL.clw')                                      ! This is a MEMBER module


   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('SAOL019.INC'),ONCE        !Local module procedure declarations
                     END


!!! <summary>
!!! Generated from procedure template - Window
!!! Componentes
!!! </summary>
SAOL_Componentes:Ficha PROCEDURE 

CurrentTab           STRING(80)                            !
ActionMessage        CSTRING(40)                           !
EnhancedFocusManager EnhancedFocusClassType
History::SAOL_COM:Record LIKE(SAOL_COM:RECORD),THREAD
QuickWindow          WINDOW('Editar Componente'),AT(,,358,168),FONT('Arial',9,,FONT:bold,CHARSET:ANSI),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('SAOL_Componentes:Ficha'),SYSTEM
                       SHEET,AT(4,4,350,142),USE(?CurrentTab)
                         TAB('&1) General'),USE(?Tab:1)
                           PROMPT('Descripción:'),AT(29,28),USE(?SAOL_COM:Descripcion:Prompt),TRN
                           ENTRY(@s100),AT(75,28,270,10),USE(SAOL_COM:Descripcion)
                           PROMPT('Path:'),AT(53,42),USE(?SAOL_COM:Path:Prompt),TRN
                           ENTRY(@s255),AT(75,42,270,10),USE(SAOL_COM:Path),MSG('Path en donde se encuentra el componente'), |
  TIP('Path en donde se encuentra el componente')
                           PROMPT('Major:'),AT(49,57),USE(?SAOL_COM:Major:Prompt),RIGHT,TRN
                           ENTRY(@n_4),AT(75,57,23,10),USE(SAOL_COM:Major),RIGHT(1)
                           PROMPT('Minor:'),AT(49,71),USE(?SAOL_COM:Minor:Prompt),RIGHT,TRN
                           ENTRY(@n_4),AT(75,71,23,10),USE(SAOL_COM:Minor),RIGHT(1)
                           PROMPT('Release:'),AT(41,85),USE(?SAOL_COM:Release:Prompt),RIGHT,TRN
                           ENTRY(@n_4),AT(75,85,23,10),USE(SAOL_COM:Release),RIGHT(1)
                           PROMPT('Build:'),AT(52,99),USE(?SAOL_COM:Build:Prompt),RIGHT,TRN
                           ENTRY(@n_4),AT(75,99,23,10),USE(SAOL_COM:Build),RIGHT(1)
                           PROMPT('Fecha Generación:'),AT(9,113),USE(?SAOL_COM:FechaGeneracion:Prompt),RIGHT,TRN
                           ENTRY(@d6),AT(75,113,41,10),USE(SAOL_COM:FechaGeneracion),RIGHT(1)
                           PROMPT('Hora Generación:'),AT(13,127),USE(?SAOL_COM:HoraGeneracion:Prompt),RIGHT,TRN
                           ENTRY(@T4),AT(75,127,33,10),USE(SAOL_COM:HoraGeneracion),RIGHT(1)
                         END
                       END
                       BUTTON('&OK'),AT(166,150,60,14),USE(?OK),DEFAULT,MSG('Aceptar los cambios y cerrar la ventana'), |
  TIP('Aceptar los cambios y cerrar la ventana')
                       BUTTON('Can&celar'),AT(230,150,60,14),USE(?Cancel),MSG('Anular los cambios'),TIP('Anular los cambios')
                       BUTTON('Ay&uda'),AT(294,150,60,14),USE(?Help),MSG('Ayuda'),STD(STD:Help),TIP('Ayuda')
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
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
                     END

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
    ActionMessage = 'Ver Componente'
  OF InsertRecord
    GlobalErrors.Throw(Msg:InsertIllegal)
    RETURN
  OF ChangeRecord
    ActionMessage = 'Cambiar un Componente'
  OF DeleteRecord
    GlobalErrors.Throw(Msg:DeleteIllegal)
    RETURN
  END
  QuickWindow{PROP:Text} = ActionMessage                   ! Display status message in title bar
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('SAOL_Componentes:Ficha')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?SAOL_COM:Descripcion:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(SAOL_COM:Record,History::SAOL_COM:Record)
  SELF.AddHistoryField(?SAOL_COM:Descripcion,2)
  SELF.AddHistoryField(?SAOL_COM:Path,3)
  SELF.AddHistoryField(?SAOL_COM:Major,4)
  SELF.AddHistoryField(?SAOL_COM:Minor,5)
  SELF.AddHistoryField(?SAOL_COM:Release,6)
  SELF.AddHistoryField(?SAOL_COM:Build,7)
  SELF.AddHistoryField(?SAOL_COM:FechaGeneracion,8)
  SELF.AddHistoryField(?SAOL_COM:HoraGeneracion,9)
  SELF.AddUpdateFile(Access:SAOL_Componentes)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:SAOL_Componentes.SetOpenRelated()
  Relate:SAOL_Componentes.Open                             ! File SAOL_Componentes used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:SAOL_Componentes
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.InsertAction = Insert:None                        ! Inserts not allowed
    SELF.DeleteAction = Delete:None                        ! Deletes not allowed
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.CancelAction = Cancel:Cancel+Cancel:Query         ! Confirm cancel
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  IF SELF.Request = ViewRecord                             ! Configure controls for View Only mode
    ?SAOL_COM:Descripcion{PROP:ReadOnly} = True
    ?SAOL_COM:Path{PROP:ReadOnly} = True
    ?SAOL_COM:Major{PROP:ReadOnly} = True
    ?SAOL_COM:Minor{PROP:ReadOnly} = True
    ?SAOL_COM:Release{PROP:ReadOnly} = True
    ?SAOL_COM:Build{PROP:ReadOnly} = True
    ?SAOL_COM:FechaGeneracion{PROP:ReadOnly} = True
    ?SAOL_COM:HoraGeneracion{PROP:ReadOnly} = True
  END
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('SAOL_Componentes:Ficha',QuickWindow)       ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
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
    Relate:SAOL_Componentes.Close
  END
  IF SELF.Opened
    INIMgr.Update('SAOL_Componentes:Ficha',QuickWindow)    ! Save window data to non-volatile store
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


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

