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
        public string nombreAsegAutotransporteFederal { get; set; }
        public string numPolizaSeguroAutotransporteFederal { get; set; }
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
        public string rFCTransportista { get; set; }
        public string codigoTransportista { get; set; }
        public string numRegIdTribTranspor { get; set; }
        public string residenciaFiscalTranspor { get; set; }
        public string nombreTransportista { get; set; }
        public string rFCEmbarcador { get; set; }
        public string numRegIdTribEmbarc { get; set; }
        public string residenciaFiscalEmbarc { get; set; }
        public string nombreEmbarcador { get; set; }
        //------------
        public string tipoDeServicio { get; set; }
        public string nombreAseg { get; set; }
        public string numPolizaSeguro { get; set; }
        public string concesionario { get; set; }
        //-------------------
        public string cveTransporte { get; set; }
        //----------------------
        public List<Ubicacion> ubicacion { get; set; }
        public List<Mercancia> mercancia { get; set; }
        public List<CantidadTransporta> cantidadTransporta { get; set; }
        public List<Contenedor> contenedor { get; set; }
        public List<DerechosDePaso> derechosDePaso { get; set; }
        public List<Carro> carro { get; set; }
        public List<CarroContenedor> carroContenedor { get; set; }
        public List<Operador> operador { get; set; }
        public List<Propietario> propietario { get; set; }
        public List<Arrendatario> arrendatario { get; set; }
        public List<Notificado> notificado { get; set; }

        public DatosCartaPorte()
        {
            ubicacion = new List<Ubicacion>();
            mercancia = new List<Mercancia>();
            cantidadTransporta = new List<CantidadTransporta>();
            contenedor = new List<Contenedor>();
            derechosDePaso = new List<DerechosDePaso>();
            carro = new List<Carro>();
            carroContenedor = new List<CarroContenedor>();
            operador = new List<Operador>();
            propietario = new List<Propietario>();
            arrendatario = new List<Arrendatario>();
            notificado = new List<Notificado>();


        }

    }
     

       [Serializable()]
       public class Ubicacion
 {
     public int id { get; set; }

     public string tipoEstacion { get; set; }
     public string distanciaRecorrida { get; set; }
     //----
     public string iDOrigen { get; set; }
     public string rFCRemitente { get; set; }
     public string nombreRemitente { get; set; }
     public string numRegIdTribOrigen { get; set; }
     public string residenciaFiscalOrigen { get; set; }
     public string numEstacionOrigen { get; set; }
     public string nombreEstacionOrigen { get; set; }
     public string navegacionTraficoOrigen { get; set; }
     public string fechaHoraSalida { get; set; }
     //----------------- 
     public string iDDestino { get; set; }
     public string rFCDestinatario { get; set; }
     public string nombreDestinatario { get; set; }
     public string numRegIdTribDestino { get; set; }
     public string residenciaFiscalDestino { get; set; }
     public string numEstacionDestino { get; set; }
     public string nombreEstacionDestino { get; set; }
     public string navegacionTraficodestino { get; set; }
     public string fechaHoraProgLlegada { get; set; }
     //----------------  
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
       public class Operador
       {
        public int id { get; set; }
        public string rFCOperador{ get; set; }
        public string numLicencia{ get; set; }
        public string nombreOperador{ get; set; }
        public string numRegIdTribOperador{ get; set; }
        public string residenciaFiscalOperador { get; set; }
         //--
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
       public class Propietario
       {
           public int id { get; set; }
           public string rFCPropietario { get; set; }
           public string nombrePropietario { get; set; }
           public string numRegIdTribPropietario { get; set; }
           public string residenciaFiscalPropietario { get; set; }
           //--
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
       public class Arrendatario
       {
           public int id { get; set; }
           public string rFCArrendatario { get; set; }
           public string nombreArrendatario { get; set; }
           public string numRegIdTribArrendatario { get; set; }
           public string residenciaFiscalArrendatario { get; set; }
           //--
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
       public class Notificado
       {
           public int id { get; set; }
           public string rFCNotificado { get; set; }
           public string nombreNotificado { get; set; }
           public string numRegIdTribNotificado { get; set; }
           public string residenciaFiscalNotificado { get; set; }
           //--
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

}
