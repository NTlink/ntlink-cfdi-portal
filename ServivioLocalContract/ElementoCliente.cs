using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ServicioLocalContract
{
    public class ElementoCliente
    {
        public long IdSistema { get; set; }
        public string RazonSocial { get; set; }
        public string Rfc { get; set; }
        public long Contratados { get; set; }
        public long Comsumidos { get; set; }
        public double Porcentaje { get; set; }
        public long Cancelados { get; set; }
    }
}
