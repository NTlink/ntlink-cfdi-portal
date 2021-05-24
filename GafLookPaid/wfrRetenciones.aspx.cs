using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.UI;
using ServicioLocalContract;
using System.ServiceModel;
using System.Web.UI.WebControls;
using ServicioLocal.Business.Retenciones;
using System.Data;
using ServicioLocalContract.Entities;


namespace GafLookPaid
{
    public partial class wfrRetenciones : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                try
                {
                  //--------------datos de las retenciones
                    Intereses.Visible = false;
                    dividendos.Visible = false;
                    arrendamientoenfideicomiso.Visible = false;
                    enajenaciondeAcciones.Visible = false;
                    fideicomisoNoEmpresarial.Visible = false;
                    intereseshipotecarios.Visible = false;
                    operacionesconderivados.Visible = false;
                    pagoextranjeros.Visible = false;
                    planesderetiro.Visible = false;
                    premios.Visible = false;
                    sectorFinanciero.Visible = false;
                    // dividendos.Attributes.CssStyle[HtmlTextWriterStyle.Display] = "none";
                   //   UpdatePanel1.Update();


                    var perfil = Session["perfil"] as string;
                    var sistema = Session["idSistema"] as long?;
                    var idEmp = Session["idEmpresa"] as int?;
                    int idEmpresaE;
                    var cliente = NtLinkClientFactory.Cliente();
                    using (cliente as IDisposable)
                    {
                       
                        var empresas = cliente.ListaEmpresas(perfil, idEmp.Value, sistema.Value, null);
                        var folio = cliente.GetNextFolioRetencion(idEmp.Value);
                        this.LabFolio.Text = folio;
                        var listaEmpresas = new List<empresa>(empresas);

                        this.ddlEmpresa.DataSource = listaEmpresas;
                        this.ddlEmpresa.DataBind();
                        this.ddlEmpresaE.DataSource = listaEmpresas;
                        this.ddlEmpresaE.DataBind();


                        int idEmpresa = idEmpresaE = listaEmpresas.First().IdEmpresa;

                        // Set dropdownlist data
                        this.ddlClaveRetencion.Items.Clear();
                        this.ddlClaveRetencion.Items.Add(new ListItem("", ""));
                        foreach (var keyPair in TipoRetencionesText.GetCatalogo())
                        {
                            this.ddlClaveRetencion.Items.Add(new ListItem(keyPair.Value, keyPair.Key));
                        }
                        this.ddlClaveRetencion.DataBind();

                        foreach (var keyPair in TipoImpuestoText.GetCatalogo())
                        {
                            this.ddlImpuestoField.Items.Add(new ListItem(keyPair.Value, keyPair.Key));
                        }
                        this.ddlImpuestoField.DataBind();

                        foreach (var keyPair in TipoPagoText.GetCatalogo())
                        {
                            this.ddlTipoPagoRetField.Items.Add(new ListItem(keyPair.Value, keyPair.Key));
                        }
                        this.ddlTipoPagoRetField.DataBind();

                        if (!cliente.TieneConfiguradoCertificado(idEmpresa))
                        {
                            this.lblError.Text = "Tienes que configurar tus certificados antes de poder facturar";
                            this.btnGenerarRetencion.Enabled = false;
                            return;
                        }

                        if (listaEmpresas.Count > 0)
                        {
                            this.ddlClientes.DataSource = cliente.ListaClientes(perfil, idEmpresa, string.Empty, false);
                            this.ddlClientes.DataBind();
                            this.ddlClientes.Items.Insert(0, "");
                            ddlClientes_SelectedIndexChanged(null, null);
                        }
                    }
                    ViewState["detalles"] = new List<facturasdetalle>();
                    ViewState["iva"] = 0M;
                    ViewState["total"] = 0M;
                    ViewState["subtotal"] = 0M;
                    ViewState["tablaRetenciones"] = CargarTabla();
                    ViewState["listItem"] = 0;
                    ViewState["Bloq"] = new bool();

                    ActualizarSaldosMaster();
                    Fecha_Sello(idEmpresaE);
                }
                catch (Exception ex)
                {
                    // Logger.Error(ex.Message);
                }
            }
        }

        protected void ddlEmpresa_SelectedIndexChanged(object sender, EventArgs e)
        {
            var cliente = NtLinkClientFactory.Cliente();
            ViewState["detalles"] = new List<facturasdetalle>();
            ViewState["iva"] = 0M;
            ViewState["total"] = 0M;
            ViewState["subtotal"] = 0M;
            ViewState["tablaRetenciones"] = CargarTabla();
            ViewState["listItem"] = 0;
            using (cliente as IDisposable)
            {
                int idEmpresa = int.Parse(this.ddlEmpresa.SelectedValue);
                if (!cliente.TieneConfiguradoCertificado(idEmpresa))
                {
                    this.lblError.Text = "Tienes que configurar tus certificados antes de poder facturar";
                    this.btnGenerarRetencion.Enabled = false;
                    this.ddlClientes.DataSource = cliente.ListaClientes(Session["perfil"] as string, idEmpresa, string.Empty, false);
                    this.ddlClientes.DataBind();
                    return;
                }

                lblError.Text = string.Empty;
                this.btnGenerarRetencion.Enabled = true;
                
                this.ddlClientes.DataSource = cliente.ListaClientes(Session["perfil"] as string, idEmpresa, string.Empty, false);
                this.ddlClientes.DataBind();

                ddlClientes_SelectedIndexChanged(null, null);
                ViewState["detalles"] = new List<facturasdetalle>();
                ViewState["iva"] = 0M;
                ViewState["total"] = 0M;
                ViewState["subtotal"] = 0M;
                Fecha_Sello(idEmpresa);
            }
        }

        protected void ddlClientes_SelectedIndexChanged(object sender, EventArgs e)
        {
            var cliente = NtLinkClientFactory.Cliente();
            if (string.IsNullOrEmpty(this.ddlClientes.SelectedValue))
            {
                return;
            }
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

                this.btnGenerarRetencion.Enabled = true;
            }
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            //this.ClearAll();
            Response.Redirect("wfrRetenciones.aspx");
        }

        protected void btnGenerarVista_Click(object sender, EventArgs e)
        {
            bool error = false;
            if (!ValidarRetencion())
                return;
            try{
            IList<RetencionesItem> items;
            var retencion = this.GetRetencion(out items);
            
            var clienteServicio = NtLinkClientFactory.Cliente();
            using (clienteServicio as IDisposable)
            {
                DatosRetenciones datosretenciones = new DatosRetenciones();
                datosretenciones = llenadoRetenciones();
                var pdf = clienteServicio.VistaPreviaRet(retencion, items,datosretenciones);
                if (pdf == null)
                {
                    if (string.IsNullOrEmpty(this.lblError.Text))
                   this.lblError.Text = "* Error al generar la vista previa";
                    return;
                }
                this.Response.ContentType = "application/pdf";
                Response.AddHeader("Content-Disposition", "attachment; filename=preview.pdf");
                this.lblError.Text = string.Empty;
                this.Response.BinaryWrite(pdf);
                this.Response.End();
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
            return;
        }


        protected void btnGenerarFactura_Click(object sender, EventArgs e)
        {
            this.GuardaRetenciones();
        }

        #region Helper Methods

        private void GuardaRetenciones()
        {
            bool error = false;
            if (this.ValidarRetencion())
            {
                IList<RetencionesItem> items;
                var retencion = this.GetRetencion(out items);
                try
                {
                    var clienteServicio = NtLinkClientFactory.Cliente();
                    int idCliente = int.Parse(this.ddlClientes.SelectedValue);
                    clientes c = clienteServicio.ObtenerClienteById(idCliente);
                    using (clienteServicio as IDisposable)
                    {
                        DatosRetenciones datosretenciones = new DatosRetenciones();
                        datosretenciones = llenadoRetenciones();
                       
                        var ss=clienteServicio.GuardarRetencion(retencion, items, datosretenciones, true);
                        if (!ss.resultado)
                        {
                            this.lblError.Text = "* Error al generar la factura";
                            return;
                        }
                        else
                        {
                            var idEmp = Session["idEmpresa"] as int?;
                            var folio = clienteServicio.GetNextFolioRetencion(idEmp.Value);
                            this.LabFolio.Text = folio;
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
                }
                // this.lblError.Text = string.Empty;
            }
        }

        private void ClearAll()
        {

            //--------------datos de las retenciones
            Intereses.Visible = false;
            dividendos.Visible = false;
            arrendamientoenfideicomiso.Visible = false;
            enajenaciondeAcciones.Visible = false;
            fideicomisoNoEmpresarial.Visible = false;
            intereseshipotecarios.Visible = false;
            operacionesconderivados.Visible = false;
            pagoextranjeros.Visible = false;
            planesderetiro.Visible = false;
            premios.Visible = false;
            sectorFinanciero.Visible = false;
                 //--------------------------------
            ckeckboxlist1.ClearSelection();
            gvRetenciones.DataSource = null;
            gvRetenciones.DataBind();

            ddlClaveRetencion.SelectedIndex = 0;
            ddlMesFinal.SelectedIndex = 0;
            ddlMesInicial.SelectedIndex = 0;
            ddlEjercicio.SelectedIndex = 0;
            ddlImpuestoField.SelectedIndex = 0;
            txtBaseRetField.Text = "";
            txtMontoRetField.Text = "";
            ddlTipoPagoRetField.SelectedIndex = 0;
            txtMontoTotalExento.Text = "";
            txtMontoTotalGravado.Text = "";
            txtMontoTotalOperacion.Text="";
                txtMontoTotalRetenciones.Text="";
            

        }

        private Retencion GetRetencion(out IList<RetencionesItem> items)
        {
            Retencion result = new Retencion();
            result.ClaveRetencion = this.ddlClaveRetencion.SelectedValue;
           // result.DescripcionRetencion = string.IsNullOrEmpty(this.txtDescripcionRetencion.Text) ? null : this.txtDescripcionRetencion.Text;
           // result.DescripcionRetencion = "";
            result.Ejercicio = int.Parse(this.ddlEjercicio.SelectedValue);
            result.Emisor = int.Parse(this.ddlEmpresa.SelectedValue);
            result.MesFinal = int.Parse(this.ddlMesFinal.Text);
            result.MesInicial = int.Parse(this.ddlMesInicial.Text);
            result.MontoTotalExento = decimal.Parse(this.txtMontoTotalExento.Text);
            result.MontoTotalGravado = decimal.Parse(this.txtMontoTotalGravado.Text);
            result.MontoTotalOperacion = decimal.Parse(this.txtMontoTotalOperacion.Text);
            result.MontoTotalRetencion = decimal.Parse(this.txtMontoTotalRetenciones.Text);
            result.Receptor = int.Parse(this.ddlClientes.SelectedValue);
            result.Folio = LabFolio.Text;
           items = new List<RetencionesItem>();
            DataTable dt = ViewState["tablaRetenciones"] as DataTable;
            if (dt.Rows.Count != 0)
            {
                foreach (DataRow item in dt.Rows)
                {
                    // We must add the Items to the Retencion type
                    items.Add(new RetencionesItem()
                    {
                        BaseRet = Convert.ToDecimal(item["baseRetField"]),
                        MontoRet = Convert.ToDecimal(item["montoRetField"]),
                        Impuestos = item["impuestoField"] as string,
                        TipoPagoRet = item["tipoPagoRetField"] as string
                    });
                }
            }
            return result;
        }

        private bool ValidarRetencion()
        {
            return true;
        }

        public DataTable CargarTabla()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("ID");
            dt.Columns.Add("baseRetField");
            dt.Columns.Add("impuestoField");
            dt.Columns.Add("montoRetField");
            dt.Columns.Add("tipoPagoRetField");
            return dt;
        }

        #endregion

        protected void gvRetenciones_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int rowIndex = Convert.ToInt32(e.CommandArgument);
            string idRow = Convert.ToString(this.gvRetenciones.DataKeys[rowIndex].Value);

            if(e.CommandName=="DeleteRetItem")
            {
                DataTable dt = ViewState["tablaRetenciones"] as DataTable;
                dt.Rows.RemoveAt(rowIndex);
                

                /*
                foreach (DataRow row in dt.Rows)
                {
                    
                    if((row[0]).ToString()==idRow)
                    {
                        dt.Rows.Remove(row);
                    }
                }*/
                this.gvRetenciones.DataSource = dt;
                this.gvRetenciones.DataBind();
                ViewState["tablaRetenciones"] = dt;
            }
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            var cliente = NtLinkClientFactory.Cliente();

            int idCliente;
            if (int.TryParse(this.ddlClientes.SelectedValue, out idCliente))
            {
                clientes c = cliente.ObtenerClienteById(idCliente);
            }

            else
            {
                lblError.Text = "Seleccione cliente";
            }

            if (string.IsNullOrEmpty(this.txtRazonSocial.Text.Trim()))

            {

                Error.Show();
                this.lblError.Text = "* No se ha seleccionado un cliente";
                return;
            }
            DataTable dt = ViewState["tablaRetenciones"] as DataTable;
            int indice = (int)ViewState["listItem"] + 1;
            dt.Rows.Add(indice, this.txtBaseRetField.Text, this.ddlImpuestoField.SelectedValue, this.txtMontoRetField.Text, this.ddlTipoPagoRetField.SelectedValue);
            ViewState["tablaRetenciones"] = dt;
            ViewState["listItem"] = indice;
            this.gvRetenciones.DataSource = dt;
            this.gvRetenciones.DataBind();
            this.txtBaseRetField.Text = this.txtMontoRetField.Text = string.Empty;
        }

        protected void ckeckboxlist1_SelectedIndexChanged(object sender, EventArgs e)
        {
            //dividendos.Attributes.Add("style", "display:block"); 
            if (ckeckboxlist1.Items[0].Selected == true) Intereses.Visible = true; else  Intereses.Visible = false; 
            if (ckeckboxlist1.Items[1].Selected == true) dividendos.Visible = true;  else  dividendos.Visible = false;
            if (ckeckboxlist1.Items[2].Selected == true) arrendamientoenfideicomiso.Visible = true; else arrendamientoenfideicomiso.Visible = false;
            if (ckeckboxlist1.Items[3].Selected == true) enajenaciondeAcciones.Visible = true; else enajenaciondeAcciones.Visible = false;
            if (ckeckboxlist1.Items[4].Selected == true) fideicomisoNoEmpresarial.Visible = true; else fideicomisoNoEmpresarial.Visible = false;
            if (ckeckboxlist1.Items[5].Selected == true) intereseshipotecarios.Visible = true; else intereseshipotecarios.Visible = false;
            if (ckeckboxlist1.Items[6].Selected == true) operacionesconderivados.Visible = true; else operacionesconderivados.Visible = false;
            if (ckeckboxlist1.Items[7].Selected == true) pagoextranjeros.Visible = true; else pagoextranjeros.Visible = false;
            if (ckeckboxlist1.Items[8].Selected == true) planesderetiro.Visible =true;else planesderetiro.Visible = false;
            if (ckeckboxlist1.Items[9].Selected == true) premios.Visible = true; else premios.Visible = false;
            if (ckeckboxlist1.Items[10].Selected == true) sectorFinanciero.Visible = true; else sectorFinanciero.Visible = false;
        }
        //------------------------------------------------------------------------------------------
        private DatosRetenciones llenadoRetenciones()
        {
            DatosRetenciones d = new DatosRetenciones();
            d.intereses = new DatosIntereses();
            d.dividendos = new DatosDividendos();
            d.arrendamientoenfideicomiso = new DatosArrendamientoenfideicomiso();
            d.enajenaciondeAcciones = new DatosEnajenaciondeAcciones();

            d.fideicomisonoempresarial = new DatosFideicomisonoempresarial();
            d.intereseshipotecarios = new DatosIntereseshipotecarios();
            d.operacionesconderivados = new DatosOperacionesconderivados();
            d.pagosaextranjeros = new DatosPagosaextranjeros();
            d.planesderetiro = new DatosPlanesderetiro();
            d.premios = new DatosPremios();
            d.sectorFinanciero = new DatosSectorFinanciero();

            d.sectorFinanciero.activo = "false";
            d.premios.activo = "false";
            d.planesderetiro.activo = "false";
            d.intereseshipotecarios.activo = "false";
            d.operacionesconderivados.activo = "false";
            d.fideicomisonoempresarial.activo = "false";
            d.pagosaextranjeros.activo = "false";

            d.dividendos.activo = "false";
            d.intereses.activo = "false";
            d.arrendamientoenfideicomiso.activo = "false";
            d.enajenaciondeAcciones.activo = "false";
            if (ckeckboxlist1.Items[0].Selected == true)//intereses
            {
                
                d.intereses.montIntNominalField = convertirTexto("txtMontIntNominal", Intereses);
                d.intereses.montIntRealField = convertirTexto("txtMontIntReal", Intereses);
                d.intereses.operFinancDerivadField = convertirDrop("ddlOperFinancDerivad", Intereses);
                d.intereses.perdidaField = convertirTexto("txtPerdida", Intereses);
                d.intereses.retiroAORESRetIntField = convertirDrop("ddlRetiroAORESRetInt", Intereses);
                d.intereses.sistFinancieroField = convertirDrop("ddlSistFinanciero", Intereses);
                d.intereses.activo = "true";
                //d.intereses.versionField = "";
            }
            if (ckeckboxlist1.Items[1].Selected == true)//dividendos
            {
                d.dividendos.dividendosDividOUtil = new DatosDividendosDividOUtil();
                d.dividendos.remanenteField = new DatosDividendosRemanente();
                d.dividendos.dividendosDividOUtil.cveTipDivOUtilField = convertirDrop("ddlCveTipDivOUtil", dividendos);
                d.dividendos.dividendosDividOUtil.montDivAcumExtField = convertirTexto("txtMontDivAcumExt", dividendos);
                d.dividendos.dividendosDividOUtil.montDivAcumNalField = convertirTexto("txtMontDivAcumNal", dividendos);
                d.dividendos.dividendosDividOUtil.montISRAcredNalField = convertirTexto("txtMontISRAcredNal", dividendos);
                d.dividendos.dividendosDividOUtil.montISRAcredRetExtranjeroField = convertirTexto("txtMontISRAcredRetExtranjero", dividendos);
                d.dividendos.dividendosDividOUtil.montISRAcredRetMexicoField = convertirTexto("txtMontISRAcredRetMexico", dividendos);
                d.dividendos.dividendosDividOUtil.montRetExtDivExtField = convertirTexto("txtMontRetExtDivExt", dividendos);
                d.dividendos.dividendosDividOUtil.tipoSocDistrDivField = convertirDrop("ddlTipoSocDistrDiv", dividendos);
                d.dividendos.remanenteField.proporcionRemField = convertirTexto("txtProporcionRem", dividendos);
                d.dividendos.activo = "true";
                //d.dividendos.versionField = "";
            }
            if (ckeckboxlist1.Items[2].Selected == true)//Arrendamientoenfideicomiso
            {
                d.arrendamientoenfideicomiso.deduccCorrespField = convertirTexto("txtDeduccCorresp", arrendamientoenfideicomiso);
                d.arrendamientoenfideicomiso.descrMontOtrosConceptDistrField = convertirTexto("txtDescrMontOtrosConceptDistr", arrendamientoenfideicomiso);
                d.arrendamientoenfideicomiso.montOtrosConceptDistrField = convertirTexto("txtMontOtrosConceptDistr", arrendamientoenfideicomiso);
                d.arrendamientoenfideicomiso.montResFiscDistFibrasField = convertirTexto("txtMontResFiscDistFibras", arrendamientoenfideicomiso);
                d.arrendamientoenfideicomiso.montTotRetField = convertirTexto("txtMontTotRet", arrendamientoenfideicomiso);
                d.arrendamientoenfideicomiso.pagProvEfecPorFiducField = convertirTexto("txtPagProvEfecPorFiduc", arrendamientoenfideicomiso);
                d.arrendamientoenfideicomiso.rendimFideicomField = convertirTexto("txtRendimFideicom", arrendamientoenfideicomiso);
                d.arrendamientoenfideicomiso.activo = "true";

            }
            if (ckeckboxlist1.Items[3].Selected == true)//enajenaciondeAcciones
            {
                d.enajenaciondeAcciones.activo = "true";
                d.enajenaciondeAcciones.contratoIntermediacionField = convertirTexto("txtContratoIntermediacion", enajenaciondeAcciones);
                d.enajenaciondeAcciones.gananciaField = convertirTexto("txtGanancia", enajenaciondeAcciones);
                d.enajenaciondeAcciones.perdidaField = convertirTexto("txtPerdida", enajenaciondeAcciones);
            }
            if (ckeckboxlist1.Items[4].Selected == true)//fideicomisonoempresarial
            {
             
                d.fideicomisonoempresarial.activo = "true";
                d.fideicomisonoempresarial.DescRetRelPagFideic = convertirTexto("DescRetRelPagFideic", fideicomisoNoEmpresarial);
                d.fideicomisonoempresarial.IntegracEgresosConceptoS = convertirTexto("txtIntegracEgresosConcepto", fideicomisoNoEmpresarial);
                d.fideicomisonoempresarial.IntegracIngresosConcepto = convertirTexto("txtIntegracIngresosConcepto", fideicomisoNoEmpresarial);
                d.fideicomisonoempresarial.MontTotEgresPeriodo = convertirTexto("txtMontTotEgresPeriodo", fideicomisoNoEmpresarial);
                d.fideicomisonoempresarial.MontTotEntradasPeriodo = convertirTexto("txtMontTotEntradasPeriodo", fideicomisoNoEmpresarial);
                d.fideicomisonoempresarial.PartPropAcumDelFideicom = convertirTexto("txtPartPropAcumDelFideicom", fideicomisoNoEmpresarial);
                d.fideicomisonoempresarial.PartPropDelFideicom = convertirTexto("txtPartPropDelFideicom", fideicomisoNoEmpresarial);
                d.fideicomisonoempresarial.IntegracIngresosPropDelMontTot = convertirTexto("txtPropDelMontTot", fideicomisoNoEmpresarial);
                d.fideicomisonoempresarial.IntegracEgresosPropDelMontTot = convertirTexto("txtPropDelMontTotSalidas", fideicomisoNoEmpresarial);
                d.fideicomisonoempresarial.MontRetRelPagFideic = convertirTexto("txtMontRetRelPagFideic", fideicomisoNoEmpresarial);
            }

            if (ckeckboxlist1.Items[5].Selected == true)//intereseshipotecarios
            {
                d.intereseshipotecarios.activo = "true";
                d.intereseshipotecarios.CreditoDeInstFinanc = convertirDrop("ddlCreditoDeInstFinanc", intereseshipotecarios);
                d.intereseshipotecarios.MontTotIntNominalesDev = convertirTexto("txtMontTotIntNominalesDev", intereseshipotecarios);
                d.intereseshipotecarios.MontTotIntNominalesDevYPag = convertirTexto("txtMontTotIntNominalesDevYPag", intereseshipotecarios);
                d.intereseshipotecarios.MontTotIntRealPagDeduc = convertirTexto("txtMontTotIntRealPagDeduc", intereseshipotecarios);
                d.intereseshipotecarios.NumContrato = convertirTexto("txtNumContrato", intereseshipotecarios);
                d.intereseshipotecarios.PropDeducDelCredit = convertirTexto("txtPropDeducDelCredit", intereseshipotecarios);
                d.intereseshipotecarios.SaldoInsoluto = convertirTexto("txtSaldoInsoluto", intereseshipotecarios);
                
            }
            if (ckeckboxlist1.Items[6].Selected == true)//operacionesconderivados
            {
                d.operacionesconderivados.activo = "true";
                d.operacionesconderivados.MontGanAcum = convertirTexto("txtMontGanAcum", operacionesconderivados);
                d.operacionesconderivados.MontPerdDed = convertirTexto("txtMontPerdDed", operacionesconderivados);
                
            }
            if (ckeckboxlist1.Items[7].Selected == true)//pagosaextranjeros
            {
                d.pagosaextranjeros.activo = "true";
                d.pagosaextranjeros.EsBenefEfectDelCobro = convertirDrop("ddlEsBenefEfectDelCobro", pagoextranjeros);
                if (d.pagosaextranjeros.EsBenefEfectDelCobro == "SI")
                {
                    d.pagosaextranjeros.RFC = convertirTextoControl("txtRFC", pagoextranjeros, "beneficiario");
                    d.pagosaextranjeros.CURP = convertirTextoControl("txtCURP", pagoextranjeros, "beneficiario");
                    d.pagosaextranjeros.NomDenRazSocB = convertirTextoControl("txtNomDenRazSocB", pagoextranjeros, "beneficiario");
                    d.pagosaextranjeros.BeneficiarioDescripcionConcepto = convertirTextoControl("txtDescripcionConcepto", pagoextranjeros, "beneficiario");
                    d.pagosaextranjeros.BeneficiarioConceptoPago = convertirDropControl("ddlConceptoPago", pagoextranjeros, "beneficiario");
                }
                else
                {
                    d.pagosaextranjeros.PaisDeResidParaEfecFisc = convertirDropControl("ddlPaisDeResidParaEfecFisc", pagoextranjeros, "noBeneficiario");
                    d.pagosaextranjeros.ConceptoPago = convertirDropControl("ddlConceptoPago", pagoextranjeros, "noBeneficiario");
                    d.pagosaextranjeros.DescripcionConcepto = convertirTextoControl("txtDescripcionConcepto", pagoextranjeros, "noBeneficiario");
               
                }
               
                
                
            }
            if (ckeckboxlist1.Items[8].Selected == true)//planesderetiro
            {
                d.planesderetiro.activo = "true";
                d.planesderetiro.HuboRetirosAnioInmAnt = convertirDrop("ddlHuboRetirosAnioInmAnt", planesderetiro);
                d.planesderetiro.HuboRetirosAnioInmAntPer = convertirDrop("ddlHuboRetirosAnioInmAntPer", planesderetiro);
                d.planesderetiro.MontIntRealesDevengAniooInmAnt = convertirTexto("txtMontIntRealesDevengAniooInmAnt", planesderetiro);
                d.planesderetiro.MontTotAportAnioInmAnterior = convertirTexto("txtMontTotAportAnioInmAnterior", planesderetiro);
                d.planesderetiro.MontTotExedenteAnioInmAnt = convertirTexto("txtMontTotExedenteAnioInmAnt", planesderetiro);
                d.planesderetiro.MontTotExentRetiradoAnioInmAnt = convertirTexto("txtMontTotExentRetiradoAnioInmAnt", planesderetiro);
                d.planesderetiro.MontTotRetiradoAnioInmAnt = convertirTexto("txtMontTotRetiradoAnioInmAnt", planesderetiro);
                d.planesderetiro.MontTotRetiradoAnioInmAntPer = convertirTexto("txtMontTotRetiradoAnioInmAntPer", planesderetiro);
                d.planesderetiro.SistemaFinanc = convertirDrop("ddlSistemaFinanc", planesderetiro);
                d.planesderetiro.NumReferencia = convertirTexto("txtNumReferencia", planesderetiro);
                bool che1 = convertirChe("chActivar", planesderetiro);
                bool che2 = convertirChe("chActivar2", planesderetiro);
                bool che3 = convertirChe("chActivar3", planesderetiro);

                List<DatosAportacionesODepositos> L = new List<DatosAportacionesODepositos>();
                if (che1 == true)
                {
                    DatosAportacionesODepositos A = new DatosAportacionesODepositos();
                    A.TipoAportacionODeposito = convertirDrop("ddlSistemaFinanc1", planesderetiro);
                    A.MontAportODep = convertirTexto("txtMontAportODep", planesderetiro);
                    A.RFCFiduciaria = convertirTexto("txtRFCFiduciaria", planesderetiro);
                    L.Add(A);
                }
                if (che2 == true)
                {
                    DatosAportacionesODepositos A = new DatosAportacionesODepositos();
                    A.TipoAportacionODeposito = convertirDrop("ddlSistemaFinanc2", planesderetiro);
                    A.MontAportODep = convertirTexto("txtMontAportODep2", planesderetiro);
                    A.RFCFiduciaria = convertirTexto("txtRFCFiduciaria2", planesderetiro);
                    L.Add(A);
                }
                if (che3 == true)
                {
                    DatosAportacionesODepositos A = new DatosAportacionesODepositos();
                    A.TipoAportacionODeposito = convertirDrop("ddlSistemaFinanc3", planesderetiro);
                    A.MontAportODep = convertirTexto("txtMontAportODep3", planesderetiro);
                    A.RFCFiduciaria = convertirTexto("txtRFCFiduciaria3", planesderetiro);
                    L.Add(A);
                }
                if (L != null)
                    if (L.Count > 0)
                    {
                        d.planesderetiro.AportacionesODepositos = new List<DatosAportacionesODepositos>();
                        d.planesderetiro.AportacionesODepositos = L;
                    }
            }
            if (ckeckboxlist1.Items[9].Selected == true)//premios
            {
                d.premios.activo = "true";
                d.premios.EntidadFederativa = convertirDrop("ddlEntidadFederativa", premios);
                d.premios.MontTotPago = convertirTexto("txtMontTotPago", premios);
                d.premios.MontTotPagoExent = convertirTexto("txtMontTotPagoExent", premios);
                d.premios.MontTotPagoGrav = convertirTexto("txtMontTotPagoGrav", premios);
                

            }
            if (ckeckboxlist1.Items[10].Selected == true)//sectorFinanciero
            {
                d.sectorFinanciero.activo = "true";
                d.sectorFinanciero.DescripFideicom = convertirTexto("txtDescripFideicom", sectorFinanciero);
                d.sectorFinanciero.NomFideicom = convertirTexto("txtNomFideicom", sectorFinanciero);
                d.sectorFinanciero.IdFideicom = convertirTexto("txtIdFideicom", sectorFinanciero);
            }






            return d;
        }
        private bool convertirChe(string nombre, Control c)
        {
            CheckBox t = (CheckBox)c.FindControl(nombre);
            return t.Checked;
        }
        private string convertirTexto(string nombre,Control c)
        {
           TextBox t = (TextBox)c.FindControl(nombre);
           return t.Text;
        }
        private string convertirDrop(string nombre, Control c)
        {
            DropDownList d = (DropDownList)c.FindControl(nombre);
            return d.SelectedValue;
        }
        private string convertirTextoControl(string nombre, Control c,string control)
        {
            Control c1 =c.FindControl(control);
            TextBox t = (TextBox)c1.FindControl(nombre);
            return t.Text;
        }
        private string convertirDropControl(string nombre, Control c, string control)
        {
            Control c1 = c.FindControl(control);
            DropDownList d = (DropDownList)c1.FindControl(nombre);
            return d.SelectedValue;
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
        protected void btnCerrar_Click(object sender, EventArgs e)
        {
            Response.Redirect("wfrRetenciones.aspx");
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
            ViewState["detalles"] = new List<facturasdetalle>();
            ViewState["iva"] = 0M;
            ViewState["total"] = 0M;
            ViewState["subtotal"] = 0M;
            ViewState["tablaRetenciones"] = CargarTabla();
            ViewState["listItem"] = 0;
            using (cliente as IDisposable)
            {
                int idEmpresa = idEmpresaE = int.Parse(this.ddlEmpresa.SelectedValue);
                if (!cliente.TieneConfiguradoCertificado(idEmpresa))
                {
                    this.lblError.Text = "Tienes que configurar tus certificados antes de poder facturar";
                    this.btnGenerarRetencion.Enabled = false;
                    this.ddlClientes.DataSource = cliente.ListaClientes(Session["perfil"] as string, idEmpresa, string.Empty, false);
                    this.ddlClientes.DataBind();
                    return;
                }
                lblError.Text = string.Empty;
                this.btnGenerarRetencion.Enabled = true;

                this.ddlClientes.DataSource = cliente.ListaClientes(Session["perfil"] as string, idEmpresa, string.Empty, false);
                this.ddlClientes.DataBind();

                ddlClientes_SelectedIndexChanged(null, null);
                ViewState["detalles"] = new List<facturasdetalle>();
                ViewState["iva"] = 0M;
                ViewState["total"] = 0M;
                ViewState["subtotal"] = 0M;

            }
            #endregion

            mpeSellos.Hide();
            this.up1.Update();
            Fecha_Sello(idEmpresaE);
        }
        //------------------------------------------------------------------------------
        protected void LinkButton1_Click(object sender, EventArgs e)
        {

            mpeCFDIG.Hide();

            string uudi = Session["UUDINuevo"].ToString();
            string c = Session["idEmpresa"].ToString();
            
            var cliente = NtLinkClientFactory.Cliente();
            using (cliente as IDisposable)
            {
                Response.AddHeader("Content-Disposition", "attachment; filename=" + "_" + uudi + ".pdf");
                this.Response.ContentType = "application/pdf";

                var pdf = cliente.GetPdfDataRetenciones(uudi, Convert.ToInt32(c), "pdf");
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

    }
}