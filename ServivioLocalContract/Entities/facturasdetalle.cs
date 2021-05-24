using System;
using System.Runtime.Serialization;
using ServicioLocalContract.Entities;
using System.Collections.Generic;
namespace ServicioLocalContract
{
    public partial class facturasdetalle
    {
        private bool _redondear = false;


        public decimal TotalPartida
        {
            get
            {
                if (Redondear)
                    return Decimal.Round(this.Cantidad* this.Precio, 2, MidpointRounding.AwayFromZero);
                else return this._Cantidad*this.Precio;
            }

         
        }
        //-------------------------Buenos para CDFI3.3------------------------------------
      //  [DataMemberAttribute]
      //  public string ConceptoClaveProdServ { get; set; }
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


        public facturasdetalle()
        {
        //    NumeroPedimento = null;
        //    ConceptoTraslados = null;
        //    Retenciones = null;
            ConceptoTraslados = new List<facturasdetalleTraslado>();
            ConceptoRetenciones = new List<facturasdetalleRetencion>();
        }
        //--------------------------------------------------------------
        

        [DataMemberAttribute]
        public int Partida { get; set; }
        [DataMemberAttribute]
        public int? PorcentajeIva { get; set; }
        [DataMemberAttribute]
        public decimal? ImporteIva { get; set; }
        [DataMemberAttribute]
        public decimal? PorcentajeRetencionIva { get; set; }
        [DataMemberAttribute]
        public decimal? RetencionIva { get; set; }
        [DataMemberAttribute]
        public string CuentaPredial { get; set; }
        //Artuculos para soriana  jajajaj
        [DataMemberAttribute]
        public int Proveedor { get; set; }
        
        public string folioPedido { get; set; }

        public short tienda { get; set; }

        [DataMemberAttribute]
        public decimal? ISR { get; set; }
       
        //------informacion aduanera
        [DataMemberAttribute]
        public string IAnumero { get; set; }
        [DataMemberAttribute]
        public string IAfecha { get; set; }
        [DataMemberAttribute]
        public string IAaduana { get; set; }
        

        public decimal cantidadUnidadCompra { get; set; }

        public decimal costoNetoUnidadCompra { get; set; }
        [DataMemberAttribute]
        public decimal porcentajeIEPS { get; set; }
        [DataMemberAttribute]
        public decimal porcentajeIVA { get; set; }
    
        [DataMemberAttribute]
        public string Remision { get; set; }
        [DataMemberAttribute]
        public string ModeloConcepto { get; set; }
        //[DataMemberAttribute]
        //public string Pedido { get; set; }

        //[DataMemberAttribute]
        //public string Referencia { get; set; }
        //[DataMemberAttribute]
        //public string Posicion { get; set; }
        //[DataMemberAttribute]
        //public string Pedimento { get; set; }
        //[DataMemberAttribute]
        //public string FacturaPedimento { get; set; }
        [DataMemberAttribute]
        public bool Redondear
        {
            get { return _redondear; }
            set { _redondear = value; }
        }
         [DataMemberAttribute]
        public string nombre { get; set; }
         [DataMemberAttribute]
        public string rfcpago { get; set; }
         [DataMemberAttribute]
        public string CURP { get; set; }
         [DataMemberAttribute]
        public string NivelEducativo { get; set; }
         [DataMemberAttribute]
       
        public string autrvoe { get; set; }
    }
}
