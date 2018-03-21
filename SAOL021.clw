

   MEMBER('SAOL.clw')                                      ! This is a MEMBER module


   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('SAOL021.INC'),ONCE        !Local module procedure declarations
                     END


!!! <summary>
!!! Generated from procedure template - Window
!!! Actualizar Passcodes
!!! </summary>
SAOL_Passcode:Ficha PROCEDURE 

CurrentTab           STRING(80)                            !
ActionMessage        CSTRING(40)                           !
EnhancedFocusManager EnhancedFocusClassType
History::SAOL_PASS:Record LIKE(SAOL_PASS:RECORD),THREAD
QuickWindow          WINDOW('Actualizar'),AT(,,277,165),FONT('Arial',9,,FONT:bold,CHARSET:ANSI),DOUBLE,CENTER,GRAY, |
  IMM,MDI,HLP('ActualizarSAOL_Passcode'),SYSTEM
                       SHEET,AT(4,17,269,128),USE(?CurrentTab)
                         TAB('&Registro'),USE(?Tab:1)
                           PROMPT('Fecha:'),AT(38,39),USE(?SAOL_PASS:Fecha:Prompt),RIGHT,TRN
                           ENTRY(@d6),AT(65,39,41,10),USE(SAOL_PASS:Fecha),RIGHT(1),READONLY,SKIP
                           PROMPT('Hora:'),AT(42,55),USE(?SAOL_PASS:Hora:Prompt),RIGHT,TRN
                           ENTRY(@t4),AT(65,55,33,10),USE(SAOL_PASS:Hora),RIGHT(1),READONLY,SKIP
                           PROMPT('Nombre PC:'),AT(21,71),USE(?SAOL_PASS:NombrePC:Prompt),TRN
                           ENTRY(@s40),AT(65,71,102,10),USE(SAOL_PASS:NombrePC)
                           PROMPT('Solicitado por:'),AT(13,86),USE(?SAOL_PASS:UsuarioquePidio:Prompt),TRN
                           ENTRY(@s40),AT(65,86,102,10),USE(SAOL_PASS:UsuarioquePidio)
                           OPTION('Tipo Passcode:'),AT(191,35,76,66),USE(SAOL_PASS:TipoPasscode,,?SAOL_PASS:TipoPasscode:2), |
  BOXED,TRN
                             RADIO('Permanente'),AT(197,73),USE(?SAOL_PASS:TipoPasscode:Radio0),VALUE('1'),TRN
                             RADIO('Reset de Fecha'),AT(220,88,37),USE(?SAOL_PASS:TipoPasscode:Radio4),DISABLE,HIDE,VALUE('5'),TRN
                             RADIO('Anual'),AT(197,86),USE(?SAOL_PASS:TipoPasscode:Radio1),VALUE('2'),TRN
                             RADIO('Mensual'),AT(197,60),USE(?SAOL_PASS:TipoPasscode:Radio2),VALUE('3'),TRN
                             RADIO('Diario'),AT(197,47),USE(?SAOL_PASS:TipoPasscode:Radio3),VALUE('4'),TRN
                             RADIO('Upgrade'),AT(220,87),USE(?SAOL_PASS:TipoPasscode:Radio5),DISABLE,HIDE,VALUE('6'),TRN
                           END
                           PROMPT('Vencimiento:'),AT(17,102),USE(?SAOL_PASS:FechaVencimiento:Prompt),RIGHT,TRN
                           ENTRY(@d6b),AT(65,102,41,10),USE(SAOL_PASS:FechaVencimiento),RIGHT(1),READONLY,SKIP
                           PROMPT('Código PC:'),AT(25,116),USE(?SAOL_PASS:CodigoMaquina:Prompt),RIGHT,TRN
                           ENTRY(@n_6),AT(65,116,41,10),USE(SAOL_PASS:CodigoMaquina),RIGHT(1),MSG('Código de Máquina')
                           BUTTON,AT(111,115,33,12),USE(?Passcode),FONT(,,,FONT:regular),RIGHT,ICON(ICON:VCRfastforward), |
  MSG('Obtener Passcode'),TIP('Obtener Passcode')
                           PROMPT('Passcode:'),AT(150,116),USE(?SAOL_PASS:Passcode:Prompt),RIGHT,TRN
                           ENTRY(@n_6),AT(190,116,34,10),USE(SAOL_PASS:Passcode),RIGHT(1),COLOR(00C0C0FFh,,00C0C0FFh), |
  READONLY,SKIP
                           ENTRY(@s255),AT(65,130,202,10),USE(SAOL_PASS:Observaciones)
                           PROMPT('Observaciones:'),AT(9,130),USE(?SAOL_PASS:Observaciones:Prompt),TRN
                         END
                       END
                       BUTTON('&OK'),AT(84,147,60,14),USE(?OK),DEFAULT,MSG('Aceptar los cambios y cerrar la ventana'), |
  TIP('Aceptar los cambios y cerrar la ventana')
                       BUTTON('Can&celar'),AT(148,147,60,14),USE(?Cancel),MSG('Anular los cambios'),TIP('Anular los cambios')
                       BUTTON('Ay&uda'),AT(212,147,60,14),USE(?Help),MSG('Ayuda'),STD(STD:Help),TIP('Ayuda')
                       PROMPT('Cliente:'),AT(75,3),USE(?SAOL_CLI:Nombre:Prompt)
                       ENTRY(@s99),AT(105,3,166,10),USE(SAOL_CLI:Nombre),READONLY,SKIP
                       PROMPT('Software:'),AT(69,16),USE(?SAOL_SOF:Nombre:Prompt)
                       ENTRY(@s100),AT(105,16,166,10),USE(SAOL_SOF:Nombre),READONLY,SKIP
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
PrimeFields            PROCEDURE(),PROC,DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
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
    ActionMessage = 'Ver un Passcode'
  OF InsertRecord
    ActionMessage = 'Agregar nuevo Passcode'
  OF ChangeRecord
    ActionMessage = 'Cambiar un Passcode'
  END
  QuickWindow{PROP:Text} = ActionMessage                   ! Display status message in title bar
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('SAOL_Passcode:Ficha')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?SAOL_PASS:Fecha:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(SAOL_PASS:Record,History::SAOL_PASS:Record)
  SELF.AddHistoryField(?SAOL_PASS:Fecha,4)
  SELF.AddHistoryField(?SAOL_PASS:Hora,5)
  SELF.AddHistoryField(?SAOL_PASS:NombrePC,6)
  SELF.AddHistoryField(?SAOL_PASS:UsuarioquePidio,7)
  SELF.AddHistoryField(?SAOL_PASS:TipoPasscode:2,9)
  SELF.AddHistoryField(?SAOL_PASS:FechaVencimiento,10)
  SELF.AddHistoryField(?SAOL_PASS:CodigoMaquina,8)
  SELF.AddHistoryField(?SAOL_PASS:Passcode,11)
  SELF.AddHistoryField(?SAOL_PASS:Observaciones,12)
  SELF.AddUpdateFile(Access:SAOL_Passcode)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:SAOL_Clientes.Open                                ! File SAOL_Clientes used by this procedure, so make sure it's RelationManager is open
  Access:SAOL_Software.UseFile                             ! File referenced in 'Other Files' so need to inform it's FileManager
  SELF.FilesOpened = True
  SELF.Primary &= Relate:SAOL_Passcode
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
    ?SAOL_PASS:Fecha{PROP:ReadOnly} = True
    ?SAOL_PASS:Hora{PROP:ReadOnly} = True
    ?SAOL_PASS:NombrePC{PROP:ReadOnly} = True
    ?SAOL_PASS:UsuarioquePidio{PROP:ReadOnly} = True
    ?SAOL_PASS:FechaVencimiento{PROP:ReadOnly} = True
    ?SAOL_PASS:CodigoMaquina{PROP:ReadOnly} = True
    DISABLE(?Passcode)
    ?SAOL_PASS:Passcode{PROP:ReadOnly} = True
    ?SAOL_PASS:Observaciones{PROP:ReadOnly} = True
    ?SAOL_CLI:Nombre{PROP:ReadOnly} = True
    ?SAOL_SOF:Nombre{PROP:ReadOnly} = True
  END
  INIMgr.Fetch('SAOL_Passcode:Ficha',QuickWindow)          ! Restore window settings from non-volatile store
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
    INIMgr.Update('SAOL_Passcode:Ficha',QuickWindow)       ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.PrimeFields PROCEDURE

  CODE
  SAOL_PASS:Fecha = TODAY()
  SAOL_PASS:Hora = CLOCK()
  SAOL_PASS:idcliente = SAOL_CLI:id
  SAOL_PASS:idSoftware = SAOL_SOF:id
  PARENT.PrimeFields


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
    OF ?Passcode
      ThisWindow.Update
        CASE SAOL_SOF:id
      	OF 1
      	   SP" = '.\PASSCODE_BOSS.INI'
             PUTINI('Req', 'M', SAOL_PASS:CodigoMaquina , SP")
             PUTINI('Req', 'D', SAOL_PASS:Fecha, SP")
             !---
             SETCURSOR(CURSOR:Wait)
             RUN('showpass_BOSS',1)
             SETCURSOR
             !---
      	OF 2
      	   SP" = '.\PASSCODE_CRM.INI'
             PUTINI('Req', 'M', SAOL_PASS:CodigoMaquina , SP")
             PUTINI('Req', 'D', SAOL_PASS:Fecha, SP")
             !---
             SETCURSOR(CURSOR:Wait)
             RUN('showpass_CRM',1)
             SETCURSOR
             !---
      	OF 3
      	   SP" = '.\PASSCODE_SISPER.INI'
             PUTINI('Req', 'M', SAOL_PASS:CodigoMaquina , SP")
             PUTINI('Req', 'D', SAOL_PASS:Fecha, SP")
             !---
             SETCURSOR(CURSOR:Wait)
             RUN('showpass_SISPER',1)
             SETCURSOR
             !---
      	OF 4
      	   SP" = '.\PASSCODE_SLS.INI'
             PUTINI('Req', 'M', SAOL_PASS:CodigoMaquina , SP")
             PUTINI('Req', 'D', SAOL_PASS:Fecha, SP")
             !---
             SETCURSOR(CURSOR:Wait)
             RUN('showpass_SLS',1)
             SETCURSOR
             !---
        END		
        CASE SAOL_PASS:TipoPasscode
           OF 1
      		SAOL_PASS:Passcode = GETINI('Rsp', 'P',, SP")
      	 OF 2	
      		SAOL_PASS:Passcode = GETINI('Rsp', 'Y',, SP")
      	 OF 3	
      		SAOL_PASS:Passcode  = GETINI('Rsp', 'M',, SP")
      	 OF 4	
      		SAOL_PASS:Passcode  = GETINI('Rsp', 'D',, SP")
        END
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
    OF ?SAOL_PASS:TipoPasscode:Radio0
      SAOL_PASS:FechaVencimiento = 0
      DISPLAY
    OF ?SAOL_PASS:TipoPasscode:Radio1
      SAOL_PASS:FechaVencimiento = SAOL_PASS:Fecha + 365
      DISPLAY
    OF ?SAOL_PASS:TipoPasscode:Radio2
      SAOL_PASS:FechaVencimiento = SAOL_PASS:Fecha + 31
      DISPLAY
    OF ?SAOL_PASS:TipoPasscode:Radio3
      SAOL_PASS:FechaVencimiento = SAOL_PASS:Fecha + 1
      DISPLAY
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

