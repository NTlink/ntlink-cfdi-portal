
using System.Xml.Serialization;

namespace ServicioLocal.Business
{


    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.6.1055.0")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true, Namespace = "http://www.sat.gob.mx/vehiculousado")]
    [System.Xml.Serialization.XmlRootAttribute(Namespace = "http://www.sat.gob.mx/vehiculousado", IsNullable = false)]
    public partial class VehiculoUsado
    {

        private t_InformacionAduanera[] informacionAduaneraField;

        private string versionField;

        private decimal montoAdquisicionField;

        private decimal montoEnajenacionField;

        private string claveVehicularField;

        private string marcaField;

        private string tipoField;

        private string modeloField;

        private string numeroMotorField;

        private string numeroSerieField;

        private string nIVField;

        private decimal valorField;

        public VehiculoUsado()
        {
            this.versionField = "1.0";
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("InformacionAduanera")]
        public t_InformacionAduanera[] InformacionAduanera
        {
            get
            {
                return this.informacionAduaneraField;
            }
            set
            {
                this.informacionAduaneraField = value;
            }
        }

        /// <remarks/>
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

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public decimal montoAdquisicion
        {
            get
            {
                return this.montoAdquisicionField;
            }
            set
            {
                this.montoAdquisicionField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public decimal montoEnajenacion
        {
            get
            {
                return this.montoEnajenacionField;
            }
            set
            {
                this.montoEnajenacionField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string claveVehicular
        {
            get
            {
                return this.claveVehicularField;
            }
            set
            {
                this.claveVehicularField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string marca
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

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string tipo
        {
            get
            {
                return this.tipoField;
            }
            set
            {
                this.tipoField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string modelo
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

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string numeroMotor
        {
            get
            {
                return this.numeroMotorField;
            }
            set
            {
                this.numeroMotorField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string numeroSerie
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

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string NIV
        {
            get
            {
                return this.nIVField;
            }
            set
            {
                this.nIVField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public decimal valor
        {
            get
            {
                return this.valorField;
            }
            set
            {
                this.valorField = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.6.1055.0")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(Namespace = "http://www.sat.gob.mx/vehiculousado")]
    public partial class t_InformacionAduanera
    {

        private string numeroField;

        private System.String fechaField;

        private string aduanaField;

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string numero
        {
            get
            {
                return this.numeroField;
            }
            set
            {
                this.numeroField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public System.String fecha
        {
            get
            {
                return this.fechaField;
            }
            set
            {
                this.fechaField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string aduana
        {
            get
            {
                return this.aduanaField;
            }
            set
            {
                this.aduanaField = value;
            }
        }
    }

}