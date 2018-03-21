

   MEMBER('SAOL.clw')                                      ! This is a MEMBER module

! SubClassMain(UNSIGNED,UNSIGNED,UNSIGNED,LONG),LONG,PASCAL ! ABC Free apiSubclass template

   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE
   INCLUDE('MENUStyle.INC'),ONCE

                     MAP
                       INCLUDE('SAOL003.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('SAOL002.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('SAOL006.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('SAOL016.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('SAOL018.INC'),ONCE        !Req'd for module callout resolution
 SubClassMain          (UNSIGNED,UNSIGNED,UNSIGNED,LONG),LONG,PASCAL
                     END


SC::WindowMain     LONG                                    ! ABC Free apiSubclass template
SC::HandleMain     LONG                                    ! ABC Free apiSubclass template

vs_GWL_WndProc      EQUATE(-4)                             ! ABC Free apiSubclass template
!!! <summary>
!!! Generated from procedure template - Frame
!!! SAOL - Sistema de Actualizaciones On-Line
!!! </summary>
Main PROCEDURE 

FrameTitle           CSTRING(128)                          !
OtherPgmHwnd         UNSIGNED                              !Handle=unsigned=hwnd
 COMPILE ('**CW7**',_VER_C70)
MenuStyleMgr MenuStyleManager
!**CW7**
EnhancedFocusManager EnhancedFocusClassType
AppFrame             APPLICATION('Generador de Instaladores - Ingenia Software'),AT(,,505,318),FONT('Arial',9,, |
  FONT:bold,CHARSET:ANSI),RESIZE,CENTER,ICON('SAOL.ICO'),MAX,STATUS(-1,80,120,45),SYSTEM,IMM
                       MENUBAR,USE(?Menubar)
                         MENU('&Archivos'),USE(?FileMenu)
                           ITEM('&Configurar Impresora...'),USE(?PrintSetup),MSG('Configurar Impresora'),STD(STD:PrintSetup)
                           ITEM,USE(?SEPARATOR1),SEPARATOR
                           ITEM('&Salir'),USE(?Exit),MSG('Salir de la Aplicación'),STD(STD:Close)
                         END
                         MENU('&Editar'),USE(?EditMenu)
                           ITEM('&Cortar'),USE(?Cut),MSG('Cortar la selección al clipboard'),STD(STD:Cut)
                           ITEM('C&opiar'),USE(?Copy),MSG('Copiar la selección al clipboard'),STD(STD:Copy)
                           ITEM('&Pegar'),USE(?Paste),MSG('Pegar la selección al clipboard'),STD(STD:Paste)
                         END
                         MENU('Datos Básicos'),USE(?DatosBasicos)
                           ITEM('&Clientes'),USE(?Clientes)
                           ITEM('&Software'),USE(?Software)
                           ITEM('C&omponentes'),USE(?Componentes)
                           ITEM('&Instaladores'),USE(?Instaladores)
                         END
                         MENU('&Ventanas'),USE(?WindowMenu),STD(STD:WindowList)
                           ITEM('&Mosaico'),USE(?Tile),MSG('Apilar las ventanas en Mosaico'),STD(STD:TileWindow)
                           ITEM('C&ascada'),USE(?Cascade),MSG('Apilar las ventanas en cascada'),STD(STD:CascadeWindow)
                           ITEM('Al&inear'),USE(?Arrange),MSG('Alinear las ventanas'),STD(STD:ArrangeIcons)
                         END
                       END
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------
Menu::Menubar ROUTINE                                      ! Code for menu items on ?Menubar
Menu::FileMenu ROUTINE                                     ! Code for menu items on ?FileMenu
Menu::EditMenu ROUTINE                                     ! Code for menu items on ?EditMenu
Menu::DatosBasicos ROUTINE                                 ! Code for menu items on ?DatosBasicos
  CASE ACCEPTED()
  OF ?Clientes
    START(SAOL_Clientes:Browse, 050000)
  OF ?Software
    START(SAOL_Software:Browse, 050000)
  OF ?Componentes
    START(SAOL_Componentes:Browse, 50000)
  OF ?Instaladores
    START(SAOL_Instaladores:Browse, 050000)
  END
Menu::WindowMenu ROUTINE                                   ! Code for menu items on ?WindowMenu

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('Main')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = 1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
    FrameTitle= 'Generador de Instaladores - Ingenia Software'
    OtherPgmHwnd=FindWindow( ,FrameTitle)
    If OtherPgmHwnd then
       If IsIconic(OtherPgmHwnd) then
  !       Message('Ya hay una copia minimizada de esta aplicación!|Presione Ok para activarla.','2 Copias',icon:exclamation,button:ok)
          OpenIcon(OtherPgmHwnd)
          ShowWindow(OtherPgmHwnd,1)
       else
          Message('Ya hay una copia de esta aplicación corriendo!| |Presione Ok para finalizar ESTA COPIA.','2 Copias',icon:exclamation,button:ok)
       end
       Halt()
    end
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.Open(AppFrame)                                      ! Open window
  Do DefineListboxStyle
                                                           ! ABC Free apiSubclass template
  SC::WindowMain=AppFrame{Prop:WndProc}      ! Save address of code that handles window messages
  AppFrame{Prop:WndProc}=ADDRESS(SubClassMain)  ! Re-assign address of code that handles window messages
  INIMgr.Fetch('Main',AppFrame)                            ! Restore window settings from non-volatile store
  SELF.SetAlerts()
  POST(EVENT:Accepted,?Instaladores)
  COMPILE ('**CW7**',_VER_C70)
      AppFrame{PROP:TabBarLocation} = MDITabLocation:Bottom
      AppFrame{PROP:TabBarStyle} = TabStyle:Default
      AppFrame{PROP:TabBarVisible}  = True
      MenuStyleMgr.Init(?Menubar)
      MenuStyleMgr.SuspendRefresh()
      MenuStyleMgr.SetThemeColors('EnergyBlueLight')
      MenuStyleMgr.ApplyTheme()
      MenuStyleMgr.Refresh(TRUE)   
  !**CW7**
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
  IF SELF.Opened                                           ! ABC Free apiSubclass template
     IF SC::WindowMain                                     ! ABC Free apiSubclass template
        AppFrame{Prop:WndProc}=SC::WindowMain ! Restore the handler for this window
     END                                                   ! ABC Free apiSubclass template
  END                                                      ! ABC Free apiSubclass template
  IF SELF.Opened
    INIMgr.Update('Main',AppFrame)                         ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
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
    ELSE
      DO Menu::Menubar                                     ! Process menu items on ?Menubar menu
      DO Menu::FileMenu                                    ! Process menu items on ?FileMenu menu
      DO Menu::EditMenu                                    ! Process menu items on ?EditMenu menu
      DO Menu::DatosBasicos                                ! Process menu items on ?DatosBasicos menu
      DO Menu::WindowMenu                                  ! Process menu items on ?WindowMenu menu
    END
  ReturnValue = PARENT.TakeAccepted()
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

SubClassMain FUNCTION(LOC:hWnd,LOC:usMsg,LOC:WParam,LOC:LParam) ! ABC Free apiSubclass template

LOC:WM_QUERYENDSESSION EQUATE(0011h)                       ! apiSubclass (ABC Free)
LOC:WM_ENDSESSION      EQUATE(0016h)                       ! apiSubclass (ABC Free)
LOC:WM_PAINT           EQUATE(000Fh)                       ! apiSubclass (ABC Free)
LOC:WM_ERASEBKGND      EQUATE(0014h)                       ! apiSubclass (ABC Free)
LOC:WM_HOTKEY          EQUATE(0312H)                       ! apiSubclass (ABC Free)

LOC:SaveResults        UNSIGNED                            ! apiSubclass (ABC Free)
LOC:iParam             LONG,OVER(LOC:LParam)               ! apiSubclass (ABC Free)

    CODE                                                   ! apiSubclass (ABC Free)
    CASE LOC:usMsg                                         ! apiSubclass (ABC Free)
    OF LOC:WM_QUERYENDSESSION                              ! apiSubclass (ABC Free)
      RETURN(True)                                         ! apiSubclass (ABC Free)
    OF LOC:WM_ENDSESSION                                   ! apiSubclass (ABC Free)
      POST(Event:CloseDown)                                ! apiSubclass (ABC Free)
      RETURN(True)                                         ! apiSubclass (ABC Free)
    ! Other Windows Messages can be accessed here
    END                                                    ! apiSubclass (ABC Free)
    RETURN(CallWindowProc(SC::WindowMain,LOC:hWnd,LOC:usMsg,LOC:WParam,LOC:LParam)) ! apiSubclass (ABC Free)


