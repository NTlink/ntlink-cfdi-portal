using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading;
using System.Web.UI;
using System.Web.UI.WebControls;
using ServicioLocalContract;
using ServicioLocalContract.Entities;
using ServicioLocal.catCFDI;
using CatalogosSAT;
using System.Data;

namespace GafLookPaid
{
    public partial class wfrFacturaInnova : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            txtCodigo.Attributes.Add("onkeypress", "javascript:return SoloNum(event); ");
            if (!this.IsPostBack)
            {
                try
                {
                    var perfil = Session["perfil"] as string;
                    var sistema = Session["idSistema"] as long?;
                    var idEmp = Session["idEmpresa"] as int?;
                    int idEmpresaE;
                    var cliente = NtLinkClientFactory.Cliente();
                    using (cliente as IDisposable)
                    {
                        var empresas = cliente.ListaEmpresas(perfil, idEmp.Value, sistema.Value, null);
                        var listaEmpresas = new List<empresa>(empresas);

                        this.ddlEmpresa.DataSource = listaEmpresas;
                        this.ddlEmpresa.DataBind();
                        this.ddlEmpresaE.DataSource = listaEmpresas;
                        this.ddlEmpresaE.DataBind();


                        int idEmpresa = idEmpresaE = listaEmpresas.First().IdEmpresa;

                        if (!cliente.TieneConfiguradoCertificado(idEmpresa))
                        {
                            this.lblError.Text = "Tienes que configurar tus certificados antes de poder facturar";
                            this.btnGenerarFactura.Enabled = this.BtnVistaPrevia.Enabled = this.btnBuscarProducto.Enabled =
                                this.btnAgregar.Enabled = this.ddlMoneda.Enabled = false;
                            return;
                        }

                        if (listaEmpresas.Count > 0)
                        {
                            this.ddlClientes.DataSource = cliente.ListaClientes(perfil, idEmpresa, string.Empty, false);
                            this.ddlClientes.DataBind();
                            this.txtFolio.Text = cliente.SiguienteFolioFactura(idEmpresa);
                            this.txtFolioSat.Text = txtFolio.Text;
                            ddlClientes_SelectedIndexChanged(null, null);
                        }

                        this.ddlSucursales.DataSource = cliente.ListaSucursales(idEmpresa);
                        ddlSucursales.DataValueField = "LugarExpedicion";
                        ddlSucursales.DataTextField = "Nombre";

                        this.ddlSucursales.DataBind();

                        //------------catalogos grandes----------------------

                        /*ddlClaveUnidad.DataSource = cliente.ConsultarClaveUnidadAll().Where(p => p.Nombre == "Pieza" || p.Nombre == "Unidad de servicio" || p.Nombre == "Kilogramo"
                                                    || p.Nombre == "Gramo" || p.Nombre == "Metro" || p.Nombre == "Metro cuadrado" || p.Nombre == "Metro cúbico" || p.Nombre == "Pulgada" || p.Nombre == "Litro" || p.Nombre == "Lote");
                        ListItem l = new ListItem("---Otro---", "0", true);
                        ddlClaveUnidad.DataTextField = "Nombre";
                        ddlClaveUnidad.DataValueField = "c_ClaveUnidad1";
                        ddlClaveUnidad.DataBind();
                        this.ddlClaveUnidad.Items.Add(l);
                        ddlClaveUnidad.SelectedValue = "H87";*/

                        Filtro_ClaveUnidad();//Axl--Se coloco este subprograma para que se visualice la clave de unidad y la descripcion en el ddlClaveUnidad y su respectivo filtrado**

                        ddlClaveUnidadE.DataSource = cliente.ConsultarClaveUnidadAll().OrderBy(p => p.Nombre);//Axl--Se ordena por orden alfabetico
                        ddlClaveUnidadE.DataTextField = "Nombre";
                        ddlClaveUnidadE.DataValueField = "c_ClaveUnidad1";
                        ddlClaveUnidadE.DataBind();
                        ddlClaveUnidadE.SelectedValue = "H87";
                        //--------------------------------------------
                        ddlMoneda.DataSource = cliente.Consultar_MonedaAll().OrderBy(p => p.Descripción);
                        ddlMoneda.DataTextField = "Descripción";
                        ddlMoneda.DataValueField = "c_Moneda1";
                        ddlMoneda.DataBind();
                        ddlMoneda.SelectedValue = "MXN";
                        CatalogosSAT.c_Moneda mone = cliente.Consultar_Moneda(ddlMoneda.SelectedValue);
                        ViewState["DecimalMoneda"] = mone.Decimales;


                    }
                    ViewState["detalles"] = new List<facturasdetalle>();
                    ViewState["detallesImpuestos"] = new List<facturasdetalleRT>();//para impuestos
                    ViewState["CfdiRelacionado"] = new List<string>();
                    ViewState["iva"] = 0M;
                    ViewState["total"] = 0M;
                    ViewState["subtotal"] = 0M;
                    ViewState["descuento"] = 0M;
                    ViewState["Bloq"] = new bool();
                    ViewState["DecimalActual"] = "2";


                    this.BindDetallesToGridView();
                    this.UpdateTotales();
                    Fecha_Sello(idEmpresaE);
                    // ActualizarSaldosMaster();
                }
                catch (Exception ex)
                {
                    //Logger.Error(ex.Message);
                }
            }
        }

        //protected void chkIva_CheckedChanged(object sender, EventArgs e)
        //{
        //    this.txtIva.Enabled = this.chkIva.Checked;
        //    this.UpdateTotales();
        //}


        protected void btnGenerarFactura_Click(object sender, EventArgs e)
        {
            btnGenerarFactura.Enabled = false;
            LblAux.Text = "";
            this.GuardarFactura();
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            var cliente = NtLinkClientFactory.Cliente();
            int idCliente = int.Parse(this.ddlClientes.SelectedValue);
            clientes c = cliente.ObtenerClienteById(idCliente);
            if (string.IsNullOrEmpty(this.txtCantidad.Text.Trim()) ||
               string.IsNullOrEmpty(this.txtPrecio.Text.Trim()) ||
               string.IsNullOrEmpty(this.txtDescripcion.Text.Trim()) ||
               string.IsNullOrEmpty(this.txtUnidad.Text.Trim()))
            {
                this.lblError.Text = "* Error de validación en la partida";
                return;
            }
            this.lblError.Text = string.Empty;

            List<facturasdetalle> detalles = ViewState["detalles"] as List<facturasdetalle>;
            string m = ViewState["DecimalMoneda"].ToString();
            int mon = 0;
            if (!string.IsNullOrEmpty(m))
                mon = Convert.ToInt16(m);
            if (ddlMoneda.SelectedValue == "MXN")
                mon = Convert.ToInt16(ddlDecimales.SelectedValue);

            if (detalles == null)
                ViewState["detalles"] = new List<facturasdetalle>();

            facturasdetalle detalle = new facturasdetalle()
            {
                Partida = detalles.Count + 1,
                Cantidad = decimal.Parse(this.txtCantidad.Text),
                Descripcion = this.txtDescripcion.Text,
                Codigo = this.txtCodigo.Text,
                Unidad = this.txtUnidad.Text,
                Precio = Decimal.Round(decimal.Parse(this.txtPrecio.Text), mon),
               // Total = decimal.Parse(this.txtPrecio.Text) * decimal.Parse(this.txtCantidad.Text) /* Decimal.Round(decimal.Parse(this.txtPrecio.Text) * decimal.Parse(this.txtCantidad.Text), mon)*/,
                Total = Decimal.Round(decimal.Parse(this.txtPrecio.Text) * decimal.Parse(this.txtCantidad.Text), mon),
                idproducto = string.IsNullOrEmpty(txtIdProducto.Value) ? 0 : int.Parse(txtIdProducto.Value),
            };

            if (!string.IsNullOrEmpty(txtDetalles.Text))
                detalle.Observaciones = txtDetalles.Text;

            if (!string.IsNullOrEmpty(txtCuentaPredial.Text))
                detalle.CuentaPredial = txtCuentaPredial.Text;
            // ddlConceptos.Items.Add(this.txtCodigo.Text);
            ddlConceptos.Items.Add(detalle.Partida.ToString());


            // detalle.ConceptoClaveProdServ = this.txtCodigo.Text;
            detalle.ConceptoNoIdentificacion = this.txtNoIdentificacion.Text;
            // detalle.ConceptoCantidad = decimal.Parse(this.txtCantidad.Text);
            detalle.ConceptoClaveUnidad = this.ddlClaveUnidad.SelectedItem.Value;
            //   detalle.ConceptoUnidad = this.txtUnidad.Text;
            //   detalle.ConceptoDescripcion = this.txtDescripcion.Text;
            //  detalle.ConceptoValorUnitario = decimal.Parse(this.txtPrecio.Text);
            //  detalle.ConceptoImporte = decimal.Parse(this.txtPrecio.Text) * decimal.Parse(this.txtCantidad.Text);
            var descuento = ViewState["descuento"].ToString();
            decimal descuento1 = 0M;
            if (!string.IsNullOrEmpty(descuento))
                descuento1 = Convert.ToDecimal(descuento);

            if (!string.IsNullOrEmpty(txtDescuento.Text))
            {
                detalle.ConceptoDescuento = decimal.Parse(this.txtDescuento.Text);
                descuento1 = descuento1 + decimal.Parse(this.txtDescuento.Text);
                // detalle.Total = detalle.Total - descuento1;// se agrego para quitar al total de concepto el descuento
            }
            ViewState["descuento"] = descuento1;

            detalles.Add(detalle);

            ViewState["detalles"] = detalles;
            this.txtIdProducto.Value = null;
            this.Clear();
            this.BindDetallesToGridView();
            this.UpdateTotales();


            //  Impuestos.ClaveConcepto = this.txtCodigo.Text;
            //  Impuestos.AltaClaveConcepto();


            cbImpuestos.Enabled = true;
            //---------------------------------------
            if (cbIVA.Checked == true)
            {
                if (ddlIVA.SelectedValue == "0.160000" || ddlIVA.SelectedValue == "0.000000")
                {
                    AgregarImpuesto(detalle.Partida.ToString(), "Traslados", "002", "Tasa", ddlIVA.SelectedValue);
                }
                else if (ddlIVA.SelectedValue == "Exento")
                {
                    AgregarImpuesto(detalle.Partida.ToString(), "Traslados", "002", ddlIVA.SelectedValue, "0.000000");
                }
            }
            if (cbRIVA.Checked == true)
            {
                AgregarImpuesto(detalle.Partida.ToString(), "Retenciones", "002", "Tasa", ddlRIVA.SelectedValue);
            }
            if (cbRISR.Checked == true)
            {
                AgregarImpuesto(detalle.Partida.ToString(), "Retenciones", "001", "Tasa", "0.100000");
            }
            if (cbIVA.Checked == true || cbRISR.Checked == true || cbRIVA.Checked == true)
            {
                cbImpuestos.Checked = true;
                #region Impuestos
                /*DivComplementos.Visible = true;
                //---------------------------llenado de datos
                var clienteServicio = NtLinkClientFactory.Cliente();
                List<CatalogosSAT.c_TasaOCuota> L;
                bool rango = false;
                using (clienteServicio as IDisposable)
                {
                    L = clienteServicio.Consultar_TasaCuota(ddlImpuesto.SelectedValue, ddlTipoFactor.SelectedValue, ddlTipoImpuesto.SelectedValue, ref rango);
                }

                if (rango == true)
                {
                    txtTasa.Text = "";
                    txtTasa.Enabled = true;
                    txtTasa.Visible = true;
                    ddlTasaOCuota.Enabled = false;
                    ddlTasaOCuota.Visible = false;

                }
                else
                {
                    this.ddlTasaOCuota.Visible = true;
                    this.ddlTasaOCuota.Enabled = true;
                    this.ddlTasaOCuota.DataSource = L;
                    this.ddlTasaOCuota.DataBind();
                    txtTasa.Enabled = false;
                    txtTasa.Visible = false;
                }
                //--
                //List<facturasdetalle> detalles = ViewState["detalles"] as List<facturasdetalle>;

                foreach (var x in detalles)
                {

                    if (x.Partida.ToString() == ddlConceptos.SelectedValue)
                    {
                        if (x.ConceptoDescuento != null)
                            txtBase.Text = (x.Total - x.ConceptoDescuento).ToString();
                        else
                            txtBase.Text = x.Total.ToString();
                        break;
                    }

                }*/
                #endregion
                cbIVA.Checked = true;
                ddlIVA.Enabled = true;
                cbRISR.Checked = false;
                cbRIVA.Checked = false;
                ddlRIVA.Enabled = false;
            }
            if (cbImpuestos.Checked == true)
            {
                ActImpuestos();
            }
            LblAux.Text = "";
            //---------------------------------------

            this.txtdsc.Text = "";//---------------------------------------


            if (this.descuento.Checked == true)
            {
                this.descuento.Checked = false;
                txtdsc.Enabled = false;

            }
        }

        protected void ddlEmpresa_SelectedIndexChanged(object sender, EventArgs e)
        {
            var cliente = NtLinkClientFactory.Cliente();
            using (cliente as IDisposable)
            {
                int idEmpresa = int.Parse(this.ddlEmpresa.SelectedValue);
                if (!cliente.TieneConfiguradoCertificado(idEmpresa))
                {
                    this.lblError.Text = "Tienes que configurar tus certificados antes de poder facturar";
                    this.btnGenerarFactura.Enabled = this.BtnVistaPrevia.Enabled =
                        this.btnAgregar.Enabled = this.ddlMoneda.Enabled = false;
                    this.ddlClientes.DataSource = cliente.ListaClientes(Session["perfil"] as string, idEmpresa, string.Empty, false);
                    this.ddlClientes.DataBind();
                    return;
                }
                var emp = cliente.ObtenerEmpresaById(idEmpresa);
                divViasConcesionadas.Visible = emp.RFC == "VCN940426PJ4";
                lblMensaje.Text = "";
                lblMensajeHistorico.Text = "";

                lblError.Text = "";
                this.ddlSucursales.DataSource = cliente.ListaSucursales(idEmpresa);
                ddlSucursales.DataValueField = "LugarExpedicion";
                ddlSucursales.DataTextField = "Nombre";
                ddlSucursales.DataBind();
                this.btnGenerarFactura.Enabled = this.BtnVistaPrevia.Enabled =
                        this.btnAgregar.Enabled = this.ddlMoneda.Enabled = true;
                this.txtFolio.Text = cliente.SiguienteFolioFactura(idEmpresa);
                this.txtFolioSat.Text = txtFolio.Text;

                this.ddlClientes.DataSource = cliente.ListaClientes(Session["perfil"] as string, idEmpresa, string.Empty, false);
                this.ddlClientes.DataBind();

                ddlClientes_SelectedIndexChanged(null, null);
                ViewState["detalles"] = new List<facturasdetalle>();
                ViewState["iva"] = 0M;
                ViewState["total"] = 0M;
                ViewState["subtotal"] = 0M;

                this.BindDetallesToGridView();
                this.UpdateTotales();
                Fecha_Sello(idEmpresa);
            }
        }

        protected void btnGenerarPreview_Click(object sender, EventArgs e)
        {
            LblAux.Text = "";
            if (!ValidarFactura())
                return;

            var pdf = Preview();
            if (pdf == null)
            {
                if (string.IsNullOrEmpty(this.lblError.Text))
                    this.lblError.Text = "Error al generar vista previa";
                return;
            }
            Response.AddHeader("Content-Disposition", "attachment; filename=preview.pdf");
            this.Response.ContentType = "application/pdf";
            this.lblError.Text = string.Empty;
            this.Response.BinaryWrite(pdf);
            this.Response.End();
        }


        protected void ddlMoneda_SelectedIndexChanged(object sender, EventArgs e)
        {
            var cliente = NtLinkClientFactory.Cliente();
            using (cliente as IDisposable)
            {
                CatalogosSAT.c_Moneda mone = cliente.Consultar_Moneda(ddlMoneda.SelectedValue);
                ViewState["DecimalMoneda"] = mone.Decimales;


                if (this.ddlMoneda.SelectedValue != "MXN")
                {
                    this.txtTipoCambio.Visible = true;
                    this.lblTipoCambio.Visible = true;

                    this.txtConfirmacion.Visible = true;//c
                    this.LblConfirmacion.Visible = true;//c

                    CatalogosSAT.Divisas D = cliente.Consultar_TipoDivisa(this.ddlMoneda.SelectedValue);
                    if (D != null)
                        txtTipoCambio.Text = D.PesosDivisa.ToString();
                    else
                        txtTipoCambio.Text = "";


                }
                else
                {
                    txtTipoCambio.Text = "";

                    this.txtTipoCambio.Visible = false;
                    this.lblTipoCambio.Visible = false;

                    this.txtConfirmacion.Visible = false;//c
                    this.LblConfirmacion.Visible = false;//c
                }
            }
        }

        protected void ddlClientes_SelectedIndexChanged(object sender, EventArgs e)
        {
            var cliente = NtLinkClientFactory.Cliente();
            if (string.IsNullOrEmpty(this.ddlClientes.SelectedValue))
                return;
            using (cliente as IDisposable)
            {
                int idCliente = int.Parse(this.ddlClientes.SelectedValue);
                clientes c = cliente.ObtenerClienteById(idCliente);
                var sb = new StringBuilder();
                sb.AppendLine(c.RazonSocial);
                sb.AppendLine(c.RFC);
                // sb.AppendLine(c.Direccion + " " + c.Colonia);
                // sb.AppendLine(c.Ciudad + " " + c.Estado + " " + c.CP);
                this.txtRazonSocial.Text = sb.ToString();
                //this.txtCuenta.Text = c.CuentaPago;
                //this.ddlMetodoPago.Text = c.MetodoPago;
            }
        }

        protected void gvDetalles_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("EliminarConcepto"))
            {
                var detalles = ViewState["detalles"] as List<facturasdetalle>;
                var detallesImpuestos = ViewState["detallesImpuestos"] as List<facturasdetalleRT>;
                facturasdetalle dt = detalles.ElementAt(Convert.ToInt32(e.CommandArgument));
                string x = dt.Partida.ToString();
                decimal desc = 0M;
                if (dt.ConceptoDescuento != null)
                    desc = (decimal)dt.ConceptoDescuento;

                detalles.RemoveAt(Convert.ToInt32(e.CommandArgument));
                ddlConceptos.Items.Remove(x);
                //Reestructuracion de conceptos-----------------------------
                foreach (var edit in detalles)
                {
                    if (edit.Partida > Convert.ToDecimal(x))
                    {
                        edit.Partida -= 1;
                    }
                }
                //----------------------------------------------------------
                ViewState["detalles"] = detalles;

                detallesImpuestos.RemoveAll(p => p.ConceptoClaveProdServ == x);
                //Reestructuracion de conceptos-----------------------------
                foreach (var editimp in detallesImpuestos)
                {
                    if (Convert.ToDecimal(editimp.ConceptoClaveProdServ) > Convert.ToDecimal(x))
                    {
                        editimp.ConceptoClaveProdServ = (Convert.ToDecimal(editimp.ConceptoClaveProdServ) - 1).ToString();
                    }
                }
                //----------------------------------------------------------
                ViewState["detallesImpuestos"] = detallesImpuestos;
                BindDetallesImpuestosToGridView();
                this.BindDetallesToGridView();

                var descuento = ViewState["descuento"].ToString();
                decimal descuento1 = 0M;
                if (!string.IsNullOrEmpty(descuento))
                    descuento1 = Convert.ToDecimal(descuento);

                descuento1 = descuento1 - desc;
                ViewState["descuento"] = descuento1;
                UpdateTotales();
                if (cbImpuestos.Checked == true)
                {
                    ActImpuestos();
                }
            }
            if (e.CommandName.Equals("Editar"))
            {
                var detalles = ViewState["detalles"] as List<facturasdetalle>;
                var edicion = detalles[Convert.ToInt32(e.CommandArgument)];
                ViewState["detalles"] = detalles;
                this.hidNumero.Value = e.CommandArgument.ToString();
                /* this.hidDetalle.Value = edicion.idproducto.ToString();*/
                this.txtUnidadEdita.Text = edicion.Unidad;
                this.txtCantidadEdita.Text = edicion.Cantidad.ToString();
                this.txtNoIdentificacionEdita.Text = edicion.ConceptoNoIdentificacion;
                this.txtDescripcionEdita.Text = edicion.Descripcion;
                this.txtObservacionesEdita.Text = edicion.Observaciones;//C
                this.txtPrecioUnitarioEdita.Text = edicion.Precio.ToString();
                this.txtCuentaPredialE.Text = edicion.CuentaPredial;//C
                this.txtCodigoE.Text = edicion.Codigo;
                this.txtDescuentoE.Text = edicion.ConceptoDescuento.ToString();
                this.ddlClaveUnidadE.SelectedValue = edicion.ConceptoClaveUnidad.ToString();

                mpeEdita.Show();
            }
        }
        protected void btnBuscarConcepto_Click(object sender, EventArgs e)
        {
            var cliente = NtLinkClientFactory.Cliente();

            using (cliente as IDisposable)
            {
                List<CatalogosSAT.c_ClaveProdServ> lista = cliente.BuscarClaveProdServSearch(this.txtConceptoBusqueda.Text);
                if (lista.Count > 20)
                {
                    this.lblMensaje.Text = lista.Count + " resultados, mostrando los primeros 20, refina tu busqueda";
                }
                this.gvBuscarConceptos.DataSource = new List<CatalogosSAT.c_ClaveProdServ>(lista.Take(20).ToList());
                this.gvBuscarConceptos.DataBind();
            }
            this.mpeBuscarConceptos.Show();
        }

        protected void btnSeleccionarConcepto_Click(object sender, EventArgs e)
        {
            if (this.gvBuscarConceptos.Rows.Count > 0)
            {
                var detalles = ViewState["detalles"] as List<facturasdetalle>;
                for (int x = 0; x < this.gvBuscarConceptos.Rows.Count; x++)
                {
                    var chkSeleccion = this.gvBuscarConceptos.Rows[x].FindControl("chkSeleccion") as CheckBox;
                    if (chkSeleccion == null || !chkSeleccion.Checked)
                    {
                        continue;
                    }

                    int idProducto = Convert.ToInt32(this.gvBuscarConceptos.DataKeys[x].Value);

                    var cliente = NtLinkClientFactory.Cliente();
                    using (cliente as IDisposable)
                    {
                        producto prod = cliente.ObtenerProductoById(idProducto);

                        decimal precio = prod.PrecioP.HasValue ? prod.PrecioP.Value : 0;

                        var detalle = new facturasdetalle
                        {
                            Partida = detalles.Count + 1,
                            Cantidad = 1,
                            Descripcion = prod.Descripcion,
                            Codigo = prod.Codigo,
                            Unidad = prod.Unidad,
                            Descripcion2 = prod.Observaciones,
                            Precio = precio,
                            Total = precio * 1,
                            CuentaPredial = prod.CuentaPredial,
                        };

                        detalles.Add(detalle);
                    }
                }
                ViewState["detalles"] = detalles;
                this.BindDetallesToGridView();
                this.UpdateTotales();
            }
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            //this.ClearAll();
            Response.Redirect("wfrFacturaAdo.aspx");
        }

        #region Helper Methods

        private void GetTipoCambio()
        {
            var cliente = NtLinkClientFactory.Cliente();
            using (cliente as IDisposable)
            {
                string tipoCambio = cliente.TipoCambio();
                this.txtTipoCambio.Text = tipoCambio;
            }
        }

        private bool ValidarFactura()
        {
            if ((ViewState["detalles"] as List<facturasdetalle>).Count == 0)
            {
                this.lblError.Text = "La factura no puede estar vacía";
                return false;
            }
            if (string.IsNullOrEmpty(this.txtFolio.Text))
            {
                this.lblError.Text = "Escribe el folio de la factura";
                return false;
            }
            if (txtFechaPago.Visible && !string.IsNullOrEmpty(txtFechaPago.Text))
            {
                var fecha = DateTime.ParseExact(txtFechaPago.Text, "dd/MM/yyyy", new CultureInfo("es-MX"));
                if (fecha > DateTime.Now)
                {
                    this.lblError.Text = "La fecha de pago de la factura esta fuera de rango";
                    return false;
                }
                if (fecha.Year != DateTime.Now.Year)
                {
                    this.lblError.Text = "La fecha de pago de la factura esta fuera de rango";
                    return false;
                }
            }
            if (ddlTipoDocumento.SelectedValue == "Donativo")
            {
                if (string.IsNullOrEmpty(txtDonatAutorizacion.Text))
                {
                    this.lblError.Text = "Escribe el número de autorización del donativo";
                    return false;
                }
                if (string.IsNullOrEmpty(txtDonatFechautorizacion.Text))
                {
                    this.lblError.Text = "Escribe la fecha de autorización del donativo";
                    return false;
                }

            }
            //*  ya no es obligatorio */
            /*
            if ((this.ddlMetodoPago.SelectedValue == "02" || this.ddlMetodoPago.SelectedValue == "03" || this.ddlMetodoPago.SelectedValue == "04"
              || this.ddlMetodoPago.SelectedValue == "05") && string.IsNullOrEmpty(this.txtCuenta.Text))
            {
                this.lblError.Text = "Falta agregar el #Cuenta o # Tarjeta. ";
                return false;
            }*/
            return true;
        }
        //-------------------------------------------


        private void GuardarFactura()
        {
            bool error = false;
            if (ValidarFactura())
            {
                var detalles = ViewState["detalles"] as List<facturasdetalle>;
                var iniciales = Session["iniciales"] as string;
                var fact = GetFactura(iniciales, detalles);
                try
                {
                    var clienteServicio = NtLinkClientFactory.Cliente();
                    int idCliente = int.Parse(this.ddlClientes.SelectedValue);
                    clientes c = clienteServicio.ObtenerClienteById(idCliente);
                    using (clienteServicio as IDisposable)
                    {
                        List<facturasdetalle33> fact33 = new List<facturasdetalle33>();
                        foreach (var de in detalles)
                        {
                            facturasdetalle33 f33 = new facturasdetalle33();
                            f33.ConceptoRetenciones = de.ConceptoRetenciones;
                            f33.ConceptoTraslados = de.ConceptoTraslados;
                            f33.ConceptoClaveProdServ = de.Codigo;
                            f33.partida = de.Partida.ToString();
                            fact33.Add(f33);
                        }
                        var ss=clienteServicio.GuardarFactura33(fact, detalles, fact33, true, null, null);
                        if (!ss.resultado)
                        {
                            this.lblError.Text = "* Error al generar la factura";
                            btnGenerarFactura.Enabled = true;
                            return;
                        }
                        this.lblError.Text = string.Empty;
                        Session["UUDINuevo"] = "";
                        string x = ss.UUDI;
                        Session["UUDINuevo"] = x;
                    }
                    this.ClearAll();
                }
                catch (FaultException ae)
                {
                    error = true;
                    this.lblError.Text = ae.Message;
                }
                catch (ApplicationException ae)
                {
                    error = true;
                    //Logger.Error(ae.Message);
                    if (ae.InnerException != null)
                    {
                        //Logger.Error(ae.InnerException.Message);
                    }
                    this.lblError.Text = ae.Message;
                }
                catch (Exception ae)
                {
                    error = true;
                    //Logger.Error(ae.Message);
                    if (ae.InnerException != null)
                    {
                        //Logger.Error(ae.InnerException.Message);
                    }
                    this.lblError.Text = "Error al generar el comprobante:" + ae.Message;
                }
                if (!error)
                {
                    //this.lblError.Text = "Comprobante generado correctamente  y enviado por correo electrónico";

                    ActualizarSaldosMaster();
                    mpeCFDIG.Show();
                    //this.Page.Response.Write("<script language='JavaScript'>window.alert('Comprobante generado');</script>");
                }
                else
                    btnGenerarFactura.Enabled = true;
                // this.lblError.Text = string.Empty;
            }
            else
                btnGenerarFactura.Enabled = true;
        }

        private facturas GetFactura(string iniciales, List<facturasdetalle> detalles)
        {
            var fact = new facturas
            {
                TipoDocumentoSAT = TipoDocumento.Innova,
                TipoDocumento = TipoDocumento.Innova,
                IdEmpresa = int.Parse(this.ddlEmpresa.SelectedValue),
                Importe = decimal.Parse(this.lblTotal.Text, NumberStyles.Currency),
                //IVA = decimal.Parse(this.lblIva.Text, NumberStyles.Currency),
                SubTotal = decimal.Parse(this.lblSubtotal.Text, NumberStyles.Currency),
                Total = decimal.Parse(this.lblTotal.Text, NumberStyles.Currency),
                //PorcentajeIva = int.Parse(this.txtIva.Text),
                PorcentajeIva = 16,
                MonedaID = this.ddlMoneda.SelectedValue,
                idcliente = int.Parse(this.ddlClientes.SelectedValue),
                Fecha = DateTime.Now,
                Folio = this.txtFolioSat.Text,//this.txtFolio.Text.PadLeft(4, '0'),
                FolioSAT = this.txtFolio.Text.PadLeft(4, '0'),
                Serie = string.IsNullOrEmpty(this.txtSerie.Text) ? null : this.txtSerie.Text,
                nProducto = detalles.Count,
                captura = DateTime.Now,
                Cancelado = 0,
                Usuario = iniciales,
                LugarExpedicion = this.ddlSucursales.SelectedValue,
                Proyecto = this.txtProyecto.Text,
                /*
                MetodoID = this.ddlMetodoPago.SelectedValue != "99" ? this.ddlMetodoPago.SelectedValue : "99",
                Metodo =this.ddlMetodoPago.SelectedValue != "99"
                        ? this.ddlMetodoPago.SelectedItem.Text: txtMetodoPago.Text,
                */

                MonedaS = this.ddlMoneda.SelectedItem.Text,
                // Cuenta = string.IsNullOrEmpty(this.txtCuenta.Text) ? null : this.txtCuenta.Text,
                VoBoNombre = this.txtVoBoNombre.Text,
                VoBoPuesto = this.txtVoBoPuesto.Text,
                VoBoArea = this.txtVoBoArea.Text,
                RecibiNombre = this.txtRecibiNombre.Text,
                RecibiPuesto = this.txtRecibiPuesto.Text,
                RecibiArea = this.txtRecibiArea.Text,
                AutorizoNombre = this.txtAutorizoNombre.Text,
                AutorizoPuesto = this.txtAutorizoPuesto.Text,
                AutorizoArea = this.txtAutorizoArea.Text,
                //  CondicionesPado=this.txtCondicionesPago.Text,
                UsoCFDI = this.ddlUsoCFDI.SelectedValue

            };


            if (ddlFormaPago.SelectedValue != "00")
            {
                fact.FormaPagoID = this.ddlFormaPago.SelectedValue;
                fact.FormaPago = this.ddlFormaPago.SelectedItem.Text;
            }
            if (ddlMetodoPago.SelectedValue != "00")
            {
                fact.MetodoID = this.ddlMetodoPago.SelectedValue;
                fact.Metodo = this.ddlMetodoPago.SelectedItem.Text;
            }
            if (!string.IsNullOrEmpty(this.txtTipoCambio.Text))
                fact.TipoCambio = Convert.ToDecimal(this.txtTipoCambio.Text);
            if (!string.IsNullOrEmpty(this.txtConfirmacion.Text))
                fact.Confirmacion = this.txtConfirmacion.Text;
            if (!string.IsNullOrEmpty(this.txtCondicionesPago.Text))
                fact.CondicionesPado = this.txtCondicionesPago.Text;


            if (ddlTipoDocumento.SelectedValue == "Egreso")
                fact.NotaCredito = true;
            if (ddlTipoDocumento.SelectedValue == "Donativo")
            {
                fact.TipoDocumento = TipoDocumento.Donativo;
                fact.DonativoAutorizacion = txtDonatAutorizacion.Text;
                fact.DonativoFechaAutorizacion = DateTime.ParseExact(txtDonatFechautorizacion.Text, "dd/MM/yyyy",
                                                                     new CultureInfo("es-MX"));
            }
            if (ddlTipoDocumento.SelectedValue == "Arrendamiento")
                fact.TipoDocumento = TipoDocumento.Arrendamiento;
            if (ddlTipoDocumento.SelectedValue == "Honorarios")
                fact.TipoDocumento = TipoDocumento.Honorarios;
            if (ddlTipoDocumento.SelectedValue == "Ingreso")
                fact.TipoDocumento = TipoDocumento.Ingreso;

            if (!string.IsNullOrEmpty(txtFolioOriginal.Text))
            {
                //var fecha = txtFechaOriginal.Text;
                fact.Fecha = DateTime.ParseExact(txtFechaOriginal.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
                fact.FolioFiscalOriginal = txtFolioOriginal.Text;
                fact.SerieFolioFiscalOriginal = txtSerieOriginal.Text;
                fact.MontoFolioFiscalOriginal = Decimal.Parse(txtMontoOriginal.Text);
            }
            fact.Fecha = DateTime.Now;

            List<string> CfdiRelacionado = ViewState["CfdiRelacionado"] as List<string>;

            if (CfdiRelacionado != null)
                if (CfdiRelacionado.Count() > 0)
                {
                    fact.UUID = CfdiRelacionado;
                    fact.TipoRelacion = ddlTipoRelacion.SelectedValue;
                }
            if (ddlStatusFactura.SelectedValue == "1")
            {
                fact.StatusPago = true;
                fact.FechaPago = Convert.ToDateTime(txtFechaPago.Text);
            }
            else
                fact.StatusPago = false;

            /*
            if (ddlStatusFactura.SelectedValue == "1" && !string.IsNullOrEmpty(txtFechaPago.Text))
            {
                fact.FechaPago = DateTime.ParseExact(txtFechaPago.Text, "dd/MM/yyyy", new CultureInfo("es-MX"));
                fact.ReferenciaPago = txtCuenta.Text;
            }
             */
            /*
            fact.Vencimiento = string.IsNullOrEmpty(this.txtDiasRevision.Text)
                                   ? fact.Fecha
                                   : fact.Fecha.AddDays(int.Parse(this.txtDiasRevision.Text));
           
             */
            fact.DatosAduanera = GetDatosFacturaAduana();
            if (ddlMoneda.SelectedValue == "MXN")
                fact.NumeroDecimal = ddlDecimales.SelectedValue;


            return fact;
        }
        private DatosFacturaAduanera GetDatosFacturaAduana()
        {
            //campos txt factura addenda mabe
            DatosFacturaAduanera dfa = new DatosFacturaAduanera
            {
                Proveedor = txttype.Text,
                Valor = txtreferenceIdentification.Text,


            };
            return dfa;
        }


        private byte[] Preview()
        {
            bool error = false;

            var detalles = ViewState["detalles"] as List<facturasdetalle>;
            var iniciales = Session["iniciales"] as string;
            var fact = GetFactura(iniciales, detalles);

            try
            {
                var clienteServicio = NtLinkClientFactory.Cliente();
                int idCliente = int.Parse(this.ddlClientes.SelectedValue);
                clientes c = clienteServicio.ObtenerClienteById(idCliente);
                using (clienteServicio as IDisposable)
                {
                    List<facturasdetalle33> fact33 = new List<facturasdetalle33>();
                    foreach (var de in detalles)
                    {
                        facturasdetalle33 f33 = new facturasdetalle33();
                        f33.ConceptoRetenciones = de.ConceptoRetenciones;
                        f33.ConceptoTraslados = de.ConceptoTraslados;
                        f33.ConceptoClaveProdServ = de.Codigo;
                        f33.partida = de.Partida.ToString();
                        fact33.Add(f33);
                    }


                    var pdf = clienteServicio.FacturaPreview33(fact, detalles, fact33, null, null);
                    if (pdf == null)
                    {
                        this.lblError.Text = "* Error al generar la factura";
                        return null;
                    }
                    else return pdf;
                }
            }
            catch (FaultException ae)
            {
                error = true;
                this.lblError.Text = ae.Message;
            }
            catch (ApplicationException ae)
            {
                error = true;
                //Logger.Error(ae.Message);
                if (ae.InnerException != null)
                {
                    //Logger.Error(ae.InnerException.Message);
                }
                this.lblError.Text = ae.Message;
            }
            catch (Exception ae)
            {
                error = true;
                //Logger.Error(ae.Message);
                if (ae.InnerException != null)
                {
                    //Logger.Error(ae.InnerException.Message);
                }
                this.lblError.Text = "Error al generar el comprobante: " + ae.Message;

            }
            if (!error)
            {
                this.lblError.Text = "Comprobante generado correctamente";
            }
            //this.lblError.Text = string.Empty;
            return null;
        }

        private void Clear()
        {
            this.txtCodigo.Text = this.txtDescripcion.Text = this.txtDetalles.Text = this.txtPrecio.Text =
                this.txtCantidad.Text = this.txtUnidad.Text = txtNoIdentificacion.Text = txtDescuento.Text = txtCuentaPredial.Text = string.Empty;
        }

        private void ClearAll()
        {
            this.Clear();
            cbImpuestos.Visible = false;
            this.txtProyecto.Text = this.txtFolioOriginal.Text = this.txtFechaOriginal.Text = this.txtMontoOriginal.Text = this.txtFolioSat.Text =
             txtProyecto.Text = this.txtSerie.Text = string.Empty;
            this.ddlStatusFactura.SelectedIndex = 0;
            this.txtFechaPago.Text = "";
            this.txtFechaPago.Visible = false;
           

            // this.lblIva.Text = 0M.ToString("C");
            this.lblTraslados.Text = 0M.ToString("C");
            this.lblRetenciones.Text = 0M.ToString("C");

            this.lblSubtotal.Text = 0M.ToString("C");
            this.lblTotal.Text = 0M.ToString("C");
            // this.ddlMetodoPago.SelectedIndex = 0;
            //this.ddlMetodoPago_SelectedIndexChanged(null, null);
            var detalles = new List<facturasdetalle>();
            ViewState["detalles"] = detalles;

            var Impuestos = new List<facturasdetalleRT>();
            ViewState["detallesImpuestos"] = Impuestos;//para impuestos
            var Relacionado = new List<string>();
            ViewState["CfdiRelacionado"] = Relacionado;

            this.BindDetallesToGridView();
            this.BindDetallesImpuestosToGridView();
            this.BindCfdiRelacionadoToGridView();

            var cliente = NtLinkClientFactory.Cliente();
            using (cliente as IDisposable)
            {
                int idEmpresa = int.Parse(this.ddlEmpresa.SelectedValue);
                this.txtFolio.Text = cliente.SiguienteFolioFactura(idEmpresa);
                this.txtFolioSat.Text = txtFolio.Text;

            }
            cbImpuestos.Checked = false;
            cbCfdiRelacionados.Checked = false;

            this.descuento.Checked = false;
            this.txtdsc.Text = " ";
        }

        private void BindDetallesToGridView()
        {
            var conceptos = ViewState["detalles"] as List<facturasdetalle>;
            if (conceptos != null && conceptos.Count > 0)
            {
                int noColumns = this.gvDetalles.Columns.Count;
                this.gvDetalles.Columns[noColumns - 1].Visible = this.gvDetalles.Columns[noColumns - 2].Visible = true;
            }
            else
            {
                int noColumns = this.gvDetalles.Columns.Count;
                this.gvDetalles.Columns[noColumns - 1].Visible = this.gvDetalles.Columns[noColumns - 2].Visible = false;
            }
            this.gvDetalles.DataSource = conceptos;
            this.gvDetalles.DataBind();
        }


        private void BindDetallesImpuestosToGridView()
        {
            List<facturasdetalleRT> detallesImpuestos2 = ViewState["detallesImpuestos"] as List<facturasdetalleRT>;
            List<facturasdetalleRT> detallesImpuestos = ViewState["detallesImpuestos"] as List<facturasdetalleRT>;
            if (detallesImpuestos != null && detallesImpuestos.Count > 0)
            {
                int noColumns = this.gvImpuestos.Columns.Count;
                this.gvImpuestos.Columns[noColumns - 1].Visible = this.gvImpuestos.Columns[noColumns - 2].Visible = true;
            }
            else
            {
                int noColumns = this.gvImpuestos.Columns.Count;
                this.gvImpuestos.Columns[noColumns - 1].Visible = this.gvImpuestos.Columns[noColumns - 2].Visible = false;
            }
            foreach (var de in detallesImpuestos2)
            {
                if (de.Impuesto == "001")
                    de.Impuesto = "ISR";
                if (de.Impuesto == "002")
                    de.Impuesto = "IVA";
                if (de.Impuesto == "003")
                    de.Impuesto = "IEPS";
            }

            this.gvImpuestos.DataSource = detallesImpuestos2;
            this.gvImpuestos.DataBind();
        }
        private void BindCfdiRelacionadoToGridView()
        {
            List<string> CfdiRelacionado = ViewState["CfdiRelacionado"] as List<string>;
            if (CfdiRelacionado != null && CfdiRelacionado.Count > 0)
            {
                int noColumns = this.gvCfdiRelacionado.Columns.Count;
                this.gvCfdiRelacionado.Columns[noColumns - 1].Visible = true;
            }
            else
            {
                int noColumns = this.gvCfdiRelacionado.Columns.Count;
                this.gvCfdiRelacionado.Columns[noColumns - 1].Visible = false;
            }


            DataTable table = new DataTable();
            table.Columns.Add("ID");
            table.Columns.Add("UUID");
            int t = 0;
            foreach (var array in CfdiRelacionado)
            {
                DataRow row1 = table.NewRow();
                row1["ID"] = t + 1;
                row1["UUID"] = array;
                table.Rows.Add(row1);
                t++;
            }

            this.gvCfdiRelacionado.DataSource = table;
            this.gvCfdiRelacionado.DataBind();
        }


        private void UpdateTotales()
        {

            CultureInfo cul = CultureInfo.CreateSpecificCulture("es-MX");
            var cliente = NtLinkClientFactory.Cliente();
            //int idCliente = int.Parse(this.ddlClientes.SelectedValue);
            //clientes c = cliente.ObtenerClienteById(idCliente);
            var detalles = ViewState["detalles"] as List<facturasdetalle>;
            var descuento = ViewState["descuento"].ToString();
            string m = ViewState["DecimalMoneda"].ToString();
            int mon = 0;
            if (!string.IsNullOrEmpty(m))
                mon = Convert.ToInt16(m);
            
            decimal descuento1 = 0M;
            if (!string.IsNullOrEmpty(descuento))
                descuento1 = Convert.ToDecimal(descuento);

            if (detalles == null)
                return;
            var iva = 0M;
            var total = 0M;
            var subtotal = 0M;
            var retenciontotal = 0M;
            var trasladototal = 0M;

            foreach (facturasdetalle detalle in detalles)
            {
                //  subtotal += detalle.TotalPartida;
                subtotal += detalle.Total;//para descuento
                iva += detalle.ImporteIva.HasValue ? detalle.ImporteIva.Value : 0;
                //total += detalle.TotalPartida + (detalle.ImporteIva.HasValue ? detalle.ImporteIva.Value : 0);
                total += detalle.Total + (detalle.ImporteIva.HasValue ? detalle.ImporteIva.Value : 0);

                foreach (var det in detalle.ConceptoTraslados)
                {
                    if (det.Importe != null)
                        trasladototal = (decimal)(trasladototal + det.Importe);
                }
                foreach (var ret in detalle.ConceptoRetenciones)
                {
                    retenciontotal = (decimal)(retenciontotal + ret.Importe);
                }

            }
            if (trasladototal > 0)
                trasladototal = Decimal.Round(trasladototal, mon);
            if (retenciontotal > 0)
                retenciontotal = Decimal.Round(retenciontotal, mon);
            if (descuento1 > 0)
                descuento1 = Decimal.Round(descuento1, mon);

            total = total + trasladototal - retenciontotal - descuento1;

            /*  int idEmpresa = int.Parse(this.ddlEmpresa.SelectedValue);
              var emp = cliente.ObtenerEmpresaById(idEmpresa);

              if (emp.RFC == "CEJ060126UI2" || emp.RFC == "BTE1209279P8" || emp.RFC == "ASN1211077Y2" || emp.RFC == "SID080303VE0")
              {
                  this.lblIva.Text = iva.ToString("#0.00##", cul);
                  this.lblTotal.Text = total.ToString("#0.00##", cul);
                  this.lblSubtotal.Text = subtotal.ToString("#0.00##", cul);
              }
              else
              {*/
            this.lblDescuento.Text = descuento1.ToString("C", cul);
            this.lblRetenciones.Text = retenciontotal.ToString("C", cul);
            this.lblTraslados.Text = trasladototal.ToString("C", cul);

            this.lblTotal.Text = total.ToString("C", cul);
            this.lblSubtotal.Text = subtotal.ToString("C", cul);
            //     }
        }

        #endregion

        protected void gvBuscarConceptos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int idProducto = Convert.ToInt32(this.gvBuscarConceptos.DataKeys[Convert.ToInt32(e.CommandArgument)].Value);
            var cliente = NtLinkClientFactory.Cliente();
            using (cliente as IDisposable)
            {
                CatalogosSAT.c_ClaveProdServ prod = cliente.ObtenerClaveProdServById(idProducto);
                //  this.txtIdProducto.Value = idProducto.ToString();
                //  this.txtCantidad.Text = "1";
                this.txtCodigo.Text = prod.c_ClaveProdServ1.ToString();
                if (txtCodigo.Text.Length < 8)
                    txtCodigo.Text = "0" + txtCodigo.Text;

                // this.txtDescripcion.Text = prod.Descripcion;
                //  this.txtUnidad.Text = prod.Unidad;
                //  this.txtPrecio.Text = prod.PrecioP.HasValue ? prod.PrecioP.Value.ToString() : string.Empty;
                //  this.txtCuentaPredial.Text = prod.CuentaPredial;
                //  this.txtDetalles.Text = prod.Observaciones;

            }

            this.mpeBuscarConceptos.Hide();
        }

        protected void ddlStatusFactura_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlStatusFactura.SelectedValue == "1")
            {
                this.lblFechaPago.Visible = true;
                this.txtFechaPago.Text = DateTime.Now.ToString("dd/MM/yyyy");
                this.txtFechaPago.Visible = true;

                //this.ddlMetodoPago.SelectedValue = "PUE"; //c
                //ddlFormaPago.SelectedValue = "00"; //c
            }
            else
            {
                this.lblFechaPago.Visible = false;
                this.txtFechaPago.Text = DateTime.Now.ToString("dd/MM/yyyy");
                this.txtFechaPago.Visible = false;

                //this.ddlMetodoPago.SelectedValue = "PPD"; //c
                //ddlFormaPago.SelectedValue = "99"; //c

            }
        }

        /* BTNGuardar Antiguo
         * protected void btnGuardar_Click(object sender, EventArgs e)
        {
            var detalles = ViewState["detalles"] as List<facturasdetalle>;
            var edicion = detalles[Convert.ToInt32(this.hidNumero.Value)];
           
           // edicion.idproducto = int.Parse(this.hidDetalle.Value);
            edicion.Unidad = this.txtUnidadEdita.Text;
            edicion.Cantidad = decimal.Parse(this.txtCantidadEdita.Text);
            edicion.Codigo = this.txtCodigoE.Text;
            edicion.Descripcion = this.txtDescripcionEdita.Text; 
            edicion.Descripcion2 = this.txtObservacionesEdita.Text;
            edicion.Precio = decimal.Parse(this.txtPrecioUnitarioEdita.Text);
            if (!string.IsNullOrEmpty(txtDescuento.Text))
                edicion.ConceptoDescuento = decimal.Parse(this.txtDescuentoE.Text);

            edicion.ConceptoNoIdentificacion = this.txtNoIdentificacionEdita.Text;
            edicion.ConceptoClaveUnidad = this.ddlClaveUnidadE.SelectedValue;
           // edicion.CuentaPredial = this.txtCuentaPredialEdita.Text;
           edicion.Total = edicion.Precio * edicion.Cantidad;
           if (edicion.PorcentajeIva != null)
               edicion.ImporteIva = ((decimal)edicion.PorcentajeIva / 100) * edicion.Total; //edicion.TotalPartida
          
            ViewState["detalles"] = detalles;
            this.BindDetallesToGridView();
            this.UpdateTotales();
        }*/

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            string m = ViewState["DecimalMoneda"].ToString();
            int mon = 0;
            if (!string.IsNullOrEmpty(m))
                mon = Convert.ToInt16(m);
            if (ddlMoneda.SelectedValue == "MXN")
                mon = Convert.ToInt16(ddlDecimales.SelectedValue);

            var detalles = ViewState["detalles"] as List<facturasdetalle>;
            var edicion = detalles[Convert.ToInt32(this.hidNumero.Value)];

            // edicion.idproducto = int.Parse(this.hidDetalle.Value);
            edicion.Unidad = this.txtUnidadEdita.Text;
            edicion.Cantidad = decimal.Parse(this.txtCantidadEdita.Text);
            edicion.Codigo = this.txtCodigoE.Text;
            edicion.Descripcion = this.txtDescripcionEdita.Text;
            edicion.Descripcion2 = this.txtObservacionesEdita.Text;
            edicion.Precio = decimal.Parse(this.txtPrecioUnitarioEdita.Text);
            /*if (!string.IsNullOrEmpty(txtDescuentoE.Text))
                edicion.ConceptoDescuento = decimal.Parse(this.txtDescuentoE.Text);*/

            edicion.ConceptoNoIdentificacion = this.txtNoIdentificacionEdita.Text;
            edicion.ConceptoClaveUnidad = this.ddlClaveUnidadE.SelectedValue;
            // edicion.CuentaPredial = this.txtCuentaPredialEdita.Text;
            if (edicion.PorcentajeIva != null)
                edicion.ImporteIva = ((decimal)edicion.PorcentajeIva / 100) * edicion.TotalPartida;
            edicion.Total = decimal.Round(edicion.Precio * edicion.Cantidad, mon);
            //ViewState["detalles"] = detalles;
            //this.BindDetallesToGridView();
            //ajuste de descuentos y observaciones ---------------------------------------------------
            edicion.Observaciones = null;
            if (!string.IsNullOrEmpty(txtObservacionesEdita.Text))
                edicion.Observaciones = this.txtObservacionesEdita.Text;
            edicion.CuentaPredial = null;
            if (!string.IsNullOrEmpty(txtCuentaPredialE.Text))
                edicion.CuentaPredial = this.txtCuentaPredialE.Text;
            var descuento = ViewState["descuento"].ToString();
            //var dc1 = edicion.ConceptoDescuento.ToString();
            decimal descuento1 = 0M;
            if (!string.IsNullOrEmpty(descuento))
            {
                descuento1 = Convert.ToDecimal(descuento);
                if (!string.IsNullOrEmpty(edicion.ConceptoDescuento.ToString()))
                {
                    descuento1 = descuento1 - Convert.ToDecimal(edicion.ConceptoDescuento);
                }
                //edicion.ConceptoDescuento;
                //descuento1 = Convert.ToDecimal(descuento) - edicion.ConceptoDescuento;
            }
            edicion.ConceptoDescuento = null;
            if (!string.IsNullOrEmpty(txtDescuentoE.Text))
            {
                edicion.ConceptoDescuento = decimal.Parse(this.txtDescuentoE.Text);
                descuento1 = descuento1 + Convert.ToDecimal(edicion.ConceptoDescuento);
            }

            //ajuste de impuestos----------------------------------------------------

            var detallesImpuestos = ViewState["detallesImpuestos"] as List<facturasdetalleRT>;
            string partida = edicion.Partida.ToString();

            foreach (var x in detallesImpuestos)
            {
                string BaseConcepto = "";
                if (edicion.ConceptoDescuento != null)
                    BaseConcepto = (edicion.Total - edicion.ConceptoDescuento).ToString();
                else
                    BaseConcepto = edicion.Total.ToString();
                if (x.ConceptoClaveProdServ.ToString() == partida)
                {
                    x.Base = Convert.ToDecimal(BaseConcepto);
                    if (x.TipoFactor != "Exento" || x.TipoImpuesto != "Traslados") //no se llenan 
                    {
                        x.Importe = Decimal.Round(Convert.ToDecimal(BaseConcepto) * Convert.ToDecimal(x.TasaOCuota), mon);
                    }
                    foreach (var det in edicion.ConceptoTraslados)
                    {
                        det.Base = Decimal.Round(Convert.ToDecimal(BaseConcepto), 6);
                        if (det.TipoFactor != "Exento")
                        {
                            det.Importe = Decimal.Round(Convert.ToDecimal(BaseConcepto) * Convert.ToDecimal(det.TasaOCuota), mon);
                        }
                    }

                    foreach (var ret in edicion.ConceptoRetenciones)
                    {
                        ret.Base = Decimal.Round(Convert.ToDecimal(BaseConcepto), 6);
                        ret.Importe = Decimal.Round(Convert.ToDecimal(BaseConcepto) * Convert.ToDecimal(ret.TasaOCuota), mon);
                    }
                }
            }
            ViewState["descuento"] = descuento1;
            ViewState["detalles"] = detalles;
            this.BindDetallesToGridView();
            ViewState["detallesImpuestos"] = detallesImpuestos;
            BindDetallesImpuestosToGridView();
            //-----------------------------------------------------------------------
            this.UpdateTotales();
            if (cbImpuestos.Checked == true)
                ActImpuestos();
        }


        protected void ddlMetodoPago_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlMetodoPago.SelectedValue == "PPD")
            {
                divParcialidades.Visible = false;
            }

            else
            {
                divParcialidades.Visible = false;

            }

        }

        protected void ddlTipoDocumento_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlTipoDocumento.SelectedValue == "Donativo")
            {
                trDonativo.Visible = true;
            }
            else trDonativo.Visible = false;


        }
        //---------------------------------------------------------------------------
        public void ActualizarSaldosMaster()
        {
            var sis = Session["idSistema"] as long?;

            if (sis != null)//---nuevo---
            {
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

                    Master.labelcontratos.Text = contratos.ToString();
                    Master.labelEmision.Text = emision.ToString();
                    Master.labeltimbrado.Text = timbrado.ToString();
                    Master.panel.Update();

                }


            }

        }

        //------------------------------------------------------------------------------


        /*
        private void agregarListaMetodoPago(string tipo, bool x)
        {
            string coma = ""; string id = "";
            if (!string.IsNullOrEmpty(txtMetodoPagoMul.Text))
                coma = ", ";
            string texto = txtMetodoPagoMul.Text;
            if (x == true)
            { texto = texto + coma + tipo; }
            else
            { texto = texto.Replace(tipo, ""); }

            texto = texto.Replace(", , ", ", ");
            texto = texto.TrimEnd(' ');
            texto = texto.TrimEnd(',');
            texto = texto.TrimStart(',');
            texto = texto.TrimStart(' ');
            txtMetodoPagoMul.Text = texto;

            id = Check01.Text.Substring(2);
            texto = texto.Replace(id, "");
            id = Check02.Text.Substring(2);
            texto = texto.Replace(id, "");
            id = Check03.Text.Substring(2);
            texto = texto.Replace(id, "");
            id = Check04.Text.Substring(2);
            texto = texto.Replace(id, "");
            id = Check05.Text.Substring(2);
            texto = texto.Replace(id, "");
            id = Check06.Text.Substring(2);
            texto = texto.Replace(id, "");
            id = Check08.Text.Substring(2);
            texto = texto.Replace(id, "");
            id = Check28.Text.Substring(2);
            texto = texto.Replace(id, "");
            id = Check29.Text.Substring(2);
            texto = texto.Replace(id, "");
            id = Check99.Text.Substring(2);
            texto = texto.Replace(" ", "");

            txtMetodoPagoMulID.Text = texto.Replace(id, "");


        }
        */

        protected void ckeckImpuestos_SelectedIndexChanged(object sender, EventArgs e)
        {
        }

        protected void btnAgregarImpuesto_Click(object sender, EventArgs e)
        {
            LblAux.Text = "";
            if (!Existe_Impuesto())//no permite agregar impuestos repetidos AXL 13/04/2018
            {
                List<facturasdetalle> detalles = ViewState["detalles"] as List<facturasdetalle>;
                List<facturasdetalleRT> detallesImpuestos = ViewState["detallesImpuestos"] as List<facturasdetalleRT>;
                string m = ViewState["DecimalMoneda"].ToString();
                int mon = 0;
                if (!string.IsNullOrEmpty(m))
                    mon = Convert.ToInt16(m);
                if (ddlMoneda.SelectedValue == "MXN")
                    mon = Convert.ToInt16(ddlDecimales.SelectedValue);

                foreach (var x in detalles)
                {
                    if (x.Partida.ToString() == ddlConceptos.SelectedValue)//quitando lo del codigo
                                                                           //  if(x.Codigo==ddlConceptos.SelectedValue)
                    {
                        facturasdetalleRT DRT = new facturasdetalleRT();
                        DRT.Base = Decimal.Round(Convert.ToDecimal(txtBase.Text), 6);
                        // DRT.Importe = Convert.ToDecimal(txtImporte.Text);
                        //----
                        if (ddlTipoFactor.SelectedValue != "Exento" || ddlTipoImpuesto.SelectedValue != "Traslados") //no se llenan 
                        {
                            if (ddlTasaOCuota.Visible == true)
                                DRT.Importe = Decimal.Round(Convert.ToDecimal(txtBase.Text) * Convert.ToDecimal(ddlTasaOCuota.SelectedValue), mon);
                            if (txtTasa.Visible == true)
                                DRT.Importe = Decimal.Round(Convert.ToDecimal(txtBase.Text) * Convert.ToDecimal(txtTasa.Text), mon);

                            if (txtTasa.Visible == true)
                                DRT.TasaOCuota = numerodecimales(Convert.ToDecimal(txtTasa.Text), 6);
                            if (ddlTasaOCuota.Visible == true)
                                DRT.TasaOCuota = ddlTasaOCuota.SelectedValue;
                        }
                        //--------------------
                        DRT.Impuesto = ddlImpuesto.SelectedValue;

                        DRT.TipoFactor = ddlTipoFactor.SelectedValue;
                        DRT.TipoImpuesto = ddlTipoImpuesto.SelectedValue;
                        DRT.ConceptoClaveProdServ = ddlConceptos.SelectedValue;
                        if (ddlTipoImpuesto.SelectedValue == "Retenciones")
                        {
                            if (x.ConceptoRetenciones == null)
                                x.ConceptoRetenciones = new List<ServicioLocalContract.Entities.facturasdetalleRetencion>();
                            ServicioLocalContract.Entities.facturasdetalleRetencion retencion = new ServicioLocalContract.Entities.facturasdetalleRetencion();
                            retencion.Base = Decimal.Round(Convert.ToDecimal(txtBase.Text), 6);
                            if (ddlTasaOCuota.Visible == true)
                                retencion.Importe = Decimal.Round(Convert.ToDecimal(txtBase.Text) * Convert.ToDecimal(ddlTasaOCuota.SelectedValue), mon);
                            if (txtTasa.Visible == true)
                                retencion.Importe = Decimal.Round(Convert.ToDecimal(txtBase.Text) * Convert.ToDecimal(txtTasa.Text), mon);

                            //retencion.Importe =Convert.ToDecimal(txtImporte.Text);
                            retencion.Impuesto = ddlImpuesto.SelectedValue;
                            if (txtTasa.Visible == true)
                                retencion.TasaOCuota = numerodecimales(Convert.ToDecimal(txtTasa.Text), 6);
                            if (ddlTasaOCuota.Visible == true)
                                retencion.TasaOCuota = ddlTasaOCuota.SelectedValue;

                            retencion.TipoFactor = ddlTipoFactor.SelectedValue;
                            x.ConceptoRetenciones.Add(retencion);
                        }
                        if (ddlTipoImpuesto.SelectedValue == "Traslados")
                        {
                            if (x.ConceptoTraslados == null)
                                x.ConceptoTraslados = new List<ServicioLocalContract.Entities.facturasdetalleTraslado>();
                            ServicioLocalContract.Entities.facturasdetalleTraslado traslados = new ServicioLocalContract.Entities.facturasdetalleTraslado();
                            traslados.Base = Decimal.Round(Convert.ToDecimal(txtBase.Text), 6);
                            // traslados.Importe = Convert.ToDecimal(txtImporte.Text);
                            if (ddlTipoFactor.SelectedValue != "Exento")
                            {
                                if (ddlTasaOCuota.Visible == true)
                                    traslados.Importe = Decimal.Round(Convert.ToDecimal(txtBase.Text) * Convert.ToDecimal(ddlTasaOCuota.SelectedValue), mon);
                                if (txtTasa.Visible == true)
                                    traslados.Importe = Decimal.Round(Convert.ToDecimal(txtBase.Text) * Convert.ToDecimal(txtTasa.Text), mon);

                                if (txtTasa.Visible == true)
                                    traslados.TasaOCuota = numerodecimales(Convert.ToDecimal(txtTasa.Text), 6);
                                if (ddlTasaOCuota.Visible == true)
                                    traslados.TasaOCuota = ddlTasaOCuota.SelectedValue;
                            }

                            traslados.Impuesto = ddlImpuesto.SelectedValue;
                            traslados.TipoFactor = ddlTipoFactor.SelectedValue;
                            x.ConceptoTraslados.Add(traslados);
                        }
                        detallesImpuestos.Add(DRT);
                    }


                }
                ViewState["detalles"] = detalles;

                ViewState["detallesImpuestos"] = detallesImpuestos;

                // this.gvImpuestos.DataSource = detallesImpuestos;
                // this.gvImpuestos.DataBind();

                BindDetallesImpuestosToGridView();
                this.UpdateTotales();
                //     txtBase.Text = "";
                //     txtTasa.Text = "";
            }
            else
                LblAux.Text = "*Impuesto ya agregado";
        }

        protected void gvImpuestos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("EliminarImpuesto"))
            {
                List<facturasdetalle> detalles = ViewState["detalles"] as List<facturasdetalle>;
                var impuestos = ViewState["detallesImpuestos"] as List<facturasdetalleRT>;
                facturasdetalleRT dt = impuestos.ElementAt(Convert.ToInt32(e.CommandArgument));
                string Impuesto = "";
                if (dt.Impuesto == "IVA")
                    Impuesto = "002";
                if (dt.Impuesto == "ISR")
                    Impuesto = "001";
                if (dt.Impuesto == "IEPS")
                    Impuesto = "003";
                // detalles.RemoveAll(p => p. == x);
                foreach (var x in detalles)
                {
                    if (dt.ConceptoClaveProdServ == x.Partida.ToString())
                    {
                        if (dt.TipoFactor == "Exento")
                            dt.Importe = null;
                        if (dt.TipoImpuesto == "Traslados")
                        {
                            x.ConceptoTraslados.RemoveAll(p => p.Base == dt.Base && p.Importe == dt.Importe
                                      && p.Impuesto == Impuesto && Convert.ToDecimal(p.TasaOCuota) == Convert.ToDecimal(dt.TasaOCuota)
                                      && p.TipoFactor == dt.TipoFactor);

                        }
                        if (dt.TipoImpuesto == "Retenciones")
                        {
                            x.ConceptoRetenciones.RemoveAll(p => p.Base == dt.Base && p.Importe == dt.Importe
                                      && p.Impuesto == Impuesto && Convert.ToDecimal(p.TasaOCuota) == Convert.ToDecimal(dt.TasaOCuota) && p.TipoFactor == dt.TipoFactor);

                        }
                    }
                }

                ViewState["detalles"] = detalles;

                impuestos.RemoveAt(Convert.ToInt32(e.CommandArgument));
                ViewState["detallesImpuestos"] = impuestos;


                this.BindDetallesImpuestosToGridView();
                this.UpdateTotales();

            }

        }

        protected void cbImpuestos_CheckedChanged(object sender, EventArgs e)
        {
            if (cbImpuestos.Checked == true)
            {
                ActImpuestos();
                #region imp
                /*DivComplementos.Visible=true;
                //---------------------------llenado de datos
            var clienteServicio = NtLinkClientFactory.Cliente();
            List<CatalogosSAT.c_TasaOCuota> L;
            bool rango = false;
            using (clienteServicio as IDisposable)
            {
                L = clienteServicio.Consultar_TasaCuota(ddlImpuesto.SelectedValue, ddlTipoFactor.SelectedValue, ddlTipoImpuesto.SelectedValue,ref rango);
            }

                if (rango == true)
                {
                    txtTasa.Text = "";
                    txtTasa.Enabled = true;
                    txtTasa.Visible = true;
                    ddlTasaOCuota.Enabled = false;
                    ddlTasaOCuota.Visible = false;

                }
                else
                {
                    this.ddlTasaOCuota.Visible = true;
                    this.ddlTasaOCuota.Enabled = true;
                    this.ddlTasaOCuota.DataSource = L;
                    this.ddlTasaOCuota.DataBind();
                    txtTasa.Enabled = false;
                    txtTasa.Visible = false;
                }
                //--
            List<facturasdetalle> detalles = ViewState["detalles"] as List<facturasdetalle>;

            foreach (var x in detalles)
            {

                if (x.Partida.ToString() == ddlConceptos.SelectedValue)
                {
                    if (x.ConceptoDescuento != null)
                        txtBase.Text = (x.Total - x.ConceptoDescuento).ToString();
                    else
                    txtBase.Text = x.Total.ToString();
                    break;
                }

            }*/

                #endregion
            }
            else
                DivComplementos.Visible = false;

        }

        protected void Button2_Click(object sender, EventArgs e)
        {

            ddlConceptos.Items.Add(this.txtCodigo.Text);

        }

        protected void btnBuscarHistorico_Click(object sender, EventArgs e)
        {
            mpeBuscarConceptoHistorico.Show();
            this.gvBuscarConceptosHistorico.DataSource = new List<producto>();
            this.gvBuscarConceptosHistorico.DataBind();
        }

        protected void gvBuscarConceptosHistorico_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int idProducto = Convert.ToInt32(this.gvBuscarConceptosHistorico.DataKeys[Convert.ToInt32(e.CommandArgument)].Value);
            var cliente = NtLinkClientFactory.Cliente();
            using (cliente as IDisposable)
            {
                producto prod = cliente.ObtenerProductoById(idProducto);
                this.txtIdProducto.Value = idProducto.ToString();
                this.txtCantidad.Text = "1";
                this.txtCodigo.Text = prod.Codigo;
                this.txtDescripcion.Text = prod.Descripcion;
                this.txtUnidad.Text = prod.Unidad;
                this.txtPrecio.Text = prod.PrecioP.HasValue ? prod.PrecioP.Value.ToString() : string.Empty;
            }
            this.mpeBuscarConceptoHistorico.Hide();


        }

        protected void btnBuscarConceptoHistorico_Click(object sender, EventArgs e)
        {
            var cliente = NtLinkClientFactory.Cliente();
            var idEmpresa = int.Parse(ddlEmpresa.SelectedValue);
            using (cliente as IDisposable)
            {
                List<producto> lista = cliente.BuscarProducto(this.txtConceptoHistoricoBusqueda.Text, idEmpresa);
                if (lista.Count > 20)
                {
                    this.lblMensajeHistorico.Text = lista.Count + " resultados, mostrando los primeros 20, refina tu busqueda";
                }
                this.gvBuscarConceptosHistorico.DataSource = new List<producto>(lista.Take(20).ToList());
                this.gvBuscarConceptosHistorico.DataBind();
            }
            this.mpeBuscarConceptoHistorico.Show();

        }

        protected void ddlConceptos_SelectedIndexChanged(object sender, EventArgs e)
        {
            List<facturasdetalle> detalles = ViewState["detalles"] as List<facturasdetalle>;

            foreach (var x in detalles)
            {

                if (x.Partida.ToString() == ddlConceptos.SelectedValue)
                {
                    if (x.ConceptoDescuento != null)
                        txtBase.Text = (x.Total - x.ConceptoDescuento).ToString();
                    else
                        txtBase.Text = x.Total.ToString();
                    break;
                }

            }
        }

        protected void ddlImpuesto_SelectedIndexChanged(object sender, EventArgs e)
        {
            ACuota();
            var clienteServicio = NtLinkClientFactory.Cliente();
            List<CatalogosSAT.c_TasaOCuota> L;
            bool rango = false;
            using (clienteServicio as IDisposable)
            {
                L = clienteServicio.Consultar_TasaCuota(ddlImpuesto.SelectedValue, ddlTipoFactor.SelectedValue, ddlTipoImpuesto.SelectedValue, ref rango);
            }

            if (rango == true)
            {
                txtTasa.Text = "";
                txtTasa.Enabled = true;
                txtTasa.Visible = true;
                ddlTasaOCuota.Enabled = false;
                ddlTasaOCuota.Visible = false;
            }
            else
            {
                this.ddlTasaOCuota.Visible = true;
                this.ddlTasaOCuota.Enabled = true;
                this.ddlTasaOCuota.DataSource = L;
                this.ddlTasaOCuota.DataBind();
                txtTasa.Enabled = false;
                txtTasa.Visible = false;
            }

        }

        protected void ddlTipoFactor_SelectedIndexChanged(object sender, EventArgs e)
        {
            var clienteServicio = NtLinkClientFactory.Cliente();
            List<CatalogosSAT.c_TasaOCuota> L;
            bool rango = false;

            using (clienteServicio as IDisposable)
            {
                L = clienteServicio.Consultar_TasaCuota(ddlImpuesto.SelectedValue, ddlTipoFactor.SelectedValue, ddlTipoImpuesto.SelectedValue, ref rango);
            }

            if (rango == true)
            {
                txtTasa.Text = "";
                txtTasa.Enabled = true;
                txtTasa.Visible = true;
                ddlTasaOCuota.Enabled = false;
                ddlTasaOCuota.Visible = false;
            }
            else
            {
                this.ddlTasaOCuota.Visible = true;
                this.ddlTasaOCuota.Enabled = true;
                this.ddlTasaOCuota.DataSource = L;
                this.ddlTasaOCuota.DataBind();
                txtTasa.Enabled = false;
                txtTasa.Visible = false;
            }

        }

        protected void ddlTipoImpuesto_SelectedIndexChanged(object sender, EventArgs e)
        {
            ACuota();
            var clienteServicio = NtLinkClientFactory.Cliente();
            List<CatalogosSAT.c_TasaOCuota> L;
            bool rango = false;

            using (clienteServicio as IDisposable)
            {
                L = clienteServicio.Consultar_TasaCuota(ddlImpuesto.SelectedValue, ddlTipoFactor.SelectedValue, ddlTipoImpuesto.SelectedValue, ref rango);
            }

            if (rango == true)
            {
                txtTasa.Text = "";
                txtTasa.Enabled = true;
                txtTasa.Visible = true;
                ddlTasaOCuota.Enabled = false;
                ddlTasaOCuota.Visible = false;
            }
            else
            {
                this.ddlTasaOCuota.Visible = true;
                this.ddlTasaOCuota.Enabled = true;
                this.ddlTasaOCuota.DataSource = L;
                this.ddlTasaOCuota.DataBind();
                txtTasa.Enabled = false;
                txtTasa.Visible = false;
            }

        }

        protected void ddlFormaPago_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlFormaPago.SelectedValue != "99")
            {
                ddlStatusFactura.SelectedValue = "1";
                ddlMetodoPago.SelectedValue = "PUE";
                this.lblFechaPago.Visible = true;
                this.txtFechaPago.Text = DateTime.Now.ToString("dd/MM/yyyy");
                this.txtFechaPago.Visible = true;
            }
            else
            {
                ddlStatusFactura.SelectedValue = "0";
                ddlMetodoPago.SelectedValue = "PPD";
                this.lblFechaPago.Visible = false;
                this.txtFechaPago.Text = DateTime.Now.ToString("dd/MM/yyyy");
                this.txtFechaPago.Visible = false;
            }
        }

        protected void btnBuscarProducto_Click(object sender, EventArgs e)
        {
            this.mpeBuscarConceptos.Show();
            this.gvBuscarConceptos.DataSource = new List<producto>();
            this.gvBuscarConceptos.DataBind();


        }
        private static string numerodecimales(decimal d, int moneda)
        {
            string D = "0";
            if (moneda == 1)
                D = d.ToString("F1");
            if (moneda == 2)
                D = d.ToString("F2");
            if (moneda == 3)
                D = d.ToString("F3");
            if (moneda == 4)
                D = d.ToString("F4");
            if (moneda == 5)
                D = d.ToString("F5");
            if (moneda == 6)
                D = d.ToString("F6");
            return (D);
        }

        protected void cbCfdiRelacionados_CheckedChanged(object sender, EventArgs e)
        {
            if (cbCfdiRelacionados.Checked == true)
            {
                DivCfdiRelacionados.Visible = true;
            }
            else
            {
                DivCfdiRelacionados.Visible = false;

            }

        }

        protected void btnCfdiRelacionado_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtUUDI.Text))
            {
                List<string> CfdiRelacionado = ViewState["CfdiRelacionado"] as List<string>;
                CfdiRelacionado.Add(txtUUDI.Text);
                ViewState["CfdiRelacionado"] = CfdiRelacionado;
                this.BindCfdiRelacionadoToGridView();

                txtUUDI.Text = "";
            }

        }

        protected void gvCfdiRelacionado_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("EliminarCfdiRelacionado"))
            {
                var CfdiRelacionado = ViewState["CfdiRelacionado"] as List<string>;
                CfdiRelacionado.RemoveAt(Convert.ToInt32(e.CommandArgument));
                ViewState["CfdiRelacionado"] = CfdiRelacionado;
                this.BindCfdiRelacionadoToGridView();

            }

        }

        protected void txtFechaPago_TextChanged(object sender, EventArgs e)
        {

        }

        protected void ddlTipoDocumentoo_SelectedIndexChanged(object sender, EventArgs e)
        {
            //if (ddlTipoDocumentoo.SelectedValue == "Donativo")
            //{
            //    trDonativo.Visible = true;
            //}
            //else trDonativo.Visible = false;

        }

        protected void btnCerrar_Click(object sender, EventArgs e)
        {
            Response.Redirect("wfrFacturaInnova.aspx");
        }


        protected void ddlClaveUnidad_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlClaveUnidad.SelectedValue == "0")
            {
                var cliente = NtLinkClientFactory.Cliente();
                List<CatalogosSAT.c_ClaveUnidad> cu = cliente.ConsultarClaveUnidadAll();
                cu = cliente.ConsultarClaveUnidadAll().Select(
                        p =>
                        new CatalogosSAT.c_ClaveUnidad()
                        {
                            Nombre = p.Nombre + " - " + p.c_ClaveUnidad1,
                            c_ClaveUnidad1 = p.c_ClaveUnidad1,
                            Descripcion = p.Nombre

                        }).ToList();

                ddlClaveUnidad.DataSource = cu.OrderBy(p => p.Descripcion);
                //ddlClaveUnidad.DataSource = cliente.ConsultarClaveUnidadAll().OrderBy(p => p.Nombre);
                ddlClaveUnidad.DataTextField = "Nombre";
                ddlClaveUnidad.DataValueField = "c_ClaveUnidad1";
                ddlClaveUnidad.DataBind();
                ddlClaveUnidad.SelectedValue = "H87";
            }
        }

        //----------------------------------------------------------------------------------
        protected void ACuota()
        {
            if (this.ddlImpuesto.SelectedValue == "003" || (this.ddlImpuesto.SelectedValue == "002" && this.ddlTipoImpuesto.SelectedValue == "Retenciones"))
            {
                ddlTipoFactor.Items.Clear();
                ListItem i1 = new ListItem("Tasa", "Tasa", true);
                ddlTipoFactor.Items.Add(i1);
                ListItem i2 = new ListItem("Cuota", "Cuota", true);
                ddlTipoFactor.Items.Add(i2);
                ListItem i3 = new ListItem("Exento", "Exento", true);
                ddlTipoFactor.Items.Add(i3);
            }
            else
            {
                ddlTipoFactor.Items.Clear();
                ListItem i1 = new ListItem("Tasa", "Tasa", true);
                ddlTipoFactor.Items.Add(i1);
                ListItem i3 = new ListItem("Exento", "Exento", true);
                ddlTipoFactor.Items.Add(i3);
            }
        }
        //------------------------------------------------------------------------------
        protected void AgregarImpuesto(string Partida, string TipoImpuesto, string Impuesto, string TipoFactor, string TasaOCuota)
        {
            List<facturasdetalle> detalles = ViewState["detalles"] as List<facturasdetalle>;
            List<facturasdetalleRT> detallesImpuestos = ViewState["detallesImpuestos"] as List<facturasdetalleRT>;
            string m = ViewState["DecimalMoneda"].ToString();
            int mon = 0;
            if (!string.IsNullOrEmpty(m))
                mon = Convert.ToInt16(m);
            if (ddlMoneda.SelectedValue == "MXN")
                mon = Convert.ToInt16(ddlDecimales.SelectedValue);

            foreach (var x in detalles)
            {
                if (x.Partida.ToString() == Partida)//quitando lo del codigo
                //  if(x.Codigo==ddlConceptos.SelectedValue)
                {
                    //---
                    string BaseConcepto = "";
                    if (x.Partida.ToString() == Partida)
                    {
                        if (x.ConceptoDescuento != null)
                            BaseConcepto = (x.Total - x.ConceptoDescuento).ToString();
                        else
                            BaseConcepto = x.Total.ToString();
                    }
                    //---
                    facturasdetalleRT DRT = new facturasdetalleRT();
                    DRT.Base = Decimal.Round(Convert.ToDecimal(BaseConcepto), 6);
                    // DRT.Importe = Convert.ToDecimal(txtImporte.Text);
                    //----
                    if (TipoFactor != "Exento" || TipoImpuesto != "Traslados") //no se llenan 
                    {
                        DRT.Importe = Decimal.Round(Convert.ToDecimal(BaseConcepto) * Convert.ToDecimal(TasaOCuota), mon);
                        DRT.TasaOCuota = TasaOCuota;
                        /*if (ddlTasaOCuota.Visible == true)
                            DRT.Importe = Decimal.Round(Convert.ToDecimal(txtBase.Text) * Convert.ToDecimal(ddlTasaOCuota.SelectedValue), mon);
                        if (txtTasa.Visible == true)
                            DRT.Importe = Decimal.Round(Convert.ToDecimal(txtBase.Text) * Convert.ToDecimal(txtTasa.Text), mon);

                        if (txtTasa.Visible == true)
                            DRT.TasaOCuota = numerodecimales(Convert.ToDecimal(txtTasa.Text), 6);
                        if (ddlTasaOCuota.Visible == true)
                            DRT.TasaOCuota = ddlTasaOCuota.SelectedValue;*/
                    }
                    //--------------------
                    DRT.Impuesto = Impuesto;

                    DRT.TipoFactor = TipoFactor;
                    DRT.TipoImpuesto = TipoImpuesto;
                    DRT.ConceptoClaveProdServ = Partida;
                    if (TipoImpuesto == "Retenciones")
                    {
                        if (x.ConceptoRetenciones == null)
                            x.ConceptoRetenciones = new List<ServicioLocalContract.Entities.facturasdetalleRetencion>();
                        ServicioLocalContract.Entities.facturasdetalleRetencion retencion = new ServicioLocalContract.Entities.facturasdetalleRetencion();
                        retencion.Base = Decimal.Round(Convert.ToDecimal(BaseConcepto), 6);
                        /*if (ddlTasaOCuota.Visible == true)
                            retencion.Importe = Decimal.Round(Convert.ToDecimal(txtBase.Text) * Convert.ToDecimal(ddlTasaOCuota.SelectedValue), mon);
                        if (txtTasa.Visible == true)
                            retencion.Importe = Decimal.Round(Convert.ToDecimal(txtBase.Text) * Convert.ToDecimal(txtTasa.Text), mon);*/
                        retencion.Importe = Decimal.Round(Convert.ToDecimal(BaseConcepto) * Convert.ToDecimal(TasaOCuota), mon);
                        //retencion.Importe =Convert.ToDecimal(txtImporte.Text);
                        retencion.Impuesto = Impuesto;
                        /*if (txtTasa.Visible == true)
                            retencion.TasaOCuota = numerodecimales(Convert.ToDecimal(txtTasa.Text), 6);
                        if (ddlTasaOCuota.Visible == true)
                            retencion.TasaOCuota = ddlTasaOCuota.SelectedValue;*/
                        retencion.TasaOCuota = TasaOCuota;

                        retencion.TipoFactor = TipoFactor;
                        x.ConceptoRetenciones.Add(retencion);
                    }
                    if (TipoImpuesto == "Traslados")
                    {
                        if (x.ConceptoTraslados == null)
                            x.ConceptoTraslados = new List<ServicioLocalContract.Entities.facturasdetalleTraslado>();
                        ServicioLocalContract.Entities.facturasdetalleTraslado traslados = new ServicioLocalContract.Entities.facturasdetalleTraslado();
                        traslados.Base = Decimal.Round(Convert.ToDecimal(BaseConcepto), 6);
                        // traslados.Importe = Convert.ToDecimal(txtImporte.Text);
                        if (TipoFactor != "Exento")
                        {
                            /*if (ddlTasaOCuota.Visible == true)
                                traslados.Importe = Decimal.Round(Convert.ToDecimal(txtBase.Text) * Convert.ToDecimal(ddlTasaOCuota.SelectedValue), mon);
                            if (txtTasa.Visible == true)
                                traslados.Importe = Decimal.Round(Convert.ToDecimal(txtBase.Text) * Convert.ToDecimal(txtTasa.Text), mon);

                            if (txtTasa.Visible == true)
                                traslados.TasaOCuota = numerodecimales(Convert.ToDecimal(txtTasa.Text), 6);
                            if (ddlTasaOCuota.Visible == true)
                                traslados.TasaOCuota = ddlTasaOCuota.SelectedValue;*/
                            traslados.Importe = Decimal.Round(Convert.ToDecimal(BaseConcepto) * Convert.ToDecimal(TasaOCuota), mon);
                            traslados.TasaOCuota = TasaOCuota;
                        }

                        traslados.Impuesto = Impuesto;
                        traslados.TipoFactor = TipoFactor;
                        x.ConceptoTraslados.Add(traslados);
                    }
                    detallesImpuestos.Add(DRT);
                }


            }
            ViewState["detalles"] = detalles;

            ViewState["detallesImpuestos"] = detallesImpuestos;

            // this.gvImpuestos.DataSource = detallesImpuestos;
            // this.gvImpuestos.DataBind();

            BindDetallesImpuestosToGridView();
            this.UpdateTotales();
            //     txtBase.Text = "";
            //     txtTasa.Text = "";
        }

        protected void cbImp_CheckedChanged(object sender, EventArgs e)
        {
            if (cbIVA.Checked == true)
            {
                ddlIVA.Enabled = true;
            }
            else
            {
                ddlIVA.Enabled = false;
            }
        }

        protected void cbRIVA_CheckedChanged(object sender, EventArgs e)
        {
            if (cbRIVA.Checked == true)
            {
                ddlRIVA.Enabled = true;
            }
            else
            {
                ddlRIVA.Enabled = false;
            }
        }

        protected void ActImpuestos()
        {
            DivComplementos.Visible = true;
            //---------------------------llenado de datos
            var clienteServicio = NtLinkClientFactory.Cliente();
            List<CatalogosSAT.c_TasaOCuota> L;
            bool rango = false;
            using (clienteServicio as IDisposable)
            {
                L = clienteServicio.Consultar_TasaCuota(ddlImpuesto.SelectedValue, ddlTipoFactor.SelectedValue, ddlTipoImpuesto.SelectedValue, ref rango);
            }

            if (rango == true)
            {
                txtTasa.Text = "";
                txtTasa.Enabled = true;
                txtTasa.Visible = true;
                ddlTasaOCuota.Enabled = false;
                ddlTasaOCuota.Visible = false;

            }
            else
            {
                this.ddlTasaOCuota.Visible = true;
                this.ddlTasaOCuota.Enabled = true;
                this.ddlTasaOCuota.DataSource = L;
                this.ddlTasaOCuota.DataBind();
                txtTasa.Enabled = false;
                txtTasa.Visible = false;
            }
            //----------------
            ddlConceptos.Items.Clear();

            //----------------
            List<facturasdetalle> detalles = ViewState["detalles"] as List<facturasdetalle>;

            foreach (var x in detalles)
            {
                ddlConceptos.Items.Add(x.Partida.ToString());
                if (x.Partida.ToString() == ddlConceptos.SelectedValue)
                {
                    if (x.ConceptoDescuento != null)
                        txtBase.Text = (x.Total - x.ConceptoDescuento).ToString();
                    else
                        txtBase.Text = x.Total.ToString();
                }

            }
        }

        protected void Filtro_ClaveUnidad()
        {
            var cliente = NtLinkClientFactory.Cliente();
            List<CatalogosSAT.c_ClaveUnidad> cu = cliente.ConsultarClaveUnidadAll();
            cu = cliente.ConsultarClaveUnidadAll().Select(
                    p =>
                    new CatalogosSAT.c_ClaveUnidad()
                    {
                        Nombre = p.Nombre + " - " + p.c_ClaveUnidad1,
                        c_ClaveUnidad1 = p.c_ClaveUnidad1,
                        Descripcion = p.Nombre

                    }).ToList();

            ddlClaveUnidad.DataSource = cu.Where(p => p.Descripcion == "Pieza" || p.Descripcion == "Unidad de servicio" || p.Descripcion == "Kilogramo"
                                        || p.Descripcion == "Gramo" || p.Descripcion == "Metro" || p.Descripcion == "Metro cuadrado" || p.Descripcion == "Metro cúbico" ||
                                        p.Descripcion == "Pulgada" || p.Descripcion == "Litro" || p.Descripcion == "Lote" || p.Descripcion == "Actividad");
            ListItem l = new ListItem("---Otro---", "0", true);
            ddlClaveUnidad.DataTextField = "Nombre";
            ddlClaveUnidad.DataValueField = "c_ClaveUnidad1";
            ddlClaveUnidad.DataBind();
            this.ddlClaveUnidad.Items.Add(l);
            ddlClaveUnidad.SelectedValue = "H87";

        }
        //---------------------------------------------------
        protected bool Existe_Impuesto()
        {
            string TasaoCuota = "";
            if (txtTasa.Visible == true)
                TasaoCuota = Decimal.Round(Convert.ToDecimal(txtTasa.Text), 6).ToString();
            if (ddlTasaOCuota.Visible == true)
                TasaoCuota = Decimal.Round(Convert.ToDecimal(ddlTasaOCuota.Text), 6).ToString();

            string imp = "";
            if (ddlImpuesto.SelectedValue == "001")
                imp = "ISR";
            if (ddlImpuesto.SelectedValue == "002")
                imp = "IVA";
            if (ddlImpuesto.SelectedValue == "003")
                imp = "IEPS";
            int cont = 0;
            List<facturasdetalleRT> detallesImpuestos = ViewState["detallesImpuestos"] as List<facturasdetalleRT>;
            foreach (var x in detallesImpuestos)
            {
                if (x.Base == Convert.ToDecimal(txtBase.Text) && x.Impuesto == imp && x.TipoFactor == ddlTipoFactor.SelectedValue
                    && Convert.ToDouble(x.TasaOCuota) == Convert.ToDouble(TasaoCuota) && x.TipoImpuesto == ddlTipoImpuesto.SelectedValue
                    && x.ConceptoClaveProdServ == ddlConceptos.SelectedValue)
                {
                    cont++;
                }
            }
            if (cont > 0)
                return true;
            else
                return false;
        }
        //------------------------------------------------------------------------------
        protected void Fecha_Sello(int idEmp)
        {
            try
            {
                bool bloq = false;
                ViewState["Bloq"] = bloq;
                string idEmpresaString = idEmp.ToString();
                int idEmpresa;
                if (!string.IsNullOrEmpty(idEmpresaString) && int.TryParse(idEmpresaString, out idEmpresa))
                {
                    empresa empresa;
                    var clienteServicio = NtLinkClientFactory.Cliente();
                    empresa = clienteServicio.ObtenerEmpresaById(idEmpresa);
                    var sistema = clienteServicio.ObtenerSistemaById((int)empresa.idSistema.Value);
                    string FechaVenceString = empresa.VencimientoCert;
                    //string FechaVenceString = "20/04/2018 12:25:53 p.m.";
                    lblVencimiento.ForeColor = System.Drawing.Color.Blue;//-------->
                    this.lblVencimiento.Text = "Su CSD caduca el dia: " + FechaVenceString;
                    Int32[] FechaVenceInt = new Int32[6];
                    FechaVenceInt[0] = Convert.ToInt32(FechaVenceString.Substring(6, 4));
                    FechaVenceInt[1] = Convert.ToInt32(FechaVenceString.Substring(3, 2));
                    FechaVenceInt[2] = Convert.ToInt32(FechaVenceString.Substring(0, 2));
                    FechaVenceInt[3] = Convert.ToInt32(FechaVenceString.Substring(11, 2));
                    FechaVenceInt[4] = Convert.ToInt32(FechaVenceString.Substring(17, 2));
                    FechaVenceInt[5] = Convert.ToInt32(FechaVenceString.Substring(17, 2));

                    if (FechaVenceString.Substring(20, 1) == "p")
                    {
                        if (FechaVenceInt[3] != 12)
                            FechaVenceInt[3] += 12;
                    }
                    else if (FechaVenceString.Substring(20, 1) == "a" && FechaVenceInt[3] == 12)
                    {
                        FechaVenceInt[3] = 0;
                    }
                    DateTime FechaVence = new DateTime(FechaVenceInt[0], FechaVenceInt[1], FechaVenceInt[2],
                        FechaVenceInt[3], FechaVenceInt[4], FechaVenceInt[5]);
                    TimeSpan c = FechaVence - DateTime.Now;
                    //TimeSpan c = FechaVence - DateTime.Parse("30/04/2017 01:24:53 p. m.");
                    if (c <= TimeSpan.Parse("15.00:00:00.0"))
                    {
                        lblVencimiento.ForeColor = System.Drawing.Color.Red;//-------->
                        bloq = true;
                        ViewState["Bloq"] = bloq;
                        //LblDiasSello.Text = "*Su CSD ha Caducado*. Favor de tramitar un sello nuevo en el SAT para poder continuar con la factura.";
                        LblDiasSello.Text = "*El CSD para <b>'" + empresa.RFC + "'</b> ha Caducado*. Favor de tramitar un sello nuevo en el SAT para poder continuar con la factura.";
                        if (c > TimeSpan.Parse("00.00:00:00.0"))
                        {
                            bloq = false;
                            ViewState["Bloq"] = bloq;
                            //LblDiasSello.Text = "*Su CSD caduca en:";
                            LblDiasSello.Text = "*El CSD para <b>'" + empresa.RFC + "'</b> caduca en:";
                            string dias = (c).ToString("dd");
                            if (dias != "00")
                                LblDiasSello.Text += " " + dias + " Dias";
                            string horas = (c).ToString("hh");
                            if (horas != "00")
                            {
                                if (dias != "00")
                                    LblDiasSello.Text += ",";
                                LblDiasSello.Text += " " + horas + " Horas";
                            }
                            string min = (c).ToString("mm");
                            if (min != "00")
                            {
                                if (dias != "00" || horas != "00")
                                    LblDiasSello.Text += ",";
                                LblDiasSello.Text += " " + min + " Minutos";
                            }
                            LblDiasSello.Text += ".";

                            //LblDiasSello.Text = "¡Importante! *Su CSD caduca en: "+ dias + " Dias, " + horas + " Horas y "+ min +" Minutos.";
                        }
                        if (ddlEmpresa.Items.Count > 1 && bloq)
                        {
                            ddlEmpresaE.Visible = true;
                            lblpop.Visible = true;
                        }
                        else
                        {
                            ddlEmpresaE.Visible = false;
                            lblpop.Visible = false;
                        }
                        this.mpeSellos.Show();
                    }
                }
            }
            catch (Exception ex)
            {
            }
        }
        protected void btclose_Click(object sender, EventArgs e)
        {
            //if (LblDiasSello.Text == "*Su CSD ha Caducado*. Favor de tramitar un sello nuevo en el SAT para poder continuar con la factura.")
            if (Convert.ToBoolean(ViewState["Bloq"]))
            {
                if (ddlEmpresa.Items.Count > 1 && ddlEmpresaE.SelectedValue != ddlEmpresa.SelectedValue)
                {
                    ActEmpresa();
                    ddlEmpresaE.SelectedIndex = 0;
                }
                else
                    Response.Redirect("Default.aspx");
            }
            else
                mpeSellos.Hide();
        }
        protected void ActEmpresa()
        {
            lblVencimiento.Text = "";
            ddlEmpresa.SelectedValue = ddlEmpresaE.SelectedValue;
            //ddlEmpresa_SelectedIndexChanged(null,null);
            int idEmpresaE;
            #region actempresa
            var cliente = NtLinkClientFactory.Cliente();
            using (cliente as IDisposable)
            {
                int idEmpresa = idEmpresaE = int.Parse(this.ddlEmpresa.SelectedValue);
                if (!cliente.TieneConfiguradoCertificado(idEmpresa))
                {
                    this.lblError.Text = "Tienes que configurar tus certificados antes de poder facturar";
                    this.btnGenerarFactura.Enabled = this.BtnVistaPrevia.Enabled =
                        this.btnAgregar.Enabled = this.ddlMoneda.Enabled = false;
                    this.ddlClientes.DataSource = cliente.ListaClientes(Session["perfil"] as string, idEmpresa, string.Empty, false);
                    this.ddlClientes.DataBind();
                    return;
                }
                var emp = cliente.ObtenerEmpresaById(idEmpresa);
                //divViasConcesionadas.Visible = emp.RFC == "VCN940426PJ4";
                lblMensaje.Text = "";
                lblMensajeHistorico.Text = "";

                lblError.Text = "";
                this.ddlSucursales.DataSource = cliente.ListaSucursales(idEmpresa);
                ddlSucursales.DataValueField = "LugarExpedicion";
                ddlSucursales.DataTextField = "Nombre";
                ddlSucursales.DataBind();
                this.btnGenerarFactura.Enabled = this.BtnVistaPrevia.Enabled =
                        this.btnAgregar.Enabled = this.ddlMoneda.Enabled = true;
                this.txtFolio.Text = cliente.SiguienteFolioFactura(idEmpresa);
                this.txtFolioSat.Text = txtFolio.Text;

                this.ddlClientes.DataSource = cliente.ListaClientes(Session["perfil"] as string, idEmpresa, string.Empty, false);
                this.ddlClientes.DataBind();

                ddlClientes_SelectedIndexChanged(null, null);
                ViewState["detalles"] = new List<facturasdetalle>();
                ViewState["iva"] = 0M;
                ViewState["total"] = 0M;
                ViewState["subtotal"] = 0M;

                this.BindDetallesToGridView();
                this.UpdateTotales();

            }
            #endregion
            mpeSellos.Hide();
            this.up1.Update();
            Fecha_Sello(idEmpresaE);
        }
        //------------------------------------------------------------------------------

            //--------------DESCUENTO-----------------------------------------
        protected void descuento_CheckedChanged(object sender, EventArgs e)
        {
            if (descuento.Enabled == true)
            {

                txtdsc.Enabled = true;
            }
            else
            {

                txtdsc.Enabled = false;
            }
        }

        protected void txtdsc_TextChanged(object sender, EventArgs e)
        {
            double result = ((double.Parse(txtdsc.Text) / 100));

            double descuento = (double.Parse(txtPrecio.Text)) * result;


            txtDescuento.Text = descuento.ToString();


        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {

            mpeCFDIG.Hide();

            string uudi = Session["UUDINuevo"].ToString();
            var cliente = NtLinkClientFactory.Cliente();
            using (cliente as IDisposable)
            {
                Response.AddHeader("Content-Disposition", "attachment; filename=" + "_" + uudi + ".pdf");
                this.Response.ContentType = "application/pdf";
                var pdf = cliente.FacturaPdf(uudi);
                if (pdf == null)
                {
                    this.lblError.Text = "Archivo no encontrado";
                    return;
                }
                this.Response.BinaryWrite(pdf);
                this.Response.End();
                Session["UUDINuevo"] = "";
            }
        }

        protected void ddlDecimales_SelectedIndexChanged(object sender, EventArgs e)
        {
            string dec = ViewState["DecimalActual"] as string;
            if ((ViewState["detalles"] as List<facturasdetalle>).Count == 0 && ddlMoneda.SelectedValue == "MXN")
            {
                string z = ddlDecimales.SelectedValue;
                ViewState["DecimalActual"] = z;
            }
            else
            {
                ddlDecimales.SelectedValue = dec;
            }

        }

    }
}