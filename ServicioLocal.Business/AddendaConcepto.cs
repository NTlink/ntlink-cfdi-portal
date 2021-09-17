using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ServicioLocal.Business.AddendaConcepto
{
        
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true)]
    public partial class Conceptos
    {

        private string[] conceptoField;

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("Concepto")]
        public string[] Concepto
        {
            get
            {
                return this.conceptoField;
            }
            set
            {
                this.conceptoField = value;
            }
        }
    }

}