using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using ServicioLocalContract;
using System.Collections.Generic;
using System.Linq;
using System.Configuration;
using System.Data;
using System.IO;
using System.ServiceModel;
using System.Web;
using System.Data.SqlClient;

namespace GafLookPaid
{
    public partial class wfrActualizaciones : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                this.FillView();
            }
        }

        #region HelperMethods

        private void FillView()
        {
            
        }

        #endregion

       
    }
}