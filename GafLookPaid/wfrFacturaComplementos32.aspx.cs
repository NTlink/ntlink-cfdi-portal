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

namespace GafLookPaid
{
    public partial class wfrFacturaComplementos32 : Page
    {
        protected void fechaPago_ServerValidate(object sender, ServerValidateEventArgs e)
        {
            if (txtFechaPago.Visible && !string.IsNullOrEmpty(txtFechaPago.Text))
            {
                var fecha = DateTime.ParseExact(txtFechaPago.Text, "dd/MM/yyyy", new CultureInfo("es-MX"));
                if (fecha > DateTime.Now)
                {
                    e.IsValid = false;
                    return;
                }
                if (fecha.Year != DateTime.Now.Year)
                {
                    e.IsValid = false;
                    return;
                }
                e.IsValid = true;
                return;
            }
            e.IsValid = false;

        }

        protected void Page_Load(object sender, EventArgs e)
        {
            ImpuestosLocales.UpdateTotales = this.UpdateTotales;

            if (!this.IsPostBack)
            {
                try
                {
                    ActivarInformacionAduanera();
                    ImpuestosLocales.Visible = false;

                    var perfil = Session["perfil"] as string;
                    var sistema = Session["idSistema"] as long?;
                    var idEmp = Session["idEmpresa"] as int?;
                    var cliente = NtLinkClientFactory.Cliente();
                    using (cliente as IDisposable)
                    {
                        var empresas = cliente.ListaEmpresas(perfil, idEmp.Value, sistema.Value, null);
                        var listaEmpresas = new List<empresa>(empresas);

                        this.ddlEmpresa.DataSource = listaEmpresas;
                        this.ddlEmpresa.DataBind();

                        int idEmpresa = listaEmpresas.First().IdEmpresa;

                        if (!cliente.TieneConfiguradoCertificado(idEmpresa))
                        {
                            this.lblError.Text = "Tienes que configurar tus certificados antes de poder facturar";
                            this.btnGenerarFactura.Enabled = this.BtnVistaPrevia.Enabled = this.btnBuscar.Enabled = 
                                this.btnAgregar.Enabled = this.ddlMoneda.Enabled = false;
                            return;
                        }

                        if (listaEmpresas.Count > 0)
                        {
                            this.ddlClientes.DataSource = cliente.ListaClientes(perfil, idEmpresa, string.Empty, false);
                            this.ddlClientes.DataBind();
                            this.txtFolio.Text = cliente.SiguienteFolioFactura(idEmpresa);
                            ddlClientes_SelectedIndexChanged(null, null);
                        }

                        this.ddlSucursales.DataSource = cliente.ListaSucursales(idEmpresa);
                        ddlSucursales.DataValueField = "LugarExpedicion";
                        ddlSucursales.DataTextField = "Nombre";

                        this.ddlSucursales.DataBind();
                    }

                    ViewState["detalles"] = new List<facturasdetalle>();
                    ViewState["iva"] = 0M;
                    ViewState["total"] = 0M;
                    ViewState["subtotal"] = 0M;

                    this.BindDetallesToGridView();
                    this.UpdateTotales();

                    ActualizarSaldosMaster();
                }
                catch (Exception ex)
                {
                    //Logger.Error(ex.Message);
                }
            }
        }

        //protected void chkIva_CheckedChanged(object sender, EventArgs e)
        //{
        //    //this.txtIva.Enabled = this.chkIva.Checked;
        //    this.UpdateTotales();
        //}

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            this.mpeBuscarConcepto.Show();
            this.gvBuscarConceptos.DataSource = new List<producto>();
            this.gvBuscarConceptos.DataBind();
        }

        protected void btnGenerarFactura_Click(object sender, EventArgs e)
        {
            this.GuardarFactura();
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(this.txtCantidad.Text.Trim()) ||
               string.IsNullOrEmpty(this.txtPrecio.Text.Trim()) ||
               string.IsNullOrEmpty(this.txtDescripcion.Text.Trim()) || 
               string.IsNullOrEmpty(this.txtUnidad.Text.Trim()))
            {
                this.lblError.Text = "* Error de validación en la partida";
                return;
            }
            this.lblError.Text = string.Empty;

            var detalles = ViewState["detalles"] as List<facturasdetalle>;
            var detalle = new facturasdetalle
                              {
                                  Partida = detalles.Count + 1,
                                  Cantidad = decimal.Parse(this.txtCantidad.Text),
                                  Descripcion = this.txtDescripcion.Text,
                                  Codigo = this.txtCodigo.Text,
                                  Unidad = this.txtUnidad.Text,
                                  Precio = decimal.Parse(this.txtPrecio.Text),
                                  Total = decimal.Parse(this.txtPrecio.Text)*decimal.Parse(this.txtCantidad.Text),
                                  idproducto =
                                      string.IsNullOrEmpty(txtIdProducto.Value) ? 0 : int.Parse(txtIdProducto.Value),
                              };

              if(cbIA.Checked==true)//se agrego la informacion de aduana
                            {
                                detalle.IAnumero =  convertirTexto("txtNumeroIA", UCInformacionAduanera1);
                                detalle.IAaduana = convertirTexto("txtAduanaIA", UCInformacionAduanera1); 
                                detalle.IAfecha = convertirTexto("txtFechaIA", UCInformacionAduanera1); 
                            }
                           

            if (cbIva.Checked)
            {
                detalle.PorcentajeIva = int.Parse(txtIvaConcepto.Text);
                detalle.ImporteIva = ((decimal)detalle.PorcentajeIva / 100) * detalle.TotalPartida;
            }

            if (cbRetencionIva.Checked)
            {
                detalle.RetencionIva = ((decimal)Convert.ToDecimal(txtRetencionIva.Text) / 100) * detalle.TotalPartida;
            }
            else
                detalle.RetencionIva = 0.0M;
            if (cbRetIsr.Checked)
            {
                detalle.ISR = ((decimal)Convert.ToDecimal(txtRetIsr.Text) / 100) * detalle.TotalPartida;
            }
            else
                detalle.ISR = 0.0M;

            detalles.Add(detalle);
            ViewState["detalles"] = detalles;
            this.txtIdProducto.Value = null;
            this.Clear();
            this.BindDetallesToGridView();
            this.UpdateTotales();
            
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
                    this.btnGenerarFactura.Enabled = this.BtnVistaPrevia.Enabled = this.btnBuscar.Enabled =
                        this.btnAgregar.Enabled = this.ddlMoneda.Enabled = false;
                    return;
                }
                lblMensaje.Text = "";
                lblError.Text = "";
                this.ddlSucursales.DataSource = cliente.ListaSucursales(idEmpresa);
                ddlSucursales.DataValueField = "LugarExpedicion";
                ddlSucursales.DataTextField = "Nombre";
                ddlSucursales.DataBind();
                this.btnGenerarFactura.Enabled = this.BtnVistaPrevia.Enabled = this.btnBuscar.Enabled =
                        this.btnAgregar.Enabled = this.ddlMoneda.Enabled = true;
                this.txtFolio.Text = cliente.SiguienteFolioFactura(idEmpresa);
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
        }

        protected void btnGenerarPreview_Click(object sender, EventArgs e)
        {
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
            if (this.ddlMoneda.SelectedValue.Equals("2"))
            {
                var t = new Thread(GetTipoCambio);
                t.Start();
                t.Join();
                this.txtTipoCambio.Visible = true;
                this.lblTipoCambio.Visible = true;
            }
            else
            {
                this.txtTipoCambio.Visible = false;
                this.lblTipoCambio.Visible = false;
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
                sb.AppendLine(c.Direccion + " " + c.Colonia);
                sb.AppendLine(c.Ciudad + " " + c.Estado + " " + c.CP);
                this.txtRazonSocial.Text = sb.ToString();
                this.txtCuenta.Text = c.CuentaPago;
                //this.ddlMetodoPago.Text = c.MetodoPago;
            }
        }

        protected void gvDetalles_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("EliminarConcepto"))
            {
                var detalles = ViewState["detalles"] as List<facturasdetalle>;
                detalles.RemoveAt(Convert.ToInt32(e.CommandArgument));
                ViewState["detalles"] = detalles;
                this.BindDetallesToGridView();
                UpdateTotales();
            }
            if (e.CommandName.Equals("Editar"))
            {
                var detalles = ViewState["detalles"] as List<facturasdetalle>;
                var edicion = detalles[Convert.ToInt32(e.CommandArgument)];
                ViewState["detalles"] = detalles;
                this.hidNumero.Value = e.CommandArgument.ToString();
                this.hidDetalle.Value = edicion.idproducto.ToString();
                this.txtUnidadEdita.Text = edicion.Unidad;
                this.txtCantidadEdita.Text = edicion.Cantidad.ToString();
                this.txtCodigoEdita.Text = edicion.Codigo;
                this.txtDescripcionEdita.Text = edicion.Descripcion;
                this.txtObservacionesEdita.Text = edicion.Descripcion2;
                this.txtPrecioUnitarioEdita.Text = edicion.Precio.ToString();
                mpeEdita.Show();
            }
        }

        protected void btnBuscarConcepto_Click(object sender, EventArgs e)
        {
            var cliente = NtLinkClientFactory.Cliente();
            var idEmpresa = int.Parse(ddlEmpresa.SelectedValue);
            using (cliente as IDisposable)
            {
                List<producto> lista = cliente.BuscarProducto(this.txtConceptoBusqueda.Text,idEmpresa);
                if(lista.Count > 20)
                {
                    this.lblMensaje.Text = lista.Count + " resultados, mostrando los primeros 20, refina tu busqueda";
                }
                this.gvBuscarConceptos.DataSource = new List<producto>(lista.Take(20).ToList());
                this.gvBuscarConceptos.DataBind();
            }
            this.mpeBuscarConcepto.Show();
        }

        protected void btnSeleccionarConcepto_Click(object sender, EventArgs e)
        {
            if (this.gvBuscarConceptos.Rows.Count > 0)
            {
                var detalles = ViewState["detalles"] as List<facturasdetalle>;
                for (int x = 0; x < this.gvBuscarConceptos.Rows.Count; x++)
                {
                    var chkSeleccion = this.gvBuscarConceptos.Rows[x].FindControl("chkSeleccion") as CheckBox;
                    if(chkSeleccion == null || !chkSeleccion.Checked)
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
                                              idproducto = prod.IdProducto
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
            this.ClearAll();
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

            //*  ya no es obligatorio */
            /*
            if ((this.ddlMetodoPago.SelectedValue == "02" || this.ddlMetodoPago.SelectedValue == "03" || this.ddlMetodoPago.SelectedValue == "04"
              || this.ddlMetodoPago.SelectedValue == "05") && string.IsNullOrEmpty(this.txtCuenta.Text))
            {
                this.lblError.Text = "Falta agregar el #Cuenta o # Tarjeta. ";
                return false;
            }
             */ 
            return true;
        }

        private void GuardarFactura()
        {
            bool error = false;
            if (ValidarFactura())
            {
                var detalles = ViewState["detalles"] as List<facturasdetalle>;
                var iniciales = Session["iniciales"] as string;
                var fact = GetFacturas(iniciales, detalles);
                try
                {
                    var clienteServicio = NtLinkClientFactory.Cliente();
                    using (clienteServicio as IDisposable)
                    {
                        if(!clienteServicio.GuardarFactura(fact, detalles, true, null))
                        {
                            this.lblError.Text = "* Error al generar la factura";
                            return;
                        }
                        //eliminando variable de session
                        Session.Remove("ImpLocalesRGV"); 

                        this.lblError.Text = string.Empty;
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

                    this.lblError.Text = "Comprobante generado correctamente  y enviado por correo electrónico";
                    ActualizarSaldosMaster();
                }
               // this.lblError.Text = string.Empty;
            }
        }

        private facturas GetFacturas(string iniciales, List<facturasdetalle> detalles)
        {
            facturas fact = new facturas();
            fact.TipoDocumento = TipoDocumento.Complementos;
            fact.IdEmpresa = int.Parse(this.ddlEmpresa.SelectedValue);
            fact.Importe = decimal.Parse(this.lblTotal.Text.Replace("$", ""), NumberStyles.Currency);
            fact.IVA = decimal.Parse(this.lblIva.Text.Replace("$", ""), NumberStyles.Currency);
            fact.SubTotal = decimal.Parse(this.lblSubtotal.Text.Replace("$", ""), NumberStyles.Currency);
            fact.Total = decimal.Parse(this.lblTotal.Text.Replace("$", ""), NumberStyles.Currency);
            fact.PorcentajeIva = 16;
            fact.Moneda = int.Parse(this.ddlMoneda.SelectedValue);
            fact.idcliente = int.Parse(this.ddlClientes.SelectedValue);
            fact.Fecha = DateTime.Now;
            fact.Usuario = iniciales;
            fact.Folio = this.txtFolio.Text.PadLeft(4, '0');
            fact.Serie = string.IsNullOrEmpty(this.txtSerie.Text) ? null : this.txtSerie.Text;
            fact.nProducto = detalles.Count;
            fact.captura = DateTime.Now;
            fact.Cancelado = 0;
            fact.LugarExpedicion = this.ddlSucursales.SelectedValue;
            fact.Proyecto = this.txtProyecto.Text;
            /*
            fact.MetodoID = this.ddlMetodoPago.SelectedValue != "99" ? this.ddlMetodoPago.SelectedValue : "99";
            fact.Metodo = this.ddlMetodoPago.SelectedValue != "99" ? this.ddlMetodoPago.SelectedItem.Text : txtMetodoPago.Text;
              */
             fact.MetodoID=this.txtMetodoPagoMulID.Text;
             fact.Metodo = this.txtMetodoPagoMul.Text;
             
            fact.MonedaS = this.ddlMoneda.SelectedItem.Text;
            fact.Cuenta = string.IsNullOrEmpty(this.txtCuenta.Text) ? null : this.txtCuenta.Text;
            fact.FormaPago = ddlCondicionesPago.SelectedValue;
            fact.CondicionesPado = this.txtCondicionesPago.Text;
            /*var fact = new facturas
                           {
                               TipoDocumento = TipoDocumento.Complementos,
                               IdEmpresa = int.Parse(this.ddlEmpresa.SelectedValue),
                               Importe = decimal.Parse(this.lblTotal.Text.Replace("$", ""), NumberStyles.Currency),
                               IVA = decimal.Parse(this.lblIva.Text.Replace("$", ""), NumberStyles.Currency),
                               SubTotal = decimal.Parse(this.lblSubtotal.Text.Replace("$", ""), NumberStyles.Currency),
                               Total = decimal.Parse(this.lblTotal.Text.Replace("$", ""), NumberStyles.Currency),
                               PorcentajeIva = 16,
                               Moneda = int.Parse(this.ddlMoneda.SelectedValue),
                               idcliente = int.Parse(this.ddlClientes.SelectedValue),
                               Fecha = DateTime.Now,
                               Usuario = iniciales,
                               Folio = this.txtFolio.Text.PadLeft(4, '0'),
                               Serie = string.IsNullOrEmpty(this.txtSerie.Text) ? null : this.txtSerie.Text,
                               nProducto = detalles.Count,
                               captura = DateTime.Now,
                               Cancelado = 0,
                               LugarExpedicion = this.ddlSucursales.SelectedValue,
                               Proyecto = this.txtProyecto.Text,
                               Metodo =
                                   this.ddlMetodoPago.SelectedValue != "Mixto"
                                       ? this.ddlMetodoPago.SelectedValue
                                       : txtMetodoPago.Text,
                               MonedaS = this.ddlMoneda.SelectedItem.Text,
                               Cuenta = string.IsNullOrEmpty(this.txtCuenta.Text) ? null : this.txtCuenta.Text,
                               FormaPago = ddlCondicionesPago.SelectedValue
                           };

            */
            if (ddlTipoDocumento.SelectedValue == "Egreso")//para ingreso o egreso
                fact.NotaCredito = true;
            

            fact.Fecha = DateTime.Now;

           string RIva= this.lblRetencionIva.Text.Replace("$", "");
           if (Convert.ToDecimal(RIva) > 0)
            {
            //    var porcentajeIva = decimal.Parse(txtRetencionIva.Text);
            //    fact.RetencionIva = (porcentajeIva / 100) * fact.SubTotal.Value;
                fact.RetencionIva = Convert.ToDecimal(RIva);
            }
            string ISRTexto= this.lblRetencionIsr.Text.Replace("$", "");
            if (Convert.ToDecimal(ISRTexto) > 0)
            {
            //    var porcentajeIsr = decimal.Parse(txtRetIsr.Text);
            //    fact.RetencionIsr = (porcentajeIsr/100)*fact.SubTotal.Value;
            //    fact.RetencionIsr = Decimal.Round(fact.RetencionIsr, 2);// se agrego para redondear el ISR por RGV
                fact.RetencionIsr = Convert.ToDecimal(ISRTexto);
            }
            fact.Leyenda = lblLeyenda.Text;
            if (ddlStatusFactura.SelectedValue == "1" && !string.IsNullOrEmpty(txtFechaPago.Text))
            {
                fact.FechaPago = DateTime.ParseExact(txtFechaPago.Text, "dd/MM/yyyy", new CultureInfo("es-MX"));
                fact.ReferenciaPago = txtCuenta.Text;
            }

            fact.Vencimiento = string.IsNullOrEmpty(this.txtDiasRevision.Text)
                                   ? fact.Fecha
                                   : fact.Fecha.AddDays(int.Parse(this.txtDiasRevision.Text));

             var imp = Session["ImpLocalesRGV"] as ImpLocales;
             fact.ImpuestosLocales = imp;

            return fact;
        }

        private byte[] Preview()
        {
            bool error = false;
            var detalles = ViewState["detalles"] as List<facturasdetalle>;
            var iniciales = Session["iniciales"] as string;
            var fact = GetFacturas(iniciales, detalles);
            try
            {
                var clienteServicio = NtLinkClientFactory.Cliente();
                using (clienteServicio as IDisposable)
                {
                    var pdf = clienteServicio.FacturaPreview(fact, detalles, null);
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
            this.lblError.Text = string.Empty;
            return null;
        }

        private void Clear()
        {
            this.txtCodigo.Text = this.txtDescripcion.Text = this.txtPrecio.Text = 
                this.txtCantidad.Text = this.txtUnidad.Text = string.Empty;

            if (cbIA.Checked == true)
            {
                convertirTextoLimpiar("txtNumeroIA", UCInformacionAduanera1);
                convertirTextoLimpiar("txtAduanaIA", UCInformacionAduanera1);
                convertirTextoLimpiar("txtFechaIA", UCInformacionAduanera1);
            }
        }

        private void ClearAll()
        {
            this.Clear();

            this.txtProyecto.Text = this.txtFolioOriginal.Text = this.txtFechaOriginal.Text = this.txtMontoOriginal.Text =
                //this.txtMetodoPago.Text =
                this.txtCuenta.Text = txtProyecto.Text =
                this.txtSerie.Text = this.txtDiasRevision.Text = string.Empty;
            this.ddlStatusFactura.SelectedIndex = 0;
            this.txtFechaPago.Text = "";
            this.txtFechaPago.Visible = false;
            this.lblIva.Text = 0M.ToString("C");
            this.lblSubtotal.Text = 0M.ToString("C");
            this.lblTotal.Text = 0M.ToString("C");
            this.lblRetencionIva.Text = 0M.ToString("C");
            this.lblRetencionIsr.Text = 0M.ToString("C");
            this.lblLeyenda.Text = "";
           // this.ddlMetodoPago.SelectedIndex = 0;
           // this.ddlMetodoPago_SelectedIndexChanged(null, null);

            var detalles = new List<facturasdetalle>();
            ViewState["detalles"] = detalles;
            this.BindDetallesToGridView();
            var cliente = NtLinkClientFactory.Cliente();
            using (cliente as IDisposable)
            {
                int idEmpresa = int.Parse(this.ddlEmpresa.SelectedValue);
                this.txtFolio.Text = cliente.SiguienteFolioFactura(idEmpresa);
            }

            txtMetodoPagoMul.Text = "";
            txtMetodoPagoMulID.Text = "";
            CheckNA.Checked = false;
            Check01.Checked = false;
            Check02.Checked = false;
            Check03.Checked = false;
            Check04.Checked = false;
            Check05.Checked = false;
            Check06.Checked = false;
            Check08.Checked = false;
            Check28.Checked = false;
            Check29.Checked = false;
            Check99.Checked = false;
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
            //-----------------------para la informacion aduanera
            var has = conceptos.Where(p => p.IAnumero != "" && p.IAnumero!=null);

            if (has.Count() == 0)
            {
                int noColumns = this.gvDetalles.Columns.Count;
                this.gvDetalles.Columns[noColumns - 4].Visible = this.gvDetalles.Columns[noColumns - 5].Visible = this.gvDetalles.Columns[noColumns - 6].Visible = false;

            }
            else
            {
                int noColumns = this.gvDetalles.Columns.Count;
                this.gvDetalles.Columns[noColumns - 4].Visible = this.gvDetalles.Columns[noColumns - 5].Visible = this.gvDetalles.Columns[noColumns - 6].Visible = true;

            }//----------------------------------------

            this.gvDetalles.DataSource = ViewState["detalles"];
            this.gvDetalles.DataBind();
        }

        private void UpdateTotales()
        {
            var detalles = ViewState["detalles"] as List<facturasdetalle>;
            if (detalles == null)
                return;
            var iva = 0M;
            var subtotal = 0M;
            var retencionesIva = 0M;
            var retencionesIsr = 0M;
            var conIva = 0M;
            var cliente = NtLinkClientFactory.Cliente();
            int idEmpresa = int.Parse(this.ddlEmpresa.SelectedValue);
            var emp = cliente.ObtenerEmpresaById(idEmpresa);
            foreach (facturasdetalle detalle in detalles)
            {
                subtotal += detalle.TotalPartida;
                if (detalle.PorcentajeIva.HasValue)
                {
                    iva += detalle.ImporteIva.Value;
                    conIva += detalle.TotalPartida;
                }
                
            }
            CultureInfo cul = CultureInfo.CreateSpecificCulture("es-MX");
           
            //-----------------------------------------------------------
           // if (cbRetencionIva.Checked)
            {
              //  var porcentajeIva = decimal.Parse(txtRetencionIva.Text);
              //  retencionesIva = (porcentajeIva / 100) * subtotal;
                decimal?  RI=0M;
                foreach (facturasdetalle detalle in detalles)
                {
                  RI += detalle.RetencionIva;
                 
                }
                retencionesIva = Convert.ToDecimal(RI);
                this.lblRetencionIva.Text = retencionesIva.ToString("C", cul);
                

            }
            //-----------------------------------------------
           // if (cbRetIsr.Checked)
            {
               // var porcentajeIsr = decimal.Parse(txtRetIsr.Text);
                //retencionesIsr = (porcentajeIsr / 100) * subtotal;
                decimal? ISR = 0M;
                foreach (facturasdetalle detalle in detalles)
                {
                    ISR += detalle.ISR;

                }
                retencionesIsr = Convert.ToDecimal(ISR);

                this.lblRetencionIsr.Text = retencionesIsr.ToString("C", cul);
                
            }
            //--------------------------------------------------
            var imp = Session["ImpLocalesRGV"] as ImpLocales;
             decimal TotalRetenciones=0M;
             decimal TotaldeTraslados = 0M;
             if (imp != null)
             {
                 if (imp.imp.Count > 0)
                 {
                     TotalRetenciones = decimal.Parse(imp.TotaldeRetenciones, NumberStyles.Currency);
                     TotaldeTraslados = decimal.Parse(imp.TotaldeTraslados, NumberStyles.Currency);
                 }
             }
            //--------------------------------------------------------
                this.lblIva.Text = iva.ToString("C", cul);
                this.lblRetencionLocal.Text = TotalRetenciones.ToString("C", cul);
                this.lblTrasladoLocal.Text = TotaldeTraslados.ToString("C", cul);
          /**/      var total = subtotal + iva - retencionesIva - retencionesIsr +TotaldeTraslados -TotalRetenciones;
                this.lblTotal.Text = total.ToString("C", cul);
                this.lblSubtotal.Text = subtotal.ToString("C", cul);
                this.lblLeyenda.Text = "Iva sobre " + conIva.ToString("C", cul) + " " + lblIva.Text;
                
                up1.Update();
        }

        #endregion

        protected void gvBuscarConceptos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int idProducto = Convert.ToInt32(this.gvBuscarConceptos.DataKeys[Convert.ToInt32(e.CommandArgument)].Value);
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
            this.mpeBuscarConcepto.Hide();
        }

        protected void ddlStatusFactura_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlStatusFactura.SelectedValue == "1")
            {
                this.lblFechaPago.Visible = true;
                this.txtFechaPago.Text = DateTime.Now.ToString("dd/MM/yyyy");
                this.txtFechaPago.Visible = true;
            }
            else
            {
                this.lblFechaPago.Visible = false;
                this.txtFechaPago.Text = DateTime.Now.ToString("dd/MM/yyyy");
                this.txtFechaPago.Visible = false;
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            var detalles = ViewState["detalles"] as List<facturasdetalle>;
            var edicion = detalles[Convert.ToInt32(this.hidNumero.Value)];
            
            edicion.idproducto = int.Parse(this.hidDetalle.Value);
            edicion.Unidad = this.txtUnidadEdita.Text;
            edicion.Cantidad = Decimal.Parse(this.txtCantidadEdita.Text);
            edicion.Codigo = this.txtCodigoEdita.Text;
            edicion.Descripcion = this.txtDescripcionEdita.Text; 
             edicion.Descripcion2 = this.txtObservacionesEdita.Text;
            edicion.Precio = decimal.Parse(this.txtPrecioUnitarioEdita.Text);
            if (edicion.PorcentajeIva != null)
            edicion.ImporteIva = ((decimal)edicion.PorcentajeIva / 100) * edicion.TotalPartida;
            ViewState["detalles"] = detalles;
            this.BindDetallesToGridView();
            this.UpdateTotales();
        }

        protected void txtDerechoPeaje_TextChanged(object sender, EventArgs e)
        {
            //// Calular los derechos de paje.
            //if (!string.IsNullOrEmpty(this.txtDerechoPeaje.Text) && !string.IsNullOrEmpty(this.txtIvaPeajes.Text))
            //{
            //    decimal totalPeaje = decimal.Parse(this.txtDerechoPeaje.Text);
            //    decimal ivaPeaje = decimal.Parse(this.txtIvaPeajes.Text);

            //    this.lblTotalPeaje.Text = (totalPeaje*(ivaPeaje/100)).ToString("C");
            //}
            //// Calcular entrega y recoleccion.

            //if (!string.IsNullOrEmpty(this.txtRecolecion.Text) && !string.IsNullOrEmpty(this.txtIvaRecolecion.Text))
            //{
            //    decimal totalRecoleccion = decimal.Parse(this.txtRecolecion.Text);
            //    decimal ivaRecoleccion = decimal.Parse(this.txtIvaRecolecion.Text);
            //    decimal retencionRecoleccion = decimal.Parse(this.txtRetencion.Text);
            //    decimal totalRetencion = totalRecoleccion*(retencionRecoleccion/100);

            //    this.lblTotalRecolecion.Text = ((totalRecoleccion * (ivaRecoleccion / 100)) - totalRetencion).ToString("C");
            //}
        }
        /*
        protected void ddlMetodoPago_SelectedIndexChanged(object sender, EventArgs e)
        {

            if (ddlMetodoPago.SelectedValue == "99")
            {
                txtMetodoPago.Visible = true;
                lblMetodoPago.Text = "Escriba el método de pago";
                lblMetodoPago.Visible = true;

            }
            else
            {
                txtMetodoPago.Visible = false;
                lblMetodoPago.Visible = false;
            }
        }

        */

        protected void ddlCondicionesPago_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlCondicionesPago.SelectedValue == "En parcialidades")
            {
                divParcialidades.Visible = true;
            }
            else
            {
                divParcialidades.Visible = false;

            }
        }

        protected void cbRetencionIva_CheckedChanged(object sender, EventArgs e)
        {
            if (cbRetencionIva.Checked)
                this.txtRetencionIva.Text = "10.66";
            else
                this.txtRetencionIva.Text = "0.00";
        }

        protected void cbRetIsr_CheckedChanged(object sender, EventArgs e)
        {
            if (this.cbRetIsr.Checked)
                this.txtRetIsr.Text = "10";
            else
            {
                this.txtRetIsr.Text = "0.00";
            }
        }

        protected void ckeckboxlist1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ckeckboxlist1.Items[0].Selected == true) ImpuestosLocales.Visible = true; else ImpuestosLocales.Visible = false; 
      
        }

        protected void cbIA_CheckedChanged(object sender, EventArgs e)
        {
            ActivarInformacionAduanera();

            //------------------------------------------
        }

        protected void ActivarInformacionAduanera()
        {

            //--------------------------------------------
            if (cbIA.Checked == true)
            {
                UCInformacionAduanera1.Visible = true;
               
            }
            else
            {
                UCInformacionAduanera1.Visible = false;
            }
        }
        private string convertirTexto(string nombre, Control c)
        {
            TextBox t = (TextBox)c.FindControl(nombre);
            return t.Text;
        }
        private void convertirTextoLimpiar(string nombre, Control c)
        {
            TextBox t = (TextBox)c.FindControl(nombre);
            t.Text = "";
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

        protected void Check01_CheckedChanged(object sender, EventArgs e)
        {

            if (Check01.Checked == true)//01
                agregarListaMetodoPago(Check01.Text, true);
            else
                agregarListaMetodoPago(Check01.Text, false);
        }

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

        protected void Check02_CheckedChanged(object sender, EventArgs e)
        {
            if (Check02.Checked == true)//
                agregarListaMetodoPago(Check02.Text, true);
            else
                agregarListaMetodoPago(Check02.Text, false);

        }


        protected void Check04_CheckedChanged(object sender, EventArgs e)
        {
            if (Check04.Checked == true)//
                agregarListaMetodoPago(Check04.Text, true);
            else
                agregarListaMetodoPago(Check04.Text, false);

        }

        protected void Check05_CheckedChanged(object sender, EventArgs e)
        {
            if (Check05.Checked == true)//
                agregarListaMetodoPago(Check05.Text, true);
            else
                agregarListaMetodoPago(Check05.Text, false);

        }

        protected void Check06_CheckedChanged(object sender, EventArgs e)
        {
            if (Check06.Checked == true)//
                agregarListaMetodoPago(Check06.Text, true);
            else
                agregarListaMetodoPago(Check06.Text, false);

        }

        protected void Check03_CheckedChanged1(object sender, EventArgs e)
        {
            if (Check03.Checked == true)//
                agregarListaMetodoPago(Check03.Text, true);
            else
                agregarListaMetodoPago(Check03.Text, false);

        }

        protected void Check08_CheckedChanged(object sender, EventArgs e)
        {
            if (Check08.Checked == true)//
                agregarListaMetodoPago(Check08.Text, true);
            else
                agregarListaMetodoPago(Check08.Text, false);

        }

        protected void Check28_CheckedChanged(object sender, EventArgs e)
        {
            if (Check28.Checked == true)//
                agregarListaMetodoPago(Check28.Text, true);
            else
                agregarListaMetodoPago(Check28.Text, false);

        }

        protected void Check29_CheckedChanged(object sender, EventArgs e)
        {
            if (Check29.Checked == true)//
                agregarListaMetodoPago(Check29.Text, true);
            else
                agregarListaMetodoPago(Check29.Text, false);

        }

        protected void CheckNA_CheckedChanged(object sender, EventArgs e)
        {
            if (CheckNA.Checked == true)//
                agregarListaMetodoPago(CheckNA.Text, true);
            else
                agregarListaMetodoPago(CheckNA.Text, false);

        }

        protected void Check99_CheckedChanged(object sender, EventArgs e)
        {
            if (Check99.Checked == true)//
                agregarListaMetodoPago(Check99.Text, true);
            else
                agregarListaMetodoPago(Check99.Text, false);

        }
        //------------------------------------------------------------------------------
       
    }
}