using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ServicioLocal.Business.Retenciones
{
    public class TipoRetencionesText
    {
        public static IDictionary<string, string> GetCatalogo()
        {
            var result = new Dictionary<string, string>
            {
                {"01", "Servicios profesionales"},
                {"02", "Regalías por derechos de autor"},
                {"03", "Autotransporte terrestre de carga"},
                {"04", "Servicios prestados por comisionistas"},
                {"05", "Arrendamiento"},
                {"06", "Enajenación de acciones"},
                {
                    "07",
                    "Enajenación de bienes objeto de la LIEPS, a través de mediadores, agentes, representantes, corredores, consignatarios o distribuidores"
                },
                {"08", "Enajenación de bienes inmuebles consignada en escritura pública"},
                {"09", "Enajenación de otros bienes, no consignada en escritura pública"},
                {"10", "Adquisición de desperdicios industriales"},
                {"11", "Adquisición de bienes consignada en escritura pública"},
                {"12", "Adquisición de otros bienes, no consignada en escritura pública"},
                {"13", "Otros retiros de AFORE."},
                {"14", "Dividendos o utilidades distribuidas."},
                {"15", "Remanente distribuible."},
                {"16", "Intereses."},
                {"17", "Arrendamiento en fideicomiso."},
                {"18", "Pagos realizados a favor de residentes en el extranjero."},
                {"19", "Enajenación de acciones u operaciones en bolsa de valores."},
                {"20", "Obtención de premios."},
                {"21", "Fideicomisos que no realizan actividades empresariales."},
                {"22", "Planes personales de retiro."},
                {"23", "Intereses reales deducibles por créditos hipotecarios."},
                {"24", "Operaciones Financieras Derivadas de Capital"},
                {"25", "Otro tipo de retenciones"}
            };
            return result;
        }
    }

    public class TipoImpuestoText
    {
        public static IDictionary<string, string> GetCatalogo()
        {
            var result = new Dictionary<string, string>
            {
                {"01", "ISR"},
                {"02", "IVA"},
                {"03", "IEPS"}
            };
            return result;
        }
    }

    public class TipoPagoText
    {
        public static IDictionary<string, string> GetCatalogo()
        {
            var result = new Dictionary<string, string>
            {
                {"Pago definitivo", "Pago definitivo"},
                {"Pago provisional", "Pago provisional"}
            };
            return result;
        }
    }
}