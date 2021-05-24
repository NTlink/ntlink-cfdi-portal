using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ServicioLocalContract;

namespace NtLinkAdministracion
{
    public partial class wftTimbrado : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.txtFechaFinal.Text = DateTime.Now.ToString("dd/MM/yyyy");
                this.txtFechaInicial.Text = DateTime.Now.AddDays(-1).ToString("dd/MM/yyyy");
            }
            
        }

        protected void txtBuscar_OnClick(object sender, EventArgs e)
        {
            var cliente = NtLinkClientFactory.Cliente();
            try
            {
                using (cliente as IDisposable)
                {
                    var inicial = DateTime.ParseExact(txtFechaInicial.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
                    var final = DateTime.ParseExact(txtFechaFinal.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
                    var tim = cliente.ObtenerTimbres(txtRfc.Text, inicial, final);
                    gvFacturas.DataSource = tim;
                    gvFacturas.DataBind();
                }
            }
            catch (FaultException ee)
            {
                lblError.Text = ee.Message;
            }
        }
    }
}