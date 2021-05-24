using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ServicioLocalContract;

namespace NtLinkAdministracion
{
    public partial class wfrEjecutivosConsulta : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                FillView();
            }

        }

        private void FillView()
        {
            var cte = NtLinkClientFactory.Cliente();
            using (cte as IDisposable)
            {
                var exes = cte.ObtenerPromotores();
                gvEjecutivos.DataSource = exes;
                gvEjecutivos.DataBind();
                
            }
        }


        protected void gvEjecutivos_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Editar")
            {
                var id = int.Parse(e.CommandArgument.ToString());
                var redirect = "~/wfrEjecutivos.aspx?id=" + e.CommandArgument.ToString();
                Response.Redirect(redirect);
            }
        }

        protected void btnNuevo_OnClick(object sender, EventArgs e)
        {
            var redirect = "~/wfrEjecutivos.aspx";
            Response.Redirect(redirect);
        }
    }
}