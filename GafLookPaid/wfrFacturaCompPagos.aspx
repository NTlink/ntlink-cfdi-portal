<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"  CodeBehind="wfrFacturaCompPagos.aspx.cs" Inherits="GafLookPaid.wfrFacturaCompPagos" %>
    <%@ Register TagPrefix="cc1" Namespace="WebControls.FilteredDropDownList" Assembly="WebControls.FilteredDropDownList" %>
     <%@ Register Assembly="DropDownChosen" Namespace="CustomDropDown" TagPrefix="cc1" %>


 <%@ MasterType VirtualPath="~/Site.Master" %>
 <%@ Register Src="~/controles/Impuestos.ascx" TagPrefix="uc" TagName="UCImpuestos" %>

<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .text-right
        {
            text-align: right;
        }
        .style125
        {
            text-align: right;
            width: 114px;
        }
        .style126
        {
            width: 127px;
        }
        .style127
        {
            text-align: right;
            width: 115px;
        }
        .style128
        {
            text-align: right;
            width: 116px;
        }
        .style129
        {
            text-align: right;
            width: 127px;
        }
        .auto-style1 {
            width: 80px;
        }
        .auto-style2 {
            width: 87px;
        }
        .auto-style3 {
            width: 148px;
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
        .style130
        {
            width: 127px;
            color: #FF0000;
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
    <script type="text/javascript" language="javascript">

   Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(BeginRequestHandler);
   function BeginRequestHandler(sender, args) { var oControl = args.get_postBackElement(); oControl.disabled = true; }

</script>
     
 


<script type="text/javascript">
 
    //localizar timers
    var iddleTimeoutWarning = null;
    var iddleTimeout = null;
 
    //esta funcion automaticamente sera llamada por ASP.NET AJAX cuando la pagina cargue y un postback parcial complete
    function pageLoad() {
 

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
                </caption>
                <caption>
                    <h1 class="style156">Generar Complemento de Pagos</h1>
                    </tr>
                    <MARQUEE>  
                        <asp:HyperLink ID="HyperLink4" runat="server" CssClass="style130" 
                             
                            onclick="javascript: window.open('http://ntlink2.com.mx/ajax/Manual%20CFDI%20Complemento%20de%20Pagos.pdf', '', 'width=600,height=600,left=50,top=50,toolbar=yes');">¿Tienes dudas? consulta el manual de llenado dando click aqui</asp:HyperLink>
                   </MARQUEE>
                    
                    <tr>
                        <td></td>
                        <td align="left" class="style159">
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
                            <cc1:DropDownListChosen ID="ddlClientes" runat="server" AllowSingleDeselect="true" AutoPostBack="True" CausesValidation="false" CssClass="page" DataPlaceHolder="Seleccione" DataTextField="RazonSocial" DataValueField="idCliente" Height="16px" NoResultsText="No hay resultados coincidentes." OnSelectedIndexChanged="ddlClientes_SelectedIndexChanged" SelectMethod="" Width="197px" AppendDataBoundItems="True">
                            </cc1:DropDownListChosen>
                        </td>
                        <td>
                            <asp:TextBox ID="txtRazonSocial" runat="server" CssClass="page" Enabled="true" Height="33px" TextMode="MultiLine" Width="341px" />
                        </td>
                    </tr>
                </caption>
                 <caption>
                     <br />
                 </caption>
    </table>
    <br />
            <table class="table-bordered">
            <tr>
            <td class="style129" style="text-align: right"><strong><span class="style155" 
                    style="color: #0000FF">Folio NTLINK:</span> </strong></td>
                    <td><asp:TextBox runat="server" ID="txtFolio" CssClass="form-control2"  Enabled="False" /> </td>
          
                    <td style="text-align: right; font-weight: 700;" class="style141">
                        Serie:
                    </td>
                    <tD>
                        <asp:TextBox runat="server" ID="txtSerie" CssClass="form-control2" />
                    </td>
                    <td>
                        <strong>Folio: </strong>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtFolioSat" CssClass="form-control2"  />
                    </td>
                     <td style="text-align: right; font-weight: 700;" class="style141">
                        Sucursal
                    </td>
                    <td>
                        <asp:DropDownList runat="server" ID="ddlSucursales" AppendDataBoundItems="True" DataValueField="LugarExpedicion"
                            DataTextField="Nombre" CssClass="form-control2"  />
                    </td>
                  </tr>

                <tr>

                    <td>Observaciones: </td>
                    <td>
                        <asp:TextBox ID="txtProyecto" runat="server" CssClass="form-control2" TextMode="MultiLine" Height="16px" Width="182px" />
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
                <tr runat="server" visible="false">
                   <td style="text-align: right; font-weight: 700;" class="style126">
                        Tipo de Documento:</td>
                    <td >
                        <asp:DropDownList runat="server" ID="ddlTipoDocumento" AutoPostBack="True" Enabled="false"
                            OnSelectedIndexChanged="ddlTipoDocumento_SelectedIndexChanged" CssClass="form-control2">
                            <asp:ListItem Text="Pago" Value="Pago" ></asp:ListItem>
                        </asp:DropDownList>
                          
                    </td>
                    <td style="text-align: right; font-weight: 700;" class="style144">
                        Status Factura:
                    </td>
                    <td>
                        <asp:DropDownList runat="server" ID="ddlStatusFactura" AutoPostBack="true" OnSelectedIndexChanged="ddlStatusFactura_SelectedIndexChanged" CssClass="form-control2" Enabled="false">
                            <asp:ListItem Value="0" Text="Pendiente"></asp:ListItem>
                            <asp:ListItem Value="1" Text="Pagada" Selected="True"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td style="text-align: right; font-weight: 700;">
                        <asp:Label runat="server" ID="lblFechaPago" Text="Fecha de Pago:"/>
                        </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtFechaPago" CssClass="form-control2"  Visible="True" 
                            ontextchanged="txtFechaPago_TextChanged"/>
                        <asp:CompareValidator runat="server" ID="cvFechaInicial" ControlToValidate="txtFechaPago"
                            Display="Dynamic" ErrorMessage="* Fecha Invalida" Operator="DataTypeCheck" Type="Date" />
                        <asp:CalendarExtender runat="server" ID="ceFechaInicial" Animated="False" PopupButtonID="txtFechaPago"
                            TargetControlID="txtFechaPago" Format="dd/MM/yyyy" />
                    </td>
                 
                </tr>
                
                <tr runat="server" visible="false">
               <td style="text-align: right" class="style126">
                        <asp:Label runat="server" ID="LblConfirmacion" Text="Confirmación:" 
                            Visible="False" style="font-weight: 700" />
                    </td>
                    <td class="style146">
                    <asp:TextBox ID="txtConfirmacion" runat="server" CssClass="form-control2" visible="false"/>
                    </td>
                     <td style="text-align: right; font-weight: 700;" class="style144">
                        Moneda:
                    </td>
                    <td class="style147">

                        <cc1:DropDownListChosen ID="ddlMoneda" runat="server"  CausesValidation="false" 
            NoResultsText="No hay resultados coincidentes." Width="213px" Height="18px"   SelectMethod=""  OnSelectedIndexChanged="ddlMoneda_SelectedIndexChanged"        
            DataPlaceHolder="Escriba aquí..." AllowSingleDeselect="true" AutoPostBack="True" Enabled="false" 
                            >                
        </cc1:DropDownListChosen>
                    </td>
                    <td style="text-align: right">
                        <asp:Label runat="server" ID="lblTipoCambio" Text="Tipo Cambio:" 
                            Visible="False" style="font-weight: 700" />
                    </td>
                    <td class="style146">
                        <asp:TextBox runat="server" ID="txtTipoCambio" Width="210px" Visible="False" />
                    </td>
                  
                </tr>
          
            
                <tr runat="server" id="trDonativo" visible="False">
                    <td class="style126" style="text-align: right; font-weight: 700;" >
                        <strong>N. de </strong>autorización del Donativo:
                    </td>
                    <td class="style146">    <asp:TextBox runat="server" ID="txtDonatAutorizacion" Width="210px" ></asp:TextBox>
                    
                    </td>
                    <td class="style9" >
                        Fecha de <strong>autorización </strong>del donativo:
                        </td>
                    <td class="style147">
                        <asp:TextBox ID="txtDonatFechautorizacion" runat="server" Width="210px" ></asp:TextBox>
                        <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" 
                            PopupButtonID="txtDonatFechautorizacion" 
                            TargetControlID="txtDonatFechautorizacion" />
                    </td>
                </tr>
               
                <tr runat="server" visible="false">
			<td style="text-align: right; vertical-align:top; font-weight: 700;" class="style126">
				Forma de Pago
			</td>
			
                 <td class="style146">
       
       <asp:DropDownList runat="server" ID="ddlFormaPago" AutoPostBack="True" 
                         OnSelectedIndexChanged="ddlFormaPago_SelectedIndexChanged" 
                         style="margin-left: 0px" Width="213px" Height="18px" Enabled="false">
   <asp:ListItem runat="server" Value="00" Text="Seleccionar"></asp:ListItem>
   <asp:ListItem runat="server" Value="01" Text="Efectivo"></asp:ListItem>
<asp:ListItem runat="server" Value="02" Text="Cheque nominativo"></asp:ListItem>
<asp:ListItem runat="server" Value="03" Text="Transferencia electrónica de fondos"></asp:ListItem>
<asp:ListItem runat="server" Value="04" Text="Tarjeta de crédito"></asp:ListItem>
<asp:ListItem runat="server" Value="05" Text="Monedero electrónico"></asp:ListItem>
<asp:ListItem runat="server" Value="06" Text="Dinero electrónico"></asp:ListItem>
<asp:ListItem runat="server" Value="08" Text="Vales de despensa"></asp:ListItem>
<asp:ListItem runat="server" Value="12" Text="Dación en pago"></asp:ListItem>
<asp:ListItem runat="server" Value="13" Text="Pago por subrogación"></asp:ListItem>
<asp:ListItem runat="server" Value="14" Text="Pago por consignación"></asp:ListItem>
<asp:ListItem runat="server" Value="15" Text="Condonación"></asp:ListItem>
<asp:ListItem runat="server" Value="17" Text="Compensación"></asp:ListItem>
<asp:ListItem runat="server" Value="23" Text="Novación"></asp:ListItem>
<asp:ListItem runat="server" Value="24" Text="Confusión"	></asp:ListItem>
<asp:ListItem runat="server" Value="25" Text="Remisión de deuda"></asp:ListItem>
<asp:ListItem runat="server" Value="26" Text="Prescripción o caducidad"></asp:ListItem>
<asp:ListItem runat="server" Value="27" Text="A satisfacción del acreedor"></asp:ListItem>
<asp:ListItem runat="server" Value="28" Text="Tarjeta de débito"></asp:ListItem>
<asp:ListItem runat="server" Value="29" Text="Tarjeta de servicios"></asp:ListItem>
<asp:ListItem runat="server" Value="30" Text="Aplicación de anticipos"></asp:ListItem>
<asp:ListItem runat="server" Value="31" Text="Intermediario pagos"></asp:ListItem>

<asp:ListItem runat="server" Value="99" Text="Por definir"></asp:ListItem>
 </asp:DropDownList>

			</td>
			
			<td class="style144">
                        <strong>Método de Pago </strong>
                    </td>
                    <td class="style147">
                        <asp:DropDownList runat="server" ID="ddlMetodoPago" AutoPostBack="True" OnSelectedIndexChanged="ddlMetodoPago_SelectedIndexChanged" Width="213px" Height="18px" Enabled="false">
                         <asp:ListItem runat="server" Value="00" Text="Seleccionar"></asp:ListItem>
                           <asp:ListItem runat="server" Text="Pago en una sola exhibición" Value="PUE"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Pago en parcialidades o diferido" Value="PPD"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
			 <td style="text-align: right; font-weight: 700;">Condiciones de Pago</td>
         <td class="style146"><asp:TextBox ID="txtCondicionesPago" runat="server" 
                 Width="210px" ></asp:TextBox></td>
		</tr>
         
         <tr>
        
         <td class="style126"></td>
         <td class="style146"></td>
         
         </tr>
                <tr runat="server" visible="false">
                    
                    <td style="text-align: right" class="style126">
                        <strong>UsoCFDI</strong></td>
                    <td class="style146">
                        <asp:DropDownList ID="ddlUsoCFDI" runat="server" AutoPostBack="True" 
                           Width="213px" Height="18px" Enabled="false">
                         <asp:ListItem runat="server"  Value="G01" Text="Adquisición de mercancias" ></asp:ListItem>
                         <asp:ListItem runat="server"  Value="G02" Text="Devoluciones, descuentos o bonificaciones" ></asp:ListItem>
                         <asp:ListItem runat="server"  Value="G03" Text="Gastos en general" ></asp:ListItem>
                         <asp:ListItem runat="server"  Value="I01" Text="Construcciones" ></asp:ListItem>
                         <asp:ListItem runat="server"  Value="I02" Text="Mobilario y equipo de oficina por inversiones" ></asp:ListItem>
                         <asp:ListItem runat="server"  Value="I03" Text="Equipo de transporte" ></asp:ListItem>
                         <asp:ListItem runat="server"  Value="I04" Text="Equipo de computo y accesorios" ></asp:ListItem>
<asp:ListItem runat="server"  Value="I05" Text="Dados, troqueles, moldes, matrices y herramental" ></asp:ListItem>
<asp:ListItem runat="server"  Value="I06" Text="Comunicaciones telefónicas" ></asp:ListItem>
<asp:ListItem runat="server"  Value="I07" Text="Comunicaciones satelitales" ></asp:ListItem>
<asp:ListItem runat="server"  Value="I08" Text="Otra maquinaria y equipo" ></asp:ListItem>
<asp:ListItem runat="server"  Value="D01" Text="Honorarios médicos, dentales y gastos hospitalarios." ></asp:ListItem>
<asp:ListItem runat="server"  Value="D02" Text="Gastos médicos por incapacidad o discapacidad" ></asp:ListItem>
<asp:ListItem runat="server"  Value="D03" Text="Gastos funerales." ></asp:ListItem>
<asp:ListItem runat="server"  Value="D04" Text="Donativos." ></asp:ListItem>
<asp:ListItem runat="server"  Value="D05" Text="Intereses reales efectivamente pagados por créditos hipotecarios (casa habitación)." ></asp:ListItem>
<asp:ListItem runat="server"  Value="D06" Text="Aportaciones voluntarias al SAR." ></asp:ListItem>
<asp:ListItem runat="server"  Value="D07" Text="Primas por seguros de gastos médicos." ></asp:ListItem>
<asp:ListItem runat="server"  Value="D08" Text="Gastos de transportación escolar obligatoria." ></asp:ListItem>
<asp:ListItem runat="server"  Value="D09" Text="Depósitos en cuentas para el ahorro, primas que tengan como base planes de pensiones." ></asp:ListItem>
<asp:ListItem runat="server"  Value="D10" Text="Pagos por servicios educativos (colegiaturas)" ></asp:ListItem>
<asp:ListItem runat="server"  Value="P01" Text="Por definir" Selected="True"></asp:ListItem> 
  </asp:DropDownList>
                    </td>
                 
                </tr>
            </table>

            <table width="100%">
             <tr>
                    <td>
                        <asp:Panel ID="Panel4" runat="server"  CssClass="page3" BorderStyle="Double" HorizontalAlign="Left" Width="100%" > 
		
       
          <div id="DivComplementoPagos"  style="width:100%" runat="server" >
         <table class="table-hover" width="100%">
<tr>
<td>

<asp:Label ID="Label6" runat="server" Text="Complemento" Font-Bold="True"  style="font-size: medium"></asp:Label>
   </td>
</tr>
<tr>
<td style="text-align: right">
    <asp:Label ID="Label15" runat="server" ForeColor="Red" Text="*"></asp:Label>
    FechaPago:</td>
<td>  <asp:TextBox ID="txtFechaPagoP" runat="server" CssClass="form-control2"></asp:TextBox>
                        <asp:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" 
                            PopupButtonID="txtFechaPagoP" 
                            TargetControlID="txtFechaPagoP" />
                   
<asp:RequiredFieldValidator runat="server" CssClass="alert-error"
                         ID="RequiredFieldValidator9" ControlToValidate="txtFechaPagoP"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                         ValidationGroup="btnAgregarPagos" style="font-size: medium" />
</td>
<td class="text-right">
    <asp:Label ID="Label16" runat="server" ForeColor="Red" Text="*"></asp:Label>
    FormaDePagoP:</td>
<td class="auto-style3">

<asp:DropDownList runat="server" ID="ddlFormaPagoP" AutoPostBack="True" 
                         OnSelectedIndexChanged="ddlFormaPagoP_SelectedIndexChanged" 
                         style="margin-left: 0px" CssClass="form-control2">
   <asp:ListItem runat="server" Value="01" Text="Efectivo"></asp:ListItem>
<asp:ListItem runat="server" Value="02" Text="Cheque nominativo"></asp:ListItem>
<asp:ListItem runat="server" Value="03" Text="Transferencia electrónica de fondos"></asp:ListItem>
<asp:ListItem runat="server" Value="04" Text="Tarjeta de crédito"></asp:ListItem>
<asp:ListItem runat="server" Value="05" Text="Monedero electrónico"></asp:ListItem>
<asp:ListItem runat="server" Value="06" Text="Dinero electrónico"></asp:ListItem>
<asp:ListItem runat="server" Value="08" Text="Vales de despensa"></asp:ListItem>
<asp:ListItem runat="server" Value="12" Text="Dación en pago"></asp:ListItem>
<asp:ListItem runat="server" Value="13" Text="Pago por subrogación"></asp:ListItem>
<asp:ListItem runat="server" Value="14" Text="Pago por consignación"></asp:ListItem>
<asp:ListItem runat="server" Value="15" Text="Condonación"></asp:ListItem>
<asp:ListItem runat="server" Value="17" Text="Compensación"></asp:ListItem>
<asp:ListItem runat="server" Value="23" Text="Novación"></asp:ListItem>
<asp:ListItem runat="server" Value="24" Text="Confusión"	></asp:ListItem>
<asp:ListItem runat="server" Value="25" Text="Remisión de deuda"></asp:ListItem>
<asp:ListItem runat="server" Value="26" Text="Prescripción o caducidad"></asp:ListItem>
<asp:ListItem runat="server" Value="27" Text="A satisfacción del acreedor"></asp:ListItem>
<asp:ListItem runat="server" Value="28" Text="Tarjeta de débito"></asp:ListItem>
<asp:ListItem runat="server" Value="29" Text="Tarjeta de servicios"></asp:ListItem>
<asp:ListItem runat="server" Value="30" Text="Aplicación de anticipos"></asp:ListItem>
<asp:ListItem runat="server" Value="31" Text="Intermediario pagos"></asp:ListItem>
<asp:ListItem runat="server" Value="99" Text="Por definir"></asp:ListItem>
 </asp:DropDownList>

    <asp:RequiredFieldValidator runat="server" CssClass="alert-error"
                         ID="RequiredFieldValidator10" ControlToValidate="ddlFormaPagoP"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                         ValidationGroup="btnAgregarPagos" style="font-size: medium" />
</td>

</td>

</tr>
<tr>

<td class="text-right">
    <asp:Label ID="Label18" runat="server" ForeColor="Red" Text="*"></asp:Label>
    Monto:</td>
<td>
    <asp:TextBox ID="txtMonto" runat="server"  CssClass="form-control2" AutoPostBack="True" OnTextChanged="txtMonto_TextChanged"></asp:TextBox>
<asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator12" ControlToValidate="txtMonto" CssClass="alert-error"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                         ValidationGroup="btnAgregarPagos" 
                         style="color: #FF0000; font-size: medium;" />
    <asp:CompareValidator runat="server" ID="CompareValidator3" ControlToValidate="txtMonto"
                            Display="Dynamic" ErrorMessage="* Precio invalido" Type="Double" Operator="DataTypeCheck"
                            ValidationGroup="btnAgregarPagos" 
                         style="color: #FF0000; font-size: medium;" />
    
</td>

<td class="text-right">
    <asp:Label ID="Label17" runat="server" ForeColor="Red" Text="*"></asp:Label>
    MonedaP:</td>
<td>
 <cc1:DropDownListChosen ID="ddlMonedaP" runat="server"  CausesValidation="false" 
            NoResultsText="No hay resultados coincidentes." CssClass="form-control2"  Width="150px"  SelectMethod=""  OnSelectedIndexChanged="ddlMonedaP_SelectedIndexChanged"        
            DataPlaceHolder="Escriba aquí..." AllowSingleDeselect="true" AutoPostBack="True" 
                           >                
        </cc1:DropDownListChosen>

    <asp:RequiredFieldValidator runat="server" CssClass="alert-error"
                         ID="RequiredFieldValidator11" ControlToValidate="ddlMonedaP"
                            Display="Dynamic" ErrorMessage="* *Requerido" 
                         ValidationGroup="btnAgregarPagos" style="font-size: medium" />

</td>
<td class="text-right"><asp:Label runat="server" ID="lblTipoCambioP" Text="Tipo Cambio:" 
                            Visible="False" /></td>
<td class="auto-style3">        <asp:TextBox runat="server" ID="txtTipoCambioP" CssClass="form-control2" Visible="False" />
                </td>

</tr>
                <tr>
                    <td colspan="3"><asp:Label ID="Label1" runat="server" Text="Datos Bancarios:" Font-Bold="True"  style="font-size: medium"></asp:Label> </td>

                </tr>

<tr>

<td class="text-right"><abbr title="Se puede registrar el número de cheque, numero de autorización,
numero de transferencia, línea de captura o algún número de referencia o identificación.">   NumOperacion:</abbr></td>
<td class="auto-style3">
    <asp:TextBox ID="txtNumOperacion" runat="server"  CssClass="form-control2"></asp:TextBox>
    </td>

<td class="text-right">
    RfcEmisorCtaOrd:</td>
<td>
         <asp:DropDownList runat="server" ID="ddlrfcemisor" 
                         style="margin-left: 0px" CssClass="form-control2" OnSelectedIndexChanged="ddlrfcemisor_SelectedIndexChanged1" AutoPostBack="True" Width="246px">
                         
              
             <asp:ListItem runat="server" Value="" Text="Seleccione" Selected="True"></asp:ListItem>
             <asp:ListItem runat="server" Value="BMN930209927" Text="BMN930209927 - BANORTE" ></asp:ListItem>
             <asp:ListItem runat="server" Value="BNM840515VB1" Text="BNM840515VB1 - BANAMEX"></asp:ListItem>
             <asp:ListItem runat="server" Value="BSM970519DU8" Text="BSM970519DU8 - SANTANDER"></asp:ListItem>
             <asp:ListItem runat="server" Value="BBA830831LJ2" Text="BBA830831LJ2 - BANCOMER"></asp:ListItem>
             <asp:ListItem runat="server" Value="HMI950125KG8" Text="HMI950125KG8 - HSBC"></asp:ListItem>
             <asp:ListItem runat="server" Value="SIN9412025I4" Text="SIN9412025I4 - SCOTIABANK"></asp:ListItem>
             <asp:ListItem runat="server" Value="00" Text="Otro"></asp:ListItem>

 </asp:DropDownList>
       <asp:TextBox ID="txtRfcEmisorCtaOrd" runat="server"  CssClass="form-control2" Visible="False" OnTextChanged="txtRfcEmisorCtaOrd_TextChanged"></asp:TextBox>
         
    

    </td>
<td class="text-right"><abbr title="Se puede registrar el nombre del banco ordenante, es requerido en caso de ser el extranjero.">   NomBancoOrdExt:</abbr></td>
<td>
    <asp:TextBox ID="txtNomBancoOrdExt" runat="server" CssClass="form-control2" Width="157px" AutoPostBack="True"></asp:TextBox>
    </td>

</tr>
<tr>
<td class="text-right">
    <abbr title="Se puede registrar el número de la cuenta con la que se realizó el pago.">CtaOrdenante:</abbr></td>
<td>
    <asp:TextBox ID="txtCtaOrdenante" runat="server" CssClass="form-control2" AutoPostBack="True"></asp:TextBox>
    </td>
<td class="text-right">RfcEmisorCtaBen:</td>
<td class="auto-style3">
    <asp:DropDownList runat="server" ID="ddlrfcben" 
                         style="margin-left: 0px" CssClass="form-control2" AutoPostBack="True" Width="246px" OnSelectedIndexChanged="ddlrfcben_SelectedIndexChanged">
                         
              
             <asp:ListItem runat="server" Value="" Text="Seleccione" Selected="True"></asp:ListItem>
             <asp:ListItem runat="server" Value="BMN930209927" Text="BMN930209927 - BANORTE" ></asp:ListItem>
             <asp:ListItem runat="server" Value="BNM840515VB1" Text="BNM840515VB1 - BANAMEX"></asp:ListItem>
             <asp:ListItem runat="server" Value="BSM970519DU8" Text="BSM970519DU8 - SANTANDER"></asp:ListItem>
             <asp:ListItem runat="server" Value="BBA830831LJ2" Text="BBA830831LJ2 - BANCOMER"></asp:ListItem>
             <asp:ListItem runat="server" Value="HMI950125KG8" Text="HMI950125KG8 - HSBC"></asp:ListItem>
             <asp:ListItem runat="server" Value="SIN9412025I4" Text="SIN9412025I4 - SCOTIABANK"></asp:ListItem>
             <asp:ListItem runat="server" Value="00" Text="Otro"></asp:ListItem>

 </asp:DropDownList>
    <asp:TextBox ID="txtRfcEmisorCtaBen" runat="server" CssClass="form-control2" Visible="False"
        ></asp:TextBox>
    </td>

<td class="text-right">
    <abbr title="Se puede registrar el número de cuenta en donde se recibió el pago.">   CtaBeneficiario: </abbr></td>
<td>
    <asp:TextBox ID="txtCtaBeneficiario" runat="server"  CssClass="form-control2"></asp:TextBox>
    </td>
<td class="text-right">TipoCadPago:</td>
<td>
     <asp:DropDownList runat="server" ID="ddlTipoCadPago" 
                         style="margin-left: 0px" CssClass="form-control2">
                         <asp:ListItem runat="server" Value="" Text=""></asp:ListItem>
   <asp:ListItem runat="server" Value="01" Text="SPEI"></asp:ListItem>

 </asp:DropDownList>
   
    <%--<asp:TextBox ID="txtTipoCadPago" runat="server"  CssClass="form-control2" Width="66px" 
        ></asp:TextBox>--%> 
    </td>

</tr>
<tr>
<td class="text-right"><abbr title="Es el certificado que corresponde al pago.">  CertPago: </abbr></td>
<td><asp:TextBox ID="txtCertPago" runat="server"  CssClass="form-control2"></asp:TextBox></td>
<td class="text-right">
<abbr title="Es la cadena original del comprobante de pago generado por la entidad emisora de la cuenta beneficiaria.">    CadPago:</abbr></td>
<td class="auto-style3"><asp:TextBox ID="txtCadPago" runat="server"  CssClass="form-control2"></asp:TextBox></td>

<td class="text-right"><abbr title="Es el sello digital que asocie al pago.">    SelloPago: </abbr></td>
<td><asp:TextBox ID="txtSelloPago" runat="server"  CssClass="form-control2"></asp:TextBox></td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td colspan="4" style="text-align: center">
<asp:Button runat="server" ID="btnAgregarPagos" Text="Agregar Pagos" 
        ValidationGroup="btnAgregarPagos"  class="btn btn-primary" 
        onclick="btnAgregarPagos_Click"/>
</td>
</tr>
<tr>
<td colspan="5">
    <asp:GridView runat="server" ID="gvPagos" AutoGenerateColumns="False" CssClass="style124"
			Width="100%" ShowHeaderWhenEmpty="True" onrowcommand="gvPagos_RowCommand" 
        onselectedindexchanged="gvPagos_SelectedIndexChanged">
			<Columns>
              	<asp:BoundField HeaderText="FechaPago" DataField="FechaPago"  ItemStyle-HorizontalAlign="Center" />
                <asp:BoundField HeaderText="FormaDePagoP" DataField="FormaDePagoP" ItemStyle-HorizontalAlign="Center"  />
				<asp:BoundField HeaderText="MonedaP" DataField="MonedaP" ItemStyle-HorizontalAlign="Center" />
				<asp:BoundField HeaderText="Monto" DataField="Monto"  ItemStyle-HorizontalAlign="Center" />
                <asp:BoundField HeaderText="NumOperacion" DataField="NumOperacion"  ItemStyle-HorizontalAlign="Center" />
               			
				<asp:ButtonField Text="Eliminar" CommandName="EliminarPago" Visible="False" ItemStyle-HorizontalAlign="Center" />
			</Columns>
		</asp:GridView></td>
</tr>
</table>
    
        
      </div>
      </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="Panel5" runat="server"  CssClass="page3" BorderStyle="Double" HorizontalAlign="Left" Width="100%" Visible="true" > 
         		<asp:CheckBox runat="server" ID="cbDoctoRelacionado" Text="DoctoRelacionado" 
                    AutoPostBack="True" oncheckedchanged="cbDoctoRelacionado_CheckedChanged" 
                    style="font-weight: 700" Visible="False"/>
                           
		
       
          <div id="DivDoctoRelacionado"  style="width:100%" runat="server" visible="true">
         <table class="table-hover" width="100%">
<tr>
<td colspan="3"  style="text-align: left; font-weight: 700;" >

<asp:Label ID="Label7" runat="server" Text="Documento Relacionado" Font-Bold="True"  style="font-size: medium"></asp:Label>
   </td>
</tr>
<tr>
<td class="text-right">
    <asp:Label ID="Label21" runat="server" ForeColor="Red" Text="*"></asp:Label>
    ID</td>
<td>
    <asp:DropDownList ID="ddlID" runat="server" AutoPostBack="True" CssClass="form-control2"
        onselectedindexchanged="ddlID_SelectedIndexChanged">
    </asp:DropDownList>
    </td>
    <td class="text-right">
    <asp:Label ID="Label20" runat="server" ForeColor="Red" Text="*"></asp:Label>
        Folio Fiscal:</td>
<td>
    <asp:TextBox ID="txtIdDocumento" runat="server" CssClass="form-control2" width="290px" MaxLength="36"></asp:TextBox>
    <asp:RequiredFieldValidator runat="server" CssClass="alert-error"
                         ID="RequiredFieldValidator17" ControlToValidate="txtIdDocumento"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                         ValidationGroup="AgregarDocumento" style="font-size: medium" />

      <input type="button" value="Consulta Reportes" onclick="javascript: window.open('wfrFacturasConsulta.aspx', '', 'width=1000,height=1000,left=50,top=50,toolbar=yes');" class="btn btn-primary" />
      </td>
      </tr>
<tr>
<td></td>
<td></td>
<td></td>
 <td> 
</td>
</tr>
<tr>
<td class="text-right">
    <asp:Label ID="Label22" runat="server" ForeColor="Red" Text="*"></asp:Label>
    Folio:</td>
<td>
    <asp:TextBox ID="txtFolioD" runat="server" CssClass="form-control2"></asp:TextBox>
    <asp:RequiredFieldValidator runat="server" CssClass="alert-error"
                         ID="RequiredFieldValidator18" ControlToValidate="txtFolioD"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                         ValidationGroup="AgregarDocumento" style="font-size: medium" />
    </td>
<td class="text-right">Serie:</td>
<td>
    <asp:TextBox ID="txtSerieD" runat="server" CssClass="form-control2"></asp:TextBox>
    </td>
</tr>
<tr>
<td class="text-right">MonedaDR:</td>
<td>
    <cc1:DropDownListChosen ID="ddlMonedaDR" runat="server" 
        AllowSingleDeselect="true" AutoPostBack="True" CausesValidation="false" 
        DataPlaceHolder="Escriba aquí..." Height="18px" 
        NoResultsText="No hay resultados coincidentes." 
        OnSelectedIndexChanged="ddlMonedaDR_SelectedIndexChanged" SelectMethod="" 
        width="210px">
    </cc1:DropDownListChosen></td>
<td class="text-right">MetodoDePagoDR:</td>
<td><asp:DropDownList runat="server" ID="ddlMetodoDePagoDR" AutoPostBack="True" OnSelectedIndexChanged="ddlMetodoDePagoDR_SelectedIndexChanged" CssClass="form-control2" >
                          <%-- <asp:ListItem runat="server" Text="Pago en una sola exhibición" Value="PUE" Selected="False" ></asp:ListItem>--%>
                            <asp:ListItem runat="server" Text="Pago en parcialidades o diferido" Value="PPD" Selected="True"></asp:ListItem>
                        </asp:DropDownList>
    </td>
</tr>
<tr>

<td class="text-right">
    <asp:Label ID="lblTipoCambioDR" runat="server" Text="Tipo Cambio:" 
        Visible="False" />
    </td>
<td>
    <asp:TextBox ID="txtTipoCambioDR" runat="server" Visible="False" CssClass="form-control2" />
    </td>
</tr>
<tr>
<td class="text-right"> <asp:Label ID="Label9" runat="server" ForeColor="Red" Text="*"></asp:Label>NumParcialidad:</td>
<td>
    <asp:TextBox ID="txtNumParcialidad" runat="server" CssClass="form-control2">1</asp:TextBox>
   
<asp:RequiredFieldValidator runat="server" CssClass="alert-error"
                         ID="RequiredFieldValidator13" ControlToValidate="txtNumParcialidad"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                         ValidationGroup="AgregarDocumento" style="font-size: medium" />    
</td>
<td class="text-right"> <asp:Label ID="Label13" runat="server" ForeColor="Red" Text="*"></asp:Label>ImpSaldoAnt:</td>
<td>
    <asp:TextBox ID="txtImpSaldoAnt" runat="server" CssClass="form-control2" AutoPostBack="True" OnTextChanged="txtImpSaldoAnt_TextChanged"></asp:TextBox>
<asp:RequiredFieldValidator runat="server" CssClass="alert-error"
                         ID="RequiredFieldValidator16" ControlToValidate="txtImpSaldoAnt"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                         ValidationGroup="AgregarDocumento" style="font-size: medium" />    
</td>
</tr>
<tr>
<td class="text-right"> <asp:Label ID="Label14" runat="server" ForeColor="Red" Text="*"></asp:Label>ImpPagado:</td>
<td>
    <asp:TextBox ID="txtImpPagado" runat="server" CssClass="form-control2"  AutoPostBack="True" OnTextChanged="txtImpPagado_TextChanged" Height="16px" Width="97px"></asp:TextBox>
<asp:RequiredFieldValidator runat="server" CssClass="alert-error"
                         ID="RequiredFieldValidator14" ControlToValidate="txtImpPagado"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                         ValidationGroup="AgregarDocumento" style="font-size: medium" />    
</td>
<td class="text-right"> <asp:Label ID="Label19" runat="server" ForeColor="Red" Text="*"></asp:Label>ImpSaldoInsoluto:</td>
<td>
    <asp:TextBox ID="txtImpSaldoInsoluto" runat="server" CssClass="form-control2" AutoPostBack="True" OnTextChanged="txtImpSaldoInsoluto_TextChanged"></asp:TextBox>

    <asp:RequiredFieldValidator runat="server" CssClass="alert-error"
                         ID="RequiredFieldValidator15" ControlToValidate="txtImpSaldoInsoluto"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                         ValidationGroup="AgregarDocumento" style="font-size: medium" />    
    </td>
</tr>
             <tr>

                 <td style="text-align: right">

                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td>
                 <td>

                   

                 </td>
                 <td>

                 </td>
                 <td>

                     <asp:Label ID="Label24" runat="server" Text=" *Campos obligatorios " Font-Bold="True" ForeColor="Red"></asp:Label>

                 </td>

             </tr>

<tr>
<td colspan="4" style="text-align: center">
<asp:Button runat="server" ID="AgregarDocumento" Text="Agregar Documento" 
        ValidationGroup="AgregarDocumento"  class="btn btn-primary" 
        onclick="btnAgregarDocumento_Click" Width="160px"/>
    <asp:CheckBox ID="DRcb" runat="server" AutoPostBack="True" Visible="False" />
</td>
</tr>
<tr>
<td colspan="5">
    <asp:GridView runat="server" ID="gvDocumento" AutoGenerateColumns="False" CssClass="style124"
			Width="100%" ShowHeaderWhenEmpty="True" onrowcommand="gvDocumento_RowCommand">
			<Columns>
              	<asp:BoundField HeaderText="ID" DataField="ID"  ItemStyle-HorizontalAlign="Center" />
                <asp:BoundField HeaderText="IdDocumento" DataField="IdDocumento" ItemStyle-HorizontalAlign="Center"  />
				<asp:BoundField HeaderText="Serie" DataField="Serie" ItemStyle-HorizontalAlign="Center" />
				<asp:BoundField HeaderText="Folio" DataField="Folio"  ItemStyle-HorizontalAlign="Center" />
                <asp:BoundField HeaderText="MonedaDR" DataField="MonedaDR" ItemStyle-HorizontalAlign="Center" />
               	<asp:BoundField HeaderText="NumParcialidad" DataField="NumParcialidad"  ItemStyle-HorizontalAlign="Center" />
               	<asp:BoundField HeaderText="ImpPagado" DataField="ImpPagado" DataFormatString="{0:C}" ItemStyle-HorizontalAlign="Center" />
               	<asp:BoundField HeaderText="ImpSaldoAnt" DataField="ImpSaldoAnt" DataFormatString="{0:C}"  ItemStyle-HorizontalAlign="Center" />
               	<asp:BoundField HeaderText="ImpSaldoInsoluto" DataField="ImpSaldoInsoluto"  DataFormatString="{0:C}" ItemStyle-HorizontalAlign="Center" />
                		
				<asp:ButtonField Text="Eliminar" CommandName="EliminarDocumento" Visible="False" ItemStyle-HorizontalAlign="Center" />
			</Columns>
		</asp:GridView></td>
</tr>
</table>
    
        
      </div>
      </asp:Panel>
                    </td>
                </tr></table>










            <div runat="server" id="divParcialidades" class="page3"  visible="False">
                <h1 style="text-align: center">
                    Parcialidades</h1>
                <table width="95%">
                    <tr>
                        <td style="text-align: right;" class="style130">
                            Folio Fiscal Original
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtFolioOriginal" />
                        </td>
                        <td style="text-align: right;" class="style3">
                            Fecha del Folio Fiscal Original:
                        </td>
                        <td>
                            <asp:TextBox ID="txtFechaOriginal" runat="server" Width="100%" />
                            <asp:CalendarExtender runat="server" ID="ceFechaOriginal" PopupButtonID="txtFechaOriginal"
                                TargetControlID="txtFechaOriginal" />
                            <asp:CompareValidator runat="server" ID="dvFechaOriginal" ErrorMessage="* Fecha Invalida"
                                Display="Dynamic" ControlToValidate="txtFechaOriginal" Operator="DataTypeCheck"
                                Type="Date" ValidationGroup="CrearFactura" />
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right;" class="style130">
                            Monto del Folio Fiscal Original
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtMontoOriginal" Width="100%" />
                            <asp:CompareValidator runat="server" ID="cvMontoOriginal" ControlToValidate="txtMontoOriginal"
                                Display="Dynamic" ErrorMessage="* Monto invalido" Operator="DataTypeCheck" Type="Currency"
                                ValidationGroup="CrearFactura" />
                        </td>
                        <td style="text-align: right">
                            Serie del Folio Fiscal Original
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtSerieOriginal"></asp:TextBox>
                        </td>
                    </tr>

                </table>
            </div>


            <div id="divViasConcesionadas" runat="server" visible="False">
                <h1>
                    Firmas</h1>
                <table width="100%">
                    <tr>
                        <td>
                            Vo. Bo.
                        </td>
                        <td>
                            Nombre:
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtVoBoNombre"></asp:TextBox>
                        </td>
                        <td>
                            Puesto:
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtVoBoPuesto"></asp:TextBox>
                        </td>
                        <td>
                            Area:
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtVoBoArea"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Recibí
                        </td>
                        <td>
                            Nombre:
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtRecibiNombre"></asp:TextBox>
                        </td>
                        <td>
                            Puesto:
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtRecibiPuesto"></asp:TextBox>
                        </td>
                        <td>
                            Area:
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtRecibiArea"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Autorizó
                        </td>
                        <td>
                            Nombre:
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtAutorizoNombre"></asp:TextBox>
                        </td>
                        <td>
                            Puesto:
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtAutorizoPuesto"></asp:TextBox>
                        </td>
                        <td>
                            Area:
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtAutorizoArea"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </div>
            <br />

              <asp:Panel ID="Panel3" runat="server"  CssClass="page3" BorderStyle="Double" HorizontalAlign="Left" Width="100%" Visible="true"> 
         		<asp:CheckBox runat="server" ID="cbCfdiRelacionados" Text="CfdiRelacionados" 
                    AutoPostBack="True" oncheckedchanged="cbCfdiRelacionados_CheckedChanged" 
                    style="font-weight: 700;"/>
		
       
                  
       
                  &nbsp;<div id="DivCfdiRelacionados"  style="width:100%" runat="server" visible="false">
         <table width="100%">
         
<tr>
<td colspan="3"  style="text-align: right; font-weight: 700;" >

    <asp:Label ID="Label23" runat="server" Font-Size="Small" Text="*Seleccione esta opción para sustituir un complemento de pago previamente cancelado" ForeColor="#CC0000"></asp:Label>
    &nbsp;</td>
</tr>
<tr>
         <td class="text-right">UUID:</td>
         <td>
             <asp:TextBox ID="txtUUDI" runat="server" Width="271px" CssClass="form-control2" />
         </td>
         <td class="text-right">TipoRelacion:</td>
         <td>       <asp:DropDownList runat="server" ID="ddlTipoRelacion" AutoPostBack="True" CssClass="form-control2" >
 <%--<asp:ListItem runat="server" Value="01" Text="01 - Nota de crédito de los documentos relacionados" />
 <asp:ListItem runat="server" Value="02" Text="02 - Nota de débito de los documentos relacionados" />
 <asp:ListItem runat="server" Value="03" Text="03 - Devolución de mercancía sobre facturas o traslados previos" />--%>
 <asp:ListItem runat="server" Value="04" Text="04 - Sustitución de los CFDI previos" />
 <%--<asp:ListItem runat="server" Value="05" Text="05 - Traslados de mercancias facturados previamente" />
 <asp:ListItem runat="server" Value="06" Text="06 - Factura generada por los traslados previos" />
 <asp:ListItem runat="server" Value="07" Text="07 - CFDI por aplicación de anticipo" />--%>
             <%--<asp:ListItem runat="server" Value="08" Text="08 - Factura generada por pagos en parcialidades" />
                 <asp:ListItem runat="server" Value="09" Text="09 - Factura generada por pagos diferidos" />--%>
                        </asp:DropDownList>
                    
      </td>
         </tr>
<tr>
<td colspan="4" style="text-align: center">
<asp:Button runat="server" ID="btnCfdiRelacionado" Text="Agregar CfdiRelacionado" 
        ValidationGroup="AgregarCfdiRelacionado"  class="btn btn-primary" 
        onclick="btnCfdiRelacionado_Click" Width="190px"/>
</td>
</tr>
<tr>
<td colspan="5">
<asp:GridView runat="server" ID="gvCfdiRelacionado" AutoGenerateColumns="False" CssClass="style124"
			Width="100%" ShowHeaderWhenEmpty="True" onrowcommand="gvCfdiRelacionado_RowCommand">
			<Columns>
              	<asp:BoundField HeaderText="ID" DataField="ID"  ItemStyle-HorizontalAlign="Center" />
                <asp:BoundField HeaderText="UUID" DataField="UUID" ItemStyle-HorizontalAlign="Center"/>
			    		
				<asp:ButtonField Text="Eliminar" CommandName="EliminarCfdiRelacionado" Visible="False" ItemStyle-HorizontalAlign="Center" />
			</Columns>
		</asp:GridView>
</td>
</tr>
</table>
    
        
      </div>
      </asp:Panel>




               <asp:Panel ID="Panel2" runat="server" CssClass="page2" BorderStyle="Double" HorizontalAlign="Center" Width="100%" Visible="false"> 
     
            <h1 style="text-align: center; color: #0000FF;" class="style156">
                <strong>Conceptos</strong></h1>
            <table width="100%">
                         <tr>
                    <td style="text-align: right; font-weight: 700;">
                        <span class="style160" style="color: #FF0000">*</span>ClaveUnidad</td>
                    <td style="text-align: left;">
                    <div>    
    
     <cc1:DropDownListChosen ID="ddlClaveUnidad" runat="server"  CausesValidation="false" 
            NoResultsText="No hay resultados coincidentes." width="144px"   SelectMethod=""          
            DataPlaceHolder="Escriba aquí..." AllowSingleDeselect="true" Height="16px" 
                            AutoPostBack="true" 
                            onselectedindexchanged="ddlClaveUnidad_SelectedIndexChanged">                
        </cc1:DropDownListChosen>  
        

        </div>
                             </td>
                    <td style="text-align: right; font-weight: 700;"> <span class="style160" 
                            style="color: #FF0000">*</span>Unidad</td>
                    <td style="text-align: left" class="style149">
                        <asp:TextBox runat="server" ID="txtUnidad" Width="134px"  />
                       </td>
                       <td style="text-align: right; font-weight: 700;"><span class="style160" 
                               style="color: #FF0000">*</span>Código </td>
                <td style="text-align: left">
                    <asp:TextBox ID="txtCodigo" runat="server" Width="134px" MaxLength="8" Text="84111506"/>
                    <script type="text/javascript"> 

                        function SoloNum(e) {
                            var key_press = document.all ? key_press = e.keyCode : key_press = e.which;
                            return (key_press > 47 && key_press < 58);
                            // el  "|| key_press == 46" es para incluir el punto ".", si borramos solo ingresara enteros 
                        }
                    </script>
                    
                    </td>
                            <td class="style157"> <input type="button" value="BuscadorSAT" onclick="javascript: window.open('http://200.57.3.46:443/PyS/catPyS.aspx', '', 'width=600,height=400,left=50,top=50,toolbar=yes');" class="btn btn-primary" />
                                 </td>
                                  <td><asp:Button ID="btnBuscarProducto" runat="server" class="btn btn-primary" 
                                OnClick="btnBuscarProducto_Click" Text="ClaveProdServ" Width="120px" /></td>
                </tr>
                <tr>
                <td></td>
                <td></td>
                <td></td>
                   <td style="color: #FF0000"> <asp:RequiredFieldValidator runat="server" 
                                    ID="RequiredFieldValidator6" ControlToValidate="txtUnidad"
                            Display="Dynamic" ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" 
                                    style="font-size: medium" />
                                </td>

                            </td>
                            <td></td>
                            <td style="color: #FF0000"> 
                         <asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator8" ControlToValidate="txtUnidad"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="AgregarConcepto" style="font-size: medium" />

                            </td>

                            </td>
                            </tr>
                <tr>
                    <td style="text-align: right; font-weight: 700;" width="15%" class="style158">
                        <span class="style160" style="color: #FF0000">*</span>Cantidad
                    </td>
                    <td class="style1">
                        <asp:TextBox runat="server" ID="txtCantidad" Width="134px" Text="1"/>
                      
                       
                    </td>
                     <td style="text-align: right; font-weight: 700;" class="style158">
                        Descuento</td>
                    <td style="text-align: left" class="style149">
                        <asp:TextBox ID="txtDescuento" runat="server" Width="134px" />
                    </td>
                    <td style="text-align: right; font-weight: 700;" class="style160">
                       NoIdentificacion                        
                    </td>
                    <td style="text-align: left" class="style161">
                        <asp:TextBox ID="txtNoIdentificacion" runat="server"  Width="134px" />
                        
                    </td>

                      <td style="text-align: right" class="style162">
                          <strong style="text-align: center"><span style="color: #FF0000">*</span>PrecioUnitario$</strong>
                    </td>
                    <td style="text-align: left" class="style158">
                        <asp:TextBox runat="server" ID="txtPrecio" Width="134px" Text="0"/></td>
                      <td class="style162"></td>  
                    
                </tr>
                <tr>
                 <td></td>
                 <td style="color: #FF0000"> <asp:RequiredFieldValidator runat="server" 
                         ID="rfvCantidad" ControlToValidate="txtCantidad"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                         ValidationGroup="AgregarConcepto" style="font-size: medium" />  
                    <asp:RegularExpressionValidator id="RegularExpressionValidator2" runat="server" Display="Dynamic" CssClass="alert-danger"
    ControlToValidate="txtCantidad" ErrorMessage="Dato invalido" 
                         ValidationExpression="[0-9]*\.?[0-9]*" 
                         ValidationGroup="AgregarConcepto" style="font-size: medium"/></td>
                 <td class="style146"></td>
                 <td class="style149"></td>
                 <td></td>
                 <td class="style154"></td>
                 <td class="style152"></td>
                 <td><asp:RequiredFieldValidator runat="server" ID="rfvPrecio" ControlToValidate="txtPrecio"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                         ValidationGroup="AgregarConcepto" 
                         style="color: #FF0000; font-size: medium;" />&nbsp;
                        <asp:CompareValidator runat="server" ID="cvPrecio" ControlToValidate="txtPrecio"
                            Display="Dynamic" ErrorMessage="* Precio invalido" Type="Double" Operator="DataTypeCheck"
                            ValidationGroup="AgregarConcepto" 
                         style="color: #FF0000; font-size: medium;" /></td>
                  
                </tr>
                <tr>
                 <td align="right"><asp:CheckBox runat="server" ID="cbIVA" Text="IVA" 
                         AutoPostBack="True" 
                         style="text-align: right; font-weight: 700; color: #2D5C94;" 
                         OnCheckedChanged="cbImp_CheckedChanged" Checked="true"/></td>
                            <td align="left">
                                <asp:DropDownList runat="server" ID="ddlIVA" AutoPostBack="True"  Width="70px" Height="18px" Enabled="true">
                         <asp:ListItem runat="server" Value="0.160000" Text="16%" Selected="True"></asp:ListItem>
                           <asp:ListItem runat="server" Text="0%" Value="0.000000"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Exento" Value="Exento"></asp:ListItem>
                        </asp:DropDownList>

                            </td>
               <td style="text-align: right; font-weight: 700;"><asp:CheckBox runat="server" 
                       ID="cbRISR" Text="Ret ISR" AutoPostBack="True" 
                       style="text-align: right; font-weight: 700; color: #2D5C94;"/></td> 
                     
                      <td style="text-align: left"> <asp:TextBox ID="txtRISR10" runat="server" Width="70px" Text="0.100000" Enabled="false"/>
                    </td>
                     <td style="text-align: right; font-weight: 700;"><asp:CheckBox runat="server" 
                             ID="cbRIVA" Text="Ret IVA" AutoPostBack="True" 
                             style="text-align: right; font-weight: 700; color: #2D5C94;" 
                             OnCheckedChanged="cbRIVA_CheckedChanged"/>
                     </td>
                      <td style="text-align: left">  <asp:DropDownList runat="server" ID="ddlRIVA" AutoPostBack="True"  Width="80px" Height="18px" Enabled="false">
                         <asp:ListItem runat="server" Value="0.106666" Text="0.106666" Selected="True"></asp:ListItem>
                           <asp:ListItem runat="server" Text="0.040000" Value="0.040000"></asp:ListItem>
                        </asp:DropDownList></td>
                        <td style="text-align: right; font-weight: 700;" width="15%">CuentaPredial</td>
                            <td colspan="1" style="text-align: left">
                                <asp:TextBox ID="txtCuentaPredial" runat="server" Width="134px" />
                             </td>
                </tr>
                

                <tr>
                    <td style="text-align: right; font-weight: 700;" width="15%">
                        <span class="style160" style="color: #FF0000">*</span>Descripción
                    </td>
                        <td colspan="3" style="text-align: left">
                            <asp:TextBox runat="server" ID="txtDescripcion" Width="94%" AutoPostBack="true"
                                TextMode="MultiLine" MaxLength="10" OnTextChanged="txtDescripcion_TextChanged" Text="Pago"/>
                           </td>
                         <td style="text-align: right;font-weight: 700;" width="15%">
                         &nbsp;Observaciones</td>
                    <td class="style153">
                        <asp:TextBox runat="server" ID="txtDetalles" Width="183%" 
                            TextMode="MultiLine" />
                    </td>
                </tr>

                <tr>
                   <td class="auto-style1"></td>
                   <td class="auto-style1">  <asp:RequiredFieldValidator runat="server" ID="rfvDescripcion" ControlToValidate="txtDescripcion"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="AgregarConcepto" 
                           style="color: #FF0000; font-size: medium;" />
                            </td>
                            <td class="auto-style1"></td>
                            <td>
                                <asp:Label runat="server" ID="rest" Text="1000 / 1000" Visible="True" style="text-align: right; font-weight: 700;"/>
                            </td>
                            <td class="auto-style1"></td>
                            <td class="auto-style1"></td>
                            <td class="auto-style1"></td>
                           </tr>
                           
                
                         <caption>
                             <tr>
                               <td></td>
                               <td></td>
                                <td>
                                     <asp:HiddenField ID="txtIdProducto" runat="server" />
                                 </td>
                                
                                 <td style="text-align: left; font-weight: 700; font-size: small; color: #FF0000;" width="94%" 
                                 class="style160">Campos Obligatorios (*)</td>
                                 <td></td> 
                                 <td class="style154">
                                     <asp:Button ID="btnAgregar" runat="server" class="btn btn-primary" 
                                         OnClick="btnAgregar_Click" Text="Agregar Concepto" 
                                         ValidationGroup="AgregarConcepto" Width="146px" />
                                 </td>
                                 <td class="style157">
                                     <asp:Button ID="btnBuscarHistorico" runat="server" class="btn btn-primary" 
                                         OnClick="btnBuscarHistorico_Click" Text="BuscarConcepto" Width="136px" />
                                 </td>
                                
                             </tr>
                         </caption>
            </table><br />
            <div style="height: 100%; overflow-y: scroll" >
                <asp:GridView runat="server" ID="gvDetalles" AutoGenerateColumns="False"  CssClass="style124" Width="100%" HorizontalAlign="Center"
                    ShowHeaderWhenEmpty="True" OnRowCommand="gvDetalles_RowCommand">
                    <Columns>
                      <asp:BoundField HeaderText="Partida" DataField="Partida" ItemStyle-HorizontalAlign="Center" />
                       
                        <asp:BoundField HeaderText="ClaveProdServ" DataField="Codigo" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField HeaderText="NoIdentificacion" DataField="ConceptoNoIdentificacion" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField HeaderText="Cantidad" DataField="Cantidad" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField HeaderText="ClaveUnidad" DataField="ConceptoClaveUnidad" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField HeaderText="Unidad" DataField="Unidad" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField HeaderText="ValorUnitario" DataField="Precio" ItemStyle-HorizontalAlign="Center" DataFormatString="${0:#,#.######}" />
                        <asp:BoundField HeaderText="Descripción" DataField="Descripcion" />
                        <asp:BoundField HeaderText="Importe" DataField="Total" DataFormatString="${0:#,#.######}" />
                       <asp:BoundField HeaderText="Descuento" DataField="ConceptoDescuento" DataFormatString="${0:#,#.######}"
                            ItemStyle-HorizontalAlign="Right" />
                        <asp:BoundField HeaderText="CuentaPredial" DataField="CuentaPredial" />
                        <asp:BoundField HeaderText="Observaciones" DataField="Observaciones" />
                        <asp:ButtonField Text="Editar" CommandName="Editar" Visible="False" ItemStyle-HorizontalAlign="Center" />
                        <asp:ButtonField Text="Eliminar" CommandName="EliminarConcepto" Visible="False" ItemStyle-HorizontalAlign="Center" />
                    </Columns>
                </asp:GridView>
            </div>
            <br />
            </asp:Panel>
            <br />
            
    <div>
		    <table width="100%">
		    <tr>
                                        
                       
                        <td style="text-align: left">
                          
        <asp:Panel ID="Panel1" runat="server"  CssClass="page3" BorderStyle="Double" HorizontalAlign="Left" Width="100%" Visible="false"> 
         		<asp:CheckBox runat="server" ID="cbImpuestos" Text="Impuestos" 
                    AutoPostBack="True" oncheckedchanged="cbImpuestos_CheckedChanged" 
                    style="font-weight: 700; color: #0000FF; font-size: large;" 
                    Enabled="False"/>
		
       
          <div id="DivComplementos"  style="width:100%" runat="server" visible="false">
         <table width="100%">
<tr>
<td colspan="3"  style="text-align: left; font-weight: 700;" >

<asp:Label ID="Label2" runat="server" Text="Impuestos" Font-Bold="True"  
        style="font-size: medium; color: #2D5C94;"></asp:Label>
   </td>
</tr>
<tr>
<td style="text-align: right">
    <asp:Label ID="Label12" runat="server" ForeColor="Red" Text="*"></asp:Label>
    TipoImpuesto:</td>
<td>
    <asp:DropDownList ID="ddlTipoImpuesto" runat="server" AutoPostBack="True" 
        onselectedindexchanged="ddlTipoImpuesto_SelectedIndexChanged">
        <asp:ListItem Value="Traslados">Traslados</asp:ListItem>
     <asp:ListItem Value="Retenciones">Retenciones</asp:ListItem>
       
    </asp:DropDownList>

    </td>
    <td style="text-align: right">
        <asp:Label ID="Label11" runat="server" ForeColor="Red" Text="*"></asp:Label>
        Base:</td>
    <td>
        <asp:TextBox ID="txtBase" runat="server" Enabled="False" Width="100px"></asp:TextBox>
        <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" 
            FilterType="Numbers, Custom" TargetControlID="txtBase" ValidChars="." />
        <asp:RequiredFieldValidator style="color: #FF0000" ID="RequiredFieldValidator5" runat="server" 
            ControlToValidate="txtBase" Display="Dynamic" ErrorMessage="Requerido" 
            ValidationGroup="AgregarImpuesto"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator style="color: #FF0000" ID="RegularExpressionValidator1" runat="server" 
            ControlToValidate="txtBase" Display="Dynamic" ErrorMessage="Dato invalido" 
            ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" 
            ValidationGroup="AgregarImpuesto" />
    </td>
</tr>
<tr>
<td style="text-align: right" class="style128"> 
    <asp:Label ID="Label10" runat="server" ForeColor="Red" Text="*"></asp:Label>
    Partida:</td>

<td class="style125">
        <asp:DropDownList ID="ddlConceptos" runat="server" AutoPostBack="True" Width="113px"
            onselectedindexchanged="ddlConceptos_SelectedIndexChanged">
            
      
    </asp:DropDownList>
        </td>
<td style="text-align: right"> 
    <asp:Label ID="Label4" runat="server" ForeColor="Red" Text="*"></asp:Label>
    TipoFactor:</td>
<td>
    <asp:DropDownList ID="ddlTipoFactor" runat="server" AutoPostBack="True" Width="113px"
        onselectedindexchanged="ddlTipoFactor_SelectedIndexChanged">
        <asp:ListItem Value="Tasa">Tasa</asp:ListItem>
        <%--<asp:ListItem Value="Cuota">Cuota</asp:ListItem>--%>
        <asp:ListItem Value="Exento">Exento</asp:ListItem>
    </asp:DropDownList>

    </td>
</tr>

<tr>
<td class="style127" style="text-align: right"> 
    <asp:Label ID="Label3" runat="server" ForeColor="Red" Text="*"></asp:Label>
    Impuesto:
    </td><td class="style125">
        <asp:DropDownList ID="ddlImpuesto" runat="server" AutoPostBack="True" onselectedindexchanged="ddlImpuesto_SelectedIndexChanged" Width="113px"
    >
    <asp:ListItem Value="002">IVA</asp:ListItem>
    <asp:ListItem Value="001">ISR</asp:ListItem>
    <asp:ListItem Value="003">IEPS</asp:ListItem>
     
       
    </asp:DropDownList>
        <br />
       
      </td>
    
<td style="text-align: right" > 
    <asp:Label ID="Label8" runat="server" ForeColor="Red" Text="*"></asp:Label>
    TasaOCuota:</td><td class="style5">
        
         <asp:TextBox ID="txtTasa" runat="server" class="prueba" Width="56px"></asp:TextBox>
         <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender3" runat="server" 
             FilterType="Numbers, Custom" TargetControlID="txtTasa" ValidChars="." />
         <asp:DropDownList ID="ddlTasaOCuota" runat="server" DataTextField="Maximo" 
             DataValueField="Maximo">
         </asp:DropDownList>
         <br />

      
    </td>
   
<td style="text-align: right" > 
  </td>
   
</tr>
<tr>
    <td>
        <asp:Label ID="LblAux" runat="server" ForeColor="Red" Text="*"/>

    </td>
<td colspan="3" style="text-align: right">
<asp:Button runat="server" ID="btnAgregarImpuesto" Text="Agregar Impuesto" 
        ValidationGroup="AgregarImpuesto"  class="btn btn-primary" 
        onclick="btnAgregarImpuesto_Click"/>
</td>
</tr>
<tr>
<td colspan="5">
<asp:GridView runat="server" ID="gvImpuestos" AutoGenerateColumns="False" CssClass="style124"
			Width="100%" ShowHeaderWhenEmpty="True" onrowcommand="gvImpuestos_RowCommand">
			<Columns>
              	<asp:BoundField HeaderText="Partida" DataField="ConceptoClaveProdServ"  ItemStyle-HorizontalAlign="Center" />
               <asp:BoundField HeaderText="TipoImpuesto" DataField="TipoImpuesto"  ItemStyle-HorizontalAlign="Center" />
                <asp:BoundField HeaderText="Impuesto" DataField="Impuesto" ItemStyle-HorizontalAlign="Center"  ItemStyle-Width="10%" />
				<asp:BoundField HeaderText="Base" DataField="Base" ItemStyle-HorizontalAlign="Center" />
				<asp:BoundField HeaderText="TasaOCuota" DataField="TasaOCuota"  ItemStyle-HorizontalAlign="Center" />
                <asp:BoundField HeaderText="Importe" DataField="Importe" DataFormatString="${0:#,#.######}" ItemStyle-HorizontalAlign="Center" />
               	<asp:BoundField HeaderText="TipoFactor" DataField="TipoFactor"  ItemStyle-HorizontalAlign="Center" />
                		
				<asp:ButtonField Text="Eliminar" CommandName="EliminarImpuesto" Visible="False" ItemStyle-HorizontalAlign="Center" />
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
            <asp:Label runat="server" ID="lblError" ForeColor="Red" />
            <div style="float: right">
                <table style="text-align: right;">
                    <tr style="width: 150px">
                        <td>
                            Subtotal:
                        </td>
                        <td>
                            <asp:Label runat="server" ID="lblSubtotal" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Retenciones
                        </td>
                        <td>
                            <asp:Label runat="server" ID="lblRetenciones" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Traslados
                        </td>
                        <td>
                            <asp:Label runat="server" ID="lblTraslados" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Descuento
                        </td>
                        <td>
                            <asp:Label runat="server" ID="lblDescuento" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Total
                        </td>
                        <td>
                            <asp:Label runat="server" ID="lblTotal" />
                        </td>
                    </tr>
                </table>
            </div>
            <div style="clear: both">
            </div>
            <p align="right">
                <asp:Button runat="server" ID="btnLimpiar" Text="Limpiar" 
                    OnClick="btnLimpiar_Click" class="btn btn-primary" Width="70px" style="height: 29px"/>&nbsp;&nbsp;&nbsp;
                <asp:Button runat="server" ID="BtnVistaPrevia" Text="Vista Previa" OnClick="btnGenerarPreview_Click" class="btn btn-primary"
                    ValidationGroup="CrearFactura" />&nbsp;&nbsp;&nbsp;
                <asp:Button runat="server" ID="btnGenerarFactura" Text="Generar Factura" OnClick="btnGenerarFactura_Click" class="btn btn-primary"
                    ValidationGroup="CrearFactura"  UseSubmitBehavior="false"
      OnClientClick="this.disabled='true';" />
                <asp:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" TargetControlID="btnGenerarFactura"
                    ConfirmText="Confirma que deseas generar el comprobante" />
            </p>
       
       <br />
    <asp:ModalPopupExtender runat="server" ID="mpeBuscarConceptos" TargetControlID="btnConceptoDummy"
        BackgroundCssClass="mpeBack" CancelControlID="btnCerrarConcepto" PopupControlID="pnlBuscarConceptos" />
    <asp:Panel runat="server" ID="pnlBuscarConceptos" Style="text-align: center;" Width="800px" CssClass="page3"
        BackColor="White">
        <h1 class="style155">
            Buscar Conceptos</h1>
           
        <p>
            <asp:TextBox runat="server" ID="txtConceptoBusqueda" Width="250px" />&nbsp;&nbsp;&nbsp;
            <asp:Button runat="server" ID="btnBuscarConcepto" Text="Buscar" OnClick="btnBuscarConcepto_Click"  class="btn btn-primary" /> 
        </p>
        <div style="height: 400px;, overflow-y: scroll">
            <asp:Label runat="server" ID="lblMensaje" ForeColor="Red" />
            <asp:GridView runat="server" ID="gvBuscarConceptos" Width="100%" AutoGenerateColumns="False" 
                DataKeyNames="c_ClaveProdServ1" ShowHeaderWhenEmpty="True" OnRowCommand="gvBuscarConceptos_RowCommand">
                <Columns>
                    <asp:BoundField HeaderText="Código" DataField="c_ClaveProdServ1" />
                    <asp:BoundField HeaderText="Descripción" DataField="Descripcion" />
                    <asp:ButtonField Text="Seleccionar" CommandName="Seleccionar" />
                </Columns>
            </asp:GridView>
        </div>
        <br />
        <%--<asp:Button runat="server" ID="btnSeleccionarConcepto" Text="Seleccionar" onclick="btnSeleccionarConcepto_Click" />&nbsp;&nbsp;--%>
        <asp:Button runat="server" ID="btnCerrarConcepto" Text="Cancelar"  class="btn btn-primary" />
    </asp:Panel>
    <asp:Button runat="server" ID="btnConceptoDummy" Style="display: none;" />
  
      <asp:ModalPopupExtender runat="server" ID="mpeEdita" TargetControlID="btnEditarDummy"
        BackgroundCssClass="mpeBack" CancelControlID="btnCancelar" PopupControlID="panelEditaConcepto" />
    <asp:Panel runat="server" ID="panelEditaConcepto" Style="text-align: center;" Width="800px" CssClass="page3"
        BackColor="White">
        <h1>
            <asp:Label runat="server"  ID="lblConcepto" style="color: #2D5C94">Editar Concepto</asp:Label></h1>
        <table class="linea" width="600px">
            <tr>
            <td>ClaveUnidad:</td>
             <td align="left"><cc1:DropDownListChosen ID="ddlClaveUnidadE" runat="server"  CausesValidation="false" 
            NoResultsText="No hay resultados coincidentes." width="206px"   SelectMethod=""          
            DataPlaceHolder="Escriba aquí..." AllowSingleDeselect="true" Height="16px">                
        </cc1:DropDownListChosen></td>
            </tr>
            <tr>
            <td>Código:</td>
            <td align="left"><asp:TextBox ID="txtCodigoE" runat="server" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="* Requerido"
                        Display="Dynamic" ControlToValidate="txtCodigoE" ValidationGroup="Concepto" /></td>
            </tr>
            <tr>
                <td>
                    Cantidad:
                </td>
                <td align="left">
                    <asp:TextBox runat="server" ID="txtCantidadEdita" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="* Requerido"
                        Display="Dynamic" ControlToValidate="txtCantidadEdita" ValidationGroup="Concepto" />
                    <asp:CompareValidator runat="server" ID="CompareValidator1" ControlToValidate="txtCantidadEdita"
                        Display="Dynamic" Type="Double" ErrorMessage="* Cantidad Invalida" ValidationGroup="Concepto"
                        Operator="DataTypeCheck" />
                    <asp:HiddenField runat="server" ID="hidDetalle" />
                    <asp:HiddenField runat="server" ID="hidNumero" />
                </td>
            </tr>
            <tr>
                <td>
                    Unidad de Medida:
                </td>
                <td align="left">
                    <asp:TextBox runat="server" ID="txtUnidadEdita" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="* Requerido"
                        Display="Dynamic" ControlToValidate="txtUnidadEdita" ValidationGroup="Concepto" />
                </td>
            </tr>
            <tr>
                <td>
                    N° de identificación:
                </td>
                <td align="left">
                    <asp:TextBox runat="server" ID="txtNoIdentificacionEdita" Width="400px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    Descripción:
                </td>
                <td align="left">
                    <asp:TextBox runat="server" ID="txtDescripcionEdita" Width="400px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="* Requerido"
                        Display="Dynamic" ControlToValidate="txtDescripcionEdita" ValidationGroup="Concepto" />
                </td>
            </tr>
            <tr>
                <td>
                    Observaciones:
                </td>
                <td align="left">
                    <asp:TextBox runat="server" ID="txtObservacionesEdita" Width="400px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    Precio Unitario:
                </td>
                <td align="left">
                    <asp:TextBox runat="server" ID="txtPrecioUnitarioEdita"></asp:TextBox>
                    <asp:CompareValidator runat="server" ID="CompareValidator2" ControlToValidate="txtPrecioUnitarioEdita"
                        Display="Dynamic" Type="Double" ErrorMessage="* Cantidad Invalida" ValidationGroup="Concepto"
                        Operator="DataTypeCheck" />
                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator4" ErrorMessage="* Requerido"
                        Display="Dynamic" ControlToValidate="txtPrecioUnitarioEdita" ValidationGroup="Concepto" />
                </td>
            </tr>
            <tr>
                <td>
                  Descuento:</td>
                <td style="text-align: left;"><asp:TextBox ID="txtDescuentoE" runat="server" Width="106px" />
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style2">
                  Cuenta Predial:</td>
                <td style="text-align: left;" class="auto-style2"><asp:TextBox ID="txtCuentaPredialE" runat="server" Width="106px" />
                    &nbsp;</td>

            </tr>
        </table>
        <br />
        <div align="right">
            <asp:Button runat="server" ID="btnGuardar" Text="Guardar" ValidationGroup="Concepto" class="btn btn-primary"
                OnClick="btnGuardar_Click" />
            &nbsp;&nbsp;&nbsp;
            <asp:Button runat="server" ID="btnCancelar" Text="Cancelar" CausesValidation="False"  class="btn btn-primary" />
        </div>
    </asp:Panel>
    <asp:Button runat="server" ID="btnEditarDummy" Style="display: none;" class="btn btn-primary" />
    
    <asp:ModalPopupExtender runat="server" ID="mpeBuscarConceptoHistorico" TargetControlID="btnConceptoHistoricoDummy" 
    BackgroundCssClass="mpeBack"
	 CancelControlID="btnCerrarConceptoHistorico" PopupControlID="pnlBuscarConceptoHistorico" />
	<asp:Panel runat="server" ID="pnlBuscarConceptoHistorico" style="text-align: center;" Width="800px" CssClass="page3" BackColor="White">
		<h1 class="style155">Buscar Conceptos Historico</h1>
		<p>
			<asp:TextBox runat="server" ID="txtConceptoHistoricoBusqueda" Width="250px" />&nbsp;&nbsp;&nbsp;
			<asp:Button runat="server" ID="btnBuscarConceptoHistorico" Text="Buscar" onclick="btnBuscarConceptoHistorico_Click"  class="btn btn-primary"/>
		</p>
        <div style="height: 400px; overflow-y: scroll"  >
		<asp:Label runat="server" ID="lblMensajeHistorico" ForeColor="Red" />
		<asp:GridView runat="server" ID="gvBuscarConceptosHistorico" Width="100%" AutoGenerateColumns="False" 
		 DataKeyNames="IdProducto" ShowHeaderWhenEmpty="True" 
			onrowcommand="gvBuscarConceptosHistorico_RowCommand">
			<Columns>
				<asp:BoundField HeaderText="Código" DataField="Codigo" />
				<asp:BoundField HeaderText="Descripción" DataField="Descripcion" />
				<asp:BoundField HeaderText="Observaciones" DataField="Observaciones" />
				<asp:BoundField HeaderText="Precio" DataField="PrecioP" DataFormatString="{0:C}" />
				<asp:ButtonField  Text="Seleccionar" CommandName="Seleccionar"/>
			</Columns>
		</asp:GridView>
        </div>
		<br />
		<%--<asp:Button runat="server" ID="btnSeleccionarConcepto" Text="Seleccionar" onclick="btnSeleccionarConcepto_Click" />&nbsp;&nbsp;--%>
		<asp:Button runat="server" ID="btnCerrarConceptoHistorico" Text="Cancelar" class="btn btn-primary" />
	</asp:Panel>
	<asp:Button runat="server" ID="btnConceptoHistoricoDummy" style="display: none;"/>
    

           
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


            



   <asp:ModalPopupExtender runat="server" ID="mpeCFDIG" TargetControlID="btngenerarDummy"
        BackgroundCssClass="mpeBack"  PopupControlID="pnlMSG" />
    <asp:Panel runat="server" ID="pnlMSG" Style="text-align: center;"  CssClass="page7"
        BackColor="#A8CF38" Height="98px" Width="418px">
        <h1 class="style161" style="color: #000000">
            <strong>Comprobante generado correctamente y enviado por correo electrónico</strong>
              <asp:LinkButton ID="LinkButton1" runat="server" ForeColor="#FF3300" 
                onclick="LinkButton1_Click">Descargar PDF</asp:LinkButton>
            </h1>
        <br />
        <%--<asp:Button runat="server" ID="btnSeleccionarConcepto" Text="Seleccionar" onclick="btnSeleccionarConcepto_Click" />&nbsp;&nbsp;--%>
        <asp:Button runat="server" ID="btnCerrar" Text="Aceptar"  class="btn btn-primary" OnClick="btnCerrar_Click" />
    </asp:Panel>
    <asp:Button runat="server" ID="btngenerarDummy" Style="display: none;" />
           



                  <asp:ModalPopupExtender runat="server" ID="Error" TargetControlID="btngenerarDummy2"
        BackgroundCssClass="mpeBack"  PopupControlID="pnerror" />

            <asp:Panel runat="server" ID="pnerror" Style="text-align: center;"  CssClass="page7"
        BackColor="#A8CF38" Height="98px" Width="418px">
        <h1 class="style161" style="color: #000000">
            <strong>Por favor seleccione un cliente.
            </strong></h1>
        <br />
        <%--<asp:Button runat="server" ID="btnSeleccionarConcepto" Text="Seleccionar" onclick="btnSeleccionarConcepto_Click" />&nbsp;&nbsp;--%>
        <asp:Button runat="server" ID="Button2" Text="Aceptar"  class="btn btn-primary"/>
    </asp:Panel>
<asp:Button runat="server"  ID="btngenerarDummy2" Style="display: none;" />


            
                  <asp:ModalPopupExtender runat="server" ID="ErrorDR" TargetControlID="btngenerarDummy3"
        BackgroundCssClass="mpeBack"  PopupControlID="pnerrorDR" />

            <asp:Panel runat="server" ID="pnerrorDR" Style="text-align: center;"  CssClass="page7"
        BackColor="#A8CF38" Height="98px" Width="418px">
        <h1 class="style161" style="color: #000000">
            <strong>Por favor Agregue los Datos del Documento Relacionado.
            </strong></h1>
        <br />
        
        <asp:Button runat="server" ID="Button3" Text="Aceptar"  class="btn btn-primary" OnClick="Button3_Click"/>
    </asp:Panel>
<asp:Button runat="server"  ID="btngenerarDummy3" Style="display: none;" />



     </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnLimpiar" />
            <asp:PostBackTrigger ControlID="gvDetalles" />
            <asp:PostBackTrigger ControlID="BtnVistaPrevia" />
             <asp:PostBackTrigger ControlID="LinkButton1" />
        </Triggers>
    </asp:UpdatePanel>
    
</asp:Content>
