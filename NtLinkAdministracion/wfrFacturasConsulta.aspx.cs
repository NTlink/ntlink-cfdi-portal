using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using ServicioLocalContract;

namespace NtLinkAdministracion
{
    public partial class wfrFacturasConsulta : Page
    {

        public string SelText = "Seleccionar Todo";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                var perfil = "Administrador";
                //var sistema = 17;
                var idEmp = 23;
                var cliente = NtLinkClientFactory.Cliente();
                using (cliente as IDisposable)
                {
                    // Primero por RFC, si es NULL intentamos con el Id de la base de produccion.
                    var sistema = cliente.ObtenerSistema("NLC091211KC6") ?? cliente.ObtenerSistemaById(17);
                    int empresaId = idEmp;
                    this.ddlClientes.Items.Clear();
                    this.ddlClientes.DataSource = cliente.ListaClientes(perfil, empresaId, string.Empty, true);
                    this.ddlClientes.DataBind();
                    this.ddlEmpresas.DataSource = cliente.ListaEmpresas(perfil, idEmp, sistema.IdSistema, null);
                    this.ddlEmpresas.Enabled = perfil.Equals("Administrador");
                    this.ddlEmpresas.DataBind();
                    this.txtFechaInicial.Text = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1).ToString("d");
                    this.txtFechaFinal.Text = DateTime.Today.ToString("d");
                    ddlEmpresas_SelectedIndexChanged(null, null);
                }
                this.FillView();
            }
        }

        protected void gvFacturas_RowCommand(object sender, GridViewCommandEventArgs e)
        {
           
            if(e.CommandName.Equals("DescargarXml"))
            {
                string uuid = this.gvFacturas.Rows[Convert.ToInt32(e.CommandArgument)].Cells[1].Text;
                var cliente = NtLinkClientFactory.Cliente();
                using (cliente as IDisposable)
                {
                    var id = (int)this.gvFacturas.DataKeys[Convert.ToInt32(e.CommandArgument)].Values["idventa"];
                    var cfd = cliente.GetFactura(id);
                    string xml = Encoding.UTF8.GetString(cliente.FacturaXml(uuid));
                    //Response.AddHeader("Content-Disposition", "attachment; filename=" + uuid + ".xml");
                    Response.AddHeader("Content-Disposition", "attachment; filename=" + cfd.RFC + "_" + cfd.Folio + "_" + cfd.Fecha.ToString("yyyyMMdd") + "_" + uuid + ".xml");
                    this.Response.ContentType = "text/xml";
                    this.Response.Charset = "UTF-8";
                    this.Response.Write(xml);
                    this.Response.End();
                }
            }
            else if (e.CommandName.Equals("DescargarPdf"))
            {
                string uuid = this.gvFacturas.Rows[Convert.ToInt32(e.CommandArgument)].Cells[1].Text;
                var cliente = NtLinkClientFactory.Cliente();
                using (cliente as IDisposable)
                {
                    var id = (int)this.gvFacturas.DataKeys[Convert.ToInt32(e.CommandArgument)].Values["idventa"];
                    var cfd = cliente.GetFactura(id);
                    Response.AddHeader("Content-Disposition", "attachment; filename=" + cfd.RFC + "_" + cfd.Folio + "_" + cfd.Fecha.ToString("yyyyMMdd") + "_" + uuid + ".pdf");
                    //Response.AddHeader("Content-Disposition", "attachment; filename=" +  uuid + ".pdf");
                    this.Response.ContentType = "application/pdf";
                    var pdf = cliente.FacturaPdf(uuid);
                    if (pdf == null)
                    {
                        this.lblError.Text = "Archivo no encontrado";
                        return;
                    }
                    this.Response.BinaryWrite(pdf);
                    this.Response.End();
                }
            }
            else if (e.CommandName.Equals("EnviarEmail"))
            {

                var idCliente = (int) this.gvFacturas.DataKeys[Convert.ToInt32(e.CommandArgument)].Values["IdCliente"];
                var cliente = NtLinkClientFactory.Cliente();
                using (cliente as IDisposable)
                {
                    clientes c = cliente.ObtenerClienteById(idCliente);
                    this.lblEmailCliente.Text = c.Email;
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
                {
                    int id = Convert.ToInt32(e.CommandArgument);
                    var cliente = NtLinkClientFactory.Cliente();
                    using (cliente as IDisposable)
                    {
                        var venta = cliente.GetFactura(id);
                        var cancelacion = cliente.CancelarFactura(venta.RfcEmisor, venta.Guid,"","");
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
                    ;
                }

            }

            else if (e.CommandName.Equals("Acuse"))
            {
                try
                {
                    int id = Convert.ToInt32(e.CommandArgument);
                    var cliente = NtLinkClientFactory.Cliente();
                    using (cliente as IDisposable)
                    {
                        var fact = cliente.GetFactura(id);
                        Response.AddHeader("Content-Disposition", "attachment; filename=" + fact.idVenta + ".pdf");
                        this.Response.ContentType = "application/pdf";
                        var pdf = cliente.AcuseCancelacion("AcuseCancelacion",id,"","","");
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
            var filtro = rbStatus.SelectedValue;
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

                List<vventas> ventas = cliente.ListaFacturas(fechaInicial, fechaFinal, int.Parse(this.ddlEmpresas.SelectedValue),
                    int.Parse(this.ddlClientes.SelectedValue), filtro, "A", iniciales).OrderByDescending(p => p.Folio).ToList();

                var lista = new List<vventas>(ventas);
                ViewState["facturas"] = lista;
                this.gvFacturas.DataSource = lista;
                this.gvFacturas.DataBind();
                CalculaTotales(lista);
                this.gvFacturaCustumer.DataSource = lista;
                this.gvFacturaCustumer.DataBind();
            }
        }

        protected void gvFacturas_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            this.gvFacturas.DataSource = ViewState["facturas"];
            this.gvFacturas.PageIndex = e.NewPageIndex;
            this.gvFacturas.DataBind();
            this.CalculaTotales(ViewState["facturas"] as List<vventas>);
        }

        protected void btnEnviarMail_Click(object sender, EventArgs e)
        {
            var cliente = NtLinkClientFactory.Cliente();
            using (cliente as IDisposable)
            {
                string uuid = this.lblGuid.Text;
                
                byte[] xml = cliente.FacturaXml(uuid);
                byte[] pdf = cliente.FacturaPdf(uuid);
                
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
                    cliente.SendMailByteArray(emails, atts, "Se envia la factura con folio " + uuid + " su la representación visual.",
                          "Envio de Facturas", empresa.Email, empresa.RazonSocial);
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
            var filtro = rbStatus.SelectedValue;
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
                var ventas = perfil == "Administrador" ? (cliente.ListaFacturas(fechaInicial, fechaFinal, int.Parse(this.ddlEmpresas.SelectedValue),
                    int.Parse(this.ddlClientes.SelectedValue), filtro, "A")
                        ) : (cliente.ListaFacturas(fechaInicial, fechaFinal, int.Parse(this.ddlEmpresas.SelectedValue),
                    int.Parse(this.ddlClientes.SelectedValue), filtro, "A", iniciales)
                        ); 
                

                List<vventas> lista;
                if(!string.IsNullOrEmpty(this.txtTexto.Text))
                {
                    lista = ventas.Where(l => (l.Cliente != null && l.Cliente.Contains(this.txtTexto.Text))
                        || (l.Observaciones != null && l.Observaciones.Contains(this.txtTexto.Text))).ToList();
                }
                else
                {
                    lista = ventas.ToList();
                }
                var gridFatura = new GridView();
                foreach (DataControlField colum in gvFacturas.Columns)
                {
                    gridFatura.Columns.Add(colum);
                }

                ViewState["facturas"]   = lista;

                this.gvFacturas.DataSource = lista;
                this.gvFacturas.DataBind();
                                
                CalculaTotales(lista);
                this.gvFacturaCustumer.DataSource = lista;
                this.gvFacturaCustumer.DataBind();
            }
        }

        private void CalculaTotales(List<vventas> lista)
        {
            var subt = lista.Where(c=>c.Cancelado == 0).Sum(p => p.SubTotal);
            var total = lista.Where(c=>c.Cancelado == 0).Sum(p => p.Total);
            var ivax = lista.Where(c => c.Cancelado == 0).Sum(p => p.IVA);
            var retiva = lista.Where(c => c.Cancelado == 0 && c.RetIva.HasValue).Sum(p => p.RetIva);
            var retisr = lista.Where(c => c.Cancelado == 0 && c.RetIsr.HasValue).Sum(p => p.RetIsr);
            var ieps = lista.Where(c => c.Cancelado == 0 && c.Ieps.HasValue).Sum(p => p.Ieps);

            if (this.gvFacturas.FooterRow != null)
            {
                this.gvFacturas.FooterRow.Cells[0].Text = "TOTAL";
                this.gvFacturas.FooterRow.Cells[6].Text = subt.Value.ToString("C");
                this.gvFacturas.FooterRow.Cells[7].Text = ivax.Value.ToString("C");
                this.gvFacturas.FooterRow.Cells[8].Text = retiva.Value.ToString("C");
                this.gvFacturas.FooterRow.Cells[9].Text = retisr.Value.ToString("C");
                this.gvFacturas.FooterRow.Cells[10].Text = ieps.Value.ToString("C");
                this.gvFacturas.FooterRow.Cells[11].Text = total.Value.ToString("C");
            }
        }

        #endregion

        protected void gvFacturas_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (e.Row.Cells[13].Text == "Cancelado")
                    e.Row.BackColor = Color.FromName("#FEDDB8");
                if (e.Row.Cells[13].Text == "Pendiente")
                    e.Row.BackColor = Color.FromName("#e4e5e7");
                if (e.Row.Cells[13].Text == "Pagado")
                    e.Row.BackColor = Color.FromName("#b3d243");
            }
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
                    var control = row.FindControl("cbChecked") as CheckBox;
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
    }
}