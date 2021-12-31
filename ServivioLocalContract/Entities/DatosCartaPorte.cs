using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ServicioLocalContract.Entities.Carta
{
    [Serializable()]
 public  class DatosCartaPorte
    {
        public string entradaSalidaMerc { get; set; }
        public string viaEntradaSalida { get; set; }
        public decimal? totalDistRec { get; set; }
        public string transpInternac { get; set; }
        public string PaisOrigenDestino { get; set; }

        //-------------
        public decimal? pesoBrutoTotal { get; set; }
        public string unidadPeso { get; set; }
        public decimal? pesoNetoTotal { get; set; }
        public int numTotalMercancias { get; set; }
        public decimal? cargoPorTasacion { get; set; }
        //---------
        public string configVehicular { get; set; }
        public string placaVM { get; set; }
        public int anioModeloVM { get; set; }
        public string subTipoRem1 { get; set; }
        public string placa1 { get; set; }
        public string subTipoRem2 { get; set; }
        public string placa2 { get; set; }

        public string permSCTAutotransporteFederal { get; set; }
        public string numPermisoSCTAutotransporteFederal { get; set; }
        public string AseguraRespCivil{ get; set; }
        public string PolizaRespCivil{ get; set; }
        public string AseguraMedAmbiente{ get; set; }
        public string PolizaMedAmbiente { get; set; }
        public string AseguraCarga{ get; set; }
        public string PolizaCarga { get; set; }
        public string PrimaSeguro { get; set; }
       
        //--------
        public string permSCTTransporteMaritimo { get; set; }
        public string numPermisoSCTTransporteMaritimo { get; set; }
        public string nombreAsegTransporteMaritimo { get; set; }
        public string numPolizaSeguroTransporteMaritimo { get; set; }
        public string tipoEmbarcacion { get; set; }
        public string matricula { get; set; }
        public string numeroOMI { get; set; }
        public int? anioEmbarcacion { get; set; }
        public string nombreEmbarc { get; set; }
        public string nacionalidadEmbarc { get; set; }
        public decimal unidadesDeArqBruto { get; set; }
        public string tipoCarga { get; set; }
        public string numCertITC { get; set; }
        public decimal? eslora { get; set; }
        public decimal? manga { get; set; }
        public decimal? calado { get; set; }
        public string lineaNaviera { get; set; }
        public string nombreAgenteNaviero { get; set; }
        public string numAutorizacionNaviero { get; set; }
        public string numViaje { get; set; }
        public string numConocEmbarc { get; set; }
        //------------
        public string permSCT { get; set; }
        public string numPermisoSCT { get; set; }
        public string matriculaAeronave { get; set; }//
        public string nombreAsegTransporteAereo { get; set; }
        public string numPolizaSeguroTransporteAereo { get; set; }
        public string numeroGuia { get; set; }
        public string lugarContrato { get; set; }
        public string codigoTransportista { get; set; }
        public string rFCEmbarcador { get; set; }
        public string numRegIdTribEmbarc { get; set; }
        public string residenciaFiscalEmbarc { get; set; }
        public string nombreEmbarcador { get; set; }
        //------------
        public string tipoDeServicio { get; set; }
        public string nombreAseg { get; set; }
        public string numPolizaSeguro { get; set; }
        public string tipoDeTrafico { get; set; }
        //-------------------
        public List<Ubicacion> ubicacion { get; set; }
        public List<Mercancia> mercancia { get; set; }
        public List<CantidadTransporta> cantidadTransporta { get; set; }
        public List<GuiasIdentificacion> guiasIdentificacion { get; set; }
        public List<Pedimentos> pedimentos { get; set; }

        public List<Contenedor> contenedor { get; set; }
        public List<DerechosDePaso> derechosDePaso { get; set; }
        public List<Carro> carro { get; set; }
        public List<CarroContenedor> carroContenedor { get; set; }
        public List<TiposFigura> tiposFigura { get; set; }
        public List<PartesTransporte> partesTransporte { get; set; }
   
        public DatosCartaPorte()
        {
            ubicacion = new List<Ubicacion>();
            mercancia = new List<Mercancia>();
            cantidadTransporta = new List<CantidadTransporta>();
            guiasIdentificacion = new List<GuiasIdentificacion>();
            pedimentos = new List<Pedimentos>();
            contenedor = new List<Contenedor>();
            derechosDePaso = new List<DerechosDePaso>();
            carro = new List<Carro>();
            carroContenedor = new List<CarroContenedor>();
            tiposFigura = new List<TiposFigura>();
            partesTransporte = new List<PartesTransporte>();
        }

    }
     

       [Serializable()]
       public class Ubicacion
 {
     public int id { get; set; }
     public string tipoUbicacion { get; set; }
     public string iDUbicacion { get; set; }
     public string rFCRemitenteDestinatario { get; set; }
     public string nombreRemitenteDestinatario { get; set; }
     public string numRegIdTrib { get; set; }
     public string residenciaFiscal { get; set; }
     public string numEstacion { get; set; }
     public string nombreEstacion { get; set; }
     public string navegacionTrafico { get; set; }
     public string fechaHoraSalidaLlegada { get; set; }
     public string tipoEstacion { get; set; }
     public string distanciaRecorrida { get; set; }
    //---------------------
     public string calle { get; set; }
     public string numeroExterior { get; set; }
     public string numeroInterior { get; set; }
     public string colonia { get; set; }
     public string localidad { get; set; }
     public string referencia { get; set; }
     public string municipio { get; set; }
     public string estado { get; set; }
     public string pais { get; set; }
     public string codigoPostal { get; set; }


 }

       [Serializable()]
       public class Mercancia
       {
           public int id { get; set; }

              //---
           public string bienesTransp { get; set; }
           public string claveSTCC { get; set; }
           public string descripcion { get; set; }
           public string cantidad { get; set; }
           public string claveUnidad { get; set; }
           public string unidad { get; set; }
           public string dimensiones { get; set; }
           public string materialPeligroso { get; set; }
           public string cveMaterialPeligroso { get; set; }
           public string embalaje { get; set; }
           public string descripEmbalaje { get; set; }
           public decimal pesoEnKg { get; set; }
           public decimal? valorMercancia { get; set; }
           public string moneda { get; set; }
           public string fraccionArancelaria { get; set; }
           public string uUIDComercioExt { get; set; }
           //------
           public string unidadPesoDetalle { get; set; }
           public decimal pesoBruto { get; set; }
           public decimal pesoNeto { get; set; }
           public decimal pesoTara { get; set; }
           public int? numPiezas { get; set; }


           
       }
       [Serializable()]
       public class GuiasIdentificacion
       {
           public int id { get; set; }
           public string NumeroGuiaIdentificacion { get; set; }
           public string DescripGuiaIdentificacion { get; set; }
           public string PesoGuiaIdentificacion { get; set; }
        
       
       }
       [Serializable()]
       public class Pedimentos
       {
           public int id { get; set; }
           public string Pedimento { get; set; }


       }
       [Serializable()]
       public class CantidadTransporta
       {
           public int id { get; set; }

           public decimal cantidad { get; set; }
           public string iDOrigen { get; set; }
           public string iDDestino { get; set; }
           public string cvesTransporte { get; set; }


       }
       [Serializable()]
       public class Contenedor
       {
           public int id { get; set; }
           public string matriculaContenedor { get; set; }
           public string tipoContenedor { get; set; }
           public string numPrecinto { get; set; }

       }
       [Serializable()]
       public class DerechosDePaso
       {
           public int id { get; set; }
           public string tipoDerechoDePaso { get; set; }
           public decimal kilometrajePagado { get; set; }

       }
       [Serializable()]
       public class Carro
       {
           public int id { get; set; }
           public string tipoCarro { get; set; }
           public string matriculaCarro { get; set; }
           public string guiaCarro { get; set; }
           public decimal toneladasNetasCarro { get; set; }

       }
       [Serializable()]
       public class CarroContenedor
       {
           public int id { get; set; }
           public string tipoContenedor { get; set; }
           public decimal pesoContenedorVacio { get; set; }
           public decimal pesoNetoMercancia { get; set; }

       }
       [Serializable()]
       public class TiposFigura
       {
           public int id { get; set; }
           public string TipoFigura { get; set; }
           public string RFCFigura { get; set; }
           public string NumLicencia { get; set; }
           public string NombreFigura { get; set; }
           public string NumRegIdTribFigura { get; set; }
           public string ResidenciaFiscalFigura { get; set; }
           //---------------------
           public string calle { get; set; }
           public string numeroExterior { get; set; }
           public string numeroInterior { get; set; }
           public string colonia { get; set; }
           public string localidad { get; set; }
           public string referencia { get; set; }
           public string municipio { get; set; }
           public string estado { get; set; }
           public string pais { get; set; }
           public string codigoPostal { get; set; }

       }
       [Serializable()]
       public class PartesTransporte
       {
           public int id { get; set; }
           public string ParteTransporte { get; set; }
       }

}
