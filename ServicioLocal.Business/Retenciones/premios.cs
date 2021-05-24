
using System.Xml.Serialization;
using System.Xml.Schema;

// 
// Este código fuente fue generado automáticamente por xsd, Versión=4.0.30319.1.
// 


/// <comentarios/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
[System.SerializableAttribute()]
[System.Diagnostics.DebuggerStepThroughAttribute()]
[System.ComponentModel.DesignerCategoryAttribute("code")]
[System.Xml.Serialization.XmlTypeAttribute(AnonymousType=true, Namespace="http://www.sat.gob.mx/esquemas/retencionpago/1/premios")]
[System.Xml.Serialization.XmlRootAttribute(Namespace="http://www.sat.gob.mx/esquemas/retencionpago/1/premios", IsNullable=false)]
public partial class Premios {

    [XmlAttribute("schemaLocation", Namespace = XmlSchema.InstanceNamespace)]
    public string xsiSchemaLocation =
        "http://www.sat.gob.mx/esquemas/retencionpago/1/premios http://www.sat.gob.mx/esquemas/retencionpago/1/premios/premios.xsd";

    private string versionField;
    
    private string entidadFederativaField;
    
    private decimal montTotPagoField;
    
    private decimal montTotPagoGravField;
    
    private decimal montTotPagoExentField;
    
    public Premios() {
        this.versionField = "1.0";
    }
    
    /// <comentarios/>
    [System.Xml.Serialization.XmlAttributeAttribute()]
    public string Version {
        get {
            return this.versionField;
        }
        set {
            this.versionField = value;
        }
    }
    
    /// <comentarios/>
    [System.Xml.Serialization.XmlAttributeAttribute()]
    public string EntidadFederativa {
        get {
            return this.entidadFederativaField;
        }
        set {
            this.entidadFederativaField = value;
        }
    }
    
    /// <comentarios/>
    [System.Xml.Serialization.XmlAttributeAttribute()]
    public decimal MontTotPago {
        get {
            return this.montTotPagoField;
        }
        set {
            this.montTotPagoField = value;
        }
    }
    
    /// <comentarios/>
    [System.Xml.Serialization.XmlAttributeAttribute()]
    public decimal MontTotPagoGrav {
        get {
            return this.montTotPagoGravField;
        }
        set {
            this.montTotPagoGravField = value;
        }
    }
    
    /// <comentarios/>
    [System.Xml.Serialization.XmlAttributeAttribute()]
    public decimal MontTotPagoExent {
        get {
            return this.montTotPagoExentField;
        }
        set {
            this.montTotPagoExentField = value;
        }
    }
}
