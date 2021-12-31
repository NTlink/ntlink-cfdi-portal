using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ServicioLocalContract.Entities.Carta;
using ServicioLocalContract.Entities.ComercioExte;

namespace ServicioLocalContract.Entities
{
       [Serializable()]
 
  public  class facturaComplementos
    {
        public List<Pagos> pagos;
        public INE ine;
        public VehiculoUsado vehiculoUsado;
        public DatosCartaPorte datosCartaPorte;
        public DatosComercioExterior datosComercioExterior;
    }

}
