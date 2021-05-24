using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GafLookPaid.controles
{
    public partial class Pagoaextranjeros : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            beneficiario.Visible = true;
            noBeneficiario.Visible = false;  
        }

        protected void ddlEsBenefEfectDelCobro_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(ddlEsBenefEfectDelCobro.SelectedValue=="SI")
            { beneficiario.Visible = true; noBeneficiario.Visible = false;  }
            else
                 { beneficiario.Visible = false; noBeneficiario.Visible = true; }
        }
    }
}