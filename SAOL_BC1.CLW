  MEMBER('SAOL.clw')

  INCLUDE('ABFILE.INC'),ONCE

  MAP
SAOL_BC1:DctInit    PROCEDURE
SAOL_BC1:DctKill    PROCEDURE
SAOL_BC1:FilesInit  PROCEDURE
  END

Hide:Access:SAOL_Log CLASS(FileManager),TYPE               ! FileManager for SAOL_Log
BindFields             PROCEDURE(),DERIVED
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:SAOL_Log CLASS(RelationManager),TYPE           ! RelationManager for SAOL_Log
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END


_Hide:Access:SAOL_Log &Hide:Access:SAOL_Log,AUTO,THREAD
_Hide:Relate:SAOL_Log &Hide:Relate:SAOL_Log,AUTO,THREAD


SAOL_BC1:DctInit PROCEDURE
  CODE
  _Hide:Access:SAOL_Log &= NEW(Hide:Access:SAOL_Log)
  _Hide:Relate:SAOL_Log &= NEW(Hide:Relate:SAOL_Log)
  Relate:SAOL_Log &= _Hide:Relate:SAOL_Log


SAOL_BC1:FilesInit PROCEDURE
  CODE
  _Hide:Relate:SAOL_Log.Init


SAOL_BC1:DctKill PROCEDURE
  CODE
  _Hide:Relate:SAOL_Log.Kill
  DISPOSE(_Hide:Relate:SAOL_Log)


Hide:Relate:SAOL_Log.Init PROCEDURE
  CODE
  _Hide:Access:SAOL_Log.Init
  SELF.Init(Access:SAOL_Log,1)


Hide:Access:SAOL_Log.BindFields PROCEDURE

  CODE
  PARENT.BindFields
  BIND('SAOL_LOG:Observaciones',SAOL_LOG:Observaciones)    ! Bind memo field


Hide:Access:SAOL_Log.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= SAOL_LOG:Record
  SELF.FileNameValue = 'SAOL_Log'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= SAOL_Log
  PARENT.Init
  Access:SAOL_Log &= SELF


Hide:Access:SAOL_Log.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:SAOL_Log &= NULL                                  ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:SAOL_Log.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(SAOL_Log,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(SAOL_LOG:PorID,'Por Id',1)
    SELF.AddKey(SAOL_LOG:PorInstalador,'Por Instalador',0)
    SELF.AddKey(SAOL_LOG:PorDescripcion,'Por Descripción',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:SAOL_Log.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:SAOL_Instaladores)


Hide:Relate:SAOL_Log.Kill PROCEDURE

  CODE
  _Hide:Access:SAOL_Log.Kill                               ! Kill the file manager
  PARENT.Kill
  Relate:SAOL_Log &= NULL                                  ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:SAOL_Log)                           ! destroy the file manager

