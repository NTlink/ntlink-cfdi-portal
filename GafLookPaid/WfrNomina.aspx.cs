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
    public partial class WfrNomina : System.Web.UI.Page
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
                        this.ddlClientes.DataSource = cliente.ListaEmpleados(perfil, idEmpresa, "", false);
                        this.ddlClientes.DataBind();
                        ddlClientes_SelectedIndexChanged(null, null);
                        if (!cliente.TieneConfiguradoCertificado(idEmpresa))
                        {
                            this.lblError.Text = "Tienes que configurar tus certificados antes de poder facturar";
                            this.btnGenerarFactura.Enabled = this.BtnVistaPrevia.Enabled = this.ddlMoneda.Enabled = false;
                            return;
                        }

                        if (listaEmpresas.Count > 0)
                        {
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

                    //this.BindDetallesToGridView();
                    this.UpdateTotales();
                    ActualizarSaldosMaster();
                }
                catch (Exception ex)
                {
                    //Logger.Error(ex.Message);
                }
            }
        }
        

        protected void btnGenerarFactura_Click(object sender, EventArgs e)
        {
            this.GuardarFactura();
        }

       

        protected void ddlEmpresa_SelectedIndexChanged(object sender, EventArgs e)
        {
            var perfil = Session["perfil"] as string;
            var sistema = Session["idSistema"] as long?;
            var idEmp = Session["idEmpresa"] as int?;
            var cliente = NtLinkClientFactory.Cliente();
            using (cliente as IDisposable)
            {
                int idEmpresa = int.Parse(this.ddlEmpresa.SelectedValue);
                if (!cliente.TieneConfiguradoCertificado(idEmpresa))
                {
                    this.lblError.Text = "Tienes que configurar tus certificados antes de poder facturar";
                    this.btnGenerarFactura.Enabled = this.BtnVistaPrevia.Enabled = this.ddlMoneda.Enabled = false;
                    return;
                }
                var emp = cliente.ObtenerEmpresaById(idEmpresa);
                lblError.Text = "";
                this.ddlSucursales.DataSource = cliente.ListaSucursales(idEmpresa);
                ddlSucursales.DataValueField = "LugarExpedicion";
                ddlSucursales.DataTextField = "Nombre";
                ddlSucursales.DataBind();
                this.btnGenerarFactura.Enabled = this.BtnVistaPrevia.Enabled = this.ddlMoneda.Enabled = true;
                this.txtFolio.Text = cliente.SiguienteFolioFactura(idEmpresa);
                this.ddlClientes.DataSource = cliente.ListaEmpleados(perfil, emp.IdEmpresa, "", false);
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
            
        }

        

        
        

       
        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            this.ClearAll();
        }

        #region Helper Methods

      

        private bool ValidarFactura()
        {
            if ((ViewState["percepciones"] as List<Percepcion>) != null && (ViewState["percepciones"] as List<Percepcion>).Count == 0)
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
                //var detalles = ViewState["detalles"] as List<facturasdetalle>;
                var subTotal = decimal.Parse(this.lblTotalPercepciones.Text, NumberStyles.Currency);
                var detalles = new List<facturasdetalle>()
                                   {
                                       new facturasdetalle(){Cantidad = 1,Unidad = "Servicio", Descripcion =ddlConcepto.SelectedValue, Precio = subTotal}
                                   };
                var iniciales = Session["iniciales"] as string;
                var fact = GetFactura(iniciales,detalles);
                
                try
                {
                    var clienteServicio = NtLinkClientFactory.Cliente();
                    int idCliente = int.Parse(this.ddlClientes.SelectedValue);
                    using (clienteServicio as IDisposable)
                    {
                        var empleado = clienteServicio.ObtenerDatosNomina(idCliente);
                        var clien = clienteServicio.ObtenerClienteById(idCliente);
                        fact.idcliente = idCliente;
                        
                        if (!clienteServicio.GuardarFactura(fact, detalles, true, fact.ConceptosAduanera))
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

        private facturas GetFactura(string iniciales, List<facturasdetalle> detalles )
        {
            var fecha = DateTime.ParseExact(txtFechaInicialLaboral.Text, "yyyy-MM-dd",
                                                System.Threading.Thread.CurrentThread.CurrentCulture);
            var fact = new facturas
            {
                TipoDocumento = TipoDocumento.Nomina,
                IdEmpresa = int.Parse(this.ddlEmpresa.SelectedValue),
                Importe = decimal.Parse(this.lblTotal.Text, NumberStyles.Currency),
                IVA = 0,
                SubTotal = decimal.Parse(this.lblTotalPercepciones.Text, NumberStyles.Currency),
                //IVA = decimal.Parse(this.lblIva.Text, NumberStyles.Currency),
                //SubTotal = decimal.Parse(this.lblSubtotal.Text, NumberStyles.Currency),
                Total = decimal.Parse(this.lblTotal.Text, NumberStyles.Currency),
                //PorcentajeIva = int.Parse(this.txtIva.Text),
                //PorcentajeIva = 16,
                RetencionIsr = decimal.Parse(this.lblTotalDeducciones.Text, NumberStyles.Currency),
                Moneda = int.Parse(this.ddlMoneda.SelectedValue),
                idcliente = int.Parse(this.ddlClientes.SelectedValue),
                Fecha = DateTime.Now,
                Folio = this.txtFolio.Text.PadLeft(4, '0'),
                Serie = string.IsNullOrEmpty(this.txtSerie.Text) ? null : this.txtSerie.Text,
                nProducto = 1,
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
                Descuento = decimal.Parse(this.lblTotalDeducciones.Text, NumberStyles.Currency).ToString(),
                Tipo = 1,
                /*VoBoNombre = this.txtVoBoNombre.Text,
                VoBoPuesto = this.txtVoBoPuesto.Text,
                VoBoArea = this.txtVoBoArea.Text,
                RecibiNombre = this.txtRecibiNombre.Text,
                RecibiPuesto = this.txtRecibiPuesto.Text,
                RecibiArea = this.txtRecibiArea.Text,
                AutorizoNombre = this.txtAutorizoNombre.Text,
                AutorizoPuesto = this.txtAutorizoPuesto.Text,
                AutorizoArea = this.txtAutorizoArea.Text*/

            };
            
            NominaDto dto = new NominaDto()
            {
                Banco = int.Parse(ddlBanco.SelectedValue),
                CLABE = txtClabe.Text,
                Departamento = txtDepartamento.Text,
                FechaInicialPago = fecha,
                CURP = txtCURP.Text,
                NumEmpleado = txtNumEmpleado.Text,
                NumSeguridadSocial = txtNumSeguridadSocial.Text,
                Puesto = txtPuesto.Text,
                PeriodicidadPago = txtPeriodicidadPago.Text,
                TipoRegimen = int.Parse(ddlRegimen.SelectedValue),
                RiesgoPuesto = int.Parse(ddlRiesgoPuesto.SelectedValue),
                SalarioBaseCotApor = decimal.Parse(txtSalarioBaseCotApor.Text),
                SalarioDiarioIntegrado = decimal.Parse(txtSalarioDiarioIntegro.Text),
                TipoContrato = txtTipoContrato.Text,
                TipoJornada = txtTipoJornada.Text,


            };


            var percepciones = ViewState["percepciones"] as List<Percepcion>;
            if (percepciones != null && percepciones.Count > 0)
            {
                Percepciones per = new Percepciones()
                {
                    Percepcion = percepciones,
                    TotalExento = percepciones.Sum(p => p.ImporteExento),
                    TotalGravado = percepciones.Sum(p => p.ImporteGravado)
                };
                dto.Percepciones = per;
            }

            var deducciones = ViewState["deducciones"] as List<Deduccion>;
            if (deducciones != null && deducciones.Count > 0)
            {
                Deducciones ded = new Deducciones()
                {
                    Deduccion = deducciones,
                    TotalExento = deducciones.Sum(p => p.ImporteExento),
                    TotalGravado = deducciones.Sum(p => p.ImporteGravado)
                };
                dto.Deducciones = ded;
            }
            dto.NumDiasPagados = Decimal.Parse(txtDiasPagados.Text);

            fact.Nomina = dto;

            fact.ConceptosAduanera = new List<facturasdetalle>();
            if (deducciones != null && deducciones.Count > 0)
            {
                foreach (Deduccion deduc in deducciones)
                {
                    facturasdetalle det = new facturasdetalle();
                    det.Descripcion = deduc.Concepto;
                    det.Codigo = deduc.Clave;
                    det.Precio = deduc.ImporteExento;
                    det.Total = deduc.ImporteGravado;
                    det.Descripcion2 = "deduccion";
                    det.Unidad = "";
                    fact.ConceptosAduanera.Add(det);
                }
            }
            if (percepciones != null && percepciones.Count > 0)
            {
                foreach (Percepcion perc in percepciones)
                {
                    facturasdetalle det = new facturasdetalle();
                    det.Descripcion = perc.Concepto;
                    det.Codigo = perc.Clave;
                    det.Precio = perc.ImporteExento;
                    det.Total = perc.ImporteGravado;
                    det.Descripcion2 = "percepcion";
                    det.Unidad = "";
                    fact.ConceptosAduanera.Add(det);
                }
            }
            
            fact.Fecha = DateTime.Now;
            if (ddlStatusFactura.SelectedValue == "1" && !string.IsNullOrEmpty(txtFechaPago.Text))
            {
                fact.FechaPago = DateTime.ParseExact(txtFechaPago.Text, "dd/MM/yyyy", new CultureInfo("es-MX"));
                fact.ReferenciaPago = txtCuenta.Text;
            }
            fact.Vencimiento = DateTime.Now;

            return fact;
        }

        private byte[] Preview()
        {
            bool error = false;
            var subTotal = decimal.Parse(this.lblTotalPercepciones.Text, NumberStyles.Currency);
            var detalles = new List<facturasdetalle>()
                                   {
                                       new facturasdetalle(){Cantidad = 1,Unidad = "Servicio", Descripcion =ddlConcepto.SelectedValue, Precio = subTotal}
                                   };
            var iniciales = Session["iniciales"] as string;//
            var fact = GetFactura(iniciales, detalles);

            try
            {
                var clienteServicio = NtLinkClientFactory.Cliente();
                int idCliente = int.Parse(this.ddlClientes.SelectedValue);
                clientes c = clienteServicio.ObtenerClienteById(idCliente);
                using (clienteServicio as IDisposable)
                {
                    var pdf = clienteServicio.FacturaPreview(fact, detalles, fact.ConceptosAduanera);
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

        //private void Clear()
        //{
        //    this.txtCodigo.Text = this.txtDescripcion.Text = this.txtDetalles.Text = this.txtPrecio.Text =
        //        this.txtCantidad.Text = this.txtUnidad.Text = this.txtCuentaPredial.Text = string.Empty;
        //}

        private void ClearAll()
        {
            //this.Clear();

            this.txtProyecto.Text = 
                //this.txtMetodoPago.Text =
                this.txtCuenta.Text = txtProyecto.Text =
                this.txtSerie.Text = string.Empty;
            this.ddlStatusFactura.SelectedIndex = 0;
            this.txtFechaPago.Text = "";
            this.txtFechaPago.Visible = false;
            this.lblTotalDeducciones.Text = 0M.ToString("C");
            this.lblTotalPercepciones.Text = 0M.ToString("C");
            this.lblTotal.Text = 0M.ToString("C");
            //this.ddlMetodoPago.SelectedIndex = 0;
            //this.ddlMetodoPago_SelectedIndexChanged(null, null);
            var detalles = new List<facturasdetalle>();
            ViewState["percepciones"] = new List<Percepcion>();

            
            ViewState["deducciones"] = new List<Deduccion>();
            
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
            var percepciones = ViewState["percepciones"] as List<Percepcion>;
            if (percepciones == null)
            {
                percepciones = new List<Percepcion>();
            }
            var deducciones = ViewState["deducciones"] as List<Deduccion>;
            if (deducciones == null)
            {
                deducciones = new List<Deduccion>();
            }
            gvPercepciones.DataSource = percepciones;
            gvPercepciones.DataBind();
            GvDeducciones.DataSource = deducciones;
            GvDeducciones.DataBind();
        }

        private void UpdateTotales()
        {
            if (!string.IsNullOrEmpty(this.ddlClientes.SelectedValue))
            {
                CultureInfo cul = CultureInfo.CreateSpecificCulture("es-MX");
                var cliente = NtLinkClientFactory.Cliente();
                var percepciones = ViewState["percepciones"] as List<Percepcion>;
                if (percepciones == null)
                {
                    percepciones = new List<Percepcion>();
                }
                var deducciones = ViewState["deducciones"] as List<Deduccion>;
                if (deducciones == null)
                {
                    deducciones = new List<Deduccion>();
                }
                
                var ded = 0M;
                var per = 0M;
                var total = 0M;
                foreach (Percepcion detalle in percepciones)
                {
                    per += detalle.ImporteExento + detalle.ImporteGravado;
                    total += detalle.ImporteExento + detalle.ImporteGravado;

                }
                foreach (Deduccion detalle in deducciones)
                {
                    ded += detalle.ImporteExento + detalle.ImporteGravado;
                    //total += detalle.ImporteExento + detalle.ImporteGravado;

                }
                lblTotal.Text = (total - ded).ToString("C", cul);
                lblTotalDeducciones.Text = ded.ToString("C", cul);
                lblTotalPercepciones.Text = per.ToString("C", cul);

            }
            
        }

        #endregion

        

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
                txtCURP.Text = c.CURP;
                this.txtRazonSocial.Text = sb.ToString();
                this.txtCuenta.Text = c.CuentaPago;
                var datos = cliente.ObtenerDatosNomina(idCliente);
                if (datos != null)
                {
                    this.txtNumEmpleado.Text = datos.NoEmpleado;
                    this.ddlRegimen.SelectedValue = datos.Regimen;
                    this.txtNumSeguridadSocial.Text = datos.NoSeguridadSocial;
                    this.txtDepartamento.Text = datos.Departamento;
                    this.txtClabe.Text = datos.Clabe;
                    this.ddlBanco.SelectedValue = datos.Banco;
                    this.txtFechaInicialLaboral.Text = datos.FechaInicio.ToString("yyyy-MM-dd");
                    this.txtPuesto.Text = datos.Puesto;
                    this.txtTipoContrato.Text = datos.TipoContrato;
                    this.txtTipoJornada.Text = datos.TipoJornada;
                    this.txtPeriodicidadPago.Text = datos.Periodicidad.ToString();
                    this.txtSalarioBaseCotApor.Text = datos.SalarioBase.ToString();
                    this.ddlRiesgoPuesto.SelectedValue = datos.Riesgo;
                    this.txtSalarioDiarioIntegro.Text = datos.SalarioDiario.ToString();
                    
                }

                //this.ddlMetodoPago.Text = c.MetodoPago;
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            /*var detalles = ViewState["detalles"] as List<facturasdetalle>;
            var edicion = detalles[Convert.ToInt32(this.hidNumero.Value)];

            edicion.idproducto = int.Parse(this.hidDetalle.Value);
            edicion.Unidad = this.txtUnidadEdita.Text;
            edicion.Cantidad = decimal.Parse(this.txtCantidadEdita.Text);
            edicion.Codigo = this.txtCodigoEdita.Text;
            edicion.Descripcion = this.txtDescripcionEdita.Text;
            edicion.Descripcion2 = this.txtObservacionesEdita.Text;
            edicion.Precio = decimal.Parse(this.txtPrecioUnitarioEdita.Text);
            edicion.CuentaPredial = this.txtCuentaPredialEdita.Text;
            edicion.ImporteIva = ((decimal)edicion.PorcentajeIva / 100) * edicion.TotalPartida;
            ViewState["detalles"] = detalles;
            this.BindDetallesToGridView();
            this.UpdateTotales();*/
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
           

        }

        protected void ddlTipoDocumento_SelectedIndexChanged(object sender, EventArgs e)
        {
           

        }

        protected void btnAgregarPercepcion_Click(object sender, EventArgs e)
        {
            lblAgregar.Text = "Agregar Percepción";
            trPercepcion.Visible = true;
            tdDeduccion.Visible = false;
            txtImporteExcento.Text = "";
            txtImporteExcento.Text = "";
            
            mpeBuscarConcepto.Show();

        }

        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            if (lblAgregar.Text == "Agregar Percepción")
            {
                var percepciones = ViewState["percepciones"] as List<Percepcion>;
                if (percepciones == null)
                {
                    percepciones = new List<Percepcion>();
                }
                Percepcion percepcion = new Percepcion();
                decimal importeGravado = 0;
                decimal importeExcento = 0;
                int tipoPercepcion = 0;
                if(!decimal.TryParse(txtImporteExcento.Text, out importeExcento))
                {
                    this.lblErrorPercepcion.Text = "El importe excento está mal escrito";
                    return;
                }
                if (!decimal.TryParse(txtImporteGravado.Text, out importeGravado))
                {
                    this.lblErrorPercepcion.Text = "El importe gravado está mal escrito";
                    return;
                }
               
                percepcion.ImporteExento = importeExcento;
                percepcion.ImporteGravado = importeGravado;
                percepcion.Clave = ddlPercepcion.SelectedValue;
                percepcion.TipoPercepcion = int.Parse(percepcion.Clave);
                percepcion.Concepto = ddlPercepcion.SelectedItem.ToString();
                percepciones.Add(percepcion);
                ViewState["percepciones"] = percepciones;
               
            }
            else if (lblAgregar.Text == "Agregar Deducción")
            {
                var deducciones = ViewState["deducciones"] as List<Deduccion>;
                if (deducciones == null)
                {
                    deducciones = new List<Deduccion>();
                }
                Deduccion deduccion = new Deduccion();
                decimal importeGravado = 0;
                decimal importeExcento = 0;
               // int tipoPercepcion = 
                if (!decimal.TryParse(txtImporteExcento.Text, out importeExcento))
                {
                    this.lblErrorPercepcion.Text = "El importe excento está mal escrito";
                    return;
                }
                if (!decimal.TryParse(txtImporteGravado.Text, out importeGravado))
                {
                    this.lblErrorPercepcion.Text = "El importe gravado está mal escrito";
                    return;
                }
                
                deduccion.ImporteExento = importeExcento;
                deduccion.ImporteGravado = importeGravado;
                deduccion.Clave = ddlDeduccion.SelectedValue;
                deduccion.TipoDeduccion = int.Parse(deduccion.Clave);
                deduccion.Concepto = ddlDeduccion.SelectedItem.ToString();
                deducciones.Add(deduccion);
                ViewState["deducciones"] = deducciones;
                
            }
            BindDetallesToGridView();
            UpdateTotales();
            mpeBuscarConcepto.Hide();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            lblAgregar.Text = "Agregar Deducción";
            trPercepcion.Visible = false;
            tdDeduccion.Visible = true;
            txtImporteExcento.Text = "";
            txtImporteExcento.Text = "";
            mpeBuscarConcepto.Show();
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