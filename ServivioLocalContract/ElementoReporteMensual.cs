using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ServicioLocalContract
{
    public class ElementoReporteMensual
    {

        public long IdSIstema { get; set; }
        public string Rfc { get; set; }
        public string RazonSocial { get; set; }
        public string Contacto { get; set; }
        public string Telefono { get; set; }
        public string Email { get; set; }
        public string Contratados { get; set; }
        public int? consumoEmision { get; set; }
        public int? consumoTimbrado { get; set; }
        public int? Timbrado { get; set; }

        public int? Totales { get; set; }
        public float? porcentaje { get; set; }
        public int? Saldo { get; set; }

    }
}
