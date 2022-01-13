using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.Text;
using log4net;
using log4net.Config;
using ServicioLocal.Business;
using ServicioLocalContract;
using System.Text.RegularExpressions;
using System.Web.Security;
using ServicioLocalContract.Entities;
using System.IO;
using System.Xml;
using ServicioLocal.Business.Retenciones;
using CatalogosSAT;
using ServicioLocalContract.entities;

namespace ServicioLocalWeb
{
    // NOTA: puede usar el comando "Rename" del menú "Refactorizar" para cambiar el nombre de clase "ServicioLocalWEB" en el código, en svc y en el archivo de configuración a la vez.
     [AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
    public class ServicioLocalWEB : NtLinkBusiness,IServicioLocalWEB 
    {
       //static  private string UUDI {get;set;}

       //  public string GetUUDI()
       //  {
       //      return UUDI;
       //  }

        public void SetFinSession(string Session)
        {
            Logger.Error("Excedio el limite de tiempo de inactividad, fin de Sesion: " + Session);
        }
        
        public void GetIP(string ip)
        {
            IPCliente.GetIP(ip);
        }
        public string GetConsultaEstatusCFDI(string cadena)
        {
            var cliente = new ClienteNtLink.ClienteTimbradoNtlink();
            string respuesta = cliente.ConsultaEstatusCfdi(cadena);

            return respuesta;
        }

        public byte[] AcuseCancelacion(string reporte, Int64 idVenta, string estatus, string estatusCancela, string EstatusCancelacion)
        {
            return NtLinkFactura.GetAcuseCancelacion("/" + reporte, idVenta, estatus, estatusCancela, EstatusCancelacion);

        }

        public bool EliminarCliente(clientes cliente)
        {
            var nlc = new NtLinkClientes();
            return nlc.EliminarCliente(cliente);
        }
        
        public List<Contratos> ListaContratos(int idSistema)
        {
            var nls = new NtLinkSistema();
            return nls.ListaContratos(idSistema);
        }

        public List<c_ClaveProdServ> Consultar_ClaveProdServAll()
        {
            OperacionesCatalogos Op = new OperacionesCatalogos();
            return Op.Consultar_ClaveProdServAll();
        }
        public List<c_ClaveUnidadPeso> Consultar_ClaveUnidadPeso_ALL()
        {
            OperacionesCatalogos Op = new OperacionesCatalogos();
            return Op.Consultar_ClaveUnidadPeso_ALL();
        }
      

        public List<CatalogosSAT.c_ClaveUnidad> ConsultarClaveUnidadAll()
        {
            OperacionesCatalogos Op = new OperacionesCatalogos();
            return Op.ConsultarClaveUnidadAll();
        }
        public List<CatalogosSAT.c_Moneda> Consultar_MonedaAll()
        {
            OperacionesCatalogos Op = new OperacionesCatalogos();
            return Op.Consultar_MonedaAll();
        }
        public List<c_Estado> Consultar_EstadosPais(string pais)
        {

            OperacionesCatalogos Op = new OperacionesCatalogos();
            return Op.Consultar_EstadosPais(pais);
        }

        public CatalogosSAT.Divisas Consultar_TipoDivisa(string pais)
        {
            OperacionesCatalogos Op = new OperacionesCatalogos();
            return Op.Consultar_TipoDivisa(pais);
        }

        public CatalogosSAT.c_Moneda Consultar_Moneda(string moneda)
        {
            CatalogosSAT.OperacionesCatalogos o9 = new CatalogosSAT.OperacionesCatalogos();
            return o9.Consultar_Moneda(moneda);
        }
    
         public List<CatalogosSAT.c_TasaOCuota> Consultar_TasaCuota(string Impu, string tipoFactor, string tipoReteTras, ref bool rango)
        {
            OperacionesCatalogos O = new OperacionesCatalogos();
            return O.Consultar_TasaCuota(Impu, tipoFactor, tipoReteTras, ref rango);

        
        }


        public List<ElementoDist> ListaDisContratos(int idDistribuidor)
        {
            var ld = new NtLinkDistribuidor();
            return ld.ListaDisContratos(idDistribuidor);
        }

        public List<Distribuidores> ListaDistribuidores()
        {
            var nld = new NtLinkDistribuidor();
            return nld.ListaDistribuidores();
        }

        public DistContratos Contratos(int idContrato)
        {
            var nld = new NtLinkDistribuidor();
            return nld.Contratos(idContrato);
        }

        public void GuardarContrato(Contratos contrato)
        {
            var nls = new NtLinkSistema();
            nls.GuardarContrato(contrato);
        }

        public string Confirmar(string Confirmar, Int64 IdTimbre)
        {
            NtLinkVentas ventas = new NtLinkVentas();

            return ventas.Confirmacion(Confirmar, IdTimbre);
        }

        public void GuardarDisContrato(DistContratos contrato)
        {
            var nls = new NtLinkSistema();
            nls.GuardarDisContrato(contrato);
        }

        public int ObtenerNumeroTimbresSistema(int idSistema)
        {
            var nls = new NtLinkSistema();
            return nls.ObtenerNumeroTimbres(idSistema);
        }

        public int ObtenerNumeroTimbresEmpresa(int idEmpresa)
        {
            NtLinkEmpresa emp = new NtLinkEmpresa();
            return emp.ObtenerNumeroTimbres(idEmpresa);
        }
        public empresa GetByRFCEMPRESA(string rfc)
        {
            NtLinkEmpresa emp = new NtLinkEmpresa();
            return emp.GetByRFCEMPRESA(rfc);
        
        }

        public void EnviarFactura(string rfc, string folioFiscal, List<string> rec, List<string> bcc)
        {
            NtLinkFactura nlf = new NtLinkFactura(0);
            nlf.EnviarFactura(rfc, folioFiscal, rec, bcc);
        }

        public string CancelarFactura(string rfcEmisor,string motivo ,string folioSustituto, string folioFiscal, string expresion, string rfcReceptor)
        {
            try
            {
                var cliente = new ClienteNtLink.ClienteTimbradoNtlink();
                string respuesta = cliente.CancelaCfdi(folioFiscal,motivo,folioSustituto, rfcEmisor,expresion,rfcReceptor);
                if (respuesta.StartsWith("<?xml version=\"1.0\"?>"))
                {
                    NtLinkFactura fact = new NtLinkFactura(0);

                    fact.CancelarFactura(folioFiscal, respuesta);

                    return "Comprobante Cancelado correctamente";
                }
                throw new FaultException("Error al cancelar el comprobante, " + respuesta);
            }
            catch (FaultException fe)
            {
                throw;
            }
            catch (Exception ex)
            {
                Logger.Error(ex);
                return "Error al cancelar el comprobante";
            }
        }

        public string CancelarRetencion(string rfc, string folioFiscal)
        {
            try
            {
                var cliente = new ClienteNtLink.ClienteTimbradoNtlink();
                string respuesta = cliente.CancelaRetencion(folioFiscal, rfc);

                // string respuesta=@"<?xml version='1.0'?><Acuse xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' Fecha='2016-03-08T15:45:53.4254568' RfcEmisor='NLC091211KC6' WorkProcessId='1f7d2c8f-29a4-41ee-8de8-d1eb3f533151' xmlns='http://www.sat.gob.mx/esquemas/retencionpago/1'><Folios><UUID>63FF5874-80DB-4673-8EC3-8987E520A686</UUID><EstatusUUID>1201</EstatusUUID></Folios><Signature Id='SelloSAT' xmlns='http://www.w3.org/2000/09/xmldsig#'><SignedInfo><CanonicalizationMethod Algorithm='http://www.w3.org/TR/2001/REC-xml-c14n-20010315' /><SignatureMethod Algorithm='http://www.w3.org/2001/04/xmldsig-more#hmac-sha512' /><Reference URI=''><Transforms><Transform Algorithm='http://www.w3.org/TR/1999/REC-xpath-19991116'><XPath>not(ancestor-or-self::*[local-name()='Signature'])</XPath></Transform></Transforms><DigestMethod Algorithm='http://www.w3.org/2001/04/xmlenc#sha512' /><DigestValue>SgtL3dyxvIknYhUwF11uFkYJHZyzfGwcMo+gOsISyiGxQIXarr61jhmZu9coO/tkjW8y4NQHayrMoxsAhpHXWg==</DigestValue></Reference></SignedInfo><SignatureValue>Ssdwvv8QzhohhuBwFNMM7UYZQfVBxfq2F1sJ58mWADS4J+0w2vFIvk5h3Sh8tcL3dOt73XyJHRZzZHY0XfUPcw==</SignatureValue><KeyInfo><KeyName>00001088888800000016</KeyName><KeyValue><RSAKeyValue><Modulus>xnL2zDPtH5jDsAZDTIfMqbKGrve+At8Kyx2EZvbfXbpK9uVExWS874oMelFzNq69/YqSReT3I7I8wr+joy5O7ouZH+4KWdIGp4Si6lHe0kntxzNmuuKyOPkJ9tMcntnFmQ4bfxFxlg/Ud2hCtuoy3j2xYkIXu5O4pGM98Nz8pAM=</Modulus><Exponent>AQAB</Exponent></RSAKeyValue></KeyValue></KeyInfo></Signature></Acuse>";


                if (respuesta.StartsWith("<?xml version=\"1.0\"?>"))
                {
                    NtLinkFactura fact = new NtLinkFactura(0);

                    fact.CancelarRetencion(folioFiscal, respuesta);

                    return "Comprobante Cancelado correctamente";
                }
                throw new FaultException("Error al cancelar el comprobante, " + respuesta);
            }
            catch (FaultException fe)
            {
                throw;
            }
            catch (Exception ex)
            {
                Logger.Error(ex);
                return "Error al cancelar el comprobante";
            }
        }

        public List<Logger> LogLco()
        {
            LcoLogic lco = new LcoLogic();
            var logs = lco.GetLogsLco();
            return logs;
        }

        public vventas GetFactura(int idFactura)
        {
            NtLinkVentas ventas = new NtLinkVentas();
            var lista = ventas.GetById(idFactura);
            Logger.Debug("Resultado: " + (lista == null));
            return lista;
        }
        public byte[] GetFacturaAcuse(string uuid, string RFC, string fecha )
        {
            NtLinkVentas ventas = new NtLinkVentas();
            var lista = ventas.GetFacturaAcuse(uuid, RFC, fecha);
            return lista;
        }
        public vventaRetenciones GetRetenciones(Int64 idFactura)
        {
            NtLinkVentas ventas = new NtLinkVentas();
            var lista = ventas.GetRetencionById(idFactura);
            Logger.Debug("Resultado: " + (lista == null));
            return lista;

        }

        public List<empresaPantalla> ObtenerPantallasPorIdEmpresa(int idEmpresa)
        {
            return new NtLinkEmpresa().GetPantallas(idEmpresa);
        }

        public bool ActualizarPantallasPorEmpresa(List<empresaPantalla> pantallas)
        {
            return new NtLinkEmpresa().SavePantallas(pantallas);
        }

        public bool GuardarConcepto(producto producto)
        {
            Logger.Debug(producto.Descripcion);
            NtLinkProducto prod = new NtLinkProducto();
            var res = prod.SaveProducto(producto);
            Logger.Debug(res);
            return res;
        }

        public bool TieneConfiguradoCertificado(int idEmpresa)
        {
            return new NtLinkEmpresa().TieneConfiguradoCertificado(idEmpresa);
        }

        public UsuarioLocal LoginToken(string userName)
        {
            Logger.Debug("Login: " + userName);
            var x = NtLinkLogin.usuarioToken(userName);
            Logger.Debug(x != null);
            if (x != null)
            {
                NtLinkUsuarios us = new NtLinkUsuarios();
                var roles = NtLinkUsuarios.GetRolesForUser(userName);
                var profile = UserProfile.GetUserProfile(userName);

                return new UsuarioLocal
                {
                    Perfil = roles[0],
                    UserId = new Guid(x.ProviderUserKey.ToString()),
                    UserName = userName,
                    Bloqueado = x.IsLockedOut,
                    Email = x.Email,
                    NombreCompleto = profile.NombreCompleto,
                    Iniciales = profile.Iniciales,
                    CambiarPassword = profile.CambiarPassword
                };
            }

            return null;


        }



        public UsuarioLocal Login(string userName, string password, string ip)
        {
            
            Logger.Debug("IP Cliente: " + ip + ", Login: " + userName);
            
            var x = NtLinkLogin.ValidateUser(userName, password);
            //Logger.Debug(x != null);
            if (x != null)
            {
                Logger.Debug("Iniciando Sesion.....");
                NtLinkUsuarios us = new NtLinkUsuarios();
                var roles = NtLinkUsuarios.GetRolesForUser(userName);
                var profile = UserProfile.GetUserProfile(userName);
               
                return new UsuarioLocal
                {
                    Perfil = roles[0],
                    UserId = new Guid(x.ProviderUserKey.ToString()),
                    UserName = userName,
                    Bloqueado = x.IsLockedOut,
                    Email = x.Email,
                    NombreCompleto = profile.NombreCompleto,
                    Iniciales = profile.Iniciales,
                    CambiarPassword = profile.CambiarPassword,
                    FechaBloqueo=x.LastLockoutDate,
                   

                };
            }
            else
            {
                Logger.Debug("Fallo al iniciando Sesion.....");
                vw_aspnet_MembershipUsers bloqueado = NtLinkUsuarios.GetCountFalidos(userName);
         
                if (bloqueado != null)
                {
                    var tiempo = DateTime.SpecifyKind(DateTime.Parse(bloqueado.LastLockoutDate.ToString()), DateTimeKind.Utc).ToLocalTime();

                    return new UsuarioLocal
                    {
                        numeroBloaquedo = bloqueado.FailedPasswordAttemptCount.ToString(),
                        Bloqueado = bloqueado.IsLockedOut,

                        FechaBloqueo=tiempo
                    };
                }
                else
                    return null;
            }
            //return null;
        }



        public List<vventas> ListaCuentas(DateTime inicio, DateTime end, int idEmpresa, int idCliente, string status, string linea = null)
        {
            NtLinkVentas ventas = new NtLinkVentas();
            var lista = ventas.GetListCuentas(inicio, end, idEmpresa, status, idCliente, linea);
            Logger.Debug("Resultado: " + lista.Count + " regs.");
            return lista;
        }

        public List<vventas> ListaFacturas(DateTime inicio, DateTime end, int idEmpresa, int idCliente, string status,
            string linea = null, string iniciales = null)
        {
            NtLinkVentas ventas = new NtLinkVentas();
            var lista = ventas.GetList(inicio, end, idEmpresa, status, idCliente, linea, iniciales);
            Logger.Debug("Resultado: " + lista.Count + " regs.");
            return lista;
        }

        public List<vventaRetenciones> ListaRetenciones(DateTime inicio, DateTime end, int idEmpresa, int idCliente, string status,
           string linea = null)
        {
            NtLinkVentas ventas = new NtLinkVentas();
            var lista = ventas.GetListRetenciones(inicio, end, idEmpresa, status, idCliente, linea);
            Logger.Debug("Resultado: " + lista.Count + " regs.");
            return lista;
        }

        public List<ConfirmacionTimbreWs33> ListaConfirmacion( string idEmpresa, string idCliente)
        {
            NtLinkVentas ventas = new NtLinkVentas();
            var lista = ventas.GetListConfirmacion( idEmpresa, idCliente);
            Logger.Debug("Resultado: " + lista.Count + " regs.");
            return lista;
        }

        public List<empresa> ListaEmpresasPatron(string patron)
        {
            NtLinkEmpresa emp = new NtLinkEmpresa();
            return emp.GetListByPattern(patron);
        }


        public List<empresa> ListaEmpresas(string perfil, int idempresa, long idSistema, string linea = null)
        {
            NtLinkEmpresa emp = new NtLinkEmpresa();
            if (idempresa == 0)
            {
                var emps = emp.GetListForLine(linea);
                Logger.Debug("Resultado: " + emps.Count + " regs.");
                return emps;
            }
            else
            {
                var emps = emp.GetList(perfil, idempresa, idSistema);
                if (linea != null)
                {
                    emps = emps.Where(p => p.Linea == linea).ToList();
                }
                Logger.Debug("Resultado: " + emps.Count + " regs.");
                return emps;
            }


        }

        public empresa ObtenerEmpresaByUserId(string userId)
        {

            var empresa = NtLinkUsuarios.GetEmpresaByUserId(userId);
            if (empresa != null)
            {
                Logger.Debug(empresa.IdEmpresa);
                return empresa;
            }
            return null;
        }


        public Guid GetUserIdByEmpresa(int idempresa)
        {

            var empresa = NtLinkUsuarios.GetUserIdByEmpresa(idempresa);
            if (empresa != null)
            {
                Logger.Debug(empresa.UserId);
                return empresa.UserId;
            }
            return empresa.UserId;
        }


        public bool RecuperarPassword(string rfc, string email)
        {
            NtLinkUsuarios nlu = new NtLinkUsuarios();
            var res = nlu.RecuperarMail(rfc, email);
            Logger.Debug(res);
            return res;
        }

        public bool RecuperarPasswordAdministracion(string email)
        {
            NtLinkUsuarios nlu = new NtLinkUsuarios();
            var res = nlu.RecuperarMailAdministracion(email);
            Logger.Debug(res);
            return res;
        }

        public string UsuarioById(Guid userId)
        {
            try
            {
                using (var db = new NtLinkLocalServiceEntities())
                {

                    var venta = db.aspnet_Membership.FirstOrDefault(p => p.UserId == userId);
                    return venta.LastLoginDate.ToString();
                }
            }
            catch (Exception ee)
            {
                return null;
                throw new FaultException("Ocurrió un error de comunicación");
            }
        }

        public UsuarioLocal ObtenerUsuarioById(string userId)
        {
            var usuario = NtLinkUsuarios.GetUser(userId);
            NtLinkUsuarios us = new NtLinkUsuarios();
            var roles = NtLinkUsuarios.GetRolesForUser(usuario.UserName);
            Logger.Debug(usuario.ProviderUserKey);
            UserProfile p = UserProfile.GetUserProfile(usuario.UserName);
            return new UsuarioLocal
            {
                Perfil = roles[0],
                UserId = new Guid(usuario.ProviderUserKey.ToString()),
                UserName = usuario.UserName,
                NombreCompleto = p.NombreCompleto,
                Iniciales = p.Iniciales,
                Email = usuario.Email,
                CambiarPassword = p.CambiarPassword
            };

        }


        public List<clientes> ListaClientes(string perfil, int idEmpresa, string filtro, bool lista)
        {
            NtLinkClientes clientes = new NtLinkClientes();
            var list = clientes.GetList(perfil, idEmpresa, filtro, lista);
            list = list.Where(p => p.Tipo == 0).ToList();
            Logger.Debug("Resultado: " + list.Count + " regs.");
            if (lista)
                list.Add(new clientes { RazonSocial = "Todos", idCliente = 0, Tipo = 0 });

            return list;
        }

        public List<clientes> ListaEmpleados(string perfil, int idEmpresa, string filtro, bool lista)
        {
            NtLinkClientes clientes = new NtLinkClientes();
            var list = clientes.GetList(perfil, idEmpresa, filtro, lista);
            Logger.Debug("Resultado: " + list.Count + " regs.");
            list = list.Where(p => p.Tipo == 1).ToList();
            return list;
        }
        public facturas GetSelloEmisor(string uudi)
        {
            using (var db = new NtLinkLocalServiceEntities())
            {

                var venta = db.facturas.FirstOrDefault(p => p.Uid == uudi);
                return venta;
            }
        }

        public List<clientes> ListaClientesGaf(string linea)
        {
            NtLinkClientes clientes = new NtLinkClientes();
            var list = clientes.GetList(linea);
            Logger.Debug("Resultado: " + list.Count + " regs.");
            return list;
        }

        public bool GuardarListaFacturas(List<vventas> lista)
        {
            NtLinkVentas ventas = new NtLinkVentas();
            var res = ventas.SaveList(lista);
            Logger.Debug(res);
            return res;
        }

        public byte[] FacturaXml(string uuid)
        {
            return NtLinkFactura.GetXmlData(uuid);
        }

        public byte[] FacturaPdf(string uuid)
        {
            return NtLinkFactura.GetPdfData(uuid);
        }
        public byte[] RetencionPdfXML(string uuid, string rfc, string tipo)
        {
            return NtLinkFactura.GetPdfDataRetenciones(uuid, rfc, tipo);
        }  

        public  byte[] GetPdfDataRetenciones(string uuid,int idEmpresa, string tipo)
          {
          return NtLinkFactura.GetPdfDataRetenciones( uuid, idEmpresa,  tipo);
        }

        //public byte[] FacturaXml(int idVenta)
        // {
        //     throw new NotImplementedException();
        // }

        //public byte[] FacturaPdf(int idVenta)
        //{
        //    throw new NotImplementedException();
        //}

        public int GuardarCliente(clientes cliente)
        {
            //Regex inv = new Regex("^([0-9a-zA-Z]([-.\\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\\w]*[0-9a-zA-Z]\\.)+[a-zA-Z]{2,9})$");
            Regex inv = new Regex(@"^[_a-zA-Z0-9-]+(\.[_a-zA-Z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,3})$");

            Regex curpx = new Regex("[A-Z]{4}[0-9]{6}[H,M][A-Z]{5}[0-9]{2}");

            if (!string.IsNullOrEmpty(cliente.CURP))
                if (!curpx.IsMatch(cliente.CURP))
                {
                    throw new FaultException("Curp incorrecto");

                }


            if (!inv.IsMatch(cliente.Email))
            {
                throw new FaultException("Email incorrecto");
            }
            NtLinkClientes c = new NtLinkClientes();
            var res = c.SaveCliente(cliente);
            Logger.Debug(res);
            return res;
        }

        public bool GuardarEmpresa(empresa empresa, byte[] cert, byte[] llave, string passwordLlave, byte[] logo, string formatoLlave)
        {
            bool result;
            NtLinkEmpresa nle = new NtLinkEmpresa();
            if (cert == null || llave == null)
            {
                result = nle.Save(empresa, logo);
            }
            else
            {
                result = nle.Save(empresa, cert, llave, passwordLlave, logo, formatoLlave);
            }
            Logger.Debug(result);
            return result;
        }

        public string SiguienteFolioFactura(int idEmpresa)
        {
            var result = NtLinkFactura.GetNextFolio(idEmpresa);
            Logger.Debug(result);
            return result;

        }

        public string TipoCambio()
        {
            var res = NtLInkTipoCambio.GetTipoCambioUsd();
            Logger.Debug(res);
            return res;
        }
        public List<c_ClaveProdServ> BuscarClaveProdServSearch(string query)
        {
            try
            {
                OperacionesCatalogos prod = new OperacionesCatalogos();
                var result = prod.ClaveProdServSearch(query);
                Logger.Debug("Resultado: " + result.Count + " regs.");
                return result;
            }
            catch (Exception ee)
            {
                Logger.Error(ee.Message);
                throw new FaultException("Ocurrió un error de comunicación");
            }

        }

        public List<producto> BuscarProducto(string query, int idEmpresa)
        {
            try
            {
                NtLinkProducto prod = new NtLinkProducto();
                var result = prod.ProductSearch(query, idEmpresa);
                Logger.Debug("Resultado: " + result.Count + " regs.");
                return result;
            }
            catch (Exception ee)
            {
                Logger.Error(ee.Message);
                throw new FaultException("Ocurrió un error de comunicación");
            }

        }

        public producto ObtenerProductoById(int id)
        {
            return new NtLinkProducto().GetProduct(id);
        }
        public c_ClaveProdServ ObtenerClaveProdServById(int id)
        {
            OperacionesCatalogos OP = new OperacionesCatalogos();
            return OP.Consultar_ClaveProdServ(id);
        }
        public List<c_Estado> Consultar_EstadosALL()
        {
            OperacionesCatalogos OP = new OperacionesCatalogos();
            return OP.Consultar_EstadosALL();
        }
        public List<c_Municipio> Consultar_MunicipioALL(string estado)
        {
            OperacionesCatalogos OP = new OperacionesCatalogos();
            return OP.Consultar_MunicipioALL(estado);
        }
        public List<c_Localidad> Consultar_LocalidadALL(string E)
        {
            OperacionesCatalogos OP = new OperacionesCatalogos();
            return OP.Consultar_LocalidadALL(E);
        
        }
        public List<c_CP> Consultar_CPALL(string estado, string municipio)
        {
            OperacionesCatalogos OP = new OperacionesCatalogos();
            return OP.Consultar_CPALL( estado,  municipio);
        }
        public List<CatalogosSAT.c_Pais> Consultar_PaisAll()
        {
            OperacionesCatalogos OP = new OperacionesCatalogos();
            return OP.Consultar_Pais_ALL();
    
         
        }
        public RetornoServicio GuardarFactura33(facturas fact, List<facturasdetalle> detalles,List<facturasdetalle33> detalles33,
            bool enviar, facturaComplementos complementosF, List<facturasdetalle> conceptosAduana)
        {

            RetornoServicio resul = new RetornoServicio();

            Logger.Debug(fact.Folio);
            NtLinkClientes nlc = new NtLinkClientes();
            clientes cliente = nlc.GetCliente(fact.idcliente);
            NtLinkEmpresa emp = new NtLinkEmpresa();
            empresa empresa = emp.GetById(fact.IdEmpresa.Value);
            NtLinkFactura fac = new NtLinkFactura(0);
            if (string.IsNullOrEmpty(empresa.RegimenFiscal))
            {
                throw new FaultException("Debes capturar el regimen fiscal de la empresa");
            }
            fact.Regimen = empresa.RegimenFiscal;
            fac.Emisor = empresa;
            fac.Receptor = cliente;
            fac.Detalles = detalles;
            fac.Factura = fact;
            fact.ConceptosAduanera = conceptosAduana;
            
            
            foreach (var d33 in detalles33)
            {
                foreach (var d in fac.Detalles)
                {
                    if(d.Partida.ToString()==d33.partida)
                    {
                       d.ConceptoRetenciones = d33.ConceptoRetenciones;
                       d.ConceptoTraslados = d33.ConceptoTraslados;
                       d.NumeroPedimento = d33.NumeroPedimento;
                    }
                }
            }
           
                        
            
            Comprobante cfd = NtLinkFactura.GeneraCfd(fac, enviar, complementosF);
            resul.resultado = false;

            if (cfd != null)
            {
                resul.resultado = true;
                resul.UUDI = cfd.Complemento.timbreFiscalDigital.UUID;
                //UUDI = cfd.Complemento.timbreFiscalDigital.UUID;
                fac.Factura.Uid = cfd.Complemento.timbreFiscalDigital.UUID;
                fac.Factura.SelloCFD = cfd.Sello;
                //fac.Factura.
                fac.Save();
                //VERIFY SAVE ID VENTA IN CARTA PORTE
                if (fact.ConceptosCartaPortes != null && fact.TipoDocumento == TipoDocumento.CartaPorte)
                {
                    using (var db = new NtLinkLocalServiceEntities())
                    {

                        if (fact.ConceptosCartaPortes.Count > 0)
                        {
                            long temporal = fact.ConceptosCartaPortes[0].idComprobantePdf;
                            var tempCompareCartaPorte = from p in db.ConceptosCartaPorte
                                                        where p.idComprobantePdf == temporal
                                                        select p;
                            foreach (var conceptosCartaPorte in tempCompareCartaPorte)
                            {
                                conceptosCartaPorte.idVenta = fact.idVenta;
                            }
                            db.SaveChanges();
                        }

                    }
                }
                return resul;
            }
            return resul;
        }

        public bool GuardarFactura(facturas fact, List<facturasdetalle> detalles, bool enviar, List<facturasdetalle> conceptosAduana)
        {
            Logger.Debug(fact.Folio);
            NtLinkClientes nlc = new NtLinkClientes();
            clientes cliente = nlc.GetCliente(fact.idcliente);
            NtLinkEmpresa emp = new NtLinkEmpresa();
            empresa empresa = emp.GetById(fact.IdEmpresa.Value);
            NtLinkFactura fac = new NtLinkFactura(0);
            if (string.IsNullOrEmpty(empresa.RegimenFiscal))
            {
                throw new FaultException("Debes capturar el regimen fiscal de la empresa");
            }
            fact.Regimen = empresa.RegimenFiscal;
            fac.Emisor = empresa;
            fac.Receptor = cliente;
            fac.Detalles = detalles;
            fac.Factura = fact;
            fact.ConceptosAduanera = conceptosAduana;



            Comprobante cfd = NtLinkFactura.GeneraCfd(fac, enviar,null);
            if (cfd != null)
            {
                fac.Factura.Uid = cfd.Complemento.timbreFiscalDigital.UUID;
                fac.Save();
                //VERIFY SAVE ID VENTA IN CARTA PORTE
                if (fact.ConceptosCartaPortes != null && fact.TipoDocumento == TipoDocumento.CartaPorte)
                {
                    using (var db = new NtLinkLocalServiceEntities())
                    {

                        if (fact.ConceptosCartaPortes.Count > 0)
                        {
                            long temporal = fact.ConceptosCartaPortes[0].idComprobantePdf;
                            var tempCompareCartaPorte = from p in db.ConceptosCartaPorte
                                                        where p.idComprobantePdf == temporal
                                                        select p;
                            foreach (var conceptosCartaPorte in tempCompareCartaPorte)
                            {
                                conceptosCartaPorte.idVenta = fact.idVenta;
                            }
                            db.SaveChanges();
                        }

                    }
                }
                return true;
            }
            return false;
        }


        public byte[] VistaPreviaRet(Retencion retencion, IList<RetencionesItem> items, DatosRetenciones datosIntereses)
        {
            try
            {
                NtLinkRetenciones retManagement = new NtLinkRetenciones();
                retManagement.Retencion = retencion;
                retManagement.Items = items;

                var res = NtLinkRetenciones.GeneraCfdPreview(retencion, items, datosIntereses);//no envia las retenciones--

                return res;
            }

            catch (FaultException fe)
            {
                throw;
            }
            catch (Exception ee)
            {
                Logger.Error(ee);
                return null;
            }
        }
        public List<ActivacionConvertidor> GetLicenciaLista()
        {
            ValidadarActivador V = new ValidadarActivador();
            return V.GetLicenciaLista();
        }

        public int GuardaLicencia(ActivacionConvertidor licencia)
        {
            ValidadarActivador com = new ValidadarActivador();
            return com.Activar(licencia);
        }

        public RetornoServicio GuardarRetencion(Retencion retencion, IList<RetencionesItem> items, DatosRetenciones datosIntereses, bool enviar)
        {
            RetornoServicio rr= new RetornoServicio();
            NtLinkRetenciones retManagement = new NtLinkRetenciones();
            retManagement.Retencion = retencion;
            retManagement.Items = items;


            Retenciones cfd = NtLinkRetenciones.GeneraCfd(retencion, items, datosIntereses, enviar);

            if (cfd != null)
            {

                rr.UUDI = cfd.Complemento.timbreFiscalDigital.UUID;
                retManagement.Retencion.Uuid = cfd.Complemento.timbreFiscalDigital.UUID;
                //-----se agrego para contantar el saldo emision---------------------
                empresa empresa;
                using (var db = new NtLinkLocalServiceEntities())
                {
                    empresa = db.empresa.Single(l => l.IdEmpresa == retencion.Emisor);
                }

                var sistema = (int)empresa.idSistema.Value;
                //---------------------------------------------------------------------
                rr.resultado = retManagement.Save(sistema);
                return rr;//guarda la retencion
            }
            rr.resultado = false;
            return rr;
        }
        public byte[] FacturaPreview33(facturas fact, List<facturasdetalle> detalles,List<facturasdetalle33> detalles33,
            facturaComplementos complementosF, List<facturasdetalle> conceptosAduana)
          {
            Logger.Info("FacturaPreview");
            try
            {

                NtLinkClientes nlc = new NtLinkClientes();
                clientes cliente = nlc.GetCliente(fact.idcliente);
                NtLinkEmpresa emp = new NtLinkEmpresa();
                empresa empresa = emp.GetById(fact.IdEmpresa.Value);
                NtLinkFactura fac = new NtLinkFactura(0);
          
               // fac.Factura.ConceptosAduanera = conceptosAduana;
                fac.Factura.Regimen = empresa.RegimenFiscal;
                fac.Emisor = empresa;
                fac.Receptor = cliente;
                fac.Detalles = detalles;
                fac.Factura = fact;
                fact.ConceptosAduanera = conceptosAduana;

                foreach (var d33 in detalles33)
                {
                    foreach (var d in fac.Detalles)
                    {
                        if (d.Partida.ToString() == d33.partida)
                        {
                            d.ConceptoRetenciones = d33.ConceptoRetenciones;
                            d.ConceptoTraslados = d33.ConceptoTraslados;
                        }
                    }
                }
           
          

                //Comprobante cfd = NtLinkFactura.GeneraCfd(fac, enviar, complementosF);

                var cfd = NtLinkFactura.GeneraPreviewRs(fac, complementosF);
                return cfd;
            }
            catch (FaultException fe)
            {
                throw;
            }
            catch (Exception ee)
            {
                Logger.Error(ee);
                return null;
            }
        }

        public byte[] FacturaPreview(facturas fact, List<facturasdetalle> detalles, List<facturasdetalle> conceptosAduana)
        {
            Logger.Info("FacturaPreview");
            try
            {

                NtLinkClientes nlc = new NtLinkClientes();
                clientes cliente = nlc.GetCliente(fact.idcliente);
                NtLinkEmpresa emp = new NtLinkEmpresa();
                empresa empresa = emp.GetById(fact.IdEmpresa.Value);
                NtLinkFactura fac = new NtLinkFactura(0);
                fac.Emisor = empresa;
                fac.Receptor = cliente;
                fac.Detalles = detalles;
                fac.Factura = fact;
                fac.Factura.ConceptosAduanera = conceptosAduana;
                fac.Factura.Regimen = empresa.RegimenFiscal;

                var cfd = NtLinkFactura.GeneraPreviewRs(fac,null);
                return cfd;
            }
            catch (FaultException fe)
            {
                throw;
            }
            catch (Exception ee)
            {
                Logger.Error(ee);
                return null;
            }
        }

        public clientes ObtenerClienteById(int idCliente)
        {
            return new NtLinkClientes().GetCliente(idCliente);
        }

        public empresa ObtenerEmpresaById(int idEmpresa)
        {
            return new NtLinkEmpresa().GetById(idEmpresa);
        }

        public List<UsuarioLocal> UsuariosLista(int idEmpresa)
        {
            var usuarios = NtLinkUsuarios.GetUserList(idEmpresa);
            return usuarios.Select(p => new UsuarioLocal
            {
                Bloqueado = p.IsLockedOut,
                Email = p.Email,
                Perfil = (NtLinkUsuarios.GetRolesForUser(p.UserName).Any() ? NtLinkUsuarios.GetRolesForUser(p.UserName)[0] : ""),
                UserId = new Guid(p.ProviderUserKey.ToString()),
                UserName = p.UserName
            }).ToList();
        }

        public List<string> ObtenerPerfiles()
        {
            var perfiles = NtLinkUsuarios.GetRoles();
            Logger.Debug(perfiles.Length.ToString());
            return perfiles.ToList();
        }

        //public bool GuardarUsuario(string userName, string password, string eMail, int idEmpresa, string perfil, string nombreCompleto, string iniciales)

        public bool GuardarUsuario(string nombreCompleto, string eMail, string password, int idEmpresa, string perfil, string userName, string iniciales)
        {
            var res = NtLinkUsuarios.CreateUser(eMail, password, eMail, idEmpresa, perfil, nombreCompleto, iniciales);
            Logger.Debug(res);
            return res;
        }


        public void SendMail(List<string> recipients, List<string> attachments, string message, string subject, string fromEmail, string fromDescription)
        {
            Mailer m = new Mailer();
            m.Send(recipients, attachments, message, subject, fromEmail, fromDescription);
        }

        public void SendMailByteArray(List<string> recipients, List<EmailAttachment> attachments, string message, string subject, string fromEmail, string fromDescription)
        {
            Mailer m = new Mailer();
            m.Send(recipients, attachments, message, subject, fromEmail, fromDescription);
        }

        public List<TimbreWs> ObtenerTimbres(string rfc, DateTime inicial, DateTime final)
        {
            NtLinkTimbrado tim = new NtLinkTimbrado();
            return tim.ObtenerTimbres(rfc, inicial, final);
        }

        public void DescargaLco()
        {
            LcoLogic log = new LcoLogic();
            log.EjecutarTareaLco();
        }

        public void Pagarfactura(int idVenta, DateTime fechaPago, string referenciaPago)
        {
            NtLinkFactura.Pagar(idVenta, fechaPago, referenciaPago);
        }

        public List<ElementoReporte> ObtenerReporte(int mes, int anio)
        {
            return NtLinkReporte.ObtenerReporte(mes, anio);
        }

        public List<ElementoReporteMensual> ObtenerReporteMensual()
        {
            return NtLinkReporte.ObtenerReporteMensual();
        }
        public List<ElementoReporte> ObtenerReportePorCliente(int mes, int anio, int idSistema)
        {
            return NtLinkReporte.ObtenerReportePorCliente(mes, anio, idSistema);
        }


        public List<ElementoReporte> ObtenerReportePorEmisor(int mes, int anio, int idEmpresa)
        {
            return NtLinkReporte.ObtenerReportePorEmisor(mes, anio, idEmpresa);
        }

        public List<ElementoReporte> ObtenerReporteFullEmisor(int mes, int anio, int idSistema)
        {
            return NtLinkReporte.ObtenerReporteFullEmisor(mes, anio, idSistema);
        }

        public bool CambiarPassword(string userId, string password)
        {
            try
            {
                MembershipUser user = NtLinkUsuarios.GetUser(userId);
                var res = NtLinkUsuarios.UpdateUserPassword(user, password);
                empresa em = NtLinkUsuarios.GetEmpresaByUserId(userId);
                if (em != null)
                {
                    NtLinkEmpresa nle = new NtLinkEmpresa();
                    em.PrimeraVez = false;
                    nle.Save(em, null);
                }
                else
                {
                    Distribuidores dis = NtLinkUsuarios.GetDisByUserId(userId);
                    NtLinkDistribuidor nle = new NtLinkDistribuidor();
                    dis.PrimeraVez = false;
                    nle.Save(dis);
                }
                Logger.Debug(user + "->" + res);
                return res;
            }
            catch (FaultException ee)
            {
                Logger.Debug(ee);
                throw;
            }
            catch (Exception ee)
            {
                Logger.Debug(ee);
                return false;
            }

        }


        public List<Sucursales> ListaSucursales(int idEmpresa)
        {
            NtLinkSucursales suc = new NtLinkSucursales();
            return suc.GetSucursalLista(idEmpresa);

        }

        public List<Comisionistas> ListaComisionistas(int idEmpresa)
        {
            var com = new NtLinkComisionistas();
            return com.GetComisionistasLista(idEmpresa);
        }

        public Sucursales ObtenerSucursal(int idSucursal)
        {
            NtLinkSucursales suc = new NtLinkSucursales();
            return suc.GetSucursal(idSucursal);
        }

        public Comisionistas ObtenerComisionista(int idComisionista)
        {
            NtLinkComisionistas suc = new NtLinkComisionistas();
            return suc.GetComisionista(idComisionista);
        }

        public bool GuardaSucursal(Sucursales sucursal)
        {
            NtLinkSucursales suc = new NtLinkSucursales();
            return suc.SaveSucursal(sucursal);
        }

        public bool GuardaComisionista(Comisionistas comisionista)
        {
            NtLinkComisionistas com = new NtLinkComisionistas();
            return com.SaveComisionista(comisionista);
        }

        public Sistemas ObtenerSistema(string rfc)
        {
            NtLinkSistema sistema = new NtLinkSistema();
            return sistema.GetSistema(rfc);
        }

        public Sistemas ObtenerSistemaById(int idSistema, bool data = false)
        {
            NtLinkSistema sistema = new NtLinkSistema();
            return sistema.GetSistema(idSistema, data);
        }

        public List<Sistemas> ListaSistemas(string filtro, int ejecutivo = 0)
        {
            NtLinkSistema sistema = new NtLinkSistema();
            return sistema.GetSistemasLista(filtro, ejecutivo);
        }

        public List<ElementoCliente> ListaSistemasTimbre(string filtro)
        {
            NtLinkSistema sistema = new NtLinkSistema();
            return sistema.ListaSistemasTimbre(filtro);
        }

        public bool GuardarSistema(Sistemas sistema, ref string resultado, string nombreCompleto, string iniciales, int usu)
        {
            NtLinkSistema sis = new NtLinkSistema();
            return sis.SaveSistema(sistema, ref resultado, nombreCompleto, iniciales, usu);
        }

        public bool GuardarDistribuidor(Distribuidores distribuidor, ref string resultado, string nombreCompleto, string iniciales)
        {
            NtLinkDistribuidor dis = new NtLinkDistribuidor();
            return dis.SaveDistribuidor(distribuidor, ref resultado, nombreCompleto, iniciales);
        }

        public usuarios AdminLogin(string user, string password, string ip)
        {
            //  Logger.Debug("Login: " + user);
            Logger.Debug("IP Cliente: " + ip + ", Login: " + user);



            NtLinkUsuarios nlu = new NtLinkUsuarios();
            return nlu.LoginAdmin(user, password);
        }

        public List<UsuarioLocal> UsuariosObtenerLista(string patron)
        {
            try
            {

                var usuarios = new NtLinkUsuarios().ListaUsuarios(patron);
                return usuarios;

            }
            catch (Exception ex)
            {
                Logger.Error(ex.ToString());
                return null;
            }
        }

        public void DesbloquearUsuario(string userName)
        {
            NtLinkUsuarios.DesbloquearUsuario(userName);
        }


        public bool EditarUsuario(UsuarioLocal usuario)
        {
            try
            {
                var c = NtLinkUsuarios.UpdateUser(usuario.UserId.ToString(), usuario.NombreCompleto, usuario.Iniciales, usuario.Perfil);
                Logger.Debug(c);
                return c;
            }
            catch (Exception ee)
            {
                Logger.Error(ee);
                return false;
            }
        }

        public bool GuardarPromotores(Promotores promotor)
        {
            Logger.Debug(promotor.IdPromotor);
            NtLinkClientes promo = new NtLinkClientes();
            var save = promo.GuardarPromotor(promotor);
            Logger.Debug(save);
            return save;
        }

        public List<Promotores> ListaPromotores()
        {
            NtLinkClientes list = new NtLinkClientes();
            return list.ListaPromotores();
        }

        public Promotores ObtenerPromotor(int idPromotor)
        {
            NtLinkClientes NumProm = new NtLinkClientes();
            return NumProm.ObtenerPromotores(idPromotor);
        }

        public List<Promotores> ObtenerPromotores()
        {
            NtLinkClientes NumProm = new NtLinkClientes();
            return NumProm.ListaPromotores();
        }


        public List<vClientesPromotores> ListaClientesPromotores(int idCliente)
        {
            NtLinkClientes list = new NtLinkClientes();
            return list.ListaClientesPromotores(idCliente);
        }

        public bool GuardarClientesPromotores(int idCliente, int idPromotor)
        {
            NtLinkClientes guardar = new NtLinkClientes();
            return guardar.GuardarClientesPromotores(idCliente, idPromotor);
        }

        public bool BorrarClientesPromotores(int idCP)
        {
            NtLinkClientes borrar = new NtLinkClientes();
            return borrar.BorrarClientesPromotores(idCP);
        }


        public List<vClientesPromotores> ListaPromotoresClientes(int idCliente)
        {
            NtLinkClientes c = new NtLinkClientes();
            return c.ListaPromotoresClientes(idCliente);
        }


        public List<LogLco> GetLogLco()
        {
            LcoLogic getLco = new LcoLogic();
            return getLco.GetLogLco();
        }

        public List<producto> ListaProductoGaf(int idEmpresa, string texto)
        {
            NtLinkProducto ProductoGaf = new NtLinkProducto();
            return ProductoGaf.ListaProductoGaf(idEmpresa, texto);
        }

        public void UpdateDistribuidor(int idContrato)
        {
            NtLinkDistribuidor dis = new NtLinkDistribuidor();
            dis.UpdateDistribuidor(idContrato);
        }

        public List<ElementoCliente> ListaTimbrado(int id)
        {
            NtLinkSistema nls = new NtLinkSistema();
            return nls.ListaTimbrado(id);
        }

        public Distribuidores ObtenerDIsById(string userId)
        {
            var dis = NtLinkUsuarios.GetDisByUserId(userId);
            if (dis != null)
                Logger.Debug(dis.IdDistribuidor);
            return dis;
        }

        public string ValidarCSD(empresa empresa, byte[] cert, byte[] llave, string passwordLlave, string formatoLlave)
        {
            string result;
            NtLinkEmpresa nle = new NtLinkEmpresa();
            result = nle.ValidaCSD(empresa, cert, llave, passwordLlave, formatoLlave);
            Logger.Debug(result);
            return result;
        }
        //conecta a iserviciolocal  comision distribuidores con conexion ala base de datos
        public List<Comision_Distribuidores> listaComDis()
        {
            NtLinkDistribuidor Cm = new NtLinkDistribuidor();
            return Cm.listaComisiones();

        }

        //conect isserviciolocal 
        public List<Ctdistribuidores> lisDistribuidores()
        {
            NtLinkDistribuidor Ct = new NtLinkDistribuidor();
            return Ct.lisDistribuidores();

        }

        public List<vventas> ListaNomina(DateTime inicio, DateTime end, int idEmpresa, int idClientem, string status, string linea = null, string iniciales = null)
        {
            NtLinkVentas ventas = new NtLinkVentas();
            var lista = ventas.GetListNomina(inicio, end, idEmpresa, status, idClientem, linea, iniciales);
            Logger.Debug("Resultado: " + lista.Count + " regs.");
            return lista;
        }



        public DatosNomina ObtenerDatosNomina(int idCLiente)
        {
            NtLinkClientes clientes = new NtLinkClientes();
            var datos = clientes.GetDatosByCliente(idCLiente);

            return datos;
        }

        public bool SaveDatosNomina(DatosNomina datos)
        {
            NtLinkClientes clientes = new NtLinkClientes();
            var res = clientes.SaveDatosNomina(datos);
            Logger.Info(res);
            return res;
        }



        public ResultadoValidacion ValidarCfdi(string xmlContent)
        {
            try
            {
                Logger.Info("Validando: " + xmlContent);
                ValidadorCfdi val = new ValidadorCfdi();
                xmlContent = xmlContent.Replace("\ufeff", "");
                string version = null;
                using (var reader = new XmlTextReader(new StringReader(xmlContent)))
                {
                    while (reader.Read())
                    {
                        if (reader.LocalName == "Comprobante")
                        {
                            version = reader.GetAttribute("version");
                            break;
                        }
                    }
                }

                return val.Validar(xmlContent, version);
            }
            catch (Exception ee)
            {
                Logger.Error(ee);
                if (ee.InnerException != null)
                    Logger.Error(ee.InnerException);
                return new ResultadoValidacion() { Valido = false, Entrada = null };
            }

        }

        public bool SaveChangesNtLinkCartaPorte(ConceptosCartaPorte concepto)
        {
            //CARTA PORTE .. 
            var cartaporte = new NtLinkCartaPorte();
            return cartaporte.SaveConceptoCartaPorte(concepto);
        }


        public List<UsuarioSistem> GetUserList(string email)
        {
            var usuarios = new NtLinkUsuariosAdmin().GetUserList(email);
            return usuarios;
        }

        public List<usuarios> GetUserAdminList()
        {
            var usuarios = new NtLinkUsuariosAdmin().GetUserAdminList();
            return usuarios;
        }

        public usuarios GetUserAdminById(int id)
        {
            var usuario = new NtLinkUsuariosAdmin().GetUserAdminById(id);
            return usuario;
        }

        public int SaveAdmin(string alias, string name, string aPaterno, string aMaterno, string passwd)
        {
            return new NtLinkUsuariosAdmin().SaveAdmin(alias, name, aPaterno, aMaterno, passwd);
        }

        public void UpdateAdmin(int id, string alias, string name, string aPaterno, string aMaterno, string newPasswd)
        {
            new NtLinkUsuariosAdmin().UpdateAdmin(id, alias, name, aPaterno, aMaterno, newPasswd);
        }

        public bool CheckPasswd(int id, String passwd)
        {
            return new NtLinkUsuariosAdmin().CheckPasswd(id, passwd);
        }

        public void NewPath(int idUser, string path)
        {
            new NtLinkUsuariosAdmin().NewPath(idUser, path);
        }

        public void DelPath(int idUser, string path)
        {
            new NtLinkUsuariosAdmin().DelPath(idUser, path);
        }

        public bool FindPath(int idUser, string path)
        {
            return new NtLinkUsuariosAdmin().FindPath(idUser, path);
        }

        public List<adminPantallas> GetAdminPantallas(int idusuario)
        {
            return new NtLinkUsuariosAdmin().GetPantallas(idusuario);
        }

        public byte[] GetFacturasZip(List<int> ids, string rfc)
        {
            try
            {
                return NtLinkFactura.GetZipFacturas(ids, rfc);
            }
            catch (Exception ee)
            {
                Logger.Error(ee);
                return null;
            }

        }

        //--------------------------------------------------
        public string GetNextFolioRetencion(int idEmpresa)
        {
            try
            {
                using (var db = new NtLinkLocalServiceEntities())
                {
                    string folio = db.Retencion.Where(p => p.Emisor == idEmpresa).Max(p => p.Folio);
                    int i = 0;
                    if (folio != null)
                    {
                        i = int.Parse(folio);
                    }
                    i++;
                    return i.ToString().PadLeft(4, '0');
                }
            }
            catch (Exception ee)
            {
                Logger.Error(ee.Message);
                return null;
            }
        }
         
    }
}
