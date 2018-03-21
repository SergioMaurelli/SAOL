

   MEMBER('SAOL.clw')                                      ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('SAOL017.INC'),ONCE        !Local module procedure declarations
                     END


!!! <summary>
!!! Generated from procedure template - Window
!!! Componentes por Instalador
!!! </summary>
SAOL_ComponentesxInstalador:Browse PROCEDURE 

Loc:Version          STRING(20)                            !
CurrentTab           STRING(80)                            !
BRW1::View:Browse    VIEW(SAOL_ComponentesxInstalador)
                       PROJECT(SAOL_CXI:Procesar)
                       PROJECT(SAOL_CXI:FechaGeneracion)
                       PROJECT(SAOL_CXI:HoraGeneracion)
                       PROJECT(SAOL_CXI:id)
                       PROJECT(SAOL_CXI:idComponente)
                       JOIN(SAOL_COM:PorID,SAOL_CXI:idComponente)
                         PROJECT(SAOL_COM:Descripcion)
                         PROJECT(SAOL_COM:Path)
                         PROJECT(SAOL_COM:id)
                       END
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
SAOL_CXI:Procesar      LIKE(SAOL_CXI:Procesar)        !List box control field - type derived from field
SAOL_CXI:Procesar_Icon LONG                           !Entry's icon ID
SAOL_COM:Descripcion   LIKE(SAOL_COM:Descripcion)     !List box control field - type derived from field
SAOL_COM:Path          LIKE(SAOL_COM:Path)            !List box control field - type derived from field
Loc:Version            LIKE(Loc:Version)              !List box control field - type derived from local data
SAOL_CXI:FechaGeneracion LIKE(SAOL_CXI:FechaGeneracion) !List box control field - type derived from field
SAOL_CXI:HoraGeneracion LIKE(SAOL_CXI:HoraGeneracion) !List box control field - type derived from field
SAOL_CXI:id            LIKE(SAOL_CXI:id)              !Primary key field - type derived from field
SAOL_COM:id            LIKE(SAOL_COM:id)              !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
EnhancedFocusManager EnhancedFocusClassType
QuickWindow          WINDOW('Componentes del Instalador'),AT(,,425,219),FONT('Arial',9,,FONT:bold,CHARSET:ANSI), |
  RESIZE,CENTER,GRAY,IMM,MDI,HLP('AsignarComponentesAInstalador:Browse'),SYSTEM
                       LIST,AT(8,35,409,159),USE(?Browse:1),HVSCROLL,FORMAT('10R|_I@n3@88L(2)|_M~Componente~@s' & |
  '100@153L(2)|_M~Path~S(100)@s255@74R(2)|_M~Versión~C(0)@s20@[40R(2)|_M~Fecha~C(0)@d6b' & |
  '@30R(2)|_M~Hora~C(0)@T4b@]|~Generación~'),FROM(Queue:Browse:1),IMM,VCR
                       BUTTON('&Elegir'),AT(4,201,60,14),USE(?Select:2),MSG('Elegir el registro'),TIP('Elegir el registro')
                       SHEET,AT(4,18,417,180),USE(?CurrentTab)
                         TAB('&Componentes'),USE(?Tab:2)
                         END
                       END
                       BUTTON('Ce&rrar'),AT(295,201,60,14),USE(?Close),MSG('Cerrar la ventana'),TIP('Cerrar la ventana')
                       BUTTON('Ay&uda'),AT(359,201,60,14),USE(?Help),MSG('Ayuda de la aplicación'),STD(STD:Help), |
  TIP('Ayuda de la aplicación')
                       PROMPT('Instalador:'),AT(5,5),USE(?SAOL_INS:Descripcion:Prompt)
                       ENTRY(@s255),AT(43,5,376,10),USE(SAOL_INS:Descripcion),LEFT(2),MSG('Descripcion del Instalador'), |
  READONLY,SKIP,TIP('Descripcion del Instalador')
                     END

                                                           ! BrowseSaveFormats (ABC Free)
SRCF::Procedure EQUATE('SAOL_ComponentesxInstalador:Browse') ! BrowseSaveFormats (ABC Free)
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
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?Browse:1
Q                      &Queue:Browse:1                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
SetQueueRecord         PROCEDURE(),DERIVED
                     END

BRW1::Sort0:StepClass StepClass                            ! Default Step Manager
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
  GlobalErrors.SetProcedureName('SAOL_ComponentesxInstalador:Browse')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Browse:1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('Loc:Version',Loc:Version)                          ! Added by: BrowseBox(ABC)
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:SAOL_ComponentesxInstalador.SetOpenRelated()
  Relate:SAOL_ComponentesxInstalador.Open                  ! File SAOL_ComponentesxInstalador used by this procedure, so make sure it's RelationManager is open
  Access:SAOL_Instaladores.UseFile                         ! File referenced in 'Other Files' so need to inform it's FileManager
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:SAOL_ComponentesxInstalador,SELF) ! Initialize the browse manager
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
    I# = INIMgr.TryFetch(SRCF::Procedure,'SRCF?CurrentTab')
    IF I# = 0
       I# = 1
    END
      SELECT(?CurrentTab,I#) 																              ! BrowseSaveFormats (ABC Free)
      POST(EVENT:NewSelection,?CurrentTab)											      ! BrowseSaveFormats (ABC Free)
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1.AddSortOrder(,)                                     ! Add the sort order for  for sort order 1
  BRW1.AppendOrder('+SAOL_COM:Descripcion,+SAOL_CXI:id')   ! Append an additional sort order
  BRW1.SetFilter('(SAOL_CXI:idInstalador=SAOL_INS:id)')    ! Apply filter expression to browse
  ?Browse:1{PROP:IconList,1} = icon:none
  ?Browse:1{PROP:IconList,2} = '~nopuede.ico'
  ?Browse:1{PROP:IconList,3} = '~todobien.ico'
  BRW1.AddField(SAOL_CXI:Procesar,BRW1.Q.SAOL_CXI:Procesar) ! Field SAOL_CXI:Procesar is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_COM:Descripcion,BRW1.Q.SAOL_COM:Descripcion) ! Field SAOL_COM:Descripcion is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_COM:Path,BRW1.Q.SAOL_COM:Path)        ! Field SAOL_COM:Path is a hot field or requires assignment from browse
  BRW1.AddField(Loc:Version,BRW1.Q.Loc:Version)            ! Field Loc:Version is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_CXI:FechaGeneracion,BRW1.Q.SAOL_CXI:FechaGeneracion) ! Field SAOL_CXI:FechaGeneracion is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_CXI:HoraGeneracion,BRW1.Q.SAOL_CXI:HoraGeneracion) ! Field SAOL_CXI:HoraGeneracion is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_CXI:id,BRW1.Q.SAOL_CXI:id)            ! Field SAOL_CXI:id is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_COM:id,BRW1.Q.SAOL_COM:id)            ! Field SAOL_COM:id is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('SAOL_ComponentesxInstalador:Browse',QuickWindow) ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
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
    Relate:SAOL_ComponentesxInstalador.Close
  END
  IF SELF.Opened
    INIMgr.Update('SAOL_ComponentesxInstalador:Browse',QuickWindow) ! Save window data to non-volatile store
  END
                                                           ! BrowseSaveFormats (ABC Free)
  IF SELF.Opened                                           ! BrowseSaveFormats (ABC Free)
  INIMgr.Update(SRCF::Procedure,'SRCF?Browse:1',?Browse:1{PROP:Format}) ! BrowseSaveFormats (ABC Free)
  INIMgr.Update(SRCF::Procedure,'SRCF?CurrentTab',CHOICE(?CurrentTab)) ! BrowseSaveFormats (ABC Free)
  END                                                      ! BrowseSaveFormats (ABC Free)
  GlobalErrors.SetProcedureName
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


BRW1.SetQueueRecord PROCEDURE

  CODE
  IF SAOL_CXI:Major OR SAOL_CXI:Minor OR SAOL_CXI:Release OR SAOL_CXI:Build
  	Loc:Version = SAOL_CXI:Major & '.' & SAOL_CXI:Minor & '.' & SAOL_CXI:Release & '.' & SAOL_CXI:Build
  ELSE
  	CLEAR(Loc:Version)
  END
  PARENT.SetQueueRecord
  
  IF (SAOL_CXI:Procesar>0)
    SELF.Q.SAOL_CXI:Procesar_Icon = 3                      ! Set icon from icon list
  ELSIF (SAOL_CXI:Procesar=False)
    SELF.Q.SAOL_CXI:Procesar_Icon = 2                      ! Set icon from icon list
  ELSE
    SELF.Q.SAOL_CXI:Procesar_Icon = 1                      ! Set icon from icon list
  END


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window
  SELF.SetStrategy(?SAOL_INS:Descripcion:Prompt, Resize:FixRight+Resize:FixTop, Resize:LockSize) ! Override strategy for ?SAOL_INS:Descripcion:Prompt
  SELF.SetStrategy(?SAOL_INS:Descripcion, Resize:FixRight+Resize:FixTop, Resize:LockSize) ! Override strategy for ?SAOL_INS:Descripcion

