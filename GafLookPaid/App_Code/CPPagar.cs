using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GafLookPaid
{
    public class CPPagar
    {

        public string llenarURLCPP(string RFC, string correo)
        {
            string URL = "";
            try
            {


                TokenClass T = new TokenClass();

                string empre = "desarrollo.ntlink.com.mx";//"www.ntlink.com.mx";
                // correo = "alfredo.alarcon@ntlink.com.mx";
                string token = T.codificar(correo, empre);



                if (token != null)
                {
                    //quitar
                    //  ScriptManager.RegisterStartupScript(Page, Page.GetType(), "newWindow", "fnLoadPageInDialog('Default.aspx?op=view&Id=5665', 'divDocInfo', 'Documento Información', 820, 350);", true);
                    //    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "newWindow", "window.open('https://deploy.cuentasporpagar.com/usuarios/entrar','_blank','status=1,toolbar=0,menubar=0,location=1,scrollbars=1,resizable=1,width=500,toolbar=1');", true);

                    // string cadena="https://deploy.cuentasporpagar.com/clientes/mx/" + RFC + "/?jwt=" + token;
                    //  ScriptManager.RegisterStartupScript(Page, Page.GetType(), "newWindow", "window.open('" + cadena + "','_blank','status=1,toolbar=0,menubar=0,location=1,width=1000,height=800,scrollbars=0,resizable=1,toolbar=0');", true);


                    URL = @"https://cuentasporpagar.com/clientes/mx/" + RFC + "/?jwt=" + token;
                }
                else
                    URL = @"https://cuentasporpagar.com/usuarios/entrar";

                return URL;

            }
            catch (Exception ex)
            {
                URL = @"https://cuentasporpagar.com/usuarios/entrar";
                return URL;

                // frameMain.Attributes["src"] = "https://deploy.cuentasporpagar.com/usuarios/entrar";
                //frameMain.Attributes.Add("style", "min-height:100%,width:100%;");

                //Logger.Error(ex.Message);
            }
        }


    }


}