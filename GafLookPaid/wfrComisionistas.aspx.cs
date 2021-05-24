using System;
using System.ServiceModel;
using ServicioLocalContract;

namespace GafLookPaid
{
    public partial class wfrComisionistas1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!this.IsPostBack)
            {
                string idComisionistaString = this.Request.QueryString["idComisionista"];
                int idComisionista;
                if(!string.IsNullOrEmpty(idComisionistaString) && int.TryParse(idComisionistaString, out idComisionista))
                {
                    var cliente = NtLinkClientFactory.Cliente();
                    using (cliente as IDisposable)
                    {
                        Comisionistas comisionista = cliente.ObtenerComisionista(idComisionista);

                        if (comisionista.IdEmpresa != (int)Session["idEmpresa"])
                        {
                            this.Response.Write("No puedes editar este Comisionista");
                            this.Response.End();
                        }

                        this.txtEmail.Text = comisionista.Email;
                        this.txtNombre.Text = comisionista.Nombre;
                        this.txtTelefono.Text = comisionista.Telefono;

                        ViewState["comisionista"] = comisionista;
                    }
                }
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            var comisionista = ViewState["comisionista"] as Comisionistas ?? new Comisionistas
                                                                                 {
                                                                                     IdEmpresa = (int) Session["idEmpresa"]
                                                                                 };
            comisionista.Nombre = this.txtNombre.Text;
            comisionista.Email = this.txtEmail.Text;
            comisionista.Telefono = this.txtTelefono.Text;

            try
            {
                var cliente = NtLinkClientFactory.Cliente();
                using (cliente as IDisposable)
                {
                    if(!cliente.GuardaComisionista(comisionista))
                    {
                        this.lblError.Text = "No se pudo guardar el Comisionista";
                        return;
                    }
                }
                this.Response.Redirect("wfrComisionistasConsulta.aspx");
            }
            catch (FaultException ex)
            {
                this.lblError.Text = ex.Message;
            }
        }
    }
}