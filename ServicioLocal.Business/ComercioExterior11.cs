
namespace EspacioComercioExterior11
{
    using System;
    using System.Diagnostics;
    using System.Xml.Serialization;
    using System.Collections;
    using System.Xml.Schema;
    using System.ComponentModel;
    using System.Collections.Generic;

    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true, Namespace = "http://www.sat.gob.mx/ComercioExterior11")]
    [System.Xml.Serialization.XmlRootAttribute(Namespace = "http://www.sat.gob.mx/ComercioExterior11", IsNullable = false)]
    public partial class ComercioExterior
    {

        private ComercioExteriorEmisor emisorField;

        private ComercioExteriorPropietario[] propietarioField;

        private ComercioExteriorReceptor receptorField;

        private List<ComercioExteriorDestinatario> destinatarioField;

        private List<ComercioExteriorMercancia> mercanciasField;

        private string versionField;
               
        private string motivoTrasladoField;

        private bool motivoTrasladoFieldSpecified;

        private string tipoOperacionField;
        
        private string claveDePedimentoField;

        private bool claveDePedimentoFieldSpecified;

        private int certificadoOrigenField;

        private bool certificadoOrigenFieldSpecified;

        private string numCertificadoOrigenField;

        private string numeroExportadorConfiableField;

        private string incotermField;

        private bool incotermFieldSpecified;

        private int subdivisionField;

        private bool subdivisionFieldSpecified;

        private string observacionesField;

        private decimal tipoCambioUSDField;

        private bool tipoCambioUSDFieldSpecified;

        private decimal totalUSDField;

        private bool totalUSDFieldSpecified;

        public ComercioExterior()
        {/*
            this.mercanciasField = new List<ComercioExteriorMercancia>();
            this.destinatarioField = new List<ComercioExteriorDestinatario>();
            this.receptorField = new ComercioExteriorReceptor();
            this.propietarioField = new List<ComercioExteriorPropietario>();
            this.emisorField = new ComercioExteriorEmisor();
          */
            this.versionField = "1.1";
        }
       public ComercioExteriorEmisor Emisor
        {
            get
            {
                return this.emisorField;
            }
            set
            {
                this.emisorField = value;
            }
        }
         [XmlElement("Propietario")]
       public ComercioExteriorPropietario[] Propietario
        {
            get
            {
                return this.propietarioField;
            }
            set
            {
                this.propietarioField = value;
            }
        }
     
        public ComercioExteriorReceptor Receptor
        {
            get
            {
                return this.receptorField;
            }
            set
            {
                this.receptorField = value;
            }
        }
          [XmlElement("Destinatario")]
      
         public List<ComercioExteriorDestinatario> Destinatario
        {
            get
            {
                return this.destinatarioField;
            }
            set
            {
                this.destinatarioField = value;
            }
        }

        [System.Xml.Serialization.XmlArrayItemAttribute("Mercancia", IsNullable = false)]
        public List<ComercioExteriorMercancia> Mercancias
        {
            get
            {
                return this.mercanciasField;
            }
            set
            {
                this.mercanciasField = value;
            }
        }

         [System.Xml.Serialization.XmlAttributeAttribute()]
        public string Version
        {
            get
            {
                return this.versionField;
            }
            set
            {
                this.versionField = value;
            }
        }
         [System.Xml.Serialization.XmlAttributeAttribute()]
         public string MotivoTraslado
       
        {
            get
            {
                return this.motivoTrasladoField;
            }
            set
            {
                this.motivoTrasladoField = value;
               
            }
        }

        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool MotivoTrasladoSpecified
        {
            get
            {
                return this.motivoTrasladoFieldSpecified;
            }
            set
            {
                this.motivoTrasladoFieldSpecified = value;
            }
        }
 
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string TipoOperacion
        {
            get
            {
                return this.tipoOperacionField;
            }
            set
            {
                this.tipoOperacionField = value;
            }
        }
         [System.Xml.Serialization.XmlAttributeAttribute()]
        public string ClaveDePedimento
        {
            get
            {
                return this.claveDePedimentoField;
            }
            set
            {
                this.claveDePedimentoField = value;
            }
        }

        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool ClaveDePedimentoSpecified
        {
            get
            {
                return this.claveDePedimentoFieldSpecified;
            }
            set
            {
                this.claveDePedimentoFieldSpecified = value;
            }
        }
         [System.Xml.Serialization.XmlAttributeAttribute()]
        public int CertificadoOrigen
        {
            get
            {
                return this.certificadoOrigenField;
            }
            set
            {
                this.certificadoOrigenField = value;
            }
        }

        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool CertificadoOrigenSpecified
        {
            get
            {
                return this.certificadoOrigenFieldSpecified;
            }
            set
            {
                this.certificadoOrigenFieldSpecified = value;
            }
        }
         [System.Xml.Serialization.XmlAttributeAttribute()]
        public string NumCertificadoOrigen
        {
            get
            {
                return this.numCertificadoOrigenField;
            }
            set
            {
                this.numCertificadoOrigenField = value;
            }
        }
         [System.Xml.Serialization.XmlAttributeAttribute()]
        public string NumeroExportadorConfiable
        {
            get
            {
                return this.numeroExportadorConfiableField;
            }
            set
            {
                this.numeroExportadorConfiableField = value;
            }
        }
         [System.Xml.Serialization.XmlAttributeAttribute()]
        public string Incoterm
        {
            get
            {
                return this.incotermField;
            }
            set
            {
                this.incotermField = value;
            }
        }

        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool IncotermSpecified
        {
            get
            {
                return this.incotermFieldSpecified;
            }
            set
            {
                this.incotermFieldSpecified = value;
            }
        }
         [System.Xml.Serialization.XmlAttributeAttribute()]
        public int Subdivision
        {
            get
            {
                return this.subdivisionField;
            }
            set
            {
                this.subdivisionField = value;
            }
        }

        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool SubdivisionSpecified
        {
            get
            {
                return this.subdivisionFieldSpecified;
            }
            set
            {
                this.subdivisionFieldSpecified = value;
            }
        }
         [System.Xml.Serialization.XmlAttributeAttribute()]
        public string Observaciones
        {
            get
            {
                return this.observacionesField;
            }
            set
            {
                this.observacionesField = value;
            }
        }
         [System.Xml.Serialization.XmlAttributeAttribute()]
        public decimal TipoCambioUSD
        {
            get
            {
                return this.tipoCambioUSDField;
            }
            set
            {
                this.tipoCambioUSDField = value;
            }
        }

        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool TipoCambioUSDSpecified
        {
            get
            {
                return this.tipoCambioUSDFieldSpecified;
            }
            set
            {
                this.tipoCambioUSDFieldSpecified = value;
            }
        }
         [System.Xml.Serialization.XmlAttributeAttribute()]
        public decimal TotalUSD
        {
            get
            {
                return this.totalUSDField;
            }
            set
            {
                this.totalUSDField = value;
            }
        }

        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool TotalUSDSpecified
        {
            get
            {
                return this.totalUSDFieldSpecified;
            }
            set
            {
                this.totalUSDFieldSpecified = value;
            }
        }
    }

    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true, Namespace = "http://www.sat.gob.mx/ComercioExterior11")]
   
    public partial class ComercioExteriorEmisor
    {

        private ComercioExteriorEmisorDomicilio domicilioField;

        private string curpField;

        public ComercioExteriorEmisor()
        {
           // this.domicilioField = new ComercioExteriorEmisorDomicilio();
        }

        public ComercioExteriorEmisorDomicilio Domicilio
        {
            get
            {
                return this.domicilioField;
            }
            set
            {
                this.domicilioField = value;
            }
        }
          [System.Xml.Serialization.XmlAttributeAttribute()]
        public string Curp
        {
            get
            {
                return this.curpField;
            }
            set
            {
                this.curpField = value;
            }
        }
    }


    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true, Namespace = "http://www.sat.gob.mx/ComercioExterior11")]
   
    public partial class ComercioExteriorEmisorDomicilio
    {

        private string calleField;

        private string numeroExteriorField;

        private string numeroInteriorField;

        private string coloniaField;

        private bool coloniaFieldSpecified;

        private string localidadField;

        private bool localidadFieldSpecified;

        private string referenciaField;

        private string municipioField;

        private bool municipioFieldSpecified;

        private string estadoField;

        private string paisField;

        private string codigoPostalField;

          [System.Xml.Serialization.XmlAttributeAttribute()]
        public string Calle
        {
            get
            {
                return this.calleField;
            }
            set
            {
                this.calleField = value;
            }
        }
          [System.Xml.Serialization.XmlAttributeAttribute()]
        public string NumeroExterior
        {
            get
            {
                return this.numeroExteriorField;
            }
            set
            {
                this.numeroExteriorField = value;
            }
        }
          [System.Xml.Serialization.XmlAttributeAttribute()]
        public string NumeroInterior
        {
            get
            {
                return this.numeroInteriorField;
            }
            set
            {
                this.numeroInteriorField = value;
            }
        }
          [System.Xml.Serialization.XmlAttributeAttribute()]
        public string Colonia
        {
            get
            {
                return this.coloniaField;
            }
            set
            {
                this.coloniaField = value;
            }
        }

        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool ColoniaSpecified
        {
            get
            {
                return this.coloniaFieldSpecified;
            }
            set
            {
                this.coloniaFieldSpecified = value;
            }
        }
          [System.Xml.Serialization.XmlAttributeAttribute()]
       
        public string Localidad
        {
            get
            {
                return this.localidadField;
            }
            set
            {
                this.localidadField = value;
            }
        }

        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool LocalidadSpecified
        {
            get
            {
                return this.localidadFieldSpecified;
            }
            set
            {
                this.localidadFieldSpecified = value;
            }
        }
          [System.Xml.Serialization.XmlAttributeAttribute()]
        public string Referencia
        {
            get
            {
                return this.referenciaField;
            }
            set
            {
                this.referenciaField = value;
            }
        }
          [System.Xml.Serialization.XmlAttributeAttribute()]
        public string Municipio
        {
            get
            {
                return this.municipioField;
            }
            set
            {
                this.municipioField = value;
            }
        }

        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool MunicipioSpecified
        {
            get
            {
                return this.municipioFieldSpecified;
            }
            set
            {
                this.municipioFieldSpecified = value;
            }
        }
          [System.Xml.Serialization.XmlAttributeAttribute()]
        public string Estado
        {
            get
            {
                return this.estadoField;
            }
            set
            {
                this.estadoField = value;
            }
        }
          [System.Xml.Serialization.XmlAttributeAttribute()]
        public string Pais
        {
            get
            {
                return this.paisField;
            }
            set
            {
                this.paisField = value;
            }
        }
          [System.Xml.Serialization.XmlAttributeAttribute()]
          public string CodigoPostal
        
        {
            get
            {
                return this.codigoPostalField;
            }
            set
            {
                this.codigoPostalField = value;
            }
        }
    }
   
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true, Namespace = "http://www.sat.gob.mx/ComercioExterior11")]
 
    public partial class ComercioExteriorPropietario
    {

        public ComercioExteriorPropietario()
        {
     
        }

        private string numRegIdTribField;

       // private c_Pais residenciaFiscalField;
        private string residenciaFiscalField;


         [System.Xml.Serialization.XmlAttributeAttribute()]
        public string NumRegIdTrib
        {
            get
            {
                return this.numRegIdTribField;
            }
            set
            {
                this.numRegIdTribField = value;
            }
        }
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string ResidenciaFiscal
        {
            get
            {
                return this.residenciaFiscalField;
            }
            set
            {
                this.residenciaFiscalField = value;
            }
        }
    }

    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true, Namespace = "http://www.sat.gob.mx/ComercioExterior11")]
  
    public partial class ComercioExteriorReceptor
    {

        private ComercioExteriorReceptorDomicilio domicilioField;

        private string numRegIdTribField;

        public ComercioExteriorReceptor()
        {
           // this.domicilioField = new ComercioExteriorReceptorDomicilio();
        }

        public ComercioExteriorReceptorDomicilio Domicilio
        {
            get
            {
                return this.domicilioField;
            }
            set
            {
                this.domicilioField = value;
            }
        }

        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string NumRegIdTrib
        {
            get
            {
                return this.numRegIdTribField;
            }
            set
            {
                this.numRegIdTribField = value;
            }
        }
    }

    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true, Namespace = "http://www.sat.gob.mx/ComercioExterior11")]

    public partial class ComercioExteriorReceptorDomicilio
    {

        private string calleField;

        private string numeroExteriorField;

        private string numeroInteriorField;

        private string coloniaField;

        private string localidadField;

        private string referenciaField;

        private string municipioField;

        private string estadoField;

        private string paisField;

        private string codigoPostalField;
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string Calle
        {
            get
            {
                return this.calleField;
            }
            set
            {
                this.calleField = value;
            }
        }
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string NumeroExterior
        {
            get
            {
                return this.numeroExteriorField;
            }
            set
            {
                this.numeroExteriorField = value;
            }
        }
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string NumeroInterior
        {
            get
            {
                return this.numeroInteriorField;
            }
            set
            {
                this.numeroInteriorField = value;
            }
        }
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string Colonia
        {
            get
            {
                return this.coloniaField;
            }
            set
            {
                this.coloniaField = value;
            }
        }
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string Localidad
        {
            get
            {
                return this.localidadField;
            }
            set
            {
                this.localidadField = value;
            }
        }
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string Referencia
        {
            get
            {
                return this.referenciaField;
            }
            set
            {
                this.referenciaField = value;
            }
        }
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string Municipio
        {
            get
            {
                return this.municipioField;
            }
            set
            {
                this.municipioField = value;
            }
        }
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string Estado
        {
            get
            {
                return this.estadoField;
            }
            set
            {
                this.estadoField = value;
            }
        }
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string Pais
        {
            get
            {
                return this.paisField;
            }
            set
            {
                this.paisField = value;
            }
        }
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string CodigoPostal
        {
            get
            {
                return this.codigoPostalField;
            }
            set
            {
                this.codigoPostalField = value;
            }
        }
    }

    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true, Namespace = "http://www.sat.gob.mx/ComercioExterior11")]
  
    public partial class ComercioExteriorDestinatario
    {

        private List<ComercioExteriorDestinatarioDomicilio> domicilioField;

        private string numRegIdTribField;

        private string nombreField;

        public ComercioExteriorDestinatario()
        {
            //this.domicilioField = new List<ComercioExteriorDestinatarioDomicilio>();
        }
        [XmlElement("Domicilio")]
         // [System.Xml.Serialization.XmlArrayItemAttribute("Domicilio", IsNullable = false)]
        public List<ComercioExteriorDestinatarioDomicilio> Domicilio
        {
            get
            {
                return this.domicilioField;
            }
            set
            {
                this.domicilioField = value;
            }
        }
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string NumRegIdTrib
        {
            get
            {
                return this.numRegIdTribField;
            }
            set
            {
                this.numRegIdTribField = value;
            }
        }
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string Nombre
        {
            get
            {
                return this.nombreField;
            }
            set
            {
                this.nombreField = value;
            }
        }
    }

    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true, Namespace = "http://www.sat.gob.mx/ComercioExterior11")]
   
    public partial class ComercioExteriorDestinatarioDomicilio
    {

        private string calleField;

        private string numeroExteriorField;

        private string numeroInteriorField;

        private string coloniaField;

        private string localidadField;

        private string referenciaField;

        private string municipioField;

        private string estadoField;

        private string paisField;

        private string codigoPostalField;
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string Calle
        {
            get
            {
                return this.calleField;
            }
            set
            {
                this.calleField = value;
            }
        }
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string NumeroExterior
        {
            get
            {
                return this.numeroExteriorField;
            }
            set
            {
                this.numeroExteriorField = value;
            }
        }
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string NumeroInterior
        {
            get
            {
                return this.numeroInteriorField;
            }
            set
            {
                this.numeroInteriorField = value;
            }
        }
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string Colonia
        {
            get
            {
                return this.coloniaField;
            }
            set
            {
                this.coloniaField = value;
            }
        }
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string Localidad
        {
            get
            {
                return this.localidadField;
            }
            set
            {
                this.localidadField = value;
            }
        }
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string Referencia
        {
            get
            {
                return this.referenciaField;
            }
            set
            {
                this.referenciaField = value;
            }
        }
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string Municipio
        {
            get
            {
                return this.municipioField;
            }
            set
            {
                this.municipioField = value;
            }
        }
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string Estado
        {
            get
            {
                return this.estadoField;
            }
            set
            {
                this.estadoField = value;
            }
        }
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string Pais
        {
            get
            {
                return this.paisField;
            }
            set
            {
                this.paisField = value;
            }
        }
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string CodigoPostal
        {
            get
            {
                return this.codigoPostalField;
            }
            set
            {
                this.codigoPostalField = value;
            }
        }
    }

    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true, Namespace = "http://www.sat.gob.mx/ComercioExterior11")]
   
    public partial class ComercioExteriorMercancia
    {

        private List<ComercioExteriorMercanciaDescripcionesEspecificas> descripcionesEspecificasField;

        private string noIdentificacionField;

      //  private c_FraccionArancelaria fraccionArancelariaField;
        private string fraccionArancelariaField;

        private bool fraccionArancelariaFieldSpecified;

        private decimal cantidadAduanaField;

        private bool cantidadAduanaFieldSpecified;

        private string unidadAduanaField;

        private bool unidadAduanaFieldSpecified;

        private decimal valorUnitarioAduanaField;

        private bool valorUnitarioAduanaFieldSpecified;

        private decimal valorDolaresField;

        public ComercioExteriorMercancia()
        {
          //  this.descripcionesEspecificasField = new List<ComercioExteriorMercanciaDescripcionesEspecificas>();
        }
        [System.Xml.Serialization.XmlArrayItemAttribute("DescripcionesEspecificas", IsNullable = false)]
        public List<ComercioExteriorMercanciaDescripcionesEspecificas> DescripcionesEspecificas
        {
            get
            {
                return this.descripcionesEspecificasField;
            }
            set
            {
                this.descripcionesEspecificasField = value;
            }
        }
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string NoIdentificacion
        {
            get
            {
                return this.noIdentificacionField;
            }
            set
            {
                this.noIdentificacionField = value;
            }
        }
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string FraccionArancelaria
        {
            get
            {
                return this.fraccionArancelariaField;
            }
            set
            {
                this.fraccionArancelariaField = value;
            }
        }

        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool FraccionArancelariaSpecified
        {
            get
            {
                return this.fraccionArancelariaFieldSpecified;
            }
            set
            {
                this.fraccionArancelariaFieldSpecified = value;
            }
        }
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public decimal CantidadAduana
        {
            get
            {
                return this.cantidadAduanaField;
            }
            set
            {
                this.cantidadAduanaField = value;
            }
        }

        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool CantidadAduanaSpecified
        {
            get
            {
                return this.cantidadAduanaFieldSpecified;
            }
            set
            {
                this.cantidadAduanaFieldSpecified = value;
            }
        }
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string UnidadAduana
        {
            get
            {
                return this.unidadAduanaField;
            }
            set
            {
                this.unidadAduanaField = value;
            }
        }

        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool UnidadAduanaSpecified
        {
            get
            {
                return this.unidadAduanaFieldSpecified;
            }
            set
            {
                this.unidadAduanaFieldSpecified = value;
            }
        }
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public decimal ValorUnitarioAduana
        {
            get
            {
                return this.valorUnitarioAduanaField;
            }
            set
            {
                this.valorUnitarioAduanaField = value;
            }
        }

        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool ValorUnitarioAduanaSpecified
        {
            get
            {
                return this.valorUnitarioAduanaFieldSpecified;
            }
            set
            {
                this.valorUnitarioAduanaFieldSpecified = value;
            }
        }
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public decimal ValorDolares
        {
            get
            {
                return this.valorDolaresField;
            }
            set
            {
                this.valorDolaresField = value;
            }
        }
    }

    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true, Namespace = "http://www.sat.gob.mx/ComercioExterior11")]
   
    public partial class ComercioExteriorMercanciaDescripcionesEspecificas
    {

        private string marcaField;

        private string modeloField;

        private string subModeloField;

        private string numeroSerieField;
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string Marca
        {
            get
            {
                return this.marcaField;
            }
            set
            {
                this.marcaField = value;
            }
        }
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string Modelo
        {
            get
            {
                return this.modeloField;
            }
            set
            {
                this.modeloField = value;
            }
        }
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string SubModelo
        {
            get
            {
                return this.subModeloField;
            }
            set
            {
                this.subModeloField = value;
            }
        }
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string NumeroSerie
        {
            get
            {
                return this.numeroSerieField;
            }
            set
            {
                this.numeroSerieField = value;
            }
        }
    }
   
}
