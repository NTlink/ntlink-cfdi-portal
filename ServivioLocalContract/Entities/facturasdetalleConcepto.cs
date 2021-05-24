using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;

namespace ServicioLocalContract.Entities
{
     [Serializable()]

   public class facturasdetalleConcepto
    {
        [DataMemberAttribute]
        public string ConceptoClaveProdServ { get; set; }
        [DataMemberAttribute]
        public string ConceptoNoIdentificacion { get; set; }
        [DataMemberAttribute]
        public decimal ConceptoCantidad { get; set; }
        [DataMemberAttribute]
        public string ConceptoClaveUnidad { get; set; }
        [DataMemberAttribute]
        public string ConceptoUnidad { get; set; }
        [DataMemberAttribute]
        public string ConceptoDescripcion { get; set; }
        [DataMemberAttribute]
        public decimal ConceptoValorUnitario { get; set; }
        [DataMemberAttribute]
        public decimal ConceptoImporte { get; set; }
        [DataMemberAttribute]
        public decimal? ConceptoDescuento { get; set; }
      
    }
}
