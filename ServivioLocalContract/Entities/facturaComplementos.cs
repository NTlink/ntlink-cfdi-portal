using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ServicioLocalContract.Entities
{
       [Serializable()]
 
  public  class facturaComplementos
    {
        public List<Pagos> pagos;
        public INE ine;
        public VehiculoUsado vehiculoUsado;
    }

}
