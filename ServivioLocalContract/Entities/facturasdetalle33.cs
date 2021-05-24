using System;
using System.Runtime.Serialization;
using ServicioLocalContract.Entities;
using System.Collections.Generic;
namespace ServicioLocalContract
{
    public partial class facturasdetalle33
    {
        private bool _redondear = false;


        
        //-------------------------Buenos para CDFI3.3------------------------------------
        [DataMemberAttribute]
        public string ConceptoClaveProdServ { get; set; }
        [DataMemberAttribute]
        public string ConceptoNoIdentificacion { get; set; }
       // [DataMemberAttribute]
       // public decimal ConceptoCantidad { get; set; }
        [DataMemberAttribute]
        public string ConceptoClaveUnidad { get; set; }
       // [DataMemberAttribute]
       // public string ConceptoUnidad { get; set; }
       // [DataMemberAttribute]
       // public string ConceptoDescripcion { get; set; }
       // [DataMemberAttribute]
       // public decimal ConceptoValorUnitario { get; set; }
       // [DataMemberAttribute]
       // public decimal ConceptoImporte { get; set; }
        [DataMemberAttribute]
        public decimal? ConceptoDescuento { get; set; }
       
        public List<string> NumeroPedimento { get; set; }//de informacion aduanera

        public List< facturasdetalleTraslado> ConceptoTraslados { get; set; }
        public List<facturasdetalleRetencion> ConceptoRetenciones { get; set; }
        
        [DataMemberAttribute]
        public string ConceptoCuentaPredial { get; set; }
        [DataMemberAttribute]
        
        public facturasdetalleParte ConceptoParte { get; set; }
        [DataMemberAttribute]
        public string partida { get; set; }

       
     

        public facturasdetalle33()
        {
        //    NumeroPedimento = null;
        //    ConceptoTraslados = null;
        //    Retenciones = null;
            ConceptoTraslados = new List<facturasdetalleTraslado>();
            ConceptoRetenciones = new List<facturasdetalleRetencion>();
        }
        //--------------------------------------------------------------
        

    }
}
