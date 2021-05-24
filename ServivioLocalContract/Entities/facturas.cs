using System;
using System.Collections.Generic;
using System.Runtime.Serialization;
using ServicioLocalContract.Entities;

namespace ServicioLocalContract
{
    public enum TipoDocumento
    {
        FacturaGeneral,
        FacturaTransportista,
        FacturaAduanera,
        Referencia,
        Ingreso,
        ReciboHonorarios,
        Constructor,
        Donativo,
        Honorarios,
        NotaCredito,
        Arrendamiento,
        FacturaGeneralFirmas,
        ConstructorFirmas,
        ConstructorFirmasCustom,
        FacturaLiverpool,
        FacturaMabe,
        FacturaDeloitte,
        FacturaSorianaCEDIS,
        FacturaSorianaTienda,
        FacturaAdo,
        CorporativoAduanal,
        FacturaPemex, 
        FacturaLucent, Nomina, Amc71,CartaPorte, Coppel, HomeDepot, Pilgrims,VehiculoUsado,
        Retenciones, Honda,Amazon,Complementos,ASONIOSCOC,Addenda1888
    }

    public partial class facturas
    {
        [DataMemberAttribute()]
        public Pilgrims AddendaPilgrims { get; set; }
        [DataMemberAttribute()]
        public HomeDepotRequestForPayment AddendaHomeDepot { get; set; }
        [DataMember]
        public AddendaCoppel AddendaCoppelObj { get; set; }
        [DataMember]
        public NominaDto Nomina { get; set; }
        [DataMemberAttribute()]
        public requestForPayment AddendaAmece { get; set; }
        [DataMemberAttribute()]
        public NUMEROPEDIMENTO2 Addenda1888 { get; set; }
        [DataMemberAttribute()]
        public string AgregadoTitulo { get; set; }
        [DataMemberAttribute()]
        public string VoBoTitulo { get; set; }
        [DataMemberAttribute()]
        public string RecibiTitulo { get; set; }
        [DataMemberAttribute()]
        public string AutorizoTitulo { get; set; }
        [DataMemberAttribute()]
        public string NumeroDecimal { get; set; }
      
        //!!
        [DataMemberAttribute()]
        public List<ConceptosCartaPorte> ConceptosCartaPortes { get; set; }

        [DataMemberAttribute()]
        public string FolioSAT { get; set; }
        [DataMemberAttribute()]
        public string AgregadoNombre { get; set; }
        [DataMemberAttribute()]
        public string AgregadoPuesto { get; set; }
        [DataMemberAttribute()]
        public string AgregadoArea { get; set; }

        [DataMemberAttribute()]
        public string VoBoNombre { get; set; }
        [DataMemberAttribute()]
        public string VoBoPuesto { get; set; }
        [DataMemberAttribute()]
        public string VoBoArea { get; set; }

        [DataMemberAttribute()]
        public string RecibiNombre { get; set; }
        [DataMemberAttribute()]
        public string RecibiPuesto { get; set; }
        [DataMemberAttribute()]
        public string RecibiArea { get; set; }

        [DataMemberAttribute()]
        public string AutorizoNombre { get; set; }
        [DataMemberAttribute()]
        public string AutorizoPuesto { get; set; }
        [DataMemberAttribute()]
        public string AutorizoArea { get; set; }


        [DataMemberAttribute()]
        public string DonativoVersion { get; set; }
        [DataMemberAttribute()]
        public string DonativoAutorizacion { get; set; }
        [DataMemberAttribute()]
        public DateTime DonativoFechaAutorizacion { get; set; }
        [DataMemberAttribute()]
        public string DonativoLeyenda { get; set; }

        [DataMemberAttribute()]
        public string LucentOrdenCompra { get; set; }
        [DataMemberAttribute()]
        public string LucentRef { get; set; }


        [DataMemberAttribute()]
        public string TituloOtros { get; set; }

        [DataMemberAttribute()]
        public bool NotaCredito { get; set; }

        [DataMemberAttribute()]
        public string LeyendaSuperior { get; set; }

        [DataMemberAttribute()]
        public string FormaPago { get; set; }

        [DataMemberAttribute()]
        public string LeyendaInferior { get; set; }


        [DataMemberAttribute()]
        public DatosFacturaAduanera DatosAduanera { get; set; }

        public List<facturasdetalle> ConceptosAduanera { get; set; }

        [DataMemberAttribute()]
        public string Leyenda { get; set; }

        [DataMemberAttribute()]
        public string TipoDeComprobante { get; set; }

        [DataMemberAttribute()]
        public TipoDocumento TipoDocumento;

        [DataMemberAttribute()]
        public TipoDocumento TipoDocumentoSAT;

        [DataMemberAttribute()]
        public string Regimen { get; set; }

        [DataMemberAttribute()]
        public string Metodo { get; set; }
        [DataMemberAttribute()]
        public string MetodoID { get; set; }//nuevo
       
        [DataMemberAttribute()]
        public string FormaPagoID { get; set; }//nuevo
        [DataMemberAttribute()]
         public string Cuenta { get; set; }
        [DataMemberAttribute()]
        public string MonedaID { get; set; }
        [DataMemberAttribute()]
        public string Confirmacion { get; set; }
      

        [DataMemberAttribute()]
        public string MonedaS { get; set; }
        [DataMemberAttribute]
        public string LugarExpedicion { get; set; }

        [DataMemberAttribute]
        public string FolioFiscalOriginal { get; set; }

        [DataMemberAttribute]
        public string SerieFolioFiscalOriginal { get; set; }

        [DataMemberAttribute]
        public DateTime? FechaFolioFiscalOriginal { get; set; }

        [DataMemberAttribute]
        public decimal? MontoFolioFiscalOriginal { get; set; }

        [DataMemberAttribute]
        public string CondicionesPado { get; set; }

        [DataMemberAttribute]
        public Decimal PorcentajeRetenciónIva { get; set; }

        [DataMemberAttribute]
        public Decimal PorcentajeRetenciónIsr { get; set; }

        [DataMemberAttribute]
        public Decimal RetencionIva { get; set; }

        [DataMemberAttribute]
        public Decimal RetencionIsr { get; set; }

        // Addenda PEMEX -- SZ
        [DataMemberAttribute]
        public FacturasAddendaPemex FacturasAddendaPemex { get; set; }
        // Fin Addenda Pemex -- SZ

        //addendaHonda
        [DataMemberAttribute]
        public DatosAddendaHonda FacturasAddendaHonda { get; set; }

        //addenda Amazon
        [DataMemberAttribute]
        public DatosAmazon FacturasAddenAmazon { get; set; }

        //addenda DatosASONIOSCOC
        [DataMemberAttribute]
        public DatosASONIOSCOC FacturasAddenASONIOSCOC { get; set; }

        [DataMember]
        public detallista Detallista { get; set; }

        //impuestosLocales
        [DataMemberAttribute]
        public ImpLocales ImpuestosLocales { get; set; }
        [DataMemberAttribute]
        public List<string> UUID { get; set; }
        [DataMemberAttribute]
        public string TipoRelacion { get; set; }
        [DataMemberAttribute]
        public ServicioParcialConstruccion parcialesconstruccion  { get; set; }

        public override string ToString()
        {
            
            return this.Folio + "|" + this.idcliente + "|" + this.Fecha.ToString("dd/MM/yyyy") + "|" + this.Importe;
        }

        [DataMemberAttribute]
        public string UsoCFDI { get; set; }

        
    }
}
