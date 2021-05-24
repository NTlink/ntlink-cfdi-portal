using System;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using ServicioLocalContract;

namespace NtLinkAdministracion
{
    public partial class wfrEditarAdministradores : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                var cliente = NtLinkClientFactory.Cliente();
                string idString = this.Request.QueryString["idChange"];
                if (!String.IsNullOrEmpty(idString))
                {
                    var usuario = cliente.GetUserAdminById(Convert.ToInt32(idString));
                    this.txbUser.Text = usuario.Nombre;
                    this.txbUser.Enabled = this.rfvUser.Enabled = false;
                    this.txbName.Text = usuario.NombreReal;
                    this.txbAMaterno.Text = usuario.aMaterno;
                    this.txbAPaterno.Text = usuario.apaterno;
                    this.gvAdminSettings.Visible = true;
                }
                else
                {
                    this.lblPass.Visible = false;
                    this.txbPass.Visible = false;
                    this.lnkChange.Visible = false;
                    this.lblPassRefresh.Visible = true;
                    this.txbPassRefresh.Visible = true;
                    this.lblConfirm.Visible = true;
                    this.txbConfirm.Visible = true;
                }
                this.gvAdminSettings.DataSource = refill(ConfigurationManager.AppSettings["DocumentosAdmin"]);
                this.gvAdminSettings.DataBind();
            }
        }

        protected void lnkChange_Click(object sender, EventArgs e)
        {          
            var cliente = NtLinkClientFactory.Cliente();
            string idString = this.Request.QueryString["idChange"];
            
            var usuario = cliente.GetUserAdminById(Convert.ToInt32(idString));
            if(cliente.CheckPasswd(Convert.ToInt32(idString),txbPass.Text))
            {
                this.lblPassRefresh.Visible = true;
                this.txbPassRefresh.Visible = true;
                this.lblConfirm.Visible = true;
                this.txbConfirm.Visible = true;
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "err_msg",
                "alert('Password Incorrecto');", true);
                this.txbPass.Text = "[Oculto]";
                //this.txbPass.Focus();
            }
            
        }

        protected void lnkSave_Click(object sender, EventArgs e)
        {
            var cliente = NtLinkClientFactory.Cliente();
            string idString = this.Request.QueryString["idChange"]; 
            cliente.GetUserAdminById(Convert.ToInt32(idString));
            if(String.IsNullOrEmpty(idString))
            {
                if(txbPassRefresh.Text==txbConfirm.Text)
                {
                    int id= cliente.SaveAdmin(txbUser.Text, txbName.Text, txbAPaterno.Text, txbAMaterno.Text, txbConfirm.Text);
                    this.Response.Redirect("wfrEditarAdministradores.aspx?idChange=" + id);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "err_msg",
                    "alert('Los passwords no coinciden');", true);
                    txbPassRefresh.Text = "";
                    txbConfirm.Text = "";
                    txbPassRefresh.Focus();
                }
            }
            else
            {
                if(txbPassRefresh.Text==txbConfirm.Text && txbConfirm.Visible==false)
                {
                    cliente.UpdateAdmin(Convert.ToInt32(idString), this.txbUser.Text, this.txbName.Text, this.txbAPaterno.Text, this.txbAMaterno.Text, this.txbConfirm.Text);
                }else
                {
                    if (txbPassRefresh.Text == txbConfirm.Text)
                    {
                        cliente.UpdateAdmin(Convert.ToInt32(idString), this.txbUser.Text, this.txbName.Text, this.txbAPaterno.Text, this.txbAMaterno.Text, this.txbConfirm.Text);
                    }else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "err_msg",
                        "alert('Los passwords no coinciden');", true);
                        txbPassRefresh.Text = "";
                        txbConfirm.Text = "";
                        txbPassRefresh.Focus();
                    }
                }
            }
        }

        protected void ckbSelected_CheckedChanged(object sender, EventArgs e)
        {
            string idString = this.Request.QueryString["idChange"];
            var cliente = NtLinkClientFactory.Cliente();
            CheckBox chk = (CheckBox)sender;
            GridViewRow gr = (GridViewRow)chk.Parent.Parent;
            string path =Convert.ToString(this.gvAdminSettings.DataKeys[gr.RowIndex].Value);
            if (chk.Checked)
            {
                if(!cliente.FindPath(Convert.ToInt32(idString),path))
                {
                    cliente.NewPath(Convert.ToInt32(idString), path);
                }
            }
            else
            {
                cliente.DelPath(Convert.ToInt32(idString), path);
            }
        }

        protected void gvAdminSettings_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            string idString = this.Request.QueryString["idChange"];
            
            if(e.Row.RowType == DataControlRowType.DataRow)
            {
                var cliente = NtLinkClientFactory.Cliente();
                string path = Convert.ToString(this.gvAdminSettings.DataKeys[e.Row.RowIndex].Value);
                bool isChecked = cliente.FindPath(Convert.ToInt32(idString),path);
                CheckBox chk = e.Row.FindControl("ckbSelected") as CheckBox;
                chk.Checked = isChecked;
                
            }
        }

        public DataTable refill(string cadena)
        {
            string path = cadena; 
            var list= path.Split('|').ToList();
            DataTable dt = new DataTable();
            dt.Columns.Add("path");

            foreach(var item in list)
            {
                DataRow dr = dt.NewRow(); dr["path"] = item;
                dt.Rows.Add(dr);
            }
            return dt;
        }
    }
}