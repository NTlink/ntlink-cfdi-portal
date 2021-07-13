using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;
using System.Xml.Schema;

namespace ServicioLocal.Business
{
   
    /// <remarks/>
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType=true, Namespace="http://www.sat.gob.mx/cfd/3")]
    public partial class AddendaOrderIdentification {

         private AddendaOrderIdentificationReferenceIdentification referenceIdentificationField;
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public AddendaOrderIdentificationReferenceIdentification referenceIdentification {
            get {
                return this.referenceIdentificationField;
            }
            set {
                this.referenceIdentificationField = value;
            }
        }
    }
    
    /// <remarks/>
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType=true, Namespace="http://www.sat.gob.mx/cfd/3")]
    public partial class AddendaOrderIdentificationReferenceIdentification {
        
        private string typeField;
        
        private string valueField;
        
        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string type {
            get {
                return this.typeField;
            }
            set {
                this.typeField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlTextAttribute()]
        public string Value {
            get {
                return this.valueField;
            }
            set {
                this.valueField = value;
            }
        }
    }

}

