<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"  CodeBehind="wfrFacturaAddenda.aspx.cs" Inherits="GafLookPaid.wfrFacturaAddenda" %>
    <%@ Register TagPrefix="cc1" Namespace="WebControls.FilteredDropDownList" Assembly="WebControls.FilteredDropDownList" %>
     <%@ Register Assembly="DropDownChosen" Namespace="CustomDropDown" TagPrefix="cc1" %>


 <%@ MasterType VirtualPath="~/Site.Master" %>
 <%@ Register Src="~/controles/Impuestos.ascx" TagPrefix="uc" TagName="UCImpuestos" %>

<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

   

    <style type="text/css">
        .style155
        {
            text-align: right;
        }
        .text-right
        {
            text-align: right;
        }
        .style156
        {
            text-align: center;
            font-weight: bold;
        }
        .style157
        {
            text-align: right;
            font-weight: bold;
        }

         .modalBackground {
        background-color: #666;
        filter: alpha(opacity=70);
        opacity: 0 ;
    }
        .modalPopup {
            background-color: #A8CF38;
            border-width: 2px;
            border-style: solid;
            border-color: #fff;
            box-shadow: 3px 3px 3px 0px rgba(0,0,0,0.35);
            border-radius: 15px;
            padding: 8px;
            width: 300px;
            text-align: center;


        }


         .modalBackground {
        background-color: #666;
        filter: alpha(opacity=70);
        opacity: 0 ;
    }
        .modalPopup {
            background-color: #A8CF38;
            border-width: 2px;
            border-style: solid;
            border-color: #fff;
            box-shadow: 3px 3px 3px 0px rgba(0,0,0,0.35);
            border-radius: 15px;
            padding: 8px;
            width: 300px;
            text-align: center;
        }
        .style165
        {
            width: 322px;
        }
        .style166
        {
            text-align: right;
            font-weight: bold;
            width: 59px;
        }
        .style167
        {
            width: 129px;
        }
        .style168
        {
            width: 59px;
        }
    </style>

   

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- script inactividad -->
    <asp:Panel runat="server" ID="warningPopup" style="display: none;" CssClass="modalPopup" Font-Names ="Arial " HorizontalAlign="Center" >
        <div class="orderLabel">
        <h1 class="style161" style="color: #F90909"><b>Advertencia</b></h1>
        Tu sesión está a punto de expirar por inactividad.
        <br /><br />

    <input id="btnWarningOK" type="button" value="Click para continuar." onclick="HideIddleWarning()" class="btn btn-primary"  />
    </div>
    </asp:Panel>
    
    
    <asp:modalpopupextender  ID="warningMPE" runat="server"
    TargetControlID="dummyLink" PopupControlID="warningPopup"
    BehaviorID="warningMPE" BackgroundCssClass="modalBackground" />
    <asp:HyperLink ID="dummyLink" runat="server" NavigateUrl="#"></asp:HyperLink>

    <!-- Cerrar sesion --> 
    <asp:Panel runat="server" ID="popupcerrar" style="display: none;" CssClass="modalPopup">
    <div class="orderLabel"  style="color: #F90909">
        Su sesión ha expirado por 
        Inactividad de 10 min.
    <br /><br />
    <input id="btncerrar" type="button" value="Entendido" onclick="HideIddleWarning2()"  class="btn btn-primary"  />
    </div>
    </asp:Panel>

    <asp:modalpopupextender ID="cerrar" runat="server"
    TargetControlID="HyperLink" PopupControlID="popupcerrar"
    BehaviorID="warningMPE2" BackgroundCssClass="modalBackground" />
    <asp:HyperLink ID="HyperLink" runat="server" NavigateUrl="#"></asp:HyperLink>


    <!---- **************************************************************** ---->

     
 


<script type="text/javascript">
 
    //localizar timers
    var iddleTimeoutWarning = null;
    var iddleTimeout = null;
 
    //esta funcion automaticamente sera llamada por ASP.NET AJAX cuando la pagina cargue y un postback parcial complete
    function pageLoad() {
 
        //borrar antiguos timers de postbacks anteriores
        if (iddleTimeoutWarning != null)
            clearTimeout(iddleTimeoutWarning);
        if (iddleTimeout != null)
            clearTimeout(iddleTimeout);
 
        //leer tiempos desde web.config
        var millisecTimeOutWarning = <%= int.Parse(System.Configuration.ConfigurationManager.AppSettings["SessionTimeoutWarning"]) * 60 * 1000 %>;
        var millisecTimeOut = <%= int.Parse(System.Configuration.ConfigurationManager.AppSettings["SessionTimeout"]) * 60 * 1000 %>;
 
        //establece tiempo para mostrar advertencia si el usuario ha estado inactivo
        iddleTimeoutWarning = setTimeout("DisplayIddleWarning()", millisecTimeOutWarning);
        iddleTimeout = setTimeout("TimeoutPage()", millisecTimeOut);
    }
 
    function TimeoutPage() {
        HideIddleWarning();
        $find('warningMPE2').show(); 
        this.SessionAbandon();
    }
 
    function DisplayIddleWarning() {
        $find('warningMPE').show();
    }
 
    function HideIddleWarning() {
        $find('warningMPE').hide();
    }

    function HideIddleWarning2() {
          
         $find('warningMPE2').hide();
         
        
        
    }
 
</script>

    <link href="Styles/StyleBoton.css"  rel="stylesheet" type="text/css" />

   
    <asp:UpdatePanel ID="up1" runat="server"  UpdateMode="Conditional" >
        <ContentTemplate>

            <table>
                <caption>
                    <h1 class="style156">Generar Addenda Concepto</h1>
                    <p class="style156">
                        &nbsp;</p>
                    
                    <tr>
                    <td></td>
                    <td align="Left" class="style159">
                            <asp:Label ID="lblVencimiento" runat="server" ForeColor="Red" Font-Bold="true" style=" font-size: x-small; text-align: left; font-variant: small-caps;" Width="250px"></asp:Label>
                        </td>
                        </tr>
                    <tr>
                        <td><strong><span class="style159">Empresa:</span></strong></td>
                        </span></strong>
                        <td>
                            <asp:DropDownList ID="ddlEmpresa" runat="server" AutoPostBack="True" CssClass="form-control2" DataTextField="RazonSocial" DataValueField="idEmpresa" OnSelectedIndexChanged="ddlEmpresa_SelectedIndexChanged" />
                        </td>
                        <td></td>
                        <td class="style148"><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span class="style159">Cliente:</span></strong>&nbsp; &nbsp; <%--asp:DropDownList runat="server" ID="ddlClientes" AutoPostBack="True"
                    DataTextField="RazonSocial" DataValueField="idCliente" CssClass="page"
                    OnSelectedIndexChanged="ddlClientes_SelectedIndexChanged" Height="16px" 
                    Width="197px" /--%>
                            <cc1:DropDownListChosen ID="ddlClientes" runat="server" AllowSingleDeselect="true" AutoPostBack="True" CausesValidation="false" CssClass="page" DataPlaceHolder="Escriba aquí..." DataTextField="RazonSocial" DataValueField="idCliente" Height="16px" NoResultsText="No hay resultados coincidentes." OnSelectedIndexChanged="ddlClientes_SelectedIndexChanged" SelectMethod="" Width="197px">
                            </cc1:DropDownListChosen>
                        </td>
                        <td>
                            <asp:TextBox ID="txtRazonSocial" runat="server" CssClass="page" Enabled="true" Height="33px" TextMode="MultiLine" Width="341px" />
                        </td>
                        
                    </tr>
                </caption>
    </table>
           <table class="page2" width="100%">
                <tr>
                    <td class="style157"><strong><span class="style155">Folio NTLINK:</span> </strong></td>
                    <td>
                        <asp:TextBox ID="txtFolio" runat="server" Enabled="False" CssClass="form-control2" />
                    </td>
                </tr>
                <tr>
                    <td class="bold" style="text-align: right; ">Serie: </td>
                    <td class="style146">
                        <asp:TextBox ID="txtSerie" runat="server" CssClass="form-control2" />
                    </td>
                    <td class="style144" style="text-align: right"><strong>Folio: </strong></td>
                    <td class="style147">
                        <asp:TextBox ID="txtFolioSat" runat="server" CssClass="form-control2" />
                    </td>
                    <td class="style141" style="text-align: right; font-weight: 700;">Sucursal </td>
                    <td class="style146">
                        <asp:DropDownList ID="ddlSucursales" runat="server" AppendDataBoundItems="True" DataTextField="Nombre" DataValueField="LugarExpedicion" CssClass="form-control2" />
                    </td>
                </tr>
                <tr>
                    <td class="bold" style="text-align: right; ">Tipo de Documento:</td>
                    <td>
                        <asp:DropDownList ID="ddlTipoDocumento" runat="server" AutoPostBack="True"  OnSelectedIndexChanged="ddlTipoDocumento_SelectedIndexChanged" CssClass="form-control2">
                            <asp:ListItem Text="Factura" Value="Ingreso"></asp:ListItem>
                            <asp:ListItem Text="Nota de Crédito" Value="Egreso"></asp:ListItem>
                            <asp:ListItem Text="Recibo de Donativo" Value="Donativo"></asp:ListItem>
                            <asp:ListItem Text="Recibo de Arrendamiento" Value="Arrendamiento"></asp:ListItem>
                            <asp:ListItem Text="Recibo de Honorarios" Value="Honorarios"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="style144" style="text-align: right; font-weight: 700;">Status Factura: </td>
                    <td class="style147">
                        <asp:DropDownList ID="ddlStatusFactura" runat="server" AutoPostBack="True" CssClass="form-control2" OnSelectedIndexChanged="ddlStatusFactura_SelectedIndexChanged">
                            <asp:ListItem Text="Pendiente" Value="0"></asp:ListItem>
                            <asp:ListItem Text="Pagada" Value="1"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td style="text-align: right; font-weight: 700;">
                        <asp:Label ID="lblFechaPago" runat="server" Text="Fecha de Pago:" Visible="False" />
                    </td>
                    <td>
                        <asp:TextBox ID="txtFechaPago" runat="server" ontextchanged="txtFechaPago_TextChanged" Visible="False" CssClass="form-control2" />
                        <asp:CompareValidator ID="cvFechaInicial" runat="server" ControlToValidate="txtFechaPago" Display="Dynamic" ErrorMessage="* Fecha Invalida" Operator="DataTypeCheck" Type="Date" />
                        <asp:CalendarExtender ID="ceFechaInicial" runat="server" Animated="False" Format="dd/MM/yyyy" PopupButtonID="txtFechaPago" TargetControlID="txtFechaPago" />
                    </td>
                </tr>
                <tr>
                    <!-- <td style="text-align: right; font-weight: 700;" class="style141">Confirma<strong>c</strong>ion:</td> -->
                    <td style="text-align: right">
                        <asp:Label ID="LblConfirmacion" runat="server" Text="Confirmación:" 
                            Visible="False" CssClass="bold" />
                    </td>
                    <td>
                        <asp:TextBox ID="txtConfirmacion" runat="server" Visible="false" CssClass="form-control2" />
                    </td>
                    <td class="style144" style="text-align: right; font-weight: 700;">Moneda: </td>
                    <td class="style147">
                        <cc1:DropDownListChosen ID="ddlMoneda" runat="server" AllowSingleDeselect="true" AutoPostBack="True" CausesValidation="false" DataPlaceHolder="Escriba aquí..." Height="18px" NoResultsText="No hay resultados coincidentes." OnSelectedIndexChanged="ddlMoneda_SelectedIndexChanged" SelectMethod="" Width="213px">
                        </cc1:DropDownListChosen>
                    </td>
                    <td style="text-align: right">
                        <asp:Label ID="lblTipoCambio" runat="server" style="font-weight: 700" Text="Tipo Cambio:" Visible="False" />
                    </td>
                    <td>
                        <asp:TextBox ID="txtTipoCambio" runat="server" Visible="False" CssClass="form-control2" />
                    </td>
                </tr>
                <tr id="trDonativo" runat="server" visible="False">
                    <td class="style141" style="text-align: right; font-weight: 700;"><strong>N. de </strong>autorización del Donativo: </td>
                    <td>
                        <asp:TextBox ID="txtDonatAutorizacion" runat="server" CssClass="form-control2"></asp:TextBox>
                    </td>
                    <td class="style9">Fecha de <strong>autorización </strong>del donativo: </td>
                    <td>
                        <asp:TextBox ID="txtDonatFechautorizacion" runat="server" CssClass="form-control2"></asp:TextBox>
                        <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" PopupButtonID="txtDonatFechautorizacion" TargetControlID="txtDonatFechautorizacion" />
                    </td>
                </tr>
                <tr>
                    <td class="bold" style="text-align: right; vertical-align:top; ">Forma de Pago </td>
                    <td>
                        <asp:DropDownList ID="ddlFormaPago" runat="server" AutoPostBack="True"  OnSelectedIndexChanged="ddlFormaPago_SelectedIndexChanged" style="margin-left: 0px" CssClass="form-control2" Width="213px">
                            <asp:ListItem runat="server" Text="Seleccionar" Value="00"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Efectivo" Value="01"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Cheque nominativo" Value="02"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Transferencia electrónica de fondos" Value="03"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Tarjeta de crédito" Value="04"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Monedero electrónico" Value="05"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Dinero electrónico" Value="06"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Vales de despensa" Value="08"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Dación en pago" Value="12"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Pago por subrogación" Value="13"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Pago por consignación" Value="14"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Condonación" Value="15"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Compensación" Value="17"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Novación" Value="23"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Confusión" Value="24"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Remisión de deuda" Value="25"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Prescripción o caducidad" Value="26"></asp:ListItem>
                            <asp:ListItem runat="server" Text="A satisfacción del acreedor" Value="27"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Tarjeta de débito" Value="28"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Tarjeta de servicios" Value="29"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Aplicación de anticipos" Value="30"></asp:ListItem>
                            <asp:ListItem runat="server" Value="31" Text="Intermediario pagos"></asp:ListItem>

                            <asp:ListItem runat="server" Selected="True" Text="Por definir" Value="99"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="style144"><strong>Método de Pago </strong></td>
                    <td>
                        <asp:DropDownList ID="ddlMetodoPago" runat="server" AutoPostBack="True"  OnSelectedIndexChanged="ddlMetodoPago_SelectedIndexChanged" CssClass="form-control2">
                            <asp:ListItem runat="server" Text="Seleccionar" Value="00"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Pago en una sola exhibición" Value="PUE"></asp:ListItem>
                            <asp:ListItem runat="server" Selected="True" Text="Pago en parcialidades o diferido" Value="PPD"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td style="text-align: right; font-weight: 700;">Condiciones de Pago</td>
                    <td>
                        <asp:TextBox ID="txtCondicionesPago" runat="server" CssClass="form-control2"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="style141" style="text-align: right"></td>
                    <td class="style146"></td>
                </tr>
                <tr>
                    <td class="style141" style="text-align: right; font-weight: bold;"><strong>UsoCFDI</strong></td>
                    <td>
                        <asp:DropDownList ID="ddlUsoCFDI" runat="server" AutoPostBack="True" CssClass="form-control2" Width="250px">
                            <asp:ListItem runat="server" Text="Adquisición de mercancias" Value="G01"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Devoluciones, descuentos o bonificaciones" Value="G02"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Gastos en general" Value="G03"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Construcciones" Value="I01"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Mobilario y equipo de oficina por inversiones" Value="I02"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Equipo de transporte" Value="I03"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Equipo de computo y accesorios" Value="I04"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Dados, troqueles, moldes, matrices y herramental" Value="I05"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Comunicaciones telefónicas" Value="I06"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Comunicaciones satelitales" Value="I07"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Otra maquinaria y equipo" Value="I08"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Honorarios médicos, dentales y gastos hospitalarios." Value="D01"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Gastos médicos por incapacidad o discapacidad" Value="D02"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Gastos funerales." Value="D03"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Donativos." Value="D04"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Intereses reales efectivamente pagados por créditos hipotecarios (casa habitación)." Value="D05"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Aportaciones voluntarias al SAR." Value="D06"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Primas por seguros de gastos médicos." Value="D07"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Gastos de transportación escolar obligatoria." Value="D08"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Depósitos en cuentas para el ahorro, primas que tengan como base planes de pensiones." Value="D09"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Pagos por servicios educativos (colegiaturas)" Value="D10"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Por definir" Value="P01"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="style144" style="text-align: right; font-weight: 700;">Observaciones </td>
                    <td class="style147">
                        <asp:TextBox ID="txtProyecto" runat="server"  CssClass="form-control2" Width="100%" />
                    </td>
                    <td>
                    
                        <strong>Decimales Importe</strong></td>
                        <td><asp:DropDownList runat="server" ID="ddlDecimales" AutoPostBack="True" 
                                OnSelectedIndexChanged="ddlDecimales_SelectedIndexChanged" 
                                CssClass="form-control2" Width="66px" >
                            <asp:ListItem Value="2" Text="2" Selected="True"></asp:ListItem>
                        <asp:ListItem Value="3" Text="3"></asp:ListItem>
                        <asp:ListItem Value="4" Text="4"></asp:ListItem>
                        <asp:ListItem Value="5" Text="5"></asp:ListItem>
                        <asp:ListItem Value="6" Text="6"></asp:ListItem>
                        </asp:DropDownList>
                        </td>
                </tr>
            </table>
            <div id="divParcialidades" runat="server" class="page3" visible="False">
                <h1 style="text-align: center">Parcialidades</h1>
                <table width="95%">
                    <tr>
                        <td class="style130" style="text-align: right;">Folio Fiscal Original </td>
                        <td>
                            <asp:TextBox ID="txtFolioOriginal" runat="server" />
                        </td>
                        <td class="style3" style="text-align: right;">Fecha del Folio Fiscal Original: </td>
                        <td>
                            <asp:TextBox ID="txtFechaOriginal" runat="server" Width="100%" />
                            <asp:CalendarExtender ID="ceFechaOriginal" runat="server" PopupButtonID="txtFechaOriginal" TargetControlID="txtFechaOriginal" />
                            <asp:CompareValidator ID="dvFechaOriginal" runat="server" ControlToValidate="txtFechaOriginal" Display="Dynamic" ErrorMessage="* Fecha Invalida" Operator="DataTypeCheck" Type="Date" ValidationGroup="CrearFactura" />
                        </td>
                    </tr>
                    <tr>
                        <td class="style130" style="text-align: right;">Monto del Folio Fiscal Original </td>
                        <td>
                            <asp:TextBox ID="txtMontoOriginal" runat="server" Width="100%" />
                            <asp:CompareValidator ID="cvMontoOriginal" runat="server" ControlToValidate="txtMontoOriginal" Display="Dynamic" ErrorMessage="* Monto invalido" Operator="DataTypeCheck" Type="Currency" ValidationGroup="CrearFactura" />
                        </td>
                        <td style="text-align: right">Serie del Folio Fiscal Original </td>
                        <td>
                            <asp:TextBox ID="txtSerieOriginal" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="divViasConcesionadas" runat="server" visible="False">
                <h1>Firmas</h1>
                <table width="100%">
                    <tr>
                        <td>Vo. Bo. </td>
                        <td>Nombre: </td>
                        <td>
                            <asp:TextBox ID="txtVoBoNombre" runat="server"></asp:TextBox>
                        </td>
                        <td>Puesto: </td>
                        <td>
                            <asp:TextBox ID="txtVoBoPuesto" runat="server"></asp:TextBox>
                        </td>
                        <td>Area: </td>
                        <td>
                            <asp:TextBox ID="txtVoBoArea" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>Recibí </td>
                        <td>Nombre: </td>
                        <td>
                            <asp:TextBox ID="txtRecibiNombre" runat="server"></asp:TextBox>
                        </td>
                        <td>Puesto: </td>
                        <td>
                            <asp:TextBox ID="txtRecibiPuesto" runat="server"></asp:TextBox>
                        </td>
                        <td>Area: </td>
                        <td>
                            <asp:TextBox ID="txtRecibiArea" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>Autorizó </td>
                        <td>Nombre: </td>
                        <td>
                            <asp:TextBox ID="txtAutorizoNombre" runat="server"></asp:TextBox>
                        </td>
                        <td>Puesto: </td>
                        <td>
                            <asp:TextBox ID="txtAutorizoPuesto" runat="server"></asp:TextBox>
                        </td>
                        <td>Area: </td>
                        <td>
                            <asp:TextBox ID="txtAutorizoArea" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </div>
            <br />
            <asp:Panel ID="Panel3" runat="server" BorderStyle="Double" CssClass="page1" HorizontalAlign="Left" Width="100%">
                <asp:CheckBox ID="cbCfdiRelacionados" runat="server" AutoPostBack="True" oncheckedchanged="cbCfdiRelacionados_CheckedChanged" style="font-weight: 700; color: #0000FF;" Text="CfdiRelacionados" />
                <div id="DivCfdiRelacionados" runat="server" style="width:100%" visible="false">
                    <table width="100%">
                        <tr>
                            <td colspan="3" style="text-align: right; font-weight: 700;">
                                <asp:Label ID="Label1" runat="server" Font-Bold="True" style="font-size: medium; text-align: right; color: #2D5C94;" Text="CfdiRelacionado"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="text-right">UUID:</td>
                            <td>
                                <asp:TextBox ID="txtUUDI" runat="server" CssClass="form-control2" Width="280px" />
                            </td>
                            <td class="text-right">TipoRelacion:</td>
                            <td>
                                <asp:DropDownList ID="ddlTipoRelacion" runat="server" AutoPostBack="True" CssClass="form-control2">
                                    <asp:ListItem runat="server" Text="01 - Nota de crédito de los documentos relacionados" Value="01" />
                                    <asp:ListItem runat="server" Text="02 - Nota de débito de los documentos relacionados" Value="02" />
                                    <asp:ListItem runat="server" Text="03 - Devolución de mercancía sobre facturas o traslados previos" Value="03" />
                                    <asp:ListItem runat="server" Text="04 - Sustitución de los CFDI previos" Value="04" />
                                    <asp:ListItem runat="server" Text="05 - Traslados de mercancias facturados previamente" Value="05" />
                                    <asp:ListItem runat="server" Text="06 - Factura generada por los traslados previos" Value="06" />
                                    <asp:ListItem runat="server" Text="07 - CFDI por aplicación de anticipo" Value="07" />
                                    <asp:ListItem runat="server" Text="08 - Factura generada por pagos en parcialidades" Value="08" />
                                    <asp:ListItem runat="server" Text="09 - Factura generada por pagos diferidos" Value="09" />
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" style="text-align: right">
                                <asp:Button ID="btnCfdiRelacionado" runat="server" class="btn btn-primary" onclick="btnCfdiRelacionado_Click" Text="Agregar CfdiRelacionado" ValidationGroup="AgregarCfdiRelacionado" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5">
                                <asp:GridView ID="gvCfdiRelacionado" runat="server" AutoGenerateColumns="False" CssClass="style124" onrowcommand="gvCfdiRelacionado_RowCommand" ShowHeaderWhenEmpty="True" Width="100%">
                                    <Columns>
                                        <asp:BoundField DataField="ID" HeaderText="ID" ItemStyle-HorizontalAlign="Center" />
                                        <asp:BoundField DataField="UUID" HeaderText="UUID" ItemStyle-HorizontalAlign="Center" />
                                        <asp:ButtonField CommandName="EliminarCfdiRelacionado" ItemStyle-HorizontalAlign="Center" Text="Eliminar" Visible="False" />
                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </div>
            </asp:Panel>
            <asp:TabContainer ID="tabContainerAduana" runat="server" ActiveTabIndex="0" AutoPostBack = "true"
                style="margin-right: 5px" Width="100%">
         
                <asp:TabPanel ID="tabGeneral" runat="server" CssClass="page3" HeaderText="Datos Generales">
                <HeaderTemplate>Conceptos</HeaderTemplate>
                <ContentTemplate><h1 class="style155" style="text-align: center"><strong>Conceptos</strong></h1><table  class="table-hover" ><tr>
                    <td style="text-align: right; ">
                    <span class="style160" style="color: #FF0000">*</span>ClaveUnidad</td>
                    <td style="text-align: left;"><div>
                    <cc1:DropDownListChosen 
                    ID="ddlClaveUnidad" runat="server" 
            NoResultsText="No hay resultados coincidentes." width="120px" Height="16px"          
            DataPlaceHolder="Escriba aquí..." AllowSingleDeselect="True"  
                            AutoPostBack="True" 
                            onselectedindexchanged="ddlClaveUnidad_SelectedIndexChanged" 
                    DisableSearchThreshold="10"></cc1:DropDownListChosen></div></td>
                    <td style="text-align: right; " class="style142"><span class="style160" 
                            style="color: #FF0000">*</span>Unidad</td><td class="style143"><asp:TextBox runat="server" ID="txtUnidad" CssClass="form-control2" Width="72px" /></td>
                    <td class="style144"><span class="style160" 
                               style="color: #FF0000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*</span>Código </td><td><asp:TextBox ID="txtCodigo" runat="server" CssClass="form-control2" MaxLength="8" Width="72px" /><script type="text/javascript"> 

                        function SoloNum(e) {
                            var key_press = document.all ? key_press = e.keyCode : key_press = e.which;
                            return (key_press > 47 && key_press < 58);
                            // el  "|| key_press == 46" es para incluir el punto ".", si borramos solo ingresara enteros 
                        }
                    </script></td>
                    
                    <td>
                        NoIdentificacion</td>
                        
                        <td><asp:TextBox ID="txtNoIdentificacion" runat="server" CssClass="form-control2" 
                             /></td><td class="style138"><input style=" width:120px" type="button" value="BuscadorSAT" onclick="javascript: window.open('http://200.57.3.46:443/PyS/catPyS.aspx', '', 'width=600,height=400,left=50,top=50,toolbar=yes');" class="btn btn-primary" /></td>
                                                             
                                </tr>
                                <tr>
                                <td></td><td></td><td class="style142"></td><td class="style143"><asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator6" ControlToValidate="txtUnidad"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="AgregarConcepto" style="font-size: medium" /></td>
                           <td class="style144"></td><td><asp:RequiredFieldValidator runat="server" 
                                    ID="rfvUnidad" ControlToValidate="txtCodigo" CssClass="alert-error"
                            Display="Dynamic" ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" 
                                    style="font-size: medium" /></td></tr><tr>
                        <td style="text-align: right"><span class="style160" style="color: #FF0000">*</span>Cantidad </td><td><asp:TextBox runat="server" ID="txtCantidad" CssClass="form-control2"  Width="59px" /></td>
                        <td class="style142"><span  style="color: #FF0000" >*</span>PrecioUnitario$&nbsp;&nbsp; </td><td class="style143"><asp:TextBox ID="txtPrecio" runat="server" CssClass="form-control2" Width="72px" /></td><td 
                        style="font-weight: 700; text-align: right;" class="style144"><asp:CheckBox 
                        ID="descuento" runat="server" AutoPostBack="True" 
                        OnCheckedChanged="descuento_CheckedChanged" 
                         Text=" % Desc" /></td><td><asp:TextBox 
                            ID="txtdsc" runat="server" AutoPostBack="True" CssClass="form-control2" 
                            Enabled="False"  OnTextChanged="txtdsc_TextChanged" Width="72px" ></asp:TextBox></td>
                        <td style="text-align: right">Descuento</td><td><asp:TextBox ID="txtDescuento" runat="server" AutoPostBack="True" CssClass="form-control2"  /></td>
                        <td><asp:Button ID="btnBuscarProducto" runat="server" class="btn btn-primary" 
                                OnClick="btnBuscarProducto_Click" Text="ClaveProdServ" Width="120px" /></td>
                        </tr>
                        
                        <tr><td></td><td><asp:RequiredFieldValidator runat="server" CssClass="alert-error"
                         ID="rfvCantidad" ControlToValidate="txtCantidad"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                         ValidationGroup="AgregarConcepto" style="font-size: medium" /><asp:RegularExpressionValidator id="RegularExpressionValidator2" runat="server" Display="Dynamic" CssClass="alert-danger"
    ControlToValidate="txtCantidad" ErrorMessage="Dato invalido" 
                         ValidationExpression="[0-9]*\.?[0-9]*" 
                         ValidationGroup="AgregarConcepto" style="font-size: medium"/></td><td class="style142"></td><td><asp:RequiredFieldValidator runat="server" ID="rfvPrecio" ControlToValidate="txtPrecio" CssClass="alert-error"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                         ValidationGroup="AgregarConcepto" 
                         style="color: #FF0000; font-size: medium;" />&nbsp; <asp:CompareValidator runat="server" ID="cvPrecio" ControlToValidate="txtPrecio"
                            Display="Dynamic" ErrorMessage="* Precio invalido" Type="Double" Operator="DataTypeCheck"
                            ValidationGroup="AgregarConcepto" 
                         style="color: #FF0000; font-size: medium;" /></td><td class="style143">&nbsp;</td><td class="style144"></td><td class="style154"></td><td></td></tr><tr><td 
                    style="text-align: right"><asp:CheckBox runat="server" ID="cbIVA" Text="IVA" 
                         AutoPostBack="True" 
                         
                         OnCheckedChanged="cbImp_CheckedChanged" Checked="True"/></td><td><asp:DropDownList 
                        runat="server" ID="ddlIVA" AutoPostBack="True"  CssClass="form-control0"><asp:ListItem 
                        Value="0.160000" Text="16%" Selected="True"></asp:ListItem><asp:ListItem 
                        Text="0%" Value="0.000000"></asp:ListItem><asp:ListItem Text="Exento" 
                        Value="Exento"></asp:ListItem></asp:DropDownList></td><td style="text-align: right; font-weight: 700;" class="style142"><asp:CheckBox runat="server" 
                       ID="cbRISR" Text="Ret ISR" AutoPostBack="True" 
                      /></td><td class="style143"><asp:TextBox 
                        ID="txtRISR10" runat="server" CssClass="form-control0" Width="62px" 
                        Text="0.100000" Enabled="False"/></td>
                    <td style="font-weight: 700; text-align: right;" class="style144"><asp:CheckBox runat="server" 
                             ID="cbRIVA" Text="Ret IVA" AutoPostBack="True" 
                             
                             OnCheckedChanged="cbRIVA_CheckedChanged"/></td><td><asp:DropDownList 
                        runat="server" ID="ddlRIVA" AutoPostBack="True"  CssClass="form-control0" 
                        Enabled="False"><asp:ListItem Value="0.106666" Text="0.106666" 
                        Selected="True"></asp:ListItem><asp:ListItem Text="0.040000" 
                        Value="0.040000"></asp:ListItem></asp:DropDownList></td>
                    <td style="text-align: right; ">CuentaPredial</td><td><asp:TextBox ID="txtCuentaPredial" runat="server" CssClass="form-control2" 
                                    Width="130px"  /></td><td></td></tr></table><table class="table-responsive"><tr><td style="text-align: right; font-weight: 700;" width="15%"><span class="style160" style="color: #FF0000">*</span>Descripción </td><td colspan="3" style="text-align: left"><asp:TextBox runat="server" ID="txtDescripcion" CssClass="form-control0"
                            TextMode="MultiLine" Width="375px" Height="68px" /></td>
                    <td style="text-align: right">Observaciones</td><td><asp:TextBox runat="server" ID="txtDetalles" CssClass="form-control2" Width="350px" Height="68px"
                            TextMode="MultiLine"  /></td><td></td><td></td></tr><tr><td class="auto-style1"></td><td class="auto-style1"><asp:RequiredFieldValidator runat="server" ID="rfvDescripcion" ControlToValidate="txtDescripcion"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="AgregarConcepto" 
                           style="color: #FF0000; font-size: medium;" /></td><td style="text-align: left; font-weight: 700; font-size: small; color: #FF0000;" 
                                 class="auto-style1">&nbsp;Obligatorios (*)</td><td class="auto-style1"></td><td class="style154"><asp:Button ID="btnAgregar" runat="server" class="btn btn-primary" 
                                         OnClick="btnAgregar_Click" Text="Agregar Concepto" 
                                         ValidationGroup="AgregarConcepto" Width="146px" /></td><td><asp:Button ID="btnBuscarHistorico" runat="server" class="btn btn-primary" 
                                         OnClick="btnBuscarHistorico_Click" Text="BuscarConcepto" Width="116px" /></td></tr><caption><tr><td><asp:HiddenField ID="txtIdProducto" runat="server" /></td><td class="style141"></td></tr></caption></table><br /><br />
                                         <div style="height: 100%; overflow-y: scroll">
                                         <asp:GridView ID="gvDetalles" runat="server" AutoGenerateColumns="False" CssClass="style124" HorizontalAlign="Center" OnRowCommand="gvDetalles_RowCommand" ShowHeaderWhenEmpty="True" Width="100%"><Columns><asp:BoundField DataField="Partida" HeaderText="Partida"><ItemStyle HorizontalAlign="Center" /></asp:BoundField><asp:BoundField DataField="Codigo" HeaderText="ClaveProdServ"><ItemStyle HorizontalAlign="Center" /></asp:BoundField><asp:BoundField DataField="ConceptoNoIdentificacion" HeaderText="NoIdentificacion"><ItemStyle HorizontalAlign="Center" /></asp:BoundField><asp:BoundField DataField="Cantidad" HeaderText="Cantidad"><ItemStyle HorizontalAlign="Center" /></asp:BoundField><asp:BoundField DataField="ConceptoClaveUnidad" HeaderText="ClaveUnidad"><ItemStyle HorizontalAlign="Center" /></asp:BoundField><asp:BoundField DataField="Unidad" HeaderText="Unidad"><ItemStyle HorizontalAlign="Center" /></asp:BoundField><asp:BoundField DataField="Precio" DataFormatString="${0:#,#.######}" HeaderText="ValorUnitario"><ItemStyle HorizontalAlign="Center" /></asp:BoundField><asp:BoundField DataField="Descripcion" HeaderText="Descripción" /><asp:BoundField DataField="Total" DataFormatString="${0:#,#.######}" HeaderText="Importe" /><asp:BoundField DataField="ConceptoDescuento" DataFormatString="${0:#,#.######}" HeaderText="Descuento"><ItemStyle HorizontalAlign="Right" /></asp:BoundField><asp:BoundField DataField="CuentaPredial" HeaderText="CuentaPredial" /><asp:BoundField DataField="Observaciones" HeaderText="Observaciones" /><asp:ButtonField CommandName="Editar" Text="Editar" Visible="False"><ItemStyle HorizontalAlign="Center" /></asp:ButtonField><asp:ButtonField CommandName="EliminarConcepto" Text="Eliminar" Visible="False"><ItemStyle HorizontalAlign="Center" /></asp:ButtonField></Columns></asp:GridView></div><br /><br /><br /><br /></ContentTemplate></asp:TabPanel>
               <asp:TabPanel ID="datosAddenda" runat="server" CssClass="page1" HeaderText="Addenda">
                <HeaderTemplate>Addenda</HeaderTemplate>
                <ContentTemplate><div align="center">
                <table width="95%"><caption><h1 class="style156">Datos Conceptos</h1><br /><br />
                <tr><td class="style168">Concepto: </td>
                </tr>
                <tr>
                <td colspan="2" style="text-align: left">
                <asp:TextBox  Width="95%" ID="txtConceptoLargo" runat="server" 
                        CssClass="form-control2" TextMode="MultiLine" Height="207px"></asp:TextBox></td>
                
                </tr>
                <tr> 
                 <td  colspan="2" style="text-align: left">
                     <asp:Button ID="btnAgregarConceptoLargo" runat="server" class="btn btn-primary" 
                         OnClick="btnAgregarConceptoLargo_Click" Text="Agregar" Width="120px" />
                    </td>
                  </tr>
                <tr><td class="style166" style="text-align: right">&nbsp;</td>
                <td class="style165" style="text-align: left">&nbsp;</td>
               </tr>
                </caption></table>
                              <div  style="width:100%;height: 100%; overflow-y: scroll"  >
                                         <asp:GridView ID="gvConceptoLargo" runat="server" AutoGenerateColumns="False" CssClass="style124"
                                           HorizontalAlign="Left" OnRowCommand="gvConceptoLargo_RowCommand" ShowHeaderWhenEmpty="True"
                                            Width="100%">
                                         <Columns><asp:BoundField DataField="ID" HeaderText="ID">
                                         <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />  </asp:BoundField>
                                          <asp:BoundField DataField="Concepto" HeaderText="Concepto" >
                                           <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" /> </asp:BoundField>
                                          <asp:ButtonField CommandName="EliminarConceptosLargos" Text="Eliminar" Visible="False">
                                          <ItemStyle HorizontalAlign="Left"  VerticalAlign="Top"/>
                                          </asp:ButtonField>
                                          </Columns>
                                         </asp:GridView></div>
                </div>
                                
                </ContentTemplate>
                </asp:TabPanel>
         
            </asp:TabContainer>
            <div>
                <table width="100%">
                    <tr>
                        <td style="text-align: left">
                            <asp:Panel ID="Panel1" runat="server" BorderStyle="Double" CssClass="page3" HorizontalAlign="Left" Width="100%">
                                <asp:CheckBox ID="cbImpuestos" runat="server" AutoPostBack="True" Enabled="False" oncheckedchanged="cbImpuestos_CheckedChanged" style="font-weight: 700; color: #0000FF; font-size: large;" Text="Impuestos" />
                                <div id="DivComplementos" runat="server" style="width:100%" visible="false">
                                    <table width="100%">
                                        <tr>
                                            <td colspan="3" style="text-align: left; font-weight: 700;">
                                                <asp:Label ID="Label2" runat="server" Font-Bold="True" style="font-size: medium; color: #2D5C94;" Text="Impuestos"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right">
                                                <asp:Label ID="Label12" runat="server" ForeColor="Red" Text="*"></asp:Label>
                                                TipoImpuesto:</td>
                                            <td>
                                                <asp:DropDownList ID="ddlTipoImpuesto" runat="server" AutoPostBack="True" onselectedindexchanged="ddlTipoImpuesto_SelectedIndexChanged" CssClass="form-control2">
                                                    <asp:ListItem Value="Traslados">Traslados</asp:ListItem>
                                                    <asp:ListItem Value="Retenciones">Retenciones</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td style="text-align: right">
                                                <asp:Label ID="Label11" runat="server" ForeColor="Red" Text="*"></asp:Label>
                                                Base:</td>
                                            <td>
                                                <asp:TextBox ID="txtBase" runat="server" Enabled="False" CssClass="form-control2"></asp:TextBox>
                                                <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" FilterType="Numbers, Custom" TargetControlID="txtBase" ValidChars="." />
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtBase" Display="Dynamic" ErrorMessage="Requerido" ValidationGroup="AgregarImpuesto"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtBase" Display="Dynamic" ErrorMessage="Dato invalido" ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" ValidationGroup="AgregarImpuesto" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style128" style="text-align: right">
                                                <asp:Label ID="Label10" runat="server" ForeColor="Red" Text="*"></asp:Label>
                                                Partida:</td>
                                            <td class="style125">
                                                <asp:DropDownList ID="ddlConceptos" runat="server" AutoPostBack="True" onselectedindexchanged="ddlConceptos_SelectedIndexChanged" CssClass="form-control2">
                                                </asp:DropDownList>
                                            </td>
                                            <td style="text-align: right">
                                                <asp:Label ID="Label4" runat="server" ForeColor="Red" Text="*"></asp:Label>
                                                TipoFactor:</td>
                                            <td>
                                                <asp:DropDownList ID="ddlTipoFactor" runat="server" AutoPostBack="True" onselectedindexchanged="ddlTipoFactor_SelectedIndexChanged" CssClass="form-control2">
                                                    <asp:ListItem Value="Tasa">Tasa</asp:ListItem>
                                                    <%--<asp:ListItem Value="Cuota">Cuota</asp:ListItem>--%>
                                                    <asp:ListItem Value="Exento">Exento</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style127" style="text-align: right">
                                                <asp:Label ID="Label3" runat="server" ForeColor="Red" Text="*"></asp:Label>
                                                Impuesto: </td>
                                            <td class="style125">
                                                <asp:DropDownList ID="ddlImpuesto" runat="server" AutoPostBack="True" onselectedindexchanged="ddlImpuesto_SelectedIndexChanged" CssClass="form-control2">
                                                    <asp:ListItem Value="002">IVA</asp:ListItem>
                                                    <asp:ListItem Value="001">ISR</asp:ListItem>
                                                    <asp:ListItem Value="003">IEPS</asp:ListItem>
                                                </asp:DropDownList>
                                                <br />
                                            </td>
                                            <td style="text-align: right">
                                                <asp:Label ID="Label8" runat="server" ForeColor="Red" Text="*"></asp:Label>
                                                TasaOCuota:</td>
                                            <td class="style5">
                                                <asp:TextBox ID="txtTasa" runat="server" CssClass="form-control2"></asp:TextBox>
                                                <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender3" runat="server" FilterType="Numbers, Custom" TargetControlID="txtTasa" ValidChars="." />
                                                <asp:DropDownList ID="ddlTasaOCuota" runat="server" DataTextField="Maximo" DataValueField="Maximo" CssClass="form-control2">
                                                </asp:DropDownList>
                                                <br />
                                            </td>
                                            <td style="text-align: right"></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="LblAux" runat="server" ForeColor="Red" Text="*" />
                                            </td>
                                            <td colspan="3" style="text-align: right">
                                                <asp:Button ID="btnAgregarImpuesto" runat="server" class="btn btn-primary" onclick="btnAgregarImpuesto_Click" Text="Agregar Impuesto" ValidationGroup="AgregarImpuesto" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="5">
                                                <asp:GridView ID="gvImpuestos" runat="server" AutoGenerateColumns="False" CssClass="style124" onrowcommand="gvImpuestos_RowCommand" ShowHeaderWhenEmpty="True" Width="100%">
                                                    <Columns>
                                                        <asp:BoundField DataField="ConceptoClaveProdServ" HeaderText="Partida" ItemStyle-HorizontalAlign="Center" />
                                                        <asp:BoundField DataField="TipoImpuesto" HeaderText="TipoImpuesto" ItemStyle-HorizontalAlign="Center" />
                                                        <asp:BoundField DataField="Impuesto" HeaderText="Impuesto" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="10%" />
                                                        <asp:BoundField DataField="Base" HeaderText="Base" ItemStyle-HorizontalAlign="Center" />
                                                        <asp:BoundField DataField="TasaOCuota" HeaderText="TasaOCuota" ItemStyle-HorizontalAlign="Center" />
                                                        <asp:BoundField DataField="Importe" DataFormatString="${0:#,#.######}" HeaderText="Importe" ItemStyle-HorizontalAlign="Center" />
                                                        <asp:BoundField DataField="TipoFactor" HeaderText="TipoFactor" ItemStyle-HorizontalAlign="Center" />
                                                        <asp:ButtonField CommandName="EliminarImpuesto" ItemStyle-HorizontalAlign="Center" Text="Eliminar" Visible="False" />
                                                    </Columns>
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
            </div>
            <br />
            <asp:UpdateProgress AssociatedUpdatePanelID="up1" ID="UpdateProgress1"  runat="server">
			<ProgressTemplate>
                    <div align="center">
                        <asp:Image ID="Image1" ImageUrl="images/ajax-loader.gif" runat="server" />
                        <br />
                        CFDI en proceso ..
                    </div>
                </ProgressTemplate>
			</asp:UpdateProgress>

            <asp:Label ID="lblError" runat="server" ForeColor="Red" />
            <div style="float: right">
                <table style="text-align: right;">
                    <tr style="width: 150px">
                        <td>Subtotal: </td>
                        <td>
                            <asp:Label ID="lblSubtotal" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>Retenciones </td>
                        <td>
                            <asp:Label ID="lblRetenciones" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>Traslados </td>
                        <td>
                            <asp:Label ID="lblTraslados" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>Descuento </td>
                        <td>
                            <asp:Label ID="lblDescuento" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>Total </td>
                        <td>
                            <asp:Label ID="lblTotal" runat="server" />
                        </td>
                    </tr>
                </table>
            </div>
            <div style="clear: both">
            </div>
            <p align="right">
                <asp:Button ID="btnLimpiar" runat="server" class="btn btn-primary" OnClick="btnLimpiar_Click" Text="Limpiar" Width="70px" />
                &nbsp;&nbsp;&nbsp;
                <asp:Button ID="BtnVistaPrevia" runat="server" class="btn btn-primary" OnClick="btnGenerarPreview_Click" Text="Vista Previa" ValidationGroup="CrearFactura" />
                &nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnGenerarFactura" runat="server" class="btn btn-primary" OnClick="btnGenerarFactura_Click" Text="Generar Factura" ValidationGroup="CrearFactura"  UseSubmitBehavior="false"
      OnClientClick="this.disabled='true';" />
                <asp:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" ConfirmText="Confirma que deseas generar el comprobante" TargetControlID="btnGenerarFactura" />
            </p>
            <br />
            <asp:ModalPopupExtender ID="mpeBuscarConceptos" runat="server" BackgroundCssClass="mpeBack" CancelControlID="btnCerrarConcepto" PopupControlID="pnlBuscarConceptos" TargetControlID="btnConceptoDummy" />
            <asp:Panel ID="pnlBuscarConceptos" runat="server" BackColor="White" CssClass="page3" Style="text-align: center;" Width="800px">
                <h1 class="style155">Buscar Conceptos</h1>
                <p>
                    <asp:TextBox ID="txtConceptoBusqueda" runat="server" Width="250px" />
                    &nbsp;&nbsp;&nbsp;
                    <asp:Button ID="btnBuscarConcepto" runat="server" class="btn btn-primary" OnClick="btnBuscarConcepto_Click" Text="Buscar" />
                </p>
                <br />
                <div style="height: 400px;, overflow-y: scroll">
                    <asp:Label ID="lblMensaje" runat="server" ForeColor="Red" />
                    <asp:GridView ID="gvBuscarConceptos" runat="server" AutoGenerateColumns="False" DataKeyNames="c_ClaveProdServ1" OnRowCommand="gvBuscarConceptos_RowCommand" ShowHeaderWhenEmpty="True" Width="100%">
                        <Columns>
                            <asp:BoundField DataField="c_ClaveProdServ1" HeaderText="Código" />
                            <asp:BoundField DataField="Descripcion" HeaderText="Descripción" />
                            <asp:ButtonField CommandName="Seleccionar" Text="Seleccionar" />
                        </Columns>
                    </asp:GridView>
                </div>
                <br />
                <%--<asp:Button runat="server" ID="btnSeleccionarConcepto" Text="Seleccionar" onclick="btnSeleccionarConcepto_Click" />&nbsp;&nbsp;--%>
                <asp:Button ID="btnCerrarConcepto" runat="server" class="btn btn-primary" Text="Cancelar" />
            </asp:Panel>
            <asp:Button ID="btnConceptoDummy" runat="server" Style="display: none;" />
            <asp:ModalPopupExtender ID="mpeEdita" runat="server" BackgroundCssClass="mpeBack" CancelControlID="btnCancelar" PopupControlID="panelEditaConcepto" TargetControlID="btnEditarDummy" />
            <asp:Panel ID="panelEditaConcepto" runat="server" BackColor="White" CssClass="page3" Style="text-align: center;" Width="800px">
                <h1>
                    <asp:Label ID="lblConcepto" runat="server" style="color: #2D5C94">Editar Concepto</asp:Label>
                </h1>
                <table class="linea" width="600px">
                    <tr>
                        <td>ClaveUnidad:</td>
                        <td align="left">
                            <cc1:DropDownListChosen ID="ddlClaveUnidadE" runat="server" AllowSingleDeselect="true" CausesValidation="false" DataPlaceHolder="Escriba aquí..." Height="16px" NoResultsText="No hay resultados coincidentes." SelectMethod="" width="206px">
                            </cc1:DropDownListChosen>
                        </td>
                    </tr>
                    <tr>
                        <td>Código:</td>
                        <td align="left">
                            <asp:TextBox ID="txtCodigoE" runat="server" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtCodigoE" Display="Dynamic" ErrorMessage="* Requerido" ValidationGroup="Concepto" />
                        </td>
                    </tr>
                    <tr>
                        <td>Cantidad: </td>
                        <td align="left">
                            <asp:TextBox ID="txtCantidadEdita" runat="server" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtCantidadEdita" Display="Dynamic" ErrorMessage="* Requerido" ValidationGroup="Concepto" />
                            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="txtCantidadEdita" Display="Dynamic" ErrorMessage="* Cantidad Invalida" Operator="DataTypeCheck" Type="Double" ValidationGroup="Concepto" />
                            <asp:HiddenField ID="hidDetalle" runat="server" />
                            <asp:HiddenField ID="hidNumero" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>Unidad de Medida: </td>
                        <td align="left">
                            <asp:TextBox ID="txtUnidadEdita" runat="server" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtUnidadEdita" Display="Dynamic" ErrorMessage="* Requerido" ValidationGroup="Concepto" />
                        </td>
                    </tr>
                    <tr>
                        <td>N° de identificación: </td>
                        <td align="left">
                            <asp:TextBox ID="txtNoIdentificacionEdita" runat="server" Width="400px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>Descripción: </td>
                        <td align="left">
                            <asp:TextBox ID="txtDescripcionEdita" runat="server" Width="400px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtDescripcionEdita" Display="Dynamic" ErrorMessage="* Requerido" ValidationGroup="Concepto" />
                        </td>
                    </tr>
                    <tr>
                        <td>Observaciones: </td>
                        <td align="left">
                            <asp:TextBox ID="txtObservacionesEdita" runat="server" Width="400px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>Precio Unitario: </td>
                        <td align="left">
                            <asp:TextBox ID="txtPrecioUnitarioEdita" runat="server"></asp:TextBox>
                            <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="txtPrecioUnitarioEdita" Display="Dynamic" ErrorMessage="* Cantidad Invalida" Operator="DataTypeCheck" Type="Double" ValidationGroup="Concepto" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtPrecioUnitarioEdita" Display="Dynamic" ErrorMessage="* Requerido" ValidationGroup="Concepto" />
                        </td>
                    </tr>
                    <tr>
                        <td>Descuento:</td>
                        <td style="text-align: left;">
                            <asp:TextBox ID="txtDescuentoE" runat="server" Width="106px" />
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>Cuenta Predial:</td>
                        <td style="text-align: left;">
                            <asp:TextBox ID="txtCuentaPredialE" runat="server" Width="106px" />
                            &nbsp;</td>
                    </tr>
                </table>
                <br />
                <div align="right">
                    <asp:Button ID="btnGuardar" runat="server" class="btn btn-primary" OnClick="btnGuardar_Click" Text="Guardar" ValidationGroup="Concepto" />
                    &nbsp;&nbsp;&nbsp;
                    <asp:Button ID="btnCancelar" runat="server" CausesValidation="False" class="btn btn-primary" Text="Cancelar" />
                </div>
            </asp:Panel>
            <asp:Button ID="btnEditarDummy" runat="server" class="btn btn-primary" Style="display: none;" />
            <asp:ModalPopupExtender ID="mpeBuscarConceptoHistorico" runat="server" BackgroundCssClass="mpeBack" CancelControlID="btnCerrarConceptoHistorico" PopupControlID="pnlBuscarConceptoHistorico" TargetControlID="btnConceptoHistoricoDummy" />
            <asp:Panel ID="pnlBuscarConceptoHistorico" runat="server" BackColor="White" CssClass="page3" style="text-align: center;" Width="800px">
                <h1 class="style155">Buscar Conceptos Historico</h1>
                <p>
                    <asp:TextBox ID="txtConceptoHistoricoBusqueda" runat="server" Width="250px" />
                    &nbsp;&nbsp;&nbsp;
                    <asp:Button ID="btnBuscarConceptoHistorico" runat="server" class="btn btn-primary" onclick="btnBuscarConceptoHistorico_Click" Text="Buscar" />
                </p>
                <div style="height: 400px; overflow-y: scroll">
                    <asp:Label ID="lblMensajeHistorico" runat="server" ForeColor="Red" />
                    <asp:GridView ID="gvBuscarConceptosHistorico" runat="server" AutoGenerateColumns="False" DataKeyNames="IdProducto" onrowcommand="gvBuscarConceptosHistorico_RowCommand" ShowHeaderWhenEmpty="True" Width="100%">
                        <Columns>
                            <asp:BoundField DataField="Codigo" HeaderText="Código" />
                            <asp:BoundField DataField="Descripcion" HeaderText="Descripción" />
                            <asp:BoundField DataField="Observaciones" HeaderText="Observaciones" />
                            <asp:BoundField DataField="PrecioP" DataFormatString="{0:C}" HeaderText="Precio" />
                            <asp:ButtonField CommandName="Seleccionar" Text="Seleccionar" />
                        </Columns>
                    </asp:GridView>
                </div>
                <br />
                <%--<asp:Button runat="server" ID="btnSeleccionarConcepto" Text="Seleccionar" onclick="btnSeleccionarConcepto_Click" />&nbsp;&nbsp;--%>
                <asp:Button ID="btnCerrarConceptoHistorico" runat="server" class="btn btn-primary" Text="Cancelar" />
            </asp:Panel>
            <asp:Button ID="btnConceptoHistoricoDummy" runat="server" style="display: none;" />




             <asp:ModalPopupExtender runat="server" ID="mpeSellos" TargetControlID="btnSelloDummy"
        BackgroundCssClass="mpeBack"  PopupControlID="pnlSello" />
    <asp:Panel runat="server" ID="pnlSello" Style="text-align: center;"  CssClass="page7"
        BackColor="#A8CF38" Height="165px" Width="418px">
        <br />
        <asp:Label runat="server" ID="Label5" Text="¡Importante!" Visible="True" class="style161" style="color: #000000"/>
        <br />
        <asp:Label runat="server" ID="LblDiasSello" Text="Su sello caduca en x dias" Visible="True" class="style161" style="color: #000000" Height="50px"/>
        <br />
        <asp:Label runat="server" ID="lblpop" Text="Seleccione otra empresa" Visible="false" class="style161" style="color: #000000"/>
        <br />
        <asp:DropDownList runat="server" ID="ddlEmpresaE" AutoPostBack="false" CssClass="page5"
            DataTextField="RazonSocial" DataValueField="idEmpresa" OnSelectedIndexChanged="ddlEmpresa_SelectedIndexChanged" Visible="false"/>
        <br />
        <br />
        <asp:Button runat="server" ID="btclose" Text="Aceptar"  class="btn btn-primary"  OnClick="btclose_Click"/>
    </asp:Panel>
    <asp:Button runat="server" ID="btnSelloDummy" Style="display: none;" />



            <asp:ModalPopupExtender ID="mpeCFDIG" runat="server" BackgroundCssClass="mpeBack" PopupControlID="pnlMSG" TargetControlID="btngenerarDummy" />
            <asp:Panel ID="pnlMSG" runat="server" BackColor="#A8CF38" CssClass="page7" Height="98px" Style="text-align: center;" Width="418px">
                <h1 class="style161" style="color: #000000"><strong>Comprobante generado correctamente y enviado por correo electrónico</strong>
                  <asp:LinkButton ID="LinkButton1" runat="server" ForeColor="#FF3300" 
                onclick="LinkButton1_Click">Descargar PDF</asp:LinkButton>
                </h1>
                <br />
                <%--<asp:Button runat="server" ID="btnSeleccionarConcepto" Text="Seleccionar" onclick="btnSeleccionarConcepto_Click" />&nbsp;&nbsp;--%>
                <asp:Button ID="btnCerrar" runat="server" class="btn btn-primary" OnClick="btnCerrar_Click" Text="Aceptar" />
            </asp:Panel>
            <asp:Button ID="btngenerarDummy" runat="server" Style="display: none;" />
           

     </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnLimpiar" />
                        <asp:PostBackTrigger ControlID="BtnVistaPrevia" />
        </Triggers>
    </asp:UpdatePanel>
    
    
    
</asp:Content>
