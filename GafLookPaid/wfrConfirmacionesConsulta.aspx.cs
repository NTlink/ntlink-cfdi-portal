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
    public partial class wfrConfirmacionesConsulta : System.Web.UI.Page
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
                    ddlClientes.SelectedValue = "0";
                    this.ddlEmpresas.DataSource = cliente.ListaEmpresas(perfil, idEmp.Value, sistema.Value, null);
                    this.ddlEmpresas.Enabled = perfil.Equals("Administrador");
                    this.ddlEmpresas.DataBind();
                  //  this.txtFechaInicial.Text = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1).ToString("d");
                  //  this.txtFechaFinal.Text = DateTime.Today.ToString("d");
                    ddlEmpresas_SelectedIndexChanged(null,null);
                }
                this.FillView();
            }
        }

        protected void gvFacturas_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            if (e.CommandName.Equals("Confirmar"))
            {
                try
                {   //id es Folio
                    Int64 id = Convert.ToInt64(e.CommandArgument);
                    var cliente = NtLinkClientFactory.Cliente();
                    Guid uid = Guid.NewGuid();
                    string confirma = uid.ToString();
                    confirma = confirma.Substring(0, 5);
                    confirma = confirma.ToUpper();
                    using (cliente as IDisposable)
                    {
                        var venta = cliente.Confirmar(confirma,id);
                        if(venta=="OK")
                            lblError.Text = "Código generado: " + confirma +", copiarlo a su CFDI y mandar a timbrar";
                        else
                                          lblError.Text = venta;
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
               // DateTime fechaInicial = DateTime.Parse(this.txtFechaInicial.Text);
               // DateTime fechaFinal = DateTime.Parse(this.txtFechaFinal.Text).AddDays(1).AddSeconds(-1);

                /*
                List<vventaRetenciones> ventas = cliente.ListaRetenciones(fechaInicial, fechaFinal, int.Parse(this.ddlEmpresas.SelectedValue),
                    int.Parse(this.ddlClientes.SelectedValue), filtro, "A").OrderByDescending(p => p.Folio).ToList();

                var lista = new List<vventaRetenciones>(ventas);
                ViewState["facturas"] = lista;
                this.gvFacturas.DataSource = lista;
                this.gvFacturas.DataBind();
                 */ 
                //CalculaTotales(lista);
              //  this.gvFacturaCustumer.DataSource = lista;
              //  this.gvFacturaCustumer.DataBind();
            }
        }

        protected void gvFacturas_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            this.gvFacturas.DataSource = ViewState["facturas"];
            this.gvFacturas.PageIndex = e.NewPageIndex;
            this.gvFacturas.DataBind();
           //this.CalculaTotales(ViewState["facturas"] as List<vventas>);
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
                /*
                DateTime fechaInicial = DateTime.Parse(this.txtFechaInicial.Text);
                DateTime fechaFinal = DateTime.Parse(this.txtFechaFinal.Text).AddDays(1).AddSeconds(-1);
                if ((fechaFinal - fechaInicial).TotalDays > 93)
                {
                    lblError.Text = "El rango de fechas no puede ser mayor a 93 dias";
                    return;
                }
                 */ 
                //var ventas = cliente.ListaConfirmacion(fechaInicial, fechaFinal, this.ddlEmpresas.SelectedValue, this.ddlClientes.SelectedValue);

                var ventas = cliente.ListaConfirmacion( this.ddlEmpresas.SelectedValue, this.ddlClientes.SelectedValue); 
                
                List<ConfirmacionTimbreWs33> lista;
                
                    lista = ventas.ToList();
                
                var gridFatura = new GridView();
                foreach (DataControlField colum in gvFacturas.Columns)
                {
                    gridFatura.Columns.Add(colum);
                }

               
                ViewState["facturas"]   = lista;

                this.gvFacturas.DataSource = lista;
                this.gvFacturas.DataBind();
                                
              
              //  this.gvFacturaCustumer.DataSource = lista;
              //  this.gvFacturaCustumer.DataBind();
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

        protected void rbStatus_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
        public string ProcessMyDataItem(object myValue)
        {
            if (myValue == null)
            {
                return "";
            }

            return myValue.ToString();
        }
    }
}