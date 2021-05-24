using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ServicioLocalContract;

namespace GafLookPaid
{
    public partial class Token : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {

                // string UserName ="";
                string token = "";
                Session["UserNameRGV"] = null;
                //Response.Write("<p>RGV esto :" + s + "," + s2 + "," + s3 + "</p>");  
                try
                {
                   //  UserName = Page.RouteData.Values["RFC"].ToString();// "ricardo.gomez@ntlink.com.mx";
                    // token = Page.RouteData.Values["token"].ToString();// "Ricardin123#";
                    token = Request.QueryString["jwt"];
                 
                    TokenClass T = new TokenClass();
                    if (token != null) //trae datos el token
                    {
                        string TokenEmpresa = T.CuerpoDecode(token);

                        T.decodificar(token);

                        if (T.Error == "0") //si no hay problemas en el token
                        {
                            string salida = T.Correo;
                            Session["UserNameRGV"] = T.Correo;
                            logMain_Authenticate(salida);

                        }
                        else  //error en el token
                        {
                            Session["userId"] = null;
                            this.Response.Redirect("~/wfrLogin.aspx");
                        }
                    }

                    else //no trae datos el token
                    {
                        Session["userId"] = null;
                        this.Response.Redirect("~/wfrLogin.aspx");
                    }

                }
                catch (Exception ex)
                {
                    Session["userId"] = null;
                    this.Response.Redirect("~/wfrLogin.aspx");
                }


            } 

        }
        //---------------------------------------------
        protected void logMain_Authenticate(string UserName)
        {
           
            var cliente = NtLinkClientFactory.Cliente();
            using (cliente as IDisposable)
            {
                UsuarioLocal res = cliente.LoginToken(UserName);
                if (res != null)
                {
                    var empresa = cliente.ObtenerEmpresaByUserId(res.UserId.ToString());
                    if (empresa != null)
                    {
                        var pantallas = cliente.ObtenerPantallasPorIdEmpresa(empresa.IdEmpresa);
                        var sistema = cliente.ObtenerSistemaById((int)empresa.idSistema.Value);
                      /*  if (empresa.PrimeraVez || res.CambiarPassword == "1")
                        {
                            this.lblUserIdCambiarPassword.Text = res.UserId.ToString();
                            this.mpeCambiarPassword.Show();
                            e.Authenticated = false;
                            return;
                        }*/
                        Session["idEmpresa"] = empresa.IdEmpresa;
                        Session["idSistema"] = empresa.idSistema;
                        Session["razonSocial"] = empresa.RazonSocial;
                        Session["perfil"] = res.Perfil;
                        Session["userId"] = res.UserId;
                        Session["nombre"] = res.NombreCompleto;
                        Session["iniciales"] = res.Iniciales;
                        Session["empresa"] = empresa;
                        Session["panatallas"] = pantallas;
                        Session["TipoSistema"] = sistema.TipoSistema;
                        Session["SaldoEmision"] = sistema.SaldoEmision;
                        Session["SaldoTimbrado"] = sistema.SaldoTimbrado;
                        Session["Contratos"] = sistema.TimbresContratados;
                        Session["RGVRFC"] = empresa.RFC;// agregado para cuentas por pagar


                    

                    }
                    else
                    {
                        var dist = cliente.ObtenerDIsById(res.UserId.ToString());
                        /*if ((dist != null && dist.PrimeraVez == true) || res.CambiarPassword == "1")
                        {
                            this.lblUserIdCambiarPassword.Text = res.UserId.ToString();
                            this.mpeCambiarPassword.Show();
                            e.Authenticated = false;
                            return;
                        }*/
                        if (dist != null)
                        {
                            Session["IdDistribuidor"] = dist.IdDistribuidor;
                            Session["razonSocial"] = dist.RazonSocial;
                            Session["tipoSistema"] = dist.TipoSistema;
                            Session["nombre"] = dist.Nombre;
                            Session["empresa"] = dist;
                        }

                        Session["perfil"] = res.Perfil;
                        Session["userId"] = res.UserId;

                        Session["iniciales"] = res.Iniciales;

                    }

                    this.Response.Redirect("~/Default.aspx", false);
                   // e.Authenticated = true;
                }
                else
                {
                    Session["userId"] = null;
                    this.Response.Redirect("~/wfrLogin.aspx");
                    //e.Authenticated = false;
                }
            }
        }

    }
}