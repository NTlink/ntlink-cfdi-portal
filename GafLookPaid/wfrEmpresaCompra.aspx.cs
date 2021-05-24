using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using ServicioLocalContract;
using System.Collections.Generic;
using System.Linq;
using System.Configuration;
using System.Data;
using System.IO;
using System.ServiceModel;
using System.Web;
using System.Net.Mail;

namespace GafLookPaid
{
    public partial class wfrEmpresaCompra : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                this.FillView();
            }
        }

        #region HelperMethods

        private void FillView()
        {
            var clienteServicio = NtLinkClientFactory.Cliente();
            var cliente = NtLinkClientFactory.Cliente();
            var idSistema = Session["idSistema"] as long?;
            var idEmpresa = Session["idEmpresa"] as int?;
            Sistemas sistemas = clienteServicio.ObtenerSistemaById(Convert.ToInt32(idSistema), true);
            string promotor = GetInfoPromotor("Nombre", Convert.ToInt32(sistemas.IdPromotor));
            string Email = GetInfoPromotor("Email", Convert.ToInt32(sistemas.IdPromotor));
            //if (Email.Contains("noasigando") || Email == "No existe registo")
            //{
            //    Email = "informes@ntlink.com.mx";
            //}
            //else if (Email == "atnclientes@ntlink.com.mx")
            //    Email = "ivonne.ahuatzi@ntlink.com.mx";

            //LblIdEmpresa.Text = idSistema.ToString() + " - " + idEmpresa.ToString() + " - " + Session["razonSocial"].ToString() + " - " + Session["RFC"].ToString();

            #region Datos empresa
            LblIdEmpresa.Text = Session["razonSocial"].ToString();
            LblRFC.Text = sistemas.Rfc;
           lblcorreo.Text= sistemas.Email;
            #endregion


            //LblIdPromotor.Text = sistemas.IdPromotor + " - " + promotor + " - " + Email;
            LblIdPromotor.Text = promotor;
            lblcorreo0.Text = Email;



            txtFechaPago.Text = DateTime.Now.AddDays(-1).ToString("dd/MM/yyyy");
            txtHora.Text = DateTime.Now.ToString("HH:mm:ss");
            LlenarPack();
        }

        #endregion

        //------------------------------------------------------------------------------------------------
        protected string GetInfoPromotor(string dato, int idsistema)
        {
            try
            {
                var clienteServicio = NtLinkClientFactory.Cliente();
                List<Promotores> db = clienteServicio.ObtenerPromotores();
                List<Promotores> y = db.Select(
                    p =>
                    new Promotores()
                    {
                        Nombre = p.Nombre,
                        Email = p.Email,
                        IdPromotor = p.IdPromotor

                    }).Where(p => p.IdPromotor == idsistema).ToList();
                //var x = db.ToList().Where(p => p.IdPromotor == idsistema);

                if (y.Count > 0)
                {
                   
                    if (dato == "Nombre")
                        return y.First().Nombre;
                    else if (dato == "Email")
                        return y.First().Email;
                    else
                        return "Campo no encontrado";
                }
                else
                {
                    return "informes@ntlink.com.mx"; 
               }


            }
            catch (Exception ee)
            {
                return "";
            }
        }

        protected void btnEnviar_Click(object sender, EventArgs e)
        {
          


            if (ValidarPago())
            {


                var cliente = NtLinkClientFactory.Cliente();
                byte[] comprobante = null;
                var idSistema = Session["idSistema"] as long?;
                var clienteServicio = NtLinkClientFactory.Cliente();
                Sistemas sistemas = clienteServicio.ObtenerSistemaById(Convert.ToInt32(idSistema), true);
                var atts = new List<EmailAttachment>();
                var emails = new List<string>();
                var idEmp = Session["idEmpresa"] as int?;
                string email = GetInfoPromotor("Email", Convert.ToInt32(sistemas.IdPromotor));


                string correoAenviar = ConfigurationManager.AppSettings["correoGratuito"];


               




                    MailMessage correo = new MailMessage();
                correo.From = new MailAddress(correoAenviar);
                correo.To.Add(new MailAddress(email));
                MailAddress bcc = new MailAddress("news@ntlink.com.mx","Comprobante de Pago");
                correo.Bcc.Add(bcc);

                correo.IsBodyHtml = true;

                correo.Subject = "Comprobante de pago";

                #region Mensaje


                string paq;
                string msj = "";
                correo.Body = "**********<b>Comprobante de pago</b>**********<br /><br />----------<b>Información</b>----------<br /><pre><b>Empresa: </b>"

                    + sistemas.RazonSocial + " - " +
                    sistemas.Rfc + "<br /><pre><b>" +
                    "Contacto: </b>" + sistemas.Email +
                    "<br /><br /><pre><b>Asesor de ventas: </b>" + GetInfoPromotor("Nombre", Convert.ToInt32(sistemas.IdPromotor))
                    + "<br /><br />----------<b>Detalles del pago</b>----------<br /><pre>" +
                    "<b>Fecha y hora de Pago: </b>" + txtFechaPago.Text + " " +
                    txtHora.Text + " Hrs.<br /><pre><b>" +
                    "Paquete:  </b>" + ddlPaquete.SelectedValue + "<br/>" + "Tipo de pago: " + ddlTipodePago.SelectedValue + "<br/>" + "Monto pagado: " + txtMonto.Text + "<br/>" + "Comentarios: " + txtDetalles.Text + "<br>" + "Paquete para: " + rbStatus.SelectedValue + "<br>" + " Folios de: " + rbcant.SelectedValue + "<br>" + "Para factuacion: " + cantif.Text + "<br>" + "Para nomina: " + cantin.Text + "<br>" +

                  "<br /><br />----------<b>Datos de Facturacion</b>----------<br /><pre>" +
                    "<b>RFC: </b>" + txtRFC.Text + " <br/>" +
                    "<b>Razón Social: </b>" + txtEmpresa.Text + "<br/> " +
                    "<b>Correo: </b>" + txtcorreo.Text + "<br/> " +
                    "<b>Dirección: </b>" + txtExtension.Text + "<br/> "+
                    "<b>C.P.: </b>" + txtCP.Text + " ";

                //if (ddlTipodePago.SelectedValue == "01")
                //    paq = "Deposito";
                //else if (ddlTipodePago.SelectedValue == "02")
                //   paq= "Cheque";
                //else if (ddlTipodePago.SelectedValue == "03")
                //   paq= "Transferencia";


                //msj += "<br /><pre><b>Refrencia: </b>" + txtReferencia.Text + "<br /><pre><b>Paquete contratado: </b>" + rbStatus.Text + " - " + ddlPaquete.Text
                //    + "<br /><pre><b>Monto Pagado: </b>" + Convert.ToDouble(txtMonto.Text).ToString("C");
                if (!string.IsNullOrEmpty(txtDetalles.Text))
                    msj += "<br /><pre><b>Comentarios: </b>" + txtDetalles.Text;
                msj += "<br /><br />**********<b>Comprobante enviado el: " + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") + "</b>**********";
                #endregion
                
                //   email = "ivonne.ahuatzi@ntlink.com.mx";
               emails.Add(email);



                if (archivoPagos.PostedFile != null)

                {

                    try

                    {

                        string strFileName = System.IO.Path.GetFileName(archivoPagos.PostedFile.FileName);

                        Attachment attachFile =

                        new Attachment(archivoPagos.PostedFile.InputStream, strFileName);

                        correo.Attachments.Add(attachFile);

                    }

                    catch

                    {



                    }

                }
                else
                {
                    try
                    {
                        cliente.SendMailByteArray(emails, atts, msj, "Envio de Comprobante de Pago " + sistemas.Rfc + " - " + sistemas.RazonSocial + " " + DateTime.Now.ToString("dd/MM/yyyy HH:mm") + " " + ddlPaquete.Text, sistemas.Email, sistemas.RazonSocial);
                        lblValidacion.Text = "Enviado";
                       
                    }
                    catch (FaultException fe)
                    {
                        lblValidacion.Text = fe.Message;
                    }
                }
                mpeCFDIG.Show();
                SmtpClient client = new SmtpClient();
                client.Send(correo);
                limpia();


            }
        }


        protected bool ValidarPago()
        {
            if (ddlTipodePago.SelectedValue == "00")
            {
                this.lblValidacion.Text = "Seleccione un Tipo de Pago";
                return false;
            }
            var fecha = DateTime.ParseExact(txtFechaPago.Text, "dd/MM/yyyy", new System.Globalization.CultureInfo("es-MX"));
            if (fecha > DateTime.Now)
            {
                this.lblValidacion.Text = "La Fecha de Pago esta fuera de rango";
                return false;
            }
            if (!ValidaHora())
                return false;
            if (ddlPaquete.SelectedValue == "0")
            {
                this.lblValidacion.Text = "Selecciona un Paquete.";
                
                
                return false;
            }
            return true;
        }
        private bool ValidaHora() {
            if (txtHora.Text.Substring(2, 1) == ":" && txtHora.Text.Substring(5, 1) == ":")
            {
                try
                {
                    int[] hora = new int[3];
                    hora[0] = Convert.ToInt32(txtHora.Text.Substring(0, 2));
                    hora[1] = Convert.ToInt32(txtHora.Text.Substring(3, 2));
                    hora[2] = Convert.ToInt32(txtHora.Text.Substring(6, 2));
                    var fecha = DateTime.ParseExact(txtFechaPago.Text, "dd/MM/yyyy", new System.Globalization.CultureInfo("es-MX"));

                    if (fecha.ToString("dd/MM/yyyy") == DateTime.Now.ToString("dd/MM/yyyy"))
                    {
                        if (hora[0] < DateTime.Now.Hour)
                        {
                            return true;
                        }
                        else if (hora[0] == DateTime.Now.Hour && hora[1] < DateTime.Now.Minute) {
                            return true;
                        }
                        else if (hora[0] == DateTime.Now.Hour && hora[1] == DateTime.Now.Minute && hora[2] < DateTime.Now.Second)
                        {
                            return true;
                        }
                        this.lblValidacion.Text = "La fecha y Hora no puede ser mayor a la actual.";
                        return false;
                    }
                    else
                    {
                        if (hora[0] <= 23 && hora[1] <= 59 && hora[2] <= 59)
                        {
                            return true;
                        }
                    }
                    this.lblValidacion.Text = "El dato para Hora, Minuto o Segundo, no se encuentra dentro de los parametros correctos.";
                    return false;
                }
                catch
                {
                    this.lblValidacion.Text = "No se utilizaron datos validos para establecer una hora de pago.";
                    return false;
                }
            }
            this.lblValidacion.Text = "El campo de hora no tiene el formato correcto.";
            return false;
        }
        protected void ddlTipodePago_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlTipodePago.SelectedValue == "00")
            {
                img.Visible = false;
                img.Src = "/";
            }
            else if (ddlTipodePago.SelectedValue == "Deposito")
            {
                img.Visible = true;
                img.Src = "images/D.jpg";
            }
            else if (ddlTipodePago.SelectedValue == "Cheque")
            {
                img.Visible = true;
                img.Src = "images/C.png";
            }
            else if (ddlTipodePago.SelectedValue == "Transferencia")
            {
                img.Visible = true;
                img.Src = "images/T.png";
            }
        }

        protected void LlenarPack() {
            int[,] Paq = new int[,]{{ 25, 50, 100, 150, 200, 300, 500, 750, 1000, 2000, 5000 },
                {445,505,530,760,955,1335,2095,2545,3135,5410,7355},{1000,2000,3000,5000,7500,10000,15000,20000,50000,100000,0 },
                {1170,1840,2560,4065,5615,6905,10060,10815,23795,37855,0 } };
            System.Data.DataTable workTable = new System.Data.DataTable();
            workTable.Columns.Add("Paquete", typeof(String));
            workTable.Columns.Add("NFolios", typeof(String));
            workTable.Columns.Add("Precio", typeof(String));

            System.Data.DataRow workRow = workTable.NewRow();
            workRow[0] = "---Seleccionar---";
            workRow[1] = "0";
            workRow[2] = "0";
            workTable.Rows.Add(workRow);


            if (rbStatus.SelectedValue == "Facturación Completa")
            {
                for (int i = 0; i < 11; i++) {
                    workRow = workTable.NewRow();
                    workRow[0] = Paq[0, i].ToString("N0") + " Folios";
                    workRow[1] = Paq[0, i].ToString("N0") + " Folios";
                    workRow[2] = Paq[1, i];
                    workTable.Rows.Add(workRow);

                    rbcant.Visible = true; 
                }
            }
            else if (rbStatus.SelectedValue == "Timbrado")
            {
                for (int i = 0; i < 10; i++)
                {
                    workRow = workTable.NewRow();
                    workRow[0] = Paq[2, i].ToString("N0") + " Timbres";
                    workRow[1] = Paq[2, i].ToString("N0") + " Timbres";
                    workRow[2] = Paq[3, i];
                    workTable.Rows.Add(workRow);
                    rbcant.Visible = false;

                }
            }


           
            

            workRow = workTable.NewRow();
            workRow[0] = "Otro";
            workRow[1] = "000";
            workRow[2] = "000";
            workTable.Rows.Add(workRow);

            this.ddlPaquete.DataSource = workTable;
            this.ddlPaquete.DataTextField = workTable.Columns[0].ToString();
            this.ddlPaquete.DataValueField = workTable.Columns[1].ToString();
            this.ddlPaquete.DataBind();
            

        }

        protected void division()
        {
            if (rbcant.SelectedValue == "Ambos")
            {
                txtfac.Visible = true;
                txtnom.Visible = true;
                cantif.Visible = true;
                cantin.Visible = true;
            }
            else
            {
                txtfac.Visible = false;
                txtnom.Visible = false;
                cantif.Visible = false;
                cantin.Visible = false;

            }

        }


        protected void rbStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            LlenarPack();
        }

        protected void btnCerrar_Click(object sender, EventArgs e)
        {
            Response.Redirect("wfrEmpresaCompra.aspx");
        }

        protected void rbcant_SelectedIndexChanged(object sender, EventArgs e)
        {
            division(); 
        }


        protected void limpia()
        {
            ddlPaquete.SelectedValue = "0";
            this.txtReferencia.Text = "";
            this.txtFechaPago.Text = "";
            this.txtHora.Text = "";
            rbStatus.ClearSelection();
            rbcant.Visible = false;
            ddlTipodePago.SelectedValue = "00";
            txtfac.Visible = false;
            txtnom.Visible = false;
            cantif.Visible = false;
            cantin.Visible = false;
            txtDetalles.Text = "";
            txtMonto.Text = "";
            txtRFC.Text = "";
            txtEmpresa.Text = "";
            txtcorreo.Text = "";
            txtExtension.Text = "";
            txtCP.Text = "";






        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            mpeCFDIG.Hide();

        }




        //------------------------------------------------------------------------------------------------





    }

    
    }
