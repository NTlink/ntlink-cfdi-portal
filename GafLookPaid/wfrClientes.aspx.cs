using System;
using System.ServiceModel;
using ServicioLocalContract;


namespace GafLookPaid
{
    public partial class wfrClientes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!this.IsPostBack)
            {
                string idClienteString = Request.QueryString["idCliente"];

                int idCliente;
                if(!string.IsNullOrEmpty(idClienteString) && int.TryParse(idClienteString, out idCliente))
                {
                    var clienteServicio = NtLinkClientFactory.Cliente();
                    clientes cliente;
                    using (clienteServicio as IDisposable)
                    {
                        cliente = clienteServicio.ObtenerClienteById(idCliente);
                        var sistema = Session["idSistema"] as long?;
                        var perfil = Session["perfil"] as string;
                        this.ddlEmpresa.DataSource = clienteServicio.ListaEmpresas(perfil, cliente.idempresa.Value, sistema.Value, null);
                        this.ddlEmpresa.DataBind();
                    }
                    this.txtRFC.Enabled = false;
                    this.FillView(cliente);
                    ViewState["cliente"] = cliente;
                }
                else
                {
                    string idEmpresaString = Request.QueryString["idEmpresa"];
                    var sistema = Session["idSistema"] as long?;
                    int idEmpresa;
                    if (!string.IsNullOrEmpty(idEmpresaString) && int.TryParse(idEmpresaString, out idEmpresa))
                    {
                        var clienteServicio = NtLinkClientFactory.Cliente();
                        using (clienteServicio as IDisposable)
                        {
                            this.ddlEmpresa.DataSource = clienteServicio.ListaEmpresas(Session["perfil"] as string, idEmpresa, sistema.Value, null);
                            this.ddlEmpresa.DataBind();
                        }
                        this.txtRFC.Enabled = true;
                    }
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            var cliente = ViewState["cliente"] as clientes;
            if (cliente != null)
            {
                clientes modCliente = this.GetClientFromView();

                modCliente.idCliente = cliente.idCliente;
                modCliente.idempresa = int.Parse(this.ddlEmpresa.SelectedValue);
                modCliente.idVendedor = cliente.idVendedor;
                modCliente.Tipo = cliente.Tipo;
               // modCliente.CURP = txtCurp.Text;//agregando curp

                try
                {
                    var clienteServicio = NtLinkClientFactory.Cliente();
                    using (clienteServicio as IDisposable)
                    {
                        clienteServicio.GuardarCliente(modCliente);
                    }
                    Response.Redirect("wfrClientesConsulta.aspx");
                }
                catch (FaultException ex)
                {
                    this.lblError.Text = ex.Message;
                }

            }
            else
            {
                try
                {
                    var clienteServicio = NtLinkClientFactory.Cliente();
                    using (clienteServicio as IDisposable)
                    {
                        clienteServicio.GuardarCliente(this.GetClientFromView());
                    }
                    Response.Redirect("wfrClientesConsulta.aspx");
                }
                catch (FaultException ex)
                {
                    this.lblError.Text = ex.Message;
                }
            }
        }


        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("wfrClientesConsulta.aspx");
        }

        #region HelperMethods

        private void FillView(clientes cliente)
        {
            this.ddlEmpresa.SelectedValue = cliente.idempresa.ToString();
            this.txtRFC.Text = cliente.RFC;
            this.txtRazonSocial.Text = cliente.RazonSocial;
            this.txtDireccion.Text = cliente.Direccion;
            this.txtColonia.Text = cliente.Colonia;
            this.txtMunicipio.Text = cliente.Ciudad;
            this.txtEstado.Text = cliente.Estado;
            this.txtPais.Text = cliente.Pais;
            this.txtCP.Text = cliente.CP;
            this.txtTelefono.Text = cliente.Telefonos;
            this.txtEmail.Text = cliente.Email;
            this.txtWeb.Text = cliente.Pagina;
            this.txtContacto.Text = cliente.Contacto;
            this.txtDiasRevision.Text = cliente.DiasRevision.ToString();
            this.txtCuentaContable.Text = cliente.Cuenta;
            this.txtBcc.Text = cliente.Bcc;
            this.txtInt.Text = cliente.NoInt;
            this.txtExt.Text = cliente.NoExt;
            this.txtLocalidad.Text = cliente.Localidad;
            this.txtReferencia.Text = cliente.Referencia;
            //this.txtMetodoPago.Text = cliente.MetodoPago;
            this.txtCuentaDeposito.Text = cliente.CuentaPago;
            this.txtCurp.Text = cliente.CURP;
            this.ddlNacionalidad.SelectedValue = cliente.Nacionalidad;//para constacia de retenciones
            this.txtNumRegIdTrib.Text = cliente.NumRegIdTrib;//para constacia de retenciones
        }

        private clientes GetClientFromView()
        {
            var cliente = new clientes
                              {
                                  RFC = this.txtRFC.Text,
                                  RazonSocial = this.txtRazonSocial.Text,
                                  Direccion = this.txtDireccion.Text,
                                  Colonia = this.txtColonia.Text,
                                  Ciudad = this.txtMunicipio.Text,
                                  Estado = this.txtEstado.Text,
                                  Pais = this.txtPais.Text,
                                  CP = this.txtCP.Text,
                                  Telefonos = this.txtTelefono.Text,
                                  Email = this.txtEmail.Text,
                                  Pagina = this.txtWeb.Text,
                                  Contacto = this.txtContacto.Text,
                                  Cuenta = this.txtCuentaContable.Text,
                                  //MetodoPago = this.txtMetodoPago.Text,
                                  Bcc = txtBcc.Text,
                                  CuentaPago = this.txtCuentaDeposito.Text,
                                  idempresa = int.Parse(this.ddlEmpresa.SelectedValue),
                                  Tipo = 0,
                                  CURP=this.txtCurp.Text,
                                  Nacionalidad=ddlNacionalidad.SelectedValue,
                                  NumRegIdTrib=txtNumRegIdTrib.Text
                                  
                              };

            if(!string.IsNullOrEmpty(this.txtDiasRevision.Text))
            {
                cliente.DiasRevision = int.Parse(this.txtDiasRevision.Text);
            }
            cliente.NoExt = string.IsNullOrEmpty(txtExt.Text) ? null : txtExt.Text;
            cliente.NoInt = string.IsNullOrEmpty(txtInt.Text) ? null : txtInt.Text;
            cliente.Localidad = string.IsNullOrEmpty(txtLocalidad.Text) ? null : txtLocalidad.Text;
            cliente.Referencia = string.IsNullOrEmpty(txtReferencia.Text) ? null : txtReferencia.Text;
            return cliente;
        }

        #endregion
    }
}