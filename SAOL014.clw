

   MEMBER('SAOL.clw')                                      ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('SAOL014.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('SAOL004.INC'),ONCE        !Req'd for module callout resolution
                     END


!!! <summary>
!!! Generated from procedure template - Window
!!! Software por Cliente
!!! </summary>
AsignarProductosACliente:Browse PROCEDURE 

CurrentTab           STRING(80)                            !
BRW1::View:Browse    VIEW(SAOL_SoftwarexCliente)
                       PROJECT(SAOL_SXC:id)
                       PROJECT(SAOL_SXC:idCliente)
                       PROJECT(SAOL_SXC:idSoftware)
                       JOIN(SAOL_CLI:PorID,SAOL_SXC:idCliente)
                         PROJECT(SAOL_CLI:Nombre)
                         PROJECT(SAOL_CLI:id)
                       END
                       JOIN(SAOL_SOF:PorID,SAOL_SXC:idSoftware)
                         PROJECT(SAOL_SOF:Nombre)
                         PROJECT(SAOL_SOF:id)
                       END
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
SAOL_CLI:Nombre        LIKE(SAOL_CLI:Nombre)          !List box control field - type derived from field
SAOL_SOF:Nombre        LIKE(SAOL_SOF:Nombre)          !List box control field - type derived from field
SAOL_SXC:id            LIKE(SAOL_SXC:id)              !Primary key field - type derived from field
SAOL_SXC:idCliente     LIKE(SAOL_SXC:idCliente)       !Browse key field - type derived from field
SAOL_CLI:id            LIKE(SAOL_CLI:id)              !Related join file key field - type derived from field
SAOL_SOF:id            LIKE(SAOL_SOF:id)              !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
EnhancedFocusManager EnhancedFocusClassType
QuickWindow          WINDOW('Software instalado en el Cliente'),AT(,,332,198),FONT('Arial',9,,FONT:bold,CHARSET:ANSI), |
  RESIZE,CENTER,GRAY,IMM,MDI,HLP('AsignarProductosACliente:Browse'),SYSTEM
                       LIST,AT(8,30,316,124),USE(?Browse:1),HVSCROLL,FORMAT('150L(2)|_M~Cliente~@s100@150L(2)|' & |
  '_M~Software~@s100@'),FROM(Queue:Browse:1),IMM,VCR
                       BUTTON('&Elegir'),AT(4,180,60,14),USE(?Select:2),MSG('Elegir el registro'),TIP('Elegir el registro')
                       BUTTON('&Agregar'),AT(136,158,60,14),USE(?Insert:4),MSG('Agregar un registro'),TIP('Agregar un registro')
                       BUTTON('&Cambiar'),AT(200,158,60,14),USE(?Change:4),DEFAULT,MSG('Cambiar un registro'),TIP('Cambiar un registro')
                       BUTTON('&Borrar'),AT(264,158,60,14),USE(?Delete:4),MSG('Borrar el registro'),TIP('Borrar el registro')
                       SHEET,AT(4,4,324,172),USE(?CurrentTab:2)
                         TAB('&Por Cliente'),USE(?Tab:2)
                         END
                       END
                       BUTTON('Ce&rrar'),AT(204,180,60,14),USE(?Close),MSG('Cerrar la ventana'),TIP('Cerrar la ventana')
                       BUTTON('Ay&uda'),AT(268,180,60,14),USE(?Help),MSG('Ayuda de la aplicación'),STD(STD:Help), |
  TIP('Ayuda de la aplicación')
                     END

                                                           ! BrowseSaveFormats (ABC Free)
SRCF::Procedure EQUATE('AsignarProductosACliente:Browse')  ! BrowseSaveFormats (ABC Free)
SRCF::OldFieldValue STRING(256)                            ! BrowseSaveFormats (ABC Free)
SRCF::OldFormat     CSTRING(8192)                          ! BrowseSaveFormats (ABC Free)
SRCF::CurrentFormat CSTRING(8192)                          ! BrowseSaveFormats (ABC Free)
SRCF::Q:Ptr LONG                                           ! BrowseSaveFormats (ABC Free)
SRCF::Q     QUEUE                                          ! BrowseSaveFormats (ABC Free)
Name          CSTRING(65)                                  ! BrowseSaveFormats (ABC Free)
Control       LONG                                         ! BrowseSaveFormats (ABC Free)
Format        CSTRING(8192)                                ! BrowseSaveFormats (ABC Free)
            END                                            ! BrowseSaveFormats (ABC Free)
ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?Browse:1
Q                      &Queue:Browse:1                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
                     END

BRW1::Sort0:Locator  IncrementalLocatorClass               ! Default Locator
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
  GlobalErrors.SetProcedureName('AsignarProductosACliente:Browse')
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
  Relate:SAOL_SoftwarexCliente.SetOpenRelated()
  Relate:SAOL_SoftwarexCliente.Open                        ! File SAOL_SoftwarexCliente used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:SAOL_SoftwarexCliente,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
                                                           ! BrowseSaveFormats (ABC Free)
  QuickWindow{Prop:Alrt,255} = CtrlAltR          ! Alert list format reset key
  SRCF::Q.Name    = '?Browse:1'                            ! BrowseSaveFormats (ABC Free)
  SRCF::Q.Control = ?Browse:1                              ! BrowseSaveFormats (ABC Free)
  SRCF::Q.Format = ?Browse:1{PROP:Format}                  ! BrowseSaveFormats (ABC Free)
  ADD(SRCF::Q,SRCF::Q.Control)                             ! BrowseSaveFormats (ABC Free)
     SRCF::OldFormat = INIMgr.TryFetch(SRCF::Procedure,'SRCFOriginal?Browse:1') ! BrowseSaveFormats (ABC Free)
     SRCF::CurrentFormat = ?Browse:1{PROP:Format}          ! BrowseSaveFormats (ABC Free)
     IF SRCF::OldFormat <> SRCF::CurrentFormat OR NOT(SRCF::OldFormat) OR NOT(INSTRING('@',SRCF::OldFormat,1)) ! BrowseSaveFormats (ABC Free)
        INIMgr.Update(SRCF::Procedure,'SRCFOriginal?Browse:1',?Browse:1{PROP:Format}) ! BrowseSaveFormats (ABC Free)
        INIMgr.Update(SRCF::Procedure,'SRCF?Browse:1',?Browse:1{PROP:Format}) ! BrowseSaveFormats (ABC Free)
     ELSE                                                  ! BrowseSaveFormats (ABC Free)
        SRCF::CurrentFormat = ?Browse:1{PROP:Format}       ! BrowseSaveFormats (ABC Free)
        INIMgr.Fetch(SRCF::Procedure,'SRCF?Browse:1',SRCF::CurrentFormat) ! BrowseSaveFormats (ABC Free)
        IF ?Browse:1{PROP:Format} <> SRCF::CurrentFormat AND SRCF::CurrentFormat ! BrowseSaveFormats (ABC Free)
           ?Browse:1{PROP:Format} = SRCF::CurrentFormat    ! BrowseSaveFormats (ABC Free)
        END                                                ! BrowseSaveFormats (ABC Free)
     END                                                   ! BrowseSaveFormats (ABC Free)
    I# = INIMgr.TryFetch(SRCF::Procedure,'SRCF?CurrentTab:2')
    IF I# = 0
       I# = 1
    END
      SELECT(?CurrentTab:2,I#) 																            ! BrowseSaveFormats (ABC Free)
      POST(EVENT:NewSelection,?CurrentTab:2)											    ! BrowseSaveFormats (ABC Free)
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1::Sort0:StepClass.Init(+ScrollSort:AllowAlpha)       ! Moveable thumb based upon SAOL_SXC:idCliente for sort order 1
  BRW1.AddSortOrder(BRW1::Sort0:StepClass,SAOL_SXC:PorCliente) ! Add the sort order for SAOL_SXC:PorCliente for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,SAOL_SXC:idCliente,1,BRW1)     ! Initialize the browse locator using  using key: SAOL_SXC:PorCliente , SAOL_SXC:idCliente
  BRW1.AddField(SAOL_CLI:Nombre,BRW1.Q.SAOL_CLI:Nombre)    ! Field SAOL_CLI:Nombre is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_SOF:Nombre,BRW1.Q.SAOL_SOF:Nombre)    ! Field SAOL_SOF:Nombre is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_SXC:id,BRW1.Q.SAOL_SXC:id)            ! Field SAOL_SXC:id is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_SXC:idCliente,BRW1.Q.SAOL_SXC:idCliente) ! Field SAOL_SXC:idCliente is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_CLI:id,BRW1.Q.SAOL_CLI:id)            ! Field SAOL_CLI:id is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_SOF:id,BRW1.Q.SAOL_SOF:id)            ! Field SAOL_SOF:id is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('AsignarProductosACliente:Browse',QuickWindow) ! Restore window settings from non-volatile store
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
    Relate:SAOL_SoftwarexCliente.Close
  END
  IF SELF.Opened
    INIMgr.Update('AsignarProductosACliente:Browse',QuickWindow) ! Save window data to non-volatile store
  END
                                                           ! BrowseSaveFormats (ABC Free)
  IF SELF.Opened                                           ! BrowseSaveFormats (ABC Free)
  INIMgr.Update(SRCF::Procedure,'SRCF?Browse:1',?Browse:1{PROP:Format}) ! BrowseSaveFormats (ABC Free)
  INIMgr.Update(SRCF::Procedure,'SRCF?CurrentTab:2',CHOICE(?CurrentTab:2)) ! BrowseSaveFormats (ABC Free)
  END                                                      ! BrowseSaveFormats (ABC Free)
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
    SAOL_SoftwarexCliente:Ficha
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


ThisWindow.TakeEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  IF EVENT() = 08D0H                                       ! BrowseSaveFormats (ABC Free)
     LOOP SRCF::Q:Ptr = 1 TO RECORDS(SRCF::Q)              ! BrowseSaveFormats (ABC Free)
        GET(SRCF::Q,SRCF::Q:Ptr)                           ! BrowseSaveFormats (ABC Free)
        IF SRCF::Q.Control{Prop:Visible} AND SRCF::Q.Format ! BrowseSaveFormats (ABC Free)
           SRCF::Q.Control{PROP:Format} = SRCF::Q.Format   ! BrowseSaveFormats (ABC Free)
           POST(Event:NewSelection,SRCF::Q.Control)        ! BrowseSaveFormats (ABC Free)
        END                                                ! BrowseSaveFormats (ABC Free)
     END                                                   ! BrowseSaveFormats (ABC Free)
  END                                                      ! BrowseSaveFormats (ABC Free)
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


ThisWindow.TakeWindowEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all window specific events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeWindowEvent()
    CASE EVENT()
    OF EVENT:AlertKey
                                                           ! BrowseSaveFormats (ABC Free)
      IF KEYCODE() = CtrlAltR             ! Check list format reset key
         LOOP SRCF::Q:Ptr = 1 TO RECORDS(SRCF::Q)          ! BrowseSaveFormats (ABC Free)
            GET(SRCF::Q,SRCF::Q:Ptr)                       ! BrowseSaveFormats (ABC Free)
            IF SRCF::Q.Control{Prop:Visible} AND SRCF::Q.Format ! BrowseSaveFormats (ABC Free)
               SRCF::Q.Control{PROP:Format} = SRCF::Q.Format ! BrowseSaveFormats (ABC Free)
               POST(Event:NewSelection,SRCF::Q.Control)    ! BrowseSaveFormats (ABC Free)
            END                                            ! BrowseSaveFormats (ABC Free)
         END                                               ! BrowseSaveFormats (ABC Free)
      END                                                  ! BrowseSaveFormats (ABC Free)
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  SELF.SelectControl = ?Select:2
  SELF.HideSelect = 1                                      ! Hide the select button when disabled
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

