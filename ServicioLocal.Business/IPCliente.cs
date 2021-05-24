using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net;
using System.Web;

namespace ServicioLocal.Business
{
    public class IPCliente : NtLinkBusiness
    {
        public static void GetIP(string ip)
        {

            Logger.Error("IP Cliente:"+ip);
            /*
            String ip = "";
            try
            {
                ip = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
            }
            catch(Exception){}

            if (string.IsNullOrEmpty(ip))
            {
                ip = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
            }

            return ip;
             */ 
        }
    
    }
}
