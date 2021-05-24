using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ServicioLocalContract;
using System.Globalization;

namespace GafLookPaid.controles
{
    public partial class ServicioParcialConstrucciones : System.Web.UI.UserControl
    {
        public delegate void LlamarMetodoEnPadre(); // este es el tipo 
        public LlamarMetodoEnPadre UpdateTotales { get; set; } // esta es la variable que ni recibe ni devuelve valor alguno 
       
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
              }
        }

        protected void txtNoInterior_TextChanged(object sender, EventArgs e)
        {

        }

        

       
      
    }
}