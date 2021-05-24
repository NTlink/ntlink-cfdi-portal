using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ServicioLocalContract.Entities
{
   public class DatosAddendaHonda
    {

        public string fecha { get; set; }
        public string folio { get; set; }
        public string ASNNumber { get; set; }
        public string moneda { get; set; }
        public string tipoComprobante { get; set; }
        public string tipoDocumento { get; set; }
        public string rfc { get; set; }
        public string ShipTo { get; set; }
        public string numeroProveedor { get; set; }
        public string PlantCode { get; set; }
        public string ReferenceNumber { get; set; }    
    }
}
