

   MEMBER('SAOL.clw')                                      ! This is a MEMBER module

                     MAP
                       INCLUDE('SAOL009.INC'),ONCE        !Local module procedure declarations
                     END


!!! <summary>
!!! Generated from procedure template - Source
!!! </summary>
GrabarLog            PROCEDURE  (idInstalador,Descripcion,Observaciones) ! Declare Procedure

  CODE
	SAOL_LOG:idInstalador  = idInstalador
	SAOL_LOG:Fecha         = TODAY()
	SAOL_LOG:Hora          = CLOCK()
	SAOL_LOG:Descripcion   = Descripcion
	SAOL_LOG:Observaciones = Observaciones
	IF Access:SAOL_Log.Insert() <> Level:Benign
		MESSAGE('Error al Grabar Log: idInstalador: ' & idInstalador & '|Descripción: ' & Descripcion & '|Observaciones: ' & Observaciones,'Atención !',ICON:HAND)
	END
	RETURN
