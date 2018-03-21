

   MEMBER('SAOL.clw')                                      ! This is a MEMBER module

                     MAP
                       INCLUDE('SAOL010.INC'),ONCE        !Local module procedure declarations
                     END


!!! <summary>
!!! Generated from procedure template - Source
!!! </summary>
GetFileVersion       PROCEDURE  (STRING cFileName,*LONG Major,*LONG Minor,*LONG Revision,*LONG Build,*LONG Fecha,*LONG Hora,*BYTE EsEjecutable) ! Declare Procedure
VS_FixedFileInfo    Group,Type
dwSignature             Long ! fixed to 0xFEEFO4BD
dwStructVersion         Long
dwFileVersionMS         Long
dwFileVersionLS         Long
dwProductVersionMS      Long
dwProductVersionLS      Long
dwFileFlagsMask         Long
dwFileFlags             Long
dwFileOS                Long
dwFileType              Long
dwFileSubtype           Long
dwFileDateMS            Long
dwFileDateLS            Long
                    End

filename_string         cstring(200)
buffersize              long
unusedvar               long
rawversioninfobuffer    byte,dim(2048)
rawqueryinfobuffer      byte,dim(2048)
subblock_string         cstring(50)
temp_ptr                long
version_info            like(VS_FixedFileInfo)
versionstring           cstring(100)          ! final version number

returnvalue             BYTE

extension cstring(260)

ColaLocal QUEUE(FILE:Queue),PRE(QLOC)
          END

Version    CSTRING(151)
cMajor     CSTRING(21)
cMinor     CSTRING(21)
cRevision  CSTRING(21)
cBuild     CSTRING(21)
cVersion   CSTRING(151)

  CODE
	returnvalue = False
	Major    = 0
	Minor    = 0
	Revision = 0
	Build    = 0
	Fecha    = 0
	Hora     = 0

	filename_string = CLIP(cFileName)
	n# = LEN(filename_string)-INSTRING('.',filename_string,-1,LEN(filename_string))
	extension = SUB(filename_string,-n#,n#)

	DIRECTORY(ColaLocal,filename_string,ff_:NORMAL+ff_:READONLY+ff_:HIDDEN+ff_:SYSTEM)
	GET(ColaLocal,1)
	Fecha = ColaLocal.date
	Hora  = ColaLocal.time
	FREE(ColaLocal)

   if extension = 'EXE' or extension = 'DLL'
      EsEjecutable = True
		buffersize = GetFileVersionInfoSize( address(filename_string),address(unusedvar))
		if bufferSize = 0 
			! no version information, or file does not exist
		else
		  ! get version resource itself, using size retreived earlier
		  if GetFileVersionInfo( address(filename_string), unusedvar, buffersize, address(rawversioninfobuffer) ) = 0
			 ! did not read version information
			else
				! read version information
				! now set the string to look for the (VS_FixedFileInfo information
				subblock_string = '\'
				! set up our temporary pointer
				temp_ptr = address(rawqueryinfobuffer)
				if VerQueryValue( address(RawVersionInfoBuffer), |
										 address(subblock_string), |
										 address(temp_ptr), |
										 address(buffersize) ) = 0
					! error - the original string in subblock_string was probably wrong
				else
					memcpy( Address(version_info), temp_ptr , buffersize)
					! got version information successfully
					!
					! For a Win2000 NTDLL.DLL with a version number of 5.0.2195.2779
					! you should get back dwProductVersionMS and dwProductVersionLS values of
					! 327680 (00050000 hex = 5.0) and 143854299 (08930ADB hex = 2195.2779)

					! part2# = band(version_info:dwProductVersionMS,0FFFFH)
					! part1# = bshift(version_info:dwProductVersionMS,-16)
					!
					! part4# = band(version_info:dwProductVersionLS,0FFFFH)
					! part3# = bshift(version_info:dwProductVersionLS,-16)

					Minor    = band(version_info:dwFileVersionMS,0FFFFH)
					Major    = bshift(version_info:dwFileVersionMS,-16)

					Build    = band(version_info:dwFileVersionLS,0FFFFH)
					Revision = bshift(version_info:dwFileVersionLS,-16)

					returnvalue = True
				end
			end
		end
	else
      EsEjecutable = False
		if extension = 'TXR'
			Version = GETINI('LIBRARY','DESCRIPTION(''VERSION','',filename_string)
			IF CLIP(Version)
            cVersion = Version
				C# = 1
				cMajor    = ''
				cMinor    = ''
				cRevision = ''
				cBuild    = ''
				LOOP I# = 1 TO LEN(cVersion)
					IF cVersion[I#] = '.'
						C# += 1
						IF C# > 4
							BREAK
						END
					ELSE
						IF NOT NUMERIC(cVersion[I#])
							BREAK
						END
						CASE C#
							OF 1
								cMajor = cMajor & cVersion[I#]
							OF 2
								cMinor = cMinor & cVersion[I#]
							OF 3
								cRevision = cRevision & cVersion[I#]
							OF 4
								cBuild = cBuild & cVersion[I#]
						END
					END
				END
				Major     = cMajor
				Minor     = cMinor
				Revision  = cRevision
				Build     = cBuild
				returnvalue = True
			END
		end
	end
	RETURN returnvalue
