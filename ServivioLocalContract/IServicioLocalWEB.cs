using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using ServicioLocalContract;
using ServicioLocalContract.Entities;
using ServicioLocal.Business.Retenciones;
using CatalogosSAT;
using ServicioLocalContract.entities;

namespace ServicioLocalContract
{
    // NOTA: puede usar el comando "Rename" del menú "Refactorizar" para cambiar el nombre de interfaz "IServicioLocalWEB" en el código y en el archivo de configuración a la vez.
    [ServiceContract]
    public interface IServicioLocalWEB
    {
        //[OperationContract]
        //string GetUUDI();
        [OperationContract]
        void SetFinSession(string Session);
        [OperationContract]
        void GetIP(string ip);
        [OperationContract]
        string GetConsultaEstatusCFDI(string cadena);
        [OperationContract]
        
        empresa GetByRFCEMPRESA(string rfc);
        [OperationContract]
        byte[] AcuseCancelacion(string reporte, Int64 idVenta, string estatus, string estatusCancela, string EstatusCancelacion);
        [OperationContract]
        bool EliminarCliente(clientes cliente);
        [OperationContract]
         List<Contratos> ListaContratos(int idSistema);
        [OperationContract]
        List<ElementoDist> ListaDisContratos(int idDistribuidor);
        [OperationContract]
        List<Distribuidores> ListaDistribuidores();
        [OperationContract]
        DistContratos Contratos(int idContrato);
        [OperationContract]
         void GuardarContrato(Contratos contrato);
        [OperationContract]
         void GuardarDisContrato(DistContratos contrato);
        [OperationContract]
         int ObtenerNumeroTimbresSistema(int idSistema);
        [OperationContract]
         int ObtenerNumeroTimbresEmpresa(int idEmpresa);
        [OperationContract]
         void EnviarFactura(string rfc, string folioFiscal, List<string> rec, List<string> bcc);
        [OperationContract]
         string CancelarFactura(string rfc, string folioFiscal,string expresion, string rfcReceptor);
        [OperationContract]
         string CancelarRetencion(string rfc, string folioFiscal);
        [OperationContract]
        string Confirmar(string Confirmar,Int64 IdTimbre);
        [OperationContract]
        List<c_ClaveProdServ> Consultar_ClaveProdServAll();
        [OperationContract]
        Divisas Consultar_TipoDivisa(string pais);
        [OperationContract]
        List<c_ClaveUnidad> ConsultarClaveUnidadAll();
        [OperationContract]
        List<c_Estado> Consultar_EstadosALL();
        [OperationContract]
        List<c_Municipio> Consultar_MunicipioALL(string estado);
        [OperationContract]
        List<c_CP> Consultar_CPALL(string estado, string municipio);

        [OperationContract]
        List<c_TasaOCuota> Consultar_TasaCuota(string Impu, string tipoFactor, string tipoReteTras,ref bool rango);
        [OperationContract]
        List<c_Moneda> Consultar_MonedaAll();
        [OperationContract]
        c_Moneda Consultar_Moneda(string moneda);
        [OperationContract]
         byte[] GetFacturaAcuse(string uuid, string RFC, string fecha);
        [OperationContract]
         List<Logger> LogLco();
        [OperationContract]
         vventas GetFactura(int idFactura);
        [OperationContract]
        facturas GetSelloEmisor(string uudi);
        [OperationContract]
         vventaRetenciones GetRetenciones(Int64 idFactura);
        [OperationContract]
         List<empresaPantalla> ObtenerPantallasPorIdEmpresa(int idEmpresa);
        [OperationContract]
         bool ActualizarPantallasPorEmpresa(List<empresaPantalla> pantallas);
        [OperationContract]
         bool GuardarConcepto(producto producto);
        [OperationContract]
         bool TieneConfiguradoCertificado(int idEmpresa);
        [OperationContract]
         UsuarioLocal LoginToken(string userName);
        [OperationContract]
         UsuarioLocal Login(string userName, string password, string ip);
        [OperationContract]
         List<vventas> ListaCuentas(DateTime inicio, DateTime end, int idEmpresa, int idCliente, string status, string linea = null);
        [OperationContract]
         List<vventas> ListaFacturas(DateTime inicio, DateTime end, int idEmpresa, int idCliente, string status,
            string linea = null, string iniciales = null);
        [OperationContract]
         List<vventaRetenciones> ListaRetenciones(DateTime inicio, DateTime end, int idEmpresa, int idCliente, string status,
           string linea = null);
        [OperationContract]
          List<ConfirmacionTimbreWs33> ListaConfirmacion( string idEmpresa, string idCliente);
       
        [OperationContract]
         List<empresa> ListaEmpresasPatron(string patron);
        [OperationContract]
         List<empresa> ListaEmpresas(string perfil, int idempresa, long idSistema, string linea = null);
        [OperationContract]
         empresa ObtenerEmpresaByUserId(string userId);
        [OperationContract]
        Guid GetUserIdByEmpresa(int idempresa);
     
        [OperationContract]
        string UsuarioById(Guid userId);
        [OperationContract]
         bool RecuperarPassword(string rfc, string email);
        [OperationContract]
         bool RecuperarPasswordAdministracion(string email);
        [OperationContract]
         UsuarioLocal ObtenerUsuarioById(string userId);
        [OperationContract]
         List<clientes> ListaClientes(string perfil, int idEmpresa, string filtro, bool lista);
      
        [OperationContract]
         List<clientes> ListaEmpleados(string perfil, int idEmpresa, string filtro, bool lista);
        [OperationContract]
         List<clientes> ListaClientesGaf(string linea);
        [OperationContract]
         bool GuardarListaFacturas(List<vventas> lista);
        [OperationContract]
         byte[] FacturaXml(string uuid);
        [OperationContract]
         byte[] FacturaPdf(string uuid);
        [OperationContract]
        byte[] GetPdfDataRetenciones(string uuid, int idEmpresa, string tipo);
        [OperationContract] 
         byte[] RetencionPdfXML(string uuid, string rfc, string tipo);
        [OperationContract]
         int GuardarCliente(clientes cliente);
        [OperationContract]
         bool GuardarEmpresa(empresa empresa, byte[] cert, byte[] llave, string passwordLlave, byte[] logo, string formatoLlave);
        [OperationContract]
         string SiguienteFolioFactura(int idEmpresa);
        [OperationContract]
         string TipoCambio();
        [OperationContract]
        List<c_ClaveProdServ> BuscarClaveProdServSearch(string query);
        [OperationContract]
        c_ClaveProdServ ObtenerClaveProdServById(int id);
        [OperationContract]
         List<producto> BuscarProducto(string query, int idEmpresa);
        [OperationContract]
         producto ObtenerProductoById(int id);
        [OperationContract]
        RetornoServicio GuardarFactura33(facturas fact, List<facturasdetalle> detalles, List<facturasdetalle33> detalles33,
            bool enviar, facturaComplementos complementosF, List<facturasdetalle> conceptosAduana);
        [OperationContract]
        bool GuardarFactura(facturas fact, List<facturasdetalle> detalles,  bool enviar, List<facturasdetalle> conceptosAduana);
        [OperationContract]
        List<ActivacionConvertidor> GetLicenciaLista();
        [OperationContract]
        int GuardaLicencia(ActivacionConvertidor licencia);
        [OperationContract]
         byte[] VistaPreviaRet(Retencion retencion, IList<RetencionesItem> items, DatosRetenciones datosIntereses);
        [OperationContract]
        RetornoServicio GuardarRetencion(Retencion retencion, IList<RetencionesItem> items, DatosRetenciones datosIntereses, bool enviar);
        [OperationContract]
         byte[] FacturaPreview(facturas fact, List<facturasdetalle> detalles, List<facturasdetalle> conceptosAduana);
        [OperationContract]
        byte[] FacturaPreview33(facturas fact, List<facturasdetalle> detalles, List<facturasdetalle33> detalles33,
            facturaComplementos complementosF, List<facturasdetalle> conceptosAduana);
     
        [OperationContract]
         clientes ObtenerClienteById(int idCliente);
        [OperationContract]
         empresa ObtenerEmpresaById(int idEmpresa);
        [OperationContract]
         List<UsuarioLocal> UsuariosLista(int idEmpresa);
        [OperationContract]
         List<string> ObtenerPerfiles();
        [OperationContract]
         bool GuardarUsuario(string nombreCompleto, string eMail, string password, int idEmpresa, string perfil, string userName, string iniciales);
        [OperationContract]
         void SendMail(List<string> recipients, List<string> attachments, string message, string subject, string fromEmail, string fromDescription);
        [OperationContract]
         void SendMailByteArray(List<string> recipients, List<EmailAttachment> attachments, string message, string subject, string fromEmail, string fromDescription);
        [OperationContract]
         List<TimbreWs> ObtenerTimbres(string rfc, DateTime inicial, DateTime final);
        [OperationContract]
         void DescargaLco();
        [OperationContract]
         void Pagarfactura(int idVenta, DateTime fechaPago, string referenciaPago);
        [OperationContract]
         List<ElementoReporte> ObtenerReporte(int mes, int anio);
        [OperationContract]
         List<ElementoReporteMensual> ObtenerReporteMensual();
        [OperationContract]
         List<ElementoReporte> ObtenerReportePorCliente(int mes, int anio, int idSistema);
        [OperationContract]
         List<ElementoReporte> ObtenerReportePorEmisor(int mes, int anio, int idEmpresa);
        [OperationContract]
         List<ElementoReporte> ObtenerReporteFullEmisor(int mes, int anio, int idSistema);
        [OperationContract]
         bool CambiarPassword(string userId, string password);
        [OperationContract]
         List<Sucursales> ListaSucursales(int idEmpresa);
        [OperationContract]
         List<Comisionistas> ListaComisionistas(int idEmpresa);
        [OperationContract]
         Sucursales ObtenerSucursal(int idSucursal);
        [OperationContract]
         Comisionistas ObtenerComisionista(int idComisionista);
        [OperationContract]
         bool GuardaSucursal(Sucursales sucursal);
        [OperationContract]
         bool GuardaComisionista(Comisionistas comisionista);
        [OperationContract]
         Sistemas ObtenerSistema(string rfc);
        [OperationContract]
         Sistemas ObtenerSistemaById(int idSistema, bool data = false);
        [OperationContract]
         List<Sistemas> ListaSistemas(string filtro, int ejecutivo = 0);
        [OperationContract]
         List<ElementoCliente> ListaSistemasTimbre(string filtro);
        [OperationContract]
         bool GuardarSistema(Sistemas sistema, ref string resultado, string nombreCompleto, string iniciales, int usu);
        [OperationContract]
         bool GuardarDistribuidor(Distribuidores distribuidor, ref string resultado, string nombreCompleto, string iniciales);
        [OperationContract]
         usuarios AdminLogin(string user, string password, string ip);
        [OperationContract]
         List<UsuarioLocal> UsuariosObtenerLista(string patron);
        [OperationContract]
         void DesbloquearUsuario(string userName);
        [OperationContract]
         bool EditarUsuario(UsuarioLocal usuario);
        [OperationContract]
         bool GuardarPromotores(Promotores promotor);
        [OperationContract]
         List<Promotores> ListaPromotores();
        [OperationContract]
         Promotores ObtenerPromotor(int idPromotor);
        [OperationContract]
         List<Promotores> ObtenerPromotores();
        [OperationContract]
         List<vClientesPromotores> ListaClientesPromotores(int idCliente);
        [OperationContract]
         bool GuardarClientesPromotores(int idCliente, int idPromotor);
        [OperationContract]
         bool BorrarClientesPromotores(int idCP);
        [OperationContract]
         List<vClientesPromotores> ListaPromotoresClientes(int idCliente);
        [OperationContract]
         List<LogLco> GetLogLco();
        [OperationContract]
         List<producto> ListaProductoGaf(int idEmpresa, string texto);
        [OperationContract]
         void UpdateDistribuidor(int idContrato);
        [OperationContract]
         List<ElementoCliente> ListaTimbrado(int id);
        [OperationContract]
         Distribuidores ObtenerDIsById(string userId);
        [OperationContract]
         string ValidarCSD(empresa empresa, byte[] cert, byte[] llave, string passwordLlave, string formatoLlave);
        [OperationContract]
         List<Comision_Distribuidores> listaComDis();
        [OperationContract]
         List<Ctdistribuidores> lisDistribuidores();
        [OperationContract]
         List<vventas> ListaNomina(DateTime inicio, DateTime end, int idEmpresa, int idClientem, string status, string linea = null, string iniciales = null);
        [OperationContract]
         DatosNomina ObtenerDatosNomina(int idCLiente);
        [OperationContract]
         bool SaveDatosNomina(DatosNomina datos);
        [OperationContract]
         ResultadoValidacion ValidarCfdi(string xmlContent);
        [OperationContract]
         bool SaveChangesNtLinkCartaPorte(ConceptosCartaPorte concepto);
        [OperationContract]
        List<UsuarioSistem> GetUserList(string email);
      
        [OperationContract]
         List<usuarios> GetUserAdminList();
        [OperationContract]
         usuarios GetUserAdminById(int id);
        [OperationContract]
         int SaveAdmin(string alias, string name, string aPaterno, string aMaterno, string passwd);
        [OperationContract]
         void UpdateAdmin(int id, string alias, string name, string aPaterno, string aMaterno, string newPasswd);
        [OperationContract]
         bool CheckPasswd(int id, String passwd);
        [OperationContract]
         void NewPath(int idUser, string path);
        [OperationContract]
         void DelPath(int idUser, string path);
        [OperationContract]
         bool FindPath(int idUser, string path);
        [OperationContract]
         List<adminPantallas> GetAdminPantallas(int idusuario);
        [OperationContract]
         byte[] GetFacturasZip(List<int> ids, string rfc);
        [OperationContract]
         string GetNextFolioRetencion(int idEmpresa);








    }
}
