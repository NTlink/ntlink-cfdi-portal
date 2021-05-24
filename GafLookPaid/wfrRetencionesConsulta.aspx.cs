using System;
using System.Collections.Generic;
using System.Drawing;
using System.Globalization;
using System.IO;
using System.ServiceModel;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;
using ServicioLocalContract;
using System.Text;
using System.Linq;
using Label = System.Web.UI.WebControls.Label;
using System.Configuration;

namespace GafLookPaid
{
    public partial class wfrRetencionesConsulta : System.Web.UI.Page
    {

        public string SelText = "Todo";
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!this.IsPostBack)
            {
                var perfil = Session["perfil"] as string;
                var sistema = Session["idSistema"] as long?;
                var idEmp = Session["idEmpresa"] as int?;
                var cliente = NtLinkClientFactory.Cliente();
                using (cliente as IDisposable)
                {
                    string guidString = ((Guid)Session["userId"]).ToString();
                    empresa empresa = cliente.ObtenerEmpresaByUserId(guidString);

                    Session["RGVrfc"]= empresa.RFC;
                    int empresaId = perfil != null && perfil.Equals("Administrador") ? 0 : empresa.IdEmpresa;
                    this.ddlClientes.Items.Clear();
                    this.ddlClientes.DataSource = cliente.ListaClientes(perfil, empresaId, string.Empty, true);
                    this.ddlClientes.DataBind();
                    this.ddlEmpresas.DataSource = cliente.ListaEmpresas(perfil, idEmp.Value, sistema.Value, null);
                    this.ddlEmpresas.Enabled = perfil.Equals("Administrador");
                    this.ddlEmpresas.DataBind();
                    this.txtFechaInicial.Text = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1).ToString("d");
                    this.txtFechaFinal.Text = DateTime.Today.ToString("d");
                    ddlEmpresas_SelectedIndexChanged(null,null);
                }
                this.FillView();
            }
        }

        protected void gvFacturas_RowCommand(object sender, GridViewCommandEventArgs e)
        {
           
            if(e.CommandName.Equals("DescargarXml"))
            {
                string uuid = this.gvFacturas.Rows[Convert.ToInt32(e.CommandArgument)].Cells[1].Text;
                string rfc = Session["RGVrfc"].ToString();
                //string rfc = this.gvFacturas.Rows[Convert.ToInt32(e.CommandArgument)].Cells[0].Text;
                string fecha = this.gvFacturas.Rows[Convert.ToInt32(e.CommandArgument)].Cells[2].Text;
                string id = this.gvFacturas.Rows[Convert.ToInt32(e.CommandArgument)].Cells[0].Text;
                DateTime f = new DateTime();
                f = Convert.ToDateTime(fecha);
                var cliente = NtLinkClientFactory.Cliente();
                using (cliente as IDisposable)
                {
                    try
                    {
                        //var id = (int)this.gvFacturas.DataKeys[Convert.ToInt32(e.CommandArgument)].Values["folio"];
                        //var cfd = cliente.GetFactura(id);
                        var bytesRes = cliente.RetencionPdfXML(uuid, rfc, "xml");
                        if (bytesRes == null)
                        {
                            this.lblError.Text = "Archivo no encontrado";
                            return;
                        }
                        string xml = Encoding.UTF8.GetString(bytesRes);
                        if (xml == "")
                        {
                            this.lblError.Text = "Archivo no encontrado";
                            return;
                        }
                            //Response.AddHeader("Content-Disposition", "attachment; filename=" + uuid + ".xml");
                        Response.AddHeader("Content-Disposition", "attachment; filename=" + rfc + "_" + id + "_" + f.ToString("yyyyMMdd") + "_" + uuid + ".xml");
                        this.Response.ContentType = "text/xml";
                        this.Response.Charset = "UTF-8";
                        this.Response.Write(xml);
                        this.Response.End();
                    }
                    catch (FaultException fe)
                    {
                        this.lblError.Text = "Archivo no encontrado";
                        return;
                    }
                }
            }
            else if (e.CommandName.Equals("DescargarPdf"))
            {
                try{
                string uuid = this.gvFacturas.Rows[Convert.ToInt32(e.CommandArgument)].Cells[1].Text;
                string rfc = Session["RGVrfc"].ToString();
                    //string rfc = this.gvFacturas.Rows[Convert.ToInt32(e.CommandArgument)].Cells[0].Text;
                string fecha = this.gvFacturas.Rows[Convert.ToInt32(e.CommandArgument)].Cells[2].Text;
                string id = this.gvFacturas.Rows[Convert.ToInt32(e.CommandArgument)].Cells[0].Text;
                DateTime f = new DateTime();
                f = Convert.ToDateTime(fecha);
                var cliente = NtLinkClientFactory.Cliente();
                using (cliente as IDisposable)
                {
                  //  var id = (int)this.gvFacturas.DataKeys[Convert.ToInt32(e.CommandArgument)].Values["idventa"];
                 
                    //var cfd = cliente.GetFactura(id);
                    Response.AddHeader("Content-Disposition", "attachment; filename=" + rfc + "_" + id + "_" + f.ToString("yyyyMMdd") + "_" + uuid + ".pdf");
                    //Response.AddHeader("Content-Disposition", "attachment; filename=" +  uuid + ".pdf");
                    this.Response.ContentType = "application/pdf";
                    var pdfSalida = cliente.RetencionPdfXML(uuid,rfc,"pdf");
                   
                    if (pdfSalida == null)
                        {
                            this.lblError.Text = "Archivo no encontrado";
                            return;
                        }
                        this.Response.BinaryWrite(pdfSalida);
                        this.Response.End();
                   

                }
                }
                catch (FaultException fe)
                {
                    this.lblError.Text = "Archivo no encontrado";
                    return;
                }
            }
            else if (e.CommandName.Equals("EnviarEmail"))
            {

                var idCliente = (int) this.gvFacturas.DataKeys[Convert.ToInt32(e.CommandArgument)].Values["idCliente"];
                //string rfc = this.gvFacturas.Rows[Convert.ToInt32(e.CommandArgument)].Cells[0].Text;
                string rfc = Session["RGVrfc"].ToString();
                var cliente = NtLinkClientFactory.Cliente();
                using (cliente as IDisposable)
                {
                    clientes c = cliente.ObtenerClienteById(idCliente);
                    this.lblEmailCliente.Text = c.Email;
                    this.lblRFCEmpresa.Text = rfc;
                }
                this.lblGuid.Text = this.gvFacturas.Rows[Convert.ToInt32(e.CommandArgument)].Cells[1].Text;
                this.mpeEmail.Show();
            }
            else if(e.CommandName.Equals("Pagar"))
            {
                var id = (int)this.gvFacturas.DataKeys[Convert.ToInt32(e.CommandArgument)].Values["idventa"];
                var cliente = NtLinkClientFactory.Cliente();
                using (cliente as IDisposable)
                {
                    var venta = cliente.GetFactura(id);
                    this.txtFechaPago.Text = venta.FechaPago.HasValue ? venta.FechaPago.Value.ToString("dd/MM/yyyy") : string.Empty;
                    this.lblFolioPago.Text = venta.Folio.ToString();
                    this.txtReferenciaPago.Text = venta.ReferenciaPago;
                }
                this.lblIdventa.Text = id.ToString();
                this.mpePagar.Show();
            }
            else if (e.CommandName.Equals("Cancelar"))
            {
                try
                {   //id es Folio
                    Int64 id = Convert.ToInt64(e.CommandArgument);
                    var cliente = NtLinkClientFactory.Cliente();
                    using (cliente as IDisposable)
                    {
                        var venta = cliente.GetRetenciones(id);
                        var cancelacion = cliente.CancelarRetencion(venta.RfcEmisor, venta.Guid);
                        lblError.Text = cancelacion;
                        this.FillView();
                    }
                }
                catch (FaultException fe)
                {
                    lblError.Text = fe.Message;
                }
                catch (Exception fe)
                {
                    
                }

            }

            else if (e.CommandName.Equals("Acuse"))
            {
                try
                {
                   Int64 id = Convert.ToInt32(e.CommandArgument);
                    var cliente = NtLinkClientFactory.Cliente();
                    using (cliente as IDisposable)
                    {
                        var fact = cliente.GetRetenciones(id);
                        Response.AddHeader("Content-Disposition", "attachment; filename=" + fact.Folio + ".pdf");
                        this.Response.ContentType = "application/pdf";
                        var pdf = cliente.AcuseCancelacion("AcuseCancelacionRetencion", id,"","","");
                        if (pdf == null || pdf.Length == 0)
                        {
                            this.lblError.Text = "Archivo no encontrado";
                            return;
                        }
                        this.Response.BinaryWrite(pdf);
                        this.Response.End();
                    }
                }
                catch (FaultException fe)
                {
                    lblError.Text = fe.Message;
                }
                catch (Exception fe)
                {
                    ;
                }

            }
            else if (e.CommandName == "SelectAll")
            {
                bool sel;
                if (hidSel.Value != "Sel")
                {
                    sel = false;
                    SelText = "Seleccionar Todos";
                    hidSel.Value = "Sel";
                }
                else
                {
                    
                    sel = true;
                    SelText = "Seleccionar Ninguno";
                    hidSel.Value = "Des";
                }
                foreach (GridViewRow row in gvFacturas.Rows)
                {
                    var lista = ViewState["facturas"] as List<vventas>;
                    if (lista != null)
                    {
                        foreach (vventas itemVventas in lista)
                        {
                            itemVventas.Seleccionar = sel;
                        }
                    }
                    gvFacturas.DataSource = lista;
                    gvFacturas.DataBind();
                    
                }
            }


        }
        
        protected void btnExportar_Click(object sender, EventArgs e)
        {
            var ex = new Export();
            this.Response.AddHeader("Content-Disposition", "attachment; filename=Reporte.xlsx");
            this.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            this.Response.BinaryWrite(ex.GridToExcel(this.gvFacturaCustumer, "Facturas"));
            this.Response.End();
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            this.FillView();
        }

        protected void ddlEmpresas_SelectedIndexChanged(object sender, EventArgs e)
        {
            var filtro = "Todos";//rbStatus.SelectedValue;
            var cliente = NtLinkClientFactory.Cliente();
            var perfil = Session["perfil"] as string;
            var iniciales = Session["iniciales"] as string;
            //if (string.IsNullOrEmpty(this.ddlClientes.SelectedValue))
            //    return;
            using (cliente as IDisposable)
            {
                var empresaId = int.Parse(this.ddlEmpresas.SelectedValue);
                var sistema = Session["idSistema"] as long?;
                this.ddlClientes.Items.Clear();
                this.ddlClientes.DataSource = cliente.ListaClientes(perfil, empresaId, string.Empty, true);
                this.ddlClientes.DataBind();
                DateTime fechaInicial = DateTime.Parse(this.txtFechaInicial.Text);
                DateTime fechaFinal = DateTime.Parse(this.txtFechaFinal.Text).AddDays(1).AddSeconds(-1);

                List<vventaRetenciones> ventas = cliente.ListaRetenciones(fechaInicial, fechaFinal, int.Parse(this.ddlEmpresas.SelectedValue),
                    int.Parse(this.ddlClientes.SelectedValue), filtro, "A").OrderByDescending(p => p.Folio).ToList();

                var lista = new List<vventaRetenciones>(ventas);
                ViewState["facturas"] = lista;
                this.gvFacturas.DataSource = lista;
                this.gvFacturas.DataBind();
                //CalculaTotales(lista);
                this.gvFacturaCustumer.DataSource = lista;
                this.gvFacturaCustumer.DataBind();
            }
        }

        protected void gvFacturas_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            this.gvFacturas.DataSource = ViewState["facturas"];
            this.gvFacturas.PageIndex = e.NewPageIndex;
            this.gvFacturas.DataBind();
           //this.CalculaTotales(ViewState["facturas"] as List<vventas>);
        }

        protected void btnEnviarMail_Click(object sender, EventArgs e)
        {
            var cliente = NtLinkClientFactory.Cliente();
            using (cliente as IDisposable)
            {
                string uuid = this.lblGuid.Text;
                string rfc = this.lblRFCEmpresa.Text;

                byte[] xml = cliente.RetencionPdfXML(uuid, rfc, "xml");
                byte[] pdf = cliente.RetencionPdfXML(uuid, rfc, "pdf");
                
                
                var atts = new List<EmailAttachment>();
                atts.Add(new EmailAttachment { Attachment = xml,Name = uuid + ".xml"});
                atts.Add(new EmailAttachment {Attachment = pdf, Name = uuid + ".pdf"});
                var idEmp = Session["idEmpresa"] as int?;
                var empresa = cliente.ObtenerEmpresaById(idEmp.Value);
                var emails = new List<string>();

                if (!string.IsNullOrEmpty(this.lblEmailCliente.Text))
                {
                    emails.Add(this.lblEmailCliente.Text);
                }
                emails.AddRange(this.txtEmails.Text.Split(','));
                try
                {
                    cliente.SendMailByteArray(emails, atts, "Se envia la constacia de retenciones con folio " + uuid + " su la representación visual.",
                          "Envio de Constancia de retenciones", empresa.Email, empresa.RazonSocial);
                }
                catch (FaultException fe)
                {
                    lblError.Text = fe.Message;
                }
                
                this.mpeEmail.Hide();
            }
        }

        protected void btnPagar_Click(object sender, EventArgs e)
        {
            var cliente = NtLinkClientFactory.Cliente();
            using (cliente as IDisposable)
            {
                try
                {
                    cliente.Pagarfactura(int.Parse(this.lblIdventa.Text), DateTime.Parse(this.txtFechaPago.Text), this.txtReferenciaPago.Text);
                }
                catch(FaultException fe)
                {
                    this.lblErrorPago.Text = fe.Message;
                }
            }
            FillView();
            this.mpePagar.Hide();
        }

        #region Helper Methods

        private void FillView()
        {
            var perfil = Session["perfil"] as string;
            var iniciales = Session["iniciales"] as string;
            var cliente = NtLinkClientFactory.Cliente();
            var filtro = "Todos";//rbStatus.SelectedValue;
            if (!string.IsNullOrEmpty(this.ddlClientes.SelectedValue))
            using (cliente as IDisposable)
            {
                DateTime fechaInicial = DateTime.Parse(this.txtFechaInicial.Text);
                DateTime fechaFinal = DateTime.Parse(this.txtFechaFinal.Text).AddDays(1).AddSeconds(-1);
                if ((fechaFinal - fechaInicial).TotalDays > 93)
                {
                    lblError.Text = "El rango de fechas no puede ser mayor a 93 dias";
                    return;
                }
                var ventas = perfil == "Administrador" ? (cliente.ListaRetenciones(fechaInicial, fechaFinal, int.Parse(this.ddlEmpresas.SelectedValue),
                    int.Parse(this.ddlClientes.SelectedValue), filtro, "A")
                        ) : (cliente.ListaRetenciones(fechaInicial, fechaFinal, int.Parse(this.ddlEmpresas.SelectedValue),
                    int.Parse(this.ddlClientes.SelectedValue), filtro, "A")
                        ); 
                

                List<vventaRetenciones> lista;
                
                    lista = ventas.ToList();
                
                var gridFatura = new GridView();
                foreach (DataControlField colum in gvFacturas.Columns)
                {
                    gridFatura.Columns.Add(colum);
                }

               

                ViewState["facturas"]   = lista;

                this.gvFacturas.DataSource = lista;
                this.gvFacturas.DataBind();
                                
              
                this.gvFacturaCustumer.DataSource = lista;
                this.gvFacturaCustumer.DataBind();
            }
        }

       

        #endregion

        protected void gvFacturas_RowDataBound(object sender, GridViewRowEventArgs e)
        {
           /* if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (e.Row.Cells[5].Text == "Cancelado")
                    e.Row.BackColor = Color.FromName("#FEDDB8");
                if (e.Row.Cells[5].Text == "Pendiente")
                    e.Row.BackColor = Color.FromName("#e4e5e7");
                if (e.Row.Cells[5].Text == "Pagado")
                    e.Row.BackColor = Color.FromName("#b3d243");
            }*/
        }

        protected void btnCerrarPagar_Click(object sender, EventArgs e)
        {
            FillView();
            mpePagar.Show();
        }

        protected void btnDescargarTodo_OnClick(object sender, EventArgs e)
        {
            try
            {
                List<int> lista = new List<int>();
                foreach (GridViewRow row in gvFacturas.Rows)
                {
                    var control = row.FindControl("cbChecked") as System.Web.UI.WebControls.CheckBox;
                    if (control.Checked)
                    {
                        var id = (int)this.gvFacturas.DataKeys[Convert.ToInt32(row.RowIndex)].Values["idventa"];
                        lista.Add(id);
                    }

                }
                //Crear zip
                var cte = NtLinkClientFactory.Cliente();
                using (cte as IDisposable)
                {
                    var idEmp = Session["idEmpresa"] as int?;
                    if (!idEmp.HasValue)
                        return;
                    var empresa = cte.ObtenerEmpresaById(idEmp.Value);
                    var bytes = cte.GetFacturasZip(lista, empresa.RFC);
                    Response.AddHeader("Content-Disposition", "attachment; filename=" + empresa.RFC + "_Comprobantes" + ".zip");
                    this.Response.ContentType = "application/zip, application/octet-stream";

                    this.Response.BinaryWrite(bytes);
                    this.Response.End();
                }
            }
            catch (Exception  ee)
            {
                lblError.Text = "Ocurrió un error al obtener el archivo";
            }
            
        }

        protected void rbStatus_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}