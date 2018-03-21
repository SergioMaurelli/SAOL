

   MEMBER('SAOL.clw')                                      ! This is a MEMBER module

                     MAP
                       INCLUDE('SAOL012.INC'),ONCE        !Local module procedure declarations
                     END


!!! <summary>
!!! Generated from procedure template - Source
!!! </summary>
CrearDirectorio      PROCEDURE  (Directorio)               ! Declare Procedure
ColaLocal QUEUE(FILE:Queue),PRE(QLO)
          END
PathIntermedio CSTRING(261)

  CODE
	Inicio# = 1
	IF Directorio[LEN(Directorio)] <> '\'
		Directorio = Directorio & '\'
	END
	LOOP
		Posicion# = INSTRING('\',Directorio,1,Inicio#)
		IF Posicion# = 0
			BREAK
		ELSE		
			PathIntermedio = SUB(Directorio,1,Posicion#)
			Inicio# = Posicion# + 1
			FREE(ColaLocal)
			DIRECTORY(ColaLocal,PathIntermedio & '*.*',ff_:Directory)
			IF ~RECORDS(ColaLocal)
				IF ~CreateDirectory( PathIntermedio, 0 )
					RETURN False
				END
			END
		END
	END
   RETURN True
