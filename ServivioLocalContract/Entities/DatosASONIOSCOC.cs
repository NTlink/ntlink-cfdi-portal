using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ServicioLocalContract.Entities
{
    [Serializable()]
   public class DatosASONIOSCOC
    {
        public List<ASONIOSCOCLosAtributos> atributos { get; set; }
        public string tipoProveedor { get; set; }
        public string folio { get; set; }
        public string ordenCompra { get; set; }
        public string noProveedor { get; set; }
        public string serie { get; set; }

        public DatosASONIOSCOC()
        {
            atributos = new List<ASONIOSCOCLosAtributos>();
        }
    }
    [Serializable()]
    public class ASONIOSCOCLosAtributos
    {
        public string ivaDevengado { get; set; }
        public string ivaAcreditable { get; set; }
        public string noPartida { get; set; }
        public string Otros { get; set; }
    }
}