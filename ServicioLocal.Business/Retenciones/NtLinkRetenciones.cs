using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.ServiceModel;
using System.Text;
using ServicioLocalContract;
using ServicioLocalContract.Entities;
using Planesderetiro11;

namespace ServicioLocal.Business.Retenciones
{
    public class NtLinkRetenciones : NtLinkBusiness
    {
        public Retencion Retencion { get; set; }
        public IList<RetencionesItem> Items { get; set; }


        public static byte[] GeneraCfdPreview(Retencion retencion, IList<RetencionesItem> items,DatosRetenciones datosRetenciones)
        {
            try
            {
                empresa empresa;
                using (var db = new NtLinkLocalServiceEntities())
                {
                    empresa = db.empresa.Single(l => l.IdEmpresa == retencion.Emisor);
                }

                var sistemaBo = new NtLinkSistema();
                var sistema = sistemaBo.GetSistema((int) empresa.idSistema.Value);
                if (sistema.SaldoEmision <= 0)
                {
                    Logger.Info("Saldo: " + sistema.SaldoEmision);
                    throw new FaultException(
                        "No cuentas con saldo suficiente para emitir facturas, contacta a tu ejecutivo de ventas");
                }

                clientes cliente;
                using (var db = new NtLinkLocalServiceEntities())
                {
                    cliente = db.clientes.Single(l => l.idCliente == retencion.Receptor);
                }

                if (string.IsNullOrEmpty(cliente.RFC))
                {
                    Logger.Error("El rfc es erróneo " + cliente.RFC);
                    throw new ApplicationException("El rfc es erróneo");
                }

                string path = Path.Combine(ConfigurationManager.AppSettings["Resources"], empresa.RFC, "Certs");
                X509Certificate2 cert = new X509Certificate2(Path.Combine(path, "csd.cer"));
                string rutaLlave = Path.Combine(path, "csd.key");
                if (File.Exists(rutaLlave + ".pem"))
                    rutaLlave = rutaLlave + ".pem";
                Logger.Debug("Ruta Llave " + rutaLlave);

                Retenciones comprobante = GetRetencion(retencion, items, cliente, empresa, datosRetenciones);
                GeneradorCfdi gen = new GeneradorCfdi();

                gen.GenerarCfdRetPreview(comprobante, cert, rutaLlave, empresa.PassKey);

                string ruta = Path.Combine(ConfigurationManager.AppSettings["Salida"], empresa.RFC);
                if (!Directory.Exists(ruta))
                    Directory.CreateDirectory(ruta);

                retencion.Uuid = comprobante.Complemento.timbreFiscalDigital.UUID;
                string xmlFile = Path.Combine(ruta, retencion.Uuid + ".xml");
                Logger.Debug(comprobante.XmlString);
                //StreamWriter sw = new StreamWriter(xmlFile, false, Encoding.UTF8);

                //sw.Write(comprobante.XmlString);

               // sw.Close();

                try
                {
                    var pdf = gen.GetPdfFromRetenciones(comprobante, comprobante.XmlString,
                        comprobante.CadenaOriginalTimbre);
                    return pdf;
                }
                catch (Exception ee)
                {
                    Logger.Error(ee);
                    if (ee.InnerException != null)
                        Logger.Error(ee.InnerException);
                }
            }
            catch (FaultException)
            {
                throw;
            }
            catch (Exception ee)
            {
                Logger.Error(ee);
                if (ee.InnerException != null)
                    Logger.Error(ee.InnerException);
            }
            return null;
        }

        public static
            Retenciones GeneraCfd(Retencion retencion, IList<RetencionesItem> items,DatosRetenciones datosRetenciones, bool enviar)
        {
            try
            {
                empresa empresa;
                using (var db = new NtLinkLocalServiceEntities())
                {
                    empresa = db.empresa.Single(l => l.IdEmpresa == retencion.Emisor);
                }
            
                var sistemaBo = new NtLinkSistema();
                var sistema = sistemaBo.GetSistema((int)empresa.idSistema.Value);
                if (sistema.SaldoEmision <= 0)
                {
                    Logger.Info("Saldo: " + sistema.SaldoEmision);
                    throw new FaultException("No cuentas con saldo suficiente para emitir facturas, contacta a tu ejecutivo de ventas");
                }

                clientes cliente;
                using (var db = new NtLinkLocalServiceEntities())
                {
                    cliente = db.clientes.Single(l => l.idCliente == retencion.Receptor);
                }

                if (string.IsNullOrEmpty(cliente.RFC))
                {
                    Logger.Error("El rfc es erróneo " + cliente.RFC);
                    throw new ApplicationException("El rfc es erróneo");
                }

                string path = Path.Combine(ConfigurationManager.AppSettings["Resources"], empresa.RFC, "Certs");
                X509Certificate2 cert = new X509Certificate2(Path.Combine(path, "csd.cer"));
                string rutaLlave = Path.Combine(path, "csd.key");
                if (File.Exists(rutaLlave + ".pem"))
                    rutaLlave = rutaLlave + ".pem";
                Logger.Debug("Ruta Llave " + rutaLlave);

                Retenciones comprobante = GetRetencion(retencion, items, cliente, empresa,datosRetenciones);
                GeneradorCfdi gen = new GeneradorCfdi();

                gen.GenerarCfdRetenciones(comprobante, cert, rutaLlave, empresa.PassKey);

                string ruta = Path.Combine(ConfigurationManager.AppSettings["Salida"], empresa.RFC);
                if (!Directory.Exists(ruta))
                    Directory.CreateDirectory(ruta);

                retencion.Uuid = comprobante.Complemento.timbreFiscalDigital.UUID;
                string xmlFile = Path.Combine(ruta, retencion.Uuid + ".xml");
                Logger.Debug(comprobante.XmlString);
                StreamWriter sw = new StreamWriter(xmlFile, false, Encoding.UTF8);

                sw.Write(comprobante.XmlString);

                sw.Close();

                try
                {
                    var pdf = gen.GetPdfFromRetenciones(comprobante, comprobante.XmlString, comprobante.CadenaOriginalTimbre);
                    string pdfFile = Path.Combine(ruta, retencion.Uuid + ".pdf");
                    File.WriteAllBytes(pdfFile, pdf);

                    if (enviar)
                    {
                        EnviaCorreo(comprobante, empresa, cliente, retencion.Uuid, pdf);
                    }
                }
                catch (Exception ee)
                {
                    Logger.Error(ee);
                    if (ee.InnerException != null)
                        Logger.Error(ee.InnerException);
                }
                return comprobante;
            }
            catch (FaultException)
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

//---------------------------------------------------
        private static Retenciones GetRetencion(Retencion retencion, IList<RetencionesItem> items, clientes cliente, empresa empresa,DatosRetenciones datosRetenciones)
        {
            Logger.Debug(retencion.Uuid);

            if (!ValidaSaldo(empresa.idSistema.Value))
                return null;

            Retenciones comprobante = new Retenciones();
            
            comprobante.Emisor = new RetencionesEmisor();
            comprobante.Emisor.NomDenRazSocE = empresa.RazonSocial;
            comprobante.Emisor.RFCEmisor = empresa.RFC;
            comprobante.IdEmpresa = empresa.IdEmpresa;
            if(!string.IsNullOrEmpty(empresa.CURP))
            comprobante.Emisor.CURPE = empresa.CURP;

            comprobante.Receptor = new RetencionesReceptor();
            comprobante.IdReceptor = cliente.idCliente;
           
            //-----------------------------------------------------------------------------
            if (cliente.Nacionalidad == "Mexicana")
            {
                comprobante.Receptor.Nacionalidad = RetencionesReceptorNacionalidad.Nacional;
                RetencionesReceptorNacional receptorNacional = new RetencionesReceptorNacional();
                receptorNacional.NomDenRazSocR = cliente.RazonSocial;
                receptorNacional.RFCRecep = cliente.RFC;
                if (!string.IsNullOrEmpty(cliente.CURP))
                    receptorNacional.CURPR = cliente.CURP;
                comprobante.Receptor.Item = receptorNacional;
            }
            else
            {
                comprobante.Receptor.Nacionalidad = RetencionesReceptorNacionalidad.Extranjero;
                RetencionesReceptorExtranjero receptorExtranjero = new RetencionesReceptorExtranjero();
                receptorExtranjero.NomDenRazSocR = cliente.RazonSocial;
                if(!string.IsNullOrEmpty(cliente.NumRegIdTrib))
                receptorExtranjero.NumRegIdTrib = cliente.NumRegIdTrib;
                comprobante.Receptor.Item = receptorExtranjero;
            }
            //_---------------------------------------------------------------------

            comprobante.Periodo = new RetencionesPeriodo();
            comprobante.Periodo.MesIni = retencion.MesInicial;
            comprobante.Periodo.MesFin = retencion.MesFinal;
            comprobante.Periodo.Ejerc = retencion.Ejercicio;

            comprobante.CveRetenc = retencion.ClaveRetencion;
            comprobante.DescRetenc = retencion.DescripcionRetencion;
            comprobante.FolioInt = retencion.Folio;

            comprobante.Totales = new RetencionesTotales();
            comprobante.Totales.montoTotOperacion = retencion.MontoTotalOperacion;
            comprobante.Totales.montoTotGrav = retencion.MontoTotalGravado;
            comprobante.Totales.montoTotExent = retencion.MontoTotalExento;
            comprobante.Totales.montoTotRet = retencion.MontoTotalRetencion;

            if (items.Count != 0)
            {
                List<RetencionesTotalesImpRetenidos> impuestosRetenidos = new List<RetencionesTotalesImpRetenidos>();
                foreach (var item in items)
                {
                    impuestosRetenidos.Add(new RetencionesTotalesImpRetenidos()
                    {
                        BaseRet =  item.BaseRet,
                        BaseRetSpecified =  true,
                        Impuesto = item.Impuestos,
                        ImpuestoSpecified =  true,
                        TipoPagoRet = item.TipoPagoRet,
                        montoRet = item.MontoRet

                    });
                }
                comprobante.Totales.ImpRetenidos = impuestosRetenidos.ToArray();
            }
            //-----------agragando las retenciones---------------------------------------------------
           //retenciones
             comprobante.Complemento=new RetencionesComplemento();
            // comprobante.Complemento.intereses.versionField = "";
            if (datosRetenciones.intereses.activo == "true")
            {
                comprobante.Complemento.intereses = new Intereses();
                comprobante.Complemento.intereses.SistFinanciero = new InteresesSistFinanciero();
                if (datosRetenciones.intereses.sistFinancieroField == "SI")
                    comprobante.Complemento.intereses.SistFinanciero = InteresesSistFinanciero.SI;
                else
                    comprobante.Complemento.intereses.SistFinanciero = InteresesSistFinanciero.NO;
                comprobante.Complemento.intereses.RetiroAORESRetInt = new InteresesRetiroAORESRetInt();
                if (datosRetenciones.intereses.retiroAORESRetIntField == "SI")
                    comprobante.Complemento.intereses.RetiroAORESRetInt = InteresesRetiroAORESRetInt.SI;
                else
                    comprobante.Complemento.intereses.RetiroAORESRetInt = InteresesRetiroAORESRetInt.NO;
                comprobante.Complemento.intereses.OperFinancDerivad = new InteresesOperFinancDerivad();
                if (datosRetenciones.intereses.operFinancDerivadField == "SI")
                    comprobante.Complemento.intereses.OperFinancDerivad = InteresesOperFinancDerivad.SI;
                else
                    comprobante.Complemento.intereses.OperFinancDerivad = InteresesOperFinancDerivad.NO;
                comprobante.Complemento.intereses.MontIntNominal =Convert.ToDecimal(datosRetenciones.intereses.montIntNominalField);
                comprobante.Complemento.intereses.MontIntReal = Convert.ToDecimal(datosRetenciones.intereses.montIntRealField);
                comprobante.Complemento.intereses.Perdida = Convert.ToDecimal(datosRetenciones.intereses.perdidaField);

            }
                //-------------------------------dividendos

            if (datosRetenciones.dividendos.activo == "true")
            { 
               comprobante.Complemento.dividendos=new Dividendos();
               comprobante.Complemento.dividendos.DividOUtil = new DividendosDividOUtil();
               comprobante.Complemento.dividendos.DividOUtil.CveTipDivOUtil = datosRetenciones.dividendos.dividendosDividOUtil.cveTipDivOUtilField;
               if (!string.IsNullOrEmpty(datosRetenciones.dividendos.dividendosDividOUtil.montDivAcumExtField))
               {
                   comprobante.Complemento.dividendos.DividOUtil.MontDivAcumExtSpecified = true;
                   comprobante.Complemento.dividendos.DividOUtil.MontDivAcumExt = Convert.ToDecimal(datosRetenciones.dividendos.dividendosDividOUtil.montDivAcumExtField);
               }
                else
                   comprobante.Complemento.dividendos.DividOUtil.MontDivAcumExtSpecified = false;
               if (!string.IsNullOrEmpty(datosRetenciones.dividendos.dividendosDividOUtil.montDivAcumNalField))
               {
                   comprobante.Complemento.dividendos.DividOUtil.MontDivAcumNalSpecified = true;
                   comprobante.Complemento.dividendos.DividOUtil.MontDivAcumNal = Convert.ToDecimal(datosRetenciones.dividendos.dividendosDividOUtil.montDivAcumNalField);
               }
               else
                   comprobante.Complemento.dividendos.DividOUtil.MontDivAcumNalSpecified = false;

               comprobante.Complemento.dividendos.DividOUtil.MontISRAcredRetExtranjero = Convert.ToDecimal(datosRetenciones.dividendos.dividendosDividOUtil.montISRAcredRetExtranjeroField);
               if (datosRetenciones.dividendos.dividendosDividOUtil.tipoSocDistrDivField == "SociedadExtranjera")
                comprobante.Complemento.dividendos.DividOUtil.TipoSocDistrDiv =DividendosDividOUtilTipoSocDistrDiv.SociedadExtranjera;
               else
                   comprobante.Complemento.dividendos.DividOUtil.TipoSocDistrDiv = DividendosDividOUtilTipoSocDistrDiv.SociedadNacional;

               if (!string.IsNullOrEmpty(datosRetenciones.dividendos.dividendosDividOUtil.montRetExtDivExtField))
               {
                   comprobante.Complemento.dividendos.DividOUtil.MontRetExtDivExtSpecified = true;
                   comprobante.Complemento.dividendos.DividOUtil.MontRetExtDivExt = Convert.ToDecimal(datosRetenciones.dividendos.dividendosDividOUtil.montRetExtDivExtField);
               }else
                   comprobante.Complemento.dividendos.DividOUtil.MontRetExtDivExtSpecified = false;
                  
               comprobante.Complemento.dividendos.DividOUtil.MontISRAcredRetMexico = Convert.ToDecimal(datosRetenciones.dividendos.dividendosDividOUtil.montISRAcredRetMexicoField);

               if (!string.IsNullOrEmpty(datosRetenciones.dividendos.dividendosDividOUtil.montISRAcredNalField))
               {
                   comprobante.Complemento.dividendos.DividOUtil.MontISRAcredNalSpecified = true;
                   comprobante.Complemento.dividendos.DividOUtil.MontISRAcredNal = Convert.ToDecimal(datosRetenciones.dividendos.dividendosDividOUtil.montISRAcredNalField);
               }else
                   comprobante.Complemento.dividendos.DividOUtil.MontISRAcredNalSpecified = false;

               comprobante.Complemento.dividendos.Remanente = new DividendosRemanente();
               if (!string.IsNullOrEmpty(datosRetenciones.dividendos.remanenteField.proporcionRemField))
               {
                   comprobante.Complemento.dividendos.Remanente.ProporcionRemSpecified = true;
                   comprobante.Complemento.dividendos.Remanente.ProporcionRem = Convert.ToDecimal(datosRetenciones.dividendos.remanenteField.proporcionRemField);
               }
               else
                   comprobante.Complemento.dividendos.Remanente.ProporcionRemSpecified = false;
            }
            //---------------------------------Arrendamientoenfideicomiso
            if (datosRetenciones.arrendamientoenfideicomiso.activo == "true")
            {
                comprobante.Complemento.arrendamientoenfideicomiso = new Arrendamientoenfideicomiso();
                comprobante.Complemento.arrendamientoenfideicomiso.DeduccCorresp = Convert.ToDecimal(datosRetenciones.arrendamientoenfideicomiso.deduccCorrespField);
                 if (!string.IsNullOrEmpty(datosRetenciones.arrendamientoenfideicomiso.montOtrosConceptDistrField))
                {
                    comprobante.Complemento.arrendamientoenfideicomiso.MontOtrosConceptDistr = Convert.ToDecimal(datosRetenciones.arrendamientoenfideicomiso.montOtrosConceptDistrField);
                    comprobante.Complemento.arrendamientoenfideicomiso.MontOtrosConceptDistrSpecified = true;
                    comprobante.Complemento.arrendamientoenfideicomiso.DescrMontOtrosConceptDistr = datosRetenciones.arrendamientoenfideicomiso.descrMontOtrosConceptDistrField;
             
                }
                else
                    comprobante.Complemento.arrendamientoenfideicomiso.MontOtrosConceptDistrSpecified = false;

                if (!string.IsNullOrEmpty(datosRetenciones.arrendamientoenfideicomiso.montResFiscDistFibrasField))
                {
                    comprobante.Complemento.arrendamientoenfideicomiso.MontResFiscDistFibras = Convert.ToDecimal(datosRetenciones.arrendamientoenfideicomiso.montResFiscDistFibrasField);
                    comprobante.Complemento.arrendamientoenfideicomiso.MontResFiscDistFibrasSpecified = true;
                }
                else
                    comprobante.Complemento.arrendamientoenfideicomiso.MontResFiscDistFibrasSpecified = false;
                if (!string.IsNullOrEmpty(datosRetenciones.arrendamientoenfideicomiso.montTotRetField))
                {
                    comprobante.Complemento.arrendamientoenfideicomiso.MontTotRet = Convert.ToDecimal(datosRetenciones.arrendamientoenfideicomiso.montTotRetField);
                    comprobante.Complemento.arrendamientoenfideicomiso.MontTotRetSpecified =true;
                }
                else
                    comprobante.Complemento.arrendamientoenfideicomiso.MontTotRetSpecified = false;

                comprobante.Complemento.arrendamientoenfideicomiso.PagProvEfecPorFiduc = Convert.ToDecimal(datosRetenciones.arrendamientoenfideicomiso.pagProvEfecPorFiducField);
                comprobante.Complemento.arrendamientoenfideicomiso.RendimFideicom = Convert.ToDecimal(datosRetenciones.arrendamientoenfideicomiso.rendimFideicomField);
                

            }

            //--------------------------------EnajenaciondeAcciones
            if (datosRetenciones.enajenaciondeAcciones.activo == "true")
            {
                comprobante.Complemento.enajenaciondeAcciones = new EnajenaciondeAcciones();
                comprobante.Complemento.enajenaciondeAcciones.ContratoIntermediacion = datosRetenciones.enajenaciondeAcciones.contratoIntermediacionField;
                comprobante.Complemento.enajenaciondeAcciones.Ganancia =Convert.ToDecimal( datosRetenciones.enajenaciondeAcciones.gananciaField);
                comprobante.Complemento.enajenaciondeAcciones.Perdida = Convert.ToDecimal(datosRetenciones.enajenaciondeAcciones.perdidaField);
                

            }
            //--------------------------------fideicomisonoempresarial
            if (datosRetenciones.fideicomisonoempresarial.activo == "true")
            {
                comprobante.Complemento.fideicomisonoempresarial = new Fideicomisonoempresarial();
                comprobante.Complemento.fideicomisonoempresarial.DeduccOSalidas = new FideicomisonoempresarialDeduccOSalidas();
                comprobante.Complemento.fideicomisonoempresarial.DeduccOSalidas.IntegracEgresos = new FideicomisonoempresarialDeduccOSalidasIntegracEgresos();
                comprobante.Complemento.fideicomisonoempresarial.DeduccOSalidas.IntegracEgresos.ConceptoS = datosRetenciones.fideicomisonoempresarial.IntegracEgresosConceptoS;

                comprobante.Complemento.fideicomisonoempresarial.DeduccOSalidas.MontTotEgresPeriodo = Convert.ToDecimal(datosRetenciones.fideicomisonoempresarial.MontTotEgresPeriodo);
                comprobante.Complemento.fideicomisonoempresarial.DeduccOSalidas.PartPropDelFideicom = Convert.ToDecimal(datosRetenciones.fideicomisonoempresarial.PartPropDelFideicom);
                int z = datosRetenciones.fideicomisonoempresarial.IntegracEgresosPropDelMontTot.IndexOf(".");
                if (z == -1)
                    datosRetenciones.fideicomisonoempresarial.IntegracEgresosPropDelMontTot = datosRetenciones.fideicomisonoempresarial.IntegracEgresosPropDelMontTot + ".00";
                comprobante.Complemento.fideicomisonoempresarial.DeduccOSalidas.PropDelMontTot = (datosRetenciones.fideicomisonoempresarial.IntegracEgresosPropDelMontTot);

                
                comprobante.Complemento.fideicomisonoempresarial.IngresosOEntradas = new FideicomisonoempresarialIngresosOEntradas();
                comprobante.Complemento.fideicomisonoempresarial.IngresosOEntradas.IntegracIngresos = new FideicomisonoempresarialIngresosOEntradasIntegracIngresos();
                comprobante.Complemento.fideicomisonoempresarial.IngresosOEntradas.IntegracIngresos.Concepto = datosRetenciones.fideicomisonoempresarial.IntegracIngresosConcepto;

                comprobante.Complemento.fideicomisonoempresarial.IngresosOEntradas.MontTotEntradasPeriodo = Convert.ToDecimal(datosRetenciones.fideicomisonoempresarial.MontTotEntradasPeriodo);
                comprobante.Complemento.fideicomisonoempresarial.IngresosOEntradas.PartPropAcumDelFideicom = Convert.ToDecimal(datosRetenciones.fideicomisonoempresarial.PartPropAcumDelFideicom);
                comprobante.Complemento.fideicomisonoempresarial.IngresosOEntradas.PropDelMontTot = Convert.ToDecimal(datosRetenciones.fideicomisonoempresarial.IntegracIngresosPropDelMontTot);
                comprobante.Complemento.fideicomisonoempresarial.RetEfectFideicomiso = new FideicomisonoempresarialRetEfectFideicomiso();
                comprobante.Complemento.fideicomisonoempresarial.RetEfectFideicomiso.DescRetRelPagFideic = datosRetenciones.fideicomisonoempresarial.DescRetRelPagFideic;
                comprobante.Complemento.fideicomisonoempresarial.RetEfectFideicomiso.MontRetRelPagFideic =Convert.ToDecimal( datosRetenciones.fideicomisonoempresarial.MontRetRelPagFideic);

            }
            //--------------------------------intereseshipotecarios
            if (datosRetenciones.intereseshipotecarios.activo == "true")
            {
                comprobante.Complemento.intereseshipotecarios = new Intereseshipotecarios();
                comprobante.Complemento.intereseshipotecarios.CreditoDeInstFinanc =new IntereseshipotecariosCreditoDeInstFinanc();
                if(datosRetenciones.intereseshipotecarios.CreditoDeInstFinanc=="SI")
                comprobante.Complemento.intereseshipotecarios.CreditoDeInstFinanc= IntereseshipotecariosCreditoDeInstFinanc.SI;
                else
                comprobante.Complemento.intereseshipotecarios.CreditoDeInstFinanc= IntereseshipotecariosCreditoDeInstFinanc.NO;

                comprobante.Complemento.intereseshipotecarios.SaldoInsoluto = Convert.ToDecimal(datosRetenciones.intereseshipotecarios.SaldoInsoluto);

                if (!string.IsNullOrEmpty(datosRetenciones.intereseshipotecarios.PropDeducDelCredit))
                {
                    comprobante.Complemento.intereseshipotecarios.PropDeducDelCreditSpecified = true;
                    comprobante.Complemento.intereseshipotecarios.PropDeducDelCredit = Convert.ToDecimal(datosRetenciones.intereseshipotecarios.PropDeducDelCredit);
                }
                else
                    comprobante.Complemento.intereseshipotecarios.PropDeducDelCreditSpecified = false;

                    if (!string.IsNullOrEmpty(datosRetenciones.intereseshipotecarios.MontTotIntNominalesDev))
                {
                    comprobante.Complemento.intereseshipotecarios.MontTotIntNominalesDevSpecified = true;
                    comprobante.Complemento.intereseshipotecarios.MontTotIntNominalesDev = Convert.ToDecimal(datosRetenciones.intereseshipotecarios.MontTotIntNominalesDev);
                }
                else
                    comprobante.Complemento.intereseshipotecarios.MontTotIntNominalesDevSpecified = false;
                if (!string.IsNullOrEmpty(datosRetenciones.intereseshipotecarios.MontTotIntNominalesDevYPag))
                {
                    comprobante.Complemento.intereseshipotecarios.MontTotIntNominalesDevYPagSpecified = true;
                    comprobante.Complemento.intereseshipotecarios.MontTotIntNominalesDevYPag = Convert.ToDecimal(datosRetenciones.intereseshipotecarios.MontTotIntNominalesDevYPag);
                }
                else
                    comprobante.Complemento.intereseshipotecarios.MontTotIntNominalesDevYPagSpecified = false;

                if (!string.IsNullOrEmpty(datosRetenciones.intereseshipotecarios.MontTotIntRealPagDeduc))
                {
                    comprobante.Complemento.intereseshipotecarios.MontTotIntRealPagDeducSpecified = true;
                    comprobante.Complemento.intereseshipotecarios.MontTotIntRealPagDeduc = Convert.ToDecimal(datosRetenciones.intereseshipotecarios.MontTotIntRealPagDeduc);
                }
                else
                    comprobante.Complemento.intereseshipotecarios.MontTotIntRealPagDeducSpecified = false;
                if (!string.IsNullOrEmpty(datosRetenciones.intereseshipotecarios.NumContrato))
                    comprobante.Complemento.intereseshipotecarios.NumContrato = datosRetenciones.intereseshipotecarios.NumContrato;
               

            }
            //--------------------------------operacionesconderivados
            if (datosRetenciones.operacionesconderivados.activo == "true")
            {
                comprobante.Complemento.operacionesconderivados = new Operacionesconderivados();
                comprobante.Complemento.operacionesconderivados.MontGanAcum = Convert.ToDecimal(datosRetenciones.operacionesconderivados.MontGanAcum);
                comprobante.Complemento.operacionesconderivados.MontPerdDed = Convert.ToDecimal(datosRetenciones.operacionesconderivados.MontPerdDed);

            }
            //--------------------------------pagosaextranjeros
            if (datosRetenciones.pagosaextranjeros.activo == "true")
            {
                comprobante.Complemento.pagosaextranjeros = new Pagosaextranjeros();
                comprobante.Complemento.pagosaextranjeros.EsBenefEfectDelCobro = new PagosaextranjerosEsBenefEfectDelCobro();
                if (datosRetenciones.pagosaextranjeros.EsBenefEfectDelCobro == "SI")
                {
                    comprobante.Complemento.pagosaextranjeros.EsBenefEfectDelCobro = PagosaextranjerosEsBenefEfectDelCobro.SI;
                    comprobante.Complemento.pagosaextranjeros.Beneficiario = new PagosaextranjerosBeneficiario();
                    comprobante.Complemento.pagosaextranjeros.Beneficiario.ConceptoPago = datosRetenciones.pagosaextranjeros.BeneficiarioConceptoPago;
                    comprobante.Complemento.pagosaextranjeros.Beneficiario.CURP = datosRetenciones.pagosaextranjeros.CURP;
                    comprobante.Complemento.pagosaextranjeros.Beneficiario.DescripcionConcepto = datosRetenciones.pagosaextranjeros.BeneficiarioDescripcionConcepto;
                    comprobante.Complemento.pagosaextranjeros.Beneficiario.NomDenRazSocB = datosRetenciones.pagosaextranjeros.NomDenRazSocB;
                    comprobante.Complemento.pagosaextranjeros.Beneficiario.RFC = datosRetenciones.pagosaextranjeros.RFC;
                
                }
                else
                {
                    comprobante.Complemento.pagosaextranjeros.EsBenefEfectDelCobro = PagosaextranjerosEsBenefEfectDelCobro.NO;
                    comprobante.Complemento.pagosaextranjeros.NoBeneficiario = new  PagosaextranjerosNoBeneficiario();
                    comprobante.Complemento.pagosaextranjeros.NoBeneficiario.ConceptoPago = datosRetenciones.pagosaextranjeros.ConceptoPago;
                    comprobante.Complemento.pagosaextranjeros.NoBeneficiario.DescripcionConcepto = datosRetenciones.pagosaextranjeros.DescripcionConcepto;
                    comprobante.Complemento.pagosaextranjeros.NoBeneficiario.PaisDeResidParaEfecFisc = datosRetenciones.pagosaextranjeros.PaisDeResidParaEfecFisc;

                }

            }
            //--------------------------------planesderetiro
            if (datosRetenciones.planesderetiro.activo == "true")
            {
                comprobante.Complemento.planesderetiro = new Planesderetiro();
                comprobante.Complemento.planesderetiro.SistemaFinanc = new PlanesderetiroSistemaFinanc();
                if (datosRetenciones.planesderetiro.SistemaFinanc=="SI")
                    comprobante.Complemento.planesderetiro.SistemaFinanc = PlanesderetiroSistemaFinanc.SI;
                else
                    comprobante.Complemento.planesderetiro.SistemaFinanc = PlanesderetiroSistemaFinanc.NO;

                if (!string.IsNullOrEmpty(datosRetenciones.planesderetiro.MontTotAportAnioInmAnterior))
                {
                    comprobante.Complemento.planesderetiro.MontTotAportAnioInmAnteriorSpecified = true;
                    comprobante.Complemento.planesderetiro.MontTotAportAnioInmAnterior =Convert.ToDecimal( datosRetenciones.planesderetiro.MontTotAportAnioInmAnterior);
                }else
                comprobante.Complemento.planesderetiro.MontTotAportAnioInmAnteriorSpecified = false;
                comprobante.Complemento.planesderetiro.MontIntRealesDevengAniooInmAnt = Convert.ToDecimal(datosRetenciones.planesderetiro.MontIntRealesDevengAniooInmAnt);
                comprobante.Complemento.planesderetiro.HuboRetirosAnioInmAntPer = new PlanesderetiroHuboRetirosAnioInmAntPer();
                if (datosRetenciones.planesderetiro.HuboRetirosAnioInmAntPer == "SI")
                    comprobante.Complemento.planesderetiro.HuboRetirosAnioInmAntPer = PlanesderetiroHuboRetirosAnioInmAntPer.SI;
                else
                    comprobante.Complemento.planesderetiro.HuboRetirosAnioInmAntPer = PlanesderetiroHuboRetirosAnioInmAntPer.NO;
                if (!string.IsNullOrEmpty(datosRetenciones.planesderetiro.MontTotRetiradoAnioInmAntPer))
                {
                    comprobante.Complemento.planesderetiro.MontTotRetiradoAnioInmAntPer = Convert.ToDecimal(datosRetenciones.planesderetiro.MontTotRetiradoAnioInmAntPer);
                    comprobante.Complemento.planesderetiro.MontTotRetiradoAnioInmAntPerSpecified = true;
                }
                else
                    comprobante.Complemento.planesderetiro.MontTotRetiradoAnioInmAntPerSpecified =false;

                if (!string.IsNullOrEmpty(datosRetenciones.planesderetiro.MontTotExentRetiradoAnioInmAnt))
                {
                    comprobante.Complemento.planesderetiro.MontTotExentRetiradoAnioInmAntSpecified = true;
                    comprobante.Complemento.planesderetiro.MontTotExentRetiradoAnioInmAnt = Convert.ToDecimal(datosRetenciones.planesderetiro.MontTotExentRetiradoAnioInmAnt);
                }
                else
                    comprobante.Complemento.planesderetiro.MontTotExentRetiradoAnioInmAntSpecified = false;

                if (!string.IsNullOrEmpty(datosRetenciones.planesderetiro.MontTotExedenteAnioInmAnt))
                {
                    comprobante.Complemento.planesderetiro.MontTotExedenteAnioInmAntSpecified = true;

                    comprobante.Complemento.planesderetiro.MontTotExedenteAnioInmAnt = Convert.ToDecimal(datosRetenciones.planesderetiro.MontTotExedenteAnioInmAnt);
                }else
                    comprobante.Complemento.planesderetiro.MontTotExedenteAnioInmAntSpecified = false;

                comprobante.Complemento.planesderetiro.HuboRetirosAnioInmAnt = new PlanesderetiroHuboRetirosAnioInmAnt();
                if (datosRetenciones.planesderetiro.HuboRetirosAnioInmAnt == "SI")
                    comprobante.Complemento.planesderetiro.HuboRetirosAnioInmAnt = PlanesderetiroHuboRetirosAnioInmAnt.SI;
                else
                    comprobante.Complemento.planesderetiro.HuboRetirosAnioInmAnt = PlanesderetiroHuboRetirosAnioInmAnt.NO;
                if (!string.IsNullOrEmpty(datosRetenciones.planesderetiro.MontTotRetiradoAnioInmAnt))
                {
                    comprobante.Complemento.planesderetiro.MontTotRetiradoAnioInmAntSpecified = true;
                    comprobante.Complemento.planesderetiro.MontTotRetiradoAnioInmAnt = Convert.ToDecimal(datosRetenciones.planesderetiro.MontTotRetiradoAnioInmAnt);

                }
                else
                     comprobante.Complemento.planesderetiro.MontTotRetiradoAnioInmAntSpecified = false;
                if (!string.IsNullOrEmpty( datosRetenciones.planesderetiro.NumReferencia))
                comprobante.Complemento.planesderetiro.NumReferencia = datosRetenciones.planesderetiro.NumReferencia;
               
                if (datosRetenciones.planesderetiro.AportacionesODepositos != null)
                {
                    if (datosRetenciones.planesderetiro.AportacionesODepositos.Count>0)
                    {
                        //comprobante.Complemento.planesderetiro.AportacionesODepositos = new List<PlanesderetiroAportacionesODepositos>();
                        List<PlanesderetiroAportacionesODepositos> AOD = new List<PlanesderetiroAportacionesODepositos>();
                        foreach (var d in datosRetenciones.planesderetiro.AportacionesODepositos)
                        {
                            PlanesderetiroAportacionesODepositos pla = new PlanesderetiroAportacionesODepositos();
                            pla.MontAportODep = Convert.ToDecimal(d.MontAportODep);
                            pla.RFCFiduciaria = d.RFCFiduciaria;
                            if (d.TipoAportacionODeposito=="a")
                            pla.TipoAportacionODeposito =c_TipoAportODep.a;
                            if (d.TipoAportacionODeposito == "b")
                                pla.TipoAportacionODeposito = c_TipoAportODep.b;
                            if (d.TipoAportacionODeposito == "c")
                                pla.TipoAportacionODeposito = c_TipoAportODep.c;
                            AOD.Add(pla);
                        }

                        comprobante.Complemento.planesderetiro.AportacionesODepositos = AOD.ToArray();
                    }
                }
            }
            //--------------------------------premios
            if (datosRetenciones.premios.activo == "true")
            {
                comprobante.Complemento.premios = new Premios();
                comprobante.Complemento.premios.EntidadFederativa = datosRetenciones.premios.EntidadFederativa;
                comprobante.Complemento.premios.MontTotPago = Convert.ToDecimal(datosRetenciones.premios.MontTotPago);
                comprobante.Complemento.premios.MontTotPagoExent = Convert.ToDecimal(datosRetenciones.premios.MontTotPagoExent);
                comprobante.Complemento.premios.MontTotPagoGrav = Convert.ToDecimal(datosRetenciones.premios.MontTotPagoGrav);
            }
            //--------------------------------sectorFinanciero
            if (datosRetenciones.sectorFinanciero.activo == "true")
            {
                comprobante.Complemento.sectorFinanciero = new SectorFinanciero();
                comprobante.Complemento.sectorFinanciero.DescripFideicom = datosRetenciones.sectorFinanciero.DescripFideicom;
                comprobante.Complemento.sectorFinanciero.IdFideicom = datosRetenciones.sectorFinanciero.IdFideicom;
                if (!string.IsNullOrEmpty(datosRetenciones.sectorFinanciero.NomFideicom))
                    comprobante.Complemento.sectorFinanciero.NomFideicom = datosRetenciones.sectorFinanciero.NomFideicom;
                

            }


            return comprobante;
        }

        private static void EnviaCorreo(Retenciones comprobante, empresa empresa, clientes cliente, string uuid, byte[] pdf)
        {
            try
            {
                Logger.Debug("Enviar Correo");
                byte[] xmlBytes = Encoding.UTF8.GetBytes(comprobante.XmlString);
                var atts = new List<EmailAttachment>
                {
                    new EmailAttachment
                    {
                        Attachment = xmlBytes,
                        Name = uuid + ".xml"
                    },
                    new EmailAttachment
                    {
                        Attachment = pdf,
                        Name = uuid + ".pdf"
                    }
                };

                Mailer m = new Mailer();
                if (cliente.Bcc != null)
                    m.Bcc = cliente.Bcc;
                List<string> emails = new List<string>();
                emails.Add(cliente.Email);

                m.Send(emails, atts,
                    "Se envia la constacia de retenciones con folio " + uuid +
                    " en formato XML y PDF.",
                    "Envio de Constancia de retenciones", empresa.Email, empresa.RazonSocial);
            }
            catch (Exception ee)
            {
                Logger.Error(ee.Message);
                if (ee.InnerException != null)
                    Logger.Error(ee.InnerException);
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
                    var sis = db.Sistemas.FirstOrDefault(p => p.IdSistema == idSistema);
                    if (sis.SaldoEmision <= 0)
                    {
                        throw new Exception("No cuentas con saldo suficiente para realizar esta operación, comunícate con el departamento de ventas");
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

        public bool Save(long Idsistema)
        {
            try
            {
                using (var db = new NtLinkLocalServiceEntities())
                {
                   //SE AGREGA PARA CONTAR EL FOLIO  

                    var ee = db.Sistemas.FirstOrDefault(p => p.IdSistema == Idsistema);
                        ee.SaldoEmision = ee.SaldoEmision - 1;
                        ee.ConsumoEmision = ee.ConsumoEmision + 1;
                        db.SaveChanges();
                    

                    db.Retencion.AddObject(this.Retencion);
                    db.SaveChanges();

                    foreach (RetencionesItem item in this.Items)
                    {
                        item.Retenciones = this.Retencion.Id;
                        db.RetencionesItem.AddObject(item);
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

       

    }
}
