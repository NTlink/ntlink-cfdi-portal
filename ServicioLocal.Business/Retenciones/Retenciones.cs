using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;
using ServicioLocalContract;

namespace ServicioLocal.Business.Retenciones
{
    public partial class Retenciones
    {
        [XmlIgnore]
        public string XmlString { get; set; }
        [XmlIgnore]
        public string CadenaOriginal { get; set; }
        [XmlIgnore]
        public string CadenaOriginalTimbre { get; set; }
        [XmlIgnore]
        public int IdEmpresa { get; set; }
        [XmlIgnore]
        public int IdReceptor { get; set; }
    }
}
