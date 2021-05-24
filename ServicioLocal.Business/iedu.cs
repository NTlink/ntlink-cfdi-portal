
//------------------------------------------------------------------------------

using System.Xml.Serialization;

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
[System.SerializableAttribute()]
[System.Diagnostics.DebuggerStepThroughAttribute()]
[System.ComponentModel.DesignerCategoryAttribute("code")]
[System.Xml.Serialization.XmlTypeAttribute(AnonymousType=true, Namespace="http://www.sat.gob.mx/iedu")]
[System.Xml.Serialization.XmlRootAttribute(Namespace="http://www.sat.gob.mx/iedu", IsNullable=false)]
public partial class instEducativas {
    
    private string versionField;
    
    private string nombreAlumnoField;
    
    private string cURPField;
    
    private instEducativasNivelEducativo nivelEducativoField;
    
    private string autRVOEField;
    
    private string rfcPagoField;
    
    public instEducativas() {
        this.versionField = "1.0";
    }
    
    /// <remarks/>
    [System.Xml.Serialization.XmlAttributeAttribute()]
    public string version {
        get {
            return this.versionField;
        }
        set {
            this.versionField = value;
        }
    }
    
    /// <remarks/>
    [System.Xml.Serialization.XmlAttributeAttribute()]
    public string nombreAlumno {
        get {
            return this.nombreAlumnoField;
        }
        set {
            this.nombreAlumnoField = value;
        }
    }
    
    /// <remarks/>
    [System.Xml.Serialization.XmlAttributeAttribute()]
    public string CURP {
        get {
            return this.cURPField;
        }
        set {
            this.cURPField = value;
        }
    }
    
    /// <remarks/>
    [System.Xml.Serialization.XmlAttributeAttribute()]
    public instEducativasNivelEducativo nivelEducativo {
        get {
            return this.nivelEducativoField;
        }
        set {
            this.nivelEducativoField = value;
        }
    }
    
    /// <remarks/>
    [System.Xml.Serialization.XmlAttributeAttribute()]
    public string autRVOE {
        get {
            return this.autRVOEField;
        }
        set {
            this.autRVOEField = value;
        }
    }
    
    /// <remarks/>
    [System.Xml.Serialization.XmlAttributeAttribute()]
    public string rfcPago {
        get {
            return this.rfcPagoField;
        }
        set {
            this.rfcPagoField = value;
        }
    }
}

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
[System.SerializableAttribute()]
[System.Xml.Serialization.XmlTypeAttribute(AnonymousType=true, Namespace="http://www.sat.gob.mx/iedu")]
public enum instEducativasNivelEducativo {
    
    /// <remarks/>
    Preescolar,
    
    /// <remarks/>
    Primaria,
    
    /// <remarks/>
    Secundaria,
    
    /// <remarks/>
    [System.Xml.Serialization.XmlEnumAttribute("Profesional técnico")]
    Profesionaltécnico,
    
    /// <remarks/>
    [System.Xml.Serialization.XmlEnumAttribute("Bachillerato o su equivalente")]
    Bachilleratoosuequivalente,
}
