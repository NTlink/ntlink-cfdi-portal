using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ServicioLocalContract;

namespace GafLookPaid
{
    public partial class WfrHomeDepot : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                try
                {
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
                //Select Controls ... for listboxes.
                //RequestforPayment_ListBox_EntityType.SelectedIndex = 0;
                //OrderIdentification_ListBox_Type.SelectedIndex = 0;

                //AdditionalInformation_ListBox_Type.SelectedIndex = 0;
                //BuyerSeller_ListBox_Type.SelectedIndex = 0;
                //Currency_ListBox_ISOCode.SelectedIndex = 0;
                //Currency_ListBox_CurrencyFunction.SelectedIndex = 0;
                ////
                //addendaHomeDeppot_AltTradItemId_DList.SelectedIndex = 0;
                //addendaHomeDeppot_PalletInfo_Description_DList.SelectedIndex = 0;

                //addendaHomeDeppot_Transport_Dlist.SelectedIndex = 0;

            }
        }

        //protected void chkIva_CheckedChanged(object sender, EventArgs e)
        //{
        //    this.txtIva.Enabled = this.chkIva.Checked;
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

            var detalles = ViewState["detalles"] as List<facturasdetalle>;
            var detalle = new facturasdetalle
            {
                Partida = detalles.Count + 1,
                Cantidad = decimal.Parse(this.txtCantidad.Text),
                Descripcion = this.txtDescripcion.Text,
                Codigo = this.txtCodigo.Text,
                Unidad = this.txtUnidad.Text,
                Descripcion2 = this.txtDetalles.Text,
                Precio = decimal.Parse(this.txtPrecio.Text),
                Total = decimal.Parse(this.txtPrecio.Text) * decimal.Parse(this.txtCantidad.Text),
               // Total = Decimal.Round(decimal.Parse(this.txtPrecio.Text) * decimal.Parse(this.txtCantidad.Text), mon),
                idproducto = string.IsNullOrEmpty(txtIdProducto.Value) ? 0 : int.Parse(txtIdProducto.Value),
                CuentaPredial = string.IsNullOrEmpty(this.txtCuentaPredial.Text) ? null : this.txtCuentaPredial.Text
            };

            if (cbIva.Checked)
            {
                detalle.PorcentajeIva = int.Parse(txtIvaConcepto.Text);
                detalle.ImporteIva = ((decimal)detalle.PorcentajeIva / 100) * detalle.TotalPartida;
            }

            //if (cbRetencion.Checked)
            //{
            //    detalle.PorcentajeRetencionIva = int.Parse((txtRetencion.Text));
            //    detalle.RetencionIva = ((decimal)detalle.PorcentajeRetencionIva / 100) * detalle.TotalPartida;
            //}
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
                    this.ddlClientes.DataSource = cliente.ListaClientes(Session["perfil"] as string, idEmpresa, string.Empty, false);
                    this.ddlClientes.DataBind();
                    return;
                }
                var emp = cliente.ObtenerEmpresaById(idEmpresa);
                divViasConcesionadas.Visible = emp.RFC == "VCN940426PJ4";
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

        protected void gvDetalles_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
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
                this.txtCuentaPredialEdita.Text = edicion.CuentaPredial;
                mpeEdita.Show();
            }
        }

        protected void btnBuscarConcepto_Click(object sender, EventArgs e)
        {
            var cliente = NtLinkClientFactory.Cliente();
            var idEmpresa = int.Parse(ddlEmpresa.SelectedValue);
            using (cliente as IDisposable)
            {
                List<producto> lista = cliente.BuscarProducto(this.txtConceptoBusqueda.Text, idEmpresa);
                if (lista.Count > 20)
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
                var fact = GetFactura(iniciales, detalles);
                try
                {
                    var clienteServicio = NtLinkClientFactory.Cliente();
                    int idCliente = int.Parse(this.ddlClientes.SelectedValue);
                    clientes c = clienteServicio.ObtenerClienteById(idCliente);
                    using (clienteServicio as IDisposable)
                    {
                        if (!clienteServicio.GuardarFactura(fact, detalles, true, null))
                        {
                            this.lblError.Text = "* Error al generar la factura";
                            return;
                        }
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

        private facturas GetFactura(string iniciales, List<facturasdetalle> detalles)
        {
            try
            {
                var fact = new facturas
                {
                    TipoDocumento = TipoDocumento.HomeDepot,
                    IdEmpresa = int.Parse(this.ddlEmpresa.SelectedValue),
                    Importe = decimal.Parse(this.lblTotal.Text, NumberStyles.Currency),
                    IVA = decimal.Parse(this.lblIva.Text, NumberStyles.Currency),
                    SubTotal = decimal.Parse(this.lblSubtotal.Text, NumberStyles.Currency),
                    Total = decimal.Parse(this.lblTotal.Text, NumberStyles.Currency),
                    //PorcentajeIva = int.Parse(this.txtIva.Text),
                    PorcentajeIva = 16,
                    Moneda = int.Parse(this.ddlMoneda.SelectedValue),
                    idcliente = int.Parse(this.ddlClientes.SelectedValue),
                    Fecha = DateTime.Now,
                    Folio = this.txtFolio.Text.PadLeft(4, '0'),
                    Serie = string.IsNullOrEmpty(this.txtSerie.Text) ? null : this.txtSerie.Text,
                    nProducto = detalles.Count,
                    captura = DateTime.Now,
                    Cancelado = 0,
                    Usuario = iniciales,
                    LugarExpedicion = this.ddlSucursales.SelectedValue,
                    Proyecto = this.txtProyecto.Text,
                    /*
                    MetodoID = this.ddlMetodoPago.SelectedValue != "99" ? this.ddlMetodoPago.SelectedValue : "99",
                    Metodo = this.ddlMetodoPago.SelectedValue != "99"
                            ? this.ddlMetodoPago.SelectedItem.Text : txtMetodoPago.Text,
                     */
                    MetodoID = this.txtMetodoPagoMulID.Text,
                    Metodo = this.txtMetodoPagoMul.Text,
             
                    MonedaS = this.ddlMoneda.SelectedItem.Text,
                    Cuenta = string.IsNullOrEmpty(this.txtCuenta.Text) ? null : this.txtCuenta.Text,
                    FormaPago = ddlCondicionesPago.SelectedValue,
                    VoBoNombre = this.txtVoBoNombre.Text,
                    VoBoPuesto = this.txtVoBoPuesto.Text,
                    VoBoArea = this.txtVoBoArea.Text,
                    RecibiNombre = this.txtRecibiNombre.Text,
                    RecibiPuesto = this.txtRecibiPuesto.Text,
                    RecibiArea = this.txtRecibiArea.Text,
                    AutorizoNombre = this.txtAutorizoNombre.Text,
                    AutorizoPuesto = this.txtAutorizoPuesto.Text,
                    AutorizoArea = this.txtAutorizoArea.Text,
                    CondicionesPado = this.txtCondicionesPago.Text
                };
                if (ddlTipoDocumento.SelectedValue == "Egreso")
                    fact.NotaCredito = true;
                if (ddlTipoDocumento.SelectedValue == "Donativo")
                {
                    fact.TipoDocumento = TipoDocumento.Donativo;
                    fact.DonativoAutorizacion = txtDonatAutorizacion.Text;
                    fact.DonativoFechaAutorizacion = DateTime.ParseExact(txtDonatFechautorizacion.Text, "dd/MM/yyyy",
                                                                         new CultureInfo("es-MX"));
                }
                fact.Fecha = DateTime.Now;

                if (ddlStatusFactura.SelectedValue == "1" && !string.IsNullOrEmpty(txtFechaPago.Text))
                {
                    fact.FechaPago = DateTime.ParseExact(txtFechaPago.Text, "dd/MM/yyyy", new CultureInfo("es-MX"));
                    fact.ReferenciaPago = txtCuenta.Text;
                }
                fact.Vencimiento = string.IsNullOrEmpty(this.txtDiasRevision.Text)
                                       ? fact.Fecha
                                       : fact.Fecha.AddDays(int.Parse(this.txtDiasRevision.Text));

                //LLenado de addenda AMC71

                #region AddendaAMC71

                HomeDepotRequestForPayment request = new HomeDepotRequestForPayment();
                request.documentStatus = HomeDepotRequestForPaymentDocumentStatus.ORIGINAL;
                request.documentStructureVersion = "AMC7.1";
                request.DeliveryDateSpecified = true;
                
                //!VEreRIFICAR FECHA CORRECTA
                //request.DeliveryDate = DateTime.ParseExact(fact.Fecha, "yyyy-MM-dd", CultureInfo.InvariantCulture);
                request.DeliveryDate = fact.Fecha;
                request.requestForPaymentIdentification = new HomeDepotRequestForPaymentRequestForPaymentIdentification();
                request.requestForPaymentIdentification.entityType =
                    HomeDepotRequestForPaymentRequestForPaymentIdentificationEntityType.INVOICE;
                //!REQ 1
                request.requestForPaymentIdentification.uniqueCreatorIdentification =
                    RequestforPayment_UniqueCreatorIdentification.Text;
                
                request.orderIdentification = new HomeDepotRequestForPaymentOrderIdentification()
                {
                    referenceIdentification =
                        new HomeDepotRequestForPaymentOrderIdentificationReferenceIdentification
                        []
                                                              {
                                                                  new HomeDepotRequestForPaymentOrderIdentificationReferenceIdentification
                                                                      ()
                                                                      {
                                                                          type =
                                                                              HomeDepotRequestForPaymentOrderIdentificationReferenceIdentificationType
                                                                              .ON,
                                                                          //!ORD ID
                                                                          Value =
                                                                              OrderIdentification_ReferenceIdentification
                                                                              .Text
                                                                      }
                                                              },
                    //!ORD DATE CHECK DATE.
                    //ReferenceDate = DateTime.ParseExact(txtFechaPago.Text, "yyyy-MM-dd", CultureInfo.InvariantCulture),
                    //!IF EXCEPTION OCCURS
                    ReferenceDate = fact.Fecha,
                    ReferenceDateSpecified = true
                };
                
                request.AdditionalInformation = new HomeDepotRequestForPaymentReferenceIdentification[]
                                                    {
                                                        new HomeDepotRequestForPaymentReferenceIdentification()
                                                            {
                                                                type = HomeDepotRequestForPaymentReferenceIdentificationType.ON,
                                                                Value = AdditionalInformation_ReferenceIdentification
                                                                              .Text
                                                            }, 
                                                    };


                //request.specialInstruction = new requestForPaymentSpecialInstruction[]
                //                                 {
                //                                     new requestForPaymentSpecialInstruction()
                //                                         {
                //                                             //! CHANGE. PARSE ENUM.
                //                                             code = requestForPaymentSpecialInstructionCode.ZZZ,
                                                                    
                //                                             //VERIFY STRING ARRAY ELEMENTS
                //                                             Text = new string[]{ CantidadLetra.Enletras(fact.Total.ToString(),ddlMoneda.SelectedItem.Text)}

                //                                         }
                //                                 };





                request.buyer = new HomeDepotRequestForPaymentBuyer();
                //! Buyer GLN
                request.buyer.gln = BuyerSeller_GlnBuyer.Text;
                request.seller = new HomeDepotRequestForPaymentSeller();
                //! Seller GLN
                request.seller.gln = BuyerSeller_GlnSeller.Text;
                request.seller.alternatePartyIdentification = new HomeDepotRequestForPaymentSellerAlternatePartyIdentification();
                request.seller.alternatePartyIdentification.type =
                   HomeDepotRequestForPaymentSellerAlternatePartyIdentificationType.SELLER_ASSIGNED_IDENTIFIER_FOR_A_PARTY;
                //! Alternate PrtId
                request.seller.alternatePartyIdentification.Value = BuyerSeller_AlternatePrtyId.Text;
                //IF Addenda Home Depot is not used.
                //request.shipTo = new requestForPaymentShipTo()
                //    {
                //        gln = Shipto_Gln.Text,
                //        nameAndAddress = new requestForPaymentShipToNameAndAddress()
                //        {
                //            //! Verify Ship to array
                //            //name = new string[] { GetValue(shipto[2]) },
                //            name = new string[] { Shipto_Name.Text },
                //            streetAddressOne =
                //                new string[] { Shipto_StreetAddress.Text },
                //            city = new string[] { Shipto_City.Text },
                //            postalCode = new string[] { Shipto_PostalCode.Text }
                //        }
                //    };
                request.currency = new HomeDepotRequestForPaymentCurrency[]
                                       {
                                           new HomeDepotRequestForPaymentCurrency()
                                               {
                                                   //! Change ISO CODE ENUM
                                                   currencyISOCode = (HomeDepotRequestForPaymentCurrencyCurrencyISOCode)
                                                                     Enum.Parse(
                                                                         typeof (
                                                                             HomeDepotRequestForPaymentCurrencyCurrencyISOCode),
                                                                         Currency_ListBox_ISOCode.SelectedValue),
                                                   //! Change Currency Function Verify for array currency function
                                                   //currencyFunction = new requestForPaymentCurrencyCurrencyFunction[]{requestForPaymentCurrencyCurrencyFunction.BILLING_CURRENCY, },
                                                   currencyFunction = new HomeDepotRequestForPaymentCurrencyCurrencyFunction[]
                                                                          {
                                                                              (HomeDepotRequestForPaymentCurrencyCurrencyFunction
                                                                              ) Enum.Parse
                                                                                    (typeof (
                                                                                         HomeDepotRequestForPaymentCurrencyCurrencyFunction
                                                                                         ),
                                                                                     Currency_ListBox_CurrencyFunction.
                                                                                         SelectedValue)
                                                                          },
                                                   //! Text Parse 
                                                   rateOfChange = decimal.Parse(Currency_RateOfChange.Text),
                                                   //! Always true?
                                                   rateOfChangeSpecified = true

                                               }
                                       };


                //IF Addenda Home Depot is not used

                //request.paymentTerms = new requestForPaymentPaymentTerms()
                //{
                //    paymentTermsEvent =
                //        requestForPaymentPaymentTermsPaymentTermsEvent.DATE_OF_INVOICE,
                //    PaymentTermsRelationTime =
                //        requestForPaymentPaymentTermsPaymentTermsRelationTime.
                //        REFERENCE_AFTER,
                //    PaymentTermsRelationTimeSpecified = true,
                //    paymentTermsEventSpecified = true,
                //    netPayment = new requestForPaymentPaymentTermsNetPayment()
                //    {
                //        netPaymentTermsType =
                //            requestForPaymentPaymentTermsNetPaymentNetPaymentTermsType
                //            .BASIC_NET,
                //        paymentTimePeriod =
                //            new requestForPaymentPaymentTermsNetPaymentPaymentTimePeriod
                //            ()
                //            {
                //                timePeriodDue =
                //                    new requestForPaymentPaymentTermsNetPaymentPaymentTimePeriodTimePeriodDue
                //                    ()
                //                    {
                //                        timePeriod =
                //                            requestForPaymentPaymentTermsNetPaymentPaymentTimePeriodTimePeriodDueTimePeriod
                //                            .DAYS,
                //                        //Verify... 
                //                        value =
                //                            txtDiasRevision.Text
                //                    }
                //            },
                //    }

                //};
                //request.allowanceCharge = new HomeDepotRequestForPaymentAllowanceCharge[]
                //                                  {
                //                                      new HomeDepotRequestForPaymentAllowanceCharge()
                //                                          {
                //                                              settlementType =
                //                                                  HomeDepotRequestForPaymentAllowanceChargeSettlementType.
                //                                                  BILL_BACK,
                //                                              allowanceChargeType =
                //                                                  HomeDepotRequestForPaymentAllowanceChargeAllowanceChargeType.
                //                                                  ALLOWANCE_GLOBAL,
                //                                              monetaryAmountOrPercentage =
                //                                                  new HomeDepotRequestForPaymentAllowanceChargeMonetaryAmountOrPercentage
                //                                                  ()
                //                                                      {
                //                                                          rate =
                //                                                              new HomeDepotRequestForPaymentAllowanceChargeMonetaryAmountOrPercentageRate
                //                                                              ()
                //                                                                  {
                //                                                                      @base =
                //                                                                          HomeDepotRequestForPaymentAllowanceChargeMonetaryAmountOrPercentageRateBase
                //                                                                          .INVOICE_VALUE,
                //                                                                      //Obligatorio Vista.|
                //                                                                      percentage =
                //                                                                          Decimal.Parse(
                //                                                                              ReqForPayment_Percentage.
                //                                                                                  Text)
                //                                                                  }
                //                                                      }
                //                                          }
                //                                  };

                var lineItems = new List<HomeDepotRequestForPaymentLineItem>();
                int countConceptos = 0;

                foreach (var comprobanteConcepto in detalles)
                {

                    HomeDepotRequestForPaymentLineItem li = new HomeDepotRequestForPaymentLineItem();
                    li.type = "SimpleInvoiceLineItemType";
                    li.number = (++countConceptos).ToString();

                    li.tradeItemIdentification = new HomeDepotRequestForPaymentLineItemTradeItemIdentification()
                    {
                        gtin = comprobanteConcepto.Codigo
                    };

                    li.tradeItemDescriptionInformation = new HomeDepotRequestForPaymentLineItemTradeItemDescriptionInformation()
                    {
                        language =
                            HomeDepotRequestForPaymentLineItemTradeItemDescriptionInformationLanguage
                            .ES,
                        languageSpecified = true,
                        longText = comprobanteConcepto.Descripcion
                    };

                    li.invoicedQuantity = new HomeDepotRequestForPaymentLineItemInvoicedQuantity()
                    {
                        unitOfMeasure = comprobanteConcepto.Unidad,
                        Text =
                            new string[]
                                                          {
                                                              comprobanteConcepto.Cantidad.ToString("F2",
                                                                                                    CultureInfo.
                                                                                                        InvariantCulture)
                                                          }
                    };
                    //request.specialInstruction = new requestForPaymentSpecialInstruction[]
                    //                             {
                    //                                 new requestForPaymentSpecialInstruction()
                    //                                     {
                    //                                         //! CHANGE. PARSE ENUM.
                    //                                         code = requestForPaymentSpecialInstructionCode.ZZZ,
                    //                                         //VERIFY STRING ARRAY ELEMENTS
                    //                                         text = new string[]
                    //                                                    {
                    //                                                        CantidadLetra.Enletras(fact.Total.ToString(),fact.MonedaS)

                    //                                                    }
                                                             
                    //                                     }
                    //                             };
                    li.grossPrice = new HomeDepotRequestForPaymentLineItemGrossPrice()
                    {
                        Amount = comprobanteConcepto.Precio
                    };

                    //li.AdditionalInformation = new HomeDepotRequestForPaymentLineItemAdditionalInformation()
                    //{
                    //    referenceIdentification =
                    //        new HomeDepotRequestForPaymentLineItemAdditionalInformationReferenceIdentification
                    //        ()
                    //        {
                    //            type =
                    //                HomeDepotRequestForPaymentLineItemAdditionalInformationReferenceIdentificationType
                    //                .ON,
                    //            Value = OrderIdentification_ReferenceIdentification.Text
                    //        }
                    //};


                    li.totalLineAmount = new HomeDepotRequestForPaymentLineItemTotalLineAmount()
                    {
                        netAmount = new HomeDepotRequestForPaymentLineItemTotalLineAmountNetAmount()
                        {
                            //! Verify / ... 
                            Amount = comprobanteConcepto.Total
                        }


                    };

                    //UNSET IF ADDENDA HOME DEPOT IS USED

                    li.totalLineAmount.grossAmount = new HomeDepotRequestForPaymentLineItemTotalLineAmountGrossAmount()
                        {
                            Amount = comprobanteConcepto.Total,
                        };
                    

                    //TODO Conceptos especiales addenda home depot.

                    li.palletInformation = new HomeDepotRequestForPaymentLineItemPalletInformation
                        {

                            palletQuantity = addendaHomeDeppot_PalletQuantity.Text == "" ? "1" : addendaHomeDeppot_PalletQuantity.Text,
                            description = new HomeDepotRequestForPaymentLineItemPalletInformationDescription()
                            {
                               
                                Text = new string[] { addendaHomeDeppot_Descriptiondesc_TextBox.Text },
                                type = (HomeDepotRequestForPaymentLineItemPalletInformationDescriptionType)Enum.Parse(typeof(requestForPaymentLineItemPalletInformationDescriptionType), addendaHomeDeppot_PalletInfo_Description_DList.SelectedValue)
                            },

                            transport = new HomeDepotRequestForPaymentLineItemPalletInformationTransport()
                            {
                                methodOfPayment = (HomeDepotRequestForPaymentLineItemPalletInformationTransportMethodOfPayment)Enum.Parse(
                            typeof(HomeDepotRequestForPaymentLineItemPalletInformationTransportMethodOfPayment), addendaHomeDeppot_Transport_Dlist.SelectedValue)
                            },

                        };

                        //TAX INFO
                    HomeDepotRequestForPaymentLineItemTradeItemTaxInformation taxInformation = new HomeDepotRequestForPaymentLineItemTradeItemTaxInformation
                        {
                            taxTypeDescription = HomeDepotRequestForPaymentLineItemTradeItemTaxInformationTaxTypeDescription.VAT
                        };
                    taxInformation.tradeItemTaxAmount = new HomeDepotRequestForPaymentLineItemTradeItemTaxInformationTradeItemTaxAmount
                        {
                            taxAmount = fact.IVA.Value
                                ,
                            taxPercentage = 16

                        };
                        //ALTERNATE TRADE ITEM IDENTIFICATION
                    HomeDepotRequestForPaymentLineItemAlternateTradeItemIdentification itemIdentification =
                            new HomeDepotRequestForPaymentLineItemAlternateTradeItemIdentification
                            {
                                type = HomeDepotRequestForPaymentLineItemAlternateTradeItemIdentificationType.BUYER_ASSIGNED,
                                Text = new string[] { addendaHomeDeppot_AltTradItemId_Txt.Text }
                            };
                    //SOLO 1?
                    li.alternateTradeItemIdentification =
                        new HomeDepotRequestForPaymentLineItemAlternateTradeItemIdentification[] { itemIdentification };
                        li.tradeItemTaxInformation = new HomeDepotRequestForPaymentLineItemTradeItemTaxInformation[] { taxInformation };

                    


                    lineItems.Add(li);
                }
                request.lineItem = lineItems.ToArray();
                request.totalAmount = new HomeDepotRequestForPaymentTotalAmount()
                {
                    //! 0 if nullable
                    Amount = fact.SubTotal ?? 0
                };

                request.TotalAllowanceCharge = new HomeDepotRequestForPaymentTotalAllowanceCharge[]
                                                   {
                                                       new HomeDepotRequestForPaymentTotalAllowanceCharge()
                                                           {
                                                               AmountSpecified = true,
                                                               //! Amount check if null then 0 
                                                               Amount =
                                                                   (fact.Descuento == null)
                                                                       ? 0
                                                                       : Decimal.Parse(fact.Descuento)
                                                           }
                                                   };
                request.baseAmount = new HomeDepotRequestForPaymentBaseAmount()
                {
                    //! 0 if nullable
                    Amount = fact.SubTotal ?? 0
                };
                var rfpTaxes = new List<HomeDepotRequestForPaymentTax>();


                var tax = new HomeDepotRequestForPaymentTax()
                {
                    type = HomeDepotRequestForPaymentTaxType.VAT,
                    taxAmount = fact.IVA ?? 0,
                    //taxAmount = comprobante.Impuestos.totalImpuestosTrasladados, //!!!!!!!
                    taxAmountSpecified = true,
                    taxPercentage = fact.PorcentajeIva ?? 0,
                    //taxPercentage = tras.tasa,//!!!!!!!
                    taxPercentageSpecified = true,
                    taxCategory = HomeDepotRequestForPaymentTaxTaxCategory.TRANSFERIDO,
                    taxCategorySpecified = true,
                    typeSpecified = true
                };
                rfpTaxes.Add(tax);

                request.tax = rfpTaxes.ToArray();

                request.payableAmount = new HomeDepotRequestForPaymentPayableAmount()
                {
                    //! 0 if nullable
                    Amount = fact.Total ?? 0
                };
                ///Conceptos añadidos por home depot




                //!!!!!!!!!!!!!!!!! ADD ADDENDA
                fact.AddendaHomeDepot = request;

                #endregion AMC71 Adenda

                //

                return fact;
            }
            catch (Exception e)
            {

                return null;
            }
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
            this.txtCodigo.Text = this.txtDescripcion.Text = this.txtDetalles.Text = this.txtPrecio.Text =
                this.txtCantidad.Text = this.txtUnidad.Text = this.txtCuentaPredial.Text = string.Empty;
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
            //this.ddlMetodoPago.SelectedIndex = 0;
          //  this.ddlMetodoPago_SelectedIndexChanged(null, null);
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
            this.gvDetalles.DataSource = ViewState["detalles"];
            this.gvDetalles.DataBind();
        }

        private void UpdateTotales()
        {

            CultureInfo cul = CultureInfo.CreateSpecificCulture("es-MX");
            var cliente = NtLinkClientFactory.Cliente();
            //int idCliente = int.Parse(this.ddlClientes.SelectedValue);
            //clientes c = cliente.ObtenerClienteById(idCliente);
            var detalles = ViewState["detalles"] as List<facturasdetalle>;
            if (detalles == null)
                return;
            var iva = 0M;
            var total = 0M;
            var subtotal = 0M;
            foreach (facturasdetalle detalle in detalles)
            {
                subtotal += detalle.TotalPartida;

                iva += detalle.ImporteIva.HasValue ? detalle.ImporteIva.Value : 0;
                total += detalle.TotalPartida + (detalle.ImporteIva.HasValue ? detalle.ImporteIva.Value : 0);
            }
            int idEmpresa = int.Parse(this.ddlEmpresa.SelectedValue);
            var emp = cliente.ObtenerEmpresaById(idEmpresa);

            if (emp.RFC == "CEJ060126UI2" || emp.RFC == "BTE1209279P8" || emp.RFC == "ASN1211077Y2" || emp.RFC == "SID080303VE0")
            {
                this.lblIva.Text = iva.ToString("#0.00##", cul);
                this.lblTotal.Text = total.ToString("#0.00##", cul);
                this.lblSubtotal.Text = subtotal.ToString("#0.00##", cul);
            }
            else
            {
                this.lblIva.Text = iva.ToString("C", cul);
                this.lblTotal.Text = total.ToString("C", cul);
                this.lblSubtotal.Text = subtotal.ToString("C", cul);
            }
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
                this.txtCuentaPredial.Text = prod.CuentaPredial;
                this.txtDetalles.Text = prod.Observaciones;

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
            edicion.Cantidad = decimal.Parse(this.txtCantidadEdita.Text);
            edicion.Codigo = this.txtCodigoEdita.Text;
            edicion.Descripcion = this.txtDescripcionEdita.Text;
            edicion.Descripcion2 = this.txtObservacionesEdita.Text;
            edicion.Precio = decimal.Parse(this.txtPrecioUnitarioEdita.Text);
            edicion.CuentaPredial = this.txtCuentaPredialEdita.Text;
            if (edicion.PorcentajeIva != null)
            edicion.ImporteIva = ((decimal)edicion.PorcentajeIva / 100) * edicion.TotalPartida;
            ViewState["detalles"] = detalles;
            this.BindDetallesToGridView();
            this.UpdateTotales();
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

        protected void ddlTipoDocumento_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlTipoDocumento.SelectedValue == "Donativo")
            {
                trDonativo.Visible = true;
            }
            else trDonativo.Visible = false;

        }

        protected void TextBox4_TextChanged(object sender, EventArgs e)
        {

        }

        protected void ListBox2_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {


        }

        protected void Button1_Click1(object sender, EventArgs e)
        {

        }

        protected void TextBox3_TextChanged(object sender, EventArgs e)
        {

        }

        protected void RequestforPayment_ListBox_EntityType_SelectedIndexChanged(object sender, EventArgs e)
        {

        }


        protected void addendaHomeDeppot_Descriptiondesc_TextBox_TextChanged(object sender, EventArgs e)
        {

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