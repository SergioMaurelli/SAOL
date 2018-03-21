  MEMBER('SAOL.clw')

  INCLUDE('ABFILE.INC'),ONCE

  MAP
SAOL_BC0:DctInit    PROCEDURE
SAOL_BC0:DctKill    PROCEDURE
SAOL_BC0:FilesInit  PROCEDURE
  END

Hide:Access:SAOL_Clientes CLASS(FileManager),TYPE          ! FileManager for SAOL_Clientes
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
ValidateFieldServer    PROCEDURE(UNSIGNED Id,BYTE HandleErrors),BYTE,PROC,DERIVED
                     END


Hide:Relate:SAOL_Clientes CLASS(RelationManager),TYPE      ! RelationManager for SAOL_Clientes
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:SAOL_Instaladores CLASS(FileManager),TYPE      ! FileManager for SAOL_Instaladores
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
ValidateFieldServer    PROCEDURE(UNSIGNED Id,BYTE HandleErrors),BYTE,PROC,DERIVED
                     END


Hide:Relate:SAOL_Instaladores CLASS(RelationManager),TYPE  ! RelationManager for SAOL_Instaladores
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:FTP_RemoteSite CLASS(FileManager),TYPE         ! FileManager for FTP_RemoteSite
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
PrimeFields            PROCEDURE(),PROC,DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:FTP_RemoteSite CLASS(RelationManager),TYPE     ! RelationManager for FTP_RemoteSite
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:FTP_ScheduledTransfer CLASS(FileManager),TYPE  ! FileManager for FTP_ScheduledTransfer
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
PrimeFields            PROCEDURE(),PROC,DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
ValidateFieldServer    PROCEDURE(UNSIGNED Id,BYTE HandleErrors),BYTE,PROC,DERIVED
                     END


Hide:Relate:FTP_ScheduledTransfer CLASS(RelationManager),TYPE ! RelationManager for FTP_ScheduledTransfer
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:FTP_TransferItem CLASS(FileManager),TYPE       ! FileManager for FTP_TransferItem
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
ValidateFieldServer    PROCEDURE(UNSIGNED Id,BYTE HandleErrors),BYTE,PROC,DERIVED
                     END


Hide:Relate:FTP_TransferItem CLASS(RelationManager),TYPE   ! RelationManager for FTP_TransferItem
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:FTP_RemoteFolder CLASS(FileManager),TYPE       ! FileManager for FTP_RemoteFolder
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:FTP_RemoteFolder CLASS(RelationManager),TYPE   ! RelationManager for FTP_RemoteFolder
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:FTP_TransferLog CLASS(FileManager),TYPE        ! FileManager for FTP_TransferLog
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
ValidateFieldServer    PROCEDURE(UNSIGNED Id,BYTE HandleErrors),BYTE,PROC,DERIVED
                     END


Hide:Relate:FTP_TransferLog CLASS(RelationManager),TYPE    ! RelationManager for FTP_TransferLog
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:FTP_TransferSet CLASS(FileManager),TYPE        ! FileManager for FTP_TransferSet
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:FTP_TransferSet CLASS(RelationManager),TYPE    ! RelationManager for FTP_TransferSet
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:FTP_Transfer CLASS(FileManager),TYPE           ! FileManager for FTP_Transfer
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
ValidateFieldServer    PROCEDURE(UNSIGNED Id,BYTE HandleErrors),BYTE,PROC,DERIVED
                     END


Hide:Relate:FTP_Transfer CLASS(RelationManager),TYPE       ! RelationManager for FTP_Transfer
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:FTP_ItemxTransferSet CLASS(FileManager),TYPE   ! FileManager for FTP_ItemxTransferSet
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:FTP_ItemxTransferSet CLASS(RelationManager),TYPE ! RelationManager for FTP_ItemxTransferSet
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:SAOL_SoftwarexCliente CLASS(FileManager),TYPE  ! FileManager for SAOL_SoftwarexCliente
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:SAOL_SoftwarexCliente CLASS(RelationManager),TYPE ! RelationManager for SAOL_SoftwarexCliente
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:SAOL_ComponentesxInstalador CLASS(FileManager),TYPE ! FileManager for SAOL_ComponentesxInstalador
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:SAOL_ComponentesxInstalador CLASS(RelationManager),TYPE ! RelationManager for SAOL_ComponentesxInstalador
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:SAOL_Componentes CLASS(FileManager),TYPE       ! FileManager for SAOL_Componentes
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:SAOL_Componentes CLASS(RelationManager),TYPE   ! RelationManager for SAOL_Componentes
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:SAOL_Software CLASS(FileManager),TYPE          ! FileManager for SAOL_Software
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:SAOL_Software CLASS(RelationManager),TYPE      ! RelationManager for SAOL_Software
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:TagSet_  CLASS(FileManager),TYPE               ! FileManager for TagSet_
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:TagSet_  CLASS(RelationManager),TYPE           ! RelationManager for TagSet_
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:TagFile_ CLASS(FileManager),TYPE               ! FileManager for TagFile_
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:TagFile_ CLASS(RelationManager),TYPE           ! RelationManager for TagFile_
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:TagFilePos_ CLASS(FileManager),TYPE            ! FileManager for TagFilePos_
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:TagFilePos_ CLASS(RelationManager),TYPE        ! RelationManager for TagFilePos_
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:SAOL_FTP_Release CLASS(FileManager),TYPE       ! FileManager for SAOL_FTP_Release
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:SAOL_FTP_Release CLASS(RelationManager),TYPE   ! RelationManager for SAOL_FTP_Release
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:SAOL_FTP_Componentes CLASS(FileManager),TYPE   ! FileManager for SAOL_FTP_Componentes
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:SAOL_FTP_Componentes CLASS(RelationManager),TYPE ! RelationManager for SAOL_FTP_Componentes
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:SAOL_Passcode CLASS(FileManager),TYPE          ! FileManager for SAOL_Passcode
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
ValidateFieldServer    PROCEDURE(UNSIGNED Id,BYTE HandleErrors),BYTE,PROC,DERIVED
                     END


Hide:Relate:SAOL_Passcode CLASS(RelationManager),TYPE      ! RelationManager for SAOL_Passcode
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END


_Hide:Access:SAOL_Clientes &Hide:Access:SAOL_Clientes,AUTO,THREAD
_Hide:Relate:SAOL_Clientes &Hide:Relate:SAOL_Clientes,AUTO,THREAD
_Hide:Access:SAOL_Instaladores &Hide:Access:SAOL_Instaladores,AUTO,THREAD
_Hide:Relate:SAOL_Instaladores &Hide:Relate:SAOL_Instaladores,AUTO,THREAD
_Hide:Access:FTP_RemoteSite &Hide:Access:FTP_RemoteSite,AUTO,THREAD
_Hide:Relate:FTP_RemoteSite &Hide:Relate:FTP_RemoteSite,AUTO,THREAD
_Hide:Access:FTP_ScheduledTransfer &Hide:Access:FTP_ScheduledTransfer,AUTO,THREAD
_Hide:Relate:FTP_ScheduledTransfer &Hide:Relate:FTP_ScheduledTransfer,AUTO,THREAD
_Hide:Access:FTP_TransferItem &Hide:Access:FTP_TransferItem,AUTO,THREAD
_Hide:Relate:FTP_TransferItem &Hide:Relate:FTP_TransferItem,AUTO,THREAD
_Hide:Access:FTP_RemoteFolder &Hide:Access:FTP_RemoteFolder,AUTO,THREAD
_Hide:Relate:FTP_RemoteFolder &Hide:Relate:FTP_RemoteFolder,AUTO,THREAD
_Hide:Access:FTP_TransferLog &Hide:Access:FTP_TransferLog,AUTO,THREAD
_Hide:Relate:FTP_TransferLog &Hide:Relate:FTP_TransferLog,AUTO,THREAD
_Hide:Access:FTP_TransferSet &Hide:Access:FTP_TransferSet,AUTO,THREAD
_Hide:Relate:FTP_TransferSet &Hide:Relate:FTP_TransferSet,AUTO,THREAD
_Hide:Access:FTP_Transfer &Hide:Access:FTP_Transfer,AUTO,THREAD
_Hide:Relate:FTP_Transfer &Hide:Relate:FTP_Transfer,AUTO,THREAD
_Hide:Access:FTP_ItemxTransferSet &Hide:Access:FTP_ItemxTransferSet,AUTO,THREAD
_Hide:Relate:FTP_ItemxTransferSet &Hide:Relate:FTP_ItemxTransferSet,AUTO,THREAD
_Hide:Access:SAOL_SoftwarexCliente &Hide:Access:SAOL_SoftwarexCliente,AUTO,THREAD
_Hide:Relate:SAOL_SoftwarexCliente &Hide:Relate:SAOL_SoftwarexCliente,AUTO,THREAD
_Hide:Access:SAOL_ComponentesxInstalador &Hide:Access:SAOL_ComponentesxInstalador,AUTO,THREAD
_Hide:Relate:SAOL_ComponentesxInstalador &Hide:Relate:SAOL_ComponentesxInstalador,AUTO,THREAD
_Hide:Access:SAOL_Componentes &Hide:Access:SAOL_Componentes,AUTO,THREAD
_Hide:Relate:SAOL_Componentes &Hide:Relate:SAOL_Componentes,AUTO,THREAD
_Hide:Access:SAOL_Software &Hide:Access:SAOL_Software,AUTO,THREAD
_Hide:Relate:SAOL_Software &Hide:Relate:SAOL_Software,AUTO,THREAD
_Hide:Access:TagSet_ &Hide:Access:TagSet_,AUTO,THREAD
_Hide:Relate:TagSet_ &Hide:Relate:TagSet_,AUTO,THREAD
_Hide:Access:TagFile_ &Hide:Access:TagFile_,AUTO,THREAD
_Hide:Relate:TagFile_ &Hide:Relate:TagFile_,AUTO,THREAD
_Hide:Access:TagFilePos_ &Hide:Access:TagFilePos_,AUTO,THREAD
_Hide:Relate:TagFilePos_ &Hide:Relate:TagFilePos_,AUTO,THREAD
_Hide:Access:SAOL_FTP_Release &Hide:Access:SAOL_FTP_Release,AUTO,THREAD
_Hide:Relate:SAOL_FTP_Release &Hide:Relate:SAOL_FTP_Release,AUTO,THREAD
_Hide:Access:SAOL_FTP_Componentes &Hide:Access:SAOL_FTP_Componentes,AUTO,THREAD
_Hide:Relate:SAOL_FTP_Componentes &Hide:Relate:SAOL_FTP_Componentes,AUTO,THREAD
_Hide:Access:SAOL_Passcode &Hide:Access:SAOL_Passcode,AUTO,THREAD
_Hide:Relate:SAOL_Passcode &Hide:Relate:SAOL_Passcode,AUTO,THREAD


SAOL_BC0:DctInit PROCEDURE
  CODE
  _Hide:Access:SAOL_Clientes &= NEW(Hide:Access:SAOL_Clientes)
  _Hide:Relate:SAOL_Clientes &= NEW(Hide:Relate:SAOL_Clientes)
  _Hide:Access:SAOL_Instaladores &= NEW(Hide:Access:SAOL_Instaladores)
  _Hide:Relate:SAOL_Instaladores &= NEW(Hide:Relate:SAOL_Instaladores)
  _Hide:Access:FTP_RemoteSite &= NEW(Hide:Access:FTP_RemoteSite)
  _Hide:Relate:FTP_RemoteSite &= NEW(Hide:Relate:FTP_RemoteSite)
  _Hide:Access:FTP_ScheduledTransfer &= NEW(Hide:Access:FTP_ScheduledTransfer)
  _Hide:Relate:FTP_ScheduledTransfer &= NEW(Hide:Relate:FTP_ScheduledTransfer)
  _Hide:Access:FTP_TransferItem &= NEW(Hide:Access:FTP_TransferItem)
  _Hide:Relate:FTP_TransferItem &= NEW(Hide:Relate:FTP_TransferItem)
  _Hide:Access:FTP_RemoteFolder &= NEW(Hide:Access:FTP_RemoteFolder)
  _Hide:Relate:FTP_RemoteFolder &= NEW(Hide:Relate:FTP_RemoteFolder)
  _Hide:Access:FTP_TransferLog &= NEW(Hide:Access:FTP_TransferLog)
  _Hide:Relate:FTP_TransferLog &= NEW(Hide:Relate:FTP_TransferLog)
  _Hide:Access:FTP_TransferSet &= NEW(Hide:Access:FTP_TransferSet)
  _Hide:Relate:FTP_TransferSet &= NEW(Hide:Relate:FTP_TransferSet)
  _Hide:Access:FTP_Transfer &= NEW(Hide:Access:FTP_Transfer)
  _Hide:Relate:FTP_Transfer &= NEW(Hide:Relate:FTP_Transfer)
  _Hide:Access:FTP_ItemxTransferSet &= NEW(Hide:Access:FTP_ItemxTransferSet)
  _Hide:Relate:FTP_ItemxTransferSet &= NEW(Hide:Relate:FTP_ItemxTransferSet)
  _Hide:Access:SAOL_SoftwarexCliente &= NEW(Hide:Access:SAOL_SoftwarexCliente)
  _Hide:Relate:SAOL_SoftwarexCliente &= NEW(Hide:Relate:SAOL_SoftwarexCliente)
  _Hide:Access:SAOL_ComponentesxInstalador &= NEW(Hide:Access:SAOL_ComponentesxInstalador)
  _Hide:Relate:SAOL_ComponentesxInstalador &= NEW(Hide:Relate:SAOL_ComponentesxInstalador)
  _Hide:Access:SAOL_Componentes &= NEW(Hide:Access:SAOL_Componentes)
  _Hide:Relate:SAOL_Componentes &= NEW(Hide:Relate:SAOL_Componentes)
  _Hide:Access:SAOL_Software &= NEW(Hide:Access:SAOL_Software)
  _Hide:Relate:SAOL_Software &= NEW(Hide:Relate:SAOL_Software)
  _Hide:Access:TagSet_ &= NEW(Hide:Access:TagSet_)
  _Hide:Relate:TagSet_ &= NEW(Hide:Relate:TagSet_)
  _Hide:Access:TagFile_ &= NEW(Hide:Access:TagFile_)
  _Hide:Relate:TagFile_ &= NEW(Hide:Relate:TagFile_)
  _Hide:Access:TagFilePos_ &= NEW(Hide:Access:TagFilePos_)
  _Hide:Relate:TagFilePos_ &= NEW(Hide:Relate:TagFilePos_)
  _Hide:Access:SAOL_FTP_Release &= NEW(Hide:Access:SAOL_FTP_Release)
  _Hide:Relate:SAOL_FTP_Release &= NEW(Hide:Relate:SAOL_FTP_Release)
  _Hide:Access:SAOL_FTP_Componentes &= NEW(Hide:Access:SAOL_FTP_Componentes)
  _Hide:Relate:SAOL_FTP_Componentes &= NEW(Hide:Relate:SAOL_FTP_Componentes)
  _Hide:Access:SAOL_Passcode &= NEW(Hide:Access:SAOL_Passcode)
  _Hide:Relate:SAOL_Passcode &= NEW(Hide:Relate:SAOL_Passcode)
  Relate:SAOL_Clientes &= _Hide:Relate:SAOL_Clientes
  Relate:SAOL_Instaladores &= _Hide:Relate:SAOL_Instaladores
  Relate:FTP_RemoteSite &= _Hide:Relate:FTP_RemoteSite
  Relate:FTP_ScheduledTransfer &= _Hide:Relate:FTP_ScheduledTransfer
  Relate:FTP_TransferItem &= _Hide:Relate:FTP_TransferItem
  Relate:FTP_RemoteFolder &= _Hide:Relate:FTP_RemoteFolder
  Relate:FTP_TransferLog &= _Hide:Relate:FTP_TransferLog
  Relate:FTP_TransferSet &= _Hide:Relate:FTP_TransferSet
  Relate:FTP_Transfer &= _Hide:Relate:FTP_Transfer
  Relate:FTP_ItemxTransferSet &= _Hide:Relate:FTP_ItemxTransferSet
  Relate:SAOL_SoftwarexCliente &= _Hide:Relate:SAOL_SoftwarexCliente
  Relate:SAOL_ComponentesxInstalador &= _Hide:Relate:SAOL_ComponentesxInstalador
  Relate:SAOL_Componentes &= _Hide:Relate:SAOL_Componentes
  Relate:SAOL_Software &= _Hide:Relate:SAOL_Software
  Relate:TagSet_ &= _Hide:Relate:TagSet_
  Relate:TagFile_ &= _Hide:Relate:TagFile_
  Relate:TagFilePos_ &= _Hide:Relate:TagFilePos_
  Relate:SAOL_FTP_Release &= _Hide:Relate:SAOL_FTP_Release
  Relate:SAOL_FTP_Componentes &= _Hide:Relate:SAOL_FTP_Componentes
  Relate:SAOL_Passcode &= _Hide:Relate:SAOL_Passcode


SAOL_BC0:FilesInit PROCEDURE
  CODE
  _Hide:Relate:SAOL_Clientes.Init
  _Hide:Relate:SAOL_Instaladores.Init
  _Hide:Relate:FTP_RemoteSite.Init
  _Hide:Relate:FTP_ScheduledTransfer.Init
  _Hide:Relate:FTP_TransferItem.Init
  _Hide:Relate:FTP_RemoteFolder.Init
  _Hide:Relate:FTP_TransferLog.Init
  _Hide:Relate:FTP_TransferSet.Init
  _Hide:Relate:FTP_Transfer.Init
  _Hide:Relate:FTP_ItemxTransferSet.Init
  _Hide:Relate:SAOL_SoftwarexCliente.Init
  _Hide:Relate:SAOL_ComponentesxInstalador.Init
  _Hide:Relate:SAOL_Componentes.Init
  _Hide:Relate:SAOL_Software.Init
  _Hide:Relate:TagSet_.Init
  _Hide:Relate:TagFile_.Init
  _Hide:Relate:TagFilePos_.Init
  _Hide:Relate:SAOL_FTP_Release.Init
  _Hide:Relate:SAOL_FTP_Componentes.Init
  _Hide:Relate:SAOL_Passcode.Init


SAOL_BC0:DctKill PROCEDURE
  CODE
  _Hide:Relate:SAOL_Clientes.Kill
  DISPOSE(_Hide:Relate:SAOL_Clientes)
  _Hide:Relate:SAOL_Instaladores.Kill
  DISPOSE(_Hide:Relate:SAOL_Instaladores)
  _Hide:Relate:FTP_RemoteSite.Kill
  DISPOSE(_Hide:Relate:FTP_RemoteSite)
  _Hide:Relate:FTP_ScheduledTransfer.Kill
  DISPOSE(_Hide:Relate:FTP_ScheduledTransfer)
  _Hide:Relate:FTP_TransferItem.Kill
  DISPOSE(_Hide:Relate:FTP_TransferItem)
  _Hide:Relate:FTP_RemoteFolder.Kill
  DISPOSE(_Hide:Relate:FTP_RemoteFolder)
  _Hide:Relate:FTP_TransferLog.Kill
  DISPOSE(_Hide:Relate:FTP_TransferLog)
  _Hide:Relate:FTP_TransferSet.Kill
  DISPOSE(_Hide:Relate:FTP_TransferSet)
  _Hide:Relate:FTP_Transfer.Kill
  DISPOSE(_Hide:Relate:FTP_Transfer)
  _Hide:Relate:FTP_ItemxTransferSet.Kill
  DISPOSE(_Hide:Relate:FTP_ItemxTransferSet)
  _Hide:Relate:SAOL_SoftwarexCliente.Kill
  DISPOSE(_Hide:Relate:SAOL_SoftwarexCliente)
  _Hide:Relate:SAOL_ComponentesxInstalador.Kill
  DISPOSE(_Hide:Relate:SAOL_ComponentesxInstalador)
  _Hide:Relate:SAOL_Componentes.Kill
  DISPOSE(_Hide:Relate:SAOL_Componentes)
  _Hide:Relate:SAOL_Software.Kill
  DISPOSE(_Hide:Relate:SAOL_Software)
  _Hide:Relate:TagSet_.Kill
  DISPOSE(_Hide:Relate:TagSet_)
  _Hide:Relate:TagFile_.Kill
  DISPOSE(_Hide:Relate:TagFile_)
  _Hide:Relate:TagFilePos_.Kill
  DISPOSE(_Hide:Relate:TagFilePos_)
  _Hide:Relate:SAOL_FTP_Release.Kill
  DISPOSE(_Hide:Relate:SAOL_FTP_Release)
  _Hide:Relate:SAOL_FTP_Componentes.Kill
  DISPOSE(_Hide:Relate:SAOL_FTP_Componentes)
  _Hide:Relate:SAOL_Passcode.Kill
  DISPOSE(_Hide:Relate:SAOL_Passcode)


Hide:Relate:SAOL_Clientes.Init PROCEDURE
  CODE
  _Hide:Access:SAOL_Clientes.Init
  SELF.Init(Access:SAOL_Clientes,1)


Hide:Access:SAOL_Clientes.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= SAOL_CLI:Record
  SELF.FileNameValue = 'SAOL_Clientes'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= SAOL_Clientes
  PARENT.Init
  Access:SAOL_Clientes &= SELF


Hide:Access:SAOL_Clientes.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:SAOL_Clientes &= NULL                             ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:SAOL_Clientes.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(SAOL_Clientes,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(SAOL_CLI:PorID,'SAOL_CLI:PorID',1)
    SELF.AddKey(SAOL_CLI:PorNombre,'SAOL_CLI:PorNombre',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Access:SAOL_Clientes.ValidateFieldServer PROCEDURE(UNSIGNED Id,BYTE HandleErrors)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.ValidateFieldServer(Id,HandleErrors)
  CASE Id
  OF 6
    GlobalErrors.SetField('Estado')
    IF INSTRING(']' & SAOL_CLI:Estado & '[', ']1[]0[]9[', 1, 1) = 0
      ReturnValue = Level:Notify
    END
    IF ReturnValue <> Level:Benign
      IF HandleErrors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInList,'''Habilitado'',''Inhabilitado'',''De baja''')
      END
    END
  END
  RETURN ReturnValue


Hide:Relate:SAOL_Clientes.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:SAOL_SoftwarexCliente,RI:RESTRICT,RI:RESTRICT,SAOL_SXC:PorCliente)
  SELF.AddRelationLink(SAOL_CLI:id,SAOL_SXC:idCliente)

  SELF.AddRelation(Relate:SAOL_Passcode,RI:RESTRICT,RI:RESTRICT,SAOL_PASS:PorCliente)
  SELF.AddRelationLink(SAOL_CLI:id,SAOL_PASS:idcliente)


Hide:Relate:SAOL_Clientes.Kill PROCEDURE

  CODE
  _Hide:Access:SAOL_Clientes.Kill                          ! Kill the file manager
  PARENT.Kill
  Relate:SAOL_Clientes &= NULL                             ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:SAOL_Clientes)                      ! destroy the file manager


Hide:Relate:SAOL_Instaladores.Init PROCEDURE
  CODE
  _Hide:Access:SAOL_Instaladores.Init
  SELF.Init(Access:SAOL_Instaladores,1)


Hide:Access:SAOL_Instaladores.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= SAOL_INS:Record
  SELF.FileNameValue = 'SAOL_Instaladores'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= SAOL_Instaladores
  PARENT.Init
  Access:SAOL_Instaladores &= SELF


Hide:Access:SAOL_Instaladores.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:SAOL_Instaladores &= NULL                         ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:SAOL_Instaladores.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(SAOL_Instaladores,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(SAOL_INS:PorID,'Por ID del Instalador',1)
    SELF.AddKey(SAOL_INS:PorIDSoftwarexCliente,'SAOL_INS:PorIDSoftwarexCliente',0)
    SELF.AddKey(SAOL_INS:PorDescripcion,'Por Descripción del Instalador',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Access:SAOL_Instaladores.ValidateFieldServer PROCEDURE(UNSIGNED Id,BYTE HandleErrors)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.ValidateFieldServer(Id,HandleErrors)
  CASE Id
  OF 16
    GlobalErrors.SetField('Estado')
    IF INSTRING(']' & SAOL_INS:Estado & '[', ']1[]0[]9[', 1, 1) = 0
      ReturnValue = Level:Notify
    END
    IF ReturnValue <> Level:Benign
      IF HandleErrors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInList,'''Activo'',''Inactivo'',''De baja''')
      END
    END
  END
  RETURN ReturnValue


Hide:Relate:SAOL_Instaladores.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:SAOL_SoftwarexCliente)

  SELF.AddRelation(Relate:SAOL_ComponentesxInstalador,RI:RESTRICT,RI:CASCADE,SAOL_CXI:PorIdInstalador)
  SELF.AddRelationLink(SAOL_INS:id,SAOL_CXI:idInstalador)

  SELF.AddRelation(Relate:SAOL_Log,RI:CASCADE,RI:CASCADE,SAOL_LOG:PorInstalador)
  SELF.AddRelationLink(SAOL_INS:id,SAOL_LOG:idInstalador)


Hide:Relate:SAOL_Instaladores.Kill PROCEDURE

  CODE
  _Hide:Access:SAOL_Instaladores.Kill                      ! Kill the file manager
  PARENT.Kill
  Relate:SAOL_Instaladores &= NULL                         ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:SAOL_Instaladores)                  ! destroy the file manager


Hide:Relate:FTP_RemoteSite.Init PROCEDURE
  CODE
  _Hide:Access:FTP_RemoteSite.Init
  SELF.Init(Access:FTP_RemoteSite,1)


Hide:Access:FTP_RemoteSite.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= FTPRS:Record
  SELF.FileNameValue = 'FTP_RemoteSite'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= FTP_RemoteSite
  PARENT.Init
  Access:FTP_RemoteSite &= SELF


Hide:Access:FTP_RemoteSite.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:FTP_RemoteSite &= NULL                            ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:FTP_RemoteSite.PrimeFields PROCEDURE

  CODE
  FTPRS:Port = INTERNET_DEFAULT_FTP_PORT                   ! Assign initial field value
  PARENT.PrimeFields


Hide:Access:FTP_RemoteSite.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(FTP_RemoteSite,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(FTPRS:PorId,'Por Id',1)
    SELF.AddKey(FTPRS:PorDescripcion,'Por Descripción',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:FTP_RemoteSite.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:FTP_Transfer,RI:RESTRICT,RI:RESTRICT,FTPT:PorRemoteSite)
  SELF.AddRelationLink(FTPRS:id,FTPT:idRemoteSite)

  SELF.AddRelation(Relate:FTP_TransferItem,RI:RESTRICT,RI:RESTRICT,FTPTI:PorRemoteSite)
  SELF.AddRelationLink(FTPRS:id,FTPTI:idRemoteSite)

  SELF.AddRelation(Relate:FTP_RemoteFolder,RI:RESTRICT,RI:CASCADE,FTPRF:PorRemoteSite)
  SELF.AddRelationLink(FTPRS:id,FTPRF:idRemoteSite)


Hide:Relate:FTP_RemoteSite.Kill PROCEDURE

  CODE
  _Hide:Access:FTP_RemoteSite.Kill                         ! Kill the file manager
  PARENT.Kill
  Relate:FTP_RemoteSite &= NULL                            ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:FTP_RemoteSite)                     ! destroy the file manager


Hide:Relate:FTP_ScheduledTransfer.Init PROCEDURE
  CODE
  _Hide:Access:FTP_ScheduledTransfer.Init
  SELF.Init(Access:FTP_ScheduledTransfer,1)


Hide:Access:FTP_ScheduledTransfer.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= FTPST:Record
  SELF.FileNameValue = 'FTP_ScheduledTransfer'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= FTP_ScheduledTransfer
  PARENT.Init
  Access:FTP_ScheduledTransfer &= SELF


Hide:Access:FTP_ScheduledTransfer.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:FTP_ScheduledTransfer &= NULL                     ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:FTP_ScheduledTransfer.PrimeFields PROCEDURE

  CODE
  FTPST:DesconectarAlFinalizar = 1                         ! Assign initial field value
  PARENT.PrimeFields


Hide:Access:FTP_ScheduledTransfer.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(FTP_ScheduledTransfer,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(FTPST:PorId,'Por id',1)
    SELF.AddKey(FTPST:PorTransferSet,'Por Conjunto de Transferencia',0)
    SELF.AddKey(FTPST:PorEstPT,'Por Estado/Próxima Transferencia',0)
    SELF.AddKey(FTPST:PorEstOrden,'Por Estado/Orden',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Access:FTP_ScheduledTransfer.ValidateFieldServer PROCEDURE(UNSIGNED Id,BYTE HandleErrors)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.ValidateFieldServer(Id,HandleErrors)
  CASE Id
  OF 6
    GlobalErrors.SetField('Repetición')
    IF INSTRING(']' & FTPST:Repetir & '[', ']1[]2[]3[]4[]5[]6[]7[', 1, 1) = 0
      ReturnValue = Level:Notify
    END
    IF ReturnValue <> Level:Benign
      IF HandleErrors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInList,'''Una vez'',''Horariamente'',''Diariamente'',''Semanalmente'',''Mensualmente'',''Al arrancar una vez al día'',''Al arrancar siempre''')
      END
    END
  OF 19
    GlobalErrors.SetField('Día de la Semana')
    IF INSTRING(']' & FTPST:DiaDeLaSemana & '[', ']1[]2[]3[]4[]5[]6[]7[', 1, 1) = 0
      ReturnValue = Level:Notify
    END
    IF ReturnValue <> Level:Benign
      IF HandleErrors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInList,'''Lunes'',''Martes'',''Miércoles'',''Jueves'',''Viernes'',''Sábado'',''Domingo''')
      END
    END
  OF 20
    GlobalErrors.SetField('Día del mes')
    IF NOT INRANGE(FTPST:DiaDelMes,1,31)
      ReturnValue = Level:Notify
    END
    IF ReturnValue <> Level:Benign
      IF HandleErrors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldOutOfRange,'1 .. 31')
      END
    END
  OF 30
    GlobalErrors.SetField('Estado')
    IF INSTRING(']' & FTPST:Estado & '[', ']1[]2[]3[]4[]5[', 1, 1) = 0
      ReturnValue = Level:Notify
    END
    IF ReturnValue <> Level:Benign
      IF HandleErrors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInList,'''En Espera'',''En Proceso'',''Completa'',''Suspendida'',''En error''')
      END
    END
  END
  RETURN ReturnValue


Hide:Relate:FTP_ScheduledTransfer.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:FTP_TransferLog,RI:RESTRICT,RI:CLEAR,FTPTL:PorScheduledTransfer)
  SELF.AddRelationLink(FTPST:id,FTPTL:idScheduledTransfer)

  SELF.AddRelation(Relate:FTP_Transfer,RI:RESTRICT,RI:RESTRICT,FTPT:PorScheduledTransfer)
  SELF.AddRelationLink(FTPST:id,FTPT:idScheduledTransfer)

  SELF.AddRelation(Relate:FTP_TransferSet)


Hide:Relate:FTP_ScheduledTransfer.Kill PROCEDURE

  CODE
  _Hide:Access:FTP_ScheduledTransfer.Kill                  ! Kill the file manager
  PARENT.Kill
  Relate:FTP_ScheduledTransfer &= NULL                     ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:FTP_ScheduledTransfer)              ! destroy the file manager


Hide:Relate:FTP_TransferItem.Init PROCEDURE
  CODE
  _Hide:Access:FTP_TransferItem.Init
  SELF.Init(Access:FTP_TransferItem,1)


Hide:Access:FTP_TransferItem.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= FTPTI:Record
  SELF.FileNameValue = 'FTP_TransferItem'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= FTP_TransferItem
  PARENT.Init
  Access:FTP_TransferItem &= SELF


Hide:Access:FTP_TransferItem.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:FTP_TransferItem &= NULL                          ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:FTP_TransferItem.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(FTP_TransferItem,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(FTPTI:PorId,'Por Id',1)
    SELF.AddKey(FTPTI:PorRemoteSite,'Por Sitio Remoto',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Access:FTP_TransferItem.ValidateFieldServer PROCEDURE(UNSIGNED Id,BYTE HandleErrors)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.ValidateFieldServer(Id,HandleErrors)
  CASE Id
  OF 2
    GlobalErrors.SetField('Dirección de Transferencia')
    IF INSTRING(']' & FTPTI:Direccion & '[', ']1[]2[', 1, 1) = 0
      ReturnValue = Level:Notify
    END
    IF ReturnValue <> Level:Benign
      IF HandleErrors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInList,'''Enviar'',''Recibir''')
      END
    END
  OF 14
    GlobalErrors.SetField('Tipo de Acción Especial')
    IF INSTRING(']' & FTPTI:TipoAccionEspecial & '[', ']1[]2[]3[]4[]5[]6[', 1, 1) = 0
      ReturnValue = Level:Notify
    END
    IF ReturnValue <> Level:Benign
      IF HandleErrors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInList,'''Crear Carpeta'',''Borrar Carpeta'',''Borrar Archivo'',''Ejecutar Aplicación'',''Borrar Archivos Locales no existentes'',''Borrar Archivos Remotos no existentes''')
      END
    END
  END
  RETURN ReturnValue


Hide:Relate:FTP_TransferItem.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:FTP_Transfer,RI:RESTRICT,RI:RESTRICT,FTPT:PorTransferItem)
  SELF.AddRelationLink(FTPTI:id,FTPT:idTransferItem)

  SELF.AddRelation(Relate:FTP_TransferLog,RI:RESTRICT,RI:CLEAR,FTPTL:PorTransferItem)
  SELF.AddRelationLink(FTPTI:id,FTPTL:idTransferItem)

  SELF.AddRelation(Relate:FTP_ItemxTransferSet,RI:RESTRICT,RI:RESTRICT,FTPIxTS:PorTransferItem)
  SELF.AddRelationLink(FTPTI:id,FTPIxTS:idTransferItem)

  SELF.AddRelation(Relate:FTP_RemoteSite)


Hide:Relate:FTP_TransferItem.Kill PROCEDURE

  CODE
  _Hide:Access:FTP_TransferItem.Kill                       ! Kill the file manager
  PARENT.Kill
  Relate:FTP_TransferItem &= NULL                          ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:FTP_TransferItem)                   ! destroy the file manager


Hide:Relate:FTP_RemoteFolder.Init PROCEDURE
  CODE
  _Hide:Access:FTP_RemoteFolder.Init
  SELF.Init(Access:FTP_RemoteFolder,1)


Hide:Access:FTP_RemoteFolder.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= FTPRF:Record
  SELF.FileNameValue = 'FTP_RemoteFolder'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= FTP_RemoteFolder
  PARENT.Init
  Access:FTP_RemoteFolder &= SELF


Hide:Access:FTP_RemoteFolder.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:FTP_RemoteFolder &= NULL                          ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:FTP_RemoteFolder.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(FTP_RemoteFolder,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(FTPRF:PorId,'Por Id',1)
    SELF.AddKey(FTPRF:PorRemoteSite,'Por Servidor',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:FTP_RemoteFolder.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:FTP_RemoteSite)


Hide:Relate:FTP_RemoteFolder.Kill PROCEDURE

  CODE
  _Hide:Access:FTP_RemoteFolder.Kill                       ! Kill the file manager
  PARENT.Kill
  Relate:FTP_RemoteFolder &= NULL                          ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:FTP_RemoteFolder)                   ! destroy the file manager


Hide:Relate:FTP_TransferLog.Init PROCEDURE
  CODE
  _Hide:Access:FTP_TransferLog.Init
  SELF.Init(Access:FTP_TransferLog,1)


Hide:Access:FTP_TransferLog.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= FTPTL:Record
  SELF.FileNameValue = 'FTP_TransferLog'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= FTP_TransferLog
  PARENT.Init
  Access:FTP_TransferLog &= SELF


Hide:Access:FTP_TransferLog.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:FTP_TransferLog &= NULL                           ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:FTP_TransferLog.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(FTP_TransferLog,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(FTPTL:PorId,'Por Id',1)
    SELF.AddKey(FTPTL:PorFecHor,'Por Fecha/Hora',0)
    SELF.AddKey(FTPTL:PorTransferItem,'Por Item de Transferencia',0)
    SELF.AddKey(FTPTL:PorScheduledTransfer,'Por Transferencia Programadas',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Access:FTP_TransferLog.ValidateFieldServer PROCEDURE(UNSIGNED Id,BYTE HandleErrors)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.ValidateFieldServer(Id,HandleErrors)
  CASE Id
  OF 2
    GlobalErrors.SetField('Tipo de Log')
    IF INSTRING(']' & FTPTL:Tipo & '[', ']0[]1[]2[]3[', 1, 1) = 0
      ReturnValue = Level:Notify
    END
    IF ReturnValue <> Level:Benign
      IF HandleErrors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInList,'''Mensaje'',''Info'',''Especial'',''Error''')
      END
    END
  END
  RETURN ReturnValue


Hide:Relate:FTP_TransferLog.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:FTP_ScheduledTransfer)

  SELF.AddRelation(Relate:FTP_TransferItem)


Hide:Relate:FTP_TransferLog.Kill PROCEDURE

  CODE
  _Hide:Access:FTP_TransferLog.Kill                        ! Kill the file manager
  PARENT.Kill
  Relate:FTP_TransferLog &= NULL                           ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:FTP_TransferLog)                    ! destroy the file manager


Hide:Relate:FTP_TransferSet.Init PROCEDURE
  CODE
  _Hide:Access:FTP_TransferSet.Init
  SELF.Init(Access:FTP_TransferSet,1)


Hide:Access:FTP_TransferSet.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= FTPTS:Record
  SELF.FileNameValue = 'FTP_TransferSet'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= FTP_TransferSet
  PARENT.Init
  Access:FTP_TransferSet &= SELF


Hide:Access:FTP_TransferSet.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:FTP_TransferSet &= NULL                           ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:FTP_TransferSet.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(FTP_TransferSet,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(FTPTS:PorId,'Por Id',1)
    SELF.AddKey(FTPTS:PorDescripcion,'Por Descripción',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:FTP_TransferSet.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:FTP_ScheduledTransfer,RI:RESTRICT,RI:CASCADE,FTPST:PorTransferSet)
  SELF.AddRelationLink(FTPTS:id,FTPST:idTransferSet)

  SELF.AddRelation(Relate:FTP_ItemxTransferSet,RI:RESTRICT,RI:CASCADE,FTPIxTS:PorTransferSet)
  SELF.AddRelationLink(FTPTS:id,FTPIxTS:idTransferSet)


Hide:Relate:FTP_TransferSet.Kill PROCEDURE

  CODE
  _Hide:Access:FTP_TransferSet.Kill                        ! Kill the file manager
  PARENT.Kill
  Relate:FTP_TransferSet &= NULL                           ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:FTP_TransferSet)                    ! destroy the file manager


Hide:Relate:FTP_Transfer.Init PROCEDURE
  CODE
  _Hide:Access:FTP_Transfer.Init
  SELF.Init(Access:FTP_Transfer,1)


Hide:Access:FTP_Transfer.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= FTPT:Record
  SELF.FileNameValue = 'FTP_Transfer'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= FTP_Transfer
  PARENT.Init
  Access:FTP_Transfer &= SELF


Hide:Access:FTP_Transfer.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:FTP_Transfer &= NULL                              ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:FTP_Transfer.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(FTP_Transfer,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(FTPT:PorId,'Por id',1)
    SELF.AddKey(FTPT:PorRemoteSite,'Por Servidor FTP',0)
    SELF.AddKey(FTPT:PorTransferItem,'Por Item de Transferencia',0)
    SELF.AddKey(FTPT:PorScheduledTransfer,'Por Transferencia Programada',0)
    SELF.AddKey(FTPT:PorInternetSession,'Por Sesión Internet',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Access:FTP_Transfer.ValidateFieldServer PROCEDURE(UNSIGNED Id,BYTE HandleErrors)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.ValidateFieldServer(Id,HandleErrors)
  CASE Id
  OF 4
    GlobalErrors.SetField('Dirección de Transferencia')
    IF INSTRING(']' & FTPT:Direccion & '[', ']1[]2[', 1, 1) = 0
      ReturnValue = Level:Notify
    END
    IF ReturnValue <> Level:Benign
      IF HandleErrors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInList,'''Enviar'',''Recibir''')
      END
    END
  OF 13
    GlobalErrors.SetField('Estado')
    IF INSTRING(']' & FTPT:Estado & '[', ']1[]2[]3[]4[]5[', 1, 1) = 0
      ReturnValue = Level:Notify
    END
    IF ReturnValue <> Level:Benign
      IF HandleErrors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInList,'''En Espera'',''En Proceso'',''Completa'',''Suspendida'',''En error''')
      END
    END
  END
  RETURN ReturnValue


Hide:Relate:FTP_Transfer.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:FTP_TransferItem)

  SELF.AddRelation(Relate:FTP_ScheduledTransfer)

  SELF.AddRelation(Relate:FTP_RemoteSite)


Hide:Relate:FTP_Transfer.Kill PROCEDURE

  CODE
  _Hide:Access:FTP_Transfer.Kill                           ! Kill the file manager
  PARENT.Kill
  Relate:FTP_Transfer &= NULL                              ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:FTP_Transfer)                       ! destroy the file manager


Hide:Relate:FTP_ItemxTransferSet.Init PROCEDURE
  CODE
  _Hide:Access:FTP_ItemxTransferSet.Init
  SELF.Init(Access:FTP_ItemxTransferSet,1)


Hide:Access:FTP_ItemxTransferSet.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= FTPIxTS:Record
  SELF.FileNameValue = 'FTP_ItemxTransferSet'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= FTP_ItemxTransferSet
  PARENT.Init
  Access:FTP_ItemxTransferSet &= SELF


Hide:Access:FTP_ItemxTransferSet.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:FTP_ItemxTransferSet &= NULL                      ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:FTP_ItemxTransferSet.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(FTP_ItemxTransferSet,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(FTPIxTS:PorId,'Por Id',1)
    SELF.AddKey(FTPIxTS:PorOrden,'Por Orden',0)
    SELF.AddKey(FTPIxTS:PorTransferSet,'Por Conjunto de Transferencia',0)
    SELF.AddKey(FTPIxTS:PorTransferItem,'Por Item de Transferencia',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:FTP_ItemxTransferSet.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:FTP_TransferItem)

  SELF.AddRelation(Relate:FTP_TransferSet)


Hide:Relate:FTP_ItemxTransferSet.Kill PROCEDURE

  CODE
  _Hide:Access:FTP_ItemxTransferSet.Kill                   ! Kill the file manager
  PARENT.Kill
  Relate:FTP_ItemxTransferSet &= NULL                      ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:FTP_ItemxTransferSet)               ! destroy the file manager


Hide:Relate:SAOL_SoftwarexCliente.Init PROCEDURE
  CODE
  _Hide:Access:SAOL_SoftwarexCliente.Init
  SELF.Init(Access:SAOL_SoftwarexCliente,1)


Hide:Access:SAOL_SoftwarexCliente.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= SAOL_SXC:Record
  SELF.FileNameValue = 'SAOL_SoftwarexCliente'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= SAOL_SoftwarexCliente
  PARENT.Init
  Access:SAOL_SoftwarexCliente &= SELF


Hide:Access:SAOL_SoftwarexCliente.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:SAOL_SoftwarexCliente &= NULL                     ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:SAOL_SoftwarexCliente.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(SAOL_SoftwarexCliente,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(SAOL_SXC:PorID,'SAOL_SXC:PorID',1)
    SELF.AddKey(SAOL_SXC:PorClienteSoftware,'Por Cliente/Software',0)
    SELF.AddKey(SAOL_SXC:PorCliente,'SAOL_SXC:PorCliente',0)
    SELF.AddKey(SAOL_SXC:PorSoftware,'SAOL_SXC:PorSoftware',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:SAOL_SoftwarexCliente.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:SAOL_Instaladores,RI:RESTRICT,RI:RESTRICT,SAOL_INS:PorIDSoftwarexCliente)
  SELF.AddRelationLink(SAOL_SXC:id,SAOL_INS:idSoftwarexCliente)

  SELF.AddRelation(Relate:SAOL_Clientes)

  SELF.AddRelation(Relate:SAOL_Software)


Hide:Relate:SAOL_SoftwarexCliente.Kill PROCEDURE

  CODE
  _Hide:Access:SAOL_SoftwarexCliente.Kill                  ! Kill the file manager
  PARENT.Kill
  Relate:SAOL_SoftwarexCliente &= NULL                     ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:SAOL_SoftwarexCliente)              ! destroy the file manager


Hide:Relate:SAOL_ComponentesxInstalador.Init PROCEDURE
  CODE
  _Hide:Access:SAOL_ComponentesxInstalador.Init
  SELF.Init(Access:SAOL_ComponentesxInstalador,1)


Hide:Access:SAOL_ComponentesxInstalador.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= SAOL_CXI:Record
  SELF.FileNameValue = 'SAOL_ComponentesxInstalador'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= SAOL_ComponentesxInstalador
  PARENT.Init
  Access:SAOL_ComponentesxInstalador &= SELF


Hide:Access:SAOL_ComponentesxInstalador.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:SAOL_ComponentesxInstalador &= NULL               ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:SAOL_ComponentesxInstalador.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(SAOL_ComponentesxInstalador,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(SAOL_CXI:PorId,'SAOL_CXI:PorId',1)
    SELF.AddKey(SAOL_CXI:PorInstaladorComponente,'Por Instalador/Componente',0)
    SELF.AddKey(SAOL_CXI:PorIdComponente,'SAOL_CXI:PorIdComponente',0)
    SELF.AddKey(SAOL_CXI:PorIdInstalador,'SAOL_CXI:PorIdInstalador',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:SAOL_ComponentesxInstalador.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:SAOL_Componentes)

  SELF.AddRelation(Relate:SAOL_Instaladores)


Hide:Relate:SAOL_ComponentesxInstalador.Kill PROCEDURE

  CODE
  _Hide:Access:SAOL_ComponentesxInstalador.Kill            ! Kill the file manager
  PARENT.Kill
  Relate:SAOL_ComponentesxInstalador &= NULL               ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:SAOL_ComponentesxInstalador)        ! destroy the file manager


Hide:Relate:SAOL_Componentes.Init PROCEDURE
  CODE
  _Hide:Access:SAOL_Componentes.Init
  SELF.Init(Access:SAOL_Componentes,1)


Hide:Access:SAOL_Componentes.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= SAOL_COM:Record
  SELF.FileNameValue = 'SAOL_Componentes'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= SAOL_Componentes
  PARENT.Init
  Access:SAOL_Componentes &= SELF


Hide:Access:SAOL_Componentes.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:SAOL_Componentes &= NULL                          ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:SAOL_Componentes.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(SAOL_Componentes,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(SAOL_COM:PorID,'SAOL_COM:PorID',1)
    SELF.AddKey(SAOL_COM:PorDescripcion,'SAOL_COM:PorDescripcion',0)
    SELF.AddKey(SAOL_COM:PorPath,'Por Path',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:SAOL_Componentes.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:SAOL_ComponentesxInstalador,RI:RESTRICT,RI:RESTRICT,SAOL_CXI:PorIdComponente)
  SELF.AddRelationLink(SAOL_COM:id,SAOL_CXI:idComponente)


Hide:Relate:SAOL_Componentes.Kill PROCEDURE

  CODE
  _Hide:Access:SAOL_Componentes.Kill                       ! Kill the file manager
  PARENT.Kill
  Relate:SAOL_Componentes &= NULL                          ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:SAOL_Componentes)                   ! destroy the file manager


Hide:Relate:SAOL_Software.Init PROCEDURE
  CODE
  _Hide:Access:SAOL_Software.Init
  SELF.Init(Access:SAOL_Software,1)


Hide:Access:SAOL_Software.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= SAOL_SOF:Record
  SELF.FileNameValue = 'SAOL_Software'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= SAOL_Software
  PARENT.Init
  Access:SAOL_Software &= SELF


Hide:Access:SAOL_Software.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:SAOL_Software &= NULL                             ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:SAOL_Software.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(SAOL_Software,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(SAOL_SOF:PorID,'SAOL_SOF:PorID',1)
    SELF.AddKey(SAOL_SOF:PorNombre,'SAOL_SOF:PorNombre',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:SAOL_Software.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:SAOL_SoftwarexCliente,RI:RESTRICT,RI:RESTRICT,SAOL_SXC:PorSoftware)
  SELF.AddRelationLink(SAOL_SOF:id,SAOL_SXC:idSoftware)

  SELF.AddRelation(Relate:SAOL_Passcode,RI:RESTRICT,RI:RESTRICT,SAOL_PASS:PorSoftware)
  SELF.AddRelationLink(SAOL_SOF:id,SAOL_PASS:idSoftware)


Hide:Relate:SAOL_Software.Kill PROCEDURE

  CODE
  _Hide:Access:SAOL_Software.Kill                          ! Kill the file manager
  PARENT.Kill
  Relate:SAOL_Software &= NULL                             ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:SAOL_Software)                      ! destroy the file manager


Hide:Relate:TagSet_.Init PROCEDURE
  CODE
  _Hide:Access:TagSet_.Init
  SELF.Init(Access:TagSet_,1)


Hide:Access:TagSet_.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= TS_:Record
  SELF.FileNameValue = 'TagSet_'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= TagSet_
  PARENT.Init
  Access:TagSet_ &= SELF


Hide:Access:TagSet_.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:TagSet_ &= NULL                                   ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:TagSet_.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(TagSet_,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(TS_:TblKey,'TS_:TblKey',0)
    SELF.AddKey(TS_:UsrTblKey,'TS_:UsrTblKey',0)
    SELF.AddKey(TS_:UsrSourceDateKey,'TS_:UsrSourceDateKey',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:TagSet_.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:TagFile_,RI:CASCADE,RI:CASCADE,TF_:PtrKey)
  SELF.AddRelationLink(TS_:Usr,TF_:Usr)
  SELF.AddRelationLink(TS_:Tbl,TF_:Tbl)

  SELF.AddRelation(Relate:TagFilePos_,RI:CASCADE,RI:CASCADE,TP_:ValKey)
  SELF.AddRelationLink(TS_:Usr,TP_:Usr)
  SELF.AddRelationLink(TS_:Tbl,TP_:Tbl)


Hide:Relate:TagSet_.Kill PROCEDURE

  CODE
  _Hide:Access:TagSet_.Kill                                ! Kill the file manager
  PARENT.Kill
  Relate:TagSet_ &= NULL                                   ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:TagSet_)                            ! destroy the file manager


Hide:Relate:TagFile_.Init PROCEDURE
  CODE
  _Hide:Access:TagFile_.Init
  SELF.Init(Access:TagFile_,1)


Hide:Access:TagFile_.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= TF_:Record
  SELF.FileNameValue = 'TagFile_'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= TagFile_
  PARENT.Init
  Access:TagFile_ &= SELF


Hide:Access:TagFile_.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:TagFile_ &= NULL                                  ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:TagFile_.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(TagFile_,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(TF_:PtrKey,'TF_:PtrKey',0)
    SELF.AddKey(TF_:ValKey,'TF_:ValKey',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:TagFile_.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:TagSet_)


Hide:Relate:TagFile_.Kill PROCEDURE

  CODE
  _Hide:Access:TagFile_.Kill                               ! Kill the file manager
  PARENT.Kill
  Relate:TagFile_ &= NULL                                  ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:TagFile_)                           ! destroy the file manager


Hide:Relate:TagFilePos_.Init PROCEDURE
  CODE
  _Hide:Access:TagFilePos_.Init
  SELF.Init(Access:TagFilePos_,1)


Hide:Access:TagFilePos_.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= TP_:Record
  SELF.FileNameValue = 'TagFilePos_'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= TagFilePos_
  PARENT.Init
  Access:TagFilePos_ &= SELF


Hide:Access:TagFilePos_.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:TagFilePos_ &= NULL                               ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:TagFilePos_.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(TagFilePos_,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(TP_:PosKey,'TP_:PosKey',0)
    SELF.AddKey(TP_:ValKey,'TP_:ValKey',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:TagFilePos_.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:TagSet_)


Hide:Relate:TagFilePos_.Kill PROCEDURE

  CODE
  _Hide:Access:TagFilePos_.Kill                            ! Kill the file manager
  PARENT.Kill
  Relate:TagFilePos_ &= NULL                               ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:TagFilePos_)                        ! destroy the file manager


Hide:Relate:SAOL_FTP_Release.Init PROCEDURE
  CODE
  _Hide:Access:SAOL_FTP_Release.Init
  SELF.Init(Access:SAOL_FTP_Release,1)


Hide:Access:SAOL_FTP_Release.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= FTP_REL:Record
  SELF.FileNameValue = 'SAOL_FTP_Release'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= SAOL_FTP_Release
  PARENT.Init
  Access:SAOL_FTP_Release &= SELF


Hide:Access:SAOL_FTP_Release.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:SAOL_FTP_Release &= NULL                          ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:SAOL_FTP_Release.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(SAOL_FTP_Release,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(FTP_REL:PorID,'FTP_REL:PorID',1)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:SAOL_FTP_Release.Kill PROCEDURE

  CODE
  _Hide:Access:SAOL_FTP_Release.Kill                       ! Kill the file manager
  PARENT.Kill
  Relate:SAOL_FTP_Release &= NULL                          ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:SAOL_FTP_Release)                   ! destroy the file manager


Hide:Relate:SAOL_FTP_Componentes.Init PROCEDURE
  CODE
  _Hide:Access:SAOL_FTP_Componentes.Init
  SELF.Init(Access:SAOL_FTP_Componentes,1)


Hide:Access:SAOL_FTP_Componentes.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= FTP_COM:Record
  SELF.FileNameValue = 'SAOL_FTP_Componentes'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= SAOL_FTP_Componentes
  PARENT.Init
  Access:SAOL_FTP_Componentes &= SELF


Hide:Access:SAOL_FTP_Componentes.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:SAOL_FTP_Componentes &= NULL                      ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:SAOL_FTP_Componentes.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(SAOL_FTP_Componentes,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(FTP_COM:PorID,'FTP_COM:PorID',1)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:SAOL_FTP_Componentes.Kill PROCEDURE

  CODE
  _Hide:Access:SAOL_FTP_Componentes.Kill                   ! Kill the file manager
  PARENT.Kill
  Relate:SAOL_FTP_Componentes &= NULL                      ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:SAOL_FTP_Componentes)               ! destroy the file manager


Hide:Relate:SAOL_Passcode.Init PROCEDURE
  CODE
  _Hide:Access:SAOL_Passcode.Init
  SELF.Init(Access:SAOL_Passcode,1)


Hide:Access:SAOL_Passcode.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= SAOL_PASS:Record
  SELF.FileNameValue = 'SAOL_Passcode'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= SAOL_Passcode
  PARENT.Init
  Access:SAOL_Passcode &= SELF


Hide:Access:SAOL_Passcode.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:SAOL_Passcode &= NULL                             ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:SAOL_Passcode.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(SAOL_Passcode,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(SAOL_PASS:PorID,'SAOL_PASS:PorID',1)
    SELF.AddKey(SAOL_PASS:PorCliente,'SAOL_PASS:PorCliente',0)
    SELF.AddKey(SAOL_PASS:PorSoftware,'SAOL_PASS:PorSoftware',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Access:SAOL_Passcode.ValidateFieldServer PROCEDURE(UNSIGNED Id,BYTE HandleErrors)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.ValidateFieldServer(Id,HandleErrors)
  CASE Id
  OF 9
    GlobalErrors.SetField('SAOL_PASS:TipoPasscode')
    IF INSTRING(']' & SAOL_PASS:TipoPasscode & '[', ']1[]2[]3[]4[]5[]6[', 1, 1) = 0
      ReturnValue = Level:Notify
    END
    IF ReturnValue <> Level:Benign
      IF HandleErrors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInList,'''Permanente'',''Anual'',''Mensual'',''Diario'',''Reset de Fecha'',''Upgrade''')
      END
    END
  END
  RETURN ReturnValue


Hide:Relate:SAOL_Passcode.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:SAOL_Clientes)

  SELF.AddRelation(Relate:SAOL_Software)


Hide:Relate:SAOL_Passcode.Kill PROCEDURE

  CODE
  _Hide:Access:SAOL_Passcode.Kill                          ! Kill the file manager
  PARENT.Kill
  Relate:SAOL_Passcode &= NULL                             ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:SAOL_Passcode)                      ! destroy the file manager

