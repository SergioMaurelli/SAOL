

   MEMBER('SAOL.clw')                                      ! This is a MEMBER module


   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('SAOL004.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('SAOL002.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('SAOL006.INC'),ONCE        !Req'd for module callout resolution
                     END


!!! <summary>
!!! Generated from procedure template - Window
!!! Software por Cliente
!!! </summary>
SAOL_SoftwarexCliente:Ficha PROCEDURE 

CurrentTab           STRING(80)                            !
ActionMessage        CSTRING(40)                           !
EnhancedFocusManager EnhancedFocusClassType
History::SAOL_SXC:Record LIKE(SAOL_SXC:RECORD),THREAD
QuickWindow          WINDOW('Asignar Software a un Cliente'),AT(,,277,74),FONT('Arial',9,,FONT:bold,CHARSET:ANSI), |
  DOUBLE,CENTER,GRAY,IMM,MDI,HLP('ActualizarSAOL_SOFTWAREXCLIENTE'),SYSTEM
                       SHEET,AT(4,5,270,47),USE(?SHEET1)
                         TAB('General'),USE(?TAB1)
                           PROMPT('Cliente:'),AT(15,22),USE(?SAOL_CLI:Nombre:Prompt),TRN
                           ENTRY(@s100),AT(43,22,210,10),USE(SAOL_CLI:Nombre),READONLY
                           BUTTON('...'),AT(258,21,12,12),USE(?CallLookup)
                           PROMPT('Software:'),AT(8,37),USE(?SAOL_SOF:NOMBRE:Prompt),TRN
                           ENTRY(@s100),AT(43,37,210,10),USE(SAOL_SOF:Nombre),READONLY
                           BUTTON('...'),AT(258,36,12,12),USE(?CallLookup:2)
                         END
                       END
                       BUTTON('&OK'),AT(85,55,60,14),USE(?OK),DEFAULT,MSG('Aceptar los cambios y cerrar la ventana'), |
  TIP('Aceptar los cambios y cerrar la ventana')
                       BUTTON('Can&celar'),AT(149,55,60,14),USE(?Cancel),MSG('Anular los cambios'),TIP('Anular los cambios')
                       BUTTON('Ay&uda'),AT(213,55,60,14),USE(?Help),MSG('Ayuda'),STD(STD:Help),TIP('Ayuda')
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
PrimeFields            PROCEDURE(),PROC,DERIVED
Reset                  PROCEDURE(BYTE Force=0),DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED
TakeSelected           PROCEDURE(),BYTE,PROC,DERIVED
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
    ActionMessage = 'Ver Software x Cliente'
  OF InsertRecord
    ActionMessage = 'Agregar un Software a un Cliente'
  OF ChangeRecord
    ActionMessage = 'Cambiar un Software de un Cliente'
  END
  QuickWindow{PROP:Text} = ActionMessage                   ! Display status message in title bar
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('SAOL_SoftwarexCliente:Ficha')
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
  SELF.AddHistoryFile(SAOL_SXC:Record,History::SAOL_SXC:Record)
  SELF.AddUpdateFile(Access:SAOL_SoftwarexCliente)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:SAOL_SoftwarexCliente.SetOpenRelated()
  Relate:SAOL_SoftwarexCliente.Open                        ! File SAOL_SoftwarexCliente used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:SAOL_SoftwarexCliente
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
    DISABLE(?CallLookup)
    ?SAOL_SOF:Nombre{PROP:ReadOnly} = True
    DISABLE(?CallLookup:2)
  END
  INIMgr.Fetch('SAOL_SoftwarexCliente:Ficha',QuickWindow)  ! Restore window settings from non-volatile store
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
    Relate:SAOL_SoftwarexCliente.Close
  END
  IF SELF.Opened
    INIMgr.Update('SAOL_SoftwarexCliente:Ficha',QuickWindow) ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.PrimeFields PROCEDURE

  CODE
  SAOL_SXC:idCliente = SAOL_CLI:id
  PARENT.PrimeFields


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF QuickWindow{Prop:AcceptAll} THEN RETURN.
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


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    EXECUTE Number
      SAOL_Clientes:Browse
      SAOL_Software:Browse
    END
    ReturnValue = GlobalResponse
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
    OF ?SAOL_CLI:Nombre
      ThisWindow.Reset(1)
    OF ?CallLookup
      ThisWindow.Update
      SAOL_CLI:Nombre = SAOL_CLI:Nombre
      IF SELF.Run(1,SelectRecord) = RequestCompleted       ! Call lookup procedure and verify RequestCompleted
        SAOL_CLI:Nombre = SAOL_CLI:Nombre
        SAOL_SXC:idCliente = SAOL_CLI:id
      END
      ThisWindow.Reset(1)
    OF ?SAOL_SOF:Nombre
      ThisWindow.Reset(1)
    OF ?CallLookup:2
      ThisWindow.Update
      SAOL_SOF:Nombre = SAOL_SOF:Nombre
      IF SELF.Run(2,SelectRecord) = RequestCompleted       ! Call lookup procedure and verify RequestCompleted
        SAOL_SOF:Nombre = SAOL_SOF:Nombre
        SAOL_SXC:idSoftware = SAOL_SOF:id
      END
      ThisWindow.Reset(1)
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


ThisWindow.TakeSelected PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all Selected events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeSelected()
    CASE FIELD()
    OF ?SAOL_CLI:Nombre
      SAOL_CLI:Nombre = SAOL_CLI:Nombre
      IF Access:SAOL_Clientes.TryFetch(SAOL_CLI:PorNombre)
        IF SELF.Run(1,SelectRecord) = RequestCompleted
          SAOL_CLI:Nombre = SAOL_CLI:Nombre
          SAOL_SXC:idCliente = SAOL_CLI:id
      ELSE
          CLEAR(SAOL_SXC:idCliente)
        END
      END
      ThisWindow.Reset
    OF ?SAOL_SOF:Nombre
      SAOL_SOF:Nombre = SAOL_SOF:Nombre
      IF Access:SAOL_Software.TryFetch(SAOL_SOF:PorNombre)
        IF SELF.Run(2,SelectRecord) = RequestCompleted
          SAOL_SOF:Nombre = SAOL_SOF:Nombre
          SAOL_SXC:idSoftware = SAOL_SOF:id
      ELSE
          CLEAR(SAOL_SXC:idSoftware)
        END
      END
      ThisWindow.Reset
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

