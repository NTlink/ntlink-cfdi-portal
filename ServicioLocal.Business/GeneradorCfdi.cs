using System;
using System.Collections.Generic;
using System.Configuration;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Net;
using System.Reflection;
using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;
using System.ServiceModel;
using System.Text;
using System.Web.Services.Protocols;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Serialization;
//using ClienteNtLink;
using Gma.QrCodeNet.Encoding;
using Gma.QrCodeNet.Encoding.Windows.Render;
using MessagingToolkit.QRCode.Codec;
using ServicioLocal.Business.ReportExecution;
using ServicioLocal.Business.ReportService;
using ServicioLocalContract;
using log4net;
using log4net.Config;
using System.Web;
using ServicioLocal.Business.InternalCertificador;
using ServicioLocal.Business.Retenciones;
using ParameterValue = ServicioLocal.Business.ReportExecution.ParameterValue;
using Warning = ServicioLocal.Business.ReportExecution.Warning;
using ServicioLocal.Business.Complemento;
using System.Threading;
using ServicioLocal.Business.Carta;


namespace ServicioLocal.Business
{
    public class GeneradorCfdi
    {
        private static readonly ILog Logger = LogManager.GetLogger(typeof(GeneradorCfdi));


        public GeneradorCfdi()
        {
            XmlConfigurator.Configure();
        }

        private string GetXml(Comprobante p, string complemento)
        {
            XmlSerializer ser = new XmlSerializer(typeof(Comprobante));
            using (MemoryStream memStream = new MemoryStream())
            {
                var sw = new StreamWriter(memStream, Encoding.UTF8);
                using (XmlWriter xmlWriter = XmlWriter.Create(sw, new XmlWriterSettings() { Indent = false, Encoding = Encoding.UTF8 }))
                {
                    XmlSerializerNamespaces namespaces = new XmlSerializerNamespaces();
                    namespaces.Add("xsi", "http://www.w3.org/2001/XMLSchema-instance");
                    namespaces.Add("cfdi", "http://www.sat.gob.mx/cfd/3");

                    ser.Serialize(xmlWriter, p, namespaces);
                    string xml = Encoding.UTF8.GetString(memStream.GetBuffer());
                    xml = xml.Substring(xml.IndexOf(Convert.ToChar(60)));
                    xml = xml.Substring(0, (xml.LastIndexOf(Convert.ToChar(62)) + 1));
                    if (complemento != null)
                    {
                        XElement comprobante = XElement.Parse(xml);
                        var comp = comprobante.Elements(_ns + "Complemento").FirstOrDefault();
                        if (comp == null)
                        {
                            comprobante.Add(new XElement(_ns + "Complemento"));
                            comp = comprobante.Elements(_ns + "Complemento").FirstOrDefault();
                        }
                        comp.Add(XElement.Parse(complemento));
                        SidetecStringWriter swriter = new SidetecStringWriter(Encoding.UTF8);
                        comprobante.Save(swriter,SaveOptions.DisableFormatting);
                        return swriter.ToString();
                    }

                    return xml;
                }
            }
        }

        private string GetXmlRetenciones(Retenciones.Retenciones p)
        {
            XmlSerializer ser = new XmlSerializer(typeof(Retenciones.Retenciones));
            using (MemoryStream memStream = new MemoryStream())
            {
                var sw = new StreamWriter(memStream, Encoding.UTF8);
                using (XmlWriter xmlWriter = XmlWriter.Create(sw, new XmlWriterSettings() { Indent = false, Encoding = Encoding.UTF8 }))
                {
                    XmlSerializerNamespaces namespaces = new XmlSerializerNamespaces();
                                       
                    namespaces.Add("xsi", "http://www.w3.org/2001/XMLSchema-instance");
                    namespaces.Add("retenciones", "http://www.sat.gob.mx/esquemas/retencionpago/1");

                  
                    if (p.Complemento.intereses != null)
                        namespaces.Add("intereses", "http://www.sat.gob.mx/esquemas/retencionpago/1/intereses"); 
                    if(p.Complemento.dividendos!=null)
                        namespaces.Add("dividendos", "http://www.sat.gob.mx/esquemas/retencionpago/1/dividendos");
                    if (p.Complemento.arrendamientoenfideicomiso != null)
                        namespaces.Add("arrendamientoenfideicomiso", "http://www.sat.gob.mx/esquemas/retencionpago/1/arrendamientoenfideicomiso");
                    if (p.Complemento.enajenaciondeAcciones != null)
                        namespaces.Add("enajenaciondeAcciones", "http://www.sat.gob.mx/esquemas/retencionpago/1/enajenaciondeacciones"); 
             
                   if(p.Complemento.fideicomisonoempresarial!=null)
                       namespaces.Add("fideicomisonoempresarial", "http://www.sat.gob.mx/esquemas/retencionpago/1/fideicomisonoempresarial"); 
                   if(p.Complemento.intereseshipotecarios!=null)
                       namespaces.Add("intereseshipotecarios", "http://www.sat.gob.mx/esquemas/retencionpago/1/intereseshipotecarios");
                   if (p.Complemento.pagosaextranjeros != null)
                       namespaces.Add("pagosaextranjeros", "http://www.sat.gob.mx/esquemas/retencionpago/1/pagosaextranjeros"); 

                   if (p.Complemento.operacionesconderivados != null)
                       namespaces.Add("operacionesconderivados", "http://www.sat.gob.mx/esquemas/retencionpago/1/operacionesconderivados");
                   if (p.Complemento.planesderetiro != null)
                       namespaces.Add("planesderetiro11","http://www.sat.gob.mx/esquemas/retencionpago/1/planesderetiro11");
                   if (p.Complemento.premios != null)
                       namespaces.Add("premios", "http://www.sat.gob.mx/esquemas/retencionpago/1/premios");
                   if (p.Complemento.sectorFinanciero != null)
                       namespaces.Add("sectorfinanciero", "http://www.sat.gob.mx/esquemas/retencionpago/1/sectorfinanciero"); 



                     ser.Serialize(xmlWriter, p, namespaces);
                    string xml = Encoding.UTF8.GetString(memStream.GetBuffer());
                    xml = xml.Substring(xml.IndexOf(Convert.ToChar(60)));
                    xml = xml.Substring(0, (xml.LastIndexOf(Convert.ToChar(62)) + 1));


                    if (xml.Contains("retenciones:intereses "))//para intereses agregar 
                    {
                        xml = xml.Replace("retenciones:intereses Version=\"1.0\"", "intereses:Intereses Version=\"1.0\" xsi:schemaLocation=\" http://www.sat.gob.mx/esquemas/retencionpago/1/intereses http://www.sat.gob.mx/esquemas/retencionpago/1/intereses/intereses.xsd\" xmlns:intereses=\"http://www.sat.gob.mx/esquemas/retencionpago/1/intereses\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"");
                    }
                    if (xml.Contains("retenciones:dividendos"))//para dividendos agregar 
                    {
                        xml = xml.Replace("retenciones:dividendos", "dividendos:Dividendos");
                        xml = xml.Replace("dividendos:Dividendos Version=\"1.0\"", "dividendos:Dividendos Version=\"1.0\" xsi:schemaLocation=\" http://www.sat.gob.mx/esquemas/retencionpago/1/dividendos http://www.sat.gob.mx/esquemas/retencionpago/1/dividendos/dividendos.xsd\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:dividendos=\"http://www.sat.gob.mx/esquemas/retencionpago/1/dividendos\"");
                    }
                    if (xml.Contains("retenciones:arrendamientoenfideicomiso"))//para arrendamientosenfideicomiso agregar 
                    {
                        xml = xml.Replace("retenciones:arrendamientoenfideicomiso", "arrendamientoenfideicomiso:Arrendamientoenfideicomiso");
                        xml = xml.Replace("arrendamientoenfideicomiso:Arrendamientoenfideicomiso Version=\"1.0\"", "arrendamientoenfideicomiso:Arrendamientoenfideicomiso Version=\"1.0\" xsi:schemaLocation=\"http://www.sat.gob.mx/esquemas/retencionpago/1/arrendamientoenfideicomiso http://www.sat.gob.mx/esquemas/retencionpago/1/arrendamientoenfideicomiso/arrendamientoenfideicomiso.xsd\" xmlns:arrendamientoenfideicomiso=\"http://www.sat.gob.mx/esquemas/retencionpago/1/arrendamientoenfideicomiso\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"");
                    }
                    if (xml.Contains("retenciones:enajenaciondeAcciones"))//para arrendamientosenfideicomiso agregar 
                    {
                        xml = xml.Replace("retenciones:enajenaciondeAcciones", "enajenaciondeacciones:EnajenaciondeAcciones");
                        xml = xml.Replace("enajenaciondeacciones:EnajenaciondeAcciones Version=\"1.0\"", "enajenaciondeacciones:EnajenaciondeAcciones Version=\"1.0\" xsi:schemaLocation=\"http://www.sat.gob.mx/esquemas/retencionpago/1/enajenaciondeacciones http://www.sat.gob.mx/esquemas/retencionpago/1/enajenaciondeacciones/enajenaciondeacciones.xsd\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:enajenaciondeacciones=\"http://www.sat.gob.mx/esquemas/retencionpago/1/enajenaciondeacciones\"");
                    }
                    //-----se agrego el espacio de nombre asu clase
                    if (xml.Contains("retenciones:fideicomisonoempresarial"))//para fideicomisonoempresarial agregar 
                    {
                        xml = xml.Replace("retenciones:fideicomisonoempresarial", "fideicomisonoempresarial:Fideicomisonoempresarial");
                        xml = xml.Replace("<fideicomisonoempresarial:Fideicomisonoempresarial", "<fideicomisonoempresarial:Fideicomisonoempresarial xmlns:fideicomisonoempresarial=\"http://www.sat.gob.mx/esquemas/retencionpago/1/fideicomisonoempresarial\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"");

                    }
                    if (xml.Contains("retenciones:intereseshipotecarios"))//para intereseshipotecarios agregar 
                    {
                        xml = xml.Replace("retenciones:intereseshipotecarios", "intereseshipotecarios:Intereseshipotecarios");
                        xml = xml.Replace("<intereseshipotecarios:Intereseshipotecarios", "<intereseshipotecarios:Intereseshipotecarios xmlns:intereseshipotecarios=\"http://www.sat.gob.mx/esquemas/retencionpago/1/intereseshipotecarios\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"");

                    }
                    if (xml.Contains("retenciones:operacionesconderivados"))//para operacionesconderivados agregar 
                    {
                        xml = xml.Replace("retenciones:operacionesconderivados", "operacionesconderivados:Operacionesconderivados");
                        xml = xml.Replace("<operacionesconderivados:Operacionesconderivados", "<operacionesconderivados:Operacionesconderivados xmlns:operacionesconderivados=\"http://www.sat.gob.mx/esquemas/retencionpago/1/operacionesconderivados\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"");

                    }
                    if (xml.Contains("retenciones:pagosaextranjeros"))//para pagosaextranjeros agregar 
                    {
                        xml = xml.Replace("retenciones:pagosaextranjeros", "pagosaextranjeros:Pagosaextranjeros");
                        xml = xml.Replace("<pagosaextranjeros:Pagosaextranjeros", "<pagosaextranjeros:Pagosaextranjeros xmlns:pagosaextranjeros=\"http://www.sat.gob.mx/esquemas/retencionpago/1/pagosaextranjeros\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"");

                    }
                    if (xml.Contains("retenciones:planesderetiro"))//para planesderetiro agregar 
                    {
                        xml = xml.Replace("retenciones:planesderetiro", "planesderetiro11:Planesderetiro");
                        xml = xml.Replace("<planesderetiro11:Planesderetiro", "<planesderetiro11:Planesderetiro xmlns:planesderetiro11=\"http://www.sat.gob.mx/esquemas/retencionpago/1/planesderetiro11\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"");

                    }
                    if (xml.Contains("retenciones:premios"))//para premios agregar 
                    {
                        xml = xml.Replace("retenciones:premios", "premios:Premios");
                        xml = xml.Replace("<premios:Premios", "<premios:Premios xmlns:premios=\"http://www.sat.gob.mx/esquemas/retencionpago/1/premios\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"");

                    }
                    if (xml.Contains("retenciones:sectorFinanciero"))//para sectorfinanciero agregar 
                    {
                        xml = xml.Replace("retenciones:sectorFinanciero", "sectorfinanciero:SectorFinanciero");
                        xml = xml.Replace("<sectorfinanciero:SectorFinanciero", "<sectorfinanciero:SectorFinanciero xmlns:sectorfinanciero=\"http://www.sat.gob.mx/esquemas/retencionpago/1/sectorfinanciero\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"");

                    }
                    return xml;
                }
            }
        }
        //public Byte[] GetPdfFromComprobante(string xmlComprobante)
        //{
        //    Comprobante comprobante = GetComprobanteFromString(xmlComprobante);
        //    comprobante.CadenaOriginalTimbre = @"||1.0|6D586938-1A02-44A1-B015-CC1B37D56BCF|2012-08-11T21:46:41|kB0Caoa3gtsqo8klGTHaOgDLCOX1mjT84vaTm0l9iM82sSfTlhLrqEd5o+X3lzETlxaLmQogX27N+tD+Izc/BsqFWHax5Ln2krh9ER0feWD4CglUqGZwnu7BWnFcLNgN8OtcmvrRibjBTsAEOvcfZu4q80aXb/b2LxEHbqM3yuw=|00001000000201614141||";
        //    comprobante.CantidadLetra = "UNO MXN 16/100";
        //    return this.GetPdfFromComprobante(comprobante, 1, TipoDocumento.FacturaGeneral);
        //}

        private byte[] GetQrCode(string cadena)
        {
            QrEncoder encoder = new QrEncoder();
            QrCode qrCode;
            if (!encoder.TryEncode(cadena, out qrCode))
            {
                throw new Exception("Error al generar codigo bidimensional: " + cadena);
            }
            GraphicsRenderer gRenderer = new GraphicsRenderer(new FixedModuleSize(2, QuietZoneModules.Two), Brushes.Black, Brushes.White);

            MemoryStream ms = new MemoryStream();
            gRenderer.WriteToStream(qrCode.Matrix, ImageFormat.Png, ms);
            return ms.GetBuffer();
        }

       

        private void PrintFields(Type tipo, string prefijo, object emisor, ComprobantePdf comp)
        {
            foreach (PropertyInfo pi in tipo.GetProperties())
            {

                if ((pi != null/* && (pi.PropertyType == typeof(t_UbicacionFiscal) */|| pi.PropertyType == typeof(t_Ubicacion)))
                    PrintFields(pi.PropertyType, prefijo + pi.Name, pi.GetValue(emisor, null), comp);
                else
                {
                    try
                    {
                        if (emisor != null && !pi.PropertyType.IsArray)
                        {
                            var valor = pi.GetValue(emisor, null) == null
                                   ? ""
                                   : pi.GetValue(emisor, null).ToString();
                            var property = comp.GetType().GetProperty(prefijo + "_" + pi.Name);
                            if (property != null)
                            {
                                property.SetValue(comp, valor, null);
                            }
                        }
                    }
                    catch (Exception eee)
                    {
                        Logger.Error(eee);
                    }


                }

            }
        }

        public Byte[] GetPdfFromRetenciones(Retenciones.Retenciones comprobante, string xml, string cadenaOriginal)
        {
            // Get and set all the values fomr reporting services
            string userName = ConfigurationManager.AppSettings["RSUserName"];
            string password = ConfigurationManager.AppSettings["RSPass"];
            string url = ConfigurationManager.AppSettings["RSUrlService"];
            ReportingService2005 clt = new ReportingService2005
            {
                Credentials = new NetworkCredential(userName, password),
                Url = url
            };
            CatalogItem[] cats = clt.ListChildren("/", true);
            var rep = GetRutaPdf(TipoDocumento.Retenciones);
            var reporte = cats.FirstOrDefault(p => p.Name == comprobante.Emisor.RFCEmisor + "_" + rep) ??
                          cats.FirstOrDefault(p => p.Name == rep);

            if (reporte == null)
            {
                throw new FaultException("No esta configurada la plantilla para este comprobante");
            }
            string enteros;
            string decimales;
            string totalLetra = comprobante.Totales.montoTotRet.ToString();
            if (totalLetra.IndexOf('.') == -1)
            {
                enteros = "0";
                decimales = "0";
            }
            else
            {
                enteros = totalLetra.Substring(0, totalLetra.IndexOf('.'));
                decimales = totalLetra.Substring(totalLetra.IndexOf('.') + 1);
            }
            var cantidadletra = CantidadLetra.Enletras(totalLetra,"MXN");
          //  string total = enteros.PadLeft(10, '0') + "." + decimales.PadRight(6, '0');
            string total = enteros + "." + decimales;
            string rfcRec = "";
            if (comprobante.Receptor.Nacionalidad == RetencionesReceptorNacionalidad.Nacional)
                rfcRec = ((RetencionesReceptorNacional) comprobante.Receptor.Item).RFCRecep;
            else rfcRec = ((RetencionesReceptorExtranjero) comprobante.Receptor.Item).NumRegIdTrib;


            int tam_var = comprobante.Sello.Length;
            string Var_Sub = comprobante.Sello.Substring((tam_var - 8), 8);

            //para CFDI
            //string URL = @"https://verificacfdi.facturaelectronica.sat.gob.mx/default.aspx";
            //para retenciones
            string URL = @"https://prodretencionverificacion.clouda.sat.gob.mx/";


            string cadenaCodigo = URL + "?" + "&id=" + comprobante.Complemento.timbreFiscalDigital.UUID.ToUpper() + "&re=" + comprobante.Emisor.RFCEmisor + "&rr=" + rfcRec + "&tt=" + total +"&fe=" + Var_Sub ;

                        
           // string cadenaCodigo = "?re=" + comprobante.Emisor.RFCEmisor + "&rr=" + rfcRec + "&tt=" +
            //                      total + "&id=" +            comprobante.Complemento.timbreFiscalDigital.UUID.ToUpper();

            byte[] bm = GetQrCode(cadenaCodigo);
           
            string logoEmpresa = Path.Combine(ConfigurationManager.AppSettings["Resources"],
                                              comprobante.Emisor.RFCEmisor, "Logo.png");
            if (!File.Exists(logoEmpresa))
            {
                logoEmpresa = Path.Combine(ConfigurationManager.AppSettings["Resources"], "LogoGenerico.png");
            }
            var logo = File.ReadAllBytes(logoEmpresa);
            var b64Logo = Convert.ToBase64String(logo);
            return GetReport(reporte.Path, xml,cadenaOriginal,cantidadletra,Convert.ToBase64String(bm),b64Logo);
        }


        public Byte[] GetPdfFromComprobante(string rfcEmisor, TipoDocumento tipo,int idempresa,int idcliente, long idpdf)
        {
            try
            {
                ReportService.ReportingService2005 clt = new ReportingService2005();
                string userName = ConfigurationManager.AppSettings["RSUserName"];
                string password = ConfigurationManager.AppSettings["RSPass"];
                string url = ConfigurationManager.AppSettings["RSUrlService"];
                //clt.Credentials = System.Net.CredentialCache.DefaultCredentials;
                clt.Credentials = new NetworkCredential(userName, password);
                clt.Url = url;
                CatalogItem[] cats = clt.ListChildren("/", true);
                var rep = GetRutaPdf(tipo);
                var reporte = cats.FirstOrDefault(p => p.Name == rfcEmisor + "_" + rep);
                if (reporte == null)
                    reporte = cats.FirstOrDefault(p => p.Name == rep);

                if (reporte == null)
                {
                    throw new FaultException("No esta configurada la plantilla para este comprobante");
                }


                return GetReport(reporte.Path, idempresa, idcliente, idpdf, null,"");
            }
            catch (Exception ee)
            {
                //System.Diagnostics.Debugger.Launch();
                Logger.Error(ee);
                if (ee.InnerException != null)
                    Logger.Error(ee.InnerException);
                throw;
            }

        }



        public Byte[] GetPdfFromComprobante(Comprobante comprobante, int orientacion, TipoDocumento tipo, ref long id, string metodoPago, clientes cliente)
        {
            
            try
            {
                ReportService.ReportingService2005 clt = new ReportingService2005();// servicio para (pdf)
                string userName = ConfigurationManager.AppSettings["RSUserName"];
                string password = ConfigurationManager.AppSettings["RSPass"];
                string url = ConfigurationManager.AppSettings["RSUrlService"];
                //clt.Credentials = System.Net.CredentialCache.DefaultCredentials;
                clt.Credentials = new NetworkCredential(userName, password);
                clt.Url = url;
                CatalogItem[] cats = clt.ListChildren("/", true);
                              
                var rep = GetRutaPdf(tipo);
                var reporte = cats.FirstOrDefault(p => p.Name == comprobante.Emisor.Rfc + "_" + rep);
                if (reporte == null)
                {
                    if (comprobante.TipoAddenda != TipoAddenda.SinAddenda)//
                        reporte = cats.FirstOrDefault(p => p.Name == "Addenda33");//
                    else//
                     reporte = cats.FirstOrDefault(p => p.Name == rep);
                    
                }
                if (reporte == null)
                {
                    throw new FaultException("No esta configurada la plantilla para este comprobante");
                }
                if (rep == "PdfHonorarios")
                {
                    comprobante.SubTotal = Convert.ToDecimal(comprobante.Impuestos.TotalImpuestosTrasladados) + comprobante.SubTotal;
                }
                var pdf = GuardaReporte(comprobante,metodoPago);
                id = pdf.IdComprobantePdf;
                string xmlData = null;
                xmlData = comprobante.XmlString;

                decimal totalPago = 0;
                if (comprobante.Complemento != null)
                    if (comprobante.Complemento.Pag != null)
                        if (comprobante.Complemento.Pag.Pago != null && comprobante.Complemento.Pag.Pago.Count() > 0)
                            foreach (var p in comprobante.Complemento.Pag.Pago)
                            {
                                totalPago = totalPago + Convert.ToDecimal(p.Monto);
                            }
                string PagoLetra = "0";
                if (totalPago > 0)
                    PagoLetra = CantidadLetra.Enletras(totalPago.ToString(), comprobante.Complemento.Pag.Pago[0].MonedaP);
             

                /*if (tipo == TipoDocumento.Nomina )
                {
                    xmlData = comprobante.XmlNomina;
                    

                }
                if (tipo == TipoDocumento.ConstructorFirmasCustom)
                {
                    xmlData = comprobante.XmlString;
                }
                 */ 
                //-----------------------------------nueva atributo 
                /*
                if (tipo == TipoDocumento.Complementos)//nuevo
                {

                    xmlData = comprobante.XmlString;
                    XmlDocument xm = new XmlDocument();
                    xm.LoadXml(xmlData);
                    int i = 0; 
                    XmlNodeList Conceptos = xm.GetElementsByTagName("cfdi:Conceptos");
                    XmlNodeList concepto = ((XmlElement)Conceptos[0]).GetElementsByTagName("cfdi:Concepto");
                    foreach (XmlElement nodo1 in concepto)
                    {

                        XmlNodeList IA = ((XmlElement)nodo1).GetElementsByTagName("cfdi:InformacionAduanera");
                        foreach (XmlElement nodo in IA)
                        {
                            string xfecha = nodo.GetAttribute("fecha");
                            nodo.SetAttribute("fechaIA", xfecha);

                        }

                        if (i == 0 && IA.Count == 0)
                        {
                            // XmlElement el = nodo1.OwnerDocument.CreateElement("cfdi:InformacionAduanera");
                            String testNamespace = "http://www.sat.gob.mx/cfd/3";
                            XmlElement el = nodo1.OwnerDocument.CreateElement("cfdi", "InformacionAduanera", testNamespace);
                            el.SetAttribute("aduana", "");
                            el.SetAttribute("fechaIA", "");
                            el.SetAttribute("numero", "");
                            nodo1.AppendChild(el);
                        }
                        i++;
                    }

                     xmlData = xm.InnerXml.ToString();

                }//--------------------------------------------------
                   */
                
                // var db = new NtLinkLocalServiceEntities();
                 //   var cliente = db.clientes.FirstOrDefault(p => p.RFC == comprobante.Receptor.Rfc);

                return GetReport(reporte.Path, pdf.IdEmpresa, cliente.idCliente, pdf.IdComprobantePdf, xmlData, PagoLetra);
            }
            catch (Exception ee)
            {
                //System.Diagnostics.Debugger.Launch();
                Logger.Error(ee);
                if (ee.InnerException != null)
                    Logger.Error(ee.InnerException);
                throw;
            }

        }



        private ComprobantePdf GuardaReporte(Comprobante comprobante, string MetodoPago)
        {
            ComprobantePdf pdf = new ComprobantePdf();

            /*
            Type tip = typeof(Comprobante);
            var fields = tip.GetProperties();
            foreach (PropertyInfo propertyInfo in fields)
            {
                try
                {
                    if (propertyInfo.Name == "Emisor")
                    {
                        PrintFields(propertyInfo.PropertyType, "Em", comprobante.Emisor, pdf);
                    }
                    else if (propertyInfo.Name == "Receptor")
                    {
                        PrintFields(propertyInfo.PropertyType, "Re", comprobante.Receptor, pdf);
                    }
                    else if (propertyInfo.Name == "Impuestos")
                    {
                        PrintFields(propertyInfo.PropertyType, "Imp", comprobante.Impuestos, pdf);
                    }
                    else if (propertyInfo.Name == "DatosAduana")
                    {
                        // PrintFields(propertyInfo.PropertyType, "Aduana", comprobante.DatosAduana, pdf);
                        if (comprobante.DatosAduana != null)
                        {
                            pdf.Aduana_Aduana = comprobante.DatosAduana.Aduana;
                            pdf.Aduana_Anticipo = comprobante.DatosAduana.Anticipo;
                            pdf.Aduana_Contenedores = comprobante.DatosAduana.Contenedores;
                            pdf.Aduana_DiasCredito = comprobante.DatosAduana.DiasCredito;
                            pdf.Aduana_Facturas = comprobante.DatosAduana.Facturas;
                            pdf.Aduana_FechaVencimiento = comprobante.DatosAduana.FechaVencimiento;
                            pdf.Aduana_GuiaHouse = comprobante.DatosAduana.GuiaHouse;
                            pdf.Aduana_GuiaMaster = comprobante.DatosAduana.GuiaMaster;
                            pdf.Aduana_Mercancia = comprobante.DatosAduana.Mercancia;
                            pdf.Aduana_Mterr = comprobante.DatosAduana.Mterr;
                            pdf.Aduana_NoBultos = comprobante.DatosAduana.NoBultos;
                            pdf.Aduana_Pedimento = comprobante.DatosAduana.Pedimento;
                            pdf.Aduana_PesoBruto = comprobante.DatosAduana.PesoBruto;
                            pdf.Aduana_ReferenciaInterna = comprobante.DatosAduana.ReferenciaInterna;
                            pdf.Aduana_ReferenciaPascal = comprobante.DatosAduana.ReferenciaPascal;
                            pdf.Aduana_Saldo = comprobante.DatosAduana.Saldo;
                            pdf.Aduana_SaldoLetra = comprobante.DatosAduana.SaldoLetra;
                            pdf.Aduana_TipoCambioFletes = comprobante.DatosAduana.TipoCambioFletes;
                            pdf.Aduana_TipoCambioPedimento = comprobante.DatosAduana.TipoCambioPedimento;
                            pdf.Aduana_TipoOperacion = comprobante.DatosAduana.TipoOperacion;
                            pdf.Aduana_TotalAddenda = comprobante.DatosAduana.TotalAddenda;
                            pdf.Aduana_ValorAduana = comprobante.DatosAduana.ValorAduana;
                        }
                    }
                    else
                    {
                        var valor = propertyInfo.GetValue(comprobante, null) == null
                                        ? ""
                                        : propertyInfo.GetValue(comprobante, null).ToString();
                        var property = pdf.GetType().GetProperty(propertyInfo.Name);
                        if (property != null)
                        {
                            property.SetValue(pdf, valor, null);
                        }
                    }
                    */



            try
            {
                if (comprobante.Titulo == "Recibo de Donativo")
                {
                    pdf.DonatAprobacion = comprobante.DonatAprobacion;
                    pdf.DonatFecha = comprobante.DonatFecha;
                    pdf.DonatLeyenda = comprobante.DonatLeyenda;
                }
                pdf.LeyendaSuperior = comprobante.LeyendaSuperior;
                pdf.LeyendaInferior = comprobante.LeyendaInferior;

                pdf.Titulo = comprobante.Titulo;
                // pdf.Observaciones = comprobante.Observaciones;
                pdf.Proyecto = comprobante.Proyecto;
                pdf.CantidadLetra = comprobante.CantidadLetra;
                if (comprobante.FechaPago != null)
                    pdf.FechaPago = comprobante.FechaPago.ToString();

                pdf.Moneda = comprobante.Moneda;

                //firmas
                pdf.VoBoNombre = comprobante.VoBoNombre;
                pdf.VoBoPuesto = comprobante.VoBoPuesto;
                pdf.VoBoArea = comprobante.VoBoArea;
                pdf.AutorizoNombre = comprobante.AutorizoNombre;
                pdf.AutorizoPuesto = comprobante.AutorizoPuesto;
                pdf.AutorizoArea = comprobante.AutorizoArea;
                pdf.RecibiNombre = comprobante.RecibiNombre;
                pdf.RecibiPuesto = comprobante.RecibiPuesto;
                pdf.RecibiArea = comprobante.RecibiArea;
                pdf.VoBoTitulo = comprobante.VoBoTitulo;
                pdf.RecibiTitulo = comprobante.RecibiTitulo;
                pdf.AutorizoTitulo = comprobante.AutorizoTitulo;
                pdf.AgregadoArea = comprobante.AgregadoArea;
                pdf.AgregadoNombre = comprobante.AgregadoNombre;
                pdf.AgregadoPuesto = comprobante.AgregadoPuesto;
                pdf.AgregadoTitulo = comprobante.AgregadoTitulo;
                //...

                if (comprobante.Emisor != null)
                {
                    pdf.CURPEmisor = comprobante.CURPEmisor;
                    pdf.Em_nombre = comprobante.Emisor.Nombre;
                    pdf.Em_RegimenFiscal = comprobante.Emisor.RegimenFiscal;
                    pdf.Em_rfc = comprobante.Emisor.Rfc;
                }
                if (comprobante.Receptor != null)
                {
                    pdf.Re_nombre = comprobante.Receptor.Nombre;
                    pdf.Re_rfc = comprobante.Receptor.Rfc;

                }
                if (comprobante.Impuestos != null)
                {
                    if (comprobante.Impuestos.TotalImpuestosRetenidosSpecified == true)
                        pdf.Imp_totalImpuestosRetenidos = comprobante.Impuestos.TotalImpuestosRetenidos;
                    if (comprobante.Impuestos.TotalImpuestosTrasladadosSpecified == true)
                        pdf.Imp_totalImpuestosTrasladados = comprobante.Impuestos.TotalImpuestosTrasladados;


                }

                // PrintFields(propertyInfo.PropertyType, "Aduana", comprobante.DatosAduana, pdf);
                if (comprobante.DatosAduana != null)
                {
                    pdf.Aduana_Aduana = comprobante.DatosAduana.Aduana;
                    pdf.Aduana_Anticipo = comprobante.DatosAduana.Anticipo;
                    pdf.Aduana_Contenedores = comprobante.DatosAduana.Contenedores;
                    pdf.Aduana_DiasCredito = comprobante.DatosAduana.DiasCredito;
                    pdf.Aduana_Facturas = comprobante.DatosAduana.Facturas;
                    pdf.Aduana_FechaVencimiento = comprobante.DatosAduana.FechaVencimiento;
                    pdf.Aduana_GuiaHouse = comprobante.DatosAduana.GuiaHouse;
                    pdf.Aduana_GuiaMaster = comprobante.DatosAduana.GuiaMaster;
                    pdf.Aduana_Mercancia = comprobante.DatosAduana.Mercancia;
                    pdf.Aduana_Mterr = comprobante.DatosAduana.Mterr;
                    pdf.Aduana_NoBultos = comprobante.DatosAduana.NoBultos;
                    pdf.Aduana_Pedimento = comprobante.DatosAduana.Pedimento;
                    pdf.Aduana_PesoBruto = comprobante.DatosAduana.PesoBruto;
                    pdf.Aduana_ReferenciaInterna = comprobante.DatosAduana.ReferenciaInterna;
                    pdf.Aduana_ReferenciaPascal = comprobante.DatosAduana.ReferenciaPascal;
                    pdf.Aduana_Saldo = comprobante.DatosAduana.Saldo;
                    pdf.Aduana_SaldoLetra = comprobante.DatosAduana.SaldoLetra;
                    pdf.Aduana_TipoCambioFletes = comprobante.DatosAduana.TipoCambioFletes;
                    pdf.Aduana_TipoCambioPedimento = comprobante.DatosAduana.TipoCambioPedimento;
                    pdf.Aduana_TipoOperacion = comprobante.DatosAduana.TipoOperacion;
                    pdf.Aduana_TotalAddenda = comprobante.DatosAduana.TotalAddenda;
                    pdf.Aduana_ValorAduana = comprobante.DatosAduana.ValorAduana;
                }

            }
            catch (Exception eee)
            {
                Logger.Error(eee);
            }

            //PrintFields(typeof(TimbreFiscalDigital), "timbre", comprobante.Complemento.timbreFiscalDigital, pdf);
            pdf.timbre_CadenaOriginal = comprobante.Complemento.timbreFiscalDigital.cadenaOriginal;
            pdf.timbre_FechaTimbrado = comprobante.Complemento.timbreFiscalDigital.FechaTimbrado.ToString();
            pdf.timbre_Leyenda = comprobante.Complemento.timbreFiscalDigital.Leyenda;
            pdf.timbre_NoCertificadoSAT = comprobante.Complemento.timbreFiscalDigital.NoCertificadoSAT;
            pdf.timbre_RfcProvCertif = comprobante.Complemento.timbreFiscalDigital.RfcProvCertif;
            pdf.timbre_SelloCFD = comprobante.Complemento.timbreFiscalDigital.SelloCFD;
            pdf.timbre_SelloSAT = comprobante.Complemento.timbreFiscalDigital.SelloSAT;
            pdf.timbre_UUID = comprobante.Complemento.timbreFiscalDigital.UUID;
            pdf.timbre_Version = comprobante.Complemento.timbreFiscalDigital.Version;
            pdf.CadenaOriginalTimbre = comprobante.CadenaOriginalTimbre;

            string enteros;
            string decimales;
            string totalLetra = comprobante.Total.ToString();
            if (totalLetra.IndexOf('.') == -1)
            {
                enteros = "0";
                decimales = "0";
            }
            else
            {
                enteros = totalLetra.Substring(0, totalLetra.IndexOf('.'));
                decimales = totalLetra.Substring(totalLetra.IndexOf('.') + 1);
            }

            //string total = enteros.PadLeft(10, '0') + "." + decimales.PadRight(6, '0');
            string total = enteros + "." + decimales;

            int tam_var = comprobante.Sello.Length;
            string Var_Sub = comprobante.Sello.Substring((tam_var - 8), 8);

            //para CFDI
            string URL = @"https://verificacfdi.facturaelectronica.sat.gob.mx/default.aspx";
            //para retenciones
            //string URL = @"https://prodretencionverificacion.clouda.sat.gob.mx/";


            string cadenaCodigo = URL + "?" + "&id=" + comprobante.Complemento.timbreFiscalDigital.UUID.ToUpper() + "&re=" + comprobante.Emisor.Rfc + "&rr=" + comprobante.Receptor.Rfc + "&tt=" + total + "&fe=" + Var_Sub;



            //string cadenaCodigo = "?re=" + comprobante.Emisor.Rfc + "&rr=" + comprobante.Receptor.Rfc + "&tt=" +
            //                       total + "&id=" + comprobante.Complemento.timbreFiscalDigital.UUID.ToUpper();

            byte[] bm = GetQrCode(cadenaCodigo);
            pdf.QrCode = bm;
            string logoEmpresa = Path.Combine(ConfigurationManager.AppSettings["Resources"],
                                              comprobante.Emisor.Rfc, "Logo.png");
            if (!File.Exists(logoEmpresa))
            {
                logoEmpresa = Path.Combine(ConfigurationManager.AppSettings["Resources"], "LogoGenerico.png");
            }

            var db = new NtLinkLocalServiceEntities();
            var empresa = db.empresa.FirstOrDefault(p => p.RFC == comprobante.Emisor.Rfc);
            if (empresa != null && empresa.Logo == null)
            {
                empresa.Logo = File.ReadAllBytes(logoEmpresa);
                db.empresa.ApplyCurrentValues(empresa);

            }
            pdf.IdEmpresa = empresa.IdEmpresa;

            if (comprobante.TipoAddenda == TipoAddenda.ADO)
            {
                pdf.Valor = comprobante.Valor;
                pdf.Proveedor = comprobante.Proveedor;

            }
            pdf.metodoDePago = MetodoPago;//TipoDEPago(pdf.metodoDePago);//nuevo
            db.ComprobantePdf.AddObject(pdf);
            db.SaveChanges();
            //--------------------------------------
            // List<ConceptoPdf> LConcetos = new List<ConceptoPdf>();
            foreach (var concepto in comprobante.Conceptos)
            {
                ConceptoPdf CPDF = new ConceptoPdf();
                CPDF.cantidad = concepto.Cantidad.ToString();
                if (concepto.CuentaPredial != null)
                    CPDF.CuentaPredial = concepto.CuentaPredial.Numero;
                CPDF.descripcion = concepto.Descripcion;
                CPDF.Detalles = concepto.observaciones;
                CPDF.IdComprobantePdf = pdf.IdComprobantePdf;
                CPDF.importe = concepto.Importe;
                CPDF.noIdentificacion = concepto.NoIdentificacion;
                CPDF.OrdenCompra = concepto.OrdenCompra;
                CPDF.timbre_UUID = pdf.timbre_UUID;
                CPDF.unidad = concepto.Unidad;
                CPDF.valorUnitario = concepto.ValorUnitario;
                CPDF.descuento = concepto.Descuento;
                CPDF.ClaveProdServ = concepto.ClaveProdServ;
                CPDF.ClaveUnidad = concepto.ClaveUnidad;
                db.ConceptoPdf.AddObject(CPDF);
            }
            /*
            var conceptos = comprobante.Conceptos.Select(p => new ConceptoPdf
            {
                timbre_UUID = pdf.timbre_UUID,
                cantidad = p.Cantidad.ToString(),
                CuentaPredial = p.CuentaPredial.Numero,
                importe = p.Importe.ToString(),
                valorUnitario = p.ValorUnitario.ToString(),
                descripcion = p.Descripcion,
                Detalles = p.Detalles,
                unidad = p.Unidad,
                OrdenCompra = p.OrdenCompra,
                noIdentificacion = p.NoIdentificacion,
                IdComprobantePdf = pdf.IdComprobantePdf
            });
            */
            /*
            foreach (ConceptoPdf conceptoPdf in conceptos)
            {
                db.ConceptoPdf.AddObject(conceptoPdf);
            }
             */
            //---------------------------


            if (comprobante.ConceptosAduana != null)
            {
                List<ConceptoPdfAddenda> conceptosAddenda = new List<ConceptoPdfAddenda>();
                foreach (var compleA in comprobante.ConceptosAduana)
                {
                    ConceptoPdfAddenda ca = new ConceptoPdfAddenda();
                    ca.timbre_UUID = pdf.timbre_UUID;
                    ca.cantidad = compleA.Cantidad.ToString();
                    if (compleA.CuentaPredial != null)
                        ca.CuentaPredial = compleA.CuentaPredial.Numero;
                    ca.importe = compleA.Importe;
                    ca.valorUnitario = compleA.ValorUnitario;
                    ca.descripcion = compleA.Descripcion;
                    ca.Detalles = compleA.Detalles;
                    ca.unidad = compleA.Unidad;
                    ca.OrdenCompra = compleA.OrdenCompra;
                    ca.noIdentificacion = compleA.NoIdentificacion;
                    ca.IdComprobantePdf = pdf.IdComprobantePdf;
                    conceptosAddenda.Add(ca);

                }

                /*
                var conceptosAddenda = comprobante.ConceptosAduana.Select(p => new ConceptoPdfAddenda()
                {
                    timbre_UUID = pdf.timbre_UUID,
                    cantidad = p.Cantidad.ToString(),
                    CuentaPredial = p.CuentaPredial.Numero,
                    importe = p.Importe.ToString(),
                    valorUnitario = p.ValorUnitario.ToString(),
                    descripcion = p.Descripcion,
                    Detalles = p.Detalles,
                    unidad = p.Unidad,
                    OrdenCompra = p.OrdenCompra,
                    noIdentificacion = p.NoIdentificacion,
                    IdComprobantePdf = pdf.IdComprobantePdf
                });
                */
                if (conceptosAddenda != null)
                    foreach (var conceptoPdf in conceptosAddenda)
                    {
                        db.ConceptoPdfAddenda.AddObject(conceptoPdf);
                    }
            }


            //TODO GUARDAR CONCEPTOS CARTA PORTE
            if (comprobante.ConceptosCartasPortes != null)
            {
                foreach (var cartaPorte in comprobante.ConceptosCartasPortes)
                {
                    //??
                    cartaPorte.idComprobantePdf = pdf.IdComprobantePdf;
                    db.ConceptosCartaPorte.AddObject(cartaPorte);
                }

            }


            db.SaveChanges();
            return pdf;
        }


        private byte[] GetReport(string report, string xmlData, string cadenaOriginal, string cantidadLetra,string qrCodeb64, string logoB64 )
        {
            Logger.Debug(report);
            ReportExecutionService rs = new ReportExecutionService();
            string userName = ConfigurationManager.AppSettings["RSUserName"];
            string password = ConfigurationManager.AppSettings["RSPass"];
            string url = ConfigurationManager.AppSettings["RSUrlExec"];
            rs.Credentials = new NetworkCredential(userName, password);
            rs.Url = url;
            //rs.Credentials = System.Net.CredentialCache.DefaultCredentials;
            string reportPath = report;//"/ReportesNtLink/Pdf";
            string format = "Pdf";
            string devInfo = @"<DeviceInfo> <OutputFormat>PDF</OutputFormat> </DeviceInfo>";
            int parametros = 5;
            ParameterValue[] parameters = new ParameterValue[parametros];
            parameters[0] = new ParameterValue();
            parameters[0].Name = "CantLetra";
            parameters[0].Value = cantidadLetra;
            parameters[1] = new ParameterValue();
            parameters[1].Name = "CadenaOri";
            parameters[1].Value = cadenaOriginal;
            
                parameters[2] = new ParameterValue();
                parameters[2].Name = "XmlData";
                parameters[2].Value = xmlData;
            parameters[3] = new ParameterValue();
                parameters[3].Name = "QrCode";
                parameters[3].Value = qrCodeb64;
            parameters[4] = new ParameterValue();
                parameters[4].Name = "Logo";
                parameters[4].Value = logoB64;
            //DataSourceCredentials creds = new DataSourceCredentials();

            ////Quitar hardcodeado de base de datos
            //creds.DataSourceName = "DSGAF";
            //creds.UserName = "Admin";
            //creds.Password = "99300055";
            //rs.SetExecutionCredentials(new[] { creds });
            ExecutionHeader execHeader = new ExecutionHeader();
            rs.Timeout = 300000;
            rs.ExecutionHeaderValue = execHeader;
            string historyId = null;
            rs.LoadReport(reportPath, historyId);
            rs.SetExecutionParameters(parameters, "en-US");

            try
            {
                string mimeType;
                string encoding;
                string fileNameExtension;
                Warning[] warnings;
                string[] streamIDs;
                var res = rs.Render(format, devInfo, out fileNameExtension, out mimeType, out encoding, out warnings, out streamIDs);
                Logger.Debug(res.Length);
                return res;
            }
            catch (Exception ee)
            {
                Logger.Error(ee);
                if (ee.InnerException != null)
                    Logger.Error(ee.InnerException);
                return null;
            }
        }


        private byte[] GetReport(string report, int empresa,int idcliente, long idPdf, string xmlData, string PagoLetra)
        {
            Logger.Debug(report + "-" + empresa + "-" + idPdf);
            ReportExecutionService rs = new ReportExecutionService();
            string userName = ConfigurationManager.AppSettings["RSUserName"];
            string password = ConfigurationManager.AppSettings["RSPass"];
            string url = ConfigurationManager.AppSettings["RSUrlExec"];
            rs.Credentials = new NetworkCredential(userName, password);
            rs.Url = url;
            //rs.Credentials = System.Net.CredentialCache.DefaultCredentials;
            string reportPath = report;//"/ReportesNtLink/Pdf";
            string format = "Pdf";
            string devInfo = @"<DeviceInfo> <OutputFormat>PDF</OutputFormat> </DeviceInfo>";
            int parametros = 0;
            if (xmlData == null)
                parametros = 4;
            else parametros = 5;
          
            ParameterValue[] parameters = new ParameterValue[parametros];
            parameters[0] = new ParameterValue();
            parameters[0].Name = "Empresa";
            parameters[0].Value = empresa.ToString();
            parameters[1] = new ParameterValue();
            parameters[1].Name = "IdPdf";
            parameters[1].Value = idPdf.ToString();
            parameters[2] = new ParameterValue();
            parameters[2].Name = "Cliente";
            parameters[2].Value = idcliente.ToString();
            parameters[3] = new ParameterValue();
            parameters[3].Name = "MontoPago";
            parameters[3].Value = PagoLetra;
           
            if (xmlData != null)
            { 
                parameters[4] = new ParameterValue();
                parameters[4].Name = "XmlData";
                parameters[4].Value = xmlData;
                
            }
            //DataSourceCredentials creds = new DataSourceCredentials();

            ////Quitar hardcodeado de base de datos
            //creds.DataSourceName = "DSGAF";
            //creds.UserName = "Admin";
            //creds.Password = "99300055";
            //rs.SetExecutionCredentials(new[] { creds });
            ExecutionHeader execHeader = new ExecutionHeader();
            rs.Timeout = 300000;
            rs.ExecutionHeaderValue = execHeader;
            string historyId = null;
            rs.LoadReport(reportPath, historyId);
            rs.SetExecutionParameters(parameters, "en-US");

            try
            {
                string mimeType;
                string encoding;
                string fileNameExtension;
                Warning[] warnings;
                string[] streamIDs;
                var res = rs.Render(format, devInfo, out fileNameExtension, out mimeType, out encoding, out warnings, out streamIDs);
                Logger.Debug(res.Length);
                return res;
            }
            catch (Exception ee)
            {
                Logger.Error(ee);
                if (ee.InnerException != null)
                    Logger.Error(ee.InnerException);
                return null;
            }
        }




        private string GetRutaPdf(TipoDocumento tipo)
        {
            string ruta = null;
            ruta = "Pdf33";
            /*
            if (tipo == TipoDocumento.FacturaTransportista)
                ruta = "PdfTransportista";
            else 
             */ if (tipo == TipoDocumento.FacturaAduanera)
                    ruta = "Pdf33_Aduanal";
                /* else*/
                if (tipo == TipoDocumento.FacturaGeneralFirmas)
                    ruta = "Pdf33_Firmas";

            /*else if (tipo == TipoDocumento.Referencia)
                ruta = "PdfReferencia";
            else if (tipo == TipoDocumento.ReciboHonorarios || tipo == TipoDocumento.Arrendamiento)
                ruta = "PdfHonorarios";
            
            else if (tipo == TipoDocumento.ConstructorFirmas)
                ruta = "ConstructorFirmas";
            else if (tipo == TipoDocumento.Constructor)
                ruta = "Constructor";
            else if (tipo == TipoDocumento.ConstructorFirmasCustom)
                ruta = "ConstructorFirmasCustom";
            else if (tipo == TipoDocumento.FacturaLiverpool)
                ruta = "FacturaLiverpool";
            else if (tipo == TipoDocumento.FacturaMabe)
                ruta = "FacturaMabe";
            else if (tipo == TipoDocumento.FacturaDeloitte)
                ruta = "FacturaDeloitte";
            else if (tipo == TipoDocumento.FacturaSorianaCEDIS)
                ruta = "FacturaSorianaCEDIS";
            else if (tipo == TipoDocumento.FacturaSorianaTienda)
                ruta = "FacturaSorianaTienda";
            else if (tipo == TipoDocumento.FacturaAdo)
                ruta = "FacturaAdo";
            else if (tipo == TipoDocumento.CorporativoAduanal)
                ruta = "CorporativoAduanal";
            else if (tipo == TipoDocumento.FacturaLucent)
                ruta = "PdfLucent";
            else if (tipo == TipoDocumento.CartaPorte)
                ruta = "PdfCartaPorte";
            else if (tipo == TipoDocumento.Nomina)
                ruta = "PdfNomina";
            else if (tipo == TipoDocumento.Complementos)
                ruta = "PdfComplementos";
            else 
             */
            if (tipo == TipoDocumento.Retenciones)
            ruta = "Retenciones";
            
            return ruta;

        }

        private string GetRutaPdfCustomizado(Comprobante comprobante, int orientacion, TipoDocumento tipo)
        {
            string ruta = null;
            ruta = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Reportes", comprobante.Emisor.Rfc, orientacion == 0 ?
                "Pdf.rdlc" : "Horizontal.rdlc");

            if (tipo == TipoDocumento.FacturaTransportista)
                ruta = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Reportes", comprobante.Emisor.Rfc, "PdfTransportista.rdlc");
            else if (tipo == TipoDocumento.FacturaAduanera)
                ruta = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Reportes", comprobante.Emisor.Rfc, "Aduanera.rdlc");
            else if (tipo == TipoDocumento.Referencia)
                ruta = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Reportes", comprobante.Emisor.Rfc, "PdfReferencia.rdlc");
            else if (tipo == TipoDocumento.Constructor)
                ruta = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Reportes", comprobante.Emisor.Rfc, "Constructor.rdlc");
            else if (tipo == TipoDocumento.FacturaGeneralFirmas)
                ruta = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Reportes", comprobante.Emisor.Rfc, "PdfFirmas.rdlc");

            else if (tipo == TipoDocumento.ConstructorFirmas)
                ruta = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Reportes", comprobante.Emisor.Rfc, "ConstructorFirmas.rdlc");


            else if (tipo == TipoDocumento.ReciboHonorarios || tipo == TipoDocumento.Arrendamiento)
            {
                ruta = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Reportes", comprobante.Emisor.Rfc, "PdfHonorarios.rdlc");
                comprobante.SubTotal = Convert.ToDecimal( comprobante.Impuestos.TotalImpuestosTrasladados) + comprobante.SubTotal;
            }

            return ruta;
        }


        public static Comprobante GetComprobanteFromString(string xmlContent)
        {
            XmlSerializer ser = new XmlSerializer(typeof(Comprobante));
            StringReader sr = new StringReader(xmlContent);
            object obj = ser.Deserialize(sr);
            var c = obj as Comprobante;

            if (c != null && c.Complemento != null && c.Complemento.Any.Count > 0)
            {
                var d = c.Complemento.Any.FirstOrDefault(p => p.LocalName == "TimbreFiscalDigital");
                if (d != null)
                {
                    XmlSerializer des = new XmlSerializer(typeof(TimbreFiscalDigital));
                    TimbreFiscalDigital tim = (TimbreFiscalDigital)des.Deserialize(new XmlTextReader(new StringReader(d.OuterXml)));
                    GeneradorCadenasTimbre gcad = new GeneradorCadenasTimbre();
                    var cadenaTimbre = gcad.CadenaOriginal(xmlContent);
                    c.CadenaOriginalTimbre = cadenaTimbre;
                    c.Complemento.timbreFiscalDigital = tim;
                }
                
            }
            return c;
        }
        public static string FirmarRetencion(string cadenaOriginal, string rutaLlave, string pass)
        {
            if (!File.Exists(rutaLlave))
            {
                throw new Exception("No se encontró el archivo: rutallave");
            }
            
            string formatoLlave = Path.GetExtension(rutaLlave).ToLower();
            byte[] llave = File.ReadAllBytes(rutaLlave);
            RSACryptoServiceProvider rsa = OpensslKey.DecodePrivateKey(llave, pass, formatoLlave);
            HashAlgorithm cryp = new SHA1CryptoServiceProvider();
            byte[] b = rsa.SignData(Encoding.UTF8.GetBytes(cadenaOriginal), cryp);
            Logger.Info(cadenaOriginal);
            byte[] hash = cryp.ComputeHash(Encoding.UTF8.GetBytes(cadenaOriginal));
            Logger.Info(BitConverter.ToString(hash).Replace("-", ""));
           // Logger.Info(Convert.ToBase64String(b));
            return Convert.ToBase64String(b);
          
            /*
             byte[] llave = File.ReadAllBytes(rutaLlave);
            if (File.Exists(rutaLlave + ".pem"))
            {
                rutaLlave = rutaLlave + ".pem";
            }
            string ext = Path.GetExtension(rutaLlave);
            //if (string.IsNullOrEmpty(pass))
            //    pass = "12345678a";
            RSACryptoServiceProvider privateKey1 = OpensslKey.DecodePrivateKey(llave, pass, ext);
            UTF8Encoding e = new UTF8Encoding(true);
            byte[] signature = privateKey1.SignData(e.GetBytes(cadenaOriginal), "SHA256");
            string sello256 = Convert.ToBase64String(signature);

            return sello256;
            */
             

        }

        public static string Firmar(string cadenaOriginal, string rutaLlave, string pass)
        {
            if (!File.Exists(rutaLlave))
            {
                throw new Exception("No se encontró el archivo: rutallave");
            }
            /*
            string formatoLlave = Path.GetExtension(rutaLlave).ToLower();
            byte[] llave = File.ReadAllBytes(rutaLlave);
            RSACryptoServiceProvider rsa = OpensslKey.DecodePrivateKey(llave, pass, formatoLlave);
            HashAlgorithm cryp = new SHA1CryptoServiceProvider();
            byte[] b = rsa.SignData(Encoding.UTF8.GetBytes(cadenaOriginal), cryp);
            Logger.Info(cadenaOriginal);
            byte[] hash = cryp.ComputeHash(Encoding.UTF8.GetBytes(cadenaOriginal));
            Logger.Info(BitConverter.ToString(hash).Replace("-", ""));
            Logger.Info(Convert.ToBase64String(b));
            return Convert.ToBase64String(b);
             */

            
            byte[] llave = File.ReadAllBytes(rutaLlave);
            if (File.Exists(rutaLlave + ".pem"))
            {
                rutaLlave = rutaLlave + ".pem";
            }
            string ext = Path.GetExtension(rutaLlave);
            //if (string.IsNullOrEmpty(pass))
            //    pass = "12345678a";
            RSACryptoServiceProvider privateKey1 = OpensslKey.DecodePrivateKey(llave, pass, ext);
            UTF8Encoding e = new UTF8Encoding(true);
            byte[] signature = privateKey1.SignData(e.GetBytes(cadenaOriginal), "SHA256");
            string sello256 = Convert.ToBase64String(signature);

            return sello256;
            
        
        }

        private readonly XNamespace _nsRet = "http://www.sat.gob.mx/esquemas/retencionpago/1";
        private readonly XNamespace _ns = "http://www.sat.gob.mx/cfd/3";
        private readonly XNamespace _donat = "http://www.sat.gob.mx/cfd/donat";

        private string ConcatenaTimbreRet(XElement entrada, string xmlTimbre, string xmlDonat, string xmlAddenda,
            bool addendaRepetida, List<XElement> nodosAddenda = null)
        {
            XElement timbre = XElement.Load(new StringReader(xmlTimbre));
          //  XElement timbre = new XElement("timbre", "RecordRGV");//quitar esto solo pruebas
            var complemento = entrada.Elements(_nsRet + "Complemento").FirstOrDefault();
            if (complemento == null)
            {
                entrada.Add(new XElement(_nsRet + "Complemento"));
                complemento = entrada.Elements(_nsRet + "Complemento").FirstOrDefault();
            }
            complemento.Add(timbre);
            if (xmlDonat != null)
            {
                XElement donat = XElement.Load(new StringReader(xmlDonat));
                complemento.Add(donat);
            }
            if (xmlAddenda != null)
            {
                XElement add = XElement.Load(new StringReader(xmlAddenda));
                if (addendaRepetida)
                {
                    entrada.Add(add);
                }
                else
                {
                    entrada.Add(new XElement(_nsRet + "Addenda"));
                    var addenda = entrada.Elements(_nsRet + "Addenda").FirstOrDefault();
                    addenda.Add(add);
                }
            }
            if (nodosAddenda != null && nodosAddenda.Count > 0)
            {
                entrada.Add(new XElement(_nsRet + "Addenda"));
                var addenda = entrada.Elements(_nsRet + "Addenda").FirstOrDefault();
                foreach (XElement nodosAddendum in nodosAddenda)
                {
                    addenda.Add(nodosAddendum);
                }
            }

            MemoryStream mem = new MemoryStream();
            StreamWriter tw = new StreamWriter(mem, Encoding.UTF8);
            //XmlWriter xmlWriter = XmlWriter.Create(tw,
            //                                     new XmlWriterSettings() {Indent = false, Encoding = Encoding.UTF8});
            entrada.Save(tw, SaveOptions.DisableFormatting);
            string xml = Encoding.UTF8.GetString(mem.GetBuffer());
            xml = xml.Substring(xml.IndexOf(Convert.ToChar(60)));
            xml = xml.Substring(0, (xml.LastIndexOf(Convert.ToChar(62)) + 1));
            //xml = xml.Replace("xmlns:donat=\"http://www.sat.gob.mx/donat\"", "");

            return xml;
        }




        private string ConcatenaTimbre(XElement entrada, string xmlTimbre, string xmlDonat, string xmlAddenda, bool addendaRepetida, List<XElement> nodosAddenda = null )
        {
            XElement timbre = XElement.Load(new StringReader(xmlTimbre));
           // XElement timbre = new XElement("timbre","RecordRGV");//quitar esto
            
            var complemento = entrada.Elements(_ns + "Complemento").FirstOrDefault();
            if (complemento == null)
            {
                entrada.Add(new XElement(_ns + "Complemento"));
                complemento = entrada.Elements(_ns + "Complemento").FirstOrDefault();
            }
            complemento.Add(timbre);
            if (xmlDonat != null)
            {
                XElement donat = XElement.Load(new StringReader(xmlDonat));
                complemento.Add(donat);
            }
            if (xmlAddenda != null)
            {
                XElement add = XElement.Load(new StringReader(xmlAddenda));
                if (addendaRepetida)
                {
                    entrada.Add(add);
                }
                else
                {
                    entrada.Add(new XElement(_ns + "Addenda"));
                    var addenda = entrada.Elements(_ns + "Addenda").FirstOrDefault();
                    addenda.Add(add);
                }
            }
            if (nodosAddenda != null && nodosAddenda.Count > 0)
            {
                entrada.Add(new XElement(_ns + "Addenda"));
                var addenda = entrada.Elements(_ns + "Addenda").FirstOrDefault();
                foreach (XElement nodosAddendum in nodosAddenda)
                {
                    addenda.Add(nodosAddendum);
                }
            }

            MemoryStream mem = new MemoryStream();
            StreamWriter tw = new StreamWriter(mem, Encoding.UTF8);
            //XmlWriter xmlWriter = XmlWriter.Create(tw,
            //                                     new XmlWriterSettings() {Indent = false, Encoding = Encoding.UTF8});
            entrada.Save(tw, SaveOptions.DisableFormatting);
            string xml = Encoding.UTF8.GetString(mem.GetBuffer());
            xml = xml.Substring(xml.IndexOf(Convert.ToChar(60)));
            xml = xml.Substring(0, (xml.LastIndexOf(Convert.ToChar(62)) + 1));
            //xml = xml.Replace("xmlns:donat=\"http://www.sat.gob.mx/donat\"", "");


            return xml;
        }



        public string GetXmlAddenda(object addenda, Type tipoAddenda, string prefijo, string ns)
        {
            XmlSerializer ser;
            XmlSerializerNamespaces namespaces = new XmlSerializerNamespaces();

            if (string.IsNullOrEmpty(prefijo))
            {
                ser = new XmlSerializer(tipoAddenda, ns);
            }
            else
            {
                ser = new XmlSerializer(tipoAddenda);
                namespaces.Add(prefijo, ns);
            }

            try
            {
                using (MemoryStream memStream = new MemoryStream())
                {
                    var sw = new StreamWriter(memStream, Encoding.UTF8);
                    using (
                        XmlWriter xmlWriter = XmlWriter.Create(sw,
                                                               new XmlWriterSettings() { Indent = false, Encoding = Encoding.UTF8 }))
                    {
                        if (namespaces.Count > 0)
                            ser.Serialize(xmlWriter, addenda, namespaces);
                        else
                        {
                            ser.Serialize(xmlWriter, addenda);
                        }
                        string xml = Encoding.UTF8.GetString(memStream.GetBuffer());
                        xml = xml.Substring(xml.IndexOf(Convert.ToChar(60)));
                        xml = xml.Substring(0, (xml.LastIndexOf(Convert.ToChar(62)) + 1));
                        return xml;
                    }
                }
            }
            catch (Exception ee)
            {

                Logger.Error(ee);
                return null;
            }
        }

        public string GetXmlAddendaDeloitte(AddendaDeloitte addenda)
        {
            XmlSerializer ser = new XmlSerializer(typeof(AddendaDeloitte));
            try
            {
                using (MemoryStream memStream = new MemoryStream())
                {
                    var sw = new StreamWriter(memStream, Encoding.UTF8);
                    using (
                        XmlWriter xmlWriter = XmlWriter.Create(sw,
                                                               new XmlWriterSettings() { Indent = false, Encoding = Encoding.UTF8 }))
                    {
                        XmlSerializerNamespaces namespaces = new XmlSerializerNamespaces();
                        namespaces.Add("del", "http://www.deloitte.com/CFD/Addenda/Receptor");
                        ser.Serialize(xmlWriter, addenda, namespaces);
                        string xml = Encoding.UTF8.GetString(memStream.GetBuffer());
                        xml = xml.Substring(xml.IndexOf(Convert.ToChar(60)));
                        xml = xml.Substring(0, (xml.LastIndexOf(Convert.ToChar(62)) + 1));
                        //xml = xml.Replace("xmlns:donat=\"http://www.sat.gob.mx/donat\"", "");
                        return xml;
                    }
                }
            }
            catch (Exception ee)
            {

                Logger.Error(ee);
                return null;
            }
        }

        public string GetXmlINE(Complemento.INE impuestos)
        {
            XmlSerializer ser = new XmlSerializer(typeof(Complemento.INE));
            try
            {
                using (MemoryStream memStream = new MemoryStream())
                {
                    var sw = new StreamWriter(memStream, Encoding.UTF8);
                    using (
                        XmlWriter xmlWriter = XmlWriter.Create(sw,
                                                               new XmlWriterSettings() { Indent = false, Encoding = Encoding.UTF8 }))
                    {
                        XmlSerializerNamespaces namespaces = new XmlSerializerNamespaces();
                        namespaces.Add("ine", "http://www.sat.gob.mx/ine");
                        ser.Serialize(xmlWriter, impuestos, namespaces);
                        string xml = Encoding.UTF8.GetString(memStream.GetBuffer());
                        xml = xml.Substring(xml.IndexOf(Convert.ToChar(60)));
                        xml = xml.Substring(0, (xml.LastIndexOf(Convert.ToChar(62)) + 1));
                        //xml = xml.Replace("xmlns:donat=\"http://www.sat.gob.mx/donat\"", "");
                        xml = xml.Replace("p1:schemaLocation=\"http://www.sat.gob.mx/Pagos http://www.sat.gob.mx/sitio_internet/cfd/Pagos/Pagos10.xsd\"", "");
                        xml = xml.Replace("xmlns:p1=\"http://www.w3.org/2001/XMLSchema-instance\"", "");

                        return xml;
                    }
                }
            }
            catch (Exception ee)
            {

                Logger.Error(ee);
                return null;
            }

        }

        public string GetXmlVEHICULOUSADO(VehiculoUsado impuestos)
        {
            XmlSerializer ser = new XmlSerializer(typeof(VehiculoUsado));
            try
            {
                using (MemoryStream memStream = new MemoryStream())
                {
                    var sw = new StreamWriter(memStream, Encoding.UTF8);
                    using (
                        XmlWriter xmlWriter = XmlWriter.Create(sw,
                                                               new XmlWriterSettings() { Indent = false, Encoding = Encoding.UTF8 }))
                    {
                        XmlSerializerNamespaces namespaces = new XmlSerializerNamespaces();
                        namespaces.Add("vehiculousado", "http://www.sat.gob.mx/vehiculousado");
                        ser.Serialize(xmlWriter, impuestos, namespaces);
                        string xml = Encoding.UTF8.GetString(memStream.GetBuffer());
                        xml = xml.Substring(xml.IndexOf(Convert.ToChar(60)));
                        xml = xml.Substring(0, (xml.LastIndexOf(Convert.ToChar(62)) + 1));
                        //xml = xml.Replace("xmlns:donat=\"http://www.sat.gob.mx/donat\"", "");
                      //  xml = xml.Replace("p1:schemaLocation=\"http://www.sat.gob.mx/Pagos http://www.sat.gob.mx/sitio_internet/cfd/Pagos/Pagos10.xsd\"", "");
                        xml = xml.Replace("xmlns:p1=\"http://www.w3.org/2001/XMLSchema-instance\"", "");

                        return xml;
                    }
                }
            }
            catch (Exception ee)
            {

                Logger.Error(ee);
                return null;
            }

        }


        public string GetXmlCartaPorte(CartaPorte impuestos)
        {
            XmlSerializer ser = new XmlSerializer(typeof(CartaPorte));
            try
            {
                using (MemoryStream memStream = new MemoryStream())
                {
                    var sw = new StreamWriter(memStream, Encoding.UTF8);
                    using (
                        XmlWriter xmlWriter = XmlWriter.Create(sw,
                                                               new XmlWriterSettings() { Indent = false, Encoding = Encoding.UTF8 }))
                    {
                        XmlSerializerNamespaces namespaces = new XmlSerializerNamespaces();
                        namespaces.Add("cartaporte", "http://www.sat.gob.mx/CartaPorte");
                        ser.Serialize(xmlWriter, impuestos, namespaces);
                        string xml = Encoding.UTF8.GetString(memStream.GetBuffer());
                        xml = xml.Substring(xml.IndexOf(Convert.ToChar(60)));
                        xml = xml.Substring(0, (xml.LastIndexOf(Convert.ToChar(62)) + 1));

                        return xml;
                    }
                }
            }
            catch (Exception ee)
            {

                Logger.Error(ee);
                return null;
            }

        }

        public string GetXmlVehiculoUsado(VehiculoUsado impuestos)
        {
            XmlSerializer ser = new XmlSerializer(typeof(VehiculoUsado));
            try
            {
                using (MemoryStream memStream = new MemoryStream())
                {
                    var sw = new StreamWriter(memStream, Encoding.UTF8);
                    using (
                        XmlWriter xmlWriter = XmlWriter.Create(sw,
                                                               new XmlWriterSettings() { Indent = false, Encoding = Encoding.UTF8 }))
                    {
                        XmlSerializerNamespaces namespaces = new XmlSerializerNamespaces();
                        namespaces.Add("vehiculousado", "http://www.sat.gob.mx/vehiculousado");
                        ser.Serialize(xmlWriter, impuestos, namespaces);
                        string xml = Encoding.UTF8.GetString(memStream.GetBuffer());
                        xml = xml.Substring(xml.IndexOf(Convert.ToChar(60)));
                        xml = xml.Substring(0, (xml.LastIndexOf(Convert.ToChar(62)) + 1));
                  
                        return xml;
                    }
                }
            }
            catch (Exception ee)
            {

                Logger.Error(ee);
                return null;
            }

        }

        public string GetXmlPagos(Complemento.Pagos impuestos)
        {
            XmlSerializer ser = new XmlSerializer(typeof(Complemento.Pagos));
            try
            {
                using (MemoryStream memStream = new MemoryStream())
                {
                    var sw = new StreamWriter(memStream, Encoding.UTF8);
                    using (
                        XmlWriter xmlWriter = XmlWriter.Create(sw,
                                                               new XmlWriterSettings() { Indent = false, Encoding = Encoding.UTF8 }))
                    {
                        XmlSerializerNamespaces namespaces = new XmlSerializerNamespaces();
                        namespaces.Add("pago10", "http://www.sat.gob.mx/Pagos");
                        ser.Serialize(xmlWriter, impuestos, namespaces);
                        string xml = Encoding.UTF8.GetString(memStream.GetBuffer());
                        xml = xml.Substring(xml.IndexOf(Convert.ToChar(60)));
                        xml = xml.Substring(0, (xml.LastIndexOf(Convert.ToChar(62)) + 1));
                        //xml = xml.Replace("xmlns:donat=\"http://www.sat.gob.mx/donat\"", "");
                        xml = xml.Replace("p1:schemaLocation=\"http://www.sat.gob.mx/Pagos http://www.sat.gob.mx/sitio_internet/cfd/Pagos/Pagos10.xsd\"", "");
                        xml = xml.Replace("xmlns:p1=\"http://www.w3.org/2001/XMLSchema-instance\"", "");

                        return xml;
                    }
                }
            }
            catch (Exception ee)
            {

                Logger.Error(ee);
                return null;
            }

        }
        public string GetXmlServicioParcialConstruccion(parcialesconstruccion impuestos)
        {
            XmlSerializer ser = new XmlSerializer(typeof(parcialesconstruccion));
            try
            {
                using (MemoryStream memStream = new MemoryStream())
                {
                    var sw = new StreamWriter(memStream, Encoding.UTF8);
                    using (
                        XmlWriter xmlWriter = XmlWriter.Create(sw,
                                                               new XmlWriterSettings() { Indent = false, Encoding = Encoding.UTF8 }))
                    {
                        XmlSerializerNamespaces namespaces = new XmlSerializerNamespaces();
                        namespaces.Add("servicioparcial", "http://www.sat.gob.mx/servicioparcialconstruccion");
                        ser.Serialize(xmlWriter, impuestos, namespaces);
                        string xml = Encoding.UTF8.GetString(memStream.GetBuffer());
                        xml = xml.Substring(xml.IndexOf(Convert.ToChar(60)));
                        xml = xml.Substring(0, (xml.LastIndexOf(Convert.ToChar(62)) + 1));
                        xml = xml.Replace("xmlns:p1=\"http://www.w3.org/2001/XMLSchema-instance\"", "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"");
                        xml = xml.Replace("p1:schemaLocation", "xsi:schemaLocation");
                        return xml;
                    }
                }
            }
            catch (Exception ee)
            {

                Logger.Error(ee);
                return null;
            }

        }


        public string GetXmlImpuestosLocales(ImpuestosLocales impuestos)
        {
            XmlSerializer ser = new XmlSerializer(typeof(ImpuestosLocales));
            try
            {
                using (MemoryStream memStream = new MemoryStream())
                {
                    var sw = new StreamWriter(memStream, Encoding.UTF8);
                    using (
                        XmlWriter xmlWriter = XmlWriter.Create(sw,
                                                               new XmlWriterSettings() { Indent = false, Encoding = Encoding.UTF8 }))
                    {
                        XmlSerializerNamespaces namespaces = new XmlSerializerNamespaces();
                        namespaces.Add("implocal", "http://www.sat.gob.mx/implocal");
                        ser.Serialize(xmlWriter, impuestos, namespaces);
                        string xml = Encoding.UTF8.GetString(memStream.GetBuffer());
                        xml = xml.Substring(xml.IndexOf(Convert.ToChar(60)));
                        xml = xml.Substring(0, (xml.LastIndexOf(Convert.ToChar(62)) + 1));
                        xml = xml.Replace("xmlns:p1=\"http://www.w3.org/2001/XMLSchema-instance\"", "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"");
                        xml = xml.Replace("p1:schemaLocation", "xsi:schemaLocation");
                        return xml;
                    }
                }
            }
            catch (Exception ee)
            {

                Logger.Error(ee);
                return null;
            }

        }

        public string GetXmlDonat(Donatarias donat)
        {
            XmlSerializer ser = new XmlSerializer(typeof(Donatarias));
            try
            {
                using (MemoryStream memStream = new MemoryStream())
                {
                    var sw = new StreamWriter(memStream, Encoding.UTF8);
                    using (
                        XmlWriter xmlWriter = XmlWriter.Create(sw,
                                                               new XmlWriterSettings() { Indent = false, Encoding = Encoding.UTF8 }))
                    {
                        XmlSerializerNamespaces namespaces = new XmlSerializerNamespaces();
                        namespaces.Add("donat", "http://www.sat.gob.mx/donat");
                        ser.Serialize(xmlWriter, donat, namespaces);
                        string xml = Encoding.UTF8.GetString(memStream.GetBuffer());
                        xml = xml.Substring(xml.IndexOf(Convert.ToChar(60)));
                        xml = xml.Substring(0, (xml.LastIndexOf(Convert.ToChar(62)) + 1));
                        //xml = xml.Replace("xmlns:donat=\"http://www.sat.gob.mx/donat\"", "");
                        return xml;
                    }
                }
            }
            catch (Exception ee)
            {

                Logger.Error(ee);
                return null;
            }

        }

        public void TimbrarComprobanteNtLink(Comprobante comp)
        {
            bool addendaRepetida = false;
            List<XElement> elAddenda = new List<XElement>();
            // ClienteTimbradoNtlink cliente = new ClienteTimbradoNtlink();
            CertificadorAppsClient internalCertificadorAppsClient =  new CertificadorAppsClient();
            try
            {
                //string complemento = null;
                Logger.Debug("Timbrando comprobante");

                XmlSerializer ser = new XmlSerializer(typeof(TimbreFiscalDigital));

                //var str = GetXml(comp, complemento);
                ServicePointManager.DefaultConnectionLimit = 200;
                ServicePointManager.ServerCertificateValidationCallback = (sender, certificate, chain, errors) =>
                {
                    return true;
                };

                // Old way to certificate using the self contained methos
                //string timbreString = cliente.TimbraCfdi(comp.XmlString);
                
                // Now we must use the service provided method to certificate
                // Get the authentication data from config
                string configUserName = ConfigurationManager.AppSettings["InternalClientUserName"];
                string configPassword = ConfigurationManager.AppSettings["InternalClientPassword"];
               
               string timbreString = internalCertificadorAppsClient.TimbraCfdi(configUserName, configPassword, comp.XmlString);
              // string timbreString = "timbreStringRGV";//quitar esto

               // Thread.Sleep(36000);
               // string timbreString ="<?xml version=\"1.0\" encoding=\"utf-8\"?><tfd:TimbreFiscalDigital xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"http://www.sat.gob.mx/TimbreFiscalDigital http://www.sat.gob.mx/sitio_internet/cfd/TimbreFiscalDigital/TimbreFiscalDigitalv11.xsd\" Version=\"1.1\" UUID=\"0106BC5B-9E5E-4FA2-B059-50B3DDE2BF74\" FechaTimbrado=\"2020-12-07T21:39:51\" RfcProvCertif=\"DAL050601L35\" SelloCFD=\"YJS2FiWppUsOvSmzSO2gYcR+4CuBCJSSACpWI9oZQUcDjKBjPNlysfpOh4QA1kEP0krYTjAUh/JsTz0v/IXoUIDcjwpoOT2xF17nAO9WLoQdF6rNpf0gYpMXbK8rJbxgrKa51RY2XGDkfsewu44yp3O1G+P6ZbbhfAbLjrdnSOIchzk+NX9RhKBmb25Searv9CNjAKz1rNfY4vxg7/a0NVoqWf8IE3zz4Pb262NRXYQSeHKTAJaPBRqmqNqwTJB/Rk4a9CDb5xgCxrZpOUiVMnr8pe/sx98wXU44yxqq074NOtjoIpvsVlbFJba551D9mLIlWsdH+goYmQXg+uKMJQ==\" NoCertificadoSAT=\"20001000000300022323\" SelloSAT=\"oweyYuPC2zxusF9vIqmdVjXrJP8t0sqbfHWeoSCzduPypELgChXE/bCOjoXU3dt2x8Vg+2Ulo7udhSSLbkS9NFpRtxyBhiNqBryLczVg9cML3EHLxkyxkpmEnng5PgVn4KAFOq9Zj2e9so4VU92+bOa1QtRG9KTQ7MFlVCPjypPXuXMpPCiqsrv5tS31tTfNpyTgkBsQaKfuK7I/tTim5ir3OJlnuuvq0JGw1bcksggylwIl7DnRFL+m9Vn4wMwNhvTqRkhcoCyrmXQIp2WH4PSlvBhE9rKiC25DLEEMrfPoMUQjjDrfc3GxojT7GTfxrnXe0CaHsSXgVUCs4y7j4Q==\" xmlns:tfd=\"http://www.sat.gob.mx/TimbreFiscalDigital\" />";

                
                Logger.Debug(timbreString);
                TimbreFiscalDigital timbre = null;
                try
                {
                   timbre = (TimbreFiscalDigital)ser.Deserialize(new XmlTextReader(new StringReader(timbreString)));
               //    timbre= new TimbreFiscalDigital();//quitar esto
              //     timbre.UUID = "ESTOESELUUID";     //quitar esto
                }
                catch (Exception ee)
                {
                    Logger.Error(ee);
                    throw new FaultException(timbreString);
                }
                if (timbreString == null)
                {
                    throw new Exception("Ocurrió un error en el timbrado");
                }
                GeneradorCadenasTimbre generadorCadenasTimbre = new GeneradorCadenasTimbre();
                comp.CadenaOriginalTimbre = generadorCadenasTimbre.CadenaOriginal(timbreString);
                timbre.cadenaOriginal = comp.CadenaOriginalTimbre;
             //   comp.CadenaOriginalTimbre = "CadenaOriginalTimbre";  //quitar esto
                string addendaXml = null;

                //---------------------------------
                if (comp.TipoAddenda == TipoAddenda.ASONIOSCOC)
                {
                    //comp.xsiSchemaLocation = comp.xsiSchemaLocation + " http://www.honda.net.mx/GPC";
                    ASONIOSCOC addendaPemex = comp.AddendaASONIOSCOC;
                    addendaXml = GetXmlAddenda(addendaPemex, typeof(ASONIOSCOC), "cfdi", "http://www.ntlink.com.mx/RGV");

                }
                if (comp.TipoAddenda == TipoAddenda.Addenda1888)
                {
                    NUMEROPEDIMENTO addenda1888 = comp.Addenda1888;
                    addendaXml = GetXmlAddenda(addenda1888, typeof(NUMEROPEDIMENTO), "", "");
                    addendaXml = addendaXml.Replace("<NUMEROPEDIMENTO xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">", "<NUMEROPEDIMENTO>");
                    addendaXml = addendaXml.Replace("<GENERAL_x0020_NUMPED>" + comp.Addenda1888.GENERAL_NUMPED + "</GENERAL_x0020_NUMPED>", "<GENERAL NUMPED=\"" + comp.Addenda1888.GENERAL_NUMPED + "\"/>");
                   

                }
                //rgv agrego la adenda honda
                //---------------------------------
                if (comp.TipoAddenda == TipoAddenda.Honda)
                {
                    //    addendaXml = GetXmlAddendaDeloitte(addenda);
                    comp.xsiSchemaLocation = comp.xsiSchemaLocation + " http://www.honda.net.mx/GPC";
                    Honda addendaPemex = comp.AddendaHonda;
                    addendaXml = GetXmlAddenda(addendaPemex, typeof(Honda), "GPC", "http://www.honda.net.mx/GPC");

                }
                //--------------------------------------------
                if (comp.TipoAddenda == TipoAddenda.Amazon)
                {
                    // addendaXml = GetXmlAddendaDeloitte(addenda);
                    comp.xsiSchemaLocation = comp.xsiSchemaLocation + " http://www.amazon.com.mx/AmazonAddenda";
                    ElementosAmazon addendaAmazon = comp.AddendaAmazon;
                    addendaXml = GetXmlAddenda(addendaAmazon, typeof(ElementosAmazon), "amazon", "http://www.amazon.com.mx/AmazonAddenda");
                  }

                //-----------------------------------------------------
                

                //----------------------------------------------
                if (comp.TipoAddenda == TipoAddenda.Deloitte)
                {
                    comp.xsiSchemaLocation = comp.xsiSchemaLocation +
                                             " http://www.deloitte.com/CFD/Addenda/Receptor http://www.pegasotecnologia.com/secfd/schemas/receptor/Deloitte_recepcion.xsd";
                    AddendaDeloitte addenda = new AddendaDeloitte()
                    {
                        mailContactoDeloitte = comp.correocontacto,
                        mailProveedor = comp.correoproveedor,
                        moneda = comp.Tipomoneda,
                        noPedido = comp.nopedido,
                        nombreContactoProveedor = comp.nombreproveedor,
                        numeroProveedor = comp.noproveedor,
                        oficina = comp.oficina,
                        origenFactura = comp.origendefactura

                    };
                    addendaXml = GetXmlAddendaDeloitte(addenda);
                }
   
               else if (comp.TipoAddenda == TipoAddenda.SorianaCedis)
                {
                    comp.xsiSchemaLocation = comp.xsiSchemaLocation +
                                             " http://www.buzonfiscal.com/ns/addenda/bf/2 http://www.buzonfiscal.com/schema/xsd/Addenda_BF_v20.xsd";
                    // Codigo para addenda Soriana Entrega a CEDIS
                    AddendaBuzonFiscalType addenda = new AddendaBuzonFiscalType
                    {
                        Emisor = new EmisorType() { telefono = comp.Telefono },
                        Receptor =
                            new ReceptorType { noProveedor = comp.noproveedor, GLN = comp.Gln },
                        TipoDocumento =
                            new TipoDocumentoType()
                            {
                                descripcion = DescripcionType.Factura,
                                nombreCorto = NombreCortoType.FAC
                            },
                        CFD = new CFDType()
                        {
                            tipoMoneda = comp.MonedatipoMoneda,
                            tipoCambio = Convert.ToDecimal((comp.TipoCambio)),
                            tipoCambioSpecified = true,
                            observaciones = comp.Proyecto,
                            totalConLetra = comp.CantidadLetra

                        },
                        Extra = new ExtraType[]
                                                                         {
                                                                             new ExtraType()
                                                                                 {
                                                                                     valor = comp.Total.ToString(),
                                                                                     atributo = comp.ExtraAtributo
                                                                                 },
                                                                             new ExtraType()
                                                                                 {
                                                                                     valor = comp.Valor1,
                                                                                     atributo = comp.ExtraAtributo1
                                                                                 }
                                                                         }

                    };
                    addendaXml = GetXmlAddenda(addenda, typeof(AddendaBuzonFiscalType), "bfa2", "http://www.buzonfiscal.com/ns/addenda/bf/2");
                }

               //Addenda ADO
                else if (comp.TipoAddenda == TipoAddenda.ADO)
                {

                    Addenda addenda = new Addenda
                    {
                        proveedor = new AddendaProveedor { tipoAddenda = comp.Proveedor },
                        addenda = new AddendaAddenda { valor = comp.Valor }
                    };
                    addendaRepetida = true;
                    addendaXml = GetXmlAddenda(addenda, typeof(Addenda), "cfdi", "http://recepcioncfd.ekomercio.com/ADO");
                }

                    ///termina ADO
                else if (comp.TipoAddenda == TipoAddenda.SorianaTienda)
                {
                    comp.xsiSchemaLocation = comp.xsiSchemaLocation +
                                             " http://www.visual-tech.mx/Apps/v-Fact/Addendas/Emisor___Proalimex/Receptor___Soriana http://www.visual-tech.mx/Apps/v-Fact/Addendas/Emisor___Proalimex/Receptor___Soriana/Addenda_Soriana.xsd";
                    DSCargaRemisionProvRemision addendaRemision = new DSCargaRemisionProvRemision
                    {
                        RowOrder = "0",
                        Id = "Remision0",
                        Proveedor = Convert.ToInt32(comp.ProveedorRemision),
                        Remision = comp.RemisionR,
                        Consecutivo = short.Parse(comp.Consecutivo),
                        FechaRemision = Convert.ToDateTime(comp.FechaRemision),
                        Tienda = short.Parse(comp.TiendaRemision),
                        TipoMoneda = short.Parse(comp.MonedatipoMoneda),
                        TipoBulto = short.Parse(comp.TipoBulto),
                        EntregaMercancia = short.Parse(comp.EntrgaMercancia),
                        CumpleReqFiscales = Convert.ToBoolean((comp.CumpleReqFiscal)),
                        CantidadBultos = short.Parse(comp.CantidadBultos),
                        Subtotal = comp.SubTotal,
                        IEPS = comp.IEPS,
                        IVA = comp.IVA,
                        OtrosImpuestos = Convert.ToDecimal(comp.OtrosImpuestos),
                        Total = comp.Total,
                        CantidadPedidos = Convert.ToInt32(comp.CantidadPedidos),
                        FechaEntregaMercancia = Convert.ToDateTime(comp.FechaEntrgaMercancia),
                        FolioNotaEntrada = comp.FolioNotaEntrada,
                        FolioNotaEntradaSpecified = true //para mostrar folio nota de entrada se agrgo este 
                    };

                    DSCargaRemisionProvPedidos addendaPedido = new DSCargaRemisionProvPedidos
                    {
                        RowOrder = "0",
                        Id = "Pedidos0",

                        Proveedor = Convert.ToInt32(comp.ProveedorRemision),
                        Remision = comp.RemisionR,
                        FolioPedido = comp.FolioNotaEntrada,
                        Tienda = short.Parse(comp.TiendaRemision),
                        CantidadArticulos = Convert.ToInt32(comp.CantidadArticulos)
                    };

                    List<DSCargaRemisionProvArticulos> addendaArticulo = new List<DSCargaRemisionProvArticulos>();

                    int h = 0;
                    foreach (var articulo in comp.Conceptos)
                    {

                        addendaArticulo.Add(new DSCargaRemisionProvArticulos
                                                {


                                                    RowOrder = Convert.ToString(h.ToString()),
                                                    Id = "Aritculos" + Convert.ToString(h.ToString()),
                                                    Remision = comp.RemisionR,
                                                    Proveedor = Convert.ToInt32(comp.ProveedorRemision),
                                                    FolioPedido = comp.FolioNotaEntrada,//Convert.ToInt32(articulo.folioPedido), 
                                                    Tienda = short.Parse(comp.TiendaRemision),
                                                    Codigo = Decimal.Parse(articulo.NoIdentificacion),
                                                    CantidadUnidadCompra = articulo.Cantidad,
                                                    CostoNetoUnidadCompra =Convert.ToDecimal( articulo.ValorUnitario),
                                                    PorcentajeIEPS = comp.PorcentajeIEPS,
                                                    PorcentajeIVA = comp.PorecentajeIVA
                                                });
                        h++;
                    }

                    DSCargaRemisionProv addenda = new DSCargaRemisionProv();


                    int index = addendaArticulo.Count + 2;
                    addenda.Items = new object[index];
                    for (int i = 0; i < index; i++)
                    {
                        if (i == 0)
                        {
                            addenda.Items[i] = addendaRemision;
                        }
                        else if (i == 1)
                        {
                            addenda.Items[i] = addendaPedido;
                        }
                        else
                        {
                            addenda.Items[i] = addendaArticulo[i - 2];
                        }
                    }

                    addendaXml = GetXmlAddenda(addenda, typeof(DSCargaRemisionProv), "", "http://www.visual-tech.mx/Apps/v-Fact/Addendas/Emisor___Proalimex/Receptor___Soriana");
                }
                // Addenda PEMEX -- SZ
                else if (comp.TipoAddenda == TipoAddenda.Pemex)
                {
                    comp.xsiSchemaLocation = comp.xsiSchemaLocation + " http://pemex.com/facturaelectronica/addenda/v2 https://pemex.reachcore.com/schemas/addenda-pemex-v2.xsd";
                    AddendaPemex addendaPemex = comp.AddendaPemex;
                    addendaXml = GetXmlAddenda(addendaPemex, typeof(AddendaPemex), "pm", "http://pemex.com/facturaelectronica/addenda/v2");
                }
                else if (comp.TipoAddenda == TipoAddenda.Lucent)
                {

                    foreach (var c in comp.Conceptos)
                    {
                        XElement el = new XElement(_ns + "ItemsFacturados");
                        el.Add(new XAttribute("OrdenCompra", comp.LucentOrdenCompra));

                        el.Add(new XAttribute("Item", c.Detalles));
                        el.Add(new XAttribute("FactRef", comp.LucentRef));

                        elAddenda.Add(el);
                    }
                    comp.DonatLeyenda = comp.LucentOrdenCompra;

                }
                else if (comp.TipoAddenda == TipoAddenda.Pilgrims)
                {
                    addendaXml = GetXmlAddenda(comp.AddendaPilgrims, typeof(Pilgrims), null, null);
                    addendaXml = addendaXml.Replace(
                        " xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"",
                        "");
                }

                if (comp.AddendaAmece != null)
                {

                    requestForPayment addendaAmece = comp.AddendaAmece;
                    addendaXml = GetXmlAddenda(addendaAmece, typeof(requestForPayment), null, null);
                }
                if (comp.AddendaInnova != null)
                {

                    AddendaOrderIdentification addendaInnova = comp.AddendaInnova;
                    addendaXml = GetXmlAddenda(addendaInnova, typeof(AddendaOrderIdentification), null, null);
                    addendaXml = addendaXml.Replace("<AddendaOrderIdentification xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\">", "<orderIdentification>");
                    addendaXml = addendaXml.Replace("<AddendaOrderIdentification xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">", "<orderIdentification>");
                    addendaXml = addendaXml.Replace("</AddendaOrderIdentification>", "</orderIdentification>");
                  //  addendaXml = addendaXml.Replace("<cfdi:Addenda>", "<cfdi:Addenda xmlns:xsi=\"http://www.eternec.com/secfd/Schemas/Receptor/Innovasport http://www.eternec.com/secfd/Schemas/Receptor/AddendaInnova.xsd\" xmlns:cfdi=\"http://www.sat.gob.mx/cfd/3\">");
                   
                }
                if (comp.addendaConcepto != null)
                {
                    addendaXml = GetXmlAddenda(comp.addendaConcepto, typeof(AddendaConcepto.Conceptos), null, null);
                   addendaXml = addendaXml.Replace("xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"","");
                   addendaXml = addendaXml.Replace("xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"","");
                }
                if (comp.AddendaHomeDepot != null)
                {

                    HomeDepotRequestForPayment addenda = comp.AddendaHomeDepot;
                    addendaXml = GetXmlAddenda(addenda, typeof(HomeDepotRequestForPayment), null, null);
                }
                if (comp.AddendaCoppelObj != null)
                {
                    comp.AddendaCoppelObj.requestForPayment.cadenaOriginal = new AddendaRequestForPaymentCadenaOriginal()
                                                                                 {
                                                                                     Cadena = comp.CadenaOriginal
                                                                                 };
                    addendaXml = GetXmlAddenda(comp.AddendaCoppelObj.requestForPayment,
                                               typeof (AddendaRequestForPayment), null, null);
                }

                string cfdiString = comp.XmlString;
                StringReader sr = new StringReader(cfdiString);
                XElement element = XElement.Load(sr);
                
               //----quitar para tibre
                
                string xmlFinal = ConcatenaTimbre(element, timbreString, null, addendaXml, addendaRepetida, elAddenda);
               
                comp.Complemento = new ComprobanteComplemento() { timbreFiscalDigital = timbre };

                if (comp.TipoAddenda == TipoAddenda.Amazon)//para quitar p1 por xsd
                {
                    xmlFinal = xmlFinal.Replace("p1:schemaLocation", "xsi:schemaLocation");
                    xmlFinal = xmlFinal.Replace("xmlns:p1=\"http://www.w3.org/2001/XMLSchema-instance\"", "");
         
                }
                if (comp.TipoAddenda == TipoAddenda.ASONIOSCOC)//para quitar p1 por xsd
                {
                    xmlFinal = xmlFinal.Replace("xmlns:cfdi=\"http://www.ntlink.com.mx/RGV\"", "");
               
                }
                if (comp.AddendaInnova != null)
                {

                    xmlFinal = xmlFinal.Replace("<cfdi:Addenda>", "<cfdi:Addenda xmlns:xsi=\"http://www.eternec.com/secfd/Schemas/Receptor/Innovasport http://www.eternec.com/secfd/Schemas/Receptor/AddendaInnova.xsd\" xmlns:cfdi=\"http://www.sat.gob.mx/cfd/3\">");


                }
            
                comp.XmlString = xmlFinal;
                  
            }
            catch (FaultException fe)
            {
                Logger.Info(fe);
                throw;
            }
            catch (SoapException exception)
            {
                Logger.Error(exception.Detail.InnerText.Trim());
                throw new ApplicationException("Error al timbrar el comprobante:" + exception.Detail.InnerText.Trim(), exception);
            }
            catch (Exception exception)
            {
                Logger.Error((exception.InnerException == null ? exception.Message : exception.InnerException.Message));
                throw new Exception("Error al timbrar el comprobante", exception);
            }
        }


        public void TimbrarRetPreview(Retenciones.Retenciones ret)
        {
            try
            {
                XmlSerializer ser = new XmlSerializer(typeof(TimbreFiscalDigital));
                TimbreFiscalDigital timbre = null;
                try
                {
                    timbre = new TimbreFiscalDigital()
                    {
                        UUID = "No Timbrado",
                        FechaTimbrado = DateTime.Now,
                        NoCertificadoSAT = "000",
                        SelloCFD = ret.Sello,
                        SelloSAT = "Inválido",
                        Version = "1.1"
                    };

                }
                catch (Exception ee)
                {
                    Logger.Error(ee);
                }
                GeneradorCadenasTimbre generadorCadenasTimbre = new GeneradorCadenasTimbre();
                ret.CadenaOriginalTimbre = "Inválido";
                string cfdiString = GetXmlRetenciones(ret);
                StringReader sr = new StringReader(cfdiString);
                var sw = new StringWriter();
                XElement element = XElement.Load(sr);

                XmlWriterSettings settings = new XmlWriterSettings();
                settings.Encoding = new UnicodeEncoding(false, false); // no BOM in a .NET string
                settings.Indent = false;
                settings.OmitXmlDeclaration = false;
                XmlWriter xmlWriter = XmlWriter.Create(sw, settings);
                ser.Serialize(xmlWriter, timbre);
                string xmlFinal = ConcatenaTimbre(element, sw.ToString(), null, null, false);

                ret.Complemento = new RetencionesComplemento() { timbreFiscalDigital = timbre };
              

                ret.XmlString = xmlFinal;

            }
            catch (FaultException fe)
            {
                throw;
            }
            catch (SoapException exception)
            {
                Logger.Error(exception.Detail.InnerText.Trim());
                throw new ApplicationException("Error al timbrar el comprobante:" + exception.Detail.InnerText.Trim(), exception);
            }
            catch (Exception exception)
            {
                Logger.Error((exception.InnerException == null ? exception.Message : exception.InnerException.Message));
                throw new Exception("Error al timbrar el comprobante", exception);
            }


        }



        public void TimbrarComprobantePreview(Comprobante comp)
        {
            //ClienteTimbradoNtlink cliente = new ClienteTimbradoNtlink();
            try
            {
                XmlSerializer ser = new XmlSerializer(typeof(TimbreFiscalDigital));
                TimbreFiscalDigital timbre = null;
                try
                {
                    timbre = new TimbreFiscalDigital()
                    {
                        UUID = "No Timbrado",
                        FechaTimbrado = DateTime.Now,
                        NoCertificadoSAT = "000",
                        SelloCFD = comp.Sello,
                        SelloSAT = "Inválido",
                        Version = "1.0"
                    };

                }
                catch (Exception ee)
                {
                    Logger.Error(ee);
                }
                GeneradorCadenasTimbre generadorCadenasTimbre = new GeneradorCadenasTimbre();
                comp.CadenaOriginalTimbre = "Inválido";

                string complementoIL = null;
                //para los impuestos locales
                if (comp.Complemento != null && comp.Complemento.implocal != null)
                {
                    complementoIL = GetXmlImpuestosLocales(comp.Complemento.implocal);
                }
                if (comp.Complemento != null && comp.Complemento.VehiculoUsado != null)
                {
                    complementoIL=GetXmlVehiculoUsado(comp.Complemento.VehiculoUsado);
                 
                }
                //para los pagos
                if (comp.Complemento != null && comp.Complemento.Pag != null)
                {
                    complementoIL = GetXmlPagos(comp.Complemento.Pag);
                }
                if(comp.Complemento!=null && comp.Complemento.ine!=null)
                    complementoIL = GetXmlINE(comp.Complemento.ine);
                
                string cfdiString = GetXml(comp, complementoIL);

                //string cfdiString = GetXml(comp,null);
                StringReader sr = new StringReader(cfdiString);
                var sw = new StringWriter();
                XElement element = XElement.Load(sr);

                XmlWriterSettings settings = new XmlWriterSettings();
                settings.Encoding = new UnicodeEncoding(false, false); // no BOM in a .NET string
                settings.Indent = false;
                settings.OmitXmlDeclaration = false;
                XmlWriter xmlWriter = XmlWriter.Create(sw, settings);
                ser.Serialize(xmlWriter, timbre);
                string xmlFinal = ConcatenaTimbre(element, sw.ToString(), null, null, false);

                comp.Complemento = new ComprobanteComplemento() { timbreFiscalDigital = timbre };
                if (comp.Nomina != null)
                {
                    var complemento = GetXmlAddenda(comp.Nomina, typeof(Nomina), "nomina", "http://www.sat.gob.mx/nomina");
                    comp.XmlNomina = complemento;
                }

                comp.XmlString = xmlFinal;

            }
            catch (FaultException fe)
            {
                throw;
            }
            catch (SoapException exception)
            {
                Logger.Error(exception.Detail.InnerText.Trim());
                throw new ApplicationException("Error al timbrar el comprobante:" + exception.Detail.InnerText.Trim(), exception);
            }
            catch (Exception exception)
            {
                Logger.Error((exception.InnerException == null ? exception.Message : exception.InnerException.Message));
                throw new Exception("Error al timbrar el comprobante", exception);
            }


        }



        public void GenerarCfdRetPreview(Retenciones.Retenciones comprobante, X509Certificate2 cert, string rutaLlave, string passLlave)
        {
            try
            {
                comprobante.Cert = Convert.ToBase64String(cert.RawData);
                comprobante.NumCert = NoCert(cert.SerialNumber);
                GeneradorCadenas gen = new GeneradorCadenas();
                string comp = GetXmlRetenciones(comprobante);
                comprobante.XmlString = comp;
                comprobante.CadenaOriginal = gen.CadenaOriginal(comp);
                comprobante.Sello = "Vista Previa";///Firmar(comprobante.CadenaOriginal, rutaLlave, passLlave);
                TimbrarRetPreview(comprobante);
            }
            catch (FaultException fe)
            {
                Logger.Error(fe);
                throw;
            }
            catch (Exception exception)
            {
                Logger.Error((exception.InnerException == null ? exception.Message : exception.InnerException.Message));
                throw;
            }
        }


        public void GenerarCfdPreview(Comprobante comprobante, X509Certificate2 cert, string rutaLlave, string passLlave)
        {
            try
            {
                //string complemento = null;
                comprobante.Certificado = Convert.ToBase64String(cert.RawData);
                comprobante.NoCertificado = NoCert(cert.SerialNumber);
                GeneradorCadenas gen = new GeneradorCadenas();  //agregar otra vez

                //string complementoPago = null;
                ////para los impuestos locales
                //if (comprobante.Complemento != null && comprobante.Complemento.Pag != null)
                //{
                //    complementoPago = GetXmlPagos(comprobante.Complemento.Pag);
                //}


                string comp = GetXml(comprobante, null);
                comprobante.XmlString = comp;
                comprobante.CadenaOriginal = gen.CadenaOriginal(comp);
                comprobante.Sello = "Vista Previa";///Firmar(comprobante.CadenaOriginal, rutaLlave, passLlave);
                TimbrarComprobantePreview(comprobante);
            }
            catch (FaultException fe)
            {
                Logger.Error(fe);
                throw;
            }
            catch (Exception exception)
            {
                Logger.Error((exception.InnerException == null ? exception.Message : exception.InnerException.Message));
                throw;
            }
        }


        public void GenerarCfd(Comprobante comprobante, X509Certificate2 cert, string rutaLlave, string passLlave)
        {
            try
            {
                Logger.Debug("Generando xml");
                comprobante.Certificado = Convert.ToBase64String(cert.RawData);
                comprobante.NoCertificado = NoCert(cert.SerialNumber);
                string complemento = null;
                GeneradorCadenas gen = new GeneradorCadenas();

                if (comprobante.Nomina != null)
                {
                    comprobante.xsiSchemaLocation = comprobante.xsiSchemaLocation + " http://www.sat.gob.mx/nomina http://www.sat.gob.mx/sitio_internet/cfd/nomina/nomina11.xsd";
                    complemento = GetXmlAddenda(comprobante.Nomina, typeof(Nomina), "nomina", "http://www.sat.gob.mx/nomina");
                    comprobante.XmlNomina = complemento;
                }
                if (comprobante.Detallista != null)
                {
                    comprobante.xsiSchemaLocation = comprobante.xsiSchemaLocation + " http://www.sat.gob.mx/detallista http://www.sat.gob.mx/sitio_internet/cfd/detallista/detallista.xsd";
                    complemento = GetXmlAddenda(comprobante.Detallista, typeof(detallista), "detallista", "http://www.sat.gob.mx/detallista");
                    //comprobante.XmlNomina = complemento;
                    
                }
                if (comprobante.Complemento != null && comprobante.Complemento.cartaPorte != null)
                {
                    comprobante.xsiSchemaLocation = comprobante.xsiSchemaLocation + " http://www.sat.gob.mx/CartaPorte http://www.sat.gob.mx/sitio_internet/cfd/CartaPorte/CartaPorte.xsd";
                    complemento = GetXmlCartaPorte(comprobante.Complemento.cartaPorte);
                    
                }
                

                if (comprobante.Complemento != null && comprobante.Complemento.Pag != null)
                {
                    comprobante.xsiSchemaLocation = comprobante.xsiSchemaLocation + " http://www.sat.gob.mx/Pagos http://www.sat.gob.mx/sitio_internet/cfd/Pagos/Pagos10.xsd";
                    complemento = GetXmlPagos(comprobante.Complemento.Pag);//GetXmlAddenda(comprobante.Complemento.Pag, typeof(GAFContract.Complemento.Pagos), "pago10", " http://www.sat.gob.mx/Pagos");
                
        
                
                }
                if (comprobante.Complemento != null && comprobante.Complemento.ine != null)
                {
                    
                    comprobante.xsiSchemaLocation = comprobante.xsiSchemaLocation + " http://www.sat.gob.mx/ine http://www.sat.gob.mx/sitio_internet/cfd/ine/ine11.xsd";
                    //complemento = GetXmlAddenda(comprobante.Complemento.ine, typeof(INE), "ine", " http://www.sat.gob.mx/ine");
                    complemento = GetXmlINE(comprobante.Complemento.ine);
                    
                }
                if (comprobante.Complemento != null && comprobante.Complemento.VehiculoUsado != null)
                {

                    comprobante.xsiSchemaLocation = comprobante.xsiSchemaLocation + " http://www.sat.gob.mx/vehiculousado http://www.sat.gob.mx/sitio_internet/cfd/vehiculousado/vehiculousado.xsd";
                    complemento = GetXmlVEHICULOUSADO(comprobante.Complemento.VehiculoUsado);

                }
                /*

                if (comprobante.Conceptos != null && comprobante.Conceptos[0].ComplementoConcepto != null && comprobante.Conceptos[0].ComplementoConcepto.iedu!=null)

                {
                    comprobante.xsiSchemaLocation = comprobante.xsiSchemaLocation + " http://www.sat.gob.mx/donat http://www.sat.gob.mx/sitio_internet/cfd/donat/donat11.xsd";
                    complemento = GetXmlDonat(comprobante.Complemento.Donat);
                }
                 */ 
                if (comprobante.Complemento != null && comprobante.Complemento.Donat != null)
                {
                    comprobante.xsiSchemaLocation = comprobante.xsiSchemaLocation + " http://www.sat.gob.mx/donat http://www.sat.gob.mx/sitio_internet/cfd/donat/donat11.xsd";
                    complemento = GetXmlDonat(comprobante.Complemento.Donat);
                }
                if (comprobante.Complemento != null && comprobante.Complemento.implocal != null)
                {

                    //comprobante.xsiSchemaLocation = comprobante.xsiSchemaLocation + " http://www.sat.gob.mx/implocal http://www.sat.gob.mx/sitio_internet/cfd/implocal/implocal.xsd";
                    //complemento = GetXmlAddenda(comprobante.Complemento.implocal, typeof(ImpuestosLocales), "implocal", " http://www.sat.gob.mx/implocal");
                    
                    complemento = GetXmlImpuestosLocales(comprobante.Complemento.implocal);
                }
                if (comprobante.Complemento != null && comprobante.Complemento.parcialesconstruccion != null)
                {
                    comprobante.xsiSchemaLocation = comprobante.xsiSchemaLocation + " http://www.sat.gob.mx/servicioparcialconstruccion http://www.sat.gob.mx/sitio_internet/cfd/servicioparcialconstruccion/servicioparcialconstruccion.xsd";
       
                    complemento = GetXmlServicioParcialConstruccion(comprobante.Complemento.parcialesconstruccion);
                }
                string comp = GetXml(comprobante, complemento);
                if (comprobante.Conceptos != null && comprobante.Conceptos[0].ComplementoConcepto != null && comprobante.Conceptos[0].ComplementoConcepto.iedu != null)
                {
                    comp = comp.Replace("<instEducativas xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"", "<iedu:instEducativas");
                    comp = comp.Replace("xmlns=\"http://www.sat.gob.mx/iedu\"","");
                    //por si no jala...
                    comp = comp.Replace("<instEducativas xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"", "<iedu:instEducativas");

                    comp = comp.Replace("xmlns:cfdi=\"http://www.sat.gob.mx/cfd/3\"","xmlns:cfdi=\"http://www.sat.gob.mx/cfd/3\" xmlns:iedu=\"http://www.sat.gob.mx/iedu\"");
                    comp = comp.Replace("http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv33.xsd", "http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv33.xsd http://www.sat.gob.mx/iedu http://www.sat.gob.mx/sitio_internet/cfd/iedu/iedu.xsd");
                }
                if (comprobante.Complemento != null && comprobante.Complemento.VehiculoUsado != null)
                {
                    comp = comp.Replace("<vehiculousado:VehiculoUsado xmlns:vehiculousado=\"http://www.sat.gob.mx/vehiculousado\"", "<vehiculousado:VehiculoUsado");
                    comp = comp.Replace("xmlns:cfdi=\"http://www.sat.gob.mx/cfd/3\"", "xmlns:cfdi=\"http://www.sat.gob.mx/cfd/3\" xmlns:vehiculousado=\"http://www.sat.gob.mx/vehiculousado\"");
                }
                if (comprobante.Complemento != null && comprobante.Complemento.cartaPorte != null)
                {
                    comp = comp.Replace("xmlns:cartaporte=\"http://www.sat.gob.mx/CartaPorte\"", "");
                    comp = comp.Replace("xmlns:cfdi=\"http://www.sat.gob.mx/cfd/3\"", "xmlns:cfdi=\"http://www.sat.gob.mx/cfd/3\" xmlns:cartaporte=\"http://www.sat.gob.mx/CartaPorte\"");
                }
                if (comprobante.Complemento != null && comprobante.Complemento.Pag != null)
                {
                    comp = comp.Replace("<pago10:Pagos Version=\"1.0\" xmlns:pago10=\"http://www.sat.gob.mx/Pagos\">", "<pago10:Pagos Version=\"1.0\">");
                    comp = comp.Replace("xmlns:cfdi=\"http://www.sat.gob.mx/cfd/3\"", "xmlns:cfdi=\"http://www.sat.gob.mx/cfd/3\" xmlns:pago10=\"http://www.sat.gob.mx/Pagos\"");
                }
                if (comprobante.Complemento != null && comprobante.Complemento.Donat != null)
                {
                    comp = comp.Replace("xmlns:donat=\"http://www.sat.gob.mx/donat\"", "");
                    comp = comp.Replace("xmlns:cfdi=\"http://www.sat.gob.mx/cfd/3\"", "xmlns:cfdi=\"http://www.sat.gob.mx/cfd/3\" xmlns:donat=\"http://www.sat.gob.mx/donat\"");
                }
                if (comprobante.Complemento != null && comprobante.Complemento.parcialesconstruccion != null)
                { 
                  comp = comp.Replace("<servicioparcial:parcialesconstruccion xsi:schemaLocation=\"http://www.sat.gob.mx/servicioparcialconstruccion http://www.sat.gob.mx/sitio_internet/cfd/servicioparcialconstruccion/servicioparcialconstruccion.xsd\"","<servicioparcial:parcialesconstruccion ");
                  comp = comp.Replace(" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:servicioparcial=\"http://www.sat.gob.mx/servicioparcialconstruccion\">", ">");
                  comp = comp.Replace("xmlns:cfdi=\"http://www.sat.gob.mx/cfd/3\"", "xmlns:cfdi=\"http://www.sat.gob.mx/cfd/3\" xmlns:servicioparcial=\"http://www.sat.gob.mx/servicioparcialconstruccion\"");
                }

                comprobante.CadenaOriginal = gen.CadenaOriginal(comp);
                comprobante.Sello = Firmar(comprobante.CadenaOriginal, rutaLlave, passLlave);
                XElement xeComprobante = XElement.Parse(comp);
                xeComprobante.Add(new XAttribute("Sello", comprobante.Sello));
                SidetecStringWriter sw = new SidetecStringWriter(Encoding.UTF8);
                xeComprobante.Save(sw,SaveOptions.DisableFormatting);
                comprobante.XmlString = sw.ToString();
                if (ConfigurationManager.AppSettings["Pac"] == "NtLink")
                {
                    TimbrarComprobanteNtLink(comprobante);
                }
                else throw new Exception("No hay un pac configurado");
            }
            catch (FaultException fe)
            {
                Logger.Error(fe);
                throw;
            }
            catch (Exception exception)
            {
                Logger.Error((exception.InnerException == null ? exception.Message : exception.InnerException.Message));
                throw;
            }
        }

        private string NoCert(string cert)
        {
            int count = 0;
            StringBuilder sb = new StringBuilder();
            foreach (char c in cert)
            {
                if (count % 2 != 0)
                    sb.Append(c);
                count++;
            }
            return sb.ToString();
        }
        //-------------------------------------------------------------
        /*public string GetXmlRetenciones(Intereses inte)
        {
            XmlSerializer ser = new XmlSerializer(typeof(Intereses));
            try
            {
                using (MemoryStream memStream = new MemoryStream())
                {
                    var sw = new StreamWriter(memStream, Encoding.UTF8);
                    using (
                        XmlWriter xmlWriter = XmlWriter.Create(sw,
                                                               new XmlWriterSettings() { Indent = false, Encoding = Encoding.UTF8 }))
                    {
                        XmlSerializerNamespaces namespaces = new XmlSerializerNamespaces();
                        namespaces.Add("intereses", "http://www.sat.gob.mx/esquemas/retencionpago/1/intereses http://www.sat.gob.mx/esquemas/retencionpago/1/intereses/intereses.xsd");
                        ser.Serialize(xmlWriter, inte, namespaces);
                        string xml = Encoding.UTF8.GetString(memStream.GetBuffer());
                        xml = xml.Substring(xml.IndexOf(Convert.ToChar(60)));
                        xml = xml.Substring(0, (xml.LastIndexOf(Convert.ToChar(62)) + 1));
                       
                        return xml;
                    }
                }
            }
            catch (Exception ee)
            {

                Logger.Error(ee);
                return null;
            }
        }*/
        //--------------------------------------------------------------

        public void GenerarCfdRetenciones(Retenciones.Retenciones comprobante, X509Certificate2 cert, string rutaLlave, string passKey)
        {
            try
            {
                Logger.Debug("Generando xml");
                comprobante.NumCert = NoCert(cert.SerialNumber);
                comprobante.Cert = Convert.ToBase64String(cert.RawData);
                var now = DateTime.Now;
                now = now.AddTicks(-(now.Ticks % TimeSpan.TicksPerSecond));
                comprobante.FechaExp = now;
                var gen = new GeneradorCadenasRetenciones();

                string comp = GetXmlRetenciones(comprobante);

                XElement xeComprobantexx = XElement.Parse(comp);
                SidetecStringWriter swxx = new SidetecStringWriter(Encoding.UTF8);
                xeComprobantexx.Save(swxx, SaveOptions.DisableFormatting);

                comprobante.CadenaOriginal = gen.CadenaOriginal(swxx.ToString());
               
                //comprobante.CadenaOriginal = gen.CadenaOriginal(comp);
              //  comprobante.Sello = Firmar(comprobante.CadenaOriginal, rutaLlave, passKey);
                comprobante.Sello = FirmarRetencion(comprobante.CadenaOriginal, rutaLlave, passKey);
                XElement xeComprobante = XElement.Parse(comp);
                xeComprobante.Add(new XAttribute("Sello", comprobante.Sello));
                SidetecStringWriter sw = new SidetecStringWriter(Encoding.UTF8);
                xeComprobante.Save(sw,SaveOptions.DisableFormatting);
                comprobante.XmlString = sw.ToString();
                if (ConfigurationManager.AppSettings["Pac"] == "NtLink")
                {
                    TimbrarRetencionesNtLink(comprobante);
                }
                else throw new Exception("No hay un pac configurado");
            }
            catch (FaultException fe)
            {
                Logger.Error(fe);
                throw;
            }
            catch (Exception exception)
            {
                Logger.Error((exception.InnerException == null ? exception.Message : exception.InnerException.Message));
                throw;
            }
        }

        private void TimbrarRetencionesNtLink(Retenciones.Retenciones comprobante)
        {
            CertificadorAppsClient internalCertificadorAppsClient = new CertificadorAppsClient();
            try
            {
                //string complemento = null;
                Logger.Debug("Timbrando comprobante");

                XmlSerializer ser = new XmlSerializer(typeof(TimbreFiscalDigital));

                ServicePointManager.DefaultConnectionLimit = 200;
                ServicePointManager.ServerCertificateValidationCallback = (sender, certificate, chain, errors) => true;

                // Get the authentication data from config
                string configUserName = ConfigurationManager.AppSettings["InternalClientUserName"];
                string configPassword = ConfigurationManager.AppSettings["InternalClientPassword"];

                string timbreString = internalCertificadorAppsClient.TimbraRetencion(configUserName, configPassword, comprobante.XmlString);
                //string timbreString = "timbreRGV";//quitar solo es para pruebas

                Logger.Debug(timbreString);
                TimbreFiscalDigital timbre = null;
                try
                {
                    timbre = (TimbreFiscalDigital)ser.Deserialize(new XmlTextReader(new StringReader(timbreString)));
                   //   timbre= new TimbreFiscalDigital();//quitar esto es para pruebas
                    //   timbre.UUID = "ESTOESELUUID";     //quitar esto es para pruebas
                }
                catch (Exception ee)
                {
                    Logger.Error(ee);
                    throw new FaultException(timbreString);
                }
                if (timbreString == null)
                {
                    throw new Exception("Ocurrió un error en el timbrado");
                }
                GeneradorCadenasTimbreRetencion generadorCadenasTimbre = new GeneradorCadenasTimbreRetencion();
                comprobante.CadenaOriginalTimbre = generadorCadenasTimbre.CadenaOriginal(timbreString);
               // comprobante.CadenaOriginalTimbre = "cadenaOriginal"; //quitar esto eso para pruebas

                string cfdiString = comprobante.XmlString;
                StringReader sr = new StringReader(cfdiString);
                XElement element = XElement.Load(sr);

                string xmlFinal = ConcatenaTimbreRet(element, timbreString, null, null, false);
                comprobante.Complemento = new RetencionesComplemento { timbreFiscalDigital = timbre };
                comprobante.XmlString = xmlFinal;
            }
            catch (FaultException fe)
            {
                Logger.Info(fe);
                throw;
            }
            catch (SoapException exception)
            {
                Logger.Error(exception.Detail.InnerText.Trim());
                throw new ApplicationException("Error al timbrar el comprobante:" + exception.Detail.InnerText.Trim(), exception);
            }
            catch (Exception exception)
            {
                Logger.Error((exception.InnerException == null ? exception.Message : exception.InnerException.Message));
                throw new Exception("Error al timbrar el comprobante", exception);
            }


        }
        //--------------------------------------------------
        private string TipoDEPago(string tipo)
        {
            string a=tipo;
            switch (tipo)
            {
                case "01": { a = "Efectivo"; break; }
                case "02": { a = "Cheque"; break; }
                case "03": { a = "Transferencia"; break; }
                case "04": { a = "Tarjetas de crédito"; break; }
                case "05": { a = "Monederos electrónicos"; break; }
                case "06": { a = "Dinero electrónico"; break; }
                case "07": { a = "Tarjetas digitales"; break; }
                case "08": { a = "Vales de despensa"; break; }
                case "09": { a = "Bienes"; break; }
                case "10": { a = "Servicio"; break; }
                case "11": { a = "Por cuenta de tercero"; break; }
                case "12": { a = "Dación en pago"; break; }
                case "13": { a = "Pago por subrogación"; break; }
                case "14": { a = "Pago por consignación"; break; }
                case "15": { a = "Condonación"; break; }
                case "16": { a = "Cancelación"; break; }
                case "17": { a = "Compensación"; break; }
                case "98": { a = "NA"; break; }
                case "99": { a = "Otros"; break; }
            }
            return a;
        }
        //----------------------------------------------

    }
}
