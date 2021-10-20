using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ServicioLocalContract.Entities.ComercioExte
{
    [Serializable()]
 public  class DatosComercioExterior
    {
        public string MotivoTraslado { get; set; }
        public string TipoOperacion { get; set; }
        public string ClaveDePedimento { get; set; }
        public string CertificadoOrigen { get; set; }
        public string NumCertificadoOrigen { get; set; }
        public string NumeroExportadorConfiable { get; set; }
        public string Incoterm { get; set; }
        public string Subdivision { get; set; }
        public string Observaciones { get; set; }
        public string TipoCambioUSD { get; set; }
        public string TotalUSD { get; set; }

        //----------------------
        public Emisor emisor { get; set; }
        public List<Propietario> propietario { get; set; }
        public Receptor receptor { get; set; }
        public List<Destinatario> destinatario { get; set; }   
        public List<Mercancia> mercancia { get; set; }
           

        public DatosComercioExterior()
        {
            emisor = new Emisor();
            propietario = new List<Propietario>();
            receptor = new Receptor();
            destinatario = new List<Destinatario>();
            mercancia = new List<Mercancia>();              

        }

    }
     

      
       [Serializable()]
       public class Mercancia
       {
           public int id { get; set; }
           //---
           public string NoIdentificacion { get; set; }
           public string FraccionArancelaria { get; set; }
           public string CantidadAduana { get; set; }
           public string UnidadAduana { get; set; }
           public string ValorUnitarioAduana { get; set; }
           public string ValorDolares { get; set; }
           
           //------

           public List<DescripcionesEspecificas> descripcionesEspecificas { get; set; }

           public Mercancia()
           {
               descripcionesEspecificas = new List<DescripcionesEspecificas>();
           }
       }
        
       [Serializable()]
       public class DescripcionesEspecificas
       {
           public int id { get; set; }
           public int idMercancia { get; set; }

           public string Marca { get; set; }
           public string Modelo { get; set; }
           public string SubModelo { get; set; }
           public string NumeroSerie { get; set; }


       }


       [Serializable()]
       public class Emisor
       {
        public string Curp { get; set; }
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
           public string NumRegIdTrib { get; set; }
           public string ResidenciaFiscal { get; set; }

       }
       [Serializable()]
       public class Receptor
       {
          public string NumRegIdTrib { get; set; }
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
       public class Destinatario
       {
           public int id { get; set; }
           public string NumRegIdTrib { get; set; }
           public string Nombre { get; set; }
           //--
           public List<Domicilio> domicilio { get; set; }

           public Destinatario()
            {
                domicilio = new List<Domicilio>();
            }
       }
       [Serializable()]
       public class Domicilio
       {
           public int id { get; set; }
           public int idDestinatario { get; set; }
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
