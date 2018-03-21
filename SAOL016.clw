

   MEMBER('SAOL.clw')                                      ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('SAOL016.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('SAOL008.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('SAOL015.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('SAOL017.INC'),ONCE        !Req'd for module callout resolution
                     END


!!! <summary>
!!! Generated from procedure template - Window
!!! Instaladores
!!! </summary>
SAOL_Instaladores:Browse PROCEDURE 

VerInhabilitados     BYTE(0)                               !Ver Clientes Inhabilitados
CurrentTab           STRING(80)                            !
Loc:Retorno          BYTE                                  !
Loc:Version          CSTRING(21)                           !
Tag                  STRING(10)                            !
BRW1::View:Browse    VIEW(SAOL_Instaladores)
                       PROJECT(SAOL_INS:Descripcion)
                       PROJECT(SAOL_INS:Referencia)
                       PROJECT(SAOL_INS:CentroEmision)
                       PROJECT(SAOL_INS:GeneradoFecha)
                       PROJECT(SAOL_INS:GeneradoHora)
                       PROJECT(SAOL_INS:PathISS)
                       PROJECT(SAOL_INS:DefaultDirName)
                       PROJECT(SAOL_INS:Contacto)
                       PROJECT(SAOL_INS:Email)
                       PROJECT(SAOL_INS:ReleaseIni)
                       PROJECT(SAOL_INS:Major)
                       PROJECT(SAOL_INS:Minor)
                       PROJECT(SAOL_INS:Release)
                       PROJECT(SAOL_INS:Build)
                       PROJECT(SAOL_INS:Procesar)
                       PROJECT(SAOL_INS:id)
                       PROJECT(SAOL_INS:idSoftwarexCliente)
                       JOIN(SAOL_SXC:PorID,SAOL_INS:idSoftwarexCliente)
                         PROJECT(SAOL_SXC:id)
                         PROJECT(SAOL_SXC:idCliente)
                         JOIN(SAOL_CLI:PorID,SAOL_SXC:idCliente)
                           PROJECT(SAOL_CLI:Nombre)
                           PROJECT(SAOL_CLI:id)
                         END
                       END
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
Tag                    LIKE(Tag)                      !List box control field - type derived from local data
Tag_Icon               LONG                           !Entry's icon ID
SAOL_INS:Descripcion   LIKE(SAOL_INS:Descripcion)     !List box control field - type derived from field
SAOL_INS:Descripcion_Icon LONG                        !Entry's icon ID
SAOL_INS:Referencia    LIKE(SAOL_INS:Referencia)      !List box control field - type derived from field
SAOL_CLI:Nombre        LIKE(SAOL_CLI:Nombre)          !List box control field - type derived from field
SAOL_INS:CentroEmision LIKE(SAOL_INS:CentroEmision)   !List box control field - type derived from field
Loc:Version            LIKE(Loc:Version)              !List box control field - type derived from local data
SAOL_INS:GeneradoFecha LIKE(SAOL_INS:GeneradoFecha)   !List box control field - type derived from field
SAOL_INS:GeneradoHora  LIKE(SAOL_INS:GeneradoHora)    !List box control field - type derived from field
SAOL_INS:PathISS       LIKE(SAOL_INS:PathISS)         !List box control field - type derived from field
SAOL_INS:DefaultDirName LIKE(SAOL_INS:DefaultDirName) !List box control field - type derived from field
SAOL_INS:Contacto      LIKE(SAOL_INS:Contacto)        !List box control field - type derived from field
SAOL_INS:Email         LIKE(SAOL_INS:Email)           !List box control field - type derived from field
SAOL_INS:ReleaseIni    LIKE(SAOL_INS:ReleaseIni)      !List box control field - type derived from field
SAOL_INS:Major         LIKE(SAOL_INS:Major)           !Browse hot field - type derived from field
SAOL_INS:Minor         LIKE(SAOL_INS:Minor)           !Browse hot field - type derived from field
SAOL_INS:Release       LIKE(SAOL_INS:Release)         !Browse hot field - type derived from field
SAOL_INS:Build         LIKE(SAOL_INS:Build)           !Browse hot field - type derived from field
SAOL_INS:Procesar      LIKE(SAOL_INS:Procesar)        !Browse hot field - type derived from field
SAOL_INS:id            LIKE(SAOL_INS:id)              !Primary key field - type derived from field
SAOL_SXC:id            LIKE(SAOL_SXC:id)              !Related join file key field - type derived from field
SAOL_CLI:id            LIKE(SAOL_CLI:id)              !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
EnhancedFocusManager EnhancedFocusClassType
BRW1::NoMoreTagsMsg  STRING('No hay más registros marcados!')
BRW1::IgnoreMouseRight BYTE(False)
BRW1::NoScrollDown   BYTE(False)
QuickWindow          WINDOW('Instaladores'),AT(,,453,198),FONT('Arial',9,,FONT:bold,CHARSET:ANSI),RESIZE,CENTER, |
  GRAY,IMM,MDI,HLP('VisualizarSAOL_INSTALADORES'),SYSTEM
                       LIST,AT(8,20,366,134),USE(?Browse:1),HVSCROLL,FORMAT('14R|_FMI@s10@113L(2)|_FMI~Instala' & |
  'dor~L(18)S(100)@s255@113L(2)|_FM~Referencia~L(0)S(100)@s100@120L(2)|_M~Cliente~S(100' & |
  ')@s100@16C|_M~C.E.~C(0)S(100)@n04b@[40R(2)|_M~Versión~C(0)@s20@40R(2)|_M~Fecha~C(0)@' & |
  'd6b@36R(2)|_M~Hora~C(0)@t4b@]|~Ultima generación~80L(2)|_M~Path ISS~S(100)@s255@1020' & |
  'L(2)|_M~Carpeta de Instalación en el Cliente~S(100)@s255@240L(2)|_M~Contacto~S(100)@' & |
  's60@1020L(2)|_M~Email~S(100)@s255@1020L(2)|_M~INI con info de Versión~S(100)@s255@'),FROM(Queue:Browse:1), |
  IMM,VCR
                       BUTTON('&Elegir'),AT(123,158,60,14),USE(?Select:2),MSG('Elegir el registro'),TIP('Elegir el registro')
                       BUTTON('&Agregar'),AT(186,158,60,14),USE(?Insert:4),MSG('Agregar un registro'),TIP('Agregar un registro')
                       BUTTON('&Cambiar'),AT(250,158,60,14),USE(?Change:4),DEFAULT,MSG('Cambiar un registro'),TIP('Cambiar un registro')
                       BUTTON('&Borrar'),AT(314,158,60,14),USE(?Delete:4),MSG('Borrar el registro'),TIP('Borrar el registro')
                       SHEET,AT(4,4,375,172),USE(?CurrentTab)
                         TAB('&Por Instalador'),USE(?Tab:2)
                           ENTRY(@s255),AT(8,160,111,10),USE(SAOL_INS:Descripcion),COLOR(COLOR:BTNFACE),MSG('Descripcio' & |
  'n del Instalador'),READONLY,SKIP,TIP('Descripcion del Instalador')
                         END
                         TAB('Por Cliente'),USE(?TAB1)
                         END
                       END
                       BUTTON('&Generar Instaladores'),AT(4,180,90),USE(?GenerarInstaladores)
                       BUTTON('Com&ponentes'),AT(98,180,60),USE(?Componentes)
                       BUTTON('Ce&rrar'),AT(325,179,60,14),USE(?Close),MSG('Cerrar la ventana'),TIP('Cerrar la ventana')
                       BUTTON('Ay&uda'),AT(389,179,60,14),USE(?Help),MSG('Ayuda de la aplicación'),STD(STD:Help), |
  TIP('Ayuda de la aplicación')
                       BUTTON('&Marcar'),AT(381,17,68,14),USE(?TagOne),MSG('Marca el registro seleccionado'),TIP('Marca el r' & |
  'egistro seleccionado')
                       BUTTON('&Desmarcar'),AT(381,34,68,14),USE(?UntagOne),MSG('Desmarca el registro seleccionado'), |
  TIP('Desmarca el registro seleccionado')
                       BUTTON('&Invertir'),AT(381,101,68,14),USE(?FlipOne),MSG('Invierte la marca'),TIP('Invierte la marca')
                       BUTTON('Marcar &Todo'),AT(381,57,68,14),USE(?TagAll),MSG('Marca todos los registros'),TIP('Marca todo' & |
  's los registros')
                       BUTTON('Desmarcar T&odo'),AT(381,74,68,14),USE(?UntagAll),MSG('Desmarca todos los registros'), |
  TIP('Desmarca todos los registros')
                       BUTTON('In&vertir Todo'),AT(381,118,68),USE(?FlipAll),MSG('Invierte todas las marcas'),TIP('Invierte t' & |
  'odas las marcas')
                       BUTTON('Marca A&nterior'),AT(381,144,68,14),USE(?PrevTag),MSG('Retrocede hasta la marca anterior'), |
  TIP('Retrocede hasta la marca anterior')
                       BUTTON('Marca &Siguiente'),AT(381,161,68,14),USE(?NextTag),MSG('Avanza a la siguiente marca'), |
  TIP('Avanza a la siguiente marca')
                       CHECK('Ver Inhabilitados'),AT(167,180,67,14),USE(VerInhabilitados),TIP('Ver Clientes In' & |
  'habilitados'),VALUE('1','0')
                     END

                                                           ! BrowseSaveFormats (ABC Free)
SRCF::Procedure EQUATE('SAOL_Instaladores:Browse')         ! BrowseSaveFormats (ABC Free)
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
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?Browse:1
Q                      &Queue:Browse:1                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
ResetQueue             PROCEDURE(BYTE ResetMode),DERIVED
ResetSort              PROCEDURE(BYTE Force),BYTE,PROC,DERIVED
SetQueueRecord         PROCEDURE(),DERIVED
TakeNewSelection       PROCEDURE(),DERIVED
UpdateWindow           PROCEDURE(),DERIVED
                     END

BRW1::Sort0:Locator  FilterLocatorClass                    ! Default Locator
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
VerSiHayMarcas      ROUTINE
	IF RECORDS(Queue:Browse:1)
	   Hubo# = FALSE
	   LOOP I# = 1 TO RECORDS(Queue:Browse:1)
		   GET(Queue:Browse:1,I#)
		   IF Queue:Browse:1.Tag
			   Hubo# = TRUE
			   BREAK
		   END
	   END
	   IF Hubo#
		   ENABLE(?GenerarInstaladores)
	   ELSE
		   DISABLE(?GenerarInstaladores)
	   END	
	ELSE
	   DISABLE(?GenerarInstaladores)
	END
	EXIT
!--------------------------------------
BRW1::TagOne ROUTINE
  IF ~SAOL_INS:Procesar
    SAOL_INS:Procesar = True
    PUT(SAOL_Instaladores)
  END!IF
  Tag = '*'
  DO BRW1::AfterSingleTag
!--------------------------------------
BRW1::UntagOne ROUTINE
  IF SAOL_INS:Procesar
    CLEAR(SAOL_INS:Procesar)
    PUT(SAOL_Instaladores)
  END!IF
  CLEAR(Tag)
  DO BRW1::AfterSingleTag
!--------------------------------------
BRW1::TagAll ROUTINE
  SETCURSOR(CURSOR:Wait)
  LOCK(SAOL_Instaladores,1)
  STREAM(SAOL_Instaladores)
  BRW1.Reset
  LOOP UNTIL BRW1.Next()
    YIELD# += 1; IF ~YIELD# % 10 THEN YIELD.
    IF ~SAOL_INS:Procesar
      SAOL_INS:Procesar = True
      PUT(SAOL_Instaladores)
    END!IF
  END!LOOP
  FLUSH(SAOL_Instaladores)
  UNLOCK(SAOL_Instaladores)
  SETCURSOR
  BRW1.ResetQueue(RESET:Queue)
  SELECT(?Browse:1,CHOICE(?Browse:1))
  IF RECORDS(Queue:Browse:1)
     ENABLE(?GenerarInstaladores)
  ELSE
     DISABLE(?GenerarInstaladores)
  END
!--------------------------------------
BRW1::UntagAll ROUTINE
  SETCURSOR(CURSOR:Wait)
  LOCK(SAOL_Instaladores,1)
  STREAM(SAOL_Instaladores)
  BRW1.Reset
  LOOP UNTIL BRW1.Next()
    YIELD# += 1; IF ~YIELD# % 10 THEN YIELD.
    IF SAOL_INS:Procesar
      CLEAR(SAOL_INS:Procesar)
      PUT(SAOL_Instaladores)
    END!IF
  END!LOOP
  FLUSH(SAOL_Instaladores)
  UNLOCK(SAOL_Instaladores)
  SETCURSOR
  Tag = ''
  BRW1.ResetQueue(RESET:Queue)
  SELECT(?Browse:1,CHOICE(?Browse:1))
  DISABLE(?GenerarInstaladores)
!--------------------------------------
BRW1::FlipAll ROUTINE
  SETCURSOR(CURSOR:Wait)
  LOCK(SAOL_Instaladores,1)
  STREAM(SAOL_Instaladores)
  BRW1.Reset
  LOOP UNTIL BRW1.Next()
    YIELD# += 1; IF ~YIELD# % 10 THEN YIELD.
    IF SAOL_INS:Procesar
      SAOL_INS:Procesar = ''
    ELSE
      SAOL_INS:Procesar = True
    END!IF
    PUT(SAOL_Instaladores)
  END!LOOP
  FLUSH(SAOL_Instaladores)
  UNLOCK(SAOL_Instaladores)
  SETCURSOR
  BRW1.ResetQueue(RESET:Queue)
  SELECT(?Browse:1,CHOICE(?Browse:1))
  DO VerSiHayMarcas
!--------------------------------------
BRW1::PrevTag ROUTINE
  IF KEYCODE() = MouseRight
    BRW1::IgnoreMouseRight = True
  END!IF
  SETCURSOR(CURSOR:Wait)
  RESET(BRW1.View, Queue:Browse:1.ViewPosition)
  IF BRW1.Previous().
  LOOP
    YIELD# += 1; IF ~YIELD# % 10 THEN YIELD.
    IF BRW1.Previous()
      MESSAGE(BRW1::NoMoreTagsMsg,,ICON:Exclamation)
      SELECT(?Browse:1)
      BRW1::IgnoreMouseRight = False
      BREAK
    END!IF
    IF SAOL_INS:Procesar
      BRW1.ResetFromFile
      BRW1.PostNewSelection
      ThisWindow.Reset
      BREAK
    END!IF
  END!LOOP
  SETCURSOR
!--------------------------------------
BRW1::NextTag ROUTINE
  IF KEYCODE() = MouseRight
    BRW1::IgnoreMouseRight = True
  END!IF
  SETCURSOR(CURSOR:Wait)
  RESET(BRW1.View, Queue:Browse:1.ViewPosition)
  IF BRW1.Next().
  LOOP
    YIELD# += 1; IF ~YIELD# % 10 THEN YIELD.
    IF BRW1.Next()
      MESSAGE(BRW1::NoMoreTagsMsg,,ICON:Exclamation)
      SELECT(?Browse:1,CHOICE(?Browse:1))
      BRW1::IgnoreMouseRight = False
      BREAK
    END!IF
    IF SAOL_INS:Procesar
      BRW1.ResetFromFile
      BRW1.PostNewSelection
      ThisWindow.Reset
      BREAK
    END!IF
  END!LOOP
  SETCURSOR
!--------------------------------------
BRW1::FlipOne ROUTINE
  IF SAOL_INS:Procesar
    SAOL_INS:Procesar = ''
  ELSE
    SAOL_INS:Procesar = True
  END!IF
  PUT(SAOL_Instaladores)
  IF Queue:Browse:1.Tag
    CLEAR(Tag)
  ELSE
    Tag = '*'
  END!IF
  DO BRW1::AfterSingleTag
!--------------------------------------
BRW1::AfterSingleTag ROUTINE
  IF Tag
    Queue:Browse:1.Tag_Icon = 1
  ELSE
    Queue:Browse:1.Tag_Icon = 2
  END!IF
  Queue:Browse:1.Tag = Tag
  PUT(Queue:Browse:1)
  ASSERT(~ERRORCODE())
  SELECT(?Browse:1,CHOICE(?Browse:1))
  IF BRW1::NoScrollDown
    BRW1::NoScrollDown = False
  ELSIF KEYCODE() <> MouseRight
    POST(EVENT:ScrollDown,?Browse:1)
  END!IF
!--------------------------------------
BRW1::MouseLeftFlipTag ROUTINE
  DATA
BRW1::Ctl SHORT,AUTO
  CODE
  IF  KEYCODE() = MouseLeft AND ?Browse:1{PROP:Visible}  |
  AND INRANGE(MOUSEX(), ?Browse:1{PROP:XPos}, ?Browse:1{PROP:XPos} + ?Browse:1{PROP:Width} - 1)  |
  AND INRANGE(MOUSEY(), ?Browse:1{PROP:YPos}, ?Browse:1{PROP:YPos} + ?Browse:1{PROP:Height}  |
                                     - CHOOSE(?Browse:1{PROP:HScroll} OR ?Browse:1{PROP:VCR},9,1))  |
  AND ?Browse:1{PROPLIST:MouseDownRow} > 0 AND ?Browse:1{PROPLIST:MouseDownZone} <> LISTZONE:Right  |
  AND ?Browse:1{PROPLIST:MouseDownField} = 1
    BRW1::Ctl = ?Browse:1
    LOOP WHILE BRW1::Ctl
      IF BRW1::Ctl{PROP:Disable} THEN EXIT.
      BRW1::Ctl = BRW1::Ctl{PROP:Parent}
    END!LOOP
    BRW1.UpdateViewRecord
    BRW1::NoScrollDown = True
    DO BRW1::FlipOne
  END!IF

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('SAOL_Instaladores:Browse')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Browse:1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('Tag',Tag)                                          ! Added by: BrowseBox(ABC)
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
  Access:SAOL_Log.UseFile                                  ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:SAOL_ComponentesxInstalador.UseFile               ! File referenced in 'Other Files' so need to inform it's FileManager
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:SAOL_Instaladores,SELF) ! Initialize the browse manager
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
  QuickWindow{PROP:Alrt,255} = MouseLeft
  ?Browse:1{PROPLIST:Resize,1}             = ''
  ?Browse:1{PROPLIST:Width,1}              = 18
  ?Browse:1{PROPLIST:Left,1}               = 1
  ?Browse:1{PROPLIST:LeftOffset,1}         = 18
  ?Browse:1{PROPLIST:Icon,1}               = 1
  BRW1.Q &= Queue:Browse:1
  BRW1.FileLoaded = 1                                      ! This is a 'file loaded' browse
  BRW1.AddSortOrder(,)                                     ! Add the sort order for  for sort order 1
  BRW1.AppendOrder('+SAOL_CLI:Nombre')                     ! Append an additional sort order
  BRW1.SetFilter('(SAOL_INS:Estado = 1)')                  ! Apply filter expression to browse
  BRW1.AddSortOrder(,SAOL_INS:PorDescripcion)              ! Add the sort order for SAOL_INS:PorDescripcion for sort order 2
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 2
  BRW1::Sort0:Locator.Init(?SAOL_INS:Descripcion,SAOL_INS:Descripcion,1,BRW1) ! Initialize the browse locator using ?SAOL_INS:Descripcion using key: SAOL_INS:PorDescripcion , SAOL_INS:Descripcion
  BRW1::Sort0:Locator.FloatRight = 1
  BRW1.SetFilter('(SAOL_INS:Estado = 1)')                  ! Apply filter expression to browse
  ?Browse:1{PROP:IconList,1} = '~BOXBBOX.ICO'
  ?Browse:1{PROP:IconList,2} = '~BOXEMPTY.ICO'
  ?Browse:1{PROP:IconList,3} = ICON:None
  ?Browse:1{PROP:IconList,4} = '~nok.ico'
  ?Browse:1{PROP:IconList,5} = '~nosepuede.ico'
  BRW1.AddField(Tag,BRW1.Q.Tag)                            ! Field Tag is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_INS:Descripcion,BRW1.Q.SAOL_INS:Descripcion) ! Field SAOL_INS:Descripcion is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_INS:Referencia,BRW1.Q.SAOL_INS:Referencia) ! Field SAOL_INS:Referencia is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_CLI:Nombre,BRW1.Q.SAOL_CLI:Nombre)    ! Field SAOL_CLI:Nombre is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_INS:CentroEmision,BRW1.Q.SAOL_INS:CentroEmision) ! Field SAOL_INS:CentroEmision is a hot field or requires assignment from browse
  BRW1.AddField(Loc:Version,BRW1.Q.Loc:Version)            ! Field Loc:Version is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_INS:GeneradoFecha,BRW1.Q.SAOL_INS:GeneradoFecha) ! Field SAOL_INS:GeneradoFecha is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_INS:GeneradoHora,BRW1.Q.SAOL_INS:GeneradoHora) ! Field SAOL_INS:GeneradoHora is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_INS:PathISS,BRW1.Q.SAOL_INS:PathISS)  ! Field SAOL_INS:PathISS is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_INS:DefaultDirName,BRW1.Q.SAOL_INS:DefaultDirName) ! Field SAOL_INS:DefaultDirName is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_INS:Contacto,BRW1.Q.SAOL_INS:Contacto) ! Field SAOL_INS:Contacto is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_INS:Email,BRW1.Q.SAOL_INS:Email)      ! Field SAOL_INS:Email is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_INS:ReleaseIni,BRW1.Q.SAOL_INS:ReleaseIni) ! Field SAOL_INS:ReleaseIni is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_INS:Major,BRW1.Q.SAOL_INS:Major)      ! Field SAOL_INS:Major is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_INS:Minor,BRW1.Q.SAOL_INS:Minor)      ! Field SAOL_INS:Minor is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_INS:Release,BRW1.Q.SAOL_INS:Release)  ! Field SAOL_INS:Release is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_INS:Build,BRW1.Q.SAOL_INS:Build)      ! Field SAOL_INS:Build is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_INS:Procesar,BRW1.Q.SAOL_INS:Procesar) ! Field SAOL_INS:Procesar is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_INS:id,BRW1.Q.SAOL_INS:id)            ! Field SAOL_INS:id is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_SXC:id,BRW1.Q.SAOL_SXC:id)            ! Field SAOL_SXC:id is a hot field or requires assignment from browse
  BRW1.AddField(SAOL_CLI:id,BRW1.Q.SAOL_CLI:id)            ! Field SAOL_CLI:id is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('SAOL_Instaladores:Browse',QuickWindow)     ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW1.AskProcedure = 1
  ?Browse:1{PROP:LineHeight} = 14
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  BRW1.ToolbarItem.HelpButton = ?Help
  SELF.SetAlerts()
  BRW1.Popup.SetLevel(BRW1.Popup.AddItem('-', 'STAG::Separator1'),1)
  BRW1.Popup.SetLevel(BRW1.Popup.AddItemMimic('TagOne', ?TagOne),1)
  BRW1.Popup.SetLevel(BRW1.Popup.AddItemMimic('UntagOne', ?UntagOne),1)
  BRW1.Popup.SetLevel(BRW1.Popup.AddItemMimic('FlipOne', ?FlipOne),1)
  BRW1.Popup.SetLevel(BRW1.Popup.AddItem('-', 'STAG::Separator2'),1)
  BRW1.Popup.SetLevel(BRW1.Popup.AddItemMimic('TagAll', ?TagAll),1)
  BRW1.Popup.SetLevel(BRW1.Popup.AddItemMimic('UntagAll', ?UntagAll),1)
  BRW1.Popup.SetLevel(BRW1.Popup.AddItemMimic('FlipAll', ?FlipAll),1)
  BRW1.Popup.SetLevel(BRW1.Popup.AddItem('-', 'STAG::Separator3'),1)
  BRW1.Popup.SetLevel(BRW1.Popup.AddItemMimic('PrevTag', ?PrevTag),1)
  BRW1.Popup.SetLevel(BRW1.Popup.AddItemMimic('NextTag', ?NextTag),1)
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
    INIMgr.Update('SAOL_Instaladores:Browse',QuickWindow)  ! Save window data to non-volatile store
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
    SAOL_Instaladores:Ficha
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
    CASE ACCEPTED()
    OF ?VerInhabilitados
      LOOP I# = 1 TO 2
      	BRW1.SetSort(I#)
      	IF VerInhabilitados
      		BRW1.SetFilter('')
      	ELSE
      		BRW1.SetFilter('(SAOL_INS:Estado = 1)')
      	END
      END
      BRW1.ResetSort(False)
      BRW1.ApplyFilter()
      ThisWindow.Reset(1)
      SELECT(?Browse:1)
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?GenerarInstaladores
      ThisWindow.Update
      Loc:Retorno = GenerarInstaladores(0)
      ThisWindow.Reset
      	ThisWindow.Reset(1)
      	SELECT(?Browse:1)     
    OF ?Componentes
      ThisWindow.Update
      SAOL_ComponentesxInstalador:Browse()
      ThisWindow.Reset
      SELECT(?Browse:1)
    OF ?TagOne
      ThisWindow.Update
      DO BRW1::TagOne
    OF ?UntagOne
      ThisWindow.Update
      DO BRW1::UntagOne
    OF ?FlipOne
      ThisWindow.Update
      DO BRW1::FlipOne
    OF ?TagAll
      ThisWindow.Update
      DO BRW1::TagAll
    OF ?UntagAll
      ThisWindow.Update
      DO BRW1::UntagAll
    OF ?FlipAll
      ThisWindow.Update
      DO BRW1::FlipAll
    OF ?PrevTag
      ThisWindow.Update
      DO BRW1::PrevTag
    OF ?NextTag
      ThisWindow.Update
      DO BRW1::NextTag
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
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
      DO BRW1::MouseLeftFlipTag
    OF EVENT:PreAlertKey
      IF KEYCODE()=MouseLeft THEN CYCLE.
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


BRW1.ResetQueue PROCEDURE(BYTE ResetMode)

  CODE
  PARENT.ResetQueue(ResetMode)
  IF RECORDS(SELF.ListQueue)
    ?TagOne{PROP:Disable} = 0
    ?UntagOne{PROP:Disable} = 0
    ?FlipOne{PROP:Disable} = 0
    ?TagAll{PROP:Disable} = 0
    ?UntagAll{PROP:Disable} = 0
    ?FlipAll{PROP:Disable} = 0
    ?PrevTag{PROP:Disable} = 0
    ?NextTag{PROP:Disable} = 0
  ELSE
    ?TagOne{PROP:Disable} = 1
    ?UntagOne{PROP:Disable} = 1
    ?FlipOne{PROP:Disable} = 1
    ?TagAll{PROP:Disable} = 1
    ?UntagAll{PROP:Disable} = 1
    ?FlipAll{PROP:Disable} = 1
    ?PrevTag{PROP:Disable} = 1
    ?NextTag{PROP:Disable} = 1
  END


BRW1.ResetSort PROCEDURE(BYTE Force)

ReturnValue          BYTE,AUTO

  CODE
  IF CHOICE(?CurrentTab) = 2
    RETURN SELF.SetSort(1,Force)
  ELSE
    RETURN SELF.SetSort(2,Force)
  END
  ReturnValue = PARENT.ResetSort(Force)
  RETURN ReturnValue


BRW1.SetQueueRecord PROCEDURE

  CODE
  Tag = CHOOSE(~SAOL_INS:Procesar, '', '*')
  SELF.Q.Tag = Tag
  IF SAOL_INS:Major OR SAOL_INS:Minor OR SAOL_INS:Release OR SAOL_INS:Build
  	Loc:Version = SAOL_INS:Major & '.' & SAOL_INS:Minor & '.' & SAOL_INS:Release & '.' & SAOL_INS:Build
  ELSE
  	CLEAR(Loc:Version)
  END
  PARENT.SetQueueRecord
  
  SELF.Q.Tag_Icon = 0
  IF (SAOL_INS:Estado = 0)
    SELF.Q.SAOL_INS:Descripcion_Icon = 5                   ! Set icon from icon list
  ELSIF (SAOL_INS:Estado = 9)
    SELF.Q.SAOL_INS:Descripcion_Icon = 4                   ! Set icon from icon list
  ELSE
    SELF.Q.SAOL_INS:Descripcion_Icon = 3                   ! Set icon from icon list
  END
  IF Tag
    Queue:Browse:1.Tag_Icon = 1
  ELSE
    Queue:Browse:1.Tag_Icon = 2
  END!IF


BRW1.TakeNewSelection PROCEDURE

  CODE
  IF BRW1::IgnoreMouseRight
    BRW1::IgnoreMouseRight = False
    SETKEYCODE(MouseLeft)
  END!IF
  PARENT.TakeNewSelection


BRW1.UpdateWindow PROCEDURE

  CODE
  PARENT.UpdateWindow
  	IF SELF.Records()
  		ENABLE(?Componentes)
  		DO VerSiHayMarcas
  	ELSE
  		DISABLE(?Componentes)
  		DISABLE(?GenerarInstaladores)
  	END


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window
  SELF.SetStrategy(?SAOL_INS:Descripcion, Resize:FixLeft+Resize:FixBottom, Resize:LockSize) ! Override strategy for ?SAOL_INS:Descripcion
  SELF.SetStrategy(?TagOne, Resize:FixRight+Resize:FixTop, Resize:LockSize) ! Override strategy for ?TagOne
  SELF.SetStrategy(?UntagOne, Resize:FixRight+Resize:FixTop, Resize:LockSize) ! Override strategy for ?UntagOne
  SELF.SetStrategy(?FlipOne, Resize:FixRight+Resize:FixTop, Resize:LockSize) ! Override strategy for ?FlipOne
  SELF.SetStrategy(?TagAll, Resize:FixRight+Resize:FixTop, Resize:LockSize) ! Override strategy for ?TagAll
  SELF.SetStrategy(?UntagAll, Resize:FixRight+Resize:FixTop, Resize:LockSize) ! Override strategy for ?UntagAll
  SELF.SetStrategy(?FlipAll, Resize:FixRight+Resize:FixTop, Resize:LockSize) ! Override strategy for ?FlipAll
  SELF.SetStrategy(?PrevTag, Resize:FixRight+Resize:FixTop, Resize:LockSize) ! Override strategy for ?PrevTag
  SELF.SetStrategy(?NextTag, Resize:FixRight+Resize:FixTop, Resize:LockSize) ! Override strategy for ?NextTag
  SELF.SetStrategy(?GenerarInstaladores, Resize:FixLeft+Resize:FixBottom, Resize:LockSize) ! Override strategy for ?GenerarInstaladores
  SELF.SetStrategy(?VerInhabilitados, Resize:FixLeft+Resize:FixBottom, Resize:LockSize) ! Override strategy for ?VerInhabilitados

