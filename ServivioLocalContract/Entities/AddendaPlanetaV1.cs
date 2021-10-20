using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ServicioLocalContract.Entities
{
    [Serializable()]
 
    public class AddendaPlanetaV1
    {
        public List<DetalleADDOC> detalleADDOC { get; set; }
        public string Empresa { get; set; }
        public string FechaADDOC { get; set; }
        public string Folio { get; set; }
        public string Requisicion { get; set; }

        public AddendaPlanetaV1(){
            detalleADDOC = new List<DetalleADDOC>();
    }

    }
    [Serializable()]
    public class DetalleADDOC
    {
        public int Linea { get; set; }
        public string ProcesoProd { get; set; }
        public string TipoTrabajo { get; set; }
        public string HojaTrabajo { get; set; }
        public string Codigo { get; set; }
        public string Cantidad { get; set; }
        public string PrecioUnitario { get; set; }
        public string Descripcion { get; set; }
        public string ImporteTotal { get; set; }
    }

}
