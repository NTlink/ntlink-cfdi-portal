using System;
using System.Web.UI.WebControls;
using ServicioLocalContract;

namespace GafLookPaid
{
    public partial class wfrComisionistas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!this.IsPostBack)
            {
                var cliente = NtLinkClientFactory.Cliente();
                using (cliente as IDisposable)
                {
                    this.gvComisionistas.DataSource = cliente.ListaComisionistas((int)Session["idEmpresa"]);
                    ViewState["comisionistas"] = this.gvComisionistas.DataSource;
                    this.gvComisionistas.DataBind();
                }
            }
        }

        protected void gvComisionistas_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if(e.CommandName.Equals("EditarComisionista"))
            {
                var idComisionista = (long)this.gvComisionistas.DataKeys[Convert.ToInt32(e.CommandArgument)].Value;
                this.Response.Redirect("wfrComisionistas.aspx?idComisionista=" + idComisionista);
            }
        }

        protected void btnNuevoComisionista_Click(object sender, EventArgs e)
        {
            this.Response.Redirect("wfrComisionistas.aspx");   
        }

        protected void gvComisionistas_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            this.gvComisionistas.DataSource = ViewState["comisionistas"];
            this.gvComisionistas.PageIndex = e.NewPageIndex;
            this.gvComisionistas.DataBind();
        }
    }
}