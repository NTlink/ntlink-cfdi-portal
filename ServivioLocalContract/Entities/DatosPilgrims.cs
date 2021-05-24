using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;

namespace ServicioLocalContract.Entities
{
    [Serializable()]
   public class DatosPilgrims
    {

        [DataMemberAttribute]
        public string Referencia { get; set; }
        [DataMemberAttribute]
        public string Posicion { get; set; }
        [DataMemberAttribute]
        public string Pedimento { get; set; }
        [DataMemberAttribute]
        public string FacturaPedimento { get; set; }
        [DataMemberAttribute]
        public string Pedido { get; set; }

    }
}
