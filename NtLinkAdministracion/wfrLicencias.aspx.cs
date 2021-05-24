using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ServicioLocalContract;
using System.Drawing;

namespace NtLinkAdministracion
{
    public partial class wfrLicencias : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                var usuario = Session["usuario"] as usuarios;
                 var cliente = NtLinkClientFactory.Cliente();
                GetLicencias();
            }
        }

        protected void gvLicencias_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            if (e.CommandName.Equals("EditarSistema"))
            {
                DataKey key = this.gvLicencias.DataKeys[Convert.ToInt32(e.CommandArgument)];
                if (key != null)
                {
                    int idCliente = Convert.ToInt32(key.Value);
                    Response.Redirect("wfrClientes.aspx?idSistema=" + idCliente);
                }
            }
            else if (e.CommandName.Equals("Contratos"))
            {
                DataKey key = this.gvLicencias.DataKeys[Convert.ToInt32(e.CommandArgument)];
                if (key != null)
                {
                    int idCliente = Convert.ToInt32(key.Value);
                    Response.Redirect("wfrClientesContratos.aspx?idSistema=" + idCliente);
                }
            }

        }


        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            var usuario = Session["usuario"] as usuarios;

            var cliente = NtLinkClientFactory.Cliente();
            using (cliente as IDisposable)
            {
                string key= Guid.NewGuid().ToString();
                string key2= key.Substring(0, 4)+"-"+key.Substring(4,19);
                ActivacionConvertidor a = new ActivacionConvertidor();
                a.key = key2.ToUpper();
                a.FechaAlta = DateTime.Now;
                string nombre = usuario.NombreReal + " " + usuario.apaterno + " " + usuario.aMaterno;
                a.Admin = nombre;
                a.Activo = true;
                cliente.GuardaLicencia(a);
                GetLicencias();
            }
       }



            #region helper methods

            private void GetLicencias()
        {

            var cliente = NtLinkClientFactory.Cliente();
            using (cliente as IDisposable)
            {
                this.gvLicencias.DataSource = cliente.GetLicenciaLista();
                this.gvLicencias.DataBind();

            //    this.gvClientes.DataSource =
            //        cliente.ListaSistemas(txtBusqueda.Text, int.Parse(ddlEjecutivos.SelectedValue))
            //            .OrderBy(p => p.RazonSocial);
            //    gvClientes.DataBind();


            }

        }

        #endregion

        protected void gvLicencias_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }

        protected void btnNuevoCliente_Click(object sender, EventArgs e)
        {
            Response.Redirect("wfrClientes.aspx");
        }


        protected void ddlEjecutivos_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            
        }
    }
}