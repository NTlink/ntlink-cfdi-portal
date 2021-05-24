using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using ServicioLocalContract;

namespace NtLinkAdministracion
{
    public class Global : System.Web.HttpApplication
    {

        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup

        }

        void Application_End(object sender, EventArgs e)
        {
            //  Code that runs on application shutdown

        }

        void Application_Error(object sender, EventArgs e)
        {
            // Code that runs when an unhandled error occurs

        }

        void Session_Start(object sender, EventArgs e)
        {
            // Code that runs when a new session is started

        }

        void Session_End(object sender, EventArgs e)
        {
            // Code that runs when a session ends. 
            // Note: The Session_End event is raised only when the sessionstate mode
            // is set to InProc in the Web.config file. If session mode is set to StateServer 
            // or SQLServer, the event is not raised.
            try
            {
                string nombre = Session["NameIP"].ToString();
                var cliente = NtLinkClientFactory.Cliente();
                cliente.SetFinSession(nombre);

                // Server.ClearError();
                //HttpContext.Current.ClearError();
                // Finally redirect, transfer, or render a error view
                // Response.Redirect("wfrLogin.aspx",false);

                // Context.ApplicationInstance.CompleteRequest();
                // Context.Response.Redirect(""); 
                /*
                HttpContext.Current.Response.Redirect("~/wfrLogin.aspx", false);

                 HttpContext.Current.Response.Clear();

                 HttpContext.Current.ApplicationInstance.CompleteRequest();

                 return;*/
            }
            catch (Exception ex) { }
        }

    }
}
