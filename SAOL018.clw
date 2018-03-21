

   MEMBER('SAOL.clw')                                      ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('SAOL018.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('SAOL019.INC'),ONCE        !Req'd for module callout resolution
                     END


!!! <summary>
!!! Generated from procedure template - Window
!!! Listado de Componentes
!!! </summary>
SAOL_Componentes:Browse PROCEDURE 

CurrentTab           STRING(80)                            !
Loc:Version          STRING(20)                            !
BRW1::View:Browse    VIEW(SAOL_Componentes)
                       PROJECT(SAOL_COM:Descripcion)
                       PROJECT(SAOL_COM:Path)
                       PROJECT(SAOL_COM:FechaGeneracion)
                       PROJECT(SAOL_COM:HoraGeneracion)
                       PROJECT(SAOL_COM:Major)
                       PROJECT(SAOL_COM:Minor)
                       PROJECT(SAOL_COM:Release)
                       PROJECT(SAOL_COM:Build)
                       PROJECT(SAOL_COM:id)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
SAOL_COM:Descripcion   LIKE(SAOL_COM:Descripcion)     !List box control field - type derived from field
SAOL_COM:Path          LIKE(SAOL_COM:Path)            !List box control field - type derived from field
Loc:Version            LIKE(Loc:Version)              !List box control field - type derived from local data
SAOL_COM:FechaGeneracion LIKE(SAOL_COM:FechaGeneracion) !List box control field - type derived from field
SAOL_COM:HoraGeneracion LIKE(SAOL_COM:HoraGeneracion) !List box control field - type derived from field
SAOL_COM:Major         LIKE(SAOL_COM:Major)           !Browse hot field - type derived from field
SAOL_COM:Minor         LIKE(SAOL_COM:Minor)           !Browse hot field - type derived from field
SAOL_COM:Release       LIKE(SAOL_COM:Release)         !Browse hot field - type derived from field
SAOL_COM:Build         LIKE(SAOL_COM:Build)           !Browse hot field - type derived from field
SAOL_COM:id            LIKE(SAOL_COM:id)              !Primary key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
EnhancedFocusManager EnhancedFocusClassType
QuickWindow          WINDOW('Componentes'),AT(,,394,198),FONT('Arial',9,,FONT:bold,CHARSET:ANSI),RESIZE,CENTER, |
  GRAY,IMM,MDI,HLP('VisualizarSAOL_COMPONENTES'),SYSTEM
                       LIST,AT(8,21,378,133),USE(?Browse:1),HVSCROLL,FORMAT('103L(2)|_M~Descripcion~S(100)@s10' & |
  '0@129L(2)|_M~Path~S(100)@s255@60R(2)|_M~Versión~C(0)@s20@[40R(2)|_M~Fecha~C(1)@d6@30' & |
  'R(2)|_M~Hora~C(1)@T4@]|~Generación~'),FROM(Queue:Browse:1),IMM,VCR
                       BUTTON('&Elegir'),AT(198,179,60,14),USE(?Select:2),MSG('Elegir el registro'),TIP('Elegir el registro')
                       SHEET,AT(4,4,387,172),USE(?CurrentTab)
                         TAB('Por Nombre'),USE(?Tab:2)
                           ENTRY(@s100),AT(8,159,124,10),USE(SAOL_COM:Descripcion),LEFT(2),COLOR(COLOR:BTNFACE),READONLY, |
  SKIP
                           BUTTON('&Cambiar'),AT(327,157,60,14),USE(?Change)
                         END
                       END
                       BUTTON('Ce&rrar'),AT(263,179,60,14),USE(?Close),MSG('Cerrar la ventana'),TIP('Cerrar la ventana')
                       BUTTON('Ay&uda'),AT(329,179,60,14),USE(?Help),MSG('Ayuda de la aplicación'),STD(STD:Help), |
  TIP('Ayuda de la aplicación')
                     END

                                                           ! BrowseSaveFormats (ABC Free)
SRCF::Procedure EQUATE('SAOL_Componentes:Browse')          ! BrowseSaveFormats (ABC Free)
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
SetQueueRecord         PROCEDURE(),DERIVED
                     END

BRW1::Sort0:Locator  FilterLocatorClass                    ! Default Locator
BRW1::Sort0:StepClass StepStringClass                      ! Default Step Manager
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
  GlobalErrors.SetProcedureName('SAOL_Componentes:Browse')
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
  Relate:SAOL_Componentes.SetOpenRelated()
  Relate:SAOL_Componentes.Open                             ! File SAOL_Componentes used by this procedure, so make sure it's RelationManager is open
  Access:SAOL_Software.UseFile                             ! File referenced in 'Other Files' so need to inform it's FileManager
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:SAOL_Componentes,SELF) ! Initialize the browse manager
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
  BRW1::Sort0:StepClass.Init(+ScrollSort:AllowAlpha,ScrollBy:Runtime) ! Moveable thumb based upon SAOL_COM:Descripcion for sort order 1
  BRW1.AddSortOrder(BRW1::Sort0:StepClass,SAOL_COM:PorDescripcion) ! Add the sort order for SAOL_COM:PorDescripcion for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(?SAOL_COM:Descripcion,SAOL_COM:Descripcion,1,BRW1) ! Initialize the browse locator using ?SAOL_COM:Descripcion using key: SAOL_COM:PorDescripcion , SAOL_COM:Descripcion
  BRW1::Sort0:Locator.FloatRight = 1
  BRW1.AddField(SAOL_COM:Descripcion,BRW1.Q.SAOL_COM:Descripcion) ! Field SAOL_COM:Descripcion is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_COM:Path,BRW1.Q.SAOL_COM:Path)        ! Field SAOL_COM:Path is a hot field or requires assignment from browse
  BRW1.AddField(Loc:Version,BRW1.Q.Loc:Version)            ! Field Loc:Version is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_COM:FechaGeneracion,BRW1.Q.SAOL_COM:FechaGeneracion) ! Field SAOL_COM:FechaGeneracion is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_COM:HoraGeneracion,BRW1.Q.SAOL_COM:HoraGeneracion) ! Field SAOL_COM:HoraGeneracion is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_COM:Major,BRW1.Q.SAOL_COM:Major)      ! Field SAOL_COM:Major is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_COM:Minor,BRW1.Q.SAOL_COM:Minor)      ! Field SAOL_COM:Minor is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_COM:Release,BRW1.Q.SAOL_COM:Release)  ! Field SAOL_COM:Release is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_COM:Build,BRW1.Q.SAOL_COM:Build)      ! Field SAOL_COM:Build is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_COM:id,BRW1.Q.SAOL_COM:id)            ! Field SAOL_COM:id is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('SAOL_Componentes:Browse',QuickWindow)      ! Restore window settings from non-volatile store
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
    Relate:SAOL_Componentes.Close
  END
  IF SELF.Opened
    INIMgr.Update('SAOL_Componentes:Browse',QuickWindow)   ! Save window data to non-volatile store
  END
                                                           ! BrowseSaveFormats (ABC Free)
  IF SELF.Opened                                           ! BrowseSaveFormats (ABC Free)
  INIMgr.Update(SRCF::Procedure,'SRCF?Browse:1',?Browse:1{PROP:Format}) ! BrowseSaveFormats (ABC Free)
  INIMgr.Update(SRCF::Procedure,'SRCF?CurrentTab',CHOICE(?CurrentTab)) ! BrowseSaveFormats (ABC Free)
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
    SAOL_Componentes:Ficha
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
    SELF.ChangeControl=?Change
  END


BRW1.SetQueueRecord PROCEDURE

  CODE
  IF SAOL_COM:Major OR SAOL_COM:Minor OR SAOL_COM:Release OR SAOL_COM:Build
  	Loc:Version = SAOL_COM:Major & '.' & SAOL_COM:Minor & '.' & SAOL_COM:Release & '.' & SAOL_COM:Build
  ELSE
  	CLEAR(Loc:Version)
  END
  PARENT.SetQueueRecord
  


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

!!! <summary>
!!! Generated from procedure template - Source
!!! </summary>
CleanPath            PROCEDURE  (Path)                     ! Declare Procedure
cPath                CSTRING(FILE:MaxFilePath)
cCleanPath           CSTRING(FILE:MaxFilePath)

  CODE
	cPath      = CLIP(LEFT(Path))
	cCleanPath = ''
	LOOP I# = 1 TO LEN(cPath)
		CASE UPPER(cPath[I#])
			OF '0' TO '9'
				cCleanPath = cCleanPath & cPath[I#]
			OF 'A' TO 'Z'
				cCleanPath = cCleanPath & cPath[I#]
			OF '\'
				cCleanPath = cCleanPath & '\'
			ELSE
				cCleanPath = cCleanPath & '_'
		END			
	END
	RETURN LOWER(cCleanPath)
!!! <summary>
!!! Generated from procedure template - Source
!!! </summary>
GrabarLogFTP         PROCEDURE  (TipoLog,Descripcion,Archivo,Carpeta) ! Declare Procedure

  CODE
	MESSAGE('Error FTP: ' & TipoLog & '|Descripción: ' & Descripcion & | 
		     '|Archivo: ' & Archivo & '|Path: ' & Carpeta,'Atencion !',ICON:HAND)
	RETURN
