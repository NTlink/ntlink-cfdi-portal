using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using ServicioLocalContract;
using System.Web;

namespace NtLinkAdministracion
{
    public partial class wfrLogin : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                if (Session["userId"] != null)
                {
                    this.Response.Redirect("Default.aspx");
                }
            }
        }
        public string GetIP()
        {
            string ip = "";

            //try{
            ip = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
            //}  catch (Exception) { }

            if (string.IsNullOrEmpty(ip))
            {
                ip = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
            }

            if (ip == "::1")
                ip = "127.0.0.1";
            return ip;
        }

        protected void logMain_Authenticate(object sender, AuthenticateEventArgs e)
        {
            var cliente = NtLinkClientFactory.Cliente();
            using (cliente as IDisposable)
            {
                string ip = GetIP();
                Session["NameIP"] = "IP Cliente: " + ip + ", Login:" + this.logMain.UserName;
              
                usuarios res = cliente.AdminLogin(this.logMain.UserName, this.logMain.Password,ip);
                //usuarios res = cliente.AdminLogin("Admin","AABBCc22++");
                if (res != null)
                {
                    
                    // Obtener las pantallas del usuario
                    var pantallas = cliente.GetAdminPantallas(res.idusuario);
                    Session["pantallas"] = pantallas;
                    Session["userId"] = res.idusuario;
                    Session["usuario"] = res;
                    e.Authenticated = true;
                }
                else
                {
                    e.Authenticated = false;
                }
            }
        }
    }
}