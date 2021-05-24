using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ServicioLocalContract;

namespace NtLinkAdministracion
{
    public partial class wfrClientesNtLink : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                string idClienteString = Request.QueryString["idCliente"];

                int idCliente;
                if (!string.IsNullOrEmpty(idClienteString) && int.TryParse(idClienteString, out idCliente))
                {
                    var clienteServicio = NtLinkClientFactory.Cliente();
                    clientes cliente;
                    using (clienteServicio as IDisposable)
                    {
                        cliente = clienteServicio.ObtenerClienteById(idCliente);
                        var sistema = 17;
                        var perfil = "Administrador";
                        this.ddlEmpresa.DataSource = clienteServicio.ListaEmpresas(perfil, cliente.idempresa.Value, sistema, null);
                        this.ddlEmpresa.DataBind();
                    }
                    this.txtRFC.Enabled = false;
                    this.FillView(cliente);
                    ViewState["cliente"] = cliente;
                }
                else
                {
                    string idEmpresaString = Request.QueryString["idEmpresa"];
                    var sistema = 17;
                    int idEmpresa;
                    if (!string.IsNullOrEmpty(idEmpresaString) && int.TryParse(idEmpresaString, out idEmpresa))
                    {
                        var clienteServicio = NtLinkClientFactory.Cliente();
                        using (clienteServicio as IDisposable)
                        {
                            this.ddlEmpresa.DataSource = clienteServicio.ListaEmpresas("Administrador", idEmpresa, sistema, null);
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

                try
                {
                    var clienteServicio = NtLinkClientFactory.Cliente();
                    using (clienteServicio as IDisposable)
                    {
                        clienteServicio.GuardarCliente(modCliente);
                    }
                    Response.Redirect("wfrClientesNtLinkConsulta.aspx");
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
                Tipo = 0

            };

            if (!string.IsNullOrEmpty(this.txtDiasRevision.Text))
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