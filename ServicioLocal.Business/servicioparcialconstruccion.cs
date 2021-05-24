namespace ServicioLocal.Business.Complemento
{

    using System.Xml.Serialization;
    using System.Xml.Schema;


    /// <comentarios/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true, Namespace = "http://www.sat.gob.mx/servicioparcialconstruccion")]
    [System.Xml.Serialization.XmlRootAttribute(Namespace = "http://www.sat.gob.mx/servicioparcialconstruccion", IsNullable = false)]
    public class parcialesconstruccion
    {
        [XmlAttribute("schemaLocation", Namespace = XmlSchema.InstanceNamespace)]
        public string xsiSchemaLocation = "http://www.sat.gob.mx/servicioparcialconstruccion http://www.sat.gob.mx/sitio_internet/cfd/servicioparcialconstruccion/servicioparcialconstruccion.xsd";
                                           
        private parcialesconstruccionInmueble inmuebleField;

        private string versionField;

        private string numPerLicoAutField;

        public parcialesconstruccion()
        {
            this.versionField = "1.0";
        }

        /// <comentarios/>
        public parcialesconstruccionInmueble Inmueble
        {
            get
            {
                return this.inmuebleField;
            }
            set
            {
                this.inmuebleField = value;
            }
        }

        /// <comentarios/>
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

        /// <comentarios/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string NumPerLicoAut
        {
            get
            {
                return this.numPerLicoAutField;
            }
            set
            {
                this.numPerLicoAutField = value;
            }
        }
    }

    /// <comentarios/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true, Namespace = "http://www.sat.gob.mx/servicioparcialconstruccion")]
    public partial class parcialesconstruccionInmueble
    {

        private string calleField;

        private string noExteriorField;

        private string noInteriorField;

        private string coloniaField;

        private string localidadField;

        private string referenciaField;

        private string municipioField;

      //  private parcialesconstruccionInmuebleEstado estadoField;
        private string estadoField;

        private string codigoPostalField;

        /// <comentarios/>
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

        /// <comentarios/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string NoExterior
        {
            get
            {
                return this.noExteriorField;
            }
            set
            {
                this.noExteriorField = value;
            }
        }

        /// <comentarios/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string NoInterior
        {
            get
            {
                return this.noInteriorField;
            }
            set
            {
                this.noInteriorField = value;
            }
        }

        /// <comentarios/>
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

        /// <comentarios/>
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

        /// <comentarios/>
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

        /// <comentarios/>
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

        /// <comentarios/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string Estado
        
        //public parcialesconstruccionInmuebleEstado Estado
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

        /// <comentarios/>
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

    /// <comentarios/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Xml.Serialization.XmlTypeAttribute(Namespace = "http://www.sat.gob.mx/servicioparcialconstruccion")]
    public enum parcialesconstruccionInmuebleEstado
    {

        /// <comentarios/>
        [System.Xml.Serialization.XmlEnumAttribute("01")]
        Item01,

        /// <comentarios/>
        [System.Xml.Serialization.XmlEnumAttribute("02")]
        Item02,

        /// <comentarios/>
        [System.Xml.Serialization.XmlEnumAttribute("03")]
        Item03,

        /// <comentarios/>
        [System.Xml.Serialization.XmlEnumAttribute("04")]
        Item04,

        /// <comentarios/>
        [System.Xml.Serialization.XmlEnumAttribute("05")]
        Item05,

        /// <comentarios/>
        [System.Xml.Serialization.XmlEnumAttribute("06")]
        Item06,

        /// <comentarios/>
        [System.Xml.Serialization.XmlEnumAttribute("07")]
        Item07,

        /// <comentarios/>
        [System.Xml.Serialization.XmlEnumAttribute("08")]
        Item08,

        /// <comentarios/>
        [System.Xml.Serialization.XmlEnumAttribute("09")]
        Item09,

        /// <comentarios/>
        [System.Xml.Serialization.XmlEnumAttribute("10")]
        Item10,

        /// <comentarios/>
        [System.Xml.Serialization.XmlEnumAttribute("11")]
        Item11,

        /// <comentarios/>
        [System.Xml.Serialization.XmlEnumAttribute("12")]
        Item12,

        /// <comentarios/>
        [System.Xml.Serialization.XmlEnumAttribute("13")]
        Item13,

        /// <comentarios/>
        [System.Xml.Serialization.XmlEnumAttribute("14")]
        Item14,

        /// <comentarios/>
        [System.Xml.Serialization.XmlEnumAttribute("15")]
        Item15,

        /// <comentarios/>
        [System.Xml.Serialization.XmlEnumAttribute("16")]
        Item16,

        /// <comentarios/>
        [System.Xml.Serialization.XmlEnumAttribute("17")]
        Item17,

        /// <comentarios/>
        [System.Xml.Serialization.XmlEnumAttribute("18")]
        Item18,

        /// <comentarios/>
        [System.Xml.Serialization.XmlEnumAttribute("19")]
        Item19,

        /// <comentarios/>
        [System.Xml.Serialization.XmlEnumAttribute("20")]
        Item20,

        /// <comentarios/>
        [System.Xml.Serialization.XmlEnumAttribute("21")]
        Item21,

        /// <comentarios/>
        [System.Xml.Serialization.XmlEnumAttribute("22")]
        Item22,

        /// <comentarios/>
        [System.Xml.Serialization.XmlEnumAttribute("23")]
        Item23,

        /// <comentarios/>
        [System.Xml.Serialization.XmlEnumAttribute("24")]
        Item24,

        /// <comentarios/>
        [System.Xml.Serialization.XmlEnumAttribute("25")]
        Item25,

        /// <comentarios/>
        [System.Xml.Serialization.XmlEnumAttribute("26")]
        Item26,

        /// <comentarios/>
        [System.Xml.Serialization.XmlEnumAttribute("27")]
        Item27,

        /// <comentarios/>
        [System.Xml.Serialization.XmlEnumAttribute("28")]
        Item28,

        /// <comentarios/>
        [System.Xml.Serialization.XmlEnumAttribute("29")]
        Item29,

        /// <comentarios/>
        [System.Xml.Serialization.XmlEnumAttribute("30")]
        Item30,

        /// <comentarios/>
        [System.Xml.Serialization.XmlEnumAttribute("31")]
        Item31,

        /// <comentarios/>
        [System.Xml.Serialization.XmlEnumAttribute("32")]
        Item32,
    }


}
