

   MEMBER('SAOL.clw')                                      ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('SAOL020.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('SAOL021.INC'),ONCE        !Req'd for module callout resolution
                     END


!!! <summary>
!!! Generated from procedure template - Window
!!! Actualizar Passcodes
!!! </summary>
SAOL_Passcode:Browse PROCEDURE (idCliente,idSoftware)

CurrentTab           STRING(80)                            !
BRW1::View:Browse    VIEW(SAOL_Passcode)
                       PROJECT(SAOL_PASS:Fecha)
                       PROJECT(SAOL_PASS:Hora)
                       PROJECT(SAOL_PASS:NombrePC)
                       PROJECT(SAOL_PASS:UsuarioquePidio)
                       PROJECT(SAOL_PASS:CodigoMaquina)
                       PROJECT(SAOL_PASS:Passcode)
                       PROJECT(SAOL_PASS:FechaVencimiento)
                       PROJECT(SAOL_PASS:Observaciones)
                       PROJECT(SAOL_PASS:id)
                       PROJECT(SAOL_PASS:idcliente)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
SAOL_PASS:Fecha        LIKE(SAOL_PASS:Fecha)          !List box control field - type derived from field
SAOL_PASS:Hora         LIKE(SAOL_PASS:Hora)           !List box control field - type derived from field
SAOL_PASS:NombrePC     LIKE(SAOL_PASS:NombrePC)       !List box control field - type derived from field
SAOL_PASS:UsuarioquePidio LIKE(SAOL_PASS:UsuarioquePidio) !List box control field - type derived from field
SAOL_PASS:CodigoMaquina LIKE(SAOL_PASS:CodigoMaquina) !List box control field - type derived from field
SAOL_PASS:Passcode     LIKE(SAOL_PASS:Passcode)       !List box control field - type derived from field
SAOL_PASS:FechaVencimiento LIKE(SAOL_PASS:FechaVencimiento) !List box control field - type derived from field
SAOL_PASS:Observaciones LIKE(SAOL_PASS:Observaciones) !Browse hot field - type derived from field
SAOL_PASS:id           LIKE(SAOL_PASS:id)             !Primary key field - type derived from field
SAOL_PASS:idcliente    LIKE(SAOL_PASS:idcliente)      !Browse key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
EnhancedFocusManager EnhancedFocusClassType
QuickWindow          WINDOW('Claves otorgadas'),AT(,,439,217),FONT('Arial',9,,FONT:bold,CHARSET:ANSI),RESIZE,CENTER, |
  GRAY,IMM,MDI,HLP('BrowsePasscodes'),SYSTEM
                       LIST,AT(10,25,419,129),USE(?Browse:1),HVSCROLL,FORMAT('50C|M~Fecha~C(0)@d6@37R(2)|M~Hor' & |
  'a~C(0)@t4@100L(2)|M~Nombre de PC~@s40@100L(2)|M~Usuario solicitante~@s40@40C(2)|M~Có' & |
  'digo PC~C(0)@n_6@40C(2)|M~Passcode~C(0)@n_6@50R(2)|M~Vencimiento~C(0)@d6@'),FROM(Queue:Browse:1), |
  IMM
                       BUTTON('&Agregar'),AT(242,174,60,14),USE(?Insert:4),MSG('Agregar un registro'),TIP('Agregar un registro')
                       BUTTON('&Cambiar'),AT(306,174,60,14),USE(?Change:4),DEFAULT,MSG('Cambiar un registro'),TIP('Cambiar un registro')
                       BUTTON('&Borrar'),AT(370,174,60,14),USE(?Delete:4),MSG('Borrar el registro'),TIP('Borrar el registro')
                       PROMPT('Observaciones:'),AT(9,159),USE(?SAOL_PASS:Observaciones:Prompt)
                       ENTRY(@s255),AT(63,159,367,10),USE(SAOL_PASS:Observaciones),READONLY,SKIP,TRN
                       SHEET,AT(4,4,432,191),USE(?CurrentTab)
                         TAB('&Claves otorgadas'),USE(?Tab:2)
                         END
                       END
                       BUTTON('Ce&rrar'),AT(306,198,60,14),USE(?Close),MSG('Cerrar la ventana'),TIP('Cerrar la ventana')
                       BUTTON('Ay&uda'),AT(370,198,60,14),USE(?Help),MSG('Ayuda de la aplicación'),STD(STD:Help), |
  TIP('Ayuda de la aplicación')
                       PROMPT('Cliente:'),AT(73,4),USE(?SAOL_CLI:Nombre:Prompt)
                       ENTRY(@s99),AT(101,4,184,10),USE(SAOL_CLI:Nombre),READONLY,SKIP
                       PROMPT('Software:'),AT(302,4),USE(?SAOL_SOF:Nombre:Prompt)
                       ENTRY(@s100),AT(338,4,95,10),USE(SAOL_SOF:Nombre),READONLY,SKIP
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?Browse:1
Q                      &Queue:Browse:1                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
                     END

BRW1::Sort0:Locator  StepLocatorClass                      ! Default Locator
BRW1::Sort0:StepClass StepLongClass                        ! Default Step Manager
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
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

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('SAOL_Passcode:Browse')
  SAOL_CLI:Id = idCliente
  GET(SAOL_Clientes,SAOL_CLI:PorID)
  SAOL_SOF:Id = idSoftware
  GET(SAOL_Software,SAOL_SOF:PorID)
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Browse:1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:SAOL_Clientes.Open                                ! File SAOL_Clientes used by this procedure, so make sure it's RelationManager is open
  Access:SAOL_Software.UseFile                             ! File referenced in 'Other Files' so need to inform it's FileManager
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:SAOL_Passcode,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1::Sort0:StepClass.Init(+ScrollSort:AllowAlpha)       ! Moveable thumb based upon SAOL_PASS:idcliente for sort order 1
  BRW1.AddSortOrder(BRW1::Sort0:StepClass,SAOL_PASS:PorCliente) ! Add the sort order for SAOL_PASS:PorCliente for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,SAOL_PASS:idcliente,1,BRW1)    ! Initialize the browse locator using  using key: SAOL_PASS:PorCliente , SAOL_PASS:idcliente
  BRW1.SetFilter('(SAOL_PASS:idcliente = SAOL_CLI:id AND SAOL_PASS:idSoftware =  SAOL_SOF:Id)') ! Apply filter expression to browse
  BRW1.AddField(SAOL_PASS:Fecha,BRW1.Q.SAOL_PASS:Fecha)    ! Field SAOL_PASS:Fecha is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_PASS:Hora,BRW1.Q.SAOL_PASS:Hora)      ! Field SAOL_PASS:Hora is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_PASS:NombrePC,BRW1.Q.SAOL_PASS:NombrePC) ! Field SAOL_PASS:NombrePC is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_PASS:UsuarioquePidio,BRW1.Q.SAOL_PASS:UsuarioquePidio) ! Field SAOL_PASS:UsuarioquePidio is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_PASS:CodigoMaquina,BRW1.Q.SAOL_PASS:CodigoMaquina) ! Field SAOL_PASS:CodigoMaquina is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_PASS:Passcode,BRW1.Q.SAOL_PASS:Passcode) ! Field SAOL_PASS:Passcode is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_PASS:FechaVencimiento,BRW1.Q.SAOL_PASS:FechaVencimiento) ! Field SAOL_PASS:FechaVencimiento is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_PASS:Observaciones,BRW1.Q.SAOL_PASS:Observaciones) ! Field SAOL_PASS:Observaciones is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_PASS:id,BRW1.Q.SAOL_PASS:id)          ! Field SAOL_PASS:id is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_PASS:idcliente,BRW1.Q.SAOL_PASS:idcliente) ! Field SAOL_PASS:idcliente is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('SAOL_Passcode:Browse',QuickWindow)         ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW1.AskProcedure = 1
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  BRW1.ToolbarItem.HelpButton = ?Help
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
    INIMgr.Update('SAOL_Passcode:Browse',QuickWindow)      ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    SAOL_Passcode:Ficha
    ReturnValue = GlobalResponse
  END
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


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert:4
    SELF.ChangeControl=?Change:4
    SELF.DeleteControl=?Delete:4
  END


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window
  SELF.SetStrategy(?SAOL_PASS:Observaciones:Prompt, Resize:FixLeft+Resize:FixBottom, Resize:LockSize) ! Override strategy for ?SAOL_PASS:Observaciones:Prompt
  SELF.SetStrategy(?SAOL_PASS:Observaciones, Resize:FixLeft+Resize:FixBottom, Resize:LockSize) ! Override strategy for ?SAOL_PASS:Observaciones
  SELF.SetStrategy(?SAOL_CLI:Nombre:Prompt, Resize:FixLeft+Resize:FixTop, Resize:LockSize) ! Override strategy for ?SAOL_CLI:Nombre:Prompt
  SELF.SetStrategy(?SAOL_CLI:Nombre, Resize:FixLeft+Resize:FixTop, Resize:LockSize) ! Override strategy for ?SAOL_CLI:Nombre
  SELF.SetStrategy(?SAOL_SOF:Nombre:Prompt, Resize:FixRight+Resize:FixTop, Resize:LockSize) ! Override strategy for ?SAOL_SOF:Nombre:Prompt
  SELF.SetStrategy(?SAOL_SOF:Nombre, Resize:FixRight+Resize:FixTop, Resize:LockSize) ! Override strategy for ?SAOL_SOF:Nombre

