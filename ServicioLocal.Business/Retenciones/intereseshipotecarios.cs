//------------------------------------------------------------------------------
// <auto-generated>
//     Este código fue generado por una herramienta.
//     Versión de runtime:4.0.30319.34209
//
//     Los cambios en este archivo podrían causar un comportamiento incorrecto y se perderán si
//     se vuelve a generar el código.
// </auto-generated>
//------------------------------------------------------------------------------

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
[System.Xml.Serialization.XmlTypeAttribute(AnonymousType=true, Namespace="http://www.sat.gob.mx/esquemas/retencionpago/1/intereseshipotecarios")]
[System.Xml.Serialization.XmlRootAttribute(Namespace="http://www.sat.gob.mx/esquemas/retencionpago/1/intereseshipotecarios", IsNullable=false)]
public partial class Intereseshipotecarios {

    [XmlAttribute("schemaLocation", Namespace = XmlSchema.InstanceNamespace)]
    public string xsiSchemaLocation =
        "http://www.sat.gob.mx/esquemas/retencionpago/1/intereseshipotecarios http://www.sat.gob.mx/esquemas/retencionpago/1/intereseshipotecarios/intereseshipotecarios.xsd";

    private string versionField;
    
    private IntereseshipotecariosCreditoDeInstFinanc creditoDeInstFinancField;
    
    private decimal saldoInsolutoField;
    
    private decimal propDeducDelCreditField;
    
    private bool propDeducDelCreditFieldSpecified;
    
    private decimal montTotIntNominalesDevField;
    
    private bool montTotIntNominalesDevFieldSpecified;
    
    private decimal montTotIntNominalesDevYPagField;
    
    private bool montTotIntNominalesDevYPagFieldSpecified;
    
    private decimal montTotIntRealPagDeducField;
    
    private bool montTotIntRealPagDeducFieldSpecified;
    
    private string numContratoField;
    
    public Intereseshipotecarios() {
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
    public IntereseshipotecariosCreditoDeInstFinanc CreditoDeInstFinanc {
        get {
            return this.creditoDeInstFinancField;
        }
        set {
            this.creditoDeInstFinancField = value;
        }
    }
    
    /// <comentarios/>
    [System.Xml.Serialization.XmlAttributeAttribute()]
    public decimal SaldoInsoluto {
        get {
            return this.saldoInsolutoField;
        }
        set {
            this.saldoInsolutoField = value;
        }
    }
    
    /// <comentarios/>
    [System.Xml.Serialization.XmlAttributeAttribute()]
    public decimal PropDeducDelCredit {
        get {
            return this.propDeducDelCreditField;
        }
        set {
            this.propDeducDelCreditField = value;
        }
    }
    
    /// <comentarios/>
    [System.Xml.Serialization.XmlIgnoreAttribute()]
    public bool PropDeducDelCreditSpecified {
        get {
            return this.propDeducDelCreditFieldSpecified;
        }
        set {
            this.propDeducDelCreditFieldSpecified = value;
        }
    }
    
    /// <comentarios/>
    [System.Xml.Serialization.XmlAttributeAttribute()]
    public decimal MontTotIntNominalesDev {
        get {
            return this.montTotIntNominalesDevField;
        }
        set {
            this.montTotIntNominalesDevField = value;
        }
    }
    
    /// <comentarios/>
    [System.Xml.Serialization.XmlIgnoreAttribute()]
    public bool MontTotIntNominalesDevSpecified {
        get {
            return this.montTotIntNominalesDevFieldSpecified;
        }
        set {
            this.montTotIntNominalesDevFieldSpecified = value;
        }
    }
    
    /// <comentarios/>
    [System.Xml.Serialization.XmlAttributeAttribute()]
    public decimal MontTotIntNominalesDevYPag {
        get {
            return this.montTotIntNominalesDevYPagField;
        }
        set {
            this.montTotIntNominalesDevYPagField = value;
        }
    }
    
    /// <comentarios/>
    [System.Xml.Serialization.XmlIgnoreAttribute()]
    public bool MontTotIntNominalesDevYPagSpecified {
        get {
            return this.montTotIntNominalesDevYPagFieldSpecified;
        }
        set {
            this.montTotIntNominalesDevYPagFieldSpecified = value;
        }
    }
    
    /// <comentarios/>
    [System.Xml.Serialization.XmlAttributeAttribute()]
    public decimal MontTotIntRealPagDeduc {
        get {
            return this.montTotIntRealPagDeducField;
        }
        set {
            this.montTotIntRealPagDeducField = value;
        }
    }
    
    /// <comentarios/>
    [System.Xml.Serialization.XmlIgnoreAttribute()]
    public bool MontTotIntRealPagDeducSpecified {
        get {
            return this.montTotIntRealPagDeducFieldSpecified;
        }
        set {
            this.montTotIntRealPagDeducFieldSpecified = value;
        }
    }
    
    /// <comentarios/>
    [System.Xml.Serialization.XmlAttributeAttribute()]
    public string NumContrato {
        get {
            return this.numContratoField;
        }
        set {
            this.numContratoField = value;
        }
    }
}

/// <comentarios/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
[System.SerializableAttribute()]
[System.Xml.Serialization.XmlTypeAttribute(AnonymousType=true, Namespace="http://www.sat.gob.mx/esquemas/retencionpago/1/intereseshipotecarios")]
public enum IntereseshipotecariosCreditoDeInstFinanc {
    
    /// <comentarios/>
    SI,
    
    /// <comentarios/>
    NO,
}
