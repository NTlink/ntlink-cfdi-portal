using System;
using System.ServiceModel;
using System.Web.UI;
using ServicioLocalContract;


namespace NtLinkAdministracion
{
    public partial class Lco : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
             var cliente = NtLinkClientFactory.Cliente();
             using (cliente as IDisposable)
             {
                 var c = cliente.GetLogLco();
                 GvLogLco.DataSource = c;
                 GvLogLco.DataBind();
                 var l = cliente.LogLco();
                 gridErrores.DataSource = l;
                 gridErrores.DataBind();
             }
        }

        protected void btnDescarga_Click(object sender, EventArgs e)
        {
            try
            {
                var cliente = NtLinkClientFactory.Cliente();

                using (cliente as IDisposable)
                {
                    cliente.DescargaLco();
                }
                lblMensaje.Text = "Proceso Iniciado";
            }
            catch (FaultException fe)
            {
                lblMensaje.Text = fe.Message;
            }
            catch (Exception ee)
            {
                lblMensaje.Text = "Ocurrió un error al ejecutar el proceso";
            }

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            var cliente = NtLinkClientFactory.Cliente();
            using (cliente as IDisposable)
            {
                var c = cliente.GetLogLco();
                GvLogLco.DataSource = c;
                GvLogLco.DataBind();
                var l = cliente.LogLco();
                gridErrores.DataSource = l;
                gridErrores.DataBind();
            }
        }
    }
}