using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.Drawing;
using System.Configuration;
using ServicioLocalContract;
using System.Data;
using System.IO;
using System.ServiceModel;



namespace GafLookPaid
{
    public partial class registroClientes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            try
            {



                string nombrecompleto = txtRFC.Text + " " + txtEmpresa.Text ;
                string correoAenviar = ConfigurationManager.AppSettings["correoGratuito"];

                MailMessage correo = new MailMessage();
                correo.IsBodyHtml = true;
                correo.From = new MailAddress(nombrecompleto + "<" + txtEmail.Text + ">");
                correo.To.Add(new MailAddress(correoAenviar));
                correo.Subject = "Registro / Alta de clientes"; //txtTitulo.Text;
                correo.Body =  "RFC: " + txtRFC.Text + "<br/>" + 
                               "Razón Social: " + txtEmpresa.Text + "<br/>" +
                               "Régimen Fiscal: " + txtNombre.Text + "<br/>" +
                               "Dirección:" + txtApellidoP.Text + "<br/>" +
                               "Colonia : " + txtcolonia.Text + "<br/>" +
                               "Delegación o Municipio : " + txtExtension.Text + "<br/>" +
                               "C.P: " + txtMovil.Text + "<br/>" +
                               "Estado : " + txtestado.Text + "<br/>" +
                               "Télefono de Contacto : " + txtTelefono.Text + "<br/>" + 
                               "Email : " + txtEmail.Text + "<br/>" +
                               "Ejecutivo de Ventas: " + txtApellidoM.Text + "<br/>" +                            
                               "Observaciones: " + txtAsesorv.Text;


              
                
                if (archivoPagos.PostedFile != null)

                {

                    try

                    {

                        string strFileName =  System.IO.Path.GetFileName(archivoPagos.PostedFile.FileName);

                        Attachment attachFile =

                        new Attachment(archivoPagos.PostedFile.InputStream, strFileName);

                        correo.Attachments.Add(attachFile);

                    }

                    catch

                    {



                    }

                }






                SmtpClient client = new SmtpClient();
                client.Send(correo);


                

                //lblMensajeError.Text = " Mensaje enviado correctamente";
                // lblMensajeError.ForeColor = Color.Green;
                Mensaje("Registro enviado correctamente");

                txtRFC.Text = "";
                txtEmpresa.Text = "";
                txtNombre.Text = "";
                txtApellidoP.Text = "";
                txtcolonia.Text = "";
                txtApellidoM.Text = "";
                txtestado.Text = "";
                txtEmail.Text = "";
                txtTelefono.Text = "";
                txtExtension.Text = "";
                txtMovil.Text = "";
                txtAsesorv.Text = "";

            }


            catch (Exception ex)
            {
                Mensaje("Error al enviar, favor comuniquese con soporte Ntlink");
                //lblMensajeError.Text = "Error al enviar, favor contacte al administrador admin@dominio.com ";
                //lblMensajeError.ForeColor = Color.Red;
            }
            finally
            {

            }
        }
        private void Mensaje(string mensaje)
        {
            string msg = string.Format("alert('{0}');", mensaje);
            ScriptManager.RegisterClientScriptBlock(this.Page, Page.ClientScript.GetType(), "myscript", msg, true);
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            this.Response.Redirect("~/wfrLogin.aspx");
        }

        protected void txtEmail_TextChanged(object sender, EventArgs e)
        {

        }


        //---------------------------------------------------------------------------------------------------------------------
    

        
    }
}