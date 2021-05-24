using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NtLinkAdministracion.Objetos
{
    public class Prospecto_View
    {
        public string RFC { get; set; }
        public string Razonsocial { get; set; }
        public string Emailcontacto { get; set; }
        public string Telefonos { get; set; }
        public string idVendedor { get; set; }
        public Nullable<System.DateTime> Fechacontacto { get; set; }
        public string Tipocliente { get; set; }
    }
}