using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;

namespace ServicioLocalContract.Entities
{
    [Serializable()]
  public  class ServicioParcialConstruccion
    {
       [DataMemberAttribute]
        public string Version { get; set; }//decimal
       [DataMemberAttribute]
        public string NumPerLicoAut { get; set; }//decimal
       [DataMemberAttribute]
        public string Calle { get; set; }//decimal
       [DataMemberAttribute]
        public string NoExterior { get; set; }//decimal
       [DataMemberAttribute]
        public string NoInterior { get; set; }//decimal
       [DataMemberAttribute]
        public string Colonia { get; set; }//decimal
       [DataMemberAttribute]
        public string Localidad { get; set; }//decimal
       [DataMemberAttribute]
        public string Referencia { get; set; }//decimal
       [DataMemberAttribute]
        public string Municipio { get; set; }//decimal
       [DataMemberAttribute]
        public string Estado { get; set; }//decimal
       [DataMemberAttribute]
        public string CodigoPostal { get; set; }//decimal

    }
}
