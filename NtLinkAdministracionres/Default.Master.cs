using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using ServicioLocalContract;

namespace NtLinkAdministracion
{
    public partial class Default : MasterPage
    {
        void Page_Init(object sender, EventArgs e)
        {
            if (Session["userId"] == null)
            {
                this.Response.Redirect("wfrLogin.aspx");
            }
            
            var pantallas = Session["pantallas"] as List<adminPantallas>;
            if (pantallas != null)
            {
                for (int x = 0; x < this.NavigationMenu.Items.Count; x++)
                {
                    var itemsToDelete = this.NavigationMenu.Items[x].ChildItems.Cast<MenuItem>()
                        .Where(menuItem => !pantallas.Any(l => l.pantalla.Equals(menuItem.Text))).ToList();
                    foreach (var item in itemsToDelete)
                    {
                        this.NavigationMenu.Items[x].ChildItems.Remove(item);
                    }
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Logout_Click(object sender, LoginCancelEventArgs e)
        {
            this.Session.Abandon();
            this.Response.Redirect("~/wfrLogin.aspx");
        }
    }
}
