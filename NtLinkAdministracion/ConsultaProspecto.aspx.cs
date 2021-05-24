using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ServicioLocalContract;
using System.Drawing;
using NtLinkAdministracion.Objetos;
using System.Data.SqlClient;
using System.Data;

namespace NtLinkAdministracion
{
    public partial class ConsultaProspecto : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                var usuario = Session["usuario"] as usuarios;
                var cliente = NtLinkClientFactory.Cliente();
                using (cliente as IDisposable)
                {
                    var ejecutivos = cliente.ObtenerPromotores();
                    ejecutivos.Insert(0, new Promotores() { Nombre = "Seleccionar", IdPromotor = 0 });
                    //ddlEjecutivos.DataSource = ejecutivos;
                    //ddlEjecutivos.DataBind();
                }
                //GetSistemas();

            }
        }

        //protected void gvClientes_RowCommand(object sender, GridViewCommandEventArgs e)
        //{
        //    if (e.CommandName.Equals("EditarSistema"))
        //    {
        //        DataKey key = this.gvClientes.DataKeys[Convert.ToInt32(e.CommandArgument)];
        //        if (key != null)
        //        {
        //            int idCliente = Convert.ToInt32(key.Value);
        //            Response.Redirect("wfrClientes.aspx?idSistema=" + idCliente);
        //        }
        //    }
        //    else if (e.CommandName.Equals("Contratos"))
        //    {
        //        DataKey key = this.gvClientes.DataKeys[Convert.ToInt32(e.CommandArgument)];
        //        if (key != null)
        //        {
        //            int idCliente = Convert.ToInt32(key.Value);
        //            Response.Redirect("wfrClientesContratos.aspx?idSistema=" + idCliente);
        //        }
        //    }
        //}


        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            GetSistemas();
        }




        protected string TC (int? idtipocliente)
        {
            /* <asp:ListItem runat="server" Text="Facturación" Value="0" ></asp:ListItem>
                   <asp:ListItem runat="server" Text="Timbrado Pre-Pago" Value="1"></asp:ListItem>
                   <%--<asp:ListItem runat="server" Text="Distribuidor" Value="2"></asp:ListItem>--%>
                   <asp:ListItem runat="server" Text="Timbrado Post-Pago" Value="3"></asp:ListItem> */

            string ret ="No definido";
            if (idtipocliente == 0)
                ret = "Facturación";
            if (idtipocliente == 1)
                ret = "Timbrado Pre-Pago";
            if(idtipocliente ==3)
                ret = "Timbrado Post-Pago";
            return ret;
        }

        //protected string vendedorxid(int? idvendedor)
        //{
        //    using (Prospect BD = new Prospect())
        //    {
        //        if (idvendedor != 0)
        //            return BD.Promotores.Where(p => p.IdPromotor == idvendedor).ToList().First().Nombre;
        //        else
        //            return "No asignado";
        //    }
        //}
      private void GetSistemas()
        {

            //List<prospecto> pros = new List<prospecto>();
            //List<Prospecto_View> pv = new List<Prospecto_View>();
            //using (prospectovic BD = new prospectovic())
            //{

            //    var conn = new SqlConnection();
            //    conn.ConnectionString = "Persist Security Info=False;Password=Ntlink.2018;User ID=ntlinkv; Initial Catalog=ProduccionNtlink;Data Source=192.168.15.251";
            //    conn.Open();
            //    SqlCommand consulta = new SqlCommand(string.Format("select Razonsocial,RFC,emailcontacto,Telefono,Vendedor,fechacontacto from prospect where Razonsocial = '" + txtBusqueda.Text + "'" + "or RFC = '" + txtBusqueda.Text + "'"), conn);

            //    SqlDataAdapter da = new SqlDataAdapter(consulta);

            //    DataTable dt = new DataTable();

            //    da.Fill(dt);
            //    tabla.DataSource = dt;
            //    tabla.DataBind();




            //}
            //foreach (var item in pros)
            //{
            //    Prospecto_View aux = new Prospecto_View()
            //    {
            //        Emailcontacto = item.Emailcontacto,
            //        Tipocliente = TC(item.Tipocliente),
            //        RFC = item.RFC,
            //        Fechacontacto = item.Fechacontacto,
            //        idVendedor = vendedorxid(item.idVendedor),
            //        Razonsocial = item.Razonsocial,
            //        Telefonos = item.Telefonos
            //    };
            //    pv.Add(aux);
            //}
            //tabla.DataSource = pv;
            //tabla.DataBind();


            var conn = new SqlConnection();
            conn.ConnectionString = "Persist Security Info=False;Password=Ntlink.2018;User ID=ntlinkv; Initial Catalog=ProduccionNtlink;Data Source=192.168.15.251";
            conn.Open();
            SqlCommand consulta = new SqlCommand(string.Format("select Razonsocial,RFC,Email,Telefono,Vendedor,Fechacontacto,Tipocliente from prospect where Razonsocial LIKE '" + txtBusqueda.Text + "%'" + "or RFC LIKE '" + txtBusqueda.Text + "%'"), conn);

            SqlDataAdapter da = new SqlDataAdapter(consulta);

            DataTable dt = new DataTable();

            da.Fill(dt);
            tabla.DataSource = dt;
            tabla.DataBind();


            conn.Close();


        }


    

        protected void btnNuevoCliente_Click(object sender, EventArgs e)
        {
            Response.Redirect("wfrClientes.aspx");
        }


        protected void ddlEjecutivos_OnSelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("wfrClientes.aspx");
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("NuevoProspecto.aspx");
        }

        protected void pruebagv_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = tabla.SelectedRow;

            Prospect obj = new Prospect()
            {
               RFC = row.Cells[2].Text,
               RazonSocial = row.Cells[1].Text,
                
                Email = row.Cells[3].Text,

                Telefono = row.Cells[4].Text,
               

            };

            Session["DataMiClase"] = obj;

            Response.Redirect("wfrClientes.aspx");
        }

       
    }
}