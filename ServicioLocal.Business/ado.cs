﻿

using System.Xml.Serialization;

// 
// This source code was auto-generated by xsd, Version=4.0.30319.1.
// 


/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
[System.SerializableAttribute()]
[System.Diagnostics.DebuggerStepThroughAttribute()]
[System.ComponentModel.DesignerCategoryAttribute("code")]
[System.Xml.Serialization.XmlTypeAttribute(AnonymousType=true, Namespace="http://recepcioncfd.ekomercio.com/ADO")]
[System.Xml.Serialization.XmlRootAttribute(Namespace="http://recepcioncfd.ekomercio.com/ADO", IsNullable=false)]
public partial class Addenda {
    
    private AddendaProveedor proveedorField;
    
    private AddendaAddenda addendaField;
    
    /// <remarks/>
    [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
    public AddendaProveedor proveedor {
        get {
            return this.proveedorField;
        }
        set {
            this.proveedorField = value;
        }
    }
    
    /// <remarks/>
    [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
    public AddendaAddenda addenda {
        get {
            return this.addendaField;
        }
        set {
            this.addendaField = value;
        }
    }
}

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
[System.SerializableAttribute()]
[System.Diagnostics.DebuggerStepThroughAttribute()]
[System.ComponentModel.DesignerCategoryAttribute("code")]
[System.Xml.Serialization.XmlTypeAttribute(AnonymousType=true, Namespace="http://recepcioncfd.ekomercio.com/ADO")]
public partial class AddendaProveedor {
    
    private System.Xml.XmlElement[] anyField;
    
    private string tipoAddendaField;
    
    /// <remarks/>
    [System.Xml.Serialization.XmlAnyElementAttribute()]
    public System.Xml.XmlElement[] Any {
        get {
            return this.anyField;
        }
        set {
            this.anyField = value;
        }
    }
    
    /// <remarks/>
    [System.Xml.Serialization.XmlAttributeAttribute()]
    public string tipoAddenda {
        get {
            return this.tipoAddendaField;
        }
        set {
            this.tipoAddendaField = value;
        }
    }
}

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
[System.SerializableAttribute()]
[System.Diagnostics.DebuggerStepThroughAttribute()]
[System.ComponentModel.DesignerCategoryAttribute("code")]
[System.Xml.Serialization.XmlTypeAttribute(AnonymousType=true, Namespace="http://recepcioncfd.ekomercio.com/ADO")]
public partial class AddendaAddenda {
    
    private System.Xml.XmlElement[] anyField;
    
    private string valorField;
    
    /// <remarks/>
    [System.Xml.Serialization.XmlAnyElementAttribute()]
    public System.Xml.XmlElement[] Any {
        get {
            return this.anyField;
        }
        set {
            this.anyField = value;
        }
    }
    
    /// <remarks/>
    [System.Xml.Serialization.XmlAttributeAttribute()]
    public string valor {
        get {
            return this.valorField;
        }
        set {
            this.valorField = value;
        }
    }
}
