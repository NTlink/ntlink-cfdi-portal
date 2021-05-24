using System;
using System.ServiceModel;
using ServicioLocalContract;

namespace GafLookPaid
{
    public partial class wfrSucursales : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                var cliente = NtLinkClientFactory.Cliente();
                  
                string idSucursalString = this.Request.QueryString["idSucursal"];
                int idSucursal;
                if (!string.IsNullOrEmpty(idSucursalString) && int.TryParse(idSucursalString, out idSucursal) && this.Request.QueryString["idEmpresa"] != null)
                {
                    using (cliente as IDisposable)
                    {
                        Sucursales sucursal = cliente.ObtenerSucursal(idSucursal);
                        // txtIdEmpresa.Value = this.Request.QueryString["idEmpresa"];
                        //if (sucursal.IdEmpresa != (int) Session["idEmpresa"])
                        //{
                        //    this.Response.Write("No puedes editar esta Sucursal");
                        //    this.Response.End();
                        //}

                        this.txtNombre.Text = sucursal.Nombre;
                        this.txtDomicilio.Text = sucursal.Direccion;
                        ViewState["sucursal"] = sucursal;
                        //-----------------------------
                        ddlEstado.DataSource = cliente.Consultar_EstadosALL();
                        ddlEstado.DataTextField = "NombredelEstado";
                        ddlEstado.DataValueField = "c_Estado1";
                        ddlEstado.DataBind();
                        if (!string.IsNullOrEmpty(sucursal.Estado))
                            this.ddlEstado.SelectedValue = sucursal.Estado;

                        ddlMunicipio.DataSource = cliente.Consultar_MunicipioALL(ddlEstado.SelectedValue);
                        ddlMunicipio.DataTextField = "Descripción";
                        ddlMunicipio.DataValueField = "c_Municipio1";
                        ddlMunicipio.DataBind();
                        if (!string.IsNullOrEmpty(sucursal.Minicipio))
                            this.ddlMunicipio.SelectedValue = sucursal.Minicipio;

                        ddlCP.DataSource = cliente.Consultar_CPALL(ddlEstado.SelectedValue, ddlMunicipio.SelectedValue);
                        ddlCP.DataTextField = "c_CP1";
                        ddlCP.DataValueField = "c_CP1";
                        ddlCP.DataBind();
                        if (!string.IsNullOrEmpty(sucursal.LugarExpedicion))
                            this.ddlCP.SelectedValue = sucursal.LugarExpedicion;
                        //-------------------------------

                    }
                }
                else
                {
                    using (cliente as IDisposable)
                    {
                        ddlEstado.DataSource = cliente.Consultar_EstadosALL();
                        ddlEstado.DataTextField = "NombredelEstado";
                        ddlEstado.DataValueField = "c_Estado1";
                        ddlEstado.DataBind();
                    
                        ddlMunicipio.DataSource = cliente.Consultar_MunicipioALL(ddlEstado.SelectedValue);
                        ddlMunicipio.DataTextField = "Descripción";
                        ddlMunicipio.DataValueField = "c_Municipio1";
                        ddlMunicipio.DataBind();
                          ddlCP.DataSource = cliente.Consultar_CPALL(ddlEstado.SelectedValue, ddlMunicipio.SelectedValue);
                        ddlCP.DataTextField = "c_CP1";
                        ddlCP.DataValueField = "c_CP1";
                        ddlCP.DataBind();
                      }
                }
                txtIdEmpresa.Value = this.Request.QueryString["idEmpresa"];
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            var sucursal = ViewState["sucursal"] as Sucursales ?? new Sucursales
                                                                      {
                                                                          IdEmpresa = int.Parse(txtIdEmpresa.Value)
                                                                      };
            sucursal.Nombre = this.txtNombre.Text;
            sucursal.LugarExpedicion = this.ddlCP.SelectedValue;
            sucursal.Estado = this.ddlEstado.SelectedValue;
            sucursal.Minicipio = this.ddlMunicipio.SelectedValue;
            sucursal.Direccion = this.txtDomicilio.Text;
            
             var cliente = NtLinkClientFactory.Cliente();
             using (cliente as IDisposable)
             {
                 try
                 {
                     if (cliente.GuardaSucursal(sucursal))
                     {
                         this.Response.Redirect("wfrSucursalesConsulta.aspx?idEmpresa="  + txtIdEmpresa.Value);
                     }
                     else
                     {
                         this.lblError.Text = "No se puedo guardar la sucursal";
                     }
                 }
                 catch (FaultException ex)
                 {
                     this.lblError.Text = ex.Message;
                 }
             }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            this.Response.Redirect("wfrSucursalesConsulta.aspx?idEmpresa=" + txtIdEmpresa.Value);
        }

        protected void ddlEstado_SelectedIndexChanged(object sender, EventArgs e)
        {
             var cliente = NtLinkClientFactory.Cliente();
             using (cliente as IDisposable)
             {

                 ddlMunicipio.DataSource = cliente.Consultar_MunicipioALL(ddlEstado.SelectedValue);
                 ddlMunicipio.DataTextField = "Descripción";
                 ddlMunicipio.DataValueField = "c_Municipio1";
                 ddlMunicipio.DataBind();
                 ddlCP.DataSource = cliente.Consultar_CPALL(ddlEstado.SelectedValue, ddlMunicipio.SelectedValue);
                 ddlCP.DataTextField = "c_CP1";
                 ddlCP.DataValueField = "c_CP1";
                 ddlCP.DataBind();
             }

        }

        protected void ddlMunicipio_SelectedIndexChanged(object sender, EventArgs e)
        {
            var cliente = NtLinkClientFactory.Cliente();
            using (cliente as IDisposable)
            {

                ddlCP.DataSource = cliente.Consultar_CPALL(ddlEstado.SelectedValue, ddlMunicipio.SelectedValue);
                ddlCP.DataTextField = "c_CP1";
                ddlCP.DataValueField = "c_CP1";
                ddlCP.DataBind();
            }

        }

        protected void ddlCP_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

    }
}