using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Net.Mail;
using System.Configuration;
using System.Net.Mime;
using System.ServiceModel;
using System.Text;
using ServicioLocalContract;
using System.ComponentModel;

namespace ServicioLocal.Business
{
    public class Mailer : NtLinkBusiness
    {
         string _host;
         string _port;
         string _username;
         string _password;

        string CorreoAct;//nuevo 
        public string Bcc { get; set; }
        bool ssl { get; set; }
        bool tipoServidor { get; set; }


        public Mailer()
        {
            var sslbool = ConfigurationManager.AppSettings["enableSsl"];
            if (sslbool != null)
                ssl = Boolean.Parse(sslbool);
            else
                ssl = false;  

            _host = ConfigurationManager.AppSettings["Host"];
            _port = ConfigurationManager.AppSettings["Port"];

            CorreoActual c = new CorreoActual();//nuevo
            _username= c.leerCorreoActual();//nuevo
            //_username = ConfigurationManager.AppSettings["UserName"];
            CorreoAct = c.correoA;//nuevo
           _password = ConfigurationManager.AppSettings["Password"];

           tipoServidor = true;
        }
         
        public void Send(List<string> recipients, List<EmailAttachment> attachments, string message, string subject, string fromEmail, string fromDescription)
        {
            try
            {
                Logger.Debug("Enviando a " + recipients.Count + " emails");

                if (fromEmail.Contains("@yahoo.com"))//por cuestiones de las politicas de yahoo no permite enviar los correos con distinto frommail y correodeenvio
                {

                    message = message + "<br/><br/><br/>\"Si necesita responder este correo favor de dirigirlo a\"";
                    message = message + " <b>" + fromEmail + "</b>";
                    fromEmail = this._username;
                }
                //----------------------------------
                var client = new SmtpClient
                {
                    Host = this._host,
                    Port = int.Parse(this._port),
                    DeliveryMethod = SmtpDeliveryMethod.Network,
                    UseDefaultCredentials = false,
                    
                    Credentials = new NetworkCredential(this._username, this._password)
                };
                client.EnableSsl = ssl;

                if (client.Host == "smtp.office365.com")//---------------
                    fromEmail = this._username;

                Logger.Info("Creando MailMessage");
                var mailMsg = new MailMessage
                {
                    Sender = new MailAddress(_username),
                    From = new MailAddress(fromEmail, fromDescription),
                    Subject = subject,
                    DeliveryNotificationOptions = DeliveryNotificationOptions.OnSuccess,
                    Body = message,
                    BodyEncoding = Encoding.UTF8
                };

                Logger.Info("Cargando Bcc: " + Bcc);
                if (!string.IsNullOrEmpty(Bcc))
                    mailMsg.Bcc.Add( new MailAddress(Bcc));
                mailMsg.Headers.Add("Disposition-Notification-To", _username);
                mailMsg.IsBodyHtml = true;
                int i = 0;

                Logger.Info("Agregando attach");

                foreach (EmailAttachment attachment in attachments)
                {
                    MemoryStream mStream = new MemoryStream();

                    mStream.Write(attachment.Attachment, 0, attachment.Attachment.Length);
                    mStream.Position = 0;
                    mailMsg.Attachments.Add(new Attachment(mStream,attachment.Name));
                }
                foreach (var recipient in recipients)
                {
                    Logger.Info("Enviando a la direccion: " + recipient);
                    if (!string.IsNullOrEmpty(recipient))
                        mailMsg.To.Add(new MailAddress(recipient));
                }
               // client.TargetName = "STARTTLS/smtp.office365.com";
                //ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls;
                //ServicePointManager.ServerCertificateValidationCallback = (sender, certificate, chain, sslPolicyErrors) => true;
                
                client.Send(mailMsg);
                CorreoActual c = new CorreoActual();
                c.escribirCorreoActual(CorreoAct);//nuevo
                Logger.Debug("Enviado correctamente");
            }
            catch (Exception ex)
            {
                if (tipoServidor)
                {
                    tipoServidor = false;
                    ConfigurarServidorSecundario();
                    Send(recipients, attachments, message, subject, fromEmail, fromDescription);

                }
                else
                {
                    Logger.Error(ex);
                    throw new FaultException("Ocurrio un error al enviar el correo");
                }
            }

        }

        public void Send(List<string> recipients, List<string> attachments, string message, string subject,string fromEmail, string fromDescription)
        {
            try
            {

                if (fromEmail.Contains("@yahoo.com"))//por cuestiones de las politicas de yahoo no permite enviar los correos con distinto frommail y correodeenvio
                {

                    message = message + "<br/><br/><br/>\"Si necesita responder este correo favor de dirigirlo a\"";
                    message = message + " <b>" + fromEmail + "</b>";
                    fromEmail = this._username;
                }
                //----------------------------------
              

                var client = new SmtpClient
                {
                    Host = this._host,
                    Port = int.Parse(this._port),
                    DeliveryMethod = SmtpDeliveryMethod.Network,
                    UseDefaultCredentials = false,
                    Credentials = new NetworkCredential(this._username, this._password)
                };
                client.EnableSsl = ssl;

                if (client.Host == "smtp.office365.com")//---------------
                    fromEmail = this._username;

                var mailMsg = new MailMessage
                {
                    Sender = new MailAddress(_username),
                    From = new MailAddress(fromEmail, fromDescription),
                    Subject = subject,
                    DeliveryNotificationOptions = DeliveryNotificationOptions.OnSuccess,
                    Body = message,
                    BodyEncoding = Encoding.UTF8
                };
                mailMsg.Headers.Add("Disposition-Notification-To", _username);
                mailMsg.IsBodyHtml = true;
                foreach (string attachment in attachments)
                {
                    mailMsg.Attachments.Add(new Attachment(attachment));
                }
                foreach (var recipient in recipients)
                {
                    mailMsg.To.Add(new MailAddress(recipient));
                }
                client.Send(mailMsg);
                CorreoActual c = new CorreoActual();
                c.escribirCorreoActual(CorreoAct);//nuevo
            }
            catch (Exception ex)
            {
                if (tipoServidor)
                {
                    tipoServidor = false;
                    ConfigurarServidorSecundario();
                    Send(recipients, attachments, message, subject, fromEmail, fromDescription);

                }
                else
                {
                    Logger.Error(ex);
                    throw new FaultException("Ocurrio un error al enviar el correo");
                }
            }
            
        }

        private void ConfigurarServidorSecundario()
        {

          var sslbool = ConfigurationManager.AppSettings["enableSslS2"];
            if (sslbool != null)
                ssl = Boolean.Parse(sslbool);
            else
                ssl = false;  

            _host = ConfigurationManager.AppSettings["HostS2"];
            _port = ConfigurationManager.AppSettings["PortS2"];

           _username = ConfigurationManager.AppSettings["UserNameS2"];
           _password = ConfigurationManager.AppSettings["PasswordS2"];
        
        
        }
       
        //------------------------------------------------------------------
    }
}
