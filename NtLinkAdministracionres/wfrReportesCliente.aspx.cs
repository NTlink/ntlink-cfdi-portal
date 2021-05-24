using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ServicioLocalContract;

namespace NtLinkAdministracion
{
    public partial class wfrReportesCliente : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                LlenarAnios();
                LlenarClientes();
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

        private void LlenarClientes()
        {
            var cliente = NtLinkClientFactory.Cliente();
            using (cliente as IDisposable)
            {
                var clientes = cliente.ListaSistemas("");
                ddlCliente.DataTextField = "RazonSocial";
                ddlCliente.DataValueField = "IdSistema";
                ddlCliente.DataSource = clientes;
                ddlCliente.DataBind();
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
                List<ElementoReporte> Lis= cliente.ObtenerReportePorCliente(Convert.ToInt32(ddlMes.SelectedValue),
                                                                        Convert.ToInt32(ddlAnio.SelectedValue),
                                                                        Convert.ToInt32(ddlCliente.SelectedValue));

                foreach (var nodo in Lis)
                {
                    nodo.Mes = ObtenerMesLetras(Convert.ToInt16(nodo.Mes));
                }
                gvReporte.DataSource = Lis;
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