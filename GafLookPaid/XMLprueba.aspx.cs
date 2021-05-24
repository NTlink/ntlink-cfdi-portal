using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GafLookPaid
{
    public partial class XMLprueba : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (exaxml.PostedFile != null)

            {

                try

                {

                    string strFileName = System.IO.Path.GetFileName(exaxml.PostedFile.FileName);
                    
                }

                catch

                {



                }

            }
        }






    }
}