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
    public partial class Impuestos : System.Web.UI.UserControl
    {
        public delegate void LlamarMetodoEnPadre(); // este es el tipo 
        public LlamarMetodoEnPadre UpdateTotales { get; set; } // esta es la variable que ni recibe ni devuelve valor alguno 
        public string ClaveConcepto { get; set; }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                Session["ImpLocalesRGV"] = new ImpLocales();
            }
        }


        protected void btnAgregarImp_Click(object sender, EventArgs e)
        {
            CultureInfo cul = CultureInfo.CreateSpecificCulture("es-MX");
      
            var imp = Session["ImpLocalesRGV"] as ImpLocales;
                        
            ImpuestosL L=new ImpuestosL();
            L.Importe =  decimal.Parse(txtImporte.Text, NumberStyles.Currency).ToString("C", cul);
            //L.ImpLoc=txtImpLoc.Text;
            L.Tasa = decimal.Parse(this.txtTasa.Text, NumberStyles.Currency).ToString("C", cul);
            L.Tasa = L.Tasa.Replace("$", "");
            L.ImpuestosLocales=ddlImpuesto.SelectedValue;
            imp.imp.Add(L);

            decimal sumaRetenciones = 0.00M;
            decimal sumaTraslados = 0.00M;
            foreach (ImpuestosL i in imp.imp)
            {
               if(i.ImpuestosLocales=="RetencionesLocales")
                   sumaRetenciones = sumaRetenciones + decimal.Parse(i.Importe, NumberStyles.Currency);
               if (i.ImpuestosLocales == "TrasladosLocales")
                   sumaTraslados = sumaTraslados + decimal.Parse(i.Importe, NumberStyles.Currency);

            }

            imp.TotaldeRetenciones = sumaRetenciones.ToString("C", cul); 
            imp.TotaldeTraslados = sumaTraslados.ToString("C", cul); 
            Session["ImpLocalesRGV"] = imp;

            BindImpuestosToGridView();
        }

        protected void gvImpuestosLocales_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            CultureInfo cul = CultureInfo.CreateSpecificCulture("es-MX");
            if (e.CommandName.Equals("EliminarConcepto"))
            {
                var imp = Session["ImpLocalesRGV"] as ImpLocales;
                var eliminado = imp.imp.ElementAt(Convert.ToInt32(e.CommandArgument));
                imp.imp.RemoveAt(Convert.ToInt32(e.CommandArgument));

                if (eliminado.ImpuestosLocales == "RetencionesLocales")
                    imp.TotaldeRetenciones = (decimal.Parse(imp.TotaldeRetenciones, NumberStyles.Currency) - decimal.Parse(eliminado.Importe, NumberStyles.Currency)).ToString("C", cul);
                else
                    imp.TotaldeTraslados = (decimal.Parse(imp.TotaldeTraslados, NumberStyles.Currency) - decimal.Parse(eliminado.Importe, NumberStyles.Currency)).ToString("C", cul);

                Session["ImpLocalesRGV"] = imp;
                this.BindImpuestosToGridView();
                UpdateTotales();
            }
        }

        private void BindImpuestosToGridView()
        {
            var imp = Session["ImpLocalesRGV"] as ImpLocales;
            if (imp != null && imp.imp.Count > 0)
            {
                int noColumns = this.gvImpuestosLocales.Columns.Count;
                this.gvImpuestosLocales.Columns[noColumns - 1].Visible = true;
            }
            else
            {
                int noColumns = this.gvImpuestosLocales.Columns.Count;
                this.gvImpuestosLocales.Columns[noColumns - 1].Visible = false;
            }
            this.gvImpuestosLocales.DataSource = imp.imp;
            this.gvImpuestosLocales.DataBind();
            this.UpdateTotales();
            this.txtImporte.Text = "";
            this.txtTasa.Text = "";
           // this.txtImpLoc.Text="";
        }
        public void AltaClaveConcepto()
        {

          //  ddlConceptos.Items.Add(ClaveConcepto);
            txtImporte.Text = ClaveConcepto;
        
        }
      
    }
}