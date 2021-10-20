
// 
namespace ServicioLocal.Business.AddendaPlaneta
{
    using System.Xml.Serialization;
    
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType=true)]
    [System.Xml.Serialization.XmlRootAttribute(Namespace="", IsNullable=false)]
    public partial class OrdenesCompra {
        
        private AddendaOC[] addendaOCField;
        
        private decimal versionField;
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("AddendaOC")]
        public AddendaOC[] AddendaOC {
            get {
                return this.addendaOCField;
            }
            set {
                this.addendaOCField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public decimal version {
            get {
                return this.versionField;
            }
            set {
                this.versionField = value;
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType=true)]
    [System.Xml.Serialization.XmlRootAttribute(Namespace="", IsNullable=false)]
    public partial class AddendaOC {
        
        private string empresaField;
        
        private string fechaADDOCField;

        private DetalleADDOC[] detalleADDOCField;
        
        private string folioField;
        
        private string requisicionField;
        
        /// <remarks/>
        public string Empresa {
            get {
                return this.empresaField;
            }
            set {
                this.empresaField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(DataType="string")]
        public string FechaADDOC {
            get {
                return this.fechaADDOCField;
            }
            set {
                this.fechaADDOCField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("DetalleADDOC")]
        public DetalleADDOC[] DetalleADDOC
        {
            get {
                return this.detalleADDOCField;
            }
            set {
                this.detalleADDOCField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string Folio {
            get {
                return this.folioField;
            }
            set {
                this.folioField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string Requisicion {
            get {
                return this.requisicionField;
            }
            set {
                this.requisicionField = value;
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    public enum EmpresaVal {
        
        /// <remarks/>
        RP,
        
        /// <remarks/>
        PQ,
        
        /// <remarks/>
        PS,
        
        /// <remarks/>
        RM,
        
        /// <remarks/>
        CL,
        
        /// <remarks/>
        SE,
        
        /// <remarks/>
        TM,
        
        /// <remarks/>
        VM,
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType=true)]
    [System.Xml.Serialization.XmlRootAttribute(Namespace="", IsNullable=false)]
    public partial class Partida {
        
        private int lineaField;
        
        private string procesoProdField;
        
        private string tipoTrabajoField;
        
        private string hojaTrabajoField;
        
        private string codigoField;
        
        private decimal cantidadField;
        
        private decimal precioUnitarioField;
        
        private string descripcionField;
        
        private decimal importeTotalField;
        
        /// <remarks/>
        public int Linea {
            get {
                return this.lineaField;
            }
            set {
                this.lineaField = value;
            }
        }
        
        /// <remarks/>
        public string ProcesoProd {
            get {
                return this.procesoProdField;
            }
            set {
                this.procesoProdField = value;
            }
        }
        
        /// <remarks/>
        public string TipoTrabajo {
            get {
                return this.tipoTrabajoField;
            }
            set {
                this.tipoTrabajoField = value;
            }
        }
        
        /// <remarks/>
        public string HojaTrabajo {
            get {
                return this.hojaTrabajoField;
            }
            set {
                this.hojaTrabajoField = value;
            }
        }
        
        /// <remarks/>
        public string Codigo {
            get {
                return this.codigoField;
            }
            set {
                this.codigoField = value;
            }
        }
        
        /// <remarks/>
        public decimal Cantidad {
            get {
                return this.cantidadField;
            }
            set {
                this.cantidadField = value;
            }
        }
        
        /// <remarks/>
        public decimal PrecioUnitario {
            get {
                return this.precioUnitarioField;
            }
            set {
                this.precioUnitarioField = value;
            }
        }
        
        /// <remarks/>
        public string Descripcion {
            get {
                return this.descripcionField;
            }
            set {
                this.descripcionField = value;
            }
        }
        
        /// <remarks/>
        public decimal ImporteTotal {
            get {
                return this.importeTotalField;
            }
            set {
                this.importeTotalField = value;
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    public enum ProcProdVal {
        
        /// <remarks/>
        INTER,
        
        /// <remarks/>
        INTE1,
        
        /// <remarks/>
        LAMF1,
        
        /// <remarks/>
        LAMF2,
        
        /// <remarks/>
        CARTU,
        
        /// <remarks/>
        PAPEL,
        
        /// <remarks/>
        FORRO,
        
        /// <remarks/>
        ENCUA,
        
        /// <remarks/>
        ENCU2,
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType=true)]
    [System.Xml.Serialization.XmlRootAttribute(Namespace="", IsNullable=false)]
    public partial class DetalleADDOC {
        
        private Partida[] partidaField;
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("Partida")]
        public Partida[] Partida {
            get {
                return this.partidaField;
            }
            set {
                this.partidaField = value;
            }
        }
    }
}
