using System;
using System.Collections.Generic;
using System.Drawing;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ServicioLocalContract;

namespace GafLookPaid
{
    public partial class wfrReporteTimbra : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
               
                LlenarAnios();
                ddlAnio.SelectedValue = DateTime.Now.Year.ToString();
                ddlAnio2.SelectedValue = DateTime.Now.Year.ToString();
                LlenarGrid();
  
                var cliente = NtLinkClientFactory.Cliente();
                var idEmp = Session["idEmpresa"] as int?;
                using (cliente as IDisposable)
                {
                    var sistema = cliente.ListaEmpresas("Operador", idEmp.Value, 0, "A");

                    var reporte = cliente.ListaTimbrado(Convert.ToInt32(sistema[0].idSistema.Value));
                    gvReporte.DataSource = reporte.ToList();
                    gvReporte.DataBind();
                }
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            var cliente = NtLinkClientFactory.Cliente();
            var idEmp = Session["idEmpresa"] as int?;
            string a=ddlAnio.SelectedValue;
            int año=0;
            if(a!="Todos")
            año= Convert.ToInt32(a);
            using (cliente as IDisposable)
            {
                var sistema = cliente.ListaEmpresas("Operador", idEmp.Value, 0, "A");
                gvReporteEmisor.DataSource = cliente.ObtenerReporteFullEmisor(Convert.ToInt32(ddlMes.SelectedValue),
                                                                              año,
                                                                              Convert.ToInt32(sistema[0].idSistema.Value));
                gvReporteEmisor.DataBind();
            }
        }

        private void LlenarAnios()
        {
            for (int anio = 2012; anio <= DateTime.Now.Year; anio++)
            {
                ddlAnio.Items.Add(anio.ToString(CultureInfo.InvariantCulture));
                ddlAnio2.Items.Add(anio.ToString(CultureInfo.InvariantCulture));

            }
            ddlAnio.Items.Add("Todos");
        }

        protected void gvReporte_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (Convert.ToInt32(e.Row.Cells[4].Text) >= 80)
                    e.Row.BackColor = Color.Red;
                e.Row.ForeColor = Color.Black;
            }
        }

        protected void btnExportar_Click(object sender, EventArgs e)
        {
            var ex = new Export();
            Response.AddHeader("Content-Disposition", "attachment; filename=Reporte.xlsx");
            this.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            this.Response.BinaryWrite(ex.GridToExcel(this.gvReporteEmisor, "Facturas"));
            this.Response.End();
        }

        protected void btnExcel_Click(object sender, EventArgs e)
        {
            var ex = new Export();
            Response.AddHeader("Content-Disposition", "attachment; filename=Reporte.xlsx");
            this.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            this.Response.BinaryWrite(ex.GridToExcel(this.gvReporte2, "Facturas"));
            this.Response.End();
        }

        protected void btnBuscar2_Click(object sender, EventArgs e)
        {
            LlenarGrid();
        }
        private void LlenarGrid()
        {
            var idEmp = Session["idEmpresa"] as int?;
            var cliente = NtLinkClientFactory.Cliente();
            using (cliente as IDisposable)
            {

                var sistema = cliente.ListaEmpresas("Operador", idEmp.Value, 0, "A");
                List<ElementoReporte> Lis = cliente.ObtenerReportePorCliente(0,
                                                                        Convert.ToInt32(ddlAnio2.SelectedValue),
                                                                        Convert.ToInt32(Convert.ToInt32(sistema[0].idSistema.Value)));

                foreach (var nodo in Lis)
                {
                    nodo.Mes = ObtenerMesLetras(Convert.ToInt16(nodo.Mes));
                }
                gvReporte2.DataSource = Lis;
                gvReporte2.DataBind();
            }
        }
        //------------------------------------------------------------------------------------
        private string ObtenerMesLetras(int m)
        {
            string salida = "";
            switch (m)
            {
                case 1:
                    salida = "Enero";
                    break;
                case 2:
                    salida = "Febrero";
                    break;
                case 3:
                    salida = "Marzo";
                    break;
                case 4:
                    salida = "Abril";
                    break;
                case 5:
                    salida = "Mayo";
                    break;
                case 6:
                    salida = "Junio";
                    break;
                case 7:
                    salida = "Julio";
                    break;
                case 8:
                    salida = "Agosto";
                    break;
                case 9:
                    salida = "Septiembre";
                    break;
                case 10:
                    salida = "Octubre";
                    break;
                case 11:
                    salida = "Noviembre";
                    break;
                case 12:
                    salida = "Diciembre";
                    break;
                default:
                    salida = "Mes erroneo";
                    break;
            }

            return salida;
        }
        //--------------------------------------------------------------------------------
    
      
    }
}