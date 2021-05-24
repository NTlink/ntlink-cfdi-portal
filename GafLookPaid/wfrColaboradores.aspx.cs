using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ServicioLocalContract;

namespace GafLookPaid
{
    public partial class wfrColaboradores : System.Web.UI.Page
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
                    DatosNomina datos;
                    using (clienteServicio as IDisposable)
                    {
                        cliente = clienteServicio.ObtenerClienteById(idCliente);
                        var sistema = Session["idSistema"] as long?;
                        var perfil = Session["perfil"] as string;
                        this.ddlEmpresa.DataSource = clienteServicio.ListaEmpresas(perfil, cliente.idempresa.Value, sistema.Value, null);
                        this.ddlEmpresa.DataBind();
                        datos = clienteServicio.ObtenerDatosNomina(cliente.idCliente);

                    }

                    this.txtRFC.Enabled = false;
                    this.FillView(cliente, datos);
                    ViewState["cliente"] = cliente;
                    if (datos != null)
                        ViewState["idDatos"] = datos.IdDatoNomina;
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
                    this.ddlEmpresa.SelectedValue = idEmpresaString;
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            int? idDatos = 0;
            if (ViewState["idDatos"] != null)
            {
                var iddatos = (long)ViewState["idDatos"];
                idDatos = (int) iddatos;

            }
            var cliente = ViewState["cliente"] as clientes;
            if (cliente != null)
            {
                clientes modCliente = this.GetClientFromView();
                DatosNomina datos = this.GetDatosFromView();
                datos.IdDatoNomina = idDatos.Value;
                datos.IdCliente = cliente.idCliente;
                modCliente.idCliente = cliente.idCliente;
                modCliente.idempresa = int.Parse(this.ddlEmpresa.SelectedValue);
                modCliente.idVendedor = cliente.idVendedor;
                modCliente.Tipo = cliente.Tipo;

                try
                {
                    var clienteServicio = NtLinkClientFactory.Cliente();
                    using (clienteServicio as IDisposable)
                    {
                        var cte = clienteServicio.GuardarCliente(modCliente);
                        datos.IdCliente = cte;
                        clienteServicio.SaveDatosNomina(datos);
                    }
                    Response.Redirect("wfrColaboradoresConsulta.aspx");
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
                        var cte = clienteServicio.GuardarCliente(this.GetClientFromView());
                        DatosNomina datos = this.GetDatosFromView();
                        datos.IdDatoNomina = idDatos.Value;
                        datos.IdCliente = cte;
                        clienteServicio.SaveDatosNomina(datos);
                    }
                    Response.Redirect("wfrColaboradoresConsulta.aspx");
                }
                catch (FaultException ex)
                {
                    this.lblError.Text = ex.Message;
                }
            }
        }


        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("wfrColaboradoresConsulta.aspx");
        }

        
        private void FillView(clientes cliente, DatosNomina datos)
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
            //this.txtMetodoPago.Text = cliente.MetodoPago;
            this.txtCuentaDeposito.Text = cliente.CuentaPago;
            txtCURP.Text = cliente.CURP;
            
            //Datos de la nomina
            if (datos != null)
            {
                this.txtNumEmpleado.Text = datos.NoEmpleado;
                this.ddlRegimen.SelectedValue = datos.Regimen;
                this.txtNumSeguridadSocial.Text = datos.NoSeguridadSocial;
                this.txtDepartamento.Text = datos.Departamento;
                this.txtClabe.Text = datos.Clabe;
                this.ddlBanco.SelectedValue = datos.Banco;
                this.txtFechaInicialLaboral.Text = datos.FechaInicio.ToString("yyyy-MM-dd");
                this.txtPuesto.Text = datos.Puesto;
                this.txtTipoContrato.Text = datos.TipoContrato;
                this.txtTipoJornada.Text = datos.TipoJornada;
                this.txtPeriodicidadPago.Text = datos.Periodicidad.ToString();
                this.txtSalarioBaseCotApor.Text = datos.SalarioBase.ToString();
                this.ddlRiesgoPuesto.SelectedValue = datos.Riesgo;
                this.txtSalarioDiarioIntegro.Text = datos.SalarioDiario.ToString();
                
            }


            




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
                CURP =  txtCURP.Text,
                Tipo = 1

            };
            
            


            if (!string.IsNullOrEmpty(this.txtDiasRevision.Text))
            {
                cliente.DiasRevision = int.Parse(this.txtDiasRevision.Text);
            }

            return cliente;
        }


        private DatosNomina GetDatosFromView()
        {
            var fecha = DateTime.ParseExact(txtFechaInicialLaboral.Text, "yyyy-MM-dd",
                                            System.Threading.Thread.CurrentThread.CurrentCulture);
            var datos = new DatosNomina()
            {
                Banco = ddlBanco.SelectedValue,
                Clabe = txtClabe.Text,
                Departamento = txtDepartamento.Text,
                FechaInicio = fecha,
                
                NoEmpleado = txtNumEmpleado.Text,
                NoSeguridadSocial = txtNumSeguridadSocial.Text,
                Puesto = txtPuesto.Text,
                Periodicidad = int.Parse(txtPeriodicidadPago.Text),
                Regimen = ddlRegimen.SelectedValue,
                Riesgo = ddlRiesgoPuesto.SelectedValue,
                SalarioBase = decimal.Parse(txtSalarioBaseCotApor.Text),
                SalarioDiario = decimal.Parse(txtSalarioDiarioIntegro.Text),
                TipoContrato = txtTipoContrato.Text,
                TipoJornada = txtTipoJornada.Text
            };
            return datos;

        }
    }
}