using System;
using System.Collections.Generic;
using System.ServiceModel;
using System.Web.UI;
using ServicioLocalContract;
using System.Linq;
using System.Data.SqlClient;
using System.Data;
using System.Globalization;

namespace NtLinkAdministracion
{
    public partial class NuevoProspecto : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var clienteServicio = NtLinkClientFactory.Cliente();
                Sistemas sistema;
                using (clienteServicio as IDisposable)
                {
                    //var ejecutivos = clienteServicio.ObtenerPromotores();
                    //ejecutivos.Insert(0, new Promotores() { Nombre = "Seleccionar", IdPromotor = 0 });
                    //ddlEjecutivos.DataSource = ejecutivos;
                    //ddlEjecutivos.DataBind();
                    //string idEmpresaString = this.Request.QueryString["idSistema"];
                    //int idSistema;
                    //no le esta diciendo que tome valor
                    //if (!string.IsNullOrEmpty(idEmpresaString) && int.TryParse(idEmpresaString, out idSistema))
                    //{
                    //    sistema = clienteServicio.ObtenerSistemaById(idSistema, true);
                    //    //se modifico ppor los cambios hechos por arce para dividir timbres y web
                    //    //txtConsumidos.Text = clienteServicio.ObtenerNumeroTimbresSistema(idSistema).ToString();
                    //    List<Contratos> v = clienteServicio.ListaContratos(idSistema);
                    //    if (v != null && v.Count > 0)
                    //    {
                    //        var count = v.Sum(p => p.Timbres);
                    //        this.txtFolios.Text = count.ToString();
                    //    }
                    //    this.FillView(sistema);
                    //    ViewState["sistema"] = sistema;
                    //}
                    //else
                    //{
                    //    this.txtRFC.Enabled = true;
                    //}
                }

                //List<Promotore> prom = new List<Promotore>();
                //using (prospectovic BD = new prospectovic())
                //{
                //    prom = BD.Promotores.ToList();
                //}
                //Promotore aux = new Promotore()
                //{
                //    Nombre = "Seleccione",
                //    IdPromotor = 0
                //};
                //prom.Add(aux);
                //ddlEjecutivos.DataSource = prom.OrderBy(p => p.IdPromotor);
                //ddlEjecutivos.DataTextField = "Nombre";
                //ddlEjecutivos.DataValueField = "IdPromotor";
                //ddlEjecutivos.DataBind();
                //ddlEjecutivos.SelectedValue = "0";//pruebalo
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {

            //SqlConnection conexion = new SqlConnection();

            var conn = new SqlConnection();
            conn.ConnectionString = "Persist Security Info=False;Password=Ntlink.2018;User ID=ntlinkv; Initial Catalog=ProduccionNtlink;Data Source=192.168.15.251";
            conn.Open();
            DateTime myDateTime = DateTime.Now;
            CultureInfo esC = new CultureInfo("es-ES");
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "insert into Prospect (RazonSocial,RFC,Email,Telefono,Vendedor,Fechacontacto,Tipocliente) values('" + txtRazonSocial.Text+"','"+txtRFC.Text+"','"+txtEmail.Text+"','"+txtTelefono.Text+"','"+this.ddlEjecutivo.SelectedItem+"','" + myDateTime.ToString("yyyy-MM-dd HH:mm:ss")+ "','"+this.ddlTipoCliente.SelectedItem+"')";
            cmd.ExecuteNonQuery();



          


            conn.Close();



            

            Response.Redirect("NuevoProspecto.aspx");
            }
        
    }
}