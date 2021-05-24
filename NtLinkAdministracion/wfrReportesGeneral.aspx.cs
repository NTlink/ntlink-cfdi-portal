using System;
using System.Globalization;
using System.Web.UI;
using ServicioLocalContract;

namespace NtLinkAdministracion
{
    public partial class wfrReportesGeneral : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                LlenarAnios();
                ddlAnio.SelectedValue = DateTime.Now.Year.ToString();
                ddlMes.SelectedValue = DateTime.Now.Month.ToString();
                LlenarGrid();
            }
        }

        private void LlenarAnios()
        {
            for (int anio = 2012; anio <= DateTime.Now.Year; anio++)
            {
                ddlAnio.Items.Add(anio.ToString(CultureInfo.InvariantCulture));
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
           LlenarGrid();
        }

        private void LlenarGrid()
        {
            var cliente = NtLinkClientFactory.Cliente();
            using (cliente as IDisposable)
            {
                gvReporte.DataSource = cliente.ObtenerReporte(Convert.ToInt32(ddlMes.SelectedValue),
                                                              Convert.ToInt32(ddlAnio.SelectedValue));
                gvReporte.DataBind();
            }
        }

        protected void btnExcel_Click(object sender, EventArgs e)
        {
            var ex = new Export();
            Response.AddHeader("Content-Disposition", "attachment; filename=Reporte.xlsx");
            this.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            this.Response.BinaryWrite(ex.GridToExcel(this.gvReporte, "Facturas"));
            this.Response.End();
        }
    }
}