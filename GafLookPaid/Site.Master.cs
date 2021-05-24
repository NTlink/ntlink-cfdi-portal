using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using System.Windows.Forms.VisualStyles;
using ServicioLocalContract;
using System.Web.UI;

namespace GafLookPaid
{
    public partial class SiteMaster : System.Web.UI.MasterPage
        {


        void Page_Init(object sender, EventArgs e)
        {
            if (Session["userId"] == null)
            {
                this.Response.Redirect("wfrLogin.aspx");
            }
            else
            {
                int indiceFacturas = 3;
                var perfil = Session["perfil"] as string;
                if (perfil != "Administrador")
                {
                    //this.NavigationMenu.Items.RemoveAt(0);
                    //this.NavigationMenu.Items.RemoveAt(1);

                    indiceFacturas = 3;
                }
                var pantallas = Session["panatallas"] as List<empresaPantalla>;
                if (pantallas != null)
                {
                    var itemsToDelete = this.NavigationMenu.Items[indiceFacturas].ChildItems.Cast<MenuItem>()
                        .Where(menuItem => !pantallas.Any(l => l.pantalla.Equals(menuItem.Text))).ToList();
                    foreach (var item in itemsToDelete)
                    {
                        if (item.Text.ToString() != "items")//medida preventiva
                        {
                            this.NavigationMenu.Items[indiceFacturas].ChildItems.Remove(item);
                        }
                    }
                }
                //this.NavigationMenu.Items[indiceFacturas].ChildItems.
                    var sistema = Session["TipoSistema"] as int?;
               
                if (sistema.HasValue && (sistema.Value == 1 || sistema.Value == 3))
                {
                    //if (perfil == "Administrador")
                    //{
                        this.NavigationMenu.Items.RemoveAt(0);
                        this.NavigationMenu.Items.RemoveAt(1);
                        this.NavigationMenu.Items.RemoveAt(1);
                        this.NavigationMenu.Items.RemoveAt(1);//se modifico 3 a 4
                        this.NavigationMenu.Items.RemoveAt(3);
                    //}
                    //else
                    //{
                    //    this.NavigationMenu.Items.RemoveAt(3);
                    //    this.NavigationMenu.Items.RemoveAt(3);
                    //    this.NavigationMenu.Items.RemoveAt(3);
                    //}

                }
                if (sistema.HasValue && sistema.Value == 2)
                {
                    this.NavigationMenu.Items.RemoveAt(1);
                    this.NavigationMenu.Items.RemoveAt(1);
                    this.NavigationMenu.Items.RemoveAt(1);
                    this.NavigationMenu.Items.RemoveAt(1);
                     this.NavigationMenu.Items.RemoveAt(3);
                    
                }
                
                if (perfil == "Administrador" && (sistema.HasValue && sistema.Value == 0))
                {
                    
                    if (NavigationMenu.Items.Count >= 6)
                    {

                        this.NavigationMenu.Items.RemoveAt(6);
                        this.NavigationMenu.Items.RemoveAt(6);
                        this.NavigationMenu.Items.RemoveAt(0);
                    }
                     
                }
                
                if (perfil == "Operador" && (sistema.HasValue && sistema.Value == 0))
                {
                    this.NavigationMenu.Items.RemoveAt(0);
                    this.NavigationMenu.Items.RemoveAt(0);

                    this.NavigationMenu.Items.RemoveAt(3);
                    this.NavigationMenu.Items.RemoveAt(3);
                    this.NavigationMenu.Items.RemoveAt(3);
                    
                }


                if (perfil == "Vendedor" && (sistema.HasValue && sistema.Value == 0))
                {
                    this.NavigationMenu.Items.RemoveAt(0);
                    this.NavigationMenu.Items.RemoveAt(0);
                    this.NavigationMenu.Items.RemoveAt(0);
                    this.NavigationMenu.Items.RemoveAt(0);
                    this.NavigationMenu.Items.RemoveAt(1);
                    this.NavigationMenu.Items.RemoveAt(1);
                    this.NavigationMenu.Items.RemoveAt(1);
                    this.NavigationMenu.Items.RemoveAt(1);


                    MenuItem item = NavigationMenu.Items[0].ChildItems[2];
                    item.Parent.ChildItems.Remove(item);


                    MenuItem itemi = NavigationMenu.Items[0].ChildItems[2];
                    itemi.Parent.ChildItems.Remove(itemi);


                }


                this.lblEmpresa.Text = Session["razonSocial"] as string;
                this.lblNombreUsuario.Text = Session["nombre"] as string;
                var emision = Session["SaldoEmision"];
                var timbrado = Session["SaldoTimbrado"];
                var contratos = Session["Contratos"] ?? "0";
                lblEmision.Text = emision.ToString();
                lblTimbrado.Text = timbrado.ToString();
                lblContratos.Text = contratos.ToString();


                //------------------Folios restantes----------------

                var emite = Convert.ToInt32(emision);
                if (emite < 10)
                {


                    lblEmision.ForeColor = System.Drawing.Color.Red;

                }


                //----------------para ir a cuentas por pagar---------

                CPPagar cpp = new CPPagar();
                string rfc = "";
                string correo = "";
                try
                {
                     rfc = Session["RGVRFC"].ToString();
                     correo = Session["UserNameRGV"].ToString();
                }
                catch (Exception ex)
                {        
                }

                // HyperLink2.NavigateUrl = 
                // Session["RGVNavigateUrl"] = cpp.llenarURLCPP(rfc, correo);//URL;
                // menuCPP.NavigateUrl = cpp.llenarURLCPP(rfc, correo);//URL;
                MenuItemCollection R = NavigationMenu.Items;

                foreach (MenuItem item in R)
                {
                    if (item.Text == "Servicios")
                    {
                        MenuItemCollection c = item.ChildItems;
                        foreach (MenuItem hijo in c)
                        {
                            if (hijo.Text == "CuentasPorPagar")

                                hijo.NavigateUrl = cpp.llenarURLCPP(rfc, correo);//URL;
                            break;
                        }
                    }
                }
                //--------------------------------
           
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
          //  hfTiempo.Value = DateTime.UtcNow.ToString(); 
            //if (!this.IsPostBack)
            //{
            //    ActualizarSaldosMaster("333", "22", "1");
            //}
        }


       

        protected void NavigationMenu_MenuItemClick(object sender, MenuEventArgs e)
        {
           
        }

        protected void btnActualizarSaldos_OnClick(object sender, EventArgs e)
        {
            var sis = Session["idSistema"] as long?;
            if (sis == null)
            {
                this.Response.Redirect("wfrLogin.aspx");
            }
            var cliente = NtLinkClientFactory.Cliente();
            using (cliente as IDisposable)
            {
                var sistema = cliente.ObtenerSistemaById((int)sis.Value, true);
                Session["SaldoEmision"] = sistema.SaldoEmision;
                Session["SaldoTimbrado"] = sistema.SaldoTimbrado;
                Session["Contratos"] = sistema.TimbresContratados;
                var emision = Session["SaldoEmision"];
                var timbrado = Session["SaldoTimbrado"];
                var contratos = Session["Contratos"] ?? "0";
                lblEmision.Text = emision.ToString();
                lblTimbrado.Text = timbrado.ToString();
                lblContratos.Text = contratos.ToString();
                updateSaldos.Update();
            }
        }
       
        public Label labelEmision
        {
            get { return lblEmision; }
            set { lblEmision = value; }
        }
        public Label labeltimbrado
        {
            get { return lblTimbrado; }
            set { lblTimbrado = value; }
        }
        public Label labelcontratos
        {
            get { return lblContratos; }
            set { lblContratos = value; }
        }
        public UpdatePanel panel
        {
            get { return updateSaldos; }
            set { updateSaldos = value; }
        }

       
    }
}
