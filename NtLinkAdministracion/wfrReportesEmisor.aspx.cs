using System;
using System.Globalization;
using System.Web.UI;
using ServicioLocalContract;
using System.Web.UI.WebControls;
using System.Collections.Generic;

namespace NtLinkAdministracion
{
    public partial class wfrReportesEmisor : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LlenarAnios();
                LlenarClientes();
                LlenarEmpresas();
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

        private void LlenarEmpresas()
        {
            var cliente = NtLinkClientFactory.Cliente();
            int emp = Convert.ToInt32(ddlCliente.SelectedValue);
            using (cliente as IDisposable)
            {
                ddlEmisor.Items.Clear();
                var lista = cliente.ListaEmpresas("Administrador", emp, Convert.ToInt32(ddlCliente.SelectedValue), null);
                var emisores = lista;
                ddlEmisor.Items.Insert(0,new ListItem("Todos"));
                ddlEmisor.DataTextField = "RazonSocial";
                ddlEmisor.DataValueField = "IdEmpresa";
                ddlEmisor.DataSource = emisores;
                ddlEmisor.DataBind();
             
            }
        }

        private void LlenarGrid()
        {
            var cliente = NtLinkClientFactory.Cliente();
            int i = 0;
            using (cliente as IDisposable)
            {
                if (ddlEmisor.SelectedValue != "Todos")
                {
                     List<ElementoReporte> Lis = cliente.ObtenerReportePorEmisor(Convert.ToInt32(ddlMes.SelectedValue),
                                                                           Convert.ToInt32(ddlAnio.SelectedValue),
                                                                           Convert.ToInt32(ddlEmisor.SelectedValue));

                    //foreach (var nodo in Lis)
                    //{
                    //    nodo.Mes = ObtenerMesLetras(Convert.ToInt16(nodo.Mes));
                    //}
                    gvReporte.DataSource = Lis;
                   
                    gvReporte.DataBind();
                }
                else
                {
                    List<ElementoReporte> Lis = cliente.ObtenerReporteFullEmisor(Convert.ToInt32(ddlMes.SelectedValue),
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
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            LlenarGrid();
        }

        protected void btnExcel_Click(object sender, EventArgs e)
        {
            var ex = new Export();
            Response.AddHeader("Content-Disposition", "attachment; filename=Reporte.xlsx");
            this.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            this.Response.BinaryWrite(ex.GridToExcel(this.gvReporte, "Facturas"));
            this.Response.End();
        }

        protected void ddlCliente_SelectedIndexChanged(object sender, EventArgs e)
        {
            LlenarEmpresas();
        }

        protected void ddlEmisor_SelectedIndexChanged(object sender, EventArgs e)
        {
            LlenarGrid();
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