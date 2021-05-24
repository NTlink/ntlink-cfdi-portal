using System;
using System.Drawing;
using System.ServiceModel;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;
using ServicioLocalContract;
using System.Web;
using System.Threading;
using System.Web.Security;


namespace GafLookPaid
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
                 string  ip=GetIP();    
                  Session["NameIP"] = "IP Cliente: " + ip + ", Login:" + this.logMain.UserName;
                UsuarioLocal res = cliente.Login(this.logMain.UserName, this.logMain.Password, ip);
                if (res != null && res.Bloqueado == true  )
                {
                    int i = Membership.MaxInvalidPasswordAttempts;
                 
                    DateTime fecharegistro =  (DateTime)res.FechaBloqueo;
                    var minutos = (DateTime.Now-fecharegistro).TotalMinutes;
                    if (minutos < 0)
                        minutos = minutos * -1;
                    if (minutos > 30 && i<=Convert.ToInt16( res.numeroBloaquedo))
                    {
                        var clix = NtLinkClientFactory.Cliente();
                        using (cliente as IDisposable)
                        {
                            clix.DesbloquearUsuario(this.logMain.UserName);
                             res = cliente.Login(this.logMain.UserName, this.logMain.Password, ip);
              
                        }
         
                    }

                }

                if (res != null && res.UserName!=null)
                {
                  

                    var empresa = cliente.ObtenerEmpresaByUserId(res.UserId.ToString());
                    if (empresa != null)
                    {
                        
                        Session["UserNameRGV"] = this.logMain.UserName;//nueva linea para logeo CPP
                   
                        var pantallas = cliente.ObtenerPantallasPorIdEmpresa(empresa.IdEmpresa);
                        //var sistema = cliente.ObtenerSistemaById((int) empresa.idSistema.Value);
                        var sistema = cliente.ObtenerSistemaById((int)empresa.idSistema, true);
                        if (empresa.PrimeraVez || res.CambiarPassword == "1")
                        {
                            this.lblUserIdCambiarPassword.Text = res.UserId.ToString();
                            this.mpeCambiarPassword.Show();
                            e.Authenticated = false;
                            return;
                        }
                  
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
                        if ((dist!= null && dist.PrimeraVez == true) || res.CambiarPassword == "1")
                        {
                            this.lblUserIdCambiarPassword.Text = res.UserId.ToString();
                            this.mpeCambiarPassword.Show();
                            e.Authenticated = false;
                            return;
                        }
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

                    e.Authenticated = true;
                }
                else
                {
                    e.Authenticated = false;
                    if (res != null)
                    {
                        if (res.Bloqueado == false)
                            logMain.FailureText = "Error de contraseña: Intento " + res.numeroBloaquedo;
                        else
                            logMain.FailureText = "Error: Usuario bloqueado, favor de comunicarse o esperar 30 minutos e intente de nuevo.";
                    }
                }
            }
        }

        protected void btnAceptarPassword_Click(object sender, EventArgs e)
        {
            bool xx = false;
            var cliente = NtLinkClientFactory.Cliente();
            using (cliente as IDisposable)
            {
               xx= cliente.CambiarPassword(this.lblUserIdCambiarPassword.Text, this.txtPassword.Text);
            }

            if (xx)
            {
                this.lblMensajePas.Text = "Contraseña cambiada correctamente, para continuar de click en el boton de cerrar";
               lblMensajePas.Visible = true;
               Cerrar.Enabled = true;

            }
            else
            {
                lblMensajePas.Text = "Error al cambiar la contraseña intente de nuevo, para continuar de click en el boton de cerrar";
                lblMensajePas.Visible = true;
                Cerrar.Enabled = true;

            }

           // UpdatePanel1.Update();
       
            //Thread.Sleep(3000);


        }

        protected void btnOlvidar_Click(object sender, EventArgs e)
        {
            this.divPasswordChange.Visible = true;
        }

        protected void btnEnviarPass_Click(object sender, EventArgs e)
        {
            try
            {
                var cliente = NtLinkClientFactory.Cliente();
                using (cliente as IDisposable)
                {
                    if (cliente.RecuperarPassword(this.txtRfcOlvide.Text, this.txtOlvide.Text))
                    {
                        lblMensajePass.Text = "Se envió un email con la nueva contraseña";
                        lblMensajePass.Visible = true;
                    }

                }
            }
            catch (FaultException faultException)
            {
                lblMensajePass.Text = faultException.Message;
                lblMensajePass.Visible = true;
            }
        }

        protected void cb1_CheckedChanged(object sender, EventArgs e)
        {
            if (cb1.Checked)
                btnAceptarPassword.Enabled = true;
            else btnAceptarPassword.Enabled = false;
        }

       

        protected void Cerrar_Click(object sender, EventArgs e)
        {

            Session.Abandon();

            this.Response.Redirect("wfrLogin.aspx");
        }

        //protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
        //{



        //        if (CheckBox1.Checked == true)
        //        {
        //            this.btnAceptarPassword.Enabled = true;
        //            this.CheckBox1.Enabled = false;
        //            this.btnAceptarPassword.Focus();

        //        }

        //        lblMensajePas.Text = "Se ha cambiado correctamente su contraseña inserte de nuevo y de Click Aceptar ";
        //        lblMensajePas.Visible = true;

        //    }
        }
    }
