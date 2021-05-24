using System;
using System.Collections.Generic;
using System.ServiceModel;
using ServicioLocalContract.Entities;

namespace ServicioLocalContract
{
	[ServiceContract]
	public interface IServicioLocal
	{

        [OperationContract]
        void SetFinSession(string Session);

        [OperationContract]
        void GetIP(string ip);

        [OperationContract]
	    bool SaveChangesNtLinkCartaPorte(ConceptosCartaPorte concepto);

        [OperationContract]
        DatosNomina ObtenerDatosNomina(int idCLiente);

        [OperationContract]
        bool SaveDatosNomina(DatosNomina datos);

        [OperationContract]
        ResultadoValidacion ValidarCfdi(string xmlContent);

        [OperationContract]
        byte[] AcuseCancelacion(string reporte,Int64 idVenta, string estatus, string estatusCancela,string EstatusCancelacion);
        
        [OperationContract]
	    bool EliminarCliente(clientes cliente);

	    [OperationContract]
	    List<Distribuidores> ListaDistribuidores();
        [OperationContract]
        List<ElementoDist> ListaDisContratos(int idDistribuidor);
        [OperationContract]
		List<Contratos> ListaContratos(int idSistema);
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
        string CancelarFactura(string rfcEmisor, string folioFiscal, string expresion, string rfcReceptor);
        [OperationContract]
        string CancelarRetencion(string rfc, string folioFiscal);

        [OperationContract]
        string GetNextFolioRetencion(int idEmpresa);

		[OperationContract]
		List<Logger> LogLco();

		[OperationContract]
		List<producto> ListaProductoGaf(int idEmpresa,string texto);
		[OperationContract]
		List<LogLco> GetLogLco();
		[OperationContract]
		List<vClientesPromotores> ListaPromotoresClientes(int idCliente);
		[OperationContract]
		bool BorrarClientesPromotores(int idCP);
		[OperationContract]
		bool GuardarClientesPromotores(int idCliente,int idPromotor);

		[OperationContract]
		List<vClientesPromotores> ListaClientesPromotores(int idCliente);

		[OperationContract]
		bool RecuperarPassword(string rfc, string email);

        [OperationContract]
        bool RecuperarPasswordAdministracion( string email);

        
        [OperationContract]
	    List<vventas> ListaCuentas(DateTime inicio, DateTime end, int idEmpresa, int idCliente, string status,
	                                      string linea = null);

        [OperationContract]
        UsuarioLocal LoginToken(string userName);
		
		[OperationContract]
		UsuarioLocal Login(string userName, string password, string ip);
		[OperationContract]
		List<vventas> ListaFacturas(DateTime inicio, DateTime end,int idEmpresa, int idClientem, string status, string linea =null,string iniciales=null);
        [OperationContract]
        List<vventaRetenciones> ListaRetenciones(DateTime inicio, DateTime end, int idEmpresa, int idClientem, string status, string linea = null);

	    [OperationContract]
	    List<empresa> ListaEmpresasPatron(string patron);
		[OperationContract]
        List<empresa> ListaEmpresas(string perfil, int idempresa, long idSistema, string linea);
		[OperationContract]
		empresa ObtenerEmpresaByUserId(string userId);
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
        byte[] RetencionPdfXML(string uuid,string rfc,string tipo);
		[OperationContract]
		int GuardarCliente(clientes cliente);
		[OperationContract]
		bool GuardarEmpresa(empresa empresa, byte[] cert, byte[] llave, string passwordLlave, byte[] logo, string formatoLlave);
		[OperationContract]
		string SiguienteFolioFactura(int idEmpresa);
		[OperationContract]
		string TipoCambio();
		[OperationContract]
		List<producto> BuscarProducto(string query, int idEmpresa);
		[OperationContract]
		producto ObtenerProductoById(int id);
		[OperationContract]
		bool GuardarFactura(facturas fact, List<facturasdetalle> detalles, bool enviar, List<facturasdetalle> detallesAduana);
		[OperationContract]
		clientes ObtenerClienteById(int idCliente);
		[OperationContract]
		empresa ObtenerEmpresaById(int idEmpresa);
		[OperationContract]
		List<UsuarioLocal> UsuariosLista(int idEmpresa);
		[OperationContract]
		List<string> ObtenerPerfiles();
		[OperationContract]
		bool EditarUsuario(UsuarioLocal usuario);
		[OperationContract]
		bool GuardarUsuario(string nombreCompleto, string eMail, string password, int idEmpresa, string perfil, string userName, string iniciales);
		[OperationContract]
		bool CambiarPassword(string userId, string password);
		[OperationContract]
		byte[] FacturaPreview(facturas fact, List<facturasdetalle> detalles, List<facturasdetalle> detallesAduana);
        [OperationContract]
	    byte[] VistaPreviaRet(Retencion retencion, IList<RetencionesItem> items,DatosRetenciones retenciones );
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
		bool GuardarSistema(Sistemas sistema, ref string resultado, string nombreCompleto, string iniciales,int usu);
        [OperationContract]
        bool GuardarDistribuidor(Distribuidores distribuidor, ref string resultado, string nombreCompleto, string iniciales);
		[OperationContract]
		usuarios AdminLogin(string user, string password,string ip);
		[OperationContract]
		bool TieneConfiguradoCertificado(int idEmpresa);

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
		bool GuardarConcepto(producto prod);

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
		List<UsuarioLocal> UsuariosObtenerLista(string patron);

		[OperationContract]
		void DesbloquearUsuario(string userName);

		[OperationContract]
		vventas GetFactura(int idFactura);
        [OperationContract]
        vventaRetenciones GetRetenciones(Int64 idretencion);

		[OperationContract]
		List<empresaPantalla> ObtenerPantallasPorIdEmpresa(int idEmpresa);

		[OperationContract]
		bool ActualizarPantallasPorEmpresa(List<empresaPantalla> pantallas);

		[OperationContract]
		bool GuardarPromotores(Promotores promotor);

		[OperationContract]
		List<Promotores> ListaPromotores();

		[OperationContract]
		Promotores ObtenerPromotor(int idPromotor);

	    [OperationContract]
	    void UpdateDistribuidor(int idContrato);

	    [OperationContract]
	    DistContratos Contratos(int idContrato);

	    [OperationContract]
	    List<ElementoCliente> ListaTimbrado(int id);

        [OperationContract]
        Distribuidores ObtenerDIsById(string idDistribuidor);

        [OperationContract]
        string ValidarCSD(empresa empresa, byte[] cert, byte[] llave, string passwordLlave, string formatoLlave);
        // lista  de datos distribuidorcomisiones

        [OperationContract]
        List<Comision_Distribuidores> listaComDis();

        //lista distribuidor timbrado
        [OperationContract]
        List<Ctdistribuidores> lisDistribuidores();

        [OperationContract]
        List<vventas> ListaNomina(DateTime inicio, DateTime end, int idEmpresa, int idClientem, string status, string linea = null, string iniciales = null);

        [OperationContract]
        bool GuardarRetencion(Retencion retencionBo, IList<RetencionesItem> items,DatosRetenciones datosIntereses,bool enviar);

        [OperationContract]
        List<usuarios> GetUserAdminList();

        [OperationContract]
        usuarios GetUserAdminById(int id);

        [OperationContract]
        int SaveAdmin(string alias, string name, string aPaterno, string aMaterno, string passwd);

        [OperationContract]
        void UpdateAdmin(int id, string alias, string name, string aPaterno, string aMaterno, string newPasswd);

        [OperationContract]
        bool CheckPasswd(int id, string passwd);

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
	    List<Promotores> ObtenerPromotores();
	}
}
