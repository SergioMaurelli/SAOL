

   MEMBER('SAOL.clw')                                      ! This is a MEMBER module

                     MAP
                       INCLUDE('SAOL011.INC'),ONCE        !Local module procedure declarations
                     END


!!! <summary>
!!! Generated from procedure template - Source
!!! </summary>
FtpPath              PROCEDURE  (Path)                     ! Declare Procedure
cPath                CSTRING(FILE:MaxFilePath)
cFtpPath             CSTRING(FILE:MaxFilePath)

  CODE
	cPath    = CLIP(LEFT(Path))
	cFtpPath = ''

	LOOP I# = 1 TO LEN(cPath)
		CASE UPPER(cPath[I#])
			OF '0' TO '9'
				cFtpPath = cFtpPath & cPath[I#]
			OF 'A' TO 'Z'
				cFtpPath = cFtpPath & cPath[I#]
			OF '\'
				cFtpPath = cFtpPath & '/'
			ELSE
				cFtpPath = cFtpPath & '_'
		END			
	END
	RETURN LOWER(cFtpPath)
