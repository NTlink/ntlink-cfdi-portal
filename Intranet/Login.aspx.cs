using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace Intranet
{
    public partial class Login1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Log_Click(object sender, EventArgs e)
        {

            var conn = new SqlConnection();
            conn.ConnectionString = "Persist Security Info=False;Password=Ntlink.2018;User ID=Victor; Initial Catalog=Intranet;Data Source=192.168.15.252";
                conn.Open();
           
            string query = "select Usuario,Pass from usuario where Usuario='" + UserName.Text + "' and Pass='" + Password.Text + "'";

            SqlCommand cmd = new SqlCommand(query, conn);
            SqlDataReader leerbd = cmd.ExecuteReader();

            if (leerbd.Read() == true)
            {

                Session["usuario"] = UserName.Text;
                Response.Redirect("~/Main.aspx");
            }

            else
            {
                lblusuario.Text = "Error de inicio de Sesión";
                lblusuario.ForeColor = System.Drawing.Color.Red;

            }
            conn.Close();
        }
    }
}