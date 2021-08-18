using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Reflection;
using System.Security.Cryptography.X509Certificates;
using System.ServiceModel;
using System.Text;
using ServicioLocal.Business.ReportExecution;
using ServicioLocalContract;
using ServicioLocalContract.Entities;
using System.Xml;
using System.Xml.Serialization;
using System.Xml.Linq;
using ServicioLocal.Business.Carta;

namespace ServicioLocal.Business
{
    public class NtLinkFactura : NtLinkBusiness
    {
        public string Uuid { get; set; }
        private facturas _factura;
        public Comprobante Cfdi { get; set; }
        public string NumeroDecimal { get; set; }
       

        public List<facturasdetalle> Detalles { get; set; }

        public facturas Factura
        {
            get { return _factura; }
            set { _factura = value; }
        }

        public clientes Receptor { get; set; }

        public empresa Emisor { get; set; }



        public static byte[] GetXmlData(string uuid)
        {
            return GetData(uuid, "xml");
        }

        public static byte[] GetPdfData(string uuid)
        {
            return GetData(uuid, "pdf");
        }
        public static byte[] GetPdfDataRetenciones(string uuid, string rfc, string tipo)
        {
            string ruta = Path.Combine(ConfigurationManager.AppSettings["Salida"], rfc);
            if (File.Exists(Path.Combine(ruta, uuid + "." + tipo)))
            {
                var bytesRes = File.ReadAllBytes(Path.Combine(ruta, uuid + "." + tipo));
                return bytesRes;
            }
            else
                return null;
        }

        public static byte[] GetPdfDataRetenciones(string uuid,int idEmpresa, string tipo)
        {

            using (var db = new NtLinkLocalServiceEntities())
            {
                var em = db.empresa.Where(p => p.IdEmpresa == idEmpresa).FirstOrDefault();

                string ruta = Path.Combine(ConfigurationManager.AppSettings["Salida"],em.RFC);
                if (File.Exists(Path.Combine(ruta, uuid + "." + tipo)))
                {
                    var bytesRes = File.ReadAllBytes(Path.Combine(ruta, uuid + "." + tipo));
                    return bytesRes;
                }
                else
                    return null;
            }
        }

        public static byte[] GetData(string uuid, string tipo)
        {
            try
            {
                using (var db = new NtLinkLocalServiceEntities())
                {
                    var venta = db.facturas.Where(p => p.Uid == uuid).FirstOrDefault();
                    if (venta == null)
                    {
                        Logger.Error("No se encontró la factura: " + uuid);
                        return null;
                    }
                    
            
                    var empresa = db.empresa.Where(p => p.IdEmpresa == venta.IdEmpresa).FirstOrDefault();
                    if (empresa == null)
                    {
                        Logger.Error("No se encontró la factura: " + uuid);
                        return null;
                    }
                    string ruta = Path.Combine(ConfigurationManager.AppSettings["Salida"], empresa.RFC);
                    if (File.Exists(Path.Combine(ruta, uuid + ".xml")))
                    {
                        var bytes = File.ReadAllBytes(Path.Combine(ruta, uuid + "." + tipo));
                        return bytes;
                    }
                    else
                    {
                        Logger. Error("No se encontró la factura: " + Path.Combine(ruta, uuid + ".xml"));
                        var gen = new GeneradorCfdi();
                        var tipoDoc = (TipoDocumento)Enum.Parse(typeof (TipoDocumento), venta.TipoDocumentoStr, true);
                        if (venta.IdPdf.HasValue)
                        {
                        
                            Logger.Info("Generando nuevo PDF");
                            var res = gen.GetPdfFromComprobante(empresa.RFC, tipoDoc, empresa.IdEmpresa, venta.idcliente,
                                venta.IdPdf.Value);
                            return res;

                        }
                        return null;
                    }

                }
            }
            catch (Exception ee)
            {
                Logger.Error(ee.Message);
                return null;
            }
        }

        public static Comprobante GeneraCfd(NtLinkFactura factura, bool enviar, facturaComplementos complementos)
        {
            try
            {

                Logger.Debug(factura.Emisor.RFC);
                empresa emp = factura.Emisor;
                var sistemaBo = new NtLinkSistema();
                var sistema = sistemaBo.GetSistema((int) emp.idSistema.Value);
                if (sistema.SaldoEmision <= 0)
                {
                    Logger.Info("Saldo: " + sistema.SaldoEmision);
                    throw new FaultException(
                        "No cuentas con saldo suficiente para emitir facturas, contacta a tu ejecutivo de ventas");
                }

                clientes cliente = factura.Receptor;
                if (string.IsNullOrEmpty(cliente.RFC))
                {
                    Logger.Error("El rfc es erróneo " + cliente.RFC);
                    throw new ApplicationException("El rfc es erróneo");
                }
                string path = Path.Combine(ConfigurationManager.AppSettings["Resources"], emp.RFC, "Certs");
                X509Certificate2 cert = new X509Certificate2(Path.Combine(path, "csd.cer"));
                string rutaLlave = Path.Combine(path, "csd.key");
                if (File.Exists(rutaLlave + ".pem"))
                    rutaLlave = rutaLlave + ".pem";
                Logger.Debug("Ruta Llave " + rutaLlave);
                var comprobante = GetComprobante(factura, cliente, emp,complementos);
                Complemento.Pagos pago = new Complemento.Pagos();
               // if (complementos != null)
                  if (comprobante.Complemento != null && comprobante.Complemento.Pag!=null)
                {
                    pago = comprobante.Complemento.Pag;
                }
                GeneradorCfdi gen = new GeneradorCfdi();

                /*Agregar si hay articulos*/
                comprobante.articulos = factura.Detalles;
                /**/
                
                gen.GenerarCfd(comprobante, cert, rutaLlave, emp.PassKey);
                string ruta = Path.Combine(ConfigurationManager.AppSettings["Salida"], emp.RFC);
                if (!Directory.Exists(ruta))
                    Directory.CreateDirectory(ruta);
                string xmlFile = Path.Combine(ruta, comprobante.Complemento.timbreFiscalDigital.UUID + ".xml");
                Logger.Debug(comprobante.XmlString);
                StreamWriter sw = new StreamWriter(xmlFile, false, Encoding.UTF8);

                sw.Write(comprobante.XmlString);

                sw.Close();
                byte[] pdf = new byte[0];

                try
                {
                    long id = 0;
                    comprobante.Complemento.Pag = pago;
                    pdf = gen.GetPdfFromComprobante(comprobante, emp.Orientacion, factura.Factura.TipoDocumento, ref id, factura.Factura.Metodo, cliente);

                   // pdf = gen.GetPdfFromComprobante(comprobante, emp.Orientacion, factura.Factura.TipoDocumento);
                    
                    string pdfFile = Path.Combine(ruta, comprobante.Complemento.timbreFiscalDigital.UUID + ".pdf");
                    File.WriteAllBytes(pdfFile, pdf);
                    
                }
                catch (Exception ee)
                {
                    Logger.Error(ee);
                    if (ee.InnerException != null)
                        Logger.Error(ee.InnerException);
                }
                if (enviar)
                {
                    try
                    {
                        
                        Logger.Debug("Enviar Correo");
                        byte[] xmlBytes = Encoding.UTF8.GetBytes(comprobante.XmlString);
                        var atts = new List<EmailAttachment>();
                        atts.Add(new EmailAttachment
                        {
                            Attachment = xmlBytes,
                            Name = comprobante.Complemento.timbreFiscalDigital.UUID + ".xml"
                        });
                        atts.Add(new EmailAttachment
                        {
                            Attachment = pdf,
                            Name = comprobante.Complemento.timbreFiscalDigital.UUID + ".pdf"
                        });
                        Mailer m = new Mailer();
                        if (factura.Receptor.Bcc != null)
                            m.Bcc = factura.Receptor.Bcc;
                        List<string> emails = new List<string>();
                        emails.Add(cliente.Email);

                        m.Send(emails, atts,
                            "Se envia la factura con folio " + comprobante.Complemento.timbreFiscalDigital.UUID +
                            " en formato XML y PDF.",
                            "Envío de Factura", emp.Email, emp.RazonSocial);
                          
                    }
                    catch (Exception ee)
                    {
                        Logger.Error(ee.Message);
                        if (ee.InnerException != null)
                            Logger.Error(ee.InnerException);
                    }
                }
                return comprobante;
            }
            catch (FaultException fe)
            {
                throw;
            }
            catch (Exception ex)
            {
                Logger.Error(ex);
                if (ex.InnerException != null)
                    Logger.Error(ex.InnerException);
                return null;
            }
        }

        public void EnviarFactura(string rfc, string folioFiscal, List<string> rec, List<string> bcc)
        {
            string ruta = Path.Combine(ConfigurationManager.AppSettings["Salida"], rfc);
            string pdfFile = Path.Combine(ruta, folioFiscal + ".pdf");
            string xmlFile = Path.Combine(ruta, folioFiscal + ".xml");

            if (File.Exists(pdfFile) && File.Exists(xmlFile))
            {
                try
                {
                    using (var db = new NtLinkLocalServiceEntities())
                    {
                        
                        var venta = db.facturas.FirstOrDefault(p => p.Uid == folioFiscal);
                        if (venta == null)
                        {
                            throw new FaultException("No se encontró la factura");
                        }
                        var emp = db.empresa.FirstOrDefault(e => e.IdEmpresa == venta.IdEmpresa);
                        Logger.Debug("Enviar Correo");
                        byte[] xmlBytes = File.ReadAllBytes(xmlFile);
                        var atts = new List<EmailAttachment>();
                        atts.Add(new EmailAttachment
                        {
                            Attachment = xmlBytes,
                            Name = Path.GetFileName(xmlFile)
                        });
                        atts.Add(new EmailAttachment
                        {
                            Attachment = File.ReadAllBytes(pdfFile),
                            Name = Path.GetFileName(pdfFile)
                        });
                        Mailer m = new Mailer();
                        if (bcc != null && bcc.Count > 0)
                        {
                            m.Bcc = bcc[0];
                        }

                        m.Send(rec, atts,
                            "Se envia la factura con folio " + folioFiscal +
                            " en formato XML y PDF.",
                            "Envío de Factura", emp.Email, emp.RazonSocial);
                         
                    }

                }
                catch (FaultException ee)
                {
                    Logger.Error(ee + folioFiscal + " " + rfc);
                    throw;

                }
                catch (Exception ee)
                {
                    Logger.Error(ee.Message);
                    if (ee.InnerException != null)
                        Logger.Error(ee.InnerException);
                }
            }
            else
            {
                throw new FaultException("No se encontró la factura");
            }

        }

        private static bool ValidaSaldo(long idSistema)
        {
            try
            {
                using (var db = new NtLinkLocalServiceEntities())
                {
                    var sis = db.Sistemas.FirstOrDefault(p=>p.IdSistema == idSistema);
                    if (sis.SaldoEmision <= 0)
                    {
                        throw new FaultException("No cuentas con saldo suficiente para emitir facturas, contacta a tu ejecutivo de ventas");
                    }
                  

                }
                return true;
            }
            catch (Exception ee)
            {
                Logger.Error(ee.Message);
                if (ee.InnerException != null)
                    Logger.Error(ee.InnerException);
                throw;
            }
        }


        public static byte[] GetZipFacturas(List<int> lista, string rfc)
        {
            var zip = Path.Combine(ConfigurationManager.AppSettings["TmpFiles"], Guid.NewGuid().ToString() + ".zip");
            string ruta = Path.Combine(ConfigurationManager.AppSettings["Salida"], rfc);
            var list = new List<string>();
            foreach (var i in lista)
            {
                using (var db = new NtLinkLocalServiceEntities())
                {
                    var venta = db.facturas.FirstOrDefault(p => p.idVenta == i);
                    string pdfFile = Path.Combine(ruta, venta.Uid + ".pdf");
                    string xmlFile = Path.Combine(ruta, venta.Uid + ".xml");
                    if (File.Exists(pdfFile))
                        list.Add(pdfFile);
                    if (File.Exists(xmlFile))
                        list.Add(xmlFile);
                }
            }
            ZipUtility.CompressOrAppendZip(list, zip);
            return File.ReadAllBytes(zip);

        }

        private static Comprobante GetComprobante(NtLinkFactura factura, clientes cliente, empresa emp, facturaComplementos complementos)
        {

            Logger.Debug(factura.Factura.FolioSAT);
            if (!ValidaSaldo(factura.Emisor.idSistema.Value))
                return null;
            Comprobante comprobante = new Comprobante();
            comprobante.Emisor = new ComprobanteEmisor();
            comprobante.Emisor.Nombre = emp.RazonSocial;

              CatalogosSAT.OperacionesCatalogos o9 = new CatalogosSAT.OperacionesCatalogos();
              CatalogosSAT.c_Moneda mone = o9.Consultar_Moneda(factura.Factura.MonedaID);
          
            

            /*comprobante.Emisor.RegimenFiscal = new[]
                                                   {
                                                       new ComprobanteEmisorRegimenFiscal
                                                           {Regimen = factura.Factura.Regimen}
                                                   };
             */
            comprobante.Emisor.RegimenFiscal = emp.RegimenFiscal;
            comprobante.Emisor.Rfc = emp.RFC;
          /*  comprobante.Emisor.DomicilioFiscal = new t_UbicacionFiscal();
            comprobante.Emisor.DomicilioFiscal.calle = emp.Direccion;
            comprobante.Emisor.DomicilioFiscal.colonia = emp.Colonia;
            comprobante.Emisor.DomicilioFiscal.codigoPostal = emp.CP;
            comprobante.Emisor.DomicilioFiscal.municipio = emp.Ciudad;
            comprobante.Emisor.DomicilioFiscal.pais = "México";
            comprobante.Emisor.DomicilioFiscal.estado = emp.Estado;
            comprobante.Emisor.DomicilioFiscal.noExterior = emp.NoExt;
            comprobante.Emisor.DomicilioFiscal.noInterior = emp.NoInt;
            comprobante.Emisor.DomicilioFiscal.localidad = emp.Localidad;
            
            comprobante.Emisor.DomicilioFiscal.referencia = emp.Referencia;
            */
            //comprobante.Titulo = "Factura";
            comprobante.Titulo = factura.Factura.TipoDocumento.ToString();
            //comprobante.tipoDeComprobante = ComprobanteTipoDeComprobante.ingreso;
            //comprobante.TipoDeComprobante = c_TipoDeComprobante.I;//cambio obligado
            if (!string.IsNullOrEmpty(factura.Factura.TipoDeComprobante))
                comprobante.TipoDeComprobante = factura.Factura.TipoDeComprobante;
            else
            comprobante.TipoDeComprobante = "I";//cambio obligado
            if (!string.IsNullOrEmpty(factura.Factura.TipoRelacion))
            {
                comprobante.CfdiRelacionados = new ComprobanteCfdiRelacionados();
                comprobante.CfdiRelacionados.CfdiRelacionado = new List<ComprobanteCfdiRelacionadosCfdiRelacionado>();
                comprobante.CfdiRelacionados.TipoRelacion = factura.Factura.TipoRelacion;
                List<ComprobanteCfdiRelacionadosCfdiRelacionado> UUDI = new List<ComprobanteCfdiRelacionadosCfdiRelacionado>();

                foreach (var uudi in factura.Factura.UUID)
                {
                    ComprobanteCfdiRelacionadosCfdiRelacionado u = new ComprobanteCfdiRelacionadosCfdiRelacionado();
                    u.UUID = uudi;
                    UUDI.Add(u);

                }
                comprobante.CfdiRelacionados.CfdiRelacionado = UUDI;
            }


            if (factura.Factura.NotaCredito)
            {
                // comprobante.tipoDeComprobante = ComprobanteTipoDeComprobante.egreso;
                // comprobante.TipoDeComprobante = c_TipoDeComprobante.E;//cambio obligado
                comprobante.TipoDeComprobante = "E";//cambio obligado
                comprobante.Titulo = "Nota de Crédito";
            }
            if (factura.Factura.TipoDocumento == TipoDocumento.ReciboHonorarios)
            {
                comprobante.Titulo = "Recibo de Honorarios";
            }
            if (factura.Factura.TipoDocumento == TipoDocumento.Arrendamiento)
            {
                comprobante.Titulo = "Recibo de Arrendamiento";
            }
            if (factura.Factura.TipoDocumento == TipoDocumento.CartaPorte)
            {
                comprobante.Titulo = "Carta Porte";
                comprobante.TipoDeComprobante = "T";//cambio obligado
            }
            if (factura.Factura.TipoDocumento == TipoDocumento.Donativo)
            {
                //comprobante.tipoDeComprobante = ComprobanteTipoDeComprobante.ingreso;
                // comprobante.TipoDeComprobante = c_TipoDeComprobante.I;//cambio obligado
                comprobante.TipoDeComprobante = "I";//cambio obligado

                comprobante.DonatAprobacion = factura.Factura.DonativoAutorizacion;
                comprobante.DonatFecha = factura.Factura.DonativoFechaAutorizacion.ToString("dd/MM/yyyy");
                comprobante.DonatLeyenda =
                    "Este comprobante ampara un donativo, el cual será destinado por la donataria a los fines propios de su objeto social. En el caso de que los bienes donados hayan sido deducidos previamente para los efectos del impuesto sobre la renta, este donativo no es deducible. La reproducción no autorizada de este comprobante constituye un delito en los términos de las disposiciones fiscales.";

                comprobante.Titulo = "Recibo de Donativo";
            }
            else if (factura.Factura.TipoDocumento == TipoDocumento.Nomina)
            {
                //comprobante.tipoDeComprobante = ComprobanteTipoDeComprobante.egreso;
                //comprobante.TipoDeComprobante = c_TipoDeComprobante.E;//cambio obligado
                comprobante.TipoDeComprobante = "E";//cambio obligado
            }

            comprobante.Receptor = new ComprobanteReceptor();
            comprobante.Receptor.Nombre = cliente.RazonSocial;
            comprobante.Receptor.Rfc = cliente.RFC;
            comprobante.Receptor.UsoCFDI = factura.Factura.UsoCFDI;
            /*
            comprobante.Receptor.Domicilio = new t_Ubicacion();
            comprobante.Receptor.Domicilio.pais = cliente.Pais;
            comprobante.Receptor.Domicilio.calle = cliente.Direccion;
            comprobante.Receptor.Domicilio.municipio = cliente.Ciudad;
            comprobante.Receptor.Domicilio.estado = cliente.Estado;
            comprobante.Receptor.Domicilio.colonia = cliente.Colonia;
            comprobante.Receptor.Domicilio.codigoPostal = cliente.CP;
            comprobante.Receptor.Domicilio.noExterior = cliente.NoExt;
            comprobante.Receptor.Domicilio.noInterior = cliente.NoInt;
            comprobante.Receptor.Domicilio.localidad = cliente.Localidad;
            comprobante.Receptor.Domicilio.referencia = cliente.Referencia;
            */

            comprobante.LugarExpedicion = factura.Factura.LugarExpedicion;
            comprobante.Fecha =factura.Factura.Fecha.ToString("s");
            comprobante.Total = Decimal.Round(factura.Factura.Total.Value, (int)mone.Decimales);
            if (factura.Factura.FolioSAT != null)
            {
                factura.Factura.FolioSAT = GetNextFolio(factura.Factura.IdEmpresa.Value);
            }
            comprobante.Leyenda = factura.Factura.Leyenda;
            comprobante.LeyendaInferior = emp.LeyendaInferior;
            comprobante.LeyendaSuperior = emp.LeyendaSuperior;
            if(!string.IsNullOrEmpty(factura.Factura.Folio))
            comprobante.Folio = factura.Factura.Folio;

            comprobante.LugarExpedicion = factura.Factura.LugarExpedicion;
            if (!string.IsNullOrEmpty(factura._factura.MetodoID))
            {

                comprobante.MetodoPagoSpecified = true; 
                comprobante.MetodoPago = factura._factura.MetodoID;
            }
            else

                comprobante.MetodoPagoSpecified = false;
            if (!string.IsNullOrEmpty(factura._factura.FormaPagoID))
            {
                comprobante.FormaPagoSpecified = true;
               comprobante.FormaPago = factura.Factura.FormaPagoID;
            }
            else
                comprobante.FormaPagoSpecified = false;
            if(factura.Factura.TipoCambio!=null)
            {comprobante.TipoCambioSpecified=true;
            comprobante.TipoCambio =(decimal) factura.Factura.TipoCambio;
            }
            else
                comprobante.TipoCambioSpecified=false;
            if (!string.IsNullOrEmpty(factura.Factura.Confirmacion))
                comprobante.Confirmacion = factura.Factura.Confirmacion;


            comprobante.Moneda = factura.Factura.MonedaID;
            //comprobante.Regimen = comprobante.Emisor.RegimenFiscal[0].Regimen;
            comprobante.SubTotal = Decimal.Round(factura.Factura.SubTotal.Value, (int)mone.Decimales);// factura.Factura.Total.Value - factura.Factura.IVA.Value + factura.Factura.RetencionIva;
            comprobante.Serie = factura.Factura.Serie;
            comprobante.VoBoNombre = factura.Factura.VoBoNombre;
            comprobante.VoBoPuesto = factura.Factura.VoBoPuesto;
            comprobante.VoBoArea = factura.Factura.VoBoArea;
            comprobante.AutorizoNombre = factura.Factura.AutorizoNombre;
            comprobante.AutorizoPuesto = factura.Factura.AutorizoPuesto;
            comprobante.AutorizoArea = factura.Factura.AutorizoArea;
            comprobante.RecibiNombre = factura.Factura.RecibiNombre;
            comprobante.RecibiPuesto = factura.Factura.RecibiPuesto;
            comprobante.RecibiArea = factura.Factura.RecibiArea;
            comprobante.VoBoTitulo = factura.Factura.VoBoTitulo;
            comprobante.RecibiTitulo = factura.Factura.RecibiTitulo;
            comprobante.AutorizoTitulo = factura.Factura.AutorizoTitulo;
            comprobante.AgregadoArea = factura.Factura.AgregadoArea;
            comprobante.AgregadoNombre = factura.Factura.AgregadoNombre;
            comprobante.AgregadoPuesto = factura.Factura.AgregadoPuesto;
            comprobante.AgregadoTitulo = factura.Factura.AgregadoTitulo;
            if (!string.IsNullOrEmpty(factura.Factura.CondicionesPado))
             comprobante.CondicionesDePago = factura.Factura.CondicionesPado;
            //---------------------------------------------------------
            
            comprobante.FechaPago = factura.Factura.FechaPago;
            comprobante.Proyecto = factura.Factura.Proyecto;//campo nuevo
            comprobante.CURPEmisor = emp.CURP;
            comprobante.TituloOtros = factura.Factura.TituloOtros;
            if (factura.Factura.TipoDocumento == TipoDocumento.FacturaLiverpool)
            {

                comprobante.FormaPago = factura.Factura.FormaPago;
                comprobante.NumeroPedido = factura._factura.DatosAduanera.NumeroPedido;
                comprobante.Buyer = factura._factura.DatosAduanera.Buyer;
                comprobante.Seller = factura._factura.DatosAduanera.Seller;
                comprobante.FechaPedido = factura._factura.DatosAduanera.FechaPedido;
                comprobante.DeptoContacto = factura._factura.DatosAduanera.DeptoContacto;
                comprobante.Proveedor = factura._factura.DatosAduanera.Proveedor;
                comprobante.Aprob = factura._factura.DatosAduanera.Aprob;
                comprobante.Contrarecibo = factura._factura.DatosAduanera.Contrarecibo;
                comprobante.FechaContrarecibo = factura._factura.DatosAduanera.FechaContrarecibo;
            }
            if (factura.Factura.TipoDocumento == TipoDocumento.FacturaMabe)
            {
                comprobante.FormaPago = factura.Factura.FormaPago;
                comprobante.MonedatipoMoneda = factura._factura.DatosAduanera.MonedatipoMoneda;
                comprobante.Proveedorcodigo = factura._factura.DatosAduanera.Provedorcodigo;
                comprobante.EntregaCodigoPostal = factura._factura.DatosAduanera.EntregaCodigoPostal;
                comprobante.noExterior = factura._factura.DatosAduanera.noExterior;
                comprobante.FechaInicial = factura._factura.DatosAduanera.FechaInicial;
                comprobante.PlantaEntrega = factura._factura.DatosAduanera.PlantaEntrega;
                comprobante.Calle = factura._factura.DatosAduanera.Calle;
                comprobante.noInterior = factura._factura.DatosAduanera.noInterior;
                comprobante.FechaFinal = factura._factura.DatosAduanera.FechaFinal;
            }
            if (factura.Factura.TipoDocumento == TipoDocumento.FacturaDeloitte)
            {
                comprobante.TipoAddenda = TipoAddenda.Deloitte;
                comprobante.Proyecto = factura.Factura.Proyecto;
                comprobante.nopedido = factura._factura.DatosAduanera.nopedido;
                comprobante.Tipomoneda = AddendaDeloitteMoneda.MXP;
                comprobante.oficina = AddendaDeloitteOficina.MEX;
                comprobante.origendefactura = AddendaDeloitteOrigenFactura.EGRESO;
                comprobante.correocontacto = factura._factura.DatosAduanera.correocontacto;
                comprobante.noproveedor = factura._factura.DatosAduanera.noproveedor;
                comprobante.correoproveedor = factura._factura.DatosAduanera.correoproveedor;
                comprobante.nombreproveedor = factura._factura.DatosAduanera.nombreproveedor;
            }
            //-----------------------------------------------rgv
            if (factura.Factura.TipoDocumento == TipoDocumento.Honda)
            {
                comprobante.TipoAddenda = TipoAddenda.Honda;
                comprobante.AddendaHonda = new Honda();
                if (!string.IsNullOrEmpty(factura.Factura.FacturasAddendaHonda.ASNNumber))
                    comprobante.AddendaHonda.ASNNumber = factura.Factura.FacturasAddendaHonda.ASNNumber;
                comprobante.AddendaHonda.fecha = factura.Factura.FacturasAddendaHonda.fecha;
                comprobante.AddendaHonda.folio = factura.Factura.FacturasAddendaHonda.folio;
                comprobante.AddendaHonda.moneda = factura.Factura.FacturasAddendaHonda.moneda;
              
                if (factura.Factura.FacturasAddendaHonda.PlantCode == "GDL")
                    comprobante.AddendaHonda.PlantCode = HondaPlantCode.GDL;
                if (factura.Factura.FacturasAddendaHonda.PlantCode == "HCL")
                    comprobante.AddendaHonda.PlantCode = HondaPlantCode.HCL;
                if (factura.Factura.FacturasAddendaHonda.PlantCode == "MPS")
                    comprobante.AddendaHonda.PlantCode = HondaPlantCode.MPS;
                if (factura.Factura.FacturasAddendaHonda.PlantCode == "MTP")
                    comprobante.AddendaHonda.PlantCode = HondaPlantCode.MTP;
                if (!string.IsNullOrEmpty(factura.Factura.FacturasAddendaHonda.ReferenceNumber))
                    comprobante.AddendaHonda.ReferenceNumber = factura.Factura.FacturasAddendaHonda.ReferenceNumber;
                if (comprobante.TipoDeComprobante == "I")
                    comprobante.AddendaHonda.tipoComprobante = HondaTipoComprobante.ingreso;
                if (comprobante.TipoDeComprobante =="E")
                    comprobante.AddendaHonda.tipoComprobante = HondaTipoComprobante.egreso;
                if (factura.Factura.FacturasAddendaHonda.tipoDocumento == "GPC")
                    comprobante.AddendaHonda.tipoDocumento = HondaTipoDocumento.GPC;
                comprobante.AddendaHonda.Proveedor = new HondaProveedor();
                comprobante.AddendaHonda.Proveedor.numeroProveedor = factura.Factura.FacturasAddendaHonda.numeroProveedor;
                comprobante.AddendaHonda.Proveedor.rfc = comprobante.Emisor.Rfc;
                comprobante.AddendaHonda.Proveedor.ShipTo = factura.Factura.FacturasAddendaHonda.ShipTo;

                List<HondaConcepto> listaHondaConceptos = new List<HondaConcepto>();

                foreach (var concepto in factura.Detalles)
                {
                    HondaConcepto C = new HondaConcepto();
                    C.importe = Decimal.Round(concepto.Total, 2); 
                    C.valorUnitario = Decimal.Round(concepto.Precio, 4); 
                    C.descripcion = concepto.Descripcion;
                    C.partnumber = concepto.Codigo;
                    C.cantidad = (long)concepto.Cantidad;
                    C.nolinea = concepto.Partida;
                       
                    //  if (!string.IsNullOrEmpty(concepto.))
                    //  C.partcolor = concepto[7]; //opcional

                    listaHondaConceptos.Add(C);

                }

                comprobante.AddendaHonda.Conceptos = listaHondaConceptos.ToArray();

            }
            //--------------------------------------------------------------
            if (factura.Factura.TipoDocumentoSAT == TipoDocumento.Addenda1888)
            {
                comprobante.TipoAddenda = TipoAddenda.Addenda1888;
                comprobante.Addenda1888 = new NUMEROPEDIMENTO();
                comprobante.Addenda1888.GENERAL_NUMPED = factura.Factura.Addenda1888.GENERAL_NUMPED;

            }
            if (factura.Factura.TipoDocumentoSAT == TipoDocumento.ASONIOSCOC)
            {
                comprobante.TipoAddenda = TipoAddenda.ASONIOSCOC;
                comprobante.AddendaASONIOSCOC = new ASONIOSCOC();

                comprobante.AddendaASONIOSCOC.folio = factura.Factura.FacturasAddenASONIOSCOC.folio;
                comprobante.AddendaASONIOSCOC.noProveedor = factura.Factura.FacturasAddenASONIOSCOC.noProveedor;
                comprobante.AddendaASONIOSCOC.ordenCompra = factura.Factura.FacturasAddenASONIOSCOC.ordenCompra;
                comprobante.AddendaASONIOSCOC.serie = factura.Factura.FacturasAddenASONIOSCOC.serie;
                comprobante.AddendaASONIOSCOC.tipoProveedor = Convert.ToInt32(factura.Factura.FacturasAddenASONIOSCOC.tipoProveedor);


                List<ASONIOSCOCPartida> Ex = new List<ASONIOSCOCPartida>();
                foreach (var atri in factura.Factura.FacturasAddenASONIOSCOC.atributos)
                {
                    ASONIOSCOCPartida e = new ASONIOSCOCPartida();
                    e.noPartida = Convert.ToInt32(atri.noPartida);
                    e.ivaAcreditable = Convert.ToDecimal(atri.ivaAcreditable);
                    e.ivaDevengado =Convert.ToDecimal(atri.ivaDevengado);
                    e.Otros = atri.Otros;
                    Ex.Add(e);

                }
                comprobante.AddendaASONIOSCOC.Partidas = Ex.ToArray();

            }
            //.------------------------------------------------------------
            if (factura.Factura.TipoDocumento == TipoDocumento.Amazon)
            {
                comprobante.TipoAddenda = TipoAddenda.Amazon;
                comprobante.AddendaAmazon = new ElementosAmazon();

                if (!string.IsNullOrEmpty(factura.Factura.FacturasAddenAmazon.TextoLibre))
                comprobante.AddendaAmazon.TextoLibre = factura.Factura.FacturasAddenAmazon.TextoLibre;
                //comprobante.AddendaAmazon.LosAtributos=
                 List<ElementosAmazonLosAtributos> Ex = new List<ElementosAmazonLosAtributos>();
                    foreach (var atri in factura.Factura.FacturasAddenAmazon.atributos)
                     {
                        ElementosAmazonLosAtributos e = new ElementosAmazonLosAtributos();
                         e.valorDelAtributo= atri.valorDelAtributo;
                         e.nombreDelAtributo = atri.nombreDelAtributo;
                         e.identificacionUnica = atri.identificacionUnica;
                         Ex.Add(e);

                     }
                     comprobante.AddendaAmazon.LosAtributos = Ex.ToArray(); 
                    
            }
            //--------------------------------------------------------------

            if (factura.Factura.TipoDocumento == TipoDocumento.FacturaSorianaCEDIS)
            {
                comprobante.TipoAddenda = TipoAddenda.SorianaCedis;
                comprobante.Telefono = factura.Factura.DatosAduanera.Telefono;
                comprobante.noproveedor = factura.Factura.DatosAduanera.NoProveedor;
                comprobante.NombreCorto = factura.Factura.DatosAduanera.NombreCorto;
                comprobante.Gln = factura.Factura.DatosAduanera.Gln;
                comprobante.Descripcion = factura.Factura.DatosAduanera.Descripcion;
                comprobante.CantidadLetra = factura.Factura.DatosAduanera.CantidadLetra;
                comprobante.Proyecto = factura.Factura.DatosAduanera.Proyecto;
                comprobante.Observaciones = factura.Factura.DatosAduanera.Observaciones;
                comprobante.TipoCambio = Convert.ToDecimal(factura.Factura.DatosAduanera.tipoCambio);
                comprobante.MonedatipoMoneda = factura.Factura.DatosAduanera.TipoMoneda;
                comprobante.ExtraAtributo = factura.Factura.DatosAduanera.ExtraAtributo;
                comprobante.ExtraAtributo1 = factura.Factura.DatosAduanera.ExtraAtributo1;
                comprobante.Valor = factura.Factura.DatosAduanera.Valor;
                comprobante.Valor1 = factura.Factura.DatosAduanera.Valor1;
            }
            if (factura.Factura.TipoDocumento == TipoDocumento.FacturaSorianaTienda)
            {
                comprobante.TipoAddenda = TipoAddenda.SorianaTienda;
                comprobante.ProveedorRemision = factura.Factura.DatosAduanera.ProveedorRemision;
                comprobante.RemisionR = factura.Factura.DatosAduanera.RemisionR;
                comprobante.Consecutivo = factura.Factura.DatosAduanera.Consecutivo;
                comprobante.FechaRemision = factura.Factura.DatosAduanera.FechaRemision;
                comprobante.TiendaRemision = factura.Factura.DatosAduanera.TiendaRemision;
                comprobante.MonedatipoMoneda = factura.Factura.DatosAduanera.TipoMoneda;
                comprobante.TipoBulto = factura.Factura.DatosAduanera.TipoBulto;
                comprobante.EntrgaMercancia = factura.Factura.DatosAduanera.EntrgaMercancia;
                comprobante.CumpleReqFiscal = factura.Factura.DatosAduanera.CumpleReqFiscal;
                comprobante.CantidadBultos = factura.Factura.DatosAduanera.CantidadBultos;
                comprobante.Subtotal = factura.Factura.DatosAduanera.Subtotal;
                comprobante.Descuentos = factura.Factura.DatosAduanera.Descuentos;
                comprobante.IEPS = factura.Factura.DatosAduanera.IEPS;
                comprobante.IVA = factura.Factura.DatosAduanera.IVA;
                comprobante.OtrosImpuestos = factura.Factura.DatosAduanera.OtrosImpuestos;
                comprobante.Total = Convert.ToDecimal(factura.Factura.DatosAduanera.Total);
                comprobante.CantidadPedidos = factura.Factura.DatosAduanera.CantidadPedidos;
                comprobante.FechaEntrgaMercancia = factura.Factura.DatosAduanera.FechaEntrgaMercancia;
                comprobante.FolioNotaEntrada = factura.Factura.DatosAduanera.FolioNotaEntrada;
                comprobante.Proyecto = factura.Factura.DatosAduanera.Observaciones;
                //Pedido
                comprobante.ProveedorPedido = factura.Factura.DatosAduanera.ProveedorRemision;
                comprobante.RemisionPedido = factura.Factura.DatosAduanera.RemisionR;
                comprobante.FolioNotaEntrada = factura.Factura.DatosAduanera.FolioNotaEntrada;
                comprobante.TiendaPedidos = factura.Factura.DatosAduanera.TiendaPedido;
                comprobante.CantidadArticulos = factura.Factura.DatosAduanera.CantidadArticulos;
                //Articulos
                comprobante.ProveedorArticulos = factura.Factura.DatosAduanera.ProveedorRemision;
                comprobante.RemisionArticulos = factura.Factura.DatosAduanera.RemisionR;
                comprobante.FolioPedido = factura.Factura.DatosAduanera.FolioNotaEntrada;
                comprobante.TiendaArticulos = factura.Factura.DatosAduanera.TiendaArticulos;
                comprobante.Codigo = factura.Factura.DatosAduanera.Codigo;
                comprobante.CantidadUnidadCompra = factura.Factura.DatosAduanera.CantidadUnidadCompra;
                comprobante.CostoNetoUnidadCompra = factura.Factura.DatosAduanera.CostoNetoUnidadCompra;
                comprobante.PorcentajeIEPS = factura.Factura.DatosAduanera.PorcentajeIEPS;
                comprobante.PorecentajeIVA = factura.Factura.DatosAduanera.PorecentajeIVA;
            }
            if (factura.Factura.TipoDocumentoSAT == TipoDocumento.FacturaAdo)
            {
                comprobante.TipoAddenda = TipoAddenda.ADO;
                comprobante.Proveedor = factura.Factura.DatosAduanera.Proveedor;
                comprobante.Valor = factura.Factura.DatosAduanera.Valor;

            }
            if (factura.Factura.TipoDocumentoSAT == TipoDocumento.Innova)
            {
                comprobante.TipoAddenda = TipoAddenda.Innova;
                comprobante.AddendaInnova = new AddendaOrderIdentification();
                comprobante.AddendaInnova.referenceIdentification = new AddendaOrderIdentificationReferenceIdentification();
                comprobante.AddendaInnova.referenceIdentification.type = factura.Factura.DatosAduanera.Proveedor;
                comprobante.AddendaInnova.referenceIdentification.Value =factura.Factura.DatosAduanera.Valor;
               
            }
            //Addenda PEMEX -- SZ
            if (factura.Factura.TipoDocumento == TipoDocumento.FacturaPemex)
            {
                comprobante.TipoAddenda = TipoAddenda.Pemex;
                // Cast por reflexion
                AddendaPemex ap = new AddendaPemex();
                Type tipo = typeof(AddendaPemex);

                foreach (PropertyInfo propertyInfo in factura.Factura.FacturasAddendaPemex.GetType().GetProperties())
                {
                    tipo.GetProperty(propertyInfo.Name).SetValue(ap, propertyInfo.GetValue(factura.Factura.FacturasAddendaPemex, new object[] { }), new object[] { });
                }
                comprobante.AddendaPemex = ap;
                // Fin Cast por reflexion
            }
            if (factura.Factura.TipoDocumento == TipoDocumento.FacturaLucent)
            {
                comprobante.TipoAddenda = TipoAddenda.Lucent;
                comprobante.LucentRef = factura.Factura.LucentRef;
                comprobante.LucentOrdenCompra = factura.Factura.LucentOrdenCompra;
            }
            if(factura.Factura.TipoDocumento == TipoDocumento.CartaPorte)
            {
                //VERIFY Agregar los campos de la addenda
                if (factura.Factura.ConceptosCartaPortes != null)
                {
                    comprobante.ConceptosCartasPortes = new List<ConceptosCartaPorte>();
                    foreach (var concepto in factura.Factura.ConceptosCartaPortes)
                    {
                        comprobante.ConceptosCartasPortes.Add(concepto);
                    }
                }
            }
            if (factura.Factura.TipoDocumento == TipoDocumento.Coppel)
            {
                comprobante.AddendaCoppelObj = factura.Factura.AddendaCoppelObj;
            }
            
              if (factura.Factura.TipoDocumento == TipoDocumento.Amc71)
            {
                comprobante.AddendaAmece = factura.Factura.AddendaAmece;
            }
            if (factura.Factura.TipoDocumento == TipoDocumento.HomeDepot)
            {
                comprobante.AddendaHomeDepot = factura.Factura.AddendaHomeDepot;
            }
            if (factura.Factura.TipoDocumentoSAT == TipoDocumento.Pilgrims)
            {
                comprobante.TipoAddenda = TipoAddenda.Pilgrims;
                comprobante.AddendaPilgrims = factura.Factura.AddendaPilgrims;
            }
            if (factura.Factura.Detallista != null)
            {
                comprobante.Detallista = factura.Factura.Detallista;
            }

            List<ComprobanteConcepto> conceptos = new List<ComprobanteConcepto>();
             //-----------------------para la informacion aduanera
           // var has = factura.Detalles.Where(p => p.IAnumero != "" && p.IAnumero!=null); //se quito para que solo mandara los que si tenian datos

            decimal DescuentosTotales = 0M;
            int mon = (int)mone.Decimales;
            if(factura.Factura.MonedaID=="MXN" && !string.IsNullOrEmpty(factura.Factura.NumeroDecimal))
                mon=Convert.ToInt16(factura.Factura.NumeroDecimal);
            foreach (facturasdetalle detalle in factura.Detalles)
            {
                ComprobanteConcepto con = new ComprobanteConcepto();
                con.Descripcion = detalle.Descripcion;
                if (!string.IsNullOrEmpty(detalle.ConceptoNoIdentificacion))
                    con.NoIdentificacion = detalle.ConceptoNoIdentificacion;
                    con.Cantidad = detalle.Cantidad;
                   // con.ValorUnitario = numerodecimales(detalle.Precio, (int)mone.Decimales);
                     
                    if (complementos!=null && complementos.pagos != null)
                    {
                        con.ValorUnitario = "0";
                        con.Importe = "0";
                    }
                    else
                    {
                        con.ValorUnitario = numerodecimales(detalle.Precio, mon); ///se movio para que sea max 6 digitos
                        con.Importe = numerodecimales(detalle.Total, mon);///se movio para que sea max 6 digitos
                    }
                  //  con.Importe = numerodecimales(detalle.Total, (int)mone.Decimales);
                    con.Unidad = detalle.Unidad;
                    con.ClaveProdServ = detalle.Codigo;
                    con.ClaveUnidad = detalle.ConceptoClaveUnidad;
                    con.observaciones = detalle.Observaciones;
                    if (!string.IsNullOrEmpty(detalle.nombre))
                    {
                        con.ComplementoConcepto = new ComprobanteConceptoComplementoConcepto();
                        //---
                        con.ComplementoConcepto.Any = new List<System.Xml.XmlElement>();
                       // con.ComplementoConcepto.Any[0] = new instEducativas();
                        
                        //--
                        con.ComplementoConcepto.iedu = new instEducativas();
                        con.ComplementoConcepto.iedu.version = "1.0";
                        if (!string.IsNullOrEmpty(detalle.rfcpago))
                        {
                          con.ComplementoConcepto.iedu.rfcPago = detalle.rfcpago;
                        }
                        con.ComplementoConcepto.iedu.nombreAlumno = detalle.nombre;
                        if (detalle.NivelEducativo == "Bachillerato o su Equivalente")
                        con.ComplementoConcepto.iedu.nivelEducativo =instEducativasNivelEducativo.Bachilleratoosuequivalente ;
                        if (detalle.NivelEducativo == "Preescolar")
                            con.ComplementoConcepto.iedu.nivelEducativo = instEducativasNivelEducativo.Preescolar;
                        if (detalle.NivelEducativo == "Primaria")
                            con.ComplementoConcepto.iedu.nivelEducativo = instEducativasNivelEducativo.Primaria;
                        if (detalle.NivelEducativo == "Profesional Tecnico")
                           con.ComplementoConcepto.iedu.nivelEducativo = instEducativasNivelEducativo.Profesionaltécnico;
                        if (detalle.NivelEducativo == "Secundaria")
                            con.ComplementoConcepto.iedu.nivelEducativo = instEducativasNivelEducativo.Secundaria;
                   
                        con.ComplementoConcepto.iedu.CURP = detalle.CURP;
                        con.ComplementoConcepto.iedu.autRVOE = detalle.autrvoe;
                        con.ComplementoConcepto.Any.Add(SerializeToXmlElement(con.ComplementoConcepto.iedu));

                    }
                if(detalle.NumeroPedimento!=null)
                    if (detalle.NumeroPedimento.Count > 0)
                    {
                        List<ComprobanteConceptoInformacionAduanera> Ifor = new List<ComprobanteConceptoInformacionAduanera>();
                        foreach (var ped in detalle.NumeroPedimento)
                        {
                            ComprobanteConceptoInformacionAduanera Ca = new ComprobanteConceptoInformacionAduanera();
                            Ca.NumeroPedimento = ped.ToString();
                            Ifor.Add(Ca);
                        }
                        con.InformacionAduanera = Ifor.ToArray();
                    
                    
                    }
                    if (!string.IsNullOrEmpty(detalle.CuentaPredial))
                    {
                        con.CuentaPredial = new ComprobanteConceptoCuentaPredial();
                        con.CuentaPredial.Numero = detalle.CuentaPredial;
                    }
                    if (detalle.ConceptoDescuento != null)
                    {
                      
                        con.DescuentoSpecified = true;
                        con.Descuento = numerodecimales((decimal)detalle.ConceptoDescuento, mon); 
                        DescuentosTotales = DescuentosTotales + Convert.ToDecimal( con.Descuento);

                    }
                    else
                        con.DescuentoSpecified = false;
                   //------------------------------------------------concepto.traslado
                    if (detalle.ConceptoTraslados != null)
                        if(detalle.ConceptoTraslados.Count>0)
                    {
                        if(detalle.ConceptoTraslados.Count>0)
                        {
                        if(con.Impuestos==null)
                            con.Impuestos = new ComprobanteConceptoImpuestos();

                        List<ComprobanteConceptoImpuestosTraslado> LC = new List<ComprobanteConceptoImpuestosTraslado>();
                        foreach (var tras in detalle.ConceptoTraslados)
                        {
                            ComprobanteConceptoImpuestosTraslado C = new ComprobanteConceptoImpuestosTraslado();
                            C.Base=tras.Base;
                            if(tras.Importe!=null)
                            {
                            
                            C.ImporteSpecified=true;
                            C.Importe=numerodecimales((decimal)tras.Importe ,mon);
                           // C.Importe = numerodecimales((decimal)tras.Importe, 6);
                            }
                            else
                                C.ImporteSpecified=false;

                            C.Impuesto = tras.Impuesto;
  
                            if(tras.TasaOCuota!=null)
                            {
                            C.TasaOCuotaSpecified=true;
                            C.TasaOCuota=tras.TasaOCuota;
                            }
                            else
                            C.TasaOCuotaSpecified=false;
                            C.TipoFactor=tras.TipoFactor;
                            LC.Add(C);
                            
                        }
                        con.Impuestos.Traslados = LC.ToArray();
                    }
                        /*
                        var agrupados = detalle.ConceptoTraslados.GroupBy(p => new { p.TipoFactor, p.Impuesto, p.TasaOCuota });
                          List<ComprobanteImpuestosTraslado> listaTraslados = new List<ComprobanteImpuestosTraslado>();
                          foreach (IGrouping<int?, facturasdetalleTraslado> facturasdetallesTras in agrupados)
                          {

                          }
                         */ 

                    }
                //_----------------------------------------------------------
                    if (detalle.ConceptoRetenciones != null)// concepto.retencion
                        if(detalle.ConceptoRetenciones.Count>0)
                    {
                        if (detalle.ConceptoRetenciones.Count > 0)
                        {
                            if (con.Impuestos == null)
                                con.Impuestos = new ComprobanteConceptoImpuestos();

                            int i = 0;
                            List<ComprobanteConceptoImpuestosRetencion> LR = new List<ComprobanteConceptoImpuestosRetencion>();
                            foreach (var tras in detalle.ConceptoRetenciones)
                            {
                                ComprobanteConceptoImpuestosRetencion R = new ComprobanteConceptoImpuestosRetencion();
                                R.Base = tras.Base;
                                R.Importe = numerodecimales(Convert.ToDecimal(tras.Importe), mon);
                               // R.Importe = numerodecimales(Convert.ToDecimal(tras.Importe), 6);
                                R.Impuesto = tras.Impuesto;
                                R.TasaOCuota = tras.TasaOCuota;
                                R.TipoFactor = tras.TipoFactor;
                                LR.Add(R);
                                i++;
                            }
                            con.Impuestos.Retenciones = LR.ToArray();
                        }
                    }
                //------------------------------------------------------------------------

                   // con.OrdenCompra = detalle.OrdenCompra;
                //---------informacion aduanera---------------------------------
              /*
                if(!string.IsNullOrEmpty(detalle.IAaduana)&&!string.IsNullOrEmpty(detalle.IAnumero))
                { 
                    var InformacionAdu = new t_InformacionAduanera
                  {
                    numero = detalle.IAnumero,
                    fecha = Convert.ToDateTime(detalle.IAfecha),
                    aduana = detalle.IAaduana
                  };
                 con.Items = new object[] { InformacionAdu };
               }
                //-------------------------
        /*VERIFICAR ESTA PARTE***************************************************************************
                if (!string.IsNullOrEmpty(detalle.CuentaPredial))
                {
                    con.CuentaPredial = detalle.CuentaPredial;
                    var predial = new ComprobanteConceptoCuentaPredial
                        {
                            Numero = detalle.CuentaPredial
                        };
                    con.Items = new object[] { predial };
                }
         */ 
                conceptos.Add(con);
            }

            if (DescuentosTotales > 0)
            {
                comprobante.DescuentoSpecified = true;
                comprobante.Descuento =  numerodecimales(Convert.ToDecimal(DescuentosTotales), mon);
              //  comprobante.Descuento = numerodecimales(Convert.ToDecimal(DescuentosTotales), 6);
            }
            else
                comprobante.DescuentoSpecified = false;
        
            comprobante.Conceptos = conceptos.ToArray(); 
            ///--------------------------------------------------------------------fin conceptos
            /////---------------------------------------------Impuestos externos-------------------------------------------
                     List<DatosTraslados> DT = new List<DatosTraslados>();
                     List<DatosTraslados> DR = new List<DatosTraslados>();
                     
                     foreach (facturasdetalle detalle in factura.Detalles)
                     {
                         if(detalle.ConceptoTraslados!=null)
                         foreach (var tras in detalle.ConceptoTraslados)
                         {
                             bool x = false;
                             string Tasa = "";
                             if(!string.IsNullOrEmpty(tras.TasaOCuota))
                             Tasa=tras.TasaOCuota.ToString();

                             foreach (var dt in DT)
                             {
                                 if (dt.impuesto == tras.Impuesto && dt.tasa == Tasa && dt.factor == tras.TipoFactor)
                                 {
                                     if (tras.Importe != null)
                                         dt.importe = (Convert.ToDecimal(dt.importe) + tras.Importe).ToString();
                                     else
                                     {
                                         if (!string.IsNullOrEmpty(dt.importe))
                                         dt.importe = (Convert.ToDecimal(dt.importe)).ToString();
                                     }
                                   
                                     x = true;
                                 }
                             }

                             if(x==false)
                             if (!string.IsNullOrEmpty(tras.TipoFactor) && !string.IsNullOrEmpty(tras.Impuesto) )
                             {
                                 DatosTraslados Dtras = new DatosTraslados();
                                 Dtras.factor = tras.TipoFactor;
                                 Dtras.impuesto = tras.Impuesto;
                                 Dtras.tasa = Tasa;
                                 if (tras.Importe!=null)
                                 Dtras.importe = tras.Importe.ToString();
                                 else
                                 Dtras.importe = "";
                               
                                 DT.Add(Dtras);
                             }
                         
                         }
                         //-------------
                         if(detalle.ConceptoRetenciones!=null)
                         foreach (var tras in detalle.ConceptoRetenciones)
                         {
                             bool x = false;

                             string Tasa = tras.TasaOCuota.ToString();
                             foreach (var dt in DR)
                             {
                                 if (dt.impuesto == tras.Impuesto)
                                 {
                                     x = true;
                                     dt.importe = (Convert.ToDecimal(dt.importe) + tras.Importe).ToString();
                                 }
                             }

                             if (x == false)
                               if (!string.IsNullOrEmpty(tras.Impuesto))
                             {
                                 DatosTraslados Dtras = new DatosTraslados();
                                 Dtras.impuesto = tras.Impuesto;
                                 Dtras.importe = tras.Importe.ToString();
                                 DR.Add(Dtras);
                             }
                             
                         }

                     }
            //--------------------------------------------------ordenar los traslado y las retenciones
                     List<ComprobanteImpuestosTraslado> listaTraslados = new List<ComprobanteImpuestosTraslado>();
                     List<ComprobanteImpuestosRetencion> listaRetenciones = new List<ComprobanteImpuestosRetencion>();

            decimal totalTraslado = 0;
                     if (DT.Count > 0)
                     {
         
                         foreach (var tras in DT)
                         {
                             if (tras.factor != "Exento")
                             {
                                 ComprobanteImpuestosTraslado tr = new ComprobanteImpuestosTraslado();
                                 tr.Importe = numerodecimales(Convert.ToDecimal(tras.importe), mon);
                               //  tr.Importe = numerodecimales(Convert.ToDecimal(tras.importe), 6);
                                 tr.Impuesto = tras.impuesto;
                                 tr.TasaOCuota = tras.tasa;
                                 tr.TipoFactor = tras.factor;
                                 listaTraslados.Add(tr);
                                 totalTraslado = totalTraslado + Convert.ToDecimal(tr.Importe);
                             }
                         }
                     }
                     decimal totalRetecion = 0;
                     if (DR.Count > 0)
                     {
         
                         foreach (var tras in DR)
                         {
                             ComprobanteImpuestosRetencion tr = new ComprobanteImpuestosRetencion();
                             tr.Importe = numerodecimales(Convert.ToDecimal(tras.importe), mon);
                            // tr.Importe = numerodecimales(Convert.ToDecimal(tras.importe), 6);
                             tr.Impuesto = tras.impuesto;
                             listaRetenciones.Add(tr);
                             totalRetecion = totalRetecion +Convert.ToDecimal( tr.Importe);
                         }
                     }
            //----------------------------

             ComprobanteImpuestos impuestos = new ComprobanteImpuestos();
            if(listaTraslados.Count>0)
            {
                impuestos.Traslados = listaTraslados.ToArray();
                impuestos.TotalImpuestosTrasladadosSpecified = true;
                impuestos.TotalImpuestosTrasladados = numerodecimales(totalTraslado, (int)mone.Decimales);
               // impuestos.TotalImpuestosTrasladados = numerodecimales(totalTraslado, mon);
           
            }

            if (listaRetenciones.Count() > 0)
            {
               
                impuestos.Retenciones = listaRetenciones.ToArray();//--
                impuestos.TotalImpuestosRetenidos = numerodecimales(totalRetecion, (int)mone.Decimales);//--
             //   impuestos.TotalImpuestosRetenidos = numerodecimales(totalRetecion, mon);//--
                impuestos.TotalImpuestosRetenidosSpecified = true;//--
            }
           if(impuestos!=null)
               if((impuestos.Retenciones!=null && impuestos.Retenciones.Count()>0)||(impuestos.Traslados!=null && impuestos.Traslados.Count()>0))
            comprobante.Impuestos = impuestos;


           
            comprobante.CantidadLetra = CantidadLetra.Enletras(comprobante.Total.ToString(), comprobante.Moneda);
            if (factura.Factura.TipoDocumento == TipoDocumento.FacturaAduanera ||
                factura.Factura.TipoDocumento == TipoDocumento.FacturaLiverpool ||
                 factura.Factura.TipoDocumento == TipoDocumento.FacturaMabe ||
                  factura.Factura.TipoDocumento == TipoDocumento.FacturaSorianaCEDIS ||
                   factura.Factura.TipoDocumento == TipoDocumento.FacturaSorianaTienda ||
                   factura.Factura.TipoDocumento == TipoDocumento.FacturaAdo ||
                  factura.Factura.TipoDocumento == TipoDocumento.FacturaDeloitte ||
                factura.Factura.TipoDocumento == TipoDocumento.Constructor ||
                factura.Factura.TipoDocumento == TipoDocumento.ConstructorFirmas ||
                  factura.Factura.TipoDocumento == TipoDocumento.CorporativoAduanal ||
                factura.Factura.TipoDocumento == TipoDocumento.ConstructorFirmasCustom)
            {
                comprobante.DatosAduana = factura.Factura.DatosAduanera;
                if (!string.IsNullOrEmpty(comprobante.DatosAduana.Saldo))
                {
                    var saldo = decimal.Parse(comprobante.DatosAduana.Saldo, NumberStyles.Currency, new CultureInfo("es-MX"));
                    comprobante.CantidadLetra = CantidadLetra.Enletras(saldo.ToString(), comprobante.Moneda);
                }
                if (factura.Factura.TipoDocumento == TipoDocumento.ConstructorFirmasCustom)
                {
                    var saldo = factura.Factura.Total;
                    comprobante.CantidadLetra = CantidadLetra.Enletras(saldo.ToString(),comprobante.Moneda);
                
                }
                
                if(factura.Factura.ConceptosAduanera!=null)
                    if (factura.Factura.ConceptosAduanera.Count() > 0)
                    {
                        /*
                        List<ComprobanteConcepto> CConcepto = new List<ComprobanteConcepto>();
                        foreach (var cAdu in factura.Factura.ConceptosAduanera)
                        {
                            ComprobanteConcepto CConp = new ComprobanteConcepto();
                            CConp.Descripcion = cAdu.Descripcion;
                            CConp.ValorUnitario = cAdu.Total.ToString();
                            CConp.Detalles = cAdu.Descripcion2;
                            CConp.NoIdentificacion = cAdu.Codigo;
                            CConcepto.Add(CConp);
                        }
                        if(CConcepto!=null)
                            if(CConcepto.Count>0)
                            {
                                comprobante.ConceptosAduana = new List<ComprobanteConcepto>();
                                comprobante.ConceptosAduana = CConcepto;
                            }
                        */
                        
                        comprobante.ConceptosAduana = factura.Factura.ConceptosAduanera
                            .Select(p => new ComprobanteConcepto
                                {
                                    Descripcion = p.Descripcion,
                                    ValorUnitario = Convert.ToString(p.Total),
                                    Importe = p.Total.ToString(),
                                    Detalles = p.Descripcion2,
                                    NoIdentificacion = p.Codigo
                                }).ToList();
                        
                    }
            }

            if (factura.Factura.TipoDocumento == TipoDocumento.Donativo)
            {
                Donatarias donat = new Donatarias
                                       {
                                           fechaAutorizacion = factura.Factura.DonativoFechaAutorizacion,
                                           leyenda =
                                               "Este comprobante ampara un donativo, el cual será destinado por la donataria a los fines propios de su objeto social. En el caso de que los bienes donados hayan sido deducidos previamente para los efectos del impuesto sobre la renta, este donativo no es deducible. La reproducción no autorizada de este comprobante constituye un delito en los términos de las disposiciones fiscales.",
                                           noAutorizacion = factura.Factura.DonativoAutorizacion,
                                           version = "1.1"
                                       };
                if (comprobante.Complemento == null)
                    comprobante.Complemento = new ComprobanteComplemento();
                comprobante.Complemento.Donat = donat;
            }
            
            
            //----------------------nuevo para impuestos locales------------------------------
            //----------------------esto es nuevo para los impuestos locales
            if (factura.Factura.ImpuestosLocales!=null)
           comprobante = ComplementoImpuestosLocales(comprobante, factura.Factura.ImpuestosLocales);

            if (factura.Factura.parcialesconstruccion != null)
                comprobante = ComplementoServicioParcialContruccion(comprobante, factura.Factura.parcialesconstruccion);
            //---------------fin de impuestos locales (nuevo)
            if(complementos!=null)
           comprobante = LLenaComplemento(comprobante, complementos);

            return comprobante;
        }
        private static XElement RemoveAllNamespaces(XElement xmlDocument)
        {
            if (!xmlDocument.HasElements)
            {
                XElement xElement = new XElement(xmlDocument.Name.LocalName);
                xElement.Value = xmlDocument.Value;

                foreach (XAttribute attribute in xmlDocument.Attributes())
                    xElement.Add(attribute);

                return xElement;
            }
            return new XElement(xmlDocument.Name.LocalName, xmlDocument.Elements().Select(el => RemoveAllNamespaces(el)));
        } 
        public static XmlElement SerializeToXmlElement(object o)
        {
            XmlDocument doc = new XmlDocument();

            using (XmlWriter writer = doc.CreateNavigator().AppendChild())
            {
                new XmlSerializer(o.GetType()).Serialize(writer, o);
            }

            return doc.DocumentElement;
        }
        private static string numerodecimales(decimal d, int moneda)
        {
            string D = "0";
            if (moneda == 1)
                D = d.ToString("F1");
            if (moneda == 2)
                D = d.ToString("F2");
            if (moneda == 3)
                D = d.ToString("F3");
            if (moneda == 4)
                D = d.ToString("F4");
            if (moneda == 5)
                D = d.ToString("F5");
            if (moneda == 6)
                D = d.ToString("F6");
            return (D);
        }
        public static byte[] GeneraPreviewRs(NtLinkFactura factura, facturaComplementos complementosF)
        {
            try
            {
                empresa emp = factura.Emisor;
                clientes cliente = factura.Receptor;
                if (string.IsNullOrEmpty(cliente.RFC))
                {
                    throw new ApplicationException("El rfc es erróneo");
                }
                string path = Path.Combine(ConfigurationManager.AppSettings["Resources"], emp.RFC, "Certs");
                X509Certificate2 cert = new X509Certificate2(Path.Combine(path, "csd.cer"));
                string rutaLlave = Path.Combine(path, "csd.key");

                var comprobante = GetComprobante(factura, cliente, emp,complementosF);
                //var complementoPago= comprobante.Complemento.Pag;
                GeneradorCfdi gen = new GeneradorCfdi();
                gen.GenerarCfdPreview(comprobante, cert, rutaLlave, emp.PassKey);
                string ruta = Path.Combine(ConfigurationManager.AppSettings["Salida"], emp.RFC);
                if (!Directory.Exists(ruta))
                    Directory.CreateDirectory(ruta);

                //comprobante.Complemento.Pag = complementoPago;

                //comprobante.CantidadLetra = CantidadLetra.Enletras(comprobante.total.ToString(), comprobante.Moneda);
                long id = 0;
                byte[] pdf = gen.GetPdfFromComprobante(comprobante, emp.Orientacion, factura.Factura.TipoDocumento, ref id, factura.Factura.Metodo, cliente);
                return pdf;


            }
            catch (FaultException fe)
            {
                throw;
            }
            catch (Exception ex)
            {
                Logger.Error(ex);
                if (ex.InnerException != null)
                    Logger.Error(ex.InnerException);
                return null;
            }

        }



        public static byte[] GeneraPreview(NtLinkFactura factura)
        {
            try
            {
                empresa emp = factura.Emisor;
                clientes cliente = factura.Receptor;
                if (string.IsNullOrEmpty(cliente.RFC))
                {
                    throw new ApplicationException("El rfc es erróneo");
                }
                string path = Path.Combine(ConfigurationManager.AppSettings["Resources"], emp.RFC, "Certs");
                X509Certificate2 cert = new X509Certificate2(Path.Combine(path, "csd.cer"));
                string rutaLlave = Path.Combine(path, "csd.key");

                var comprobante = GetComprobante(factura, cliente, emp,null);
                GeneradorCfdi gen = new GeneradorCfdi();
                gen.GenerarCfdPreview(comprobante, cert, rutaLlave, emp.PassKey);
                string ruta = Path.Combine(ConfigurationManager.AppSettings["Salida"], emp.RFC);
                if (!Directory.Exists(ruta))
                    Directory.CreateDirectory(ruta);

                long id = 0;

                //comprobante.CantidadLetra = CantidadLetra.Enletras(comprobante.total.ToString(), comprobante.Moneda);
                byte[] pdf = gen.GetPdfFromComprobante(comprobante, emp.Orientacion, factura.Factura.TipoDocumento, ref id, factura.Factura.Metodo, cliente);
                return pdf;
            }
            catch (FaultException fe)
            {
                throw;
            }
            catch (Exception ex)
            {
                Logger.Error(ex);
                if (ex.InnerException != null)
                    Logger.Error(ex.InnerException);
                return null;
            }

        }

        //---------------------------------------------------------------------------------

        public static string GetNextFolio(int idEmpresa)
        {
            try
            {
                using (var db = new NtLinkLocalServiceEntities())
                {

                    // var empre = db.empresa.FirstOrDefault(p => p.IdEmpresa == idEmpresa);//nuevo
                    var empre = db.empresa.Where(p => p.IdEmpresa == idEmpresa).FirstOrDefault();//nuevo
                                     
                    string folio = "0";//nuevo
                    if (empre != null) //nuevo
                    {  //nuevo
                        if (!string.IsNullOrEmpty(empre.Folio))//nuevo
                        folio = empre.Folio;//nuevo
                       
                    } //nuevo            
                    /*
                   string folio = db.facturas.Where(p => p.IdEmpresa == idEmpresa).Max(p => p.Folio );
                     
                    //  var listaFolio = db.facturas.Where(p => p.IdEmpresa == idEmpresa).OrderByDescending(p => p.idVenta).Select(p => p.Folio);
                    //  int[] ints = listaFolio.Select(int.Parse).ToArray();
                    //  string folio = ints.Max().ToString();
                    int i = 0;
                    if (folio != null)
                    {
                        db.facturas.AsEnumerable();
                        folio = db.facturas.Where(p => p.IdEmpresa == idEmpresa).Select(p => p.Folio).Select(int.Parse).Max().ToString();
                   
                        i = int.Parse(folio);
                    }
                    */
                    Int64 i = 0;//nuevo
                    i = Int64.Parse(folio);//nuevo
                   
                    i++;
                    return i.ToString().PadLeft(6, '0');

                }
            }
            catch (Exception ee)
            {
                Logger.Error(ee.Message);
                return null;
            }
        }


        private bool ValidaFolio(string folio, int idEmpresa)
        {
            if (string.IsNullOrEmpty(folio))
                throw new ApplicationException("El folio de la factura no puede ir vacío");
            return true;

        }



        public static byte[] GetAcuseCancelacion(string report, Int64 idVenta, string estatus, string estatusCancela, string EstatusCancelacion)
        {
            try
            {
                Logger.Debug(report + "->" + idVenta);
                ReportExecutionService rs = new ReportExecutionService();
                string userName = ConfigurationManager.AppSettings["RSUserName"];
                string password = ConfigurationManager.AppSettings["RSPass"];
                string url = ConfigurationManager.AppSettings["RSUrlExec"];
                rs.Credentials = new NetworkCredential(userName, password);
                rs.Url = url;
                string reportPath = report;//"/ReportesNtLink/Pdf";
                string format = "Pdf";
                string devInfo = @"<DeviceInfo> <OutputFormat>PDF</OutputFormat> </DeviceInfo>";
                ParameterValue[] parameters = new ParameterValue[4];

                parameters[0] = new ParameterValue();
                parameters[0].Name = "idVenta";
                parameters[0].Value = idVenta.ToString();
                parameters[1] = new ParameterValue();
                parameters[1].Name = "Estatus";
                parameters[1].Value = estatus;
                parameters[2] = new ParameterValue();
                parameters[2].Name = "EstatusCancela";
                parameters[2].Value = estatusCancela;
                parameters[3] = new ParameterValue();
           
                parameters[3].Name = "EstatusCancelacion";
                parameters[3].Value = EstatusCancelacion;

                ExecutionHeader execHeader = new ExecutionHeader();
                rs.Timeout = 300000;
                rs.ExecutionHeaderValue = execHeader;
                rs.LoadReport(reportPath, null);
                rs.SetExecutionParameters(parameters, "en-US");


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

        public void CancelarRetencion(string uuid, string acuse)
        {
            try
            {
                using (var db = new NtLinkLocalServiceEntities())
                {
                    var fact = db.Retencion.FirstOrDefault(p => p.Uuid == uuid);
                    if (fact != null)
                    {
                         AcuseCancelacion ac = AcuseCancelacion.Parse(acuse);
                         if (!string.IsNullOrEmpty(ac.FechaCancelacion))
                         fact.FechaCancelacion =ac.FechaCancelacion;
                         fact.EstatusCancelacion = ac.Status;
                         fact.SelloCancelacion = ac.SelloSat; 
                         db.Retencion.ApplyCurrentValues(fact);
                         db.SaveChanges();

                        /*
                        AcuseCancelacion ac = AcuseCancelacion.Parse(acuse);
                        fact.Observaciones = acuse;
                        fact.Cancelado = 1;
                        fact.EstatusCancelacion = ac.Status;
                        fact.FechaCancelacion = ac.FechaCancelacion;
                        fact.SelloCancelacion = ac.SelloSat;
                        db.facturas.ApplyCurrentValues(fact);
                        db.SaveChanges();
                        */ 
                    }
                }
            }
            catch (FaultException fe)
            {
                throw;
            }
            catch (Exception ee)
            {
                Logger.Error(ee.Message);
                if (ee.InnerException != null)
                    Logger.Error(ee.InnerException);
            }
        }


        public void CancelarFactura(string uuid, string acuse)
        {
            try
            {
                using (var db = new NtLinkLocalServiceEntities())
                {
                    var fact = db.facturas.FirstOrDefault(p => p.Uid == uuid);
                    if (fact != null)
                    {
                        AcuseCancelacion ac = AcuseCancelacion.Parse(acuse);
                        fact.Observaciones = acuse;
                        fact.Cancelado = 1;
                        fact.EstatusCancelacion = ac.Status;
                        fact.FechaCancelacion = ac.FechaCancelacion;
                        fact.SelloCancelacion = ac.SelloSat;
                        db.facturas.ApplyCurrentValues(fact);
                        db.SaveChanges();
                    }
                }
            }
            catch (FaultException fe)
            {
                throw;
            }
            catch (Exception ee)
            {
                Logger.Error(ee.Message);
                if (ee.InnerException != null)
                    Logger.Error(ee.InnerException);
            }
        }

        public NtLinkFactura(int idFactura)
        {
            try
            {
                using (var db = new NtLinkLocalServiceEntities())
                {
                    if (idFactura == 0)
                    {
                        this.Factura = new facturas();
                        this.Detalles = new List<facturasdetalle>();
                    }
                    else
                    {
                        this.Factura = db.facturas.Where(p => p.idVenta == idFactura).FirstOrDefault();
                        if (Factura == null)
                        {
                            throw new ApplicationException("La factura " + idFactura.ToString() + " No se encontró");
                        }
                        this.Detalles = db.facturasdetalle.Where(p => p.idVenta == idFactura).ToList();
                    }
                }
            }
            catch (Exception ee)
            {
                Logger.Error(ee.Message);
                if (ee.InnerException != null)
                    Logger.Error(ee.InnerException);
            }

        }


        public bool Save()
        {
            try
            {
                _factura.RetIsr = _factura.RetencionIsr;
                _factura.RetIva = _factura.RetencionIva;
                if (_factura.DatosAduanera != null)
                    _factura.Ieps = _factura.DatosAduanera.IEPS;

                using (var db = new NtLinkLocalServiceEntities())
                {
                    empresa em = db.empresa.Where(p => p.IdEmpresa == _factura.IdEmpresa).FirstOrDefault();
                    //if (Factura.Folio != null)
                    em.Folio = _factura.FolioSAT;
                    //  else  em.Folio = "000001";//inicia la factura
                    db.SaveChanges();
                    if (_factura.idVenta == 0)
                  //  if (_factura.idVenta == 0 && ValidaFolio(_factura.Folio, _factura.IdEmpresa.Value))
                    {
                        db.facturas.AddObject(_factura);
                        var ee = db.Sistemas.FirstOrDefault(p => p.IdSistema == Emisor.idSistema);
                        ee.SaldoEmision = ee.SaldoEmision - 1;
                        ee.ConsumoEmision = ee.ConsumoEmision + 1;
                        db.SaveChanges();
                    }
                    else
                    {
                        db.facturas.ApplyCurrentValues(_factura);
                    }
                    foreach (facturasdetalle detalle in Detalles)
                    {
                        if (detalle.idproducto == 0)
                        {
                            producto prod = new producto();
                            prod.Unidad = detalle.Unidad;
                            prod.Codigo = detalle.Codigo;
                            prod.Descripcion = detalle.Descripcion;
                            prod.Observaciones = detalle.Descripcion2;
                            prod.PrecioP = detalle.Precio;
                            prod.UltimaVenta = detalle.Precio;
                            prod.IdEmpresa = Factura.IdEmpresa;
                            var ntprod = new NtLinkProducto();
                            ntprod.SaveProducto(prod);
                            detalle.idproducto = prod.IdProducto;
                        }
                        else
                        {
                            producto prod = db.producto.Where(p => p.IdProducto == detalle.idproducto).FirstOrDefault();
                            prod.UltimaVenta = detalle.Precio;
                            prod.Modificacion = DateTime.Now;
                            db.producto.ApplyCurrentValues(prod);
                        }

                        detalle.idVenta = _factura.idVenta;
                        if (detalle.IdFacturaDetalle == 0)
                            db.facturasdetalle.AddObject(detalle);
                        else
                            db.facturasdetalle.ApplyCurrentValues(detalle);

                      }
                   
                    

                    db.SaveChanges();
                    return true;
                }
            }
            catch (Exception ee)
            {
                Logger.Error(ee);
                if (ee.InnerException != null)
                    Logger.Error(ee.InnerException);
                return false;
            }
        }

        public static void Pagar(int idVenta, DateTime fechaPago, string referenciaPago)
        {
            try
            {
                using (var db = new NtLinkLocalServiceEntities())
                {
                    facturas fac = db.facturas.Single(l => l.idVenta == idVenta);
                    fac.FechaPago = fechaPago;
                    fac.ReferenciaPago = referenciaPago;
                    db.facturas.ApplyCurrentValues(fac);
                    db.SaveChanges();
                }
            }
            catch (Exception ee)
            {
                Logger.Error(ee.Message);
                if (ee.InnerException != null)
                    Logger.Error(ee.InnerException);
                throw;
            }
        }
        //***********************************AREA DE COMPLEMENTOS**************************************************
        public static Comprobante ComplementoServicioParcialContruccion(Comprobante comprobante, ServicioParcialConstruccion serContr)
        {
            if (comprobante.Complemento == null)
                comprobante.Complemento = new ComprobanteComplemento();
            comprobante.Complemento.parcialesconstruccion = new Complemento.parcialesconstruccion();

            comprobante.Complemento.parcialesconstruccion.NumPerLicoAut = serContr.NumPerLicoAut;
            comprobante.Complemento.parcialesconstruccion.Inmueble = new Complemento.parcialesconstruccionInmueble();
            comprobante.Complemento.parcialesconstruccion.Inmueble.Calle = serContr.Calle;
            comprobante.Complemento.parcialesconstruccion.Inmueble.CodigoPostal = serContr.CodigoPostal;
            if (!string.IsNullOrEmpty(serContr.Colonia))
            comprobante.Complemento.parcialesconstruccion.Inmueble.Colonia = serContr.Colonia;
            comprobante.Complemento.parcialesconstruccion.Inmueble.Estado = serContr.Estado;
            if (!string.IsNullOrEmpty(serContr.Localidad))
            comprobante.Complemento.parcialesconstruccion.Inmueble.Localidad = serContr.Localidad;
            comprobante.Complemento.parcialesconstruccion.Inmueble.Municipio = serContr.Municipio;
            if (!string.IsNullOrEmpty(serContr.NoExterior))
            comprobante.Complemento.parcialesconstruccion.Inmueble.NoExterior = serContr.NoExterior;
            if (!string.IsNullOrEmpty(serContr.NoInterior))
            comprobante.Complemento.parcialesconstruccion.Inmueble.NoInterior = serContr.NoInterior;
            if (!string.IsNullOrEmpty(serContr.Referencia))
            comprobante.Complemento.parcialesconstruccion.Inmueble.Referencia = serContr.Referencia;
            comprobante.Complemento.parcialesconstruccion.Version = "1.0";

            return comprobante;
        }
        public static Comprobante ComplementoImpuestosLocales(Comprobante comprobante, ImpLocales ImpuestosLocales)
        {
                if (ImpuestosLocales.imp.Count() > 0)
                {

                    if (comprobante.Complemento == null)
                        comprobante.Complemento = new ComprobanteComplemento();
                      comprobante.Complemento.implocal = new ImpuestosLocales();


                    if (ImpuestosLocales.TotaldeRetenciones != null)
                     comprobante.Complemento.implocal.TotaldeRetenciones = decimal.Parse(ImpuestosLocales.TotaldeRetenciones, NumberStyles.Currency);
                    if (ImpuestosLocales.TotaldeTraslados != null)
                        comprobante.Complemento.implocal.TotaldeTraslados = decimal.Parse(ImpuestosLocales.TotaldeTraslados, NumberStyles.Currency);
                    //--------------------------------------------------------
                    if (ImpuestosLocales.imp != null)
                    {
                        List<ImpuestosLocalesTrasladosLocales> LITL = new List<ImpuestosLocalesTrasladosLocales>();
                        foreach (var imp in ImpuestosLocales.imp)
                        {
                            if (imp.ImpuestosLocales == "TrasladosLocales")
                            {
                                ImpuestosLocalesTrasladosLocales litl = new ImpuestosLocalesTrasladosLocales();
                                litl.ImpLocTrasladado = imp.ImpLoc;
                                litl.Importe = decimal.Parse(imp.Importe, NumberStyles.Currency);
                                litl.TasadeTraslado = decimal.Parse(imp.Tasa, NumberStyles.Currency);

                                LITL.Add(litl);
                            }
                        }
                        if (LITL.Count > 0)
                            comprobante.Complemento.implocal.TrasladosLocales = LITL.ToArray();

                    }
                    //-------------------------------------------------------------
                    if (ImpuestosLocales.imp != null)
                    {
                        //comprobante.Complemento.imlocal.RetencionesLocales = new ImpuestosLocalesRetencionesLocales();
                        List<ImpuestosLocalesRetencionesLocales> LIL = new List<ImpuestosLocalesRetencionesLocales>();
                        foreach (var imp in ImpuestosLocales.imp)
                        {
                            if (imp.ImpuestosLocales == "RetencionesLocales")
                            {
                                ImpuestosLocalesRetencionesLocales lil = new ImpuestosLocalesRetencionesLocales();
                                lil.ImpLocRetenido = imp.ImpLoc;
                                lil.Importe = decimal.Parse(imp.Importe, NumberStyles.Currency);
                                lil.TasadeRetencion = decimal.Parse(imp.Tasa, NumberStyles.Currency);
                                LIL.Add(lil);
                            }
                        }
                        if (LIL.Count > 0)
                            comprobante.Complemento.implocal.RetencionesLocales = LIL.ToArray();
                    }
                }
                return comprobante;
        }

        public static Comprobante LLenaComplemento(Comprobante comprobante, facturaComplementos complementos)
        {
            //try
            //{

                if (complementos.vehiculoUsado != null)
                {
                    if (comprobante.Complemento == null)
                        comprobante.Complemento = new ComprobanteComplemento();
                    comprobante.Complemento.VehiculoUsado = new VehiculoUsado();
                    comprobante.Complemento.VehiculoUsado.claveVehicular = complementos.vehiculoUsado.claveVehicular;
                    comprobante.Complemento.VehiculoUsado.marca = complementos.vehiculoUsado.marca;
                    comprobante.Complemento.VehiculoUsado.modelo = complementos.vehiculoUsado.modelo;
                    comprobante.Complemento.VehiculoUsado.montoAdquisicion = complementos.vehiculoUsado.montoAdquisicion;
                    comprobante.Complemento.VehiculoUsado.montoEnajenacion = complementos.vehiculoUsado.montoEnajenacion;
                    if (!string.IsNullOrEmpty(complementos.vehiculoUsado.NIV))
                        comprobante.Complemento.VehiculoUsado.NIV = complementos.vehiculoUsado.NIV;
                    if (!string.IsNullOrEmpty(complementos.vehiculoUsado.numeroMotor))
                        comprobante.Complemento.VehiculoUsado.numeroMotor = complementos.vehiculoUsado.numeroMotor;
                    if (!string.IsNullOrEmpty(complementos.vehiculoUsado.numeroSerie))
                        comprobante.Complemento.VehiculoUsado.numeroSerie = complementos.vehiculoUsado.numeroSerie;
                    comprobante.Complemento.VehiculoUsado.tipo = complementos.vehiculoUsado.tipo;
                    comprobante.Complemento.VehiculoUsado.valor = complementos.vehiculoUsado.valor;
                    comprobante.Complemento.VehiculoUsado.Version = complementos.vehiculoUsado.Version;
                    if (complementos.vehiculoUsado.InformacionAduanera != null)
                    {
                        List<t_InformacionAduanera> IVU = new List<t_InformacionAduanera>();
                        foreach (var d in complementos.vehiculoUsado.InformacionAduanera)
                        {
                            t_InformacionAduanera i = new t_InformacionAduanera();
                            if (!string.IsNullOrEmpty(d.aduana))
                                i.aduana = d.aduana;
                            i.fecha = d.fecha;
                            i.numero = d.numero;
                            IVU.Add(i);
                        }
                        comprobante.Complemento.VehiculoUsado.InformacionAduanera = IVU.ToArray();
                    }
                }

                if (complementos.pagos != null)
                {


                    if (comprobante.Complemento == null)
                        comprobante.Complemento = new ComprobanteComplemento();
                    comprobante.Complemento.Pag = new Complemento.Pagos();
                    comprobante.Complemento.Pag.Version = "1.0";
                    comprobante.Complemento.Pag.Pago = new List<Complemento.PagosPago>();
                    List<Complemento.PagosPago> PA = new List<Complemento.PagosPago>();
                    foreach (var p in complementos.pagos)
                    {
                        Complemento.PagosPago pa = new Complemento.PagosPago();
                        CatalogosSAT.OperacionesCatalogos o13 = new CatalogosSAT.OperacionesCatalogos();
                        CatalogosSAT.c_Moneda mone = o13.Consultar_Moneda(p.monedaP);

                        if (!string.IsNullOrEmpty(p.cadPago))
                            pa.CadPago = p.cadPago;
                        if (!string.IsNullOrEmpty(p.certPago))
                            pa.CertPago = p.certPago;
                        if (!string.IsNullOrEmpty(p.ctaBeneficiario))
                            pa.CtaBeneficiario = p.ctaBeneficiario;
                        if (!string.IsNullOrEmpty(p.ctaOrdenante))
                            pa.CtaOrdenante = p.ctaOrdenante;
                        DateTime D = Convert.ToDateTime(p.fechaPago);
                        // DateTime D22 = D.AddHours(12);
                        // pa.FechaPago = D22.ToString("s");
                        pa.FechaPago = D.ToString("s");
                        if (!string.IsNullOrEmpty(p.formaDePagoP))
                            pa.FormaDePagoP = p.formaDePagoP;
                        //pa.Impuestos
                        pa.MonedaP = p.monedaP;
                        pa.Monto = numerodecimales(Convert.ToDecimal(p.monto), (int)mone.Decimales);//--
                        if (!string.IsNullOrEmpty(p.nomBancoOrdExt))
                            pa.NomBancoOrdExt = p.nomBancoOrdExt;
                        if (!string.IsNullOrEmpty(p.numOperacion))
                            pa.NumOperacion = p.numOperacion;
                        if (!string.IsNullOrEmpty(p.rfcEmisorCtaBen))
                            pa.RfcEmisorCtaBen = p.rfcEmisorCtaBen;
                        if (!string.IsNullOrEmpty(p.rfcEmisorCtaOrd))
                            pa.RfcEmisorCtaOrd = p.rfcEmisorCtaOrd;
                        if (!string.IsNullOrEmpty(p.selloPago))
                            pa.SelloPago = p.selloPago;

                        if (!string.IsNullOrEmpty(p.tipoCadPago))
                        {
                            pa.TipoCadPago = p.tipoCadPago;
                            pa.TipoCadPagoSpecified = true;
                        }
                        else
                            pa.TipoCadPagoSpecified = false;
                        if (!string.IsNullOrEmpty(p.tipoCambioP))
                        {
                            pa.TipoCambioP = Convert.ToDecimal(p.tipoCambioP);
                            pa.TipoCambioPSpecified = true;
                        }
                        else
                            pa.TipoCambioPSpecified = false;

                        List<Complemento.PagosPagoDoctoRelacionado> Doc = new List<Complemento.PagosPagoDoctoRelacionado>();
                        if (p.DoctoRelacionado != null)
                        {
                            foreach (var d in p.DoctoRelacionado)
                            {
                                Complemento.PagosPagoDoctoRelacionado doc = new Complemento.PagosPagoDoctoRelacionado();
                                doc.Folio = d.Folio;
                                doc.IdDocumento = d.IdDocumento;
                                if (!string.IsNullOrEmpty(d.ImpPagado))
                                {
                                    doc.ImpPagado = Convert.ToDecimal(d.ImpPagado);
                                    doc.ImpPagadoSpecified = true;

                                }
                                else
                                    doc.ImpPagadoSpecified = false;
                                if (!string.IsNullOrEmpty(d.ImpSaldoAnt))
                                {
                                    doc.ImpSaldoAnt = Convert.ToDecimal(d.ImpSaldoAnt);
                                    doc.ImpSaldoAntSpecified = true;
                                }
                                else
                                    doc.ImpSaldoAntSpecified = false;
                                if (!string.IsNullOrEmpty(d.ImpSaldoInsoluto))
                                {
                                    doc.ImpSaldoInsoluto = Convert.ToDecimal(d.ImpSaldoInsoluto);
                                    doc.ImpSaldoInsolutoSpecified = true;
                                }
                                else
                                    doc.ImpSaldoInsolutoSpecified = false;
                                if (!string.IsNullOrEmpty(d.MetodoDePagoDR))
                                    doc.MetodoDePagoDR = d.MetodoDePagoDR;
                                doc.MonedaDR = d.MonedaDR;
                                if (!string.IsNullOrEmpty(d.NumParcialidad))
                                    doc.NumParcialidad = d.NumParcialidad;
                                if (!string.IsNullOrEmpty(d.Serie))
                                    doc.Serie = d.Serie;
                                if (!string.IsNullOrEmpty(d.TipoCambioDR))
                                {
                                    doc.TipoCambioDR = Convert.ToDecimal(d.TipoCambioDR);
                                    doc.TipoCambioDRSpecified = true;
                                }
                                else
                                    doc.TipoCambioDRSpecified = false;
                                Doc.Add(doc);
                            }

                            pa.DoctoRelacionado = Doc.ToArray();
                        }
                        PA.Add(pa);
                    }
                    comprobante.Complemento.Pag.Pago = PA;
                }
                //-------------------------------
                if (complementos.ine != null)
                {
                    if (comprobante.Complemento == null)
                        comprobante.Complemento = new ComprobanteComplemento();
                    comprobante.Complemento.ine = new Complemento.INE();
                    if (!string.IsNullOrEmpty(complementos.ine.IdContabilidad))
                    {
                        comprobante.Complemento.ine.IdContabilidadSpecified = true;
                        comprobante.Complemento.ine.IdContabilidad = complementos.ine.IdContabilidad;
                    }
                    else
                        comprobante.Complemento.ine.IdContabilidadSpecified = false;
                    if (!string.IsNullOrEmpty(complementos.ine.TipoComite))
                    {
                        comprobante.Complemento.ine.TipoComiteSpecified = true;
                        comprobante.Complemento.ine.TipoComite = complementos.ine.TipoComite;
                    }
                    else

                        comprobante.Complemento.ine.TipoComiteSpecified = false;
                    comprobante.Complemento.ine.TipoProceso = complementos.ine.TipoProceso;

                    List<Complemento.INEEntidad> Entidad = new List<Complemento.INEEntidad>();
                    foreach (var i in complementos.ine.Entidad)
                    {
                        Complemento.INEEntidad E = new Complemento.INEEntidad();
                        if (!string.IsNullOrEmpty(i.Ambito))
                        {
                            E.AmbitoSpecified = true;
                            E.Ambito = i.Ambito;
                        }
                        else
                            E.AmbitoSpecified = false;
                        E.ClaveEntidad = i.ClaveEntidad;
                        if (i.IdContabilidad != null)
                            if (i.IdContabilidad.Count() > 0)
                            {
                                List<Complemento.INEEntidadContabilidad> Contabilidad = new List<Complemento.INEEntidadContabilidad>();
                                foreach (var s in i.IdContabilidad)
                                {
                                    Complemento.INEEntidadContabilidad c = new Complemento.INEEntidadContabilidad();
                                    c.IdContabilidad = Convert.ToInt64(s);
                                    Contabilidad.Add(c);
                                }
                                E.Contabilidad = Contabilidad.ToArray();
                            }
                        Entidad.Add(E);
                    }
                    if (Entidad != null)
                        comprobante.Complemento.ine.Entidad = Entidad.ToArray();

                }
                if (complementos.datosCartaPorte != null)
                {
                    CartaPorte c = new CartaPorte();
                    c.Version = "1.0";
                    c.TranspInternac = complementos.datosCartaPorte.transpInternac;
                    //c.EntradaSalidaMerc = complementos.datosCartaPorte.entradaSalidaMerc;

                    if (!string.IsNullOrEmpty(complementos.datosCartaPorte.entradaSalidaMerc))
                    {
                        c.EntradaSalidaMerc = complementos.datosCartaPorte.entradaSalidaMerc;
                        c.EntradaSalidaMercSpecified = true;
                    }
                    else
                        c.EntradaSalidaMercSpecified = false;

                    if (!string.IsNullOrEmpty(complementos.datosCartaPorte.viaEntradaSalida))
                    {
                        c.ViaEntradaSalida = complementos.datosCartaPorte.viaEntradaSalida;
                        c.ViaEntradaSalidaSpecified = true;
                    }
                    else
                        c.ViaEntradaSalidaSpecified = false;

                    if (complementos.datosCartaPorte.totalDistRec != null)
                    {
                        c.TotalDistRec = (decimal)complementos.datosCartaPorte.totalDistRec;
                        c.TotalDistRecSpecified = true;
                    }
                    else
                        c.TotalDistRecSpecified = false;
                    //------------
                    if (complementos.datosCartaPorte.ubicacion != null)
                    {
                        List<CartaPorteUbicacion> LU = new List<CartaPorteUbicacion>();
                        foreach (var u in complementos.datosCartaPorte.ubicacion)
                        {
                            CartaPorteUbicacion C = new CartaPorteUbicacion();
                            if (!string.IsNullOrEmpty(u.distanciaRecorrida))
                            {
                                C.DistanciaRecorrida = Convert.ToDecimal(u.distanciaRecorrida);
                                C.DistanciaRecorridaSpecified = true;
                            }
                            else
                                C.DistanciaRecorridaSpecified = false;
                            if (!string.IsNullOrEmpty(u.tipoEstacion))
                            {
                                C.TipoEstacionSpecified = true;
                                C.TipoEstacion = u.tipoEstacion;
                            }
                            else
                                C.TipoEstacionSpecified = false;

                            if (u.fechaHoraSalida != null)
                            {
                                C.Origen = new CartaPorteUbicacionOrigen();
                                if (!string.IsNullOrEmpty(u.iDOrigen))
                                    C.Origen.IDOrigen = u.iDOrigen;
                                C.Origen.FechaHoraSalida = Convert.ToDateTime(u.fechaHoraSalida).ToString("s");
                                if (!string.IsNullOrEmpty(u.navegacionTraficoOrigen))
                                {
                                    C.Origen.NavegacionTrafico = u.navegacionTraficoOrigen;
                                    C.Origen.NavegacionTraficoSpecified = true;
                                }
                                else
                                    C.Origen.NavegacionTraficoSpecified = false;
                                if (!string.IsNullOrEmpty(u.nombreEstacionOrigen))
                                    C.Origen.NombreEstacion = u.nombreEstacionOrigen;
                                if (!string.IsNullOrEmpty(u.nombreRemitente))
                                    C.Origen.NombreRemitente = u.nombreRemitente;
                                if (!string.IsNullOrEmpty(u.numEstacionOrigen))
                                {
                                    C.Origen.NumEstacion = u.numEstacionOrigen;
                                    C.Origen.NumEstacionSpecified = true;
                                }
                                else
                                    C.Origen.NumEstacionSpecified = false;
                                if (!string.IsNullOrEmpty(u.numRegIdTribOrigen))
                                    C.Origen.NumRegIdTrib = u.numRegIdTribOrigen;
                                if (!string.IsNullOrEmpty(u.residenciaFiscalOrigen))
                                {
                                    C.Origen.ResidenciaFiscal = u.residenciaFiscalOrigen;
                                    C.Origen.ResidenciaFiscalSpecified = true;
                                }
                                else
                                    C.Origen.ResidenciaFiscalSpecified = false;
                                if (!string.IsNullOrEmpty(u.rFCRemitente))
                                    C.Origen.RFCRemitente = u.rFCRemitente;
                            }
                            if (u.fechaHoraProgLlegada != null)
                            {
                                C.Destino = new CartaPorteUbicacionDestino();
                                if (!string.IsNullOrEmpty(u.iDDestino))
                                    C.Destino.IDDestino = u.iDDestino;
                                C.Destino.FechaHoraProgLlegada = Convert.ToDateTime(u.fechaHoraProgLlegada).ToString("s"); ;
                                if (!string.IsNullOrEmpty(u.navegacionTraficodestino))
                                {
                                    C.Destino.NavegacionTrafico = u.navegacionTraficodestino;
                                    C.Destino.NavegacionTraficoSpecified = true;
                                }
                                else
                                    C.Destino.NavegacionTraficoSpecified = false;
                                if (!string.IsNullOrEmpty(u.nombreEstacionDestino))
                                    C.Destino.NombreEstacion = u.nombreEstacionDestino;
                                if (!string.IsNullOrEmpty(u.nombreDestinatario))
                                    C.Destino.NombreDestinatario = u.nombreDestinatario;
                                if (!string.IsNullOrEmpty(u.numEstacionDestino))
                                {
                                    C.Destino.NumEstacion = u.numEstacionDestino;
                                    C.Destino.NumEstacionSpecified = true;
                                }
                                else
                                    C.Destino.NumEstacionSpecified = false;
                                if (!string.IsNullOrEmpty(u.numRegIdTribDestino))
                                    C.Destino.NumRegIdTrib = u.numRegIdTribDestino;
                                if (!string.IsNullOrEmpty(u.residenciaFiscalDestino))
                                {
                                    C.Destino.ResidenciaFiscal = u.residenciaFiscalDestino;
                                    C.Destino.ResidenciaFiscalSpecified = true;
                                }
                                else
                                    C.Destino.ResidenciaFiscalSpecified = false;
                                if (!string.IsNullOrEmpty(u.rFCDestinatario))
                                    C.Destino.RFCDestinatario = u.rFCDestinatario;
                            }
                            if (u.calle != null)
                            {
                                C.Domicilio = new CartaPorteUbicacionDomicilio();
                                C.Domicilio.Calle = u.calle;
                                C.Domicilio.CodigoPostal = u.codigoPostal;
                                if (!string.IsNullOrEmpty(u.colonia))
                                    C.Domicilio.Colonia = u.colonia;
                                C.Domicilio.Estado = u.estado;
                                if (!string.IsNullOrEmpty(u.localidad))
                                    C.Domicilio.Localidad = u.localidad;
                                if (!string.IsNullOrEmpty(u.municipio))
                                    C.Domicilio.Municipio = u.municipio;
                                if (!string.IsNullOrEmpty(u.numeroExterior))
                                    C.Domicilio.NumeroExterior = u.numeroExterior;
                                if (!string.IsNullOrEmpty(u.numeroInterior))
                                    C.Domicilio.NumeroInterior = u.numeroInterior;
                                C.Domicilio.Pais = u.pais;
                                if (!string.IsNullOrEmpty(u.referencia))
                                    C.Domicilio.Referencia = u.referencia;


                            }
                            LU.Add(C);
                        }

                        c.Ubicaciones = LU.ToArray();
                    }
                    ///--------------
                    if (complementos.datosCartaPorte.mercancia != null)
                    {
                        c.Mercancias = new CartaPorteMercancias();
                        if (complementos.datosCartaPorte.cargoPorTasacion != null)
                        {
                            c.Mercancias.CargoPorTasacion = (decimal)complementos.datosCartaPorte.cargoPorTasacion;
                            c.Mercancias.CargoPorTasacionSpecified = true;
                        }
                        else
                            c.Mercancias.CargoPorTasacionSpecified = false;
                        c.Mercancias.NumTotalMercancias = complementos.datosCartaPorte.numTotalMercancias;
                        if (complementos.datosCartaPorte.pesoBrutoTotal != null)
                        {
                            c.Mercancias.PesoBrutoTotal = (decimal)complementos.datosCartaPorte.pesoBrutoTotal;
                            c.Mercancias.PesoBrutoTotalSpecified = true;
                        }
                        else
                            c.Mercancias.PesoBrutoTotalSpecified = false;
                        if (complementos.datosCartaPorte.pesoNetoTotal != null)
                        {
                            c.Mercancias.PesoNetoTotal = (decimal)complementos.datosCartaPorte.pesoNetoTotal;
                            c.Mercancias.PesoNetoTotalSpecified = true;
                        }
                        else
                            c.Mercancias.PesoNetoTotalSpecified = false;
                        if (complementos.datosCartaPorte.pesoBrutoTotal != null)
                        {
                            c.Mercancias.UnidadPeso = complementos.datosCartaPorte.unidadPeso;
                            c.Mercancias.UnidadPesoSpecified = true;
                        }
                        else
                            c.Mercancias.UnidadPesoSpecified = false;


                        List<CartaPorteMercanciasMercancia> LM = new List<CartaPorteMercanciasMercancia>();
                        foreach (var m in complementos.datosCartaPorte.mercancia)
                        {
                            CartaPorteMercanciasMercancia M = new CartaPorteMercanciasMercancia();
                            if (!string.IsNullOrEmpty(m.bienesTransp))
                            {
                                M.BienesTransp = m.bienesTransp;
                                M.BienesTranspSpecified = true;
                            }
                            else
                            {
                                M.BienesTranspSpecified = false;
                            }
                            if (!string.IsNullOrEmpty(m.cantidad))
                                M.Cantidad = m.cantidad;

                            if (!string.IsNullOrEmpty(m.claveSTCC))
                            {
                                M.ClaveSTCC = m.claveSTCC;
                                M.ClaveSTCCSpecified = true;
                            }
                            else
                                M.ClaveSTCCSpecified = false;
                            if (!string.IsNullOrEmpty(m.claveUnidad))
                                M.ClaveUnidad = m.claveUnidad;
                            if (!string.IsNullOrEmpty(m.cveMaterialPeligroso))
                            {
                                M.CveMaterialPeligroso = m.cveMaterialPeligroso;
                                M.CveMaterialPeligrosoSpecified = true;
                            }
                            else
                                M.CveMaterialPeligrosoSpecified = false;
                            if (!string.IsNullOrEmpty(m.descripcion))
                                M.Descripcion = m.descripcion;
                            if (!string.IsNullOrEmpty(m.descripEmbalaje))
                                M.DescripEmbalaje = m.descripEmbalaje;
                            if (!string.IsNullOrEmpty(m.dimensiones))
                                M.Dimensiones = m.dimensiones;
                            if (!string.IsNullOrEmpty(m.embalaje))
                            {
                                M.Embalaje = m.embalaje;
                                M.EmbalajeSpecified = true;
                            }
                            else
                                M.EmbalajeSpecified = false;
                            if (!string.IsNullOrEmpty(m.fraccionArancelaria))
                            {
                                M.FraccionArancelaria = m.fraccionArancelaria;
                                M.FraccionArancelariaSpecified = true;
                            }
                            else
                                M.FraccionArancelariaSpecified = false;
                            if (!string.IsNullOrEmpty(m.materialPeligroso))
                            {
                                M.MaterialPeligroso = m.materialPeligroso;
                                M.MaterialPeligrosoSpecified = true;
                            }
                            else
                                M.MaterialPeligrosoSpecified = false;
                            if (!string.IsNullOrEmpty(m.moneda))
                            {
                                M.Moneda = m.moneda;
                                M.MonedaSpecified = true;
                            }
                            else
                                M.MonedaSpecified = false;
                            M.PesoEnKg = m.pesoEnKg;
                            if (!string.IsNullOrEmpty(m.unidad))
                                M.Unidad = m.unidad;
                            if (!string.IsNullOrEmpty(m.uUIDComercioExt))
                                M.UUIDComercioExt = m.uUIDComercioExt;
                            if (m.valorMercancia != null)
                            {
                                M.ValorMercancia = (decimal)m.valorMercancia;
                                M.ValorMercanciaSpecified = true;
                            }
                            else
                                M.ValorMercanciaSpecified = false;
                            if (!string.IsNullOrEmpty(m.unidadPesoDetalle))
                            {
                                M.DetalleMercancia = new CartaPorteMercanciasMercanciaDetalleMercancia();
                                if (m.numPiezas != null)
                                {
                                    M.DetalleMercancia.NumPiezas = (Int32)m.numPiezas;
                                    M.DetalleMercancia.NumPiezasSpecified = true;
                                }
                                else
                                    M.DetalleMercancia.NumPiezasSpecified = false;

                                M.DetalleMercancia.PesoBruto = m.pesoBruto;
                                M.DetalleMercancia.PesoNeto = m.pesoNeto;
                                M.DetalleMercancia.PesoTara = m.pesoTara;
                                M.DetalleMercancia.UnidadPeso = m.unidadPesoDetalle;
                            }
                            if (complementos.datosCartaPorte.cantidadTransporta != null && complementos.datosCartaPorte.cantidadTransporta.Count > 0)
                            {
                                List<CartaPorteMercanciasMercanciaCantidadTransporta> CANT = new List<CartaPorteMercanciasMercanciaCantidadTransporta>();
                                foreach (var cant in complementos.datosCartaPorte.cantidadTransporta)
                                {
                                    if (cant.id == m.id)
                                    {
                                        CartaPorteMercanciasMercanciaCantidadTransporta ct = new CartaPorteMercanciasMercanciaCantidadTransporta();
                                        ct.Cantidad = cant.cantidad;
                                        if (!string.IsNullOrEmpty(cant.cvesTransporte))
                                        {
                                            ct.CvesTransporte = cant.cvesTransporte;
                                            ct.CvesTransporteSpecified = true;
                                        }
                                        else
                                            ct.CvesTransporteSpecified = false;
                                        ct.IDDestino = cant.iDDestino;
                                        ct.IDOrigen = cant.iDOrigen;
                                        CANT.Add(ct);
                                    }
                                }
                                M.CantidadTransporta = CANT.ToArray();
                            }

                            LM.Add(M);
                        }
                        c.Mercancias.Mercancia = LM.ToArray();

                    }
                    //--------------------------------
                    if (!string.IsNullOrEmpty(complementos.datosCartaPorte.placaVM))
                    {
                        c.Mercancias.AutotransporteFederal = new CartaPorteMercanciasAutotransporteFederal();
                        c.Mercancias.AutotransporteFederal.IdentificacionVehicular = new CartaPorteMercanciasAutotransporteFederalIdentificacionVehicular();
                        c.Mercancias.AutotransporteFederal.IdentificacionVehicular.AnioModeloVM = complementos.datosCartaPorte.anioModeloVM;
                        c.Mercancias.AutotransporteFederal.IdentificacionVehicular.ConfigVehicular = complementos.datosCartaPorte.configVehicular;
                        c.Mercancias.AutotransporteFederal.IdentificacionVehicular.PlacaVM = complementos.datosCartaPorte.placaVM;
                    }


                    if (!string.IsNullOrEmpty(complementos.datosCartaPorte.subTipoRem1) || !string.IsNullOrEmpty(complementos.datosCartaPorte.subTipoRem2))
                    {
                        List<CartaPorteMercanciasAutotransporteFederalRemolque> LR = new List<CartaPorteMercanciasAutotransporteFederalRemolque>();
                        
                        if (!string.IsNullOrEmpty(complementos.datosCartaPorte.subTipoRem1))
                        {
                            CartaPorteMercanciasAutotransporteFederalRemolque r = new CartaPorteMercanciasAutotransporteFederalRemolque();
                            r.Placa = complementos.datosCartaPorte.placa1;
                            r.SubTipoRem = complementos.datosCartaPorte.subTipoRem1;
                            LR.Add(r);
                        }
                        if (!string.IsNullOrEmpty(complementos.datosCartaPorte.subTipoRem2))
                        {
                            CartaPorteMercanciasAutotransporteFederalRemolque r = new CartaPorteMercanciasAutotransporteFederalRemolque();
                            r.Placa = complementos.datosCartaPorte.placa2;
                            r.SubTipoRem = complementos.datosCartaPorte.subTipoRem2;
                            LR.Add(r);
                        }
                       c.Mercancias.AutotransporteFederal.Remolques = LR.ToArray();
             
                    }


                    if (!string.IsNullOrEmpty(complementos.datosCartaPorte.nombreAsegAutotransporteFederal))
                    {
                        c.Mercancias.AutotransporteFederal.NombreAseg = complementos.datosCartaPorte.nombreAsegAutotransporteFederal;
                        c.Mercancias.AutotransporteFederal.NumPermisoSCT = complementos.datosCartaPorte.numPermisoSCTAutotransporteFederal;
                        c.Mercancias.AutotransporteFederal.NumPolizaSeguro = complementos.datosCartaPorte.numPolizaSeguroAutotransporteFederal;
                        c.Mercancias.AutotransporteFederal.PermSCT = complementos.datosCartaPorte.permSCTAutotransporteFederal;
                    }
                    //----------------------
                    if (!string.IsNullOrEmpty(complementos.datosCartaPorte.nombreAgenteNaviero))
                    {
                        c.Mercancias.TransporteMaritimo = new CartaPorteMercanciasTransporteMaritimo();
                        if (complementos.datosCartaPorte.anioEmbarcacion != null)
                        {
                            c.Mercancias.TransporteMaritimo.AnioEmbarcacion = (Int32)complementos.datosCartaPorte.anioEmbarcacion;
                            c.Mercancias.TransporteMaritimo.AnioEmbarcacionSpecified = true;
                        }
                        else
                            c.Mercancias.TransporteMaritimo.AnioEmbarcacionSpecified = false;
                        if (complementos.datosCartaPorte.calado != null)
                        {
                            c.Mercancias.TransporteMaritimo.Calado = (decimal)complementos.datosCartaPorte.calado;
                            c.Mercancias.TransporteMaritimo.CaladoSpecified = true;
                        }
                        else
                            c.Mercancias.TransporteMaritimo.CaladoSpecified = false;
                        if (complementos.datosCartaPorte.eslora != null)
                        {
                            c.Mercancias.TransporteMaritimo.Eslora = (decimal)complementos.datosCartaPorte.eslora;
                            c.Mercancias.TransporteMaritimo.EsloraSpecified = true;
                        }
                        else
                            c.Mercancias.TransporteMaritimo.EsloraSpecified = false;
                        if (!string.IsNullOrEmpty(complementos.datosCartaPorte.lineaNaviera))
                            c.Mercancias.TransporteMaritimo.LineaNaviera = complementos.datosCartaPorte.lineaNaviera;
                        if (complementos.datosCartaPorte.manga != null)
                        {
                            c.Mercancias.TransporteMaritimo.Manga = (decimal)complementos.datosCartaPorte.manga;
                            c.Mercancias.TransporteMaritimo.MangaSpecified = true;
                        }
                        else
                            c.Mercancias.TransporteMaritimo.MangaSpecified = false;

                        c.Mercancias.TransporteMaritimo.Matricula = complementos.datosCartaPorte.matricula;
                        c.Mercancias.TransporteMaritimo.NacionalidadEmbarc = complementos.datosCartaPorte.nacionalidadEmbarc;
                        c.Mercancias.TransporteMaritimo.NombreAgenteNaviero = complementos.datosCartaPorte.nombreAgenteNaviero;
                        if (!string.IsNullOrEmpty(complementos.datosCartaPorte.nombreAsegTransporteMaritimo))
                            c.Mercancias.TransporteMaritimo.NombreAseg = complementos.datosCartaPorte.nombreAsegTransporteMaritimo;
                        if (!string.IsNullOrEmpty(complementos.datosCartaPorte.nombreEmbarc))
                            c.Mercancias.TransporteMaritimo.NombreEmbarc = complementos.datosCartaPorte.nombreEmbarc;
                        c.Mercancias.TransporteMaritimo.NumAutorizacionNaviero = complementos.datosCartaPorte.numAutorizacionNaviero;
                        c.Mercancias.TransporteMaritimo.NumCertITC = complementos.datosCartaPorte.numCertITC;
                        if (!string.IsNullOrEmpty(complementos.datosCartaPorte.numConocEmbarc))
                            c.Mercancias.TransporteMaritimo.NumConocEmbarc = complementos.datosCartaPorte.numConocEmbarc;
                        c.Mercancias.TransporteMaritimo.NumeroOMI = complementos.datosCartaPorte.numeroOMI;
                        if (!string.IsNullOrEmpty(complementos.datosCartaPorte.numPermisoSCTTransporteMaritimo))
                            c.Mercancias.TransporteMaritimo.NumPermisoSCT = complementos.datosCartaPorte.numPermisoSCTTransporteMaritimo;
                        if (!string.IsNullOrEmpty(complementos.datosCartaPorte.numPolizaSeguroTransporteMaritimo))
                            c.Mercancias.TransporteMaritimo.NumPolizaSeguro = complementos.datosCartaPorte.numPolizaSeguroTransporteMaritimo;
                        if (!string.IsNullOrEmpty(complementos.datosCartaPorte.numViaje))
                            c.Mercancias.TransporteMaritimo.NumViaje = complementos.datosCartaPorte.numViaje;
                        if (complementos.datosCartaPorte.permSCTTransporteMaritimo != null)
                        {
                            c.Mercancias.TransporteMaritimo.PermSCT = complementos.datosCartaPorte.permSCTTransporteMaritimo;
                            c.Mercancias.TransporteMaritimo.PermSCTSpecified = true;
                        }
                        else
                            c.Mercancias.TransporteMaritimo.PermSCTSpecified = false;
                        c.Mercancias.TransporteMaritimo.TipoCarga = complementos.datosCartaPorte.tipoCarga;
                        if (!string.IsNullOrEmpty(complementos.datosCartaPorte.tipoEmbarcacion))
                            c.Mercancias.TransporteMaritimo.TipoEmbarcacion = complementos.datosCartaPorte.tipoEmbarcacion;
                        c.Mercancias.TransporteMaritimo.UnidadesDeArqBruto = complementos.datosCartaPorte.unidadesDeArqBruto;

                        if (complementos.datosCartaPorte.contenedor != null && complementos.datosCartaPorte.contenedor.Count > 0)
                        {
                            List<CartaPorteMercanciasTransporteMaritimoContenedor> CON = new List<CartaPorteMercanciasTransporteMaritimoContenedor>();
                            foreach (var con in complementos.datosCartaPorte.contenedor)
                            {
                                CartaPorteMercanciasTransporteMaritimoContenedor conte = new CartaPorteMercanciasTransporteMaritimoContenedor();
                                conte.MatriculaContenedor = con.matriculaContenedor;
                                if (!string.IsNullOrEmpty(con.numPrecinto))
                                    conte.NumPrecinto = con.numPrecinto;
                                conte.TipoContenedor = con.tipoContenedor;
                                CON.Add(conte);
                            }

                            c.Mercancias.TransporteMaritimo.Contenedor = CON.ToArray();
                        }



                    }
                    //-----------------------------------
                    if (!string.IsNullOrEmpty(complementos.datosCartaPorte.matriculaAeronave))
                    {
                        c.Mercancias.TransporteAereo = new CartaPorteMercanciasTransporteAereo();
                        if (!string.IsNullOrEmpty(complementos.datosCartaPorte.codigoTransportista))
                        {
                            c.Mercancias.TransporteAereo.CodigoTransportista = complementos.datosCartaPorte.codigoTransportista;
                            c.Mercancias.TransporteAereo.CodigoTransportistaSpecified = true;
                        }
                        else
                            c.Mercancias.TransporteAereo.CodigoTransportistaSpecified = false;
                        if (!string.IsNullOrEmpty(complementos.datosCartaPorte.lugarContrato))
                            c.Mercancias.TransporteAereo.LugarContrato = complementos.datosCartaPorte.lugarContrato;
                        c.Mercancias.TransporteAereo.MatriculaAeronave = complementos.datosCartaPorte.matriculaAeronave;
                        if (!string.IsNullOrEmpty(complementos.datosCartaPorte.nombreAsegTransporteAereo))
                            c.Mercancias.TransporteAereo.NombreAseg = complementos.datosCartaPorte.nombreAsegTransporteAereo;
                        if (!string.IsNullOrEmpty(complementos.datosCartaPorte.nombreEmbarcador))
                            c.Mercancias.TransporteAereo.NombreEmbarcador = complementos.datosCartaPorte.nombreEmbarcador;
                        if (!string.IsNullOrEmpty(complementos.datosCartaPorte.nombreTransportista))
                            c.Mercancias.TransporteAereo.NombreTransportista = complementos.datosCartaPorte.nombreTransportista;
                        c.Mercancias.TransporteAereo.NumeroGuia = complementos.datosCartaPorte.numeroGuia;
                        c.Mercancias.TransporteAereo.NumPermisoSCT = complementos.datosCartaPorte.numPermisoSCT;
                        if (!string.IsNullOrEmpty(complementos.datosCartaPorte.numPolizaSeguroTransporteAereo))
                            c.Mercancias.TransporteAereo.NumPolizaSeguro = complementos.datosCartaPorte.numPolizaSeguroTransporteAereo;
                        if (!string.IsNullOrEmpty(complementos.datosCartaPorte.numRegIdTribEmbarc))
                            c.Mercancias.TransporteAereo.NumRegIdTribEmbarc = complementos.datosCartaPorte.numRegIdTribEmbarc;
                        if (!string.IsNullOrEmpty(complementos.datosCartaPorte.numRegIdTribTranspor))
                            c.Mercancias.TransporteAereo.NumRegIdTribTranspor = complementos.datosCartaPorte.numRegIdTribTranspor;
                        if (!string.IsNullOrEmpty(complementos.datosCartaPorte.permSCT))
                        {
                            c.Mercancias.TransporteAereo.PermSCT = complementos.datosCartaPorte.permSCT;
                            c.Mercancias.TransporteAereo.PermSCTSpecified = true;
                        }
                        else
                            c.Mercancias.TransporteAereo.PermSCTSpecified = false;
                        if (!string.IsNullOrEmpty(complementos.datosCartaPorte.residenciaFiscalEmbarc))
                        {
                            c.Mercancias.TransporteAereo.ResidenciaFiscalEmbarc = complementos.datosCartaPorte.residenciaFiscalEmbarc;
                            c.Mercancias.TransporteAereo.ResidenciaFiscalEmbarcSpecified = true;
                        }
                        else
                            c.Mercancias.TransporteAereo.ResidenciaFiscalEmbarcSpecified = false;
                        if (!string.IsNullOrEmpty(complementos.datosCartaPorte.residenciaFiscalTranspor))
                        {
                            c.Mercancias.TransporteAereo.ResidenciaFiscalTranspor = complementos.datosCartaPorte.residenciaFiscalTranspor;
                            c.Mercancias.TransporteAereo.ResidenciaFiscalTransporSpecified = true;
                        }
                        else
                            c.Mercancias.TransporteAereo.ResidenciaFiscalTransporSpecified = false;
                        if (!string.IsNullOrEmpty(complementos.datosCartaPorte.rFCEmbarcador))
                            c.Mercancias.TransporteAereo.RFCEmbarcador = complementos.datosCartaPorte.rFCEmbarcador;
                        if (!string.IsNullOrEmpty(complementos.datosCartaPorte.rFCTransportista))
                            c.Mercancias.TransporteAereo.RFCTransportista = complementos.datosCartaPorte.rFCTransportista;


                    }
                    //---------------------------------
                    if (!string.IsNullOrEmpty(complementos.datosCartaPorte.tipoDeServicio))
                    {
                        c.Mercancias.TransporteFerroviario = new CartaPorteMercanciasTransporteFerroviario();
                        c.Mercancias.TransporteFerroviario.TipoDeServicio = complementos.datosCartaPorte.tipoDeServicio;
                        if (!string.IsNullOrEmpty(complementos.datosCartaPorte.concesionario))
                            c.Mercancias.TransporteFerroviario.Concesionario = complementos.datosCartaPorte.concesionario;
                        if (!string.IsNullOrEmpty(complementos.datosCartaPorte.nombreAseg))
                            c.Mercancias.TransporteFerroviario.NombreAseg = complementos.datosCartaPorte.nombreAseg;
                        if (!string.IsNullOrEmpty(complementos.datosCartaPorte.numPolizaSeguro))
                            c.Mercancias.TransporteFerroviario.NumPolizaSeguro = complementos.datosCartaPorte.numPolizaSeguro;

                        if (complementos.datosCartaPorte.derechosDePaso != null && complementos.datosCartaPorte.derechosDePaso.Count > 0)
                        {
                            List<CartaPorteMercanciasTransporteFerroviarioDerechosDePaso> D = new List<CartaPorteMercanciasTransporteFerroviarioDerechosDePaso>();
                            foreach (var des in complementos.datosCartaPorte.derechosDePaso)
                            {
                                CartaPorteMercanciasTransporteFerroviarioDerechosDePaso d = new CartaPorteMercanciasTransporteFerroviarioDerechosDePaso();
                                d.KilometrajePagado = des.kilometrajePagado;
                                d.TipoDerechoDePaso = des.tipoDerechoDePaso;
                                D.Add(d);
                            }
                            c.Mercancias.TransporteFerroviario.DerechosDePaso = D.ToArray();
                        }

                        if (complementos.datosCartaPorte.carro != null && complementos.datosCartaPorte.carro.Count > 0)
                        {
                            List<CartaPorteMercanciasTransporteFerroviarioCarro> CA = new List<CartaPorteMercanciasTransporteFerroviarioCarro>();
                            foreach (var ca in complementos.datosCartaPorte.carro)
                            {
                                CartaPorteMercanciasTransporteFerroviarioCarro cr = new CartaPorteMercanciasTransporteFerroviarioCarro();
                                cr.GuiaCarro = ca.guiaCarro;
                                cr.MatriculaCarro = ca.matriculaCarro;
                                cr.TipoCarro = ca.tipoCarro;
                                cr.ToneladasNetasCarro = ca.toneladasNetasCarro;
                                if (complementos.datosCartaPorte.carroContenedor != null && complementos.datosCartaPorte.carroContenedor.Count > 0)
                                {
                                    List<CartaPorteMercanciasTransporteFerroviarioCarroContenedor> CAC = new List<CartaPorteMercanciasTransporteFerroviarioCarroContenedor>();
                                    foreach (var cc in complementos.datosCartaPorte.carroContenedor)
                                    {
                                        if (ca.id == cc.id)
                                        {
                                            CartaPorteMercanciasTransporteFerroviarioCarroContenedor cac = new CartaPorteMercanciasTransporteFerroviarioCarroContenedor();
                                            cac.PesoContenedorVacio = cc.pesoContenedorVacio;
                                            cac.PesoNetoMercancia = cc.pesoNetoMercancia;
                                            cac.TipoContenedor = cc.tipoContenedor;
                                            CAC.Add(cac);
                                        }
                                    }
                                    cr.Contenedor = CAC.ToArray();
                                }
                                CA.Add(cr);
                            }
                            c.Mercancias.TransporteFerroviario.Carro = CA.ToArray();
                        }

                    }
                    //-----------------------------
                    if (!string.IsNullOrEmpty(complementos.datosCartaPorte.cveTransporte))
                    {
                        c.FiguraTransporte = new CartaPorteFiguraTransporte();
                        c.FiguraTransporte.CveTransporte = complementos.datosCartaPorte.cveTransporte;

                        if (complementos.datosCartaPorte.operador != null && complementos.datosCartaPorte.operador.Count > 0)
                        {
                            List<CartaPorteFiguraTransporteOperadores> OO = new List<CartaPorteFiguraTransporteOperadores>();
                            CartaPorteFiguraTransporteOperadores O1 = new CartaPorteFiguraTransporteOperadores();
                            List<CartaPorteFiguraTransporteOperadoresOperador> O = new List<CartaPorteFiguraTransporteOperadoresOperador>();
                            foreach (var op in complementos.datosCartaPorte.operador)
                            {
                                CartaPorteFiguraTransporteOperadoresOperador o = new CartaPorteFiguraTransporteOperadoresOperador();
                                if (!string.IsNullOrEmpty(op.nombreOperador))
                                    o.NombreOperador = op.nombreOperador;
                                if (!string.IsNullOrEmpty(op.numLicencia))
                                    o.NumLicencia = op.numLicencia;
                                if (!string.IsNullOrEmpty(op.numRegIdTribOperador))
                                    o.NumRegIdTribOperador = op.numRegIdTribOperador;
                                if (!string.IsNullOrEmpty(op.residenciaFiscalOperador))
                                {
                                    o.ResidenciaFiscalOperador = op.residenciaFiscalOperador;
                                    o.ResidenciaFiscalOperadorSpecified = true;
                                }
                                else
                                    o.ResidenciaFiscalOperadorSpecified = false;
                                if (!string.IsNullOrEmpty(op.rFCOperador))
                                    o.RFCOperador = op.rFCOperador;

                                if (!string.IsNullOrEmpty(op.calle))
                                {
                                    o.Domicilio = new CartaPorteFiguraTransporteOperadoresOperadorDomicilio();
                                    o.Domicilio.Calle = op.calle;
                                    o.Domicilio.CodigoPostal = op.codigoPostal;
                                    if (!string.IsNullOrEmpty(op.colonia))
                                        o.Domicilio.Colonia = op.colonia;
                                    o.Domicilio.Estado = op.estado;
                                    if (!string.IsNullOrEmpty(op.localidad))
                                        o.Domicilio.Localidad = op.localidad;
                                    if (!string.IsNullOrEmpty(op.municipio))
                                        o.Domicilio.Municipio = op.municipio;
                                    if (!string.IsNullOrEmpty(op.numeroExterior))
                                        o.Domicilio.NumeroExterior = op.numeroExterior;
                                    if (!string.IsNullOrEmpty(op.numeroInterior))
                                        o.Domicilio.NumeroInterior = op.numeroInterior;
                                    o.Domicilio.Pais = op.pais;
                                    if (!string.IsNullOrEmpty(op.referencia))
                                        o.Domicilio.Referencia = op.referencia;

                                }
                                O.Add(o);
                            }
                            O1.Operador = O.ToArray();
                            OO.Add(O1);
                            c.FiguraTransporte.Operadores = OO.ToArray();
                        }
                        //---------------------------------------------
                        if (complementos.datosCartaPorte.propietario != null && complementos.datosCartaPorte.propietario.Count > 0)
                        {
                            List<CartaPorteFiguraTransportePropietario> O = new List<CartaPorteFiguraTransportePropietario>();
                            foreach (var op in complementos.datosCartaPorte.propietario)
                            {
                                CartaPorteFiguraTransportePropietario o = new CartaPorteFiguraTransportePropietario();
                                if (!string.IsNullOrEmpty(op.nombrePropietario))
                                    o.NombrePropietario = op.nombrePropietario;
                                if (!string.IsNullOrEmpty(op.numRegIdTribPropietario))
                                    o.NumRegIdTribPropietario = op.numRegIdTribPropietario;
                                if (!string.IsNullOrEmpty(op.residenciaFiscalPropietario))
                                {
                                    o.ResidenciaFiscalPropietario = op.residenciaFiscalPropietario;
                                    o.ResidenciaFiscalPropietarioSpecified = true;
                                }
                                else
                                    o.ResidenciaFiscalPropietarioSpecified = false;
                                if (!string.IsNullOrEmpty(op.rFCPropietario))
                                    o.RFCPropietario = op.rFCPropietario;

                                if (!string.IsNullOrEmpty(op.calle))
                                {
                                    o.Domicilio = new CartaPorteFiguraTransportePropietarioDomicilio();
                                    o.Domicilio.Calle = op.calle;
                                    o.Domicilio.CodigoPostal = op.codigoPostal;
                                    if (!string.IsNullOrEmpty(op.colonia))
                                        o.Domicilio.Colonia = op.colonia;
                                    o.Domicilio.Estado = op.estado;
                                    if (!string.IsNullOrEmpty(op.localidad))
                                        o.Domicilio.Localidad = op.localidad;
                                    if (!string.IsNullOrEmpty(op.municipio))
                                        o.Domicilio.Municipio = op.municipio;
                                    if (!string.IsNullOrEmpty(op.numeroExterior))
                                        o.Domicilio.NumeroExterior = op.numeroExterior;
                                    if (!string.IsNullOrEmpty(op.numeroInterior))
                                        o.Domicilio.NumeroInterior = op.numeroInterior;
                                    o.Domicilio.Pais = op.pais;
                                    if (!string.IsNullOrEmpty(op.referencia))
                                        o.Domicilio.Referencia = op.referencia;

                                }
                                O.Add(o);
                            }
                            c.FiguraTransporte.Propietario = O.ToArray();
                        }
                        //---------------------------------------------
                        if (complementos.datosCartaPorte.arrendatario != null && complementos.datosCartaPorte.arrendatario.Count > 0)
                        {
                            List<CartaPorteFiguraTransporteArrendatario> O = new List<CartaPorteFiguraTransporteArrendatario>();
                            foreach (var op in complementos.datosCartaPorte.arrendatario)
                            {
                                CartaPorteFiguraTransporteArrendatario o = new CartaPorteFiguraTransporteArrendatario();
                                if (!string.IsNullOrEmpty(op.nombreArrendatario))
                                    o.NombreArrendatario = op.nombreArrendatario;
                                if (!string.IsNullOrEmpty(op.numRegIdTribArrendatario))
                                    o.NumRegIdTribArrendatario = op.numRegIdTribArrendatario;
                                if (!string.IsNullOrEmpty(op.residenciaFiscalArrendatario))
                                {
                                    o.ResidenciaFiscalArrendatario = op.residenciaFiscalArrendatario;
                                    o.ResidenciaFiscalArrendatarioSpecified = true;
                                }
                                else
                                    o.ResidenciaFiscalArrendatarioSpecified = false;
                                if (!string.IsNullOrEmpty(op.rFCArrendatario))
                                    o.RFCArrendatario = op.rFCArrendatario;

                                if (!string.IsNullOrEmpty(op.calle))
                                {
                                    o.Domicilio = new CartaPorteFiguraTransporteArrendatarioDomicilio();
                                    o.Domicilio.Calle = op.calle;
                                    o.Domicilio.CodigoPostal = op.codigoPostal;
                                    if (!string.IsNullOrEmpty(op.colonia))
                                        o.Domicilio.Colonia = op.colonia;
                                    o.Domicilio.Estado = op.estado;
                                    if (!string.IsNullOrEmpty(op.localidad))
                                        o.Domicilio.Localidad = op.localidad;
                                    if (!string.IsNullOrEmpty(op.municipio))
                                        o.Domicilio.Municipio = op.municipio;
                                    if (!string.IsNullOrEmpty(op.numeroExterior))
                                        o.Domicilio.NumeroExterior = op.numeroExterior;
                                    if (!string.IsNullOrEmpty(op.numeroInterior))
                                        o.Domicilio.NumeroInterior = op.numeroInterior;
                                    o.Domicilio.Pais = op.pais;
                                    if (!string.IsNullOrEmpty(op.referencia))
                                        o.Domicilio.Referencia = op.referencia;

                                }
                                O.Add(o);
                            }
                            c.FiguraTransporte.Arrendatario = O.ToArray();
                        }
                        //---------------------------------------------
                        if (complementos.datosCartaPorte.notificado != null && complementos.datosCartaPorte.notificado.Count > 0)
                        {
                            List<CartaPorteFiguraTransporteNotificado> O = new List<CartaPorteFiguraTransporteNotificado>();
                            foreach (var op in complementos.datosCartaPorte.notificado)
                            {
                                CartaPorteFiguraTransporteNotificado o = new CartaPorteFiguraTransporteNotificado();
                                if (!string.IsNullOrEmpty(op.nombreNotificado))
                                    o.NombreNotificado = op.nombreNotificado;
                                if (!string.IsNullOrEmpty(op.numRegIdTribNotificado))
                                    o.NumRegIdTribNotificado = op.numRegIdTribNotificado;
                                if (!string.IsNullOrEmpty(op.residenciaFiscalNotificado))
                                {
                                    o.ResidenciaFiscalNotificado = op.residenciaFiscalNotificado;
                                    o.ResidenciaFiscalNotificadoSpecified = true;
                                }
                                else
                                    o.ResidenciaFiscalNotificadoSpecified = false;
                                if (!string.IsNullOrEmpty(op.rFCNotificado))
                                    o.RFCNotificado = op.rFCNotificado;

                                if (!string.IsNullOrEmpty(op.calle))
                                {
                                    o.Domicilio = new CartaPorteFiguraTransporteNotificadoDomicilio();
                                    o.Domicilio.Calle = op.calle;
                                    o.Domicilio.CodigoPostal = op.codigoPostal;
                                    if (!string.IsNullOrEmpty(op.colonia))
                                        o.Domicilio.Colonia = op.colonia;
                                    o.Domicilio.Estado = op.estado;
                                    if (!string.IsNullOrEmpty(op.localidad))
                                        o.Domicilio.Localidad = op.localidad;
                                    if (!string.IsNullOrEmpty(op.municipio))
                                        o.Domicilio.Municipio = op.municipio;
                                    if (!string.IsNullOrEmpty(op.numeroExterior))
                                        o.Domicilio.NumeroExterior = op.numeroExterior;
                                    if (!string.IsNullOrEmpty(op.numeroInterior))
                                        o.Domicilio.NumeroInterior = op.numeroInterior;
                                    o.Domicilio.Pais = op.pais;
                                    if (!string.IsNullOrEmpty(op.referencia))
                                        o.Domicilio.Referencia = op.referencia;

                                }
                                O.Add(o);
                            }
                            c.FiguraTransporte.Notificado = O.ToArray();
                        }
                        //---------------------------------------------
                    }
                    //-----------------------------------
                    if (comprobante.Complemento == null)
                        comprobante.Complemento = new ComprobanteComplemento();
                    comprobante.Complemento.cartaPorte = new CartaPorte();
                    comprobante.Complemento.cartaPorte = c;

                }

                return comprobante;
            //}
            //catch (Exception ee)
            //{
            //    Logger.Error("Error en llenado del complemento en Aplicativo:"+ ee.Message);
            //    return comprobante;
            //}
        }
        //***********************************************************************************



    }

  
}
