 
<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"  CodeBehind="wfrFacturaComercioExterior.aspx.cs" Inherits="GafLookPaid.wfrFacturaComercioExterior" MaintainScrollPositionOnPostBack="true" %>
    <%@ Register TagPrefix="cc1" Namespace="WebControls.FilteredDropDownList" Assembly="WebControls.FilteredDropDownList"  %>
     <%@ Register Assembly="DropDownChosen" Namespace="CustomDropDown" TagPrefix="cc1" %>
      <% @ Register Assembly = "TimePicker" Namespace = "MKB.TimePicker" TagPrefix = "cc2" %>
 <%@ MasterType VirtualPath="~/Site.Master" %>
 <%@ Register Src="~/controles/Impuestos.ascx" TagPrefix="uc" TagName="UCImpuestos" %>

<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
     
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
 <%--<link href="Styles/chosen.css" rel="stylesheet" />
  <link href="Styles/chosen.min.css" rel="stylesheet" />--%>

  <style type="text/css">
        .style125
        {
            width: 182px;
        }
        .style127
        {
            width: 83px;
        }
        .style128
        {
            width: 84px;
            text-align: right;
        }
        .style130
        {
            width: 119px;
        }
        .style132
        {
            width: 256px;
        }
        .auto-style1 {
            width: 15%;
        }
        .auto-style2 {
            width: 16%;
        }
        .style138
        {
            width: 6%;
        }
        .style141
        {
            width: 34%;
            text-align: right;
        }
        .style142
        {
            width: 48%;
        }
        .style143
        {
            width: 25%;
        }
        .style144
        {
            width: 50%;
            text-align: right;
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



        .style146
        {
            width: 100px;
        }
       

        .style147
      {
          height: 71px;
      }
       
         #MainContent_tabContainerAduana_tabGeneral_TimeSelector1 > table:nth-child(-n+2) {
border-style:None;
 border-width:0px;
     height:5px !important;
     font-size:10px !important;
    
}
 #MainContent_tabContainerAduana_tabGeneral_TimeSelector1 >table> tbody>tr>td>input
{
  padding: 5px 0px; 
  font-size:10px import!; 
}
       #MainContent_tabContainerAduana_tabGeneral_TimeSelector2 > table:nth-child(-n+2) {
border-style:None;
 border-width:0px;
     height:5px !important;
     font-size:10px !important;
    
}
 #MainContent_tabContainerAduana_tabGeneral_TimeSelector2 >table> tbody>tr>td>input
{
  padding: 5px 0px; 
  font-size:10px import!; 
}

        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server" />
    
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
 
 <script language="javascript" type="text/javascript">
     function AppendTime(sender, args) {
         var selectedDate = new Date();
         selectedDate = sender.get_selectedDate();
         var now = new Date();
         sender.get_element().value = selectedDate.format("dd/MM/yyyy") + " " + now.format("hh:mm tt");
     }
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
                    <h1>Generar Co mercio Exterior</h1>
                   
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <asp:Label ID="lblVencimiento" runat="server" ForeColor="Red" Font-Bold="true" style=" font-size: x-small; text-align: left; font-variant: small-caps;" Width="250px"></asp:Label>
                        </td>
                     <td>Cliente:</td>
                        <td></td> 
                    </tr>
                    <tr>
                        <td>Empresa:</td>
                      
                        <td>
                            <asp:DropDownList ID="ddlEmpresa" runat="server" AutoPostBack="True" CssClass="form-control2" DataTextField="RazonSocial" DataValueField="idEmpresa" OnSelectedIndexChanged="ddlEmpresa_SelectedIndexChanged" />
                        </td>
                        
                        <td> <%--asp:DropDownList runat="server" ID="ddlClientes" AutoPostBack="True"
                    DataTextField="RazonSocial" DataValueField="idCliente" CssClass="page"
                    OnSelectedIndexChanged="ddlClientes_SelectedIndexChanged" Height="16px" 
                    Width="197px" /--%>
                            <cc1:DropDownListChosen ID="ddlClientes" runat="server" AllowSingleDeselect="true" AutoPostBack="True" CausesValidation="false" CssClass="form-control2" DataPlaceHolder="Seleccione..." DataTextField="RazonSocial" DataValueField="idCliente"  NoResultsText="No hay resultados coincidentes." OnSelectedIndexChanged="ddlClientes_SelectedIndexChanged" SelectMethod=""  Width="400px" AppendDataBoundItems="True" >
                               
                 
                            </cc1:DropDownListChosen>
                           

                      
                            </td>
                     
                        
                    </tr>
                </caption>
                <tr>
                <td>Folio NTLINK:</td>
                
                <td><asp:TextBox runat="server" ID="txtFolio" CssClass="form-control2" Width="59px"  Enabled="False" />
            </td>
               <td>
                            <asp:TextBox ID="txtRazonSocial" runat="server" CssClass="form-control2" Enabled="true" Height="33px" TextMode="MultiLine" Width="341px" />
                        </td>
            </tr>
    </table>
            <table class="page2"   width="100%">
            <tr>
            
            <td style="text-align: right">Folio:</td>
                    <td class="style132">
                        <asp:TextBox runat="server" ID="txtFolioSat" CssClass="form-control2" 
                            Width="156px"  />
                    </td>
                      <td style="text-align: right">
                        Serie:
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtSerie" CssClass="form-control2" Width="156px" AutoPostBack="True"  />
                    </td>
                             
                    
                     <td style="text-align: right">
                        Sucursal
                    </td>
                    <td>
                        <asp:DropDownList runat="server" ID="ddlSucursales" AppendDataBoundItems="True" DataValueField="LugarExpedicion"
                            DataTextField="Nombre" CssClass="form-control2" Width="156px"  />
                    </td>
                  </tr>
                <tr>
                   <td style="text-align: right">
                        Tipo de Documento:</td>
                    <td class="style132" >
                        <asp:DropDownList runat="server" ID="ddlTipoDocumento" AutoPostBack="True" OnSelectedIndexChanged="ddlTipoDocumento_SelectedIndexChanged" CssClass="form-control2">
                            <asp:ListItem Text="Factura" Value="Ingreso" ></asp:ListItem>
                            <asp:ListItem Text="Nota de Crédito" Value="Egreso" ></asp:ListItem>
                            <asp:ListItem Text="Recibo de Donativo" Value="Donativo" ></asp:ListItem>
                            <asp:ListItem Text="Recibo de Arrendamiento" Value="Arrendamiento" ></asp:ListItem>
                            <asp:ListItem Text="Recibo de Honorarios" Value="Honorarios" ></asp:ListItem>
                            <asp:ListItem Text="Traslado" Value="T" ></asp:ListItem>
                            
                        </asp:DropDownList>
                          
                    </td>
                    <td style="text-align: right">
                        Status Factura:
                    </td>
                    <td>
                        <asp:DropDownList runat="server" ID="ddlStatusFactura" AutoPostBack="true" OnSelectedIndexChanged="ddlStatusFactura_SelectedIndexChanged" CssClass="form-control2" Width="176px" >
                            <asp:ListItem Value="0" Text="Pendiente"></asp:ListItem>
                            <asp:ListItem Value="1" Text="Pagada"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:Label runat="server" ID="lblFechaPago" Text="Fecha de Pago:" 
                            Visible="False" style="text-align: right" />
                        </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtFechaPago" CssClass="form-control2"  Visible="False" 
                            ontextchanged="txtFechaPago_TextChanged" />
                        <asp:CompareValidator runat="server" ID="cvFechaInicial" ControlToValidate="txtFechaPago"
                            Display="Dynamic" ErrorMessage="* Fecha Invalida" Operator="DataTypeCheck" Type="Date" />
                        <asp:CalendarExtender runat="server" ID="ceFechaInicial" Animated="False" PopupButtonID="txtFechaPago"
                            TargetControlID="txtFechaPago" Format="dd/MM/yyyy" />
                    </td>
                 
                </tr>
                
                <tr>
               
                     <td style="text-align: right">
                        Moneda:
                    </td>
                 
   <td class="style132"><cc1:DropDownListChosen ID="ddlMoneda" runat="server"  CausesValidation="false" 
            NoResultsText="No hay resultados coincidentes."  Width="185px"  Height="16px"   SelectMethod=""  OnSelectedIndexChanged="ddlMoneda_SelectedIndexChanged"        
            DataPlaceHolder="Escriba aquí..." AllowSingleDeselect="true" AutoPostBack="True" AppendDataBoundItems="True" 
                            >              
        </cc1:DropDownListChosen></td>  
                   
                    <td style="text-align: right">
                        <asp:Label runat="server" ID="lblTipoCambio" Text="Tipo Cambio:" 
                            Visible="False" />
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtTipoCambio" CssClass="form-control2"  Visible="False" />
                    </td>
                   <!-- <td style="text-align: right; font-weight: 700;" class="style141">Confirma<strong>c</strong>ion:</td> -->
                    <td>
                        <asp:Label runat="server" ID="LblConfirmacion" Text="Confirmación:" 
                            Visible="False" />
                    </td>
                    <td>
                    <asp:TextBox ID="txtConfirmacion" runat="server" CssClass="form-control2" visible="false"/>
                    </td>
                </tr>
          
            
                <tr runat="server" id="trDonativo" visible="False">
                    <td style="text-align: right">
                        N. de<strong> </strong>autorización del Donativo:
                    </td>
                    <td>    <asp:TextBox runat="server" ID="txtDonatAutorizacion" CssClass="form-control2" Width="156px" ></asp:TextBox>
                    
                    </td>
                    <td style="text-align: right">
                        Fecha de autorización<strong> </strong>del donativo:
                        </td>
                    <td>
                        <asp:TextBox ID="txtDonatFechautorizacion" runat="server" CssClass="form-control2" ></asp:TextBox>
                        <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" 
                            PopupButtonID="txtDonatFechautorizacion" 
                            TargetControlID="txtDonatFechautorizacion" />
                    </td>
                </tr>
               
                <tr>
			<td style="text-align: right">
				Forma de Pago
			</td>
			
                 <td>
       
       <asp:DropDownList runat="server" ID="ddlFormaPago" AutoPostBack="True" 
                         OnSelectedIndexChanged="ddlFormaPago_SelectedIndexChanged" 
                         style="margin-left: 0px"  CssClass="form-control2">
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
<asp:ListItem runat="server" Value="99" Text="Por definir" Selected="True"></asp:ListItem>
 </asp:DropDownList>

			</td>
			
			<td style="text-align: right">Método de Pago</td>
                    <td>
                        <asp:DropDownList runat="server" ID="ddlMetodoPago" AutoPostBack="True" OnSelectedIndexChanged="ddlMetodoPago_SelectedIndexChanged"  CssClass="form-control2">
                         <asp:ListItem runat="server" Value="00" Text="Seleccionar"></asp:ListItem>
                           <asp:ListItem runat="server" Text="Pago en una sola exhibición" Value="PUE"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Pago en parcialidades o diferido" Value="PPD" Selected="True"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
			 <td>Condiciones de Pago</td>
         <td><asp:TextBox ID="txtCondicionesPago" runat="server" 
                CssClass="form-control2" ></asp:TextBox></td>
		</tr>
         
         <tr>
        
         <td></td>
         <td class="style132"></td>
         
         </tr>
                <tr>
                    
                    <td style="text-align: right">UsoCFDI</td>
                    <td>
                        <asp:DropDownList ID="ddlUsoCFDI" runat="server" AutoPostBack="True" 
                            CssClass="form-control0" Width="209px"  >
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
<asp:ListItem runat="server"  Value="P01" Text="Por definir" ></asp:ListItem> 
  </asp:DropDownList>
                    </td>
                       <td>
                        Observaciones
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtProyecto"  CssClass="form-control2" Width="156px" />
                    </td>
                    <td>
                    
                        Decimales Importe</td>
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


            <div runat="server" id="divParcialidades" class="page3"  visible="False">
                <h1 style="text-align: center">
                    Parcialidades</h1>
                <table width="95%">
                    <tr>
                        <td>
                            Folio Fiscal Original
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtFolioOriginal" />
                        </td>
                        <td>
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

              <asp:Panel ID="Panel3" runat="server"  CssClass="page1" BorderStyle="Double" HorizontalAlign="Left" Width="100%" > 
         		<asp:CheckBox runat="server" ID="cbCfdiRelacionados" Text="CfdiRelacionados" 
                    AutoPostBack="True" oncheckedchanged="cbCfdiRelacionados_CheckedChanged" 
                    style="font-weight: 700; color: #0000FF;"/>
		
       
          <div id="DivCfdiRelacionados"  style="width:100%" runat="server" visible="false">
         <table width="100%">
         
<tr>
<td colspan="3"  style="text-align: right; font-weight: 700;" >

<asp:Label ID="Label1" runat="server" Text="CfdiRelacionado" Font-Bold="True"  
        style="font-size: medium; text-align: right; color: #2D5C94;"></asp:Label>
   </td>
</tr>
<tr>
         <td class="text-right">UUID:</td>
         <td>
             <asp:TextBox ID="txtUUDI" runat="server" CssClass="form-control2" 
                 Width="280px" />
         </td>
         <td class="text-right">TipoRelacion:</td>
         <td>       <asp:DropDownList runat="server" ID="ddlTipoRelacion" AutoPostBack="True" CssClass="form-control2" >
                      <asp:ListItem runat="server" Value="01" Text="01 - Nota de crédito de los documentos relacionados" />
 <asp:ListItem runat="server" Value="02" Text="02 - Nota de débito de los documentos relacionados" />
 <asp:ListItem runat="server" Value="03" Text="03 - Devolución de mercancía sobre facturas o traslados previos" />
 <asp:ListItem runat="server" Value="04" Text="04 - Sustitución de los CFDI previos" />
 <asp:ListItem runat="server" Value="05" Text="05 - Traslados de mercancias facturados previamente" />
 <asp:ListItem runat="server" Value="06" Text="06 - Factura generada por los traslados previos" />
 <asp:ListItem runat="server" Value="07" Text="07 - CFDI por aplicación de anticipo" />
             <asp:ListItem runat="server" Value="08" Text="08 - Factura generada por pagos en parcialidades" />
                 <asp:ListItem runat="server" Value="09" Text="09 - Factura generada por pagos diferidos" />
                        </asp:DropDownList>
                    
      </td>
         </tr>
<tr>
<td colspan="4" style="text-align: right">
<asp:Button runat="server" ID="btnCfdiRelacionado" Text="Agregar CfdiRelacionado" 
        ValidationGroup="AgregarCfdiRelacionado"  class="btn btn-primary" 
        onclick="btnCfdiRelacionado_Click"/>
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




               <asp:Panel ID="Panel2" runat="server" CssClass="page2" BorderStyle="Double" 
                 HorizontalAlign="Center" Width="103%" > 
     
            <h1 style="text-align: center; " class="style156">
                <strong>Conceptos</strong></h1>
            <table  class="table-hover" >
                         <tr>
                    <td style="text-align: right; font-weight: 700;">
                        <span class="style160" style="color: #FF0000">*</span>ClaveUnidad</td>
                    <td style="text-align: left;">
                    <div>    
    
     <cc1:DropDownListChosen ID="ddlClaveUnidad" runat="server"  CausesValidation="false" 
            NoResultsText="No hay resultados coincidentes." width="129px" Height="16px"  SelectMethod=""          
            DataPlaceHolder="Escriba aquí..." AllowSingleDeselect="true"  
                            AutoPostBack="true" 
                            onselectedindexchanged="ddlClaveUnidad_SelectedIndexChanged" >                
        </cc1:DropDownListChosen>  
        

        </div>
                             </td>
                    <td style="text-align: right; font-weight: 700;" class="style142"> <span class="style160" 
                            style="color: #FF0000">*</span>Unidad</td>
                    <td class="style143">
                        <asp:TextBox runat="server" ID="txtUnidad" CssClass="form-control2" Width="72px" AutoPostBack="True" />
                       </td>
                       <td style="font-weight: 700;" class="style144"><span class="style160" 
                               style="color: #FF0000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*</span>Código </td>
                <td>
                    <asp:TextBox ID="txtCodigo" runat="server" CssClass="form-control2" MaxLength="8" Width="72px" AutoPostBack="True" />
                    <script type="text/javascript"> 

                        function SoloNum(e) {
                            var key_press = document.all ? key_press = e.keyCode : key_press = e.which;
                            return (key_press > 47 && key_press < 58);
                            // el  "|| key_press == 46" es para incluir el punto ".", si borramos solo ingresara enteros 
                        }
                    </script>
                    
                    </td>
                     <td style="text-align: right" class="style162">
                          <strong style="text-align: center"><span style="color: #FF0000">
                          
                          </span>NoIdentificacion</strong></td>
                    <td>
                        <asp:TextBox ID="txtNoIdentificacion" runat="server" CssClass="form-control2" 
                            />
                        
                    </td>
                          <td class="style138"> <input type="button" value="BuscadorSAT" onclick="javascript: window.open('http://200.57.3.46:443/PyS/catPyS.aspx', '', 'width=600,height=400,left=50,top=50,toolbar=yes');" class="btn btn-primary" />
                                 </td>
                                  <td><asp:Button ID="btnBuscarProducto" runat="server" class="btn btn-primary" 
                                OnClick="btnBuscarProducto_Click" Text="ClaveProdServ" Width="125px" /></td>
                 
               
                </tr>
                <tr>
                <td></td>
                <td></td>
                <td class="style142"></td>
                   <td class="style143"><asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator6" ControlToValidate="txtUnidad"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="AgregarConcepto" style="font-size: medium" /></td>
                            <td class="style144"></td>
                            <td> <asp:RequiredFieldValidator runat="server" 
                                    ID="rfvUnidad" ControlToValidate="txtCodigo" CssClass="alert-error"
                            Display="Dynamic" ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" 
                                    style="font-size: medium" /></td>
                            </tr>
                <tr>
                    <td style="text-align: right; font-weight: 700;" width="15%" class="style158">
                        <span class="style160" style="color: #FF0000">*</span>Cantidad
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtCantidad" CssClass="form-control2"  Width="59px" />
                      
                       
                    </td>
                     <td style="text-align: right; font-weight: 700;" class="style142">
                         <span  style="color: #FF0000" >*</span>PrecioUnitario$</td>
                    <td class="style143">
                        <asp:TextBox ID="txtPrecio" runat="server" CssClass="form-control2" Width="72px" />
                    </td>
                    <td style="font-weight: 700;" class="style144">
                        <asp:CheckBox ID="descuento" runat="server" AutoPostBack="True" Checked="false" OnCheckedChanged="descuento_CheckedChanged"  Text=" % Desc" />
              </td>    <td>     <asp:TextBox ID="txtdsc" runat="server" AutoPostBack="True" CssClass="form-control2" Enabled="false"  OnTextChanged="txtdsc_TextChanged" Width="72px" ></asp:TextBox>
                     </td>
                     
                       <td style="text-align: right">  
                         Descuento</td>
                    <td>
                        
                        <asp:TextBox ID="txtDescuento" runat="server" AutoPostBack="True" CssClass="form-control2"  />
                        
                    </td>

                </tr>
                <tr>
                 <td></td>
                 <td> <asp:RequiredFieldValidator runat="server" CssClass="alert-error"
                         ID="rfvCantidad" ControlToValidate="txtCantidad"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                         ValidationGroup="AgregarConcepto" style="font-size: medium" />  
                     <asp:RegularExpressionValidator id="RegularExpressionValidator2" runat="server" Display="Dynamic" CssClass="alert-danger"
    ControlToValidate="txtCantidad" ErrorMessage="Dato invalido" 
                         ValidationExpression="[0-9]*\.?[0-9]*" 
                         ValidationGroup="AgregarConcepto" style="font-size: medium"/></td>
                 <td class="style142"></td>
                 <td><asp:RequiredFieldValidator runat="server" ID="rfvPrecio" ControlToValidate="txtPrecio" CssClass="alert-error"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                         ValidationGroup="AgregarConcepto" 
                         style="color: #FF0000; font-size: medium;" />&nbsp;
                        <asp:CompareValidator runat="server" ID="cvPrecio" ControlToValidate="txtPrecio"
                            Display="Dynamic" ErrorMessage="* Precio invalido" Type="Double" Operator="DataTypeCheck"
                            ValidationGroup="AgregarConcepto" 
                         style="color: #FF0000; font-size: medium;" /></td>
                 <td class="style143"> 
                                             &nbsp;</td>
                 <td class="style144"></td>
                 <td class="style154"></td>
                 <td></td>
                 
                  
                </tr>
                <tr>
                 <td style="text-align: right"><asp:CheckBox runat="server" ID="cbIVA" Text="IVA" 
                         AutoPostBack="True" 
                                     OnCheckedChanged="cbImp_CheckedChanged" Checked="true"/></td>
                            <td>
                                <asp:DropDownList runat="server" ID="ddlIVA" AutoPostBack="True"  
                                    CssClass="form-control0" Enabled="true" 
                                    onselectedindexchanged="ddlIVA_SelectedIndexChanged">
                         <asp:ListItem runat="server" Value="0.160000" Text="16%" Selected="True"></asp:ListItem>
                                   <asp:ListItem runat="server" Value="0.080000" Text="8%"></asp:ListItem>
                           <asp:ListItem runat="server" Text="0%" Value="0.000000"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Exento" Value="Exento"></asp:ListItem>
                        </asp:DropDownList>

                            </td>
               <td style="text-align: right; font-weight: 700;" class="style142"><asp:CheckBox runat="server" 
                       ID="cbRISR" Text="Ret ISR" AutoPostBack="True" 
                    /></td> 
                     
                      <td class="style143"> <asp:TextBox ID="txtRISR10" runat="server" CssClass="form-control0" Width="62px" Text="0.100000" Enabled="false"/>
                    </td>
                     <td style="font-weight: 700;" class="style144">
                         <asp:CheckBox runat="server" 
                             ID="cbRIVA" Text="Ret IVA" AutoPostBack="True" 
                             
                             OnCheckedChanged="cbRIVA_CheckedChanged"/>
                     </td>
                      <td>  <asp:DropDownList runat="server" ID="ddlRIVA" AutoPostBack="True"  
                              CssClass="form-control0" Enabled="false" 
                              onselectedindexchanged="ddlRIVA_SelectedIndexChanged">
                         <asp:ListItem runat="server" Value="0.106666" Text="0.106666" Selected="True">  </asp:ListItem>
                                          <asp:ListItem runat="server" Text="0.040000" Value="0.040000"></asp:ListItem>
                        </asp:DropDownList></td>
                        <td style="text-align: right; font-weight: 700;">CuentaPredial</td>
                            <td>
                                <asp:TextBox ID="txtCuentaPredial" runat="server" CssClass="form-control2" 
                                    Width="140px"  />
                             </td>  
                        <td></td>
                     
                        
                </tr>
                </table>
                <table class="table-responsive">
                <tr>
                    <td style="text-align: right; font-weight: 700;" width="15%">
                        <span class="style160" style="color: #FF0000">*</span>Descripción
                    </td>
                    <td colspan="3" style="text-align: left">
                        <asp:TextBox runat="server" ID="txtDescripcion" CssClass="form-control0"
                            TextMode="MultiLine" Width="375px" Height="68px" />
                      
                    </td>
                     <td style="text-align: right">Observaciones</td>
                    
      <td>
                        <asp:TextBox runat="server" ID="txtDetalles" CssClass="form-control2" Width="350px" Height="68px"
                            TextMode="MultiLine"  />
                    </td>
                    <td></td>
                    <td></td>
                </tr>

                <tr>
                   <td class="auto-style1"></td>
                   <td class="auto-style1">  <asp:RequiredFieldValidator runat="server" ID="rfvDescripcion" ControlToValidate="txtDescripcion"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="AgregarConcepto" 
                           style="color: #FF0000; font-size: medium;" />
                            </td>
                             <td style="text-align: left; font-weight: 700; font-size: small; color: #FF0000;" 
                                 class="auto-style1">&nbsp;Obligatorios (*)</td>
                            <td class="auto-style1"></td>
                             <td class="style154">
                                     <asp:Button ID="btnAgregar" runat="server" class="btn btn-primary" 
                                         OnClick="btnAgregar_Click" Text="Agregar Concepto" 
                                         ValidationGroup="AgregarConcepto" Width="146px" />
                                 </td>
                                 <td>
                                     <asp:Button ID="btnBuscarHistorico" runat="server" class="btn btn-primary" 
                                         OnClick="btnBuscarHistorico_Click" Text="BuscarConcepto" Width="122px" />
                                 </td>
                       
                           </tr>
                           
                
                         <caption>
                             <tr>
                               
                                <td>
                                     <asp:HiddenField ID="txtIdProducto" runat="server" />
                                 </td>
                                
                                 
                                 <td class="style141"></td> 
                               
                                
                             </tr>
                         </caption>
            </table>

            <br />

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
                        <asp:BoundField HeaderText="ValorUnitario" DataField="Precio" ItemStyle-HorizontalAlign="Center" DataFormatString= "${0:#,#.######}" />
                        <asp:BoundField HeaderText="Descripción" DataField="Descripcion" />
                        <asp:BoundField HeaderText="Importe" DataField="Total" DataFormatString= "${0:#,#.######}"  />
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
                          
        <asp:Panel ID="Panel1" runat="server"  CssClass="page3" BorderStyle="Double" HorizontalAlign="Left" Width="100%" > 
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
<td></td>
<td style="text-align: right">
    <asp:Label ID="Label12" runat="server" ForeColor="Red" Text="*"></asp:Label>
    TipoImpuesto:</td>
<td>
    <asp:DropDownList ID="ddlTipoImpuesto" runat="server" AutoPostBack="True"  CssClass="form-control2"
        onselectedindexchanged="ddlTipoImpuesto_SelectedIndexChanged">
        <asp:ListItem Value="Traslados">Traslados</asp:ListItem>
     <asp:ListItem Value="Retenciones">Retenciones</asp:ListItem>
       
    </asp:DropDownList>

    </td>
    <td style="text-align: right">
        <asp:Label ID="Label11" runat="server" ForeColor="Red" Text="*"></asp:Label>
        Base:</td>
    <td>
        <asp:TextBox ID="txtBase" runat="server" Enabled="False" CssClass="form-control2"></asp:TextBox>
        <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" 
            FilterType="Numbers, Custom" TargetControlID="txtBase" ValidChars="." />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
            ControlToValidate="txtBase" Display="Dynamic" ErrorMessage="Requerido" 
            ValidationGroup="AgregarImpuesto"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
            ControlToValidate="txtBase" Display="Dynamic" ErrorMessage="Dato invalido" 
            ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" 
            ValidationGroup="AgregarImpuesto" />
    </td>
</tr>
<tr>
<td></td>
<td class="style128"> 
    <asp:Label ID="Label10" runat="server" ForeColor="Red" Text="*"></asp:Label>
    Partida:</td>

<td class="style125">
        <asp:DropDownList ID="ddlConceptos" runat="server" AutoPostBack="True" CssClass="form-control0"
            onselectedindexchanged="ddlConceptos_SelectedIndexChanged">
            
      
    </asp:DropDownList>
        </td>
<td style="text-align: right"> 
    <asp:Label ID="Label4" runat="server" ForeColor="Red" Text="*"></asp:Label>
    TipoFactor:</td>
<td>
    <asp:DropDownList ID="ddlTipoFactor" runat="server" AutoPostBack="True" CssClass="form-control2"
        onselectedindexchanged="ddlTipoFactor_SelectedIndexChanged">
        <asp:ListItem Value="Tasa">Tasa</asp:ListItem>
        <%--<asp:ListItem Value="Cuota">Cuota</asp:ListItem>--%>
        <asp:ListItem Value="Exento">Exento</asp:ListItem>
    </asp:DropDownList>

    </td>
</tr>

<tr>
<td></td>
<td class="style127" style="text-align: right"> 
    <asp:Label ID="Label3" runat="server" ForeColor="Red" Text="*"></asp:Label>
    Impuesto:
    </td><td class="style125">
        <asp:DropDownList ID="ddlImpuesto" runat="server" AutoPostBack="True" 
        onselectedindexchanged="ddlImpuesto_SelectedIndexChanged" CssClass="form-control2"
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
        
         <asp:TextBox ID="txtTasa" runat="server" CssClass="form-control2"></asp:TextBox>
         <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender3" runat="server" 
             FilterType="Numbers, Custom" TargetControlID="txtTasa" ValidChars="." />
         <asp:DropDownList ID="ddlTasaOCuota" runat="server" DataTextField="Maximo" CssClass="form-control2"
             DataValueField="Maximo" OnSelectedIndexChanged="ddlTasaOCuota_SelectedIndexChanged">
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
        onclick="btnAgregarImpuesto_Click" Width="133px"/>
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
                     <td style="text-align: left">
                                                     
                 </td>
		</tr>
        </table>
		</div>
          <br />
   <%-- <asp:Panel ID="Panel4" runat="server"  BorderStyle="Double"  CssClass="page2"
                 HorizontalAlign="Center" Width="105%" >
   --%> 
   
 
         
          <asp:TabContainer ID="tabContainerAduana" runat="server" ActiveTabIndex="2" 
                 AutoPostBack = "true" style="margin-right: 0px" Width="105%">
         
         <asp:TabPanel ID="datosComplemento" runat="server"  HeaderText="Comercio Exterior" CssClass="page1">
                <HeaderTemplate>Comercio Exterior</HeaderTemplate>
                <ContentTemplate>

                    <h1 style="text-align: center; " class="style156">
                <strong>Comercio Exterior</strong></h1>
              <table width="95%">
                    <tr>
                        <td style="text-align: right;">
                           MotivoTraslado:
                        </td>
                        <td>
                                
       <asp:DropDownList runat="server" ID="ddlMotivoTraslado"  
                                    style="margin-left: 0px"  CssClass="form-control2" Width="200px">
  <asp:ListItem runat="server" Value="-1" Text="Seleccionar"></asp:ListItem>    
   <asp:ListItem runat="server" Value="01" Text="Envío de mercancias facturadas con anterioridad"></asp:ListItem>
   <asp:ListItem runat="server" Value="02" Text="Reubicación de mercancías propias"></asp:ListItem>
   <asp:ListItem runat="server" Value="03" Text="Envío de mercancías objeto de contrato de consignación"></asp:ListItem>
   <asp:ListItem runat="server" Value="04" Text="Envío de mercancías para posterior enajenación"></asp:ListItem>
   <asp:ListItem runat="server" Value="05" Text="Envío de mercancías propiedad de terceros"></asp:ListItem>
   <asp:ListItem runat="server" Value="00" Text="Otros"></asp:ListItem>   	 
   </asp:DropDownList>
                        </td>
                        <td style="text-align: right;">
                           <span class="style160" style="color: #FF0000">*</span> TipoOperacion:
                        </td>
                      <td>
                         <asp:DropDownList runat="server" ID="ddlTipoOperacion" style="margin-left: 0px"  CssClass="form-control2">
   <asp:ListItem runat="server" Value="2" Text="Exportación"></asp:ListItem>
   </asp:DropDownList>
                        </td>
                          <td style="text-align: right;">
                         ClaveDePedimento:
                        </td>
                        <td>
              <asp:DropDownList runat="server" ID="ddlClaveDePedimento" style="margin-left: 0px"  CssClass="form-control2" Width="200px">
               <asp:ListItem runat="server" Value="-1" Text="Seleccionar"></asp:ListItem>                      
   <asp:ListItem runat="server" Value="A1" Text="IMPORTACION O EXPORTACION DEFINITIVA"></asp:ListItem>
   </asp:DropDownList>
                        </td>
                        </tr>
                        <tr>
                        <td style="text-align: right;">
                            CertificadoOrigen:
                        </td>
                        <td> <asp:DropDownList runat="server" ID="ddlCertificadoOrigen"  
                                    style="margin-left: 0px"  CssClass="form-control2">
                             <asp:ListItem runat="server" Value="-1" Text="Seleccionar"></asp:ListItem>                      
                             <asp:ListItem runat="server" Value="0" Text="0"></asp:ListItem>
                             <asp:ListItem runat="server" Value="1" Text="1"></asp:ListItem>
                             </asp:DropDownList>
                        </td>
                        <td style="text-align: right;">
                         NumCertificadoOrigen:
                        </td>
                        <td style="text-align: right;">
                           <asp:TextBox ID="txtNumCertificadoOrigen" runat="server" CssClass="form-control2" Width="72px" />
          
                        </td>
                  
                    <td style="text-align: right;">NumeroExportadorConfiable:</td>
                    <td>  <asp:TextBox ID="txtNumeroExportadorConfiable" runat="server" CssClass="form-control2" Width="72px" />
               </td>
                 </tr>
                    <tr>
                    <td style="text-align: right;">Incoterm:</td>
                    <td><asp:DropDownList runat="server" ID="dllIncoterm"  
                                    style="margin-left: 0px"  CssClass="form-control2" Width="200px">
               <asp:ListItem runat="server" Value="-1" Text="Seleccionar"></asp:ListItem>                      
   <asp:ListItem runat="server" Value="CFR" Text="COSTE Y FLETE (PUERTO DE DESTINO CONVENIDO)"></asp:ListItem>
   <asp:ListItem runat="server" Value="CIF" Text="COSTE, SEGURO Y FLETE (PUERTO DE DESTINO CONVENIDO)"></asp:ListItem>
   <asp:ListItem runat="server" Value="CPT" Text="TRANSPORTE PAGADO HASTA (EL LUGAR DE DESTINO CONVENIDO)"></asp:ListItem>
   <asp:ListItem runat="server" Value="CIP" Text="TRANSPORTE Y SEGURO PAGADOS HASTA (LUGAR DE DESTINO CONVENIDO)"></asp:ListItem>
   <asp:ListItem runat="server" Value="DAF" Text="ENTREGADA EN FRONTERA (LUGAR CONVENIDO)"></asp:ListItem>
   <asp:ListItem runat="server" Value="DAP" Text="ENTREGADA EN LUGAR"></asp:ListItem>
   <asp:ListItem runat="server" Value="DAT" Text="ENTREGADA EN TERMINAL"></asp:ListItem>
   <asp:ListItem runat="server" Value="DES" Text="ENTREGADA SOBRE BUQUE (PUERTO DE DESTINO CONVENIDO)"></asp:ListItem>
   <asp:ListItem runat="server" Value="DEQ" Text="ENTREGADA EN MUELLE (PUERTO DE DESTINO CONVENIDO)"></asp:ListItem>
   <asp:ListItem runat="server" Value="DDU" Text="ENTREGADA DERECHOS NO PAGADOS (LUGAR DE DESTINO CONVENIDO)"></asp:ListItem>
   <asp:ListItem runat="server" Value="DDP" Text="ENTREGADA DERECHOS PAGADOS (LUGAR DE DESTINO CONVENIDO)"></asp:ListItem>
  <asp:ListItem runat="server" Value="DPU" Text="ENTREGADA Y DESCARGADA EN LUGAR ACORDADO"></asp:ListItem>
   <asp:ListItem runat="server" Value="EXW" Text="EN FABRICA (LUGAR CONVENIDO)"></asp:ListItem>
   <asp:ListItem runat="server" Value="FCA" Text="FRANCO TRANSPORTISTA (LUGAR DESIGNADO)"></asp:ListItem>   
   <asp:ListItem runat="server" Value="FAS" Text="FRANCO AL COSTADO DEL BUQUE (PUERTO DE CARGA CONVENIDO)"></asp:ListItem>
   <asp:ListItem runat="server" Value="FOB" Text="FRANCO A BORDO (PUERTO DE CARGA CONVENIDO)"></asp:ListItem>
   </asp:DropDownList></td>
   
                    <td style="text-align: right;">Subdivision:</td>
                    <td><asp:DropDownList runat="server" ID="ddlSubdivision"  
                                    style="margin-left: 0px"  CssClass="form-control2">
               <asp:ListItem runat="server" Value="-1" Text="Seleccionar"></asp:ListItem>                      
   <asp:ListItem runat="server" Value="0" Text="0"></asp:ListItem>
   <asp:ListItem runat="server" Value="1" Text="1"></asp:ListItem>
   </asp:DropDownList></td>
                                  
                    <td style="text-align: right;">TipoCambioUSD:</td>
                    <td><asp:TextBox ID="txtTipoCambioUSD" runat="server" CssClass="form-control2"  />
                       <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender24" runat="server"
    TargetControlID="txtTipoCambioUSD" FilterType="Custom, Numbers" ValidChars="." Enabled="True" />
                          </td> 
                             </tr>
                    <tr>     
       <td style="text-align: right;">TotalUSD:</td>
                    <td><asp:TextBox ID="txtTotalUSD" runat="server" CssClass="form-control2"  />
                     <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender23" runat="server"
    TargetControlID="txtTotalUSD" FilterType="Custom, Numbers" ValidChars="." Enabled="True" />
      </td>
                    <td style="text-align: right;">Observaciones:</td>
                    <td  colspan="4"><asp:TextBox ID="txtObservacionesCE" runat="server" CssClass="form-control2"/>
            </td>
                    </tr>
                    <tr>
                    <td>
                    </td>
                    <td>
                    <asp:RegularExpressionValidator id="RegularExpressionValidator3" 
            runat="server" Display="Dynamic" CssClass="alert-danger"
    ControlToValidate="txtTipoCambioUSD" ErrorMessage="Dato invalido" 
                         ValidationExpression="[0-9]*\.?[0-9]*" 
                         ValidationGroup="CrearFactura" style="font-size: medium"/>
                    </td>
                    <td>
                    </td>
                    <td>
                     <asp:RegularExpressionValidator id="RegularExpressionValidator4" 
            runat="server" Display="Dynamic" CssClass="alert-danger"
    ControlToValidate="txtTotalUSD" ErrorMessage="Dato invalido" 
                         ValidationExpression="[0-9]*\.?[0-9]*" 
                         ValidationGroup="CrearFactura" style="font-size: medium"/>
                    </td>
                    </tr>

               </table>
           
                </ContentTemplate>
                </asp:TabPanel>
   
           <asp:TabPanel ID="TabPanel2" runat="server"  HeaderText="Datos" CssClass="page1" >
                <HeaderTemplate>Datos</HeaderTemplate>
                <ContentTemplate>
                
                   <asp:UpdatePanel ID="UpdatePanel1" runat="server"  UpdateMode="Conditional"  >
               <ContentTemplate>
            
                  <h1 style="text-align: center; " class="style156">
                <strong>Datos</strong></h1>
               <div style="border: solid 2px gray">
               &nbsp;&nbsp;&nbsp; <asp:CheckBox runat="server" ID="cbEmisor" Text="Emisor"  
                    AutoPostBack="True" oncheckedchanged="cbEmisor_CheckedChanged" 
                    style="font-weight: 700; color:Black;"/>
		
       
                <div id="DivEmisor"  style="width:100%" runat="server" visible="False">
                 <h1 style="text-align: center; " class="style156">
                <strong>Emisor</strong></h1>
                <table width="100%">
                <tr>
                <td></td>
                       <td style="text-align: right;">Curp:</td>
                      <td>   <asp:TextBox ID="txtCurp" runat="server" CssClass="form-control2"  MaxLength="13"></asp:TextBox>
                      </td>
                       </tr>
                     <tr>
                     <td></td>
                     </tr>
                </table>

                   <div style="width:100%;align-items: center;display: flex; justify-content: center;">
                 <div style="border: solid 2px gray; width:90%" >
               &nbsp;&nbsp;&nbsp; <asp:CheckBox runat="server" ID="cbDomicilioEmisor" Text="Domicilio" 
                    AutoPostBack="True" oncheckedchanged="cbDomicilioEmisor_CheckedChanged" 
                    style="font-weight: 700; color:Black;"/>
		       
                <div id="DivcbDomicilioEmisor"  style="width:100%;" runat="server" visible="False">
                 <h1 style="text-align: center; " class="style156">
                <strong>Domicilio</strong></h1>
                <table>
                      <tr>
                       <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>Pais:</td>
           <td><cc1:DropDownListChosen ID="ddlPaisOperador" runat="server"  CausesValidation="false" 
            NoResultsText="No hay resultados coincidentes."  Width="185px"  Height="16px"   SelectMethod=""          
            DataPlaceHolder="Escriba aquí..." AllowSingleDeselect="true"  onselectedindexchanged="ddlPaisOperador_SelectedIndexChanged" AutoPostBack="True" AppendDataBoundItems="True" >              
            </cc1:DropDownListChosen></td>
               <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>Estado:</td>
               <td>   <asp:TextBox ID="txtEstadoOperador" runat="server" CssClass="form-control2"  MaxLength="30"></asp:TextBox>
                <asp:DropDownList ID="dllEstadoOperador" runat="server" CssClass="form-control2" Width="180px" 
                  style="margin-left: 0px" AutoPostBack="True"  onselectedindexchanged="dllEstadoOperador_SelectedIndexChanged">
               </asp:DropDownList>
                      </td>
               
                            <td style="text-align: right;">Municipio:</td>
                      <td>   <asp:TextBox ID="txtMunicipioOperador" runat="server" CssClass="form-control2"  MaxLength="120"></asp:TextBox>
                    <asp:DropDownList ID="ddlMunicipioOperador" runat="server" CssClass="form-control2" Width="180px" 
                  style="margin-left: 0px" AutoPostBack="True" >
               </asp:DropDownList>
                 
                      </td>
                 
                      </tr>
                      <tr>
                      <td></td>
                      <td><asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator57" ControlToValidate="ddlPaisOperador"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="CrearFactura" style="font-size: medium" /></td>
                      <td></td>
                      <td><asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator42" ControlToValidate="txtEstadoOperador"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="CrearFactura" style="font-size: medium" /></td>
                           <td></td>
                           <td></td>
                      </tr>
               
                <tr>
                         <td style="text-align: right;">Localidad:</td>
                      <td>   <asp:TextBox ID="txtLocalidadOperador" runat="server" CssClass="form-control2"  MaxLength="120"></asp:TextBox>
                          <asp:DropDownList ID="dllLocalidadOperador" runat="server" CssClass="form-control2" Width="180px" 
                  style="margin-left: 0px" AutoPostBack="True" >
               </asp:DropDownList>
                      </td>
                          <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>CodigoPostal:</td>
                      <td>   <asp:TextBox ID="txtCodigoPostalOperador" runat="server" CssClass="form-control2"  MaxLength="12"></asp:TextBox>
                      </td>
                    
                           <td style="text-align: right;">Referencia:</td>
                      <td>   <asp:TextBox ID="txtReferenciaOperador" runat="server" CssClass="form-control2"  MaxLength="250"></asp:TextBox>
                      </td>
                           
                      </tr>
                      <tr>
                      <td></td>
                      <td></td>
                      <td></td>
                      <td><asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator43" ControlToValidate="txtCodigoPostalOperador"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="CrearFactura" style="font-size: medium" /></td>

                      </tr>
                      <tr>
                             <td style="text-align: right;">Colonia:</td>
                      <td>   <asp:TextBox ID="txtColoniaOperador" runat="server" CssClass="form-control2" Width="250px"  MaxLength="120"></asp:TextBox>
                      </td>
                          <td style="text-align: right;">NumeroExterior:</td>
                      <td>   <asp:TextBox ID="txtNumeroExteriorOperador" runat="server" CssClass="form-control2"  MaxLength="55"></asp:TextBox>
                      </td>
                                 <td style="text-align: right;">NumeroInterior:</td>
                      <td>   <asp:TextBox ID="txtNumeroInteriorOperador" runat="server" CssClass="form-control2"  MaxLength="55"></asp:TextBox>
                      </td>
                      </tr>
                      <tr>
                      <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>Calle:</td>
                      <td>   <asp:TextBox ID="txtCalleOperador" runat="server" CssClass="form-control2" Width="250px"  MaxLength="100"></asp:TextBox>
                      </td>
                      
                      </tr>
                      <tr>
                     <td></td>
                     <td>
                           <asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator41" ControlToValidate="txtCalleOperador"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="CrearFactura" style="font-size: medium" />
                           </td> </tr>
                </table>
                </div>
                </div>
                </div>

         
         </div>
         </div>

                 <div style="border: solid 2px gray">
               &nbsp;&nbsp;&nbsp; <asp:CheckBox runat="server" ID="cbPropietario" Text="Propietario"  
                    AutoPostBack="True" oncheckedchanged="cbPropietario_CheckedChanged" 
                    style="font-weight: 700; color:Black;"/>
		
       
                <div id="DivPropietario"  style="width:100%" runat="server" visible="False">
                 <h1 style="text-align: center; " class="style156">
                <strong>Propietario</strong></h1>
                <table width="100%">
                <tr>
                      <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>NumRegIdTrib:</td>
                      <td>   <asp:TextBox ID="txtNumRegIdTribPropietario" runat="server" CssClass="form-control2"  MaxLength="40"></asp:TextBox>
                      </td>
                      <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>ResidenciaFiscal:</td>
           <td><cc1:DropDownListChosen ID="ddlResidenciaFiscalPropietario" runat="server"  CausesValidation="false" 
            NoResultsText="No hay resultados coincidentes."  Width="185px"  Height="16px"   SelectMethod=""          
            DataPlaceHolder="Escriba aquí..." AllowSingleDeselect="true" AutoPostBack="True" AppendDataBoundItems="True" >              
        </cc1:DropDownListChosen></td>
                     </tr>
                     <tr>
                     <td></td>
                      <td><asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator10" ControlToValidate="txtNumRegIdTribPropietario"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="AgregarPropietario" style="font-size: medium" /></td>
                 <td></td>
                      <td><asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator12" ControlToValidate="ddlResidenciaFiscalPropietario"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="AgregarPropietario" style="font-size: medium" /></td>
                     </tr>
                </table>

                                 
                  <table width="90%" >
          <tr>
            <td style="text-align: right;" ><div style="width:100%; ">  
            <asp:Button runat="server" ID="btnPropietario" Text="Agregar Propietario" 
        ValidationGroup="AgregarPropietario"  class="btn btn-primary" 
        onclick="btnPropietario_Click" Width="133px"/>
        </div>
        </td>
        <td></td>
          </tr>
           </table>


                  <div style="height: 100%; overflow-y: scroll" >
                <asp:GridView runat="server" ID="gvPropietario" AutoGenerateColumns="False"  CssClass="style124" Width="100%" 
                HorizontalAlign="Center"   ShowHeaderWhenEmpty="True" OnRowCommand="gvPropietario_RowCommand">
                    <Columns>
                      <asp:BoundField HeaderText="Propietario" DataField="id" Visible="false">
                       
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                         <asp:BoundField HeaderText="NumRegIdTrib" DataField="NumRegIdTrib" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                          <asp:BoundField HeaderText="ResidenciaFiscal" DataField="ResidenciaFiscal" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                         <asp:ButtonField Text="Eliminar" CommandName="EliminarPropietario" Visible="False" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:ButtonField>
                    </Columns>
                </asp:GridView>
            </div>



                </div>
                </div>

                   <div style="border: solid 2px gray">
               &nbsp;&nbsp;&nbsp; <asp:CheckBox runat="server" ID="cbReceptor" Text="Receptor"   
                    AutoPostBack="True" oncheckedchanged="cbReceptor_CheckedChanged" 
                    style="font-weight: 700; color:Black;"/>
		
       
                <div id="DivReceptor"  style="width:100%" runat="server" visible="False">
                 <h1 style="text-align: center; " class="style156">
                <strong>Receptor</strong></h1>
                 <table width="100%">
                <tr>

                <td></td>
                       <td style="text-align: right;">NumRegIdTrib:</td>
                      <td>   <asp:TextBox ID="txtNumRegIdTribReceptor" runat="server" CssClass="form-control2"  MaxLength="40"></asp:TextBox>
                      </td>
                     </tr>
                    <tr><td></td></tr>
                </table>

                 <div style="width:100%;align-items: center;display: flex; justify-content: center;">
                 <div style="border: solid 2px gray; width:90%" >
               &nbsp;&nbsp;&nbsp; <asp:CheckBox runat="server" ID="cbDomicilioReceptor" Text="Domicilio" 
                    AutoPostBack="True" oncheckedchanged="cbDomicilioReceptor_CheckedChanged" 
                    style="font-weight: 700; color:Black;"/>
		
       
                <div id="DivDomicilioReceptor"  style="width:100%;" runat="server" visible="False">
        

                 <h1 style="text-align: center; " class="style156">
                <strong>Domicilio</strong></h1>
                <table>
                 <tr>
                   <td style="text-align: right;" ><span class="style160" style="color: #FF0000">*</span>Pais:</td>
                   <td class="style147"><cc1:DropDownListChosen ID="ddlPaisArrendatario" runat="server"  CausesValidation="false" 
                     NoResultsText="No hay resultados coincidentes."  Width="185px"  Height="16px"   SelectMethod=""          
                     DataPlaceHolder="Escriba aquí..." AllowSingleDeselect="true" onselectedindexchanged="ddlPaisArrendatario_SelectedIndexChanged" AutoPostBack="True" AppendDataBoundItems="True" >              
                    </cc1:DropDownListChosen></td>
                        <td style="text-align: right;" ><span class="style160" style="color: #FF0000">*</span>Estado:</td>
                      <td class="style147">   <asp:TextBox ID="txtEstadoArrendatario" runat="server" CssClass="form-control2"  MaxLength="30"></asp:TextBox>
                          <asp:DropDownList ID="dllEstadoArrendatario" runat="server" CssClass="form-control2" Width="180px" 
                  style="margin-left: 0px" AutoPostBack="True"  onselectedindexchanged="dllEstadoArrendatario_SelectedIndexChanged">
               </asp:DropDownList>
                      </td>
                          <td style="text-align: right;" >Municipio:</td>
                      <td class="style147"> <asp:TextBox ID="txtMunicipioArrendatario" runat="server" CssClass="form-control2"  MaxLength="120"></asp:TextBox>
                          <asp:DropDownList ID="ddlMunicipioArrendatario" runat="server" CssClass="form-control2" Width="180px" 
                  style="margin-left: 0px" AutoPostBack="True" >
               </asp:DropDownList>
                      </td>
                        </tr>
                      <tr>
                      <td></td>
                      <td><asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator59" ControlToValidate="ddlPaisArrendatario"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="CrearFactura" style="font-size: medium" /></td>
                      <td></td>
                      <td><asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator48" ControlToValidate="txtEstadoArrendatario"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="CrearFactura" style="font-size: medium" /></td>
                           <td></td>
                            <td></td>
                     
                      </tr>
                    <tr>
                     <td style="text-align: right;">Localidad:</td>
                      <td>   <asp:TextBox ID="txtLocalidadArrendatario" runat="server" CssClass="form-control2"  MaxLength="120"></asp:TextBox>
                       <asp:DropDownList ID="dllLocalidadArrendatario" runat="server" CssClass="form-control2" Width="180px" 
                  style="margin-left: 0px" AutoPostBack="True" >
               </asp:DropDownList>
                      </td>
                         <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>CodigoPostal:</td>
                      <td>   <asp:TextBox ID="txtCodigoPostalArrendatario" runat="server" CssClass="form-control2"  MaxLength="12"></asp:TextBox>
                      </td>
                      
                                 <td style="text-align: right;">Referencia:</td>
                      <td>   <asp:TextBox ID="txtReferenciaArrendatario" runat="server" CssClass="form-control2"  MaxLength="250"></asp:TextBox>
                      </td>
                                                
                      </tr>
                      <tr>
                      <td></td>
                      <td></td>
                      <td></td>
                      <td>
                     <asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator49" ControlToValidate="txtCodigoPostalArrendatario"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="CrearFactura" style="font-size: medium" /></td>
                      </tr>
                      <tr>
                             <td style="text-align: right;">Colonia:</td>
                      <td>   <asp:TextBox ID="txtColoniaArrendatario" runat="server" CssClass="form-control2" Width="250px"  MaxLength="120"></asp:TextBox>
                      </td>
                       <td style="text-align: right;">NumeroExterior:</td>
                      <td>   <asp:TextBox ID="txtNumeroExteriorArrendatario" runat="server" CssClass="form-control2"  MaxLength="55"></asp:TextBox>
                      </td>
                                 <td style="text-align: right;">NumeroInterior:</td>
                      <td>   <asp:TextBox ID="txtNumeroInteriorArrendatario" runat="server" CssClass="form-control2"  MaxLength="55"></asp:TextBox>
                      </td>        
                      </tr>
                        <tr>
                      <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>Calle:</td>
                      <td>   <asp:TextBox ID="txtCalleArrendatario" runat="server" CssClass="form-control2" Width="250px"  MaxLength="100"></asp:TextBox>
                      </td>
                           
                      </tr>
                      <tr>
                     <td></td>
                     <td>
                     <asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator47" ControlToValidate="txtCalleArrendatario"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="CrearFactura" style="font-size: medium" /></td> </tr>
                </table>
                </div>
                </div>
                </div>
                   
              </div>
               </div>

                <div style="border: solid 2px gray">
               &nbsp;&nbsp;&nbsp; <asp:CheckBox runat="server" ID="cbDestinatario" Text="Destinatario"   
                    AutoPostBack="True" oncheckedchanged="cbDestinatario_CheckedChanged" 
                    style="font-weight: 700; color:Black;"/>
		
     
                <div id="DivDestinatario"  style="width:100%" runat="server" visible="False">
               
             <h1 style="text-align: center; " class="style156">
                <strong>Destinatario</strong></h1>
              <table width="100%">
                <tr>
                       <td style="text-align: right;">Nombre:</td>
                      <td>   <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control2"  MaxLength="254"></asp:TextBox>
                      </td>
                     
                             <td style="text-align: right;">NumRegIdTrib:</td>
                      <td>   <asp:TextBox ID="txtNumRegIdTribDestinatario" runat="server" CssClass="form-control2"  MaxLength="40"></asp:TextBox>
                      </td>
                     </tr>
                     <tr><td></td></tr>
                     </table>
                          
            <table width="90%" >
          <tr>
            <td style="text-align: right;" ><div >  <asp:Button runat="server" ID="btnDestinatarioComple" Text="Agregar Destinatario" 
         class="btn btn-primary" 
        onclick="btnDestinatarioComple_Click" Width="133px"/></div></td>
        <td></td>
          </tr>
           </table>
                        <div style="height: 100%; overflow-y: scroll" >
                <asp:GridView runat="server" ID="gvDestinatarioComple" AutoGenerateColumns="False"  CssClass="style124" Width="100%" 
                HorizontalAlign="Center"   ShowHeaderWhenEmpty="True" OnRowCommand="gvDestinatarioComple_RowCommand">
                    <Columns>
                      <asp:BoundField HeaderText="ID" DataField="id"  >
                       
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="NumRegIdTrib" DataField="NumRegIdTrib" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="Nombre" DataField="Nombre" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                         <asp:ButtonField Text="Eliminar" CommandName="EliminarDestinatario" Visible="False" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:ButtonField>
                    </Columns>
                </asp:GridView>
            </div>


                  
                                   <div style="width:100%;align-items: center;display: flex; justify-content: center;">
                 <div style="border: solid 2px gray; width:90%" >
               &nbsp;&nbsp;&nbsp; <asp:CheckBox runat="server" ID="cbDomicilioDestinatario" Text="Domicilio" 
                    AutoPostBack="True" oncheckedchanged="cbDomicilioDestinatario_CheckedChanged" 
                    style="font-weight: 700; color:Black;"/>
	 
                <div id="DivDomicilioDestinatario"  style="width:100%;" runat="server" visible="False">
     
                 <h1 style="text-align: center; " class="style156">
                <strong>Domicilio</strong></h1>
        
           <table width="100%">
                <tr>
                       <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>Pais:</td>
           <td><cc1:DropDownListChosen ID="ddlPaisNotificado" runat="server"  CausesValidation="false" 
            NoResultsText="No hay resultados coincidentes."  Width="185px"  Height="16px"   SelectMethod=""          
            DataPlaceHolder="Escriba aquí..." AllowSingleDeselect="true" onselectedindexchanged="ddlPaisNotificado_SelectedIndexChanged" AutoPostBack="True" AppendDataBoundItems="True" >              
        </cc1:DropDownListChosen></td>
                              <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>Estado:</td>
                      <td>   <asp:TextBox ID="txtEstadoNotificado" runat="server" CssClass="form-control2"  MaxLength="30"></asp:TextBox>
                      <asp:DropDownList ID="dllEstadoNotificado" runat="server" CssClass="form-control2" Width="180px" 
                  style="margin-left: 0px" AutoPostBack="True"  onselectedindexchanged="dllEstadoNotificado_SelectedIndexChanged">
               </asp:DropDownList>
                      </td>
                            <td style="text-align: right;">Municipio:</td>
                      <td>   <asp:TextBox ID="txtMunicipioNotificado" runat="server" CssClass="form-control2"  MaxLength="120"></asp:TextBox>
                           <asp:DropDownList ID="ddlMunicipioNotificado" runat="server" CssClass="form-control2" Width="180px" 
                  style="margin-left: 0px" AutoPostBack="True" >
               </asp:DropDownList>   </td>
                     
                      </tr>
                      <tr>
                      <td></td>
                      <td><asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator60" ControlToValidate="ddlPaisNotificado"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="AgregarDomicilio" style="font-size: medium" /></td>
                      <td></td>
                      <td><asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator51" ControlToValidate="txtEstadoNotificado"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="AgregarDomicilio" style="font-size: medium" /></td>
                           <td></td>
                           <td></td>
                      </tr>
                      
                <tr>
                <td style="text-align: right;">Localidad:</td>
                      <td>   <asp:TextBox ID="txtLocalidadNotificado" runat="server" CssClass="form-control2"  MaxLength="120"></asp:TextBox>
                     <asp:DropDownList ID="dllLocalidadNotificado" runat="server" CssClass="form-control2" Width="180px" 
                  style="margin-left: 0px" AutoPostBack="True" >
               </asp:DropDownList> 
                      </td>
                     <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>CodigoPostal:</td>
                      <td>   <asp:TextBox ID="txtCodigoPostalNotificado" runat="server" CssClass="form-control2"  MaxLength="12"></asp:TextBox>
                      </td>
                                          <td style="text-align: right;">Referencia:</td>
                      <td>   <asp:TextBox ID="txtReferenciaNotificado" runat="server" CssClass="form-control2"  MaxLength="250"></asp:TextBox>
                      </td>
                           
                      </tr>
                      <tr>
                      <td></td>
                      <td></td>
                      <td></td>
                      <td><asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator52" ControlToValidate="txtCodigoPostalNotificado"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="AgregarDomicilio" style="font-size: medium" /></td>

                      </tr>
                      <tr>
                             <td style="text-align: right;">Colonia:</td>
                      <td>   <asp:TextBox ID="txtColoniaNotificado" runat="server" CssClass="form-control2" Width="250px"  MaxLength="120"></asp:TextBox>
                      </td>
                            <td style="text-align: right;">NumeroExterior:</td>
                      <td>   <asp:TextBox ID="txtNumeroExteriorNotificado" runat="server" CssClass="form-control2"  MaxLength="55"></asp:TextBox>
                      </td>
                                 <td style="text-align: right;">NumeroInterior:</td>
                      <td>   <asp:TextBox ID="txtNumeroInteriorNotificado" runat="server" CssClass="form-control2"  MaxLength="55"></asp:TextBox>
                      </td>    
                      </tr>
                      <tr>
                           
                      <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>Calle:</td>
                      <td>   <asp:TextBox ID="txtCalleNotificado" runat="server" CssClass="form-control2" Width="250px"  MaxLength="100"></asp:TextBox>
                      </td>
                        <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>Destinatario:</td>
                      <td>     <asp:DropDownList ID="ddlDestinatarios" runat="server" CssClass="form-control0">
                      </asp:DropDownList> </td>    
                      </tr>
                      <tr>
                     <td></td>
                     <td>
                           <asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator50" ControlToValidate="txtCalleNotificado"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="AgregarDomicilio" style="font-size: medium" />
                           </td><td></td>
                           <td> <asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator13" ControlToValidate="ddlDestinatarios"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="AgregarDomicilio" style="font-size: medium" /></td> </tr>
                </table>
             
                
            <table width="90%" >
          <tr>
            <td style="text-align: right;" ><div >  <asp:Button runat="server" ID="Button6" Text="Agregar Domicilio" 
        ValidationGroup="AgregarDomicilio"  class="btn btn-primary" 
        onclick="btnDomicilio_Click" Width="133px"/></div></td>
        <td></td>
          </tr>
           </table>
               
                        <div style="height: 100%; overflow-y: scroll" >
                <asp:GridView runat="server" ID="gvDestinatario" AutoGenerateColumns="False"  CssClass="style124" Width="100%" 
                HorizontalAlign="Center"   ShowHeaderWhenEmpty="True" OnRowCommand="gvDestinatario_RowCommand">
                    <Columns>
                      <asp:BoundField HeaderText="Destinatario" DataField="idDestinatario" >
                       
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="Estado" DataField="estado" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="Pais" DataField="pais" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                          <asp:BoundField HeaderText="CP" DataField="codigoPostal" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                          <asp:ButtonField Text="Eliminar" CommandName="EliminarDomicilio" Visible="False" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:ButtonField>
                    </Columns>
                </asp:GridView>
            </div>

            
              </div>

                </div>
                </div>
              


                </div>
                </div>
                 </ContentTemplate>
                 </asp:UpdatePanel>
                 </ContentTemplate>
                 </asp:TabPanel>
     
         <asp:TabPanel ID="TabPanel3" runat="server"  HeaderText="Mercancias" CssClass="page1" >
                <HeaderTemplate>Mercancias</HeaderTemplate>
                <ContentTemplate>
                
           
                    <h1 style="text-align: center; " class="style156">
                    <strong>Mercancias</strong></h1>
            <table >
            <tr>
              <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>
                         NoIdentificacion:
                        </td>
                        <td>
                           <asp:TextBox ID="txtNoIdentificacionM" runat="server" CssClass="form-control2" Width="72px" />
                        </td>
                     <td style="text-align: right;">FraccionArancelaria:</td>
                     <td>   <asp:TextBox ID="txtFraccionArancelaria" runat="server" CssClass="form-control2"></asp:TextBox>
                     </td> 
                     <td style="text-align: right;">
                         CantidadAduana:
                        </td>
                        <td>
                           <asp:TextBox ID="txtCantidadAduana" runat="server" CssClass="form-control2" Width="72px" />
          <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server"
    TargetControlID="txtCantidadAduana" FilterType="Custom, Numbers" ValidChars="." Enabled="True" />
                        </td>
                        <td style="text-align: right;">
                       UnidadAduana:
                        </td>
                        <td>
                           <asp:DropDownList runat="server" ID="ddlUnidadAduana"  
                  style="margin-left: 0px"  CssClass="form-control2">
                     <asp:ListItem runat="server" Value="00" Text="Seleccionar"></asp:ListItem>
   <asp:ListItem Value="01" Text="KILO"></asp:ListItem>             
   <asp:ListItem Value="02" Text="GRAMO"></asp:ListItem>
   <asp:ListItem Value="03" Text="METRO LINEAL"></asp:ListItem>
   <asp:ListItem Value="04" Text="METRO CUADRADO"></asp:ListItem>
   <asp:ListItem Value="05" Text="METRO CUBICO"></asp:ListItem>
   <asp:ListItem Value="06" Text="PIEZA"></asp:ListItem>
   <asp:ListItem Value="07" Text="CABEZA"></asp:ListItem>
   <asp:ListItem Value="08" Text="LITRO"></asp:ListItem>
   <asp:ListItem Value="09" Text="PAR"></asp:ListItem>
   <asp:ListItem Value="10" Text="KILOWATT"></asp:ListItem>
   <asp:ListItem Value="11" Text="MILLAR"></asp:ListItem>
   <asp:ListItem Value="12" Text="JUEGO"></asp:ListItem>
   <asp:ListItem Value="13" Text="KILOWATT/HORA"></asp:ListItem>
   <asp:ListItem Value="14" Text="TONELADA"></asp:ListItem>
   <asp:ListItem Value="15" Text="BARRIL"></asp:ListItem>
   <asp:ListItem Value="16" Text="GRAMO NETO"></asp:ListItem>
   <asp:ListItem Value="17" Text="DECENAS"></asp:ListItem>
   <asp:ListItem Value="18" Text="CIENTOS"></asp:ListItem>
   <asp:ListItem Value="19" Text="DOCENAS"></asp:ListItem>
   <asp:ListItem Value="20" Text="CAJA"></asp:ListItem>
   <asp:ListItem Value="21" Text="BOTELLA"></asp:ListItem>
   <asp:ListItem Value="22" Text="CARAT"></asp:ListItem>
   <asp:ListItem Value="99" Text="SERVICIO"></asp:ListItem>
   </asp:DropDownList>
                        </td>
                                              
            </tr>
           <tr>
            <td></td>

            <td>   <asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator8" ControlToValidate="txtNoIdentificacionM"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="AgregarMercancias" style="font-size: medium" />         
                         </td>
                         <td></td>
                         <td></td>
                        <td></td>

                         <td><asp:RegularExpressionValidator id="RegularExpressionValidator6" runat="server"
                          Display="Dynamic" CssClass="alert-danger"
    ControlToValidate="txtCantidadAduana" ErrorMessage="Dato invalido" 
                         ValidationExpression="[0-9]*\.?[0-9]*" 
                         ValidationGroup="AgregarMercancias" style="font-size: medium"/></td>
                         
                      
                        </tr>
<tr>
<td style="text-align: right;">ValorUnitarioAduana:</td>
<td>       <asp:TextBox ID="txtValorUnitarioAduana" runat="server" CssClass="form-control2" Width="72px" />
          <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender4" runat="server"
            TargetControlID="txtValorUnitarioAduana" FilterType="Custom, Numbers" 
        ValidChars="." Enabled="True" />
           </td>
           <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>ValorDolares:</td>
           <td>  <asp:TextBox ID="txtValorDolares" runat="server" CssClass="form-control2" Width="72px" />
          <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender25" runat="server"
            TargetControlID="txtValorDolares" FilterType="Custom, Numbers" 
        ValidChars="." Enabled="True" /></td>
</tr>
<tr>
<td></td>
   <td>      <asp:RegularExpressionValidator id="RegularExpressionValidator7" runat="server" Display="Dynamic" CssClass="alert-danger"
    ControlToValidate="txtValorUnitarioAduana" ErrorMessage="Dato invalido" 
                         ValidationExpression="[0-9]*\.?[0-9]*" 
                         ValidationGroup="AgregarMercancias" style="font-size: medium"/>
                       
                         </td>
                         <td></td>
                         <td>
                          <asp:RegularExpressionValidator id="RegularExpressionValidator5" runat="server" 
                          Display="Dynamic" CssClass="alert-danger"
    ControlToValidate="txtValorDolares" ErrorMessage="Dato invalido" 
                         ValidationExpression="[0-9]*\.?[0-9]*" 
                         ValidationGroup="AgregarMercancias" style="font-size: medium"/>
                         <asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator9" ControlToValidate="txtValorDolares"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="AgregarMercancias" style="font-size: medium" />    
                         </td>
</tr>
         </table>

               <table width="90%" >
          <tr>
            <td style="text-align: right;" ><div style="width=100%; ">
            <asp:Button runat="server" ID="Button3" Text="Agregar Mercancia" 
        ValidationGroup="AgregarMercancias"  class="btn btn-primary" 
        onclick="AgregarMercancias_Click" Width="133px"/>
        </div>
        </td>
        <td></td>
          </tr>
           </table>
             <div style="height: 100%; overflow-y: scroll" >
                <asp:GridView runat="server" ID="gvMercancia" AutoGenerateColumns="False" 
                 CssClass="style124" Width="100%" HorizontalAlign="Center"
                    ShowHeaderWhenEmpty="True" OnRowCommand="gvMercancia_RowCommand">
                    <Columns>
                      <asp:BoundField HeaderText="ID" DataField="id" >
                       
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                       
                        <asp:BoundField HeaderText="NoIdentificacion" DataField="NoIdentificacion" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="FraccionArancelaria" DataField="FraccionArancelaria" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="CantidadAduana" DataField="CantidadAduana" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="UnidadAduana" 
                            DataField="UnidadAduana" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="ValorUnitarioAduana" DataField="ValorUnitarioAduana" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="ValorDolares" DataField="ValorDolares" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:ButtonField Text="Eliminar" CommandName="EliminarMercancia" Visible="False" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:ButtonField>
                    </Columns>
                </asp:GridView>
            </div>


               
                   <h1 style="text-align: center; " class="style156">
                    <strong>DescripcionesEspecificas</strong></h1>
           <table width="100%" >
           <tr>
               <td style="text-align: right;"> <span class="style160" style="color: #FF0000">*</span>Mercancia:</td>
           <td>      <asp:DropDownList ID="ddlIDMercancia" runat="server" CssClass="form-control0">
                      </asp:DropDownList>
          </td>
         
             <td style="text-align: right;"> <span class="style160" style="color: #FF0000">*</span>Marca:</td>
           <td>   <asp:TextBox ID="txtMarca" runat="server" CssClass="form-control2"  Width="72px"
                   ></asp:TextBox>
          </td>
           <td style="text-align: right;">Modelo:</td>
           <td>   <asp:TextBox ID="txtModelo" runat="server" CssClass="form-control2" Width="72px"
                   ></asp:TextBox>
          </td>
             <td  style="text-align: right;">SubModelo:</td>
           <td>   <asp:TextBox ID="txtSubModelo" runat="server" CssClass="form-control2" Width="72px" 
                   ></asp:TextBox>
          </td>
          <td style="text-align: right;">NumeroSerie:</td>
          <td><asp:TextBox ID="txtNumeroSerie" runat="server" CssClass="form-control2" Width="72px" 
                   ></asp:TextBox></td>
           </tr>
           <tr>
           <td></td>
           <td><asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidatorx" ControlToValidate="ddlIDMercancia"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="DescripcionesEspecificas" style="font-size: medium" /> </td>
           <td></td>
                 <td> <asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator11" ControlToValidate="txtMarca"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="DescripcionesEspecificas" style="font-size: medium" />   </td>
           </tr>
           <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td> <td></td>
              <td><asp:Button runat="server" ID="Button4" Text="Agregar Descripciones" 
        ValidationGroup="DescripcionesEspecificas"  class="btn btn-primary" 
        onclick="Descripciones_Click" Width="133px"/></td>
          </tr>
            </table>
      
             <div style="height: 100%; overflow-y: scroll" >
                <asp:GridView runat="server" ID="gvDescripcionesEspecificas" AutoGenerateColumns="False"  
                CssClass="style124" Width="100%" HorizontalAlign="Center"
                    ShowHeaderWhenEmpty="True" OnRowCommand="gvDescripcionesEspecificas_RowCommand">
                    <Columns>
                      <asp:BoundField HeaderText="Mercancia" DataField="idMercancia" >
                       
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                       
                        <asp:BoundField HeaderText="Marca" DataField="Marca" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="Modelo" DataField="Modelo" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="SubModelo" DataField="SubModelo" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="NumeroSerie" DataField="NumeroSerie" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                       <asp:ButtonField Text="Eliminar" CommandName="EliminarDescripcionesEspecificas" Visible="False" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:ButtonField>
                    </Columns>
                </asp:GridView>
            </div>
            

        
        
     
          
               </ContentTemplate>
            </asp:TabPanel>
     
   
          </asp:TabContainer> 
                 
               
        

            <%--     </asp:Panel>--%>


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
                    ValidationGroup="CrearFactura" UseSubmitBehavior="false"
      OnClientClick="this.disabled='true';"   />
             <%--   <asp:Button runat="server" ID="Button3" Text="Generar pruebas"  class="btn btn-primary"  />
           --%>     
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
             <td align="left"> <cc1:DropDownListChosen ID="ddlClaveUnidadE" runat="server"  CausesValidation="false" 
            NoResultsText="No hay resultados coincidentes." width="129px" Height="16px"  SelectMethod=""          
            DataPlaceHolder="Escriba aquí..." AllowSingleDeselect="true"  
                            AutoPostBack="false" 
                            onselectedindexchanged="ddlClaveUnidadE_SelectedIndexChanged" >                
        </cc1:DropDownListChosen>  
        </td>
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
            <strong>Comprobante generado correctamente y enviado por correo electrónico </strong>
            <asp:LinkButton ID="LinkButton1" runat="server" ForeColor="#FF3300" 
                onclick="LinkButton1_Click">Descargar PDF</asp:LinkButton>
        </h1>
        <br />
        <%--<asp:Button runat="server" ID="btnSeleccionarConcepto" Text="Seleccionar" onclick="btnSeleccionarConcepto_Click" />&nbsp;&nbsp;--%>
        <asp:Button runat="server" ID="Button1" Text="Aceptar"  class="btn btn-primary" OnClick="btnCerrar_Click" />
    </asp:Panel>
    <asp:Button runat="server" ID="btngenerarDummy" Style="display: none;" />
          
        
            
            <!-- error -->

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


        
     </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnLimpiar" />
            <asp:PostBackTrigger ControlID="gvDetalles" />
            <asp:PostBackTrigger ControlID="BtnVistaPrevia" />
            <asp:PostBackTrigger ControlID="LinkButton1"/>
        </Triggers>
    </asp:UpdatePanel>
    
</asp:Content>
