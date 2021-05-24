using System;
using System.Collections.Generic;
using System.ServiceModel; 
using System.Web.UI;
using ServicioLocalContract;
using System.Linq;

namespace NtLinkAdministracion
{
    public partial class wfrClientes : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                
                    var clienteServicio = NtLinkClientFactory.Cliente();
                    Sistemas sistema;
                using (clienteServicio as IDisposable)
                {
                    var ejecutivos = clienteServicio.ObtenerPromotores();
                    ejecutivos.Insert(0,new Promotores(){Nombre = "Seleccionar", IdPromotor = 0});
                    ddlEjecutivos.DataSource = ejecutivos;
                    ddlEjecutivos.DataBind();
                    string idEmpresaString = this.Request.QueryString["idSistema"];
                    int idSistema;
                    if (!string.IsNullOrEmpty(idEmpresaString) && int.TryParse(idEmpresaString, out idSistema))
                    {
                        sistema = clienteServicio.ObtenerSistemaById(idSistema, true);
                       //se modifico ppor los cambios hechos por arce para dividir timbres y web
                        //txtConsumidos.Text = clienteServicio.ObtenerNumeroTimbresSistema(idSistema).ToString();
                        List<Contratos> v = clienteServicio.ListaContratos(idSistema);
                        if (v != null && v.Count > 0)
                        {
                            var count = v.Sum(p => p.Timbres);
                            this.txtFolios.Text = count.ToString();
                        }
                        this.FillView(sistema);
                        ViewState["sistema"] = sistema;
                        ddlEjecutivos.Enabled = false;
                    }
                    else
                    {
                        this.txtRFC.Enabled = true;
                    }
                }
                
                
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            this.Response.Redirect("wfrEmpresasConsulta.aspx");
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            var sistema = ViewState["sistema"] as Sistemas;
            var cliente = NtLinkClientFactory.Cliente();
            if (sistema != null)
            {

                Sistemas modSistemas = this.GetEmpresaFromView();
                modSistemas.IdSistema = sistema.IdSistema;
                using (cliente as IDisposable)
                {
                    try
                    {
                      
                        string resultado = null; string usuString = Session["userId"].ToString();
                        if (string.IsNullOrEmpty(usuString))
                            usuString = "0";
                        cliente.GuardarSistema(modSistemas, ref resultado, txtNombreAdmin.Text, txtInicialesAdmin.Text,Convert.ToInt16(usuString));
                        this.LblMensaje.Text = resultado;
                        btnGuardar.Enabled = false;
                    }
                    catch (FaultException ex)
                    {
                        this.lblError.Text = ex.Message;
                    }
                }
            }
            else
            {
                try
                {
                    
                    string resultado = null;
                    string usuString = Session["userId"].ToString();
                    if (string.IsNullOrEmpty(usuString))
                        usuString = "0";
                    cliente.GuardarSistema(this.GetEmpresaFromView(), ref resultado, txtNombreAdmin.Text, txtInicialesAdmin.Text, Convert.ToInt16(usuString));
                    this.LblMensaje.Text= resultado;
                    //this.Response.Redirect("wfrClientesConsulta.aspx");
                }
                catch (FaultException ex)
                {
                    this.lblError.Text = ex.Message;
                }
            }
        }

        #region Helper Methods

        private void FillView(Sistemas empresa)
        {
            this.txtRFC.Text = empresa.Rfc;
            this.txtRazonSocial.Text = empresa.RazonSocial;
            this.txtDireccion.Text = empresa.Direccion;
            this.txtColonia.Text = empresa.Colonia;
            this.txtMunicipio.Text = empresa.Ciudad;
            this.txtEstado.Text = empresa.Estado;
            this.txtCP.Text = empresa.Cp;
            this.txtEmail.Text = empresa.Email;
            this.txtContacto.Text = empresa.Contacto;
            this.txtTelefono.Text = empresa.Telefono;
            this.ddlRegimen.Text = empresa.RegimenFiscal;
            this.ddlTipoCliente.SelectedValue = empresa.TipoSistema.ToString();
            this.txtSaldoEmision.Text = empresa.SaldoEmision.ToString();
            this.txtSaldoTimbrado.Text = empresa.SaldoTimbrado.ToString();
            this.ddlEjecutivos.SelectedValue = empresa.IdPromotor.ToString();
            this.cbBloqueado.Checked = empresa.Bloqueado;
            this.txtRenovacion.Text = empresa.UltimaRenovacion.ToString();
            this.txtConsumoEmision.Text = empresa.ConsumoEmision.HasValue ? empresa.ConsumoEmision.Value.ToString() : "";
            this.txtConsumoTimbrado.Text = empresa.ConsumoTimbrado.HasValue ? empresa.ConsumoTimbrado.Value.ToString() : "";
            bool ?b= empresa.Multiple;
            if (b == true)
                this.cbMultiple.Checked = true;
            else
                this.cbMultiple.Checked = false;

        }

        private Sistemas GetEmpresaFromView()
        {
            var sistema = new Sistemas
            {
                Rfc = this.txtRFC.Text,
                RazonSocial = this.txtRazonSocial.Text,
                Direccion = this.txtDireccion.Text,
                Colonia = this.txtColonia.Text,
                Ciudad = this.txtMunicipio.Text,
                Estado = this.txtEstado.Text,
                Telefono = this.txtTelefono.Text,
                Cp = this.txtCP.Text,
                Email = this.txtEmail.Text,
                Contacto = this.txtContacto.Text,
                RegimenFiscal = this.ddlRegimen.SelectedValue,
                TipoSistema = int.Parse(ddlTipoCliente.SelectedValue),
                Bloqueado = this.cbBloqueado.Checked,
                ConsumoEmision =  string.IsNullOrEmpty(this.txtConsumoEmision.Text) ? 0: int.Parse(txtConsumoEmision.Text),
                SaldoEmision = string.IsNullOrEmpty(this.txtSaldoEmision.Text) ? 0 : int.Parse(txtSaldoEmision.Text),
                ConsumoTimbrado = string.IsNullOrEmpty(this.txtConsumoTimbrado.Text) ? 0 : int.Parse(txtConsumoTimbrado.Text),
                SaldoTimbrado = string.IsNullOrEmpty(this.txtSaldoTimbrado.Text) ? 0 : int.Parse(txtSaldoTimbrado.Text)
            };
            if (!string.IsNullOrEmpty(txtFolios.Text))
            {
                sistema.Folios = int.Parse(txtFolios.Text);
            }

            if (!string.IsNullOrEmpty(this.txtSaldoEmision.Text))
            {
                sistema.SaldoEmision = int.Parse(txtSaldoEmision.Text);
            }

            if (!string.IsNullOrEmpty(this.txtSaldoTimbrado.Text))
            {
                sistema.SaldoTimbrado = int.Parse(txtSaldoTimbrado.Text);
            }

            if (cbMultiple.Checked == true)
                sistema.Multiple = true;
            else
                sistema.Multiple = false;

            sistema.IdPromotor = int.Parse(ddlEjecutivos.SelectedValue);
            return sistema;
        }

        #endregion
    }
}