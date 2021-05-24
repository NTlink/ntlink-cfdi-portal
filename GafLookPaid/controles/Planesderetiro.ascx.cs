using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GafLookPaid.controles
{
    public partial class Planesderetiro : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void chActivar_CheckedChanged(object sender, EventArgs e)
        {
            if (chActivar.Checked == true)
            {
                txtMontAportODep.Enabled = true;
                txtRFCFiduciaria.Enabled = true;
                RequiredFieldValidator2.Enabled = true;
                
            }
            else
            {
                txtMontAportODep.Enabled = false;
                txtRFCFiduciaria.Enabled = false;
                txtMontAportODep.Text = "";
                txtRFCFiduciaria.Text="";
                RequiredFieldValidator2.Enabled = false;
                
             
            }
        }

        protected void chActivar2_CheckedChanged(object sender, EventArgs e)
        {
            if (chActivar2.Checked == true)
            {
                txtMontAportODep2.Enabled = true;
                txtRFCFiduciaria2.Enabled = true;
                RequiredFieldValidator3.Enabled = true;
            }
            else
            {
                txtMontAportODep2.Enabled = false;
                txtRFCFiduciaria2.Enabled = false;
                txtMontAportODep2.Text = "";
                txtRFCFiduciaria2.Text = "";
                RequiredFieldValidator3.Enabled = false;
            }
        }

        protected void chActivar3_CheckedChanged(object sender, EventArgs e)
        {
            if (chActivar3.Checked == true)
            {
                txtMontAportODep3.Enabled = true;
                txtRFCFiduciaria3.Enabled = true;
                RequiredFieldValidator4.Enabled = true;
                RequiredFieldValidator4.Enabled = false;
           
            }
            else
            {
                txtMontAportODep3.Enabled = false;
                txtRFCFiduciaria3.Enabled = false;
                txtMontAportODep3.Text = "";
                txtRFCFiduciaria3.Text = "";

            }
        }
    }
}