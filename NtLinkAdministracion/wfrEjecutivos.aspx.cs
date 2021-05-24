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
    public partial class wfrEjecutivos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            if (this.Request["id"] != null)
            {
                var cliente = NtLinkClientFactory.Cliente();
                using (cliente as IDisposable)
                {
                    var ejecutivo = cliente.ObtenerPromotor(int.Parse(Request["id"]));
                    if (ejecutivo == null)
                        return;
                    this.txtEmail.Text = ejecutivo.Email;
                    this.hidIdEjecutivo.Value = ejecutivo.IdPromotor.ToString();
                    this.txtNombre.Text = ejecutivo.Nombre;
                    this.txtTelefono.Text = ejecutivo.Telefono;

                }
            }
            else this.hidIdEjecutivo.Value = "0";
        }

        protected void btnGuardar_OnClick(object sender, EventArgs e)
        {
            try
            {
                var exec = new Promotores();
                exec.IdPromotor = int.Parse(hidIdEjecutivo.Value);
                exec.Nombre = txtNombre.Text;
                exec.Telefono = txtTelefono.Text;
                exec.Email = txtEmail.Text;
                var cliente = NtLinkClientFactory.Cliente();
                using (cliente as IDisposable)
                {
                    cliente.GuardarPromotores(exec);
                    lblMensaje.Text = "Guardado correctamente";
                }
            }
            catch (FaultException fe)
            {
                lblMensaje.Text = fe.Message;
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Ocurrió un error al guardar la informacion";
            }

        }
    }
}