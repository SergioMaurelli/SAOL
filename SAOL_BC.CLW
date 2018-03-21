  MEMBER('SAOL.clw')

  PRAGMA('define(init_priority=>3)')

  MAP
    MODULE('SAOL_BC0.CLW')
SAOL_BC0:DctInit             PROCEDURE
SAOL_BC0:DctKill             PROCEDURE
SAOL_BC0:FilesInit           PROCEDURE
    END
    MODULE('SAOL_BC1.CLW')
SAOL_BC1:DctInit             PROCEDURE
SAOL_BC1:DctKill             PROCEDURE
SAOL_BC1:FilesInit           PROCEDURE
    END
  END

DctInit PROCEDURE
  CODE
  SAOL_BC0:DctInit
  SAOL_BC1:DctInit
  SAOL_BC0:FilesInit
  SAOL_BC1:FilesInit


DctKill PROCEDURE
  CODE
  SAOL_BC0:DctKill
  SAOL_BC1:DctKill

