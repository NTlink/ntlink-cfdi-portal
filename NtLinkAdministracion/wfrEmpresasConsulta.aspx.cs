using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ServicioLocalContract;

namespace NtLinkAdministracion
{
    public partial class wfrEmpresasConsulta : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void btnNuevaEmpresa_Click(object sender, EventArgs e)
        {
            Response.Redirect("wfrEmpresa.aspx");
        }

        protected void gvEmpresas_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("EditarEmpresa"))
            {
                DataKey key = this.gvEmpresas.DataKeys[Convert.ToInt32(e.CommandArgument)];
                if (key != null)
                {
                    int idCliente = Convert.ToInt32(key.Value);
                    Response.Redirect("wfrEmpresas.aspx?idEmpresa=" + idCliente);
                }
            }
            if (e.CommandName.Equals("EditarSucursal"))
            {
                DataKey key = this.gvEmpresas.DataKeys[Convert.ToInt32(e.CommandArgument)];
                if (key != null)
                {
                    int idCliente = Convert.ToInt32(key.Value);
                    Response.Redirect("wfrSucursalesConsulta.aspx?idEmpresa=" + idCliente);
                }
            }
            if (e.CommandName.Equals("EditarConceptos"))
            {
                DataKey key = this.gvEmpresas.DataKeys[Convert.ToInt32(e.CommandArgument)];
                if (key != null)
                {
                    int idCliente = Convert.ToInt32(key.Value);
                    Response.Redirect("wfrConceptos.aspx?idEmpresa=" + idCliente);
                }
            }
        }
        protected void gvEmpresas_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            this.gvEmpresas.DataSource = ViewState["empresas"];
            this.gvEmpresas.PageIndex = e.NewPageIndex;
            this.gvEmpresas.DataBind();
        }

        #region HelperMethods

        private void FillView()
        {

            var cliente = NtLinkClientFactory.Cliente();
            
            using (cliente as IDisposable)
            {
                this.gvEmpresas.DataSource = cliente.ListaEmpresasPatron(txtRfc.Text);
                ViewState["empresas"] = this.gvEmpresas.DataSource;
                this.gvEmpresas.DataBind();
            }
        }

        #endregion

        protected void ddlClientes_SelectedIndexChanged(object sender, EventArgs e)
        {
            FillView();
        }

        protected void gvEmpresas_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            
        }

        protected void btnBuscar_OnClick(object sender, EventArgs e)
        {
            FillView();
        }
    }
}