
<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"  CodeBehind="wfrFacturaCartaPorte.aspx.cs" Inherits="GafLookPaid.wfrFacturaCartaPorte" MaintainScrollPositionOnPostBack="true" %>
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
             <table class="table-bordered">
                </caption>
                <caption>
                    <h1>Generar Carta Porte</h1>
                   
                    </tr>
                    <tr>
                        <td class="style146"></td>
                        <td>
                            <asp:Label ID="lblVencimiento" runat="server" ForeColor="Red" Font-Bold="true" style=" font-size: x-small; text-align: left; font-variant: small-caps;" Width="250px"></asp:Label>
                        </td>
                     <td>Cliente:</td>
                        <td></td> 
                    </tr>
                    <tr>
                        <td class="style146">Empresa:</td>
                      
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
                                   <asp:ListItem runat="server" Value="0.060000" Text="0.060000"></asp:ListItem>
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
         
         <asp:TabPanel ID="datosComplemento" runat="server"  HeaderText="Carta Porte" CssClass="page1">
                <HeaderTemplate>Carta Porte</HeaderTemplate>
                <ContentTemplate>

                    <h1 style="text-align: center; " class="style156">
                <strong>Carta Porte</strong></h1>
              <table width="95%">
                    <tr>
                        <td style="text-align: right;">
                            <span class="style160" style="color: #FF0000">*</span>TranspInternac:
                        </td>
                        <td>
                                
       <asp:DropDownList runat="server" ID="ddlTranspInternac"  
                                    style="margin-left: 0px"  CssClass="form-control2">
   <asp:ListItem runat="server" Value="Sí" Text="Sí"></asp:ListItem>
   <asp:ListItem runat="server" Value="No" Text="No"></asp:ListItem>
   </asp:DropDownList>
                        </td>
                        <td style="text-align: right;">
                           EntradaSalidaMerc:
                        </td>
                        <td>
                        <asp:DropDownList runat="server" ID="ddlEntradaSalidaMerc"  
                                    style="margin-left: 0px"  CssClass="form-control2">
          <asp:ListItem runat="server" Value="00" Text="Seleccionar"></asp:ListItem>                     
   <asp:ListItem runat="server" Value="Entrada" Text="Entrada"></asp:ListItem>
   <asp:ListItem runat="server" Value="Salida" Text="Salida"></asp:ListItem>
   </asp:DropDownList>
                        </td>
                        <td style="text-align: right;">
                            ViaEntradaSalida:
                        </td>
                        <td> <asp:DropDownList runat="server" ID="ddlViaEntradaSalida"  
                                    style="margin-left: 0px"  CssClass="form-control2">
               <asp:ListItem runat="server" Value="00" Text="Seleccionar"></asp:ListItem>                      
   <asp:ListItem runat="server" Value="01" Text="Autotransporte Federal"></asp:ListItem>
   <asp:ListItem runat="server" Value="02" Text="Transporte Marítimo"></asp:ListItem>
      <asp:ListItem runat="server" Value="03" Text="Transporte Aéreo"></asp:ListItem>
   <asp:ListItem runat="server" Value="04" Text="Transporte Ferroviario"></asp:ListItem>
      <asp:ListItem runat="server" Value="05" Text="Ducto"></asp:ListItem>
   </asp:DropDownList>
                        </td>
                        <td style="text-align: right;">
                         TotalDistRec:
                        </td>
                        <td>
                           <asp:TextBox ID="txtTotalDistRec" runat="server" CssClass="form-control2" Width="72px" />
          
                        </td>
                    </tr>
                    <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td><asp:RegularExpressionValidator id="RegularExpressionValidator3" runat="server" Display="Dynamic" CssClass="alert-danger"
    ControlToValidate="txtTotalDistRec" ErrorMessage="Dato invalido" 
                         ValidationExpression="[0-9]*\.?[0-9]*" 
                         ValidationGroup="CrearFactura" style="font-size: medium"/></td>
                    </tr>
               </table>
           
                </ContentTemplate>
                </asp:TabPanel>
        
       
          <asp:TabPanel ID="tabGeneral" runat="server"  HeaderText="Ubicaciones" CssClass="page1" >
                <HeaderTemplate>Ubicaciones</HeaderTemplate>
                <ContentTemplate>

                
                   <asp:UpdatePanel ID="UpdatePanel2" runat="server"  UpdateMode="Conditional"  >
               <ContentTemplate>

                         <h1 style="text-align: center; " class="style156">
                <strong>Ubicaciones</strong></h1>
             
               <table>
          <tr>
          <td></td>
              <td style="text-align: right;">
                  TipoEstacion:</td>
          <td>
              <asp:DropDownList ID="ddlTipoEstacion" runat="server" CssClass="form-control2" 
                  style="margin-left: 0px">
                  <asp:ListItem runat="server" Text="Seleccionar" Value="00"></asp:ListItem>
                  <asp:ListItem runat="server" Text="Origen Nacional" Value="01"></asp:ListItem>
                  <asp:ListItem runat="server" Text="Intermedia" Value="02"></asp:ListItem>
                  <asp:ListItem runat="server" Text="Destino Final Nacional" Value="03"></asp:ListItem>
              </asp:DropDownList>
              </td>
         <td style="text-align: right;">DistanciaRecorrida:</td> 
          <td>
              <asp:TextBox ID="txtDistanciaRecorrida" runat="server" CssClass="form-control2" 
                  Width="72px" />
              </td>
              <tr>
                  <td>
                  </td>
                  <td>
                  </td>
                  <td>
                  </td>
                  <td>
                  </td>
                  <td>
                      <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" 
                          ControlToValidate="txtDistanciaRecorrida" CssClass="alert-danger" 
                          Display="Dynamic" ErrorMessage="Dato invalido" style="font-size: medium" 
                          ValidationExpression="[0-9]*\.?[0-9]*" ValidationGroup="CrearFactura" />
                  </td>
              </tr>
                   </tr>
               </table>
               <div style="border: solid 2px gray">
               &nbsp;&nbsp;&nbsp; <asp:CheckBox runat="server" ID="cbOrigen" Text="Origen" 
                    AutoPostBack="True" oncheckedchanged="cbOrigen_CheckedChanged" 
                    style="font-weight: 700; color:Black;"/>
		
       
          <div id="DivOrigen"  style="width:100%" runat="server" visible="false">
               <h1 style="text-align: center; " class="style156">
                <strong>Origen</strong></h1>
           <table>
           <tr>
           <td style="text-align: right;">IDOrigen:</td>
           <td>   <asp:TextBox ID="txtIDOrigen" runat="server" CssClass="form-control2"></asp:TextBox>
          </td>
           <td style="text-align: right;">RFCRemitente:</td>
           <td><asp:TextBox ID="txtRFCRemitente" runat="server" CssClass="form-control2"></asp:TextBox></td>
           <td style="text-align: right;">NombreRemitente:</td>
           <td><asp:TextBox ID="txtNombreRemitente" runat="server" CssClass="form-control2"></asp:TextBox></td>
          
           </tr>
           <tr>
            <td style="text-align: right;">NumRegIdTrib:</td>
           <td><asp:TextBox ID="txtNumRegIdTrib" runat="server" CssClass="form-control2"></asp:TextBox></td>

            <td style="text-align: right;">ResidenciaFiscal:</td>
           <td><div> <cc1:DropDownListChosen ID="ddlResidenciaFiscal" runat="server"  CausesValidation="false" 
            NoResultsText="No hay resultados coincidentes."   width="185px" Height="16px"   SelectMethod=""          
            DataPlaceHolder="Escriba aquí..." AllowSingleDeselect="true" AutoPostBack="True" AppendDataBoundItems="True" 
                            >              
        </cc1:DropDownListChosen></div> </td>
           <td style="text-align: right;">NumEstacion:</td>
           <td><asp:TextBox ID="txtNumEstacion" runat="server" CssClass="form-control2"></asp:TextBox></td>
             
           </tr>
           <tr>
   
             <td style="text-align: right;">NombreEstacion:</td>
           <td><asp:TextBox ID="txtNombreEstacion" runat="server" CssClass="form-control2"></asp:TextBox></td>
       
           <td style="text-align: right;">NavegacionTrafico:</td>
           <td>    <asp:DropDownList runat="server" ID="ddlNavegacionTrafico"  
                  style="margin-left: 0px"  CssClass="form-control2">
  <asp:ListItem runat="server" Value="00" Text="Seleccionar"></asp:ListItem>             
   <asp:ListItem runat="server" Value="Altura" Text="Altura"></asp:ListItem>
   <asp:ListItem runat="server" Value="Cabotaje" Text="Cabotaje"></asp:ListItem>
   </asp:DropDownList></td>
  
           <td style="text-align: right;"> <span class="style160" style="color: #FF0000">*</span>FechaHoraSalida:</td>
    <td colspan="2"  style="padding:0; margin:0;">
    <table ><tr style="padding:0; margin:0;">
  
           <td style="padding:0; margin:0;">  <asp:TextBox runat="server" ID="txtFechaHoraSalida" CssClass="form-control2"  Width="72px"  
                           />
                        
                     <asp:CompareValidator runat="server" ID="CompareValidator5" ControlToValidate="txtFechaHoraSalida"
                            Display="Dynamic" ErrorMessage="* Fecha Invalida" Operator="DataTypeCheck" Type="Date" />
                        <asp:CalendarExtender runat="server" ID="CalendarExtender2" Animated="False" PopupButtonID="txtFechaHoraSalida"
                            TargetControlID="txtFechaHoraSalida" Format="dd/MM/yyyy" />
          </td>
          <td style="padding:0; margin:0; text-align:left;">
           <cc2:TimeSelector ID = "TimeSelector1" runat = "server"  ReadOnly="false"  Font-Size="40px" CssClass="form-control2"
           DisplaySeconds = "false" style="padding:0; margin:3px;" >  </cc2:TimeSelector>
          </td>
          </tr>
          </table>
    </td>
           </tr>
            <tr>
          <td></td><td></td>
          <td></td><td></td>
          <td> <asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator54" ControlToValidate="txtFechaHoraSalida"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="AgregarUbicaciones" style="font-size: medium" /></td><td></td>
          </tr>
           </table>
           </div>
           </div>

           <div style="border: solid 2px gray">
               &nbsp;&nbsp;&nbsp; <asp:CheckBox runat="server" ID="cbDestino" Text="Destino" 
                    AutoPostBack="True" oncheckedchanged="cbDestino_CheckedChanged" 
                    style="font-weight: 700; color:Black;"/>
		
       
          <div id="DivDestino"  style="width:100%" runat="server" visible="false">
            <h1 style="text-align: center; " class="style156">
                <strong>Destino</strong></h1>
           <table>
           <tr>
           <td style="text-align: right;">IDDestino:</td>
           <td>   <asp:TextBox ID="txtIDDestino" runat="server" CssClass="form-control2"></asp:TextBox>
          </td>
           <td style="text-align: right;">RFCDestinatario:</td>
           <td><asp:TextBox ID="txtRFCDestinatario" runat="server" CssClass="form-control2"></asp:TextBox></td>
           <td style="text-align: right;">NombreDestinatario:</td>
           <td><asp:TextBox ID="txtNombreDestinatario" runat="server" CssClass="form-control2"></asp:TextBox></td>
          
           </tr>
           <tr>
            <td style="text-align: right;">NumRegIdTrib:</td>
           <td><asp:TextBox ID="txtNumRegIdTribDestino" runat="server" CssClass="form-control2"></asp:TextBox></td>

            <td style="text-align: right;">ResidenciaFiscal:</td>
           <td><div style=" width:200px"><cc1:DropDownListChosen ID="ddlResidenciaFiscalDestino" runat="server"  CausesValidation="false" 
            NoResultsText="No hay resultados coincidentes."  Width="185px"  Height="16px"   SelectMethod=""          
            DataPlaceHolder="Escriba aquí..." AllowSingleDeselect="true" AutoPostBack="True" AppendDataBoundItems="True" 
                            >              
        </cc1:DropDownListChosen></div> </td>
           <td style="text-align: right;">NumEstacion:</td>
           <td><asp:TextBox ID="txtNumEstacionDestino" runat="server" CssClass="form-control2"></asp:TextBox></td>
             
           </tr>
           <tr>
   
             <td style="text-align: right;">NombreEstacion:</td>
           <td><asp:TextBox ID="txtNombreEstacionDestino" runat="server" CssClass="form-control2"></asp:TextBox></td>
       
           <td style="text-align: right;">NavegacionTrafico:</td>
           <td>    <asp:DropDownList runat="server" ID="ddlNavegacionTraficoDestino"  
                  style="margin-left: 0px"  CssClass="form-control2">
  <asp:ListItem runat="server" Value="00" Text="Seleccionar"></asp:ListItem>             
   <asp:ListItem runat="server" Value="Altura" Text="Altura"></asp:ListItem>
   <asp:ListItem runat="server" Value="Cabotaje" Text="Cabotaje"></asp:ListItem>
   </asp:DropDownList></td>
           <td style="text-align: right;"> <span class="style160" style="color: #FF0000">*</span>FechaHoraProgLlegada:</td>
         <td colspan="2"  style="padding:0; margin:0;">
             <table ><tr style="padding:0; margin:0;">
  
           <td>  <asp:TextBox runat="server" ID="txtFechaHoraProgLlegada" CssClass="form-control2"  Width="72px"  
                           />
                        <asp:CompareValidator runat="server" ID="CompareValidator4" ControlToValidate="txtFechaHoraProgLlegada"
                            Display="Dynamic" ErrorMessage="* Fecha Invalida" Operator="DataTypeCheck" Type="Date" />
                                              
                     <asp:CompareValidator runat="server" ID="CompareValidator3" ControlToValidate="txtFechaHoraProgLlegada"
                            Display="Dynamic" ErrorMessage="* Fecha Invalida" Operator="DataTypeCheck" Type="Date" />
                        <asp:CalendarExtender runat="server" ID="CalendarExtender1" Animated="False" PopupButtonID="txtFechaHoraProgLlegada"
                            TargetControlID="txtFechaHoraProgLlegada" Format="dd/MM/yyyy" />
          </td>
           <td style="padding:0; margin:0;">
           <cc2:TimeSelector ID = "TimeSelector2" runat = "server"  ReadOnly="false"  Font-Size="40px" CssClass="form-control2"
           DisplaySeconds = "false" style="padding:0; margin:3px;" >  </cc2:TimeSelector>
           </td>
          </tr>
          <tr>
          <td></td><td></td>
          <td></td><td></td>
          <td> <asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator53" ControlToValidate="txtFechaHoraProgLlegada"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="AgregarUbicaciones" style="font-size: medium" /></td><td></td>
          </tr>
          </table>
    </td>
           </tr>
           </table>
           </div>
           </div>
           <div style="border: solid 2px gray">
               &nbsp;&nbsp;&nbsp; <asp:CheckBox runat="server" ID="cbDomicilio" Text="Domicilio" 
                    AutoPostBack="True" oncheckedchanged="cbDomicilio_CheckedChanged" 
                    style="font-weight: 700; color:Black;"/>
		
       
          <div id="DivDomicilio"  style="width:100%" runat="server" visible="false">
        
             <h1 style="text-align: center; " class="style156">
                <strong>Domicilio</strong></h1>
                 <table>
           <tr>
             <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>Pais:</td>
           <td>
           <cc1:DropDownListChosen ID="ddlPais" runat="server"  CausesValidation="false" 
            NoResultsText="No hay resultados coincidentes."  Width="185px"  Height="16px"   SelectMethod=""          
            DataPlaceHolder="Escriba aquí..." AllowSingleDeselect="true" AutoPostBack="True" 
                   AppendDataBoundItems="True" 
                   onselectedindexchanged="ddlPais_SelectedIndexChanged">              
            </cc1:DropDownListChosen>
           </td>
              <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>Estado:</td>
           <td>   <asp:TextBox ID="txtEstado" runat="server" CssClass="form-control2" 
                   MaxLength="30"></asp:TextBox>
               
              <asp:DropDownList ID="ddlEstado" runat="server" CssClass="form-control2" Width="180px" 
                  style="margin-left: 0px" AutoPostBack="True" 
                   onselectedindexchanged="ddlEstado_SelectedIndexChanged">
               </asp:DropDownList>

          </td>
        <td style="text-align: right;">Municipio:</td>
           <td>   <asp:TextBox ID="txtMunicipio" runat="server" CssClass="form-control2" 
                   MaxLength="120"></asp:TextBox>
                      <asp:DropDownList ID="ddlMunicipio" runat="server" CssClass="form-control2" 
                style="margin-left: 0px"  Width="180px"
                   onselectedindexchanged="ddlMunicipio_SelectedIndexChanged">
               </asp:DropDownList>



          </td>
          <td style="text-align: right;">Localidad:</td>
           <td>   <asp:TextBox ID="txtLocalidad" runat="server" CssClass="form-control2" 
                   MaxLength="120"></asp:TextBox>
                         <asp:DropDownList ID="ddlLocalidad" runat="server" CssClass="form-control2" 
                style="margin-left: 0px"  Width="180px"
                   onselectedindexchanged="ddlLocalidad_SelectedIndexChanged">
               </asp:DropDownList>
          </td>
         
          </tr>
          <tr>
          <td></td>
          <td> <asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator55" ControlToValidate="ddlPais"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="AgregarUbicaciones" style="font-size: medium" /></td>
          <td></td>
          <td><asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator11" ControlToValidate="txtEstado"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="AgregarUbicaciones" style="font-size: medium" /></td>
          
          </tr>
          <tr>
           <td style="text-align: right;"> <span class="style160" style="color: #FF0000">*</span>Calle:</td>
           <td>   <asp:TextBox ID="txtCalle" runat="server" CssClass="form-control2" 
                   MaxLength="100"></asp:TextBox>
          </td>
       
            <td style="text-align: right;">Referencia:</td>
           <td>   <asp:TextBox ID="txtReferencia" runat="server" CssClass="form-control2" 
                   MaxLength="250"></asp:TextBox>
          </td>
                 <td style="text-align: right;">NumeroExterior:</td>
           <td>   <asp:TextBox ID="txtNumeroExterior" runat="server" CssClass="form-control2" 
                   MaxLength="55"></asp:TextBox>
          </td>
               
           <td style="text-align: right;">NumeroInterior:</td>
           <td>   <asp:TextBox ID="txtNumeroInterior" runat="server" CssClass="form-control2" 
                   MaxLength="55"></asp:TextBox>
          </td>

          </tr>
          <tr>
          <td></td>
          <td><asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator12" ControlToValidate="txtCalle"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="AgregarUbicaciones" style="font-size: medium" /></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          </tr>
          <tr>
             <td style="text-align: right;">Colonia:</td>
           <td>   <asp:TextBox ID="txtColonia" runat="server" CssClass="form-control2" 
                   MaxLength="120"></asp:TextBox>
          </td>
      
       <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>CodigoPostal:</td>
           <td>   <asp:TextBox ID="txtCodigoPostal" runat="server" CssClass="form-control2" 
                   MaxLength="12"></asp:TextBox>
          </td>
          </tr>
          <tr>
          <td></td>
          <td>       </td>
          <td></td>  <td>
           <asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator10" ControlToValidate="txtCodigoPostal"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="AgregarUbicaciones" style="font-size: medium" />
          </td>
          <td></td>
            <td></td>  
          </tr>
          </table>
          </div>
          </div>
                   
           <table width="90%" >
          <tr>
            <td style="text-align: right;" ><div style="width=100%; ">    <asp:Button runat="server" ID="btnUbicaciones" Text="Agregar Ubicación" 
        ValidationGroup="AgregarUbicaciones"  class="btn btn-primary" 
        onclick="btnUbicaciones_Click" Width="133px"/>
        </div>
        </td>
        <td></td>
          </tr>
           </table>
     

             <div style="height: 100%; overflow-y: scroll" >
                <asp:GridView runat="server" ID="gvUbicaciones" AutoGenerateColumns="False"  CssClass="style124" Width="100%" HorizontalAlign="Center"
                    ShowHeaderWhenEmpty="True" OnRowCommand="gvUbicaciones_RowCommand">
                    <Columns>
                      <asp:BoundField HeaderText="ID" DataField="id" ItemStyle-HorizontalAlign="Center" Visible="false" />
                       
                        <asp:BoundField HeaderText="TipoEstacion" DataField="tipoEstacion" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField HeaderText="DistanciaRecorrida" DataField="distanciaRecorrida" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField HeaderText="IDOrigen" DataField="iDOrigen" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField HeaderText="RFCRemitente" DataField="rFCRemitente" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField HeaderText="FechaHoraSalida" DataField="fechaHoraSalida" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField HeaderText="IDDestino" DataField="iDDestino" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField HeaderText="RFCDestinatario" DataField="rFCDestinatario" />
                        <asp:BoundField HeaderText="FechaHoraProgLlegada" DataField="fechaHoraProgLlegada" />
                       <asp:BoundField HeaderText="Estado" DataField="estado"  ItemStyle-HorizontalAlign="Right" />
                        <asp:BoundField HeaderText="Pais" DataField="pais" />
                        <asp:BoundField HeaderText="CP" DataField="codigoPostal" />
                        <asp:ButtonField Text="Eliminar" CommandName="EliminarUbicacion" Visible="False" ItemStyle-HorizontalAlign="Center" />
                    </Columns>
                </asp:GridView>
            </div>
            <br /> <br /> <br /> 

             </ContentTemplate>
          </asp:UpdatePanel>
                </ContentTemplate>
                </asp:TabPanel>

           <asp:TabPanel ID="TabPanel1" runat="server"  HeaderText="Mercancias" CssClass="page1" >
                <HeaderTemplate>Mercancias</HeaderTemplate>
                <ContentTemplate>
                
                   <asp:UpdatePanel ID="UpdatePanel4" runat="server"  UpdateMode="Conditional"  >
               <ContentTemplate>

                    <h1 style="text-align: center; " class="style156">
                <strong>Mercancias</strong></h1>
            <table >
            <tr>
              <td style="text-align: right;">
                         PesoBrutoTotal:
                        </td>
                        <td>
                           <asp:TextBox ID="txtPesoBrutoTotal" runat="server" CssClass="form-control2" Width="72px" />
          <asp:FilteredTextBoxExtender ID="ftbe" runat="server"
    TargetControlID="txtPesoBrutoTotal" FilterType="Custom, Numbers" ValidChars="." Enabled="True" />
                        </td>
                           <td style="text-align: right;">UnidadPeso:</td>
                 <td>
                 <div>
                 <cc1:DropDownListChosen ID="ddlClaveUnidadPeso" runat="server" 
            NoResultsText="No hay resultados coincidentes."  Width="150px"  Height="16px"   SelectMethod=""          
            DataPlaceHolder="Escriba aquí..." AllowSingleDeselect="True" AutoPostBack="True" 
                         AppendDataBoundItems="True" DisableSearchThreshold="10">              
        </cc1:DropDownListChosen>
        </div>
        </td> 
          <td style="text-align: right;">
                         PesoNetoTotal:
                        </td>
                        <td>
                           <asp:TextBox ID="txtPesoNetoTotal" runat="server" CssClass="form-control2" Width="72px" />
          <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server"
    TargetControlID="txtPesoNetoTotal" FilterType="Custom, Numbers" ValidChars="." Enabled="True" />
                        </td>
                        <td style="text-align: right;">
                        <span class="style160" style="color: #FF0000">*</span>NumTotalMercancias:
                        </td>
                        <td>
                           <asp:TextBox ID="txtNumTotalMercancias" runat="server" CssClass="form-control2" Width="72px" />
          <asp:FilteredTextBoxExtender ID="TextBox1_FilteredTextBoxExtender" runat="server"
Enabled="True" TargetControlID="txtNumTotalMercancias" FilterType="Numbers">
</asp:FilteredTextBoxExtender>
                        </td>
                                              
            </tr>
           <tr>
            <td></td>

            <td><asp:RegularExpressionValidator id="RegularExpressionValidator5" runat="server" Display="Dynamic" CssClass="alert-danger"
    ControlToValidate="txtPesoBrutoTotal" ErrorMessage="Dato invalido" 
                         ValidationExpression="[0-9]*\.?[0-9]*" 
                         ValidationGroup="CrearFactura" style="font-size: medium"/>
                         
                         </td>
                         <td></td>
                         <td></td>
                        <td></td>

                         <td><asp:RegularExpressionValidator id="RegularExpressionValidator6" runat="server" Display="Dynamic" CssClass="alert-danger"
    ControlToValidate="txtPesoNetoTotal" ErrorMessage="Dato invalido" 
                         ValidationExpression="[0-9]*\.?[0-9]*" 
                         ValidationGroup="CrearFactura" style="font-size: medium"/></td>
            
                       <td></td>
                         <td><asp:RegularExpressionValidator id="RegularExpressionValidator7" runat="server" Display="Dynamic" CssClass="alert-danger"
    ControlToValidate="txtNumTotalMercancias" ErrorMessage="Dato invalido" 
                         ValidationExpression="[0-9]*\.?[0-9]*" 
                         ValidationGroup="CrearFactura" style="font-size: medium"/>
                             <asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator9" ControlToValidate="txtNumTotalMercancias"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="CrearFactura" style="font-size: medium" />
                         </td>
                        <td></td>
                      
                        </tr>
<tr>
<td style="text-align: right;">CargoPorTasacion:</td>
<td>       <asp:TextBox ID="txtCargoPorTasacion" runat="server" CssClass="form-control2" Width="72px" />
          <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender4" runat="server"
            TargetControlID="txtCargoPorTasacion" FilterType="Custom, Numbers" 
        ValidChars="." Enabled="True" />
           </td>
</tr>
<tr>
<td></td>
   <td><asp:RegularExpressionValidator id="RegularExpressionValidator15" runat="server" Display="Dynamic" CssClass="alert-danger"
    ControlToValidate="txtCargoPorTasacion" ErrorMessage="Dato invalido" 
                         ValidationExpression="[0-9]*\.?[0-9]*" 
                         ValidationGroup="CrearFactura" style="font-size: medium"/>
                         </td>

</tr>
         </table>
               
                   <h1 style="text-align: center; " class="style156">
                    <strong>Mercancia</strong></h1>
           <table >
           <tr>
             <td style="text-align: right;">BienesTransp:</td>
           <td>   <asp:TextBox ID="txtBienesTransp" runat="server" CssClass="form-control2"  Width="72px"
                   ></asp:TextBox>
          </td>
           <td style="text-align: right;">ClaveSTCC:</td>
           <td>   <asp:TextBox ID="txtClaveSTCC" runat="server" CssClass="form-control2" Width="72px"
                   ></asp:TextBox>
          </td>
             <td  style="text-align: right;">Descripcion:</td>
           <td colspan="3">   <asp:TextBox ID="txtDescripcionMercancia" runat="server" 
                   CssClass="form-control2" TextMode="MultiLine" Width="242px" 
                   ></asp:TextBox>
          </td>
          <td></td>
          <td></td>
           </tr>
           <tr>
            <td style="text-align: right;">
                         Cantidad:
                        </td>
                        <td>
                           <asp:TextBox ID="txtCantidadMercancia" runat="server" CssClass="form-control2" Width="72px" />
          <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender5" runat="server"
    TargetControlID="txtCantidadMercancia" FilterType="Custom, Numbers" ValidChars="." Enabled="True" />
    </td>
    <td style="text-align: right;">ClaveUnidad:</td>
                    <td style="text-align: left;">
                    <div>    
    
     <cc1:DropDownListChosen ID="ddlClaveUnidadMercancia" runat="server" 
            NoResultsText="No hay resultados coincidentes." width="129px" Height="16px"  SelectMethod=""          
            DataPlaceHolder="Escriba aquí..." AllowSingleDeselect="True"  
                            AutoPostBack="True" DisableSearchThreshold="10"  >                
        </cc1:DropDownListChosen>  
        

        </div>
                             </td>

    <td style="text-align: right;">Unidad:</td>
           <td>   <asp:TextBox ID="txtUnidadMercancia" runat="server" CssClass="form-control2" 
                   ></asp:TextBox>
          </td>
           <td style="text-align: right;">Dimensiones:</td>
           <td>   <asp:TextBox ID="txtDimensiones" runat="server" CssClass="form-control2" 
                   ></asp:TextBox>
          </td>
            </tr>
           <tr>
           <td></td>
                 <td><asp:RegularExpressionValidator id="RegularExpressionValidator8" runat="server" Display="Dynamic" CssClass="alert-danger"
    ControlToValidate="txtCantidadMercancia" ErrorMessage="Dato invalido" 
                         ValidationExpression="[0-9]*\.?[0-9]*" 
                         ValidationGroup="CrearFactura" style="font-size: medium"/></td>
           </tr>
           <tr>
                    
           <td style="text-align: right;">MaterialPeligroso:</td>
           <td>    <asp:DropDownList runat="server" ID="ddlMaterialPeligroso"  
                  style="margin-left: 0px"  CssClass="form-control2">
  <asp:ListItem Value="00" Text="Seleccionar"></asp:ListItem>             
   <asp:ListItem Value="Sí" Text="Sí"></asp:ListItem>
   <asp:ListItem Value="No" Text="No"></asp:ListItem>
   </asp:DropDownList></td>
           <td style="text-align: right;">CveMaterialPeligroso:</td>
           <td>   <asp:TextBox ID="txtCveMaterialPeligroso" runat="server" CssClass="form-control2"  Width="72px"
                   ></asp:TextBox>
          </td>
          
        <td style="text-align: right;">Embalaje:</td>
           <td>   
         
      <asp:DropDownList runat="server" ID="ddlEmbalaje"  width="160px" 
                  style="margin-left: 0px"  CssClass="form-control2">
                  <asp:ListItem Value="00" Text="Seleccionar"></asp:ListItem>    
                  <asp:ListItem Value="1A1" Text="Bidones (Tambores) de Acero 1 de tapa no desmontable"></asp:ListItem>
<asp:ListItem Value="1A2" Text="Bidones (Tambores) de Acero 1 de tapa desmontable"></asp:ListItem>
<asp:ListItem Value="1B1" Text="Bidones (Tambores) de Aluminio de tapa no desmontable"></asp:ListItem>
<asp:ListItem Value="1B2" Text="Bidones (Tambores) de Aluminio de tapa desmontable"></asp:ListItem>
<asp:ListItem Value="1D" Text="Bidones (Tambores) de Madera contrachapada"></asp:ListItem>
<asp:ListItem Value="1G" Text="Bidones (Tambores) de Cartón"></asp:ListItem>
<asp:ListItem Value="1H1" Text="Bidones (Tambores) de Plástico de tapa no desmontable"></asp:ListItem>
<asp:ListItem Value="1H2" Text="Bidones (Tambores) de Plástico de tapa desmontable"></asp:ListItem>
<asp:ListItem Value="1N1" 
                      Text="Bidones (Tambores) de Metal que no sea acero ni aluminio de tapa no desmontable"></asp:ListItem>
<asp:ListItem Value="1N2" 
                      Text="Bidones (Tambores) de Metal que no sea acero ni aluminio de tapa desmontable"></asp:ListItem>
<asp:ListItem Value="3A1" Text="Jerricanes (Porrones) de Acero de tapa no desmontable"></asp:ListItem>
<asp:ListItem Value="3A2" Text="Jerricanes (Porrones) de Acero de tapa desmontable"></asp:ListItem>
<asp:ListItem Value="3B1" Text="Jerricanes (Porrones) de Aluminio de tapa no desmontable"></asp:ListItem>
<asp:ListItem Value="3B2" Text="Jerricanes (Porrones) de Aluminio de tapa desmontable"></asp:ListItem>
<asp:ListItem Value="3H1" Text="Jerricanes (Porrones) de Plástico de tapa no desmontable"></asp:ListItem>
<asp:ListItem Value="3H2" Text="Jerricanes (Porrones) de Plástico de tapa desmontable"></asp:ListItem>
<asp:ListItem Value="4A" Text="Cajas de Acero"></asp:ListItem>
<asp:ListItem Value="4B" Text="Cajas de Aluminio"></asp:ListItem>
<asp:ListItem Value="4C1" Text="Cajas de Madera natural ordinaria"></asp:ListItem>
<asp:ListItem Value="4C2" 
                      Text="Cajas de Madera natural de paredes a prueba de polvos (estancas a los pulverulentos)"></asp:ListItem>
<asp:ListItem Value="4D" Text="Cajas de Madera contrachapada"></asp:ListItem>
<asp:ListItem Value="4F" Text="Cajas de Madera reconstituida"></asp:ListItem>
<asp:ListItem Value="4G" Text="Cajas de Cartón"></asp:ListItem>
<asp:ListItem Value="4H1" Text="Cajas de Plástico Expandido"></asp:ListItem>
<asp:ListItem Value="4H2" Text="Cajas de Plástico Rígido"></asp:ListItem>
<asp:ListItem Value="5H1" 
                      Text="Sacos (Bolsas) de Tejido de plástico sin forro ni revestimientos interiores"></asp:ListItem>
<asp:ListItem Value="5H2" 
                      Text="Sacos (Bolsas) de Tejido de plástico a prueba de polvos (estancos a los pulverulentos)"></asp:ListItem>
<asp:ListItem Value="5H3" Text="Sacos (Bolsas) de Tejido de plástico resistente al agua"></asp:ListItem>
<asp:ListItem Value="5H4" Text="Sacos (Bolsas) de Película de plástico"></asp:ListItem>
<asp:ListItem Value="5L1" Text="Sacos (Bolsas) de Tela sin forro ni revestimientos interiores"></asp:ListItem>
<asp:ListItem Value="5L2" 
                      Text="Sacos (Bolsas) de Tela a prueba de polvos (estancos a los pulverulentos)"></asp:ListItem>
<asp:ListItem Value="5L3" Text="Sacos (Bolsas) de Tela resistentes al agua"></asp:ListItem>
<asp:ListItem Value="5M1" Text="Sacos (Bolsas) de Papel de varias hojas"></asp:ListItem>
<asp:ListItem Value="5M2" Text="Sacos (Bolsas) de Papel de varias hojas, resistentes al agua"></asp:ListItem>
<asp:ListItem Value="6HA1" 
                      Text="Envases y embalajes compuestos de Recipiente de plástico, con bidón (tambor) de acero"></asp:ListItem>
<asp:ListItem Value="6HA2" 
                      Text="Envases y embalajes compuestos de Recipiente de plástico, con una jaula o caja de acero"></asp:ListItem>
<asp:ListItem Value="6HB1" 
                      Text="Envases y embalajes compuestos de Recipiente de plástico, con un bidón (tambor) exterior de aluminio"></asp:ListItem>
<asp:ListItem Value="6HB2" 
                      Text="Envases y embalajes compuestos de Recipiente de plástico, con una jaula o caja de aluminio"></asp:ListItem>
<asp:ListItem Value="6HC" 
                      Text="Envases y embalajes compuestos de Recipiente de plástico, con una caja de madera"></asp:ListItem>
<asp:ListItem Value="6HD1" 
                      Text="Envases y embalajes compuestos de Recipiente de plástico, con un bidón (tambor) de madera contrachapada"></asp:ListItem>
<asp:ListItem Value="6HD2" 
                      Text="Envases y embalajes compuestos de Recipiente de plástico, con una caja de madera contrachapada"></asp:ListItem>
<asp:ListItem Value="6HG1" 
                      Text="Envases y embalajes compuestos de Recipiente de plástico, con un bidón (tambor) de cartón"></asp:ListItem>
<asp:ListItem Value="6HG2" 
                      Text="Envases y embalajes compuestos de Recipiente de plástico, con una caja de cartón"></asp:ListItem>
<asp:ListItem Value="6HH1" 
                      Text="Envases y embalajes compuestos de Recipiente de plástico, con un bidón (tambor) de plástico"></asp:ListItem>
<asp:ListItem Value="6HH2" 
                      Text="Envases y embalajes compuestos de Recipiente de plástico, con caja de plástico rígido"></asp:ListItem>
<asp:ListItem Value="6PA1" 
                      Text="Envases y embalajes compuestos de Recipiente de vidrio, porcelana o de gres, con un bidón (tambor) de acero"></asp:ListItem>
<asp:ListItem Value="6PA2" 
                      Text="Envases y embalajes compuestos de Recipiente de vidrio, porcelana o de gres, con una jaula o una caja de acero"></asp:ListItem>
<asp:ListItem Value="6PB1" 
                      Text="Envases y embalajes compuestos de Recipiente de vidrio, porcelana o de gres, con un bidón (tambor) exterior de aluminio"></asp:ListItem>
<asp:ListItem Value="6PB2" 
                      Text="Envases y embalajes compuestos de Recipiente de vidrio, porcelana o de gres, con una jaula o una caja de aluminio"></asp:ListItem>
<asp:ListItem Value="6PC" 
                      Text="Envases y embalajes compuestos de Recipiente de vidrio, porcelana o de gres, con una caja de madera"></asp:ListItem>
<asp:ListItem Value="6PD 1" 
                      Text="Envases y embalajes compuestos de Recipiente de vidrio, porcelana o de gres, con bidón (tambor) de madera contrachapada"></asp:ListItem>
<asp:ListItem Value="6PD2" 
                      Text="Envases y embalajes compuestos de Recipiente de vidrio, porcelana o de gres, con canasta de mimbre"></asp:ListItem>
<asp:ListItem Value="6PG1" 
                      Text="Envases y embalajes compuestos de Recipiente de vidrio, porcelana o de gres, con un bidón (tambor) de cartón"></asp:ListItem>
<asp:ListItem Value="6PG2" 
                      Text="Envases y embalajes compuestos de Recipiente de vidrio, porcelana o de gres, con una caja de cartón"></asp:ListItem>
<asp:ListItem Value="6PH1" 
                      Text="Envases y embalajes compuestos de Recipiente de vidrio, porcelana o de gres, con un envase y embalaje de plástico expandido"></asp:ListItem>
<asp:ListItem Value="6PH2" 
                      Text="Envases y embalajes compuestos de Recipiente de vidrio, porcelana o de gres, con un envase y embalaje de plástico rígido"></asp:ListItem>
<asp:ListItem Value="7H1" Text="Bultos de Plástico"></asp:ListItem>
<asp:ListItem Value="7L1" Text="Bultos de Tela"></asp:ListItem>
<asp:ListItem Value="Z01" Text="No aplica" ></asp:ListItem>

                   </asp:DropDownList>
                   
                   </td>
              <td style="text-align: right;">DescripEmbalaje:</td>
           <td>   <asp:TextBox ID="txtDescripEmbalaje" runat="server" CssClass="form-control2" 
                   MaxLength="100"></asp:TextBox>
          </td>
  
           </tr>
           <tr>
              <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>
                         PesoEnKg:
                        </td>
                        <td>
                           <asp:TextBox ID="txtPesoEnKg" runat="server" CssClass="form-control2" Width="72px" />
          <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender6" runat="server"
    TargetControlID="txtPesoEnKg" FilterType="Custom, Numbers" ValidChars="." Enabled="True" />
    </td>
      <td style="text-align: right;">ValorMercancia:</td>
                        <td>
                           <asp:TextBox ID="txtValorMercancia" runat="server" CssClass="form-control2" Width="72px" />
          <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender7" runat="server"
    TargetControlID="txtValorMercancia" FilterType="Custom, Numbers" ValidChars="." Enabled="True" />
    </td>
       <td style="text-align: right">
                        Moneda:
                    </td>
                 
   <td class="style132"><cc1:DropDownListChosen ID="ddlMonedaMercancia" runat="server" 
            NoResultsText="No hay resultados coincidentes."  Width="185px"  
           Height="16px"   SelectMethod=""  OnSelectedIndexChanged="ddlMoneda_SelectedIndexChanged"        
            DataPlaceHolder="Escriba aquí..." AllowSingleDeselect="True" 
           AutoPostBack="True" AppendDataBoundItems="True" DisableSearchThreshold="10" 
                            >              
        </cc1:DropDownListChosen></td>  
         <td style="text-align: right;">FraccionArancelaria:</td>
           <td>   <asp:TextBox ID="txtFraccionArancelaria" runat="server" CssClass="form-control2" 
                   ></asp:TextBox>
          </td>
           </tr>
           <tr>
           <td></td>
           <td>
           <asp:RegularExpressionValidator id="RegularExpressionValidator9" runat="server" 
           Display="Dynamic" CssClass="alert-danger"
    ControlToValidate="txtPesoEnKg" ErrorMessage="Dato invalido" 
                         ValidationExpression="[0-9]*\.?[0-9]*" 
                         ValidationGroup="AgregarMercancias" style="font-size: medium"/>
                         <asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator8" ControlToValidate="txtPesoEnKg"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="AgregarMercancias" style="font-size: medium" />
           </td>
           
           <td><asp:RegularExpressionValidator id="RegularExpressionValidator10" runat="server" Display="Dynamic" CssClass="alert-danger"
    ControlToValidate="txtValorMercancia" ErrorMessage="Dato invalido" 
                         ValidationExpression="[0-9]*\.?[0-9]*" 
                         ValidationGroup="CrearFactura" style="font-size: medium"/></td>
           <td></td>
           <td></td>
           </tr>
           <tr>
           
             <td style="text-align: right;">UUIDComercioExt:</td>
           <td colspan="3">   <asp:TextBox ID="txtUUIDComercioExt" runat="server" CssClass="form-control2" 
                   ></asp:TextBox>
          </td>

            </tr>
               
           </table>
             
              <div style="border: solid 2px gray">
               &nbsp;&nbsp;&nbsp; <asp:CheckBox runat="server" ID="cbDetalleMercancia" Text="DetalleMercancia" 
                    AutoPostBack="True" oncheckedchanged="cbDetalleMercancia_CheckedChanged" 
                    style="font-weight: 700; color:Black;"/>
		
       
          <div id="DivDetalleMercancia"  style="width:100%" runat="server" visible="False">
        
                    <h1 style="text-align: center; " class="style156">
                    <strong>DetalleMercancia</strong></h1>
            <table>       
            <tr>
            
              <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>UnidadPeso:</td>
                 <td><cc1:DropDownListChosen ID="ddlUnidadPesoDM" runat="server" 
            NoResultsText="No hay resultados coincidentes."  Width="185px"  Height="16px"   SelectMethod=""          
            DataPlaceHolder="Escriba aquí..." AllowSingleDeselect="True" AutoPostBack="True" 
                         AppendDataBoundItems="True" DisableSearchThreshold="10" >              
          </cc1:DropDownListChosen></td>

              <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>PesoBruto: </td>
                        <td>
                           <asp:TextBox ID="txtPesoBruto" runat="server" CssClass="form-control2" Width="72px" />
          <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender9" runat="server"
    TargetControlID="txtPesoBruto" FilterType="Custom, Numbers" ValidChars="." Enabled="True" />
    </td>
        <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>PesoNeto: </td>
                        <td>
                           <asp:TextBox ID="txtPesoNeto" runat="server" CssClass="form-control2" Width="72px" />
          <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender10" runat="server"
    TargetControlID="txtPesoNeto" FilterType="Custom, Numbers" ValidChars="." Enabled="True" />
    </td> <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>PesoTara: </td>
                        <td>
                           <asp:TextBox ID="txtPesoTara" runat="server" CssClass="form-control2" Width="72px" />
          <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender11" runat="server"
    TargetControlID="txtPesoTara" FilterType="Custom, Numbers" ValidChars="." Enabled="True" />
    </td>
    <td style="text-align: right;">NumPiezas: </td>
                        <td>
                           <asp:TextBox ID="txtNumPiezas" runat="server" CssClass="form-control2" Width="72px" />
          <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender12" runat="server"
Enabled="True" TargetControlID="txtNumPiezas" FilterType="Numbers">
</asp:FilteredTextBoxExtender>
                        </td>
           </tr>
           <tr>
           <td></td>
           <td></td>
           <td></td>
           <td>
           <asp:RegularExpressionValidator id="RegularExpressionValidator12" 
            runat="server" Display="Dynamic" CssClass="alert-danger"
    ControlToValidate="txtPesoBruto" ErrorMessage="Dato invalido" 
                         ValidationExpression="[0-9]*\.?[0-9]*" 
                         ValidationGroup="AgregarMercancias" style="font-size: medium"/>
                         <asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator16" ControlToValidate="txtPesoBruto"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="AgregarMercancias" style="font-size: medium" />
                           </td>
                           <td></td>
                           <td>  <asp:RegularExpressionValidator id="RegularExpressionValidator13" 
            runat="server" Display="Dynamic" CssClass="alert-danger"
    ControlToValidate="txtPesoNeto" ErrorMessage="Dato invalido" 
                         ValidationExpression="[0-9]*\.?[0-9]*" 
                         ValidationGroup="AgregarMercancias" style="font-size: medium"/>
                         <asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator17" ControlToValidate="txtPesoNeto"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="AgregarMercancias" style="font-size: medium" /></td>
                           <td></td>
                           <td>
                             <asp:RegularExpressionValidator id="RegularExpressionValidator14" 
            runat="server" Display="Dynamic" CssClass="alert-danger"
    ControlToValidate="txtPesoTara" ErrorMessage="Dato invalido" 
                         ValidationExpression="[0-9]*\.?[0-9]*" 
                         ValidationGroup="AgregarMercancias" style="font-size: medium"/>
                         <asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator18" ControlToValidate="txtPesoTara"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="AgregarMercancias" style="font-size: medium" /></td>
                       
           </tr>
            </table>
            </div>
            </div>

            <table width="90%" >
          <tr>
            <td style="text-align: right;" ><div style="width=100%; "> <asp:Button runat="server" ID="Button3" Text="Agregar Mercancia" 
        ValidationGroup="AgregarMercancias"  class="btn btn-primary" 
        onclick="AgregarMercancias_Click" Width="133px"/>
        </div>
        </td>
        <td></td>
          </tr>
           </table>
             <div style="height: 100%; overflow-y: scroll" >
                <asp:GridView runat="server" ID="gvMercancia" AutoGenerateColumns="False"  CssClass="style124" Width="100%" HorizontalAlign="Center"
                    ShowHeaderWhenEmpty="True" OnRowCommand="gvMercancia_RowCommand">
                    <Columns>
                      <asp:BoundField HeaderText="ID" DataField="id" >
                       
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                       
                        <asp:BoundField HeaderText="BienesTransp" DataField="bienesTransp" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="ClaveSTCC" DataField="claveSTCC" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="Cantidad" DataField="cantidad" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="ClaveUnidad" 
                            DataField="claveUnidad" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="MaterialPeligroso" DataField="materialPeligroso" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="Embalaje" DataField="embalaje" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="PesoEnKg" DataField="pesoEnKg" />
                        <asp:BoundField HeaderText="Valor" DataField="valorMercancia" />
                       <asp:BoundField HeaderText="Moneda" DataField="moneda" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                       <asp:ButtonField Text="Eliminar" CommandName="EliminarMercancia" Visible="False" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:ButtonField>
                    </Columns>
                </asp:GridView>
            </div>


            <br />

           <div style="border: solid 2px gray">
               &nbsp;&nbsp;&nbsp; <asp:CheckBox runat="server" ID="cbCantidadTransporta" Text="CantidadTransporta" 
                    AutoPostBack="True" oncheckedchanged="cbCantidadTransporta_CheckedChanged" 
                    style="font-weight: 700; color:Black;"/>
		
       
          <div id="DivCantidadTransporta"  style="width:100%" runat="server" visible="False">
        

           <h1 style="text-align: center; " class="style156">
                    <strong>CantidadTransporta</strong></h1>
           <table>
           <tr>
           <td style="text-align: right;">
                            <span class="style160" style="color: #FF0000">*</span> 
    IDMercancia:</td>

<td >
        <asp:DropDownList ID="ddlIDMercancia" runat="server" AutoPostBack="True"
         CssClass="form-control0" Width="90px"> </asp:DropDownList>
            </td>
             <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span> Cantidad:</td>
                        <td>
                           <asp:TextBox ID="txtCantidaCT" runat="server" CssClass="form-control2" Width="72px" />
          <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender8" runat="server"
    TargetControlID="txtCantidaCT" FilterType="Custom, Numbers" ValidChars="." Enabled="True" />
    </td>
       <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>
       IDOrigen:</td>
                  <td>
                      <asp:TextBox ID="txtIDOrigenCT" runat="server" CssClass="form-control2" Width="72px" />
          </td>
           <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>
       IDDestino:</td>
                  <td>
                      <asp:TextBox ID="txtIDDestinoCT" runat="server" CssClass="form-control2" Width="72px" />
          </td>
          <td style="text-align: right;">CvesTransporte:</td>
           <td>    <asp:DropDownList runat="server" ID="ddlCvesTransporte"  
                  style="margin-left: 0px"  CssClass="form-control2">
                <asp:ListItem Value="00" Text="Seleccionar"></asp:ListItem>             
               <asp:ListItem Value="01" Text="Autotransporte Federal"></asp:ListItem>
<asp:ListItem Value="02" Text="Transporte Marítimo"></asp:ListItem>
<asp:ListItem Value="03" Text="Transporte Aéreo"></asp:ListItem>
<asp:ListItem Value="04" Text="Transporte Ferroviario"></asp:ListItem>
<asp:ListItem Value="05" Text="Ducto"></asp:ListItem>
                </asp:DropDownList></td>
            </tr>
            <tr>
            <td></td>
            <td></td>
            <td></td>
             <td>    <asp:RegularExpressionValidator id="RegularExpressionValidator11" 
            runat="server" Display="Dynamic" CssClass="alert-danger"
    ControlToValidate="txtCantidaCT" ErrorMessage="Dato invalido" 
                         ValidationExpression="[0-9]*\.?[0-9]*" 
                         ValidationGroup="AgregarCantidadTransporta" style="font-size: medium"/>
                         <asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator13" ControlToValidate="txtCantidaCT"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="AgregarCantidadTransporta" style="font-size: medium" /></td>
           <td></td>
           <td>      <asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator14" ControlToValidate="txtIDOrigenCT"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="AgregarCantidadTransporta" style="font-size: medium" /></td>
                           <td></td>
                           <td> <asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator15" ControlToValidate="txtIDDestinoCT"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="AgregarCantidadTransporta" style="font-size: medium" /></td>
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
              <td><asp:Button runat="server" ID="Button4" Text="Agregar CTransporta" 
        ValidationGroup="AgregarCantidadTransporta"  class="btn btn-primary" 
        onclick="CantidadTransporta_Click" Width="133px"/></td>
          </tr>
            </table>
      
             <div style="height: 100%; overflow-y: scroll" >
                <asp:GridView runat="server" ID="gvCantidadTransporta" AutoGenerateColumns="False"  CssClass="style124" Width="100%" HorizontalAlign="Center"
                    ShowHeaderWhenEmpty="True" OnRowCommand="gvCantidadTransporta_RowCommand">
                    <Columns>
                      <asp:BoundField HeaderText="Mercancia" DataField="id" >
                       
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                       
                        <asp:BoundField HeaderText="Cantidad" DataField="Cantidad" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="IDOrigen" DataField="IDOrigen" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="IDDestino" DataField="IDDestino" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="CvesTransporte" DataField="CvesTransporte" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                       <asp:ButtonField Text="Eliminar" CommandName="EliminarCantidadTransporta" Visible="False" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:ButtonField>
                    </Columns>
                </asp:GridView>
            </div>
            </div>
            </div>
            <br />

                 <div style="border: solid 2px gray">
               &nbsp;&nbsp;&nbsp; <asp:CheckBox runat="server" ID="cbAutotransporteFederal" Text="AutotransporteFederal" 
                    AutoPostBack="True" oncheckedchanged="cbAutotransporteFederal_CheckedChanged" 
                    style="font-weight: 700; color:Black;"/>
		
       
          <div id="DivAutotransporteFederal"  style="width:100%" runat="server" visible="False">
        

                 <h1 style="text-align: center; " class="style156">
                <strong>AutotransporteFederal</strong></h1>
                <table>
                <tr>
                  <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>
                           ConfigVehicular:
                        </td>
                        <td>
                        <asp:DropDownList runat="server" ID="ddlConfigVehicular" style="margin-left: 0px"  CssClass="form-control2"  Width="250px">
                        <asp:ListItem runat="server" Value="C2" Text="Camión Unitario (2 llantas en el eje delantero y 4 llantas en el eje trasero)" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="C3" Text="Camión Unitario (2 llantas en el eje delantero y 6 o 8 llantas en los dos ejes traseros)" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="C2R2" Text="Camión-Remolque (6 llantas en el camión y 8 llantas en remolque)" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="C3R2" Text="Camión-Remolque (10 llantas en el camión y 8 llantas en remolque)" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="C2R3" Text="Camión-Remolque (6 llantas en el camión y 12 llantas en remolque)" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="C3R3" Text="Camión-Remolque (10 llantas en el camión y 12 llantas en remolque)" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="T2S1" Text="Tractocamión Articulado (6 llantas en el tractocamión, 4 llantas en el semirremolque)" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="T2S2" Text="Tractocamión Articulado (6 llantas en el tractocamión, 8 llantas en el semirremolque)" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="T2S3" Text="Tractocamión Articulado (6 llantas en el tractocamión, 12 llantas en el semirremolque)" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="T3S1" Text="Tractocamión Articulado (10 llantas en el tractocamión, 4 llantas en el semirremolque)" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="T3S2" Text="Tractocamión Articulado (10 llantas en el tractocamión, 8 llantas en el semirremolque)" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="T3S3" Text="Tractocamión Articulado (10 llantas en el tractocamión, 12 llantas en el semirremolque)" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="T2S1R2" Text="Tractocamión Semirremolque-Remolque (6 llantas en el tractocamión, 4 llantas en el semirremolque y 8 llantas en el remolque)" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="T2S2R2" Text="Tractocamión Semirremolque-Remolque (6 llantas en el tractocamión, 8 llantas en el semirremolque y 8 llantas en el remolque)" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="T2S1R3" Text="Tractocamión Semirremolque-Remolque (6 llantas en el tractocamión, 4 llantas en el semirremolque y 12 llantas en el remolque)" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="T3S1R2" Text="Tractocamión Semirremolque-Remolque (10 llantas en el tractocamión, 4 llantas en el semirremolque y 8 llantas en el remolque)" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="T3S1R3" Text="Tractocamión Semirremolque-Remolque (10 llantas en el tractocamión, 4 llantas en el semirremolque y 12 llantas en el remolque)" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="T3S2R2" Text="Tractocamión Semirremolque-Remolque (10 llantas en el tractocamión, 8 llantas en el semirremolque y 8 llantas en el remolque)" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="T3S2R3" Text="Tractocamión Semirremolque-Remolque (10 llantas en el tractocamión, 8 llantas en el semirremolque y 12 llantas en el remolque)" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="T3S2R4" Text="Tractocamión Semirremolque-Remolque (10 llantas en el tractocamión, 8 llantas en el semirremolque y 16 llantas en el remolque)" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="T2S2S2" Text="Tractocamión Semirremolque-Semirremolque (6 llantas en el tractocamión, 8 llantas en el semirremolque delantero y 8 llantas en el semirremolque trasero)" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="T3S2S2" Text="Tractocamión Semirremolque-Semirremolque (10 llantas en el tractocamión, 8 llantas en el semirremolque delantero y 8 llantas en el semirremolque trasero)" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="T3S3S2" Text="Tractocamión Semirremolque-Semirremolque (10 llantas en el tractocamión, 12 llantas en el semirremolque delantero y 8 llantas en el semirremolque trasero)" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="OTROEV" Text="Especializado de Voluminoso" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="OTROEGP" Text="Especializado de Gran Peso" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="OTROSG" Text="Servicio de Grúas" ></asp:ListItem>

                        </asp:DropDownList>
                        </td>
                        <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>PlacaVM:</td>
                      <td>   <asp:TextBox ID="txtPlacaVM" runat="server" CssClass="form-control2"    MaxLength="10"></asp:TextBox>
                      </td>
                          <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>AnioModeloVM:</td>
                      <td>   <asp:TextBox ID="txtAnioModeloVM" runat="server" CssClass="form-control2"    MaxLength="4"></asp:TextBox>
                      </td>
                </tr>
                <tr>
                <td></td>
                <td></td>
                <td></td>
                <td>     <asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator19" ControlToValidate="txtPlacaVM"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="CrearFactura" style="font-size: medium" />
                           </td>
               <td></td>
                <td>     <asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator20" ControlToValidate="txtAnioModeloVM"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="CrearFactura" style="font-size: medium" />
                          <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender13" runat="server"
                     Enabled="True" TargetControlID="txtAnioModeloVM" FilterType="Numbers"></asp:FilteredTextBoxExtender>
                           </td>
                </tr>
                 <tr>
                 <td></td><td style="text-align: right;">  
                <asp:CheckBox runat="server" ID="cbSubTipoRem1" Text="Activar" 
                    AutoPostBack="True" oncheckedchanged="cbSubTipoRem1_CheckedChanged" 
                    style="font-weight: 700; color:Black;"/></td>
                 <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>
                           SubTipoRem:
                        </td>
                        <td>
                        <asp:DropDownList runat="server" ID="ddlSubTipoRem" style="margin-left: 0px"  Enabled="false" CssClass="form-control2"  Width="250px">
                       <asp:ListItem runat="server" Value="CTR001" Text="Caballete" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR002" Text="Caja" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR003" Text="Caja Abierta" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR004" Text="Caja Cerrada" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR005" Text="Caja De Recolección Con Cargador Frontal" ></asp:ListItem> 
                       <asp:ListItem runat="server" Value="CTR006" Text="Caja Refrigerada" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR007" Text="Caja Seca" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR008" Text="Caja Transferencia" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR009" Text="Cama Baja o Cuello Ganso" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR010" Text="Chasis Portacontenedor" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR011" Text="Convencional De Chasis" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR012" Text="Equipo Especial" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR013" Text="Estacas" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR014" Text="Góndola Madrina" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR015" Text="Grúa Industrial" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR016" Text="Grúa" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR017" Text="Integral" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR018" Text="Jaula" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR019" Text="Media Redila" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR020" Text="Pallet o Celdillas" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR021" Text="Plataforma" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR022" Text="Plataforma Con Grúa" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR023" Text="Plataforma Encortinada" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR024" Text="Redilas" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR025" Text="Refrigerador" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR026" Text="Revolvedora" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR027" Text="Semicaja" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR028" Text="Tanque" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR029" Text="Tolva" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR030" Text="Tractor" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR031" Text="Volteo" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR032" Text="Volteo Desmontable" ></asp:ListItem>

                        </asp:DropDownList>
                        </td>
                         <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>Placa:</td>
                      <td>   <asp:TextBox ID="txtPlaca" runat="server" CssClass="form-control2"  Enabled="false"   MaxLength="10"></asp:TextBox>
                      </td>
                </tr>
                <tr>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                     <td>     <asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator21" ControlToValidate="txtPlaca" Enabled="false"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="CrearFactura" style="font-size: medium" /></td>
                </tr>
                 <tr>
                 <td></td><td style="text-align: right;"> <asp:CheckBox runat="server" ID="cbSubTipoRem2" Text="Activar" 
                    AutoPostBack="True" oncheckedchanged="cbSubTipoRem2_CheckedChanged" 
                    style="font-weight: 700; color:Black;"/></td>
                 <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>
                           SubTipoRem:
                        </td>
                        <td>
                        <asp:DropDownList runat="server" ID="ddlSubTipoRem2" style="margin-left: 0px"  Enabled="false" CssClass="form-control2"  Width="250px">
                       <asp:ListItem runat="server" Value="CTR001" Text="Caballete" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR002" Text="Caja" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR003" Text="Caja Abierta" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR004" Text="Caja Cerrada" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR005" Text="Caja De Recolección Con Cargador Frontal" ></asp:ListItem> 
                       <asp:ListItem runat="server" Value="CTR006" Text="Caja Refrigerada" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR007" Text="Caja Seca" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR008" Text="Caja Transferencia" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR009" Text="Cama Baja o Cuello Ganso" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR010" Text="Chasis Portacontenedor" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR011" Text="Convencional De Chasis" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR012" Text="Equipo Especial" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR013" Text="Estacas" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR014" Text="Góndola Madrina" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR015" Text="Grúa Industrial" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR016" Text="Grúa" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR017" Text="Integral" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR018" Text="Jaula" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR019" Text="Media Redila" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR020" Text="Pallet o Celdillas" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR021" Text="Plataforma" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR022" Text="Plataforma Con Grúa" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR023" Text="Plataforma Encortinada" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR024" Text="Redilas" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR025" Text="Refrigerador" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR026" Text="Revolvedora" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR027" Text="Semicaja" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR028" Text="Tanque" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR029" Text="Tolva" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR030" Text="Tractor" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR031" Text="Volteo" ></asp:ListItem>
                       <asp:ListItem runat="server" Value="CTR032" Text="Volteo Desmontable" ></asp:ListItem>

                        </asp:DropDownList>
                        </td>
                         <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>Placa:</td>
                      <td>   <asp:TextBox ID="txtPlaca2" runat="server" CssClass="form-control2"  Enabled="false"   MaxLength="10"></asp:TextBox>
                      </td>
                </tr>
                <tr>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                     <td>     <asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator22" ControlToValidate="txtPlaca2" Enabled="false"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="CrearFactura" style="font-size: medium" /></td>
                </tr>
                <tr>
                    <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>
                           PermSCT:
                        </td>
                        <td>
                        <asp:DropDownList runat="server" ID="ddlPermSCT" style="margin-left: 0px" CssClass="form-control2"  Width="250px">
                         <asp:ListItem runat="server" Value="TPAF01" Text="Autotransporte Federal de carga general." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF02" Text="Transporte privado de carga." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF03" Text="Autotransporte Federal de Carga Especializada de materiales y residuos peligrosos." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF04" Text="Transporte de automóviles sin rodar en vehículo tipo góndola." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF05" Text="Transporte de carga de gran peso y/o volumen de hasta 90 toneladas." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF06" Text="Transporte de carga especializada de gran peso y/o volumen de más 90 toneladas." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF07" Text="Transporte Privado de materiales y residuos peligrosos." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF08" Text="Autotransporte internacional de carga de largo recorrido." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF09" Text="Autotransporte internacional de carga especializada de materiales y residuos peligrosos de largo recorrido." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF10" Text="Autotransporte Federal de Carga General cuyo ámbito de aplicación comprende la franja fronteriza con Estados Unidos." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF11" Text="Autotransporte Federal de Carga Especializada cuyo ámbito de aplicación comprende la franja fronteriza con Estados Unidos." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF12" Text="Servicio auxiliar de arrastre en las vías generales de comunicación." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF13" Text="Servicio auxiliar de servicios de arrastre, arrastre y salvamento, y depósito de vehículos en las vías generales de comunicación." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF14" Text="Servicio de paquetería y mensajería en las vías generales de comunicación." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF15" Text="Transporte especial para el tránsito de grúas industriales con peso máximo de 90 toneladas." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF16" Text="Servicio federal para empresas arrendadoras servicio público federal." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF17" Text="Empresas trasladistas de vehículos nuevos." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF18" Text="Empresas fabricantes o distribuidoras de vehículos nuevos." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF19" Text="Autorización expresa para circular en los caminos y puentes de jurisdicción federal con configuraciones de tractocamión doblemente articulado." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPTM01" Text="Permiso temporal para navegación de cabotaje" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="TPTA01" Text="Concesión y/o autorización para el servicio regular nacional y/o internacional para empresas mexicanas" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="TPTA02" Text="Permiso para el servicio aéreo regular de empresas extranjeras" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="TPTA03" Text="Permiso para el servicio nacional e internacional no regular de fletamento" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="TPTA04" Text="Permiso para el servicio nacional e internacional no regular de taxi aéreo" ></asp:ListItem>

                        </asp:DropDownList>
                        </td>
                         <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>NumPermisoSCT:</td>
                      <td>   <asp:TextBox ID="txtNumPermisoSCT" runat="server" CssClass="form-control2"    MaxLength="50"></asp:TextBox>
                      </td>
                          <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>NombreAseg:</td>
                      <td>   <asp:TextBox ID="txtNombreAseg" runat="server" CssClass="form-control2"    MaxLength="50"></asp:TextBox>
                      </td>
                    
                </tr>
                <tr>
                <td></td>
                <td></td>
                <td></td>
                <td><asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator23" ControlToValidate="txtNumPermisoSCT" 
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="CrearFactura" style="font-size: medium" /></td>
                           <td></td>
                           <td><asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator24" ControlToValidate="txtNombreAseg" 
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="CrearFactura" style="font-size: medium" /></td>
                        
                </tr>
                <tr>
                      <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>NumPolizaSeguro:</td>
                      <td>   <asp:TextBox ID="txtNumPolizaSeguro" runat="server" CssClass="form-control2"    MaxLength="30"></asp:TextBox>
                      </td>
                </tr>
                <tr>
                   <td></td>
                           <td><asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator25" ControlToValidate="txtNumPolizaSeguro" 
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="CrearFactura" style="font-size: medium" /></td>
                </tr>
                </table>
                
                 
         </div>
         </div>
         
                 <div style="border: solid 2px gray">
               &nbsp;&nbsp;&nbsp; <asp:CheckBox runat="server" ID="cbTransporteMaritimo" Text="TransporteMaritimo" 
                    AutoPostBack="True" oncheckedchanged="cbTransporteMaritimo_CheckedChanged" 
                    style="font-weight: 700; color:Black;"/>
		
       
          <div id="DivTransporteMaritimo"  style="width:100%" runat="server" visible="False">
        

                 <h1 style="text-align: center; " class="style156">
                <strong>TransporteMaritimo</strong></h1>
                <table>
                <tr>
                     <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>MatriculaContenedor:</td>
                      <td>   <asp:TextBox ID="txtMatriculaContenedor" runat="server" CssClass="form-control2"    MaxLength="15"></asp:TextBox>
                      </td>
                  <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>
                           TipoContenedor:
                        </td>
                        <td>
                        <asp:DropDownList runat="server" ID="ddlTipoContenedor" style="margin-left: 0px"  CssClass="form-control2"  Width="250px">
                        <asp:ListItem runat="server" Value="CM001" Text="Contenedores refrigerados de 20FT" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="CM002" Text="Contenedores refrigerados de 40FT" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="CM003" Text="Contenedores estándar de 8FT" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="CM004" Text="Contenedores estándar de 10FT" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="CM005" Text="Contenedores estándar de 20FT" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="CM006" Text="Contenedores estándar de 40FT" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="CM007" Text="Contenedores Open Side" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="CM008" Text="Contenedor Isotanque" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="CM009" Text="Contenedor flat racks" ></asp:ListItem>

                        </asp:DropDownList>
                        </td>
                         <td style="text-align: right;">NumPrecinto:</td>
                      <td>   <asp:TextBox ID="txtNumPrecinto" runat="server" CssClass="form-control2"  MaxLength="20"></asp:TextBox>
                      </td>

                </tr>
                <tr>
                <td></td>
                <td><asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator26" ControlToValidate="txtMatriculaContenedor" 
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="AgregarContenedor" style="font-size: medium" /></td>
                </tr>
                           <tr>
                           <td></td>
                     <td></td>
                     <td></td>
                      <td></td>
                     <td></td>
            <td style="text-align: right;" >   <asp:Button runat="server" ID="btnContenedor" Text="Agregar Contenedor" 
        ValidationGroup="AgregarContenedor"  class="btn btn-primary" 
        onclick="btnContenedor_Click" Width="133px"/>
        
        </td>
              </tr>
             </table> 
             <div style="height: 100%; overflow-y: scroll" >
                <asp:GridView runat="server" ID="gvContenedor" AutoGenerateColumns="False"  CssClass="style124" Width="100%" 
                HorizontalAlign="Center"   ShowHeaderWhenEmpty="True" OnRowCommand="gvContenedor_RowCommand">
                    <Columns>
                      <asp:BoundField HeaderText="Contenedor" DataField="id" Visible="false">
                         <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                       
                        <asp:BoundField HeaderText="MatriculaContenedor" DataField="MatriculaContenedor" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="TipoContenedor" DataField="TipoContenedor" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="NumPrecinto" DataField="NumPrecinto" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                         <asp:ButtonField Text="Eliminar" CommandName="EliminarContenedor" Visible="False" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:ButtonField>
                    </Columns>
                </asp:GridView>
            </div>
            <table>
            <tr>
                 <td style="text-align: right;">
                           PermSCT:
                        </td>
                        <td>
                        <asp:DropDownList runat="server" ID="ddlPermSCTTransporteMaritimo" style="margin-left: 0px" CssClass="form-control2"  Width="250px">
                         <asp:ListItem runat="server" Text="Seleccionar" Value="00"></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF01" Text="Autotransporte Federal de carga general." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF02" Text="Transporte privado de carga." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF03" Text="Autotransporte Federal de Carga Especializada de materiales y residuos peligrosos." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF04" Text="Transporte de automóviles sin rodar en vehículo tipo góndola." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF05" Text="Transporte de carga de gran peso y/o volumen de hasta 90 toneladas." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF06" Text="Transporte de carga especializada de gran peso y/o volumen de más 90 toneladas." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF07" Text="Transporte Privado de materiales y residuos peligrosos." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF08" Text="Autotransporte internacional de carga de largo recorrido." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF09" Text="Autotransporte internacional de carga especializada de materiales y residuos peligrosos de largo recorrido." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF10" Text="Autotransporte Federal de Carga General cuyo ámbito de aplicación comprende la franja fronteriza con Estados Unidos." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF11" Text="Autotransporte Federal de Carga Especializada cuyo ámbito de aplicación comprende la franja fronteriza con Estados Unidos." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF12" Text="Servicio auxiliar de arrastre en las vías generales de comunicación." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF13" Text="Servicio auxiliar de servicios de arrastre, arrastre y salvamento, y depósito de vehículos en las vías generales de comunicación." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF14" Text="Servicio de paquetería y mensajería en las vías generales de comunicación." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF15" Text="Transporte especial para el tránsito de grúas industriales con peso máximo de 90 toneladas." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF16" Text="Servicio federal para empresas arrendadoras servicio público federal." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF17" Text="Empresas trasladistas de vehículos nuevos." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF18" Text="Empresas fabricantes o distribuidoras de vehículos nuevos." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF19" Text="Autorización expresa para circular en los caminos y puentes de jurisdicción federal con configuraciones de tractocamión doblemente articulado." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPTM01" Text="Permiso temporal para navegación de cabotaje" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="TPTA01" Text="Concesión y/o autorización para el servicio regular nacional y/o internacional para empresas mexicanas" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="TPTA02" Text="Permiso para el servicio aéreo regular de empresas extranjeras" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="TPTA03" Text="Permiso para el servicio nacional e internacional no regular de fletamento" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="TPTA04" Text="Permiso para el servicio nacional e internacional no regular de taxi aéreo" ></asp:ListItem>

                        </asp:DropDownList>
                        </td>
                <td style="text-align: right;">NumPermisoSCT:</td>
                      <td>   <asp:TextBox ID="txtTransporteMaritimoNumPermisoSCT" runat="server" CssClass="form-control2"    MaxLength="30"></asp:TextBox>
                      </td>
                        <td style="text-align: right;">NombreAseg:</td>
                      <td>   <asp:TextBox ID="txtTransporteMaritimoNombreAseg" runat="server" CssClass="form-control2"    MaxLength="50"></asp:TextBox>
                      </td>
                      </tr>
                      <tr>
                       <td style="text-align: right;">NumPolizaSeguro:</td>
                      <td>   <asp:TextBox ID="txtTransporteMaritimNumPolizaSeguro" runat="server" CssClass="form-control2"    MaxLength="30"></asp:TextBox>
                      </td>
                        <td style="text-align: right;">
                           TipoEmbarcacion:
                        </td>
                        <td>
                        <asp:DropDownList runat="server" ID="ddlTipoEmbarcacion" style="margin-left: 0px" CssClass="form-control2"  Width="180px">
                           <asp:ListItem runat="server" Text="Seleccionar" Value="00"></asp:ListItem>
                      <asp:ListItem runat="server" Value="B01" Text="Abastecedor" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="B02" Text="Barcaza" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="B03" Text="Granelero" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="B04" Text="Porta Contenedor" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="B05" Text="Draga" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="B06" Text="Pesquero" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="B07" Text="Carga General" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="B08" Text="Quimiqueros" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="B09" Text="Transbordadores" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="B10" Text="Carga RoRo" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="B11" Text="Investigación" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="B12" Text="Tanquero" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="B13" Text="Gasero" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="B14" Text="Remolcador" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="B15" Text="Extraordinaria especialización" ></asp:ListItem>
                        </asp:DropDownList>
                        </td>
                         <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>Matricula:</td>
                      <td>   <asp:TextBox ID="txtMatricula" runat="server" CssClass="form-control2"    MaxLength="30"></asp:TextBox>
                      </td>
            </tr>
            <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td><asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator27" ControlToValidate="txtMatricula" 
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="CrearFactura" style="font-size: medium" /></td>
            </tr>
            <tr>
                <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>NumeroOMI:</td>
                      <td>   <asp:TextBox ID="txtNumeroOMI" runat="server" CssClass="form-control2"    MaxLength="10"></asp:TextBox>
                      </td>
                      <td style="text-align: right;">AnioEmbarcacion:</td>
                      <td>   <asp:TextBox ID="txtAnioEmbarcacion" runat="server" CssClass="form-control2"    MaxLength="4"></asp:TextBox>
                      </td>
                        <td style="text-align: right;">NombreEmbarc:</td>
                      <td>   <asp:TextBox ID="txtNombreEmbarc" runat="server" CssClass="form-control2"    MaxLength="50"></asp:TextBox>
                      </td>
               
            </tr>
            <tr>
            <td></td>
            <td><asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator29" ControlToValidate="txtNumeroOMI"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="CrearFactura" style="font-size: medium" /></td>
            <td></td>
            <td>
                          <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender14" runat="server"
                     Enabled="True" TargetControlID="txtAnioEmbarcacion" FilterType="Numbers"></asp:FilteredTextBoxExtender></td>
            </tr>
            <tr>
            <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>NacionalidadEmbarc:</td>
           <td><cc1:DropDownListChosen ID="ddlNacionalidadEmbarc" runat="server"  CausesValidation="false" 
            NoResultsText="No hay resultados coincidentes."  Width="185px"  Height="16px"   SelectMethod=""          
            DataPlaceHolder="Escriba aquí..." AllowSingleDeselect="true" AutoPostBack="True" AppendDataBoundItems="True" >              
        </cc1:DropDownListChosen></td>
               <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>UnidadesDeArqBruto:</td>
                      <td>   <asp:TextBox ID="txtUnidadesDeArqBruto" runat="server" CssClass="form-control2"  ></asp:TextBox>
                      <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender17" runat="server"
    TargetControlID="txtUnidadesDeArqBruto" FilterType="Custom, Numbers" ValidChars="." Enabled="True" />
                      </td>
                 <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>
                           TipoCarga:
                        </td>
                        <td>
                        <asp:DropDownList runat="server" ID="ddlTipoCarga" style="margin-left: 0px" CssClass="form-control2"  Width="180px">
                        <asp:ListItem runat="server" Value="CGS" Text="Carga General Suelta" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="CGC" Text="Carga General Contenerizada" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="GMN" Text="Gran Mineral" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="GAG" Text="Granel Agrícola" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="OFL" Text="Otros Fluidos" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="PYD" Text="Pretóleo y Derivados" ></asp:ListItem>
                        </asp:DropDownList>
                        </td>
            </tr>
            <tr>
            <td></td>
            <td><asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator56" ControlToValidate="ddlNacionalidadEmbarc"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="CrearFactura" style="font-size: medium" /></td>
            <td></td>
            <td><asp:RegularExpressionValidator id="RegularExpressionValidator16" 
            runat="server" Display="Dynamic" CssClass="alert-danger"
    ControlToValidate="txtUnidadesDeArqBruto" ErrorMessage="Dato invalido" 
                         ValidationExpression="[0-9]*\.?[0-9]*" 
                         ValidationGroup="CrearFactura" style="font-size: medium"/>
                         <asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator28" ControlToValidate="txtUnidadesDeArqBruto"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="CrearFactura" style="font-size: medium" /></td>

            </tr>
            <tr>
             <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>NumCertITC:</td>
                      <td>   <asp:TextBox ID="txtNumCertITC" runat="server" CssClass="form-control2"    MaxLength="20"></asp:TextBox>
                      </td>
                     <td style="text-align: right;">Eslora:</td>
                      <td>   <asp:TextBox ID="txtEslora" runat="server" CssClass="form-control2"  ></asp:TextBox>
                      <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender16" runat="server"
    TargetControlID="txtEslora" FilterType="Custom, Numbers" ValidChars="." Enabled="True" />
                      </td>
                         <td style="text-align: right;">Manga:</td>
                      <td>   <asp:TextBox ID="txtManga" runat="server" CssClass="form-control2"  ></asp:TextBox>
                        <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender15" runat="server"
    TargetControlID="txtManga" FilterType="Custom, Numbers" ValidChars="." Enabled="True" />
                      </td>

            </tr>
            <tr>
            <td></td>
            <td><asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator30" ControlToValidate="txtNumCertITC"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="CrearFactura" style="font-size: medium" /></td>
                           <td></td>
                           <td><asp:RegularExpressionValidator id="RegularExpressionValidator17" 
            runat="server" Display="Dynamic" CssClass="alert-danger"
    ControlToValidate="txtEslora" ErrorMessage="Dato invalido" 
                         ValidationExpression="[0-9]*\.?[0-9]*" 
                         ValidationGroup="CrearFactura" style="font-size: medium"/></td>
                           <td></td>
                           <td><asp:RegularExpressionValidator id="RegularExpressionValidator18" 
            runat="server" Display="Dynamic" CssClass="alert-danger"
    ControlToValidate="txtManga" ErrorMessage="Dato invalido" 
                         ValidationExpression="[0-9]*\.?[0-9]*" 
                         ValidationGroup="CrearFactura" style="font-size: medium"/></td>
            </tr>
            <tr>
            <td style="text-align: right;">Calado:</td>
                      <td>   <asp:TextBox ID="txtCalado" runat="server" CssClass="form-control2"  ></asp:TextBox>
                        <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender18" runat="server"
    TargetControlID="txtCalado" FilterType="Custom, Numbers" ValidChars="." Enabled="True" />
                      </td>
                      <td style="text-align: right;">LineaNaviera:</td>
                      <td>   <asp:TextBox ID="txtLineaNaviera" runat="server" CssClass="form-control2"    MaxLength="50"></asp:TextBox>
                      </td>
                     <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>NombreAgenteNaviero:</td>
                      <td>   <asp:TextBox ID="txtNombreAgenteNaviero" runat="server" CssClass="form-control2"    MaxLength="100"></asp:TextBox>
                      </td>
               
            </tr>
            <tr>
            <td><asp:RegularExpressionValidator id="RegularExpressionValidator19" 
            runat="server" Display="Dynamic" CssClass="alert-danger"
    ControlToValidate="txtCalado" ErrorMessage="Dato invalido" 
                         ValidationExpression="[0-9]*\.?[0-9]*" 
                         ValidationGroup="CrearFactura" style="font-size: medium"/></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td><asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator31" ControlToValidate="txtNombreAgenteNaviero"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="CrearFactura" style="font-size: medium" /></td>
            </tr>
            <tr>
                <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>
                           NumAutorizacionNaviero:
                        </td>
                        <td>
                        <asp:DropDownList runat="server" ID="ddlNumAutorizacionNaviero" style="margin-left: 0px" CssClass="form-control2"  Width="180px">
                   <asp:ListItem runat="server" Value="SCT418/020/2016" Text="SCT418/020/2016" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/021/2016" Text="SCT418/021/2016" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/025/2016" Text="SCT418/025/2016" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/026/2016" Text="SCT418/026/2016" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/028/2016" Text="SCT418/028/2016" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/029/2016" Text="SCT418/029/2016" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/030/2016" Text="SCT418/030/2016" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/034/2016" Text="SCT418/034/2016" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/036/2016" Text="SCT418/036/2016" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/042/2016" Text="SCT418/042/2016" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/046/2016" Text="SCT418/046/2016" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/047/2016" Text="SCT418/047/2016" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/048/2016" Text="SCT418/048/2016" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/051/2016" Text="SCT418/051/2016" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/052/2016" Text="SCT418/052/2016" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/010/2017" Text="SCT418/010/2017" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/014/2017" Text="SCT418/014/2017" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/017/2017" Text="SCT418/017/2017" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/021/2017" Text="SCT418/021/2017" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/022/2017" Text="SCT418/022/2017" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/023/2017" Text="SCT418/023/2017" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/024/2017" Text="SCT418/024/2017" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/030/2017" Text="SCT418/030/2017" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/031/2017" Text="SCT418/031/2017" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/034/2017" Text="SCT418/034/2017" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/035/2017" Text="SCT418/035/2017" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/038/2017" Text="SCT418/038/2017" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/044/2017" Text="SCT418/044/2017" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/045/2017" Text="SCT418/045/2017" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/047/2017" Text="SCT418/047/2017" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/053/2017" Text="SCT418/053/2017" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/054/2017" Text="SCT418/054/2017" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/056/2017" Text="SCT418/056/2017" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/057/2017" Text="SCT418/057/2017" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/060/2017" Text="SCT418/060/2017" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/061/2017" Text="SCT418/061/2017" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/064/2017" Text="SCT418/064/2017" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/065/2017" Text="SCT418/065/2017" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/006/2018" Text="SCT418/006/2018" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/013/2018" Text="SCT418/013/2018" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/014/2018" Text="SCT418/014/2018" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/017/2018" Text="SCT418/017/2018" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/018/2018" Text="SCT418/018/2018" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/019/2018" Text="SCT418/019/2018" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/022/2018" Text="SCT418/022/2018" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/026/2018" Text="SCT418/026/2018" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/031/2018" Text="SCT418/031/2018" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/033/2018" Text="SCT418/033/2018" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/037/2018" Text="SCT418/037/2018" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/038/2018" Text="SCT418/038/2018" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/040/2018" Text="SCT418/040/2018" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/041/2018" Text="SCT418/041/2018" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/043/2018" Text="SCT418/043/2018" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/045/2018" Text="SCT418/045/2018" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/046/2018" Text="SCT418/046/2018" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/048/2018" Text="SCT 418/048/2018" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/050/2018" Text="SCT 418/050/2018" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/053/2018" Text="SCT 418/053/2018" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/057/2018" Text="SCT418/057/2018" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/068/2018" Text="SCT418/068/2018" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/003/2019" Text="SCT418/003/2019" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/005/2019" Text="SCT418/005/2019" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/013/2019" Text="SCT418/013/2019" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/015/2019" Text="SCT418/015/2019" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/020/2019" Text="SCT418/020/2019" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/025/2019" Text="SCT418/025/2019" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/026/2019" Text="SCT418/026/2019" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/027/2019" Text="SCT418/027/2019" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/029/2019" Text="SCT418/029/2019" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/036/2019" Text="SCT418/036/2019" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/037/2019" Text="SCT418/037/2019" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/038/2019" Text="SCT418/038/2019" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/041/2019" Text="SCT418/041/2019" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/045/2019" Text="SCT418/045/2019" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/046/2019" Text="SCT418/046/2019" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/003/2020" Text="SCT418/003/2020" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/005/2020" Text="SCT418/005/2020" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/006/2020" Text="SCT418/006/2020" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/010/2020" Text="SCT418/010/2020" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/011/2020" Text="SCT418/011/2020" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/012/2020" Text="SCT418/012/2020" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/013/2020" Text="SCT418/013/2020" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/023/2020" Text="SCT418/023/2020" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/024/2020" Text="SCT418/024/2020" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/025/2020" Text="SCT418/025/2020" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/026/2020" Text="SCT418/026/2020" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/027/2020" Text="SCT418/027/2020" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/029/2020" Text="SCT418/029/2020" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/030/2020" Text="SCT418/030/2020" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/031/2020" Text="SCT418/031/2020" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/032/2020" Text="SCT418/032/2020" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/033/2020" Text="SCT418/033/2020" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/035/2020" Text="SCT418/035/2020" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/036/2020" Text="SCT418/036/2020" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/037/2020" Text="SCT418/037/2020" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/040/2020" Text="SCT418/040/2020" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/041/2020" Text="SCT418/041/2020" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/042/2020" Text="SCT418/042/2020" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/001/2021" Text="SCT418/001/2021" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/005/2021" Text="SCT418/005/2021" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/006/2021" Text="SCT418/006/2021" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/007/2021" Text="SCT418/007/2021" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/013/2021" Text="SCT418/013/2021" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/020/2021" Text="SCT418/020/2021" ></asp:ListItem>
<asp:ListItem runat="server" Value="SCT418/021/2021" Text="SCT418/021/2021" ></asp:ListItem>
                        </asp:DropDownList>
                        </td>
                        <td style="text-align: right;">NumViaje:</td>
                      <td>   <asp:TextBox ID="txtNumViaje" runat="server" CssClass="form-control2" MaxLength="30"></asp:TextBox>
                      </td>
                          <td style="text-align: right;">NumConocEmbarc:</td>
                      <td>   <asp:TextBox ID="txtNumConocEmbarc" runat="server" CssClass="form-control2" MaxLength="30"></asp:TextBox>
                      </td>
            </tr>
            </table>

         </div>
         </div>
                 <div style="border: solid 2px gray">
               &nbsp;&nbsp;&nbsp; <asp:CheckBox runat="server" ID="cbTransporteAereo" Text="TransporteAereo" 
                    AutoPostBack="True" oncheckedchanged="cbTransporteAereo_CheckedChanged" 
                    style="font-weight: 700; color:Black;"/>
		
       
          <div id="DivTransporteAereo"  style="width:100%" runat="server" visible="False">
        

                 <h1 style="text-align: center; " class="style156">
                <strong>TransporteAereo</strong></h1>
                <table>
                <tr>
                 <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>
                           PermSCT:
                        </td>
                        <td>
                        <asp:DropDownList runat="server" ID="ddlTransporteAereoPermSCT" style="margin-left: 0px" CssClass="form-control2"  Width="250px">
                         <asp:ListItem runat="server" Value="TPAF01" Text="Autotransporte Federal de carga general." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF02" Text="Transporte privado de carga." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF03" Text="Autotransporte Federal de Carga Especializada de materiales y residuos peligrosos." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF04" Text="Transporte de automóviles sin rodar en vehículo tipo góndola." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF05" Text="Transporte de carga de gran peso y/o volumen de hasta 90 toneladas." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF06" Text="Transporte de carga especializada de gran peso y/o volumen de más 90 toneladas." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF07" Text="Transporte Privado de materiales y residuos peligrosos." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF08" Text="Autotransporte internacional de carga de largo recorrido." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF09" Text="Autotransporte internacional de carga especializada de materiales y residuos peligrosos de largo recorrido." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF10" Text="Autotransporte Federal de Carga General cuyo ámbito de aplicación comprende la franja fronteriza con Estados Unidos." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF11" Text="Autotransporte Federal de Carga Especializada cuyo ámbito de aplicación comprende la franja fronteriza con Estados Unidos." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF12" Text="Servicio auxiliar de arrastre en las vías generales de comunicación." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF13" Text="Servicio auxiliar de servicios de arrastre, arrastre y salvamento, y depósito de vehículos en las vías generales de comunicación." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF14" Text="Servicio de paquetería y mensajería en las vías generales de comunicación." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF15" Text="Transporte especial para el tránsito de grúas industriales con peso máximo de 90 toneladas." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF16" Text="Servicio federal para empresas arrendadoras servicio público federal." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF17" Text="Empresas trasladistas de vehículos nuevos." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF18" Text="Empresas fabricantes o distribuidoras de vehículos nuevos." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPAF19" Text="Autorización expresa para circular en los caminos y puentes de jurisdicción federal con configuraciones de tractocamión doblemente articulado." ></asp:ListItem>
                         <asp:ListItem runat="server" Value="TPTM01" Text="Permiso temporal para navegación de cabotaje" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="TPTA01" Text="Concesión y/o autorización para el servicio regular nacional y/o internacional para empresas mexicanas" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="TPTA02" Text="Permiso para el servicio aéreo regular de empresas extranjeras" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="TPTA03" Text="Permiso para el servicio nacional e internacional no regular de fletamento" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="TPTA04" Text="Permiso para el servicio nacional e internacional no regular de taxi aéreo" ></asp:ListItem>

                        </asp:DropDownList>
                        </td>
                         <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>numPermisoSCT:</td>
                      <td>   <asp:TextBox ID="txtTransporteAereoNumConocEmbarc" runat="server" CssClass="form-control2" MaxLength="50"></asp:TextBox>
                      </td>
                           <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>MatriculaAeronave:</td>
                      <td>   <asp:TextBox ID="txtMatriculaAeronave" runat="server" CssClass="form-control2" MaxLength="50"></asp:TextBox>
                      </td>
                </tr>
                <tr>
                <td></td>
                <td></td>
                <td></td>
                <td><asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator32" ControlToValidate="txtTransporteAereoNumConocEmbarc"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="CrearFactura" style="font-size: medium" /></td>
                           <td></td>
                           <td><asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator33" ControlToValidate="txtMatriculaAeronave"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="CrearFactura" style="font-size: medium" /></td>
                </tr>
                <tr>
                  <td style="text-align: right;">NombreAseg:</td>
                      <td>   <asp:TextBox ID="txtTransporteAereoNombreAseg" runat="server" CssClass="form-control2" MaxLength="50"></asp:TextBox>
                      </td>
                  <td style="text-align: right;">NumPolizaSeguro:</td>
                      <td>   <asp:TextBox ID="txtTransporteAereoNumPolizaSeguro" runat="server" CssClass="form-control2" MaxLength="30"></asp:TextBox>
                      </td>
                       <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>NumeroGuia:</td>
                      <td>   <asp:TextBox ID="txtNumeroGuia" runat="server" CssClass="form-control2" MaxLength="15"></asp:TextBox>
                             </td>
                </tr>
                <tr>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td><asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator34" ControlToValidate="txtNumeroGuia"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="CrearFactura" style="font-size: medium" /></td>
                </tr>
                <tr>
                   <td style="text-align: right;">LugarContrato:</td>
                      <td>   <asp:TextBox ID="txtLugarContrato" runat="server" CssClass="form-control2" MaxLength="120"></asp:TextBox>
                      </td>
                       <td style="text-align: right;">RFCTransportista:</td>
                      <td>   <asp:TextBox ID="txtRFCTransportista" runat="server" CssClass="form-control2" MaxLength="13"></asp:TextBox>
                      </td>
                         <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>
                           CodigoTransportista:
                        </td>
                        <td>
                        <asp:DropDownList runat="server" ID="ddlCodigoTransportista" style="margin-left: 0px" CssClass="form-control2"  Width="200px">
                       <asp:ListItem runat="server" Value="CA001" Text="All Nippon Airways LTD" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA002" Text="Cathay Pacific Airways Limited" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA003" Text="China Southern Airlines" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA004" Text="Emirates" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA005" Text="Hainan Airlines" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA006" Text="Korean Air" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA007" Text="Qatar Airlines " ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA008" Text="Air Canada" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA009" Text="Air Transat (Transat A. T.)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA010" Text="Canjet (Imp Group Limited/Canjet Airlines)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA011" Text="Cargojet Airways Ltd" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA012" Text="Flair Airlines" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA013" Text="Jazz  Air  LP" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA014" Text="Sunwing (Sunwing Airlines)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA015" Text="Swoop Airlines" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA016" Text="West Jet (Westjet Airlines Ltd)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA017" Text="Aerolíneas Argentinas" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA018" Text="Aerorepública" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA019" Text="Avianca (Aerovías Del Continente Americano)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA020" Text="Copa (Compañía Panameña De Aviación)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA021" Text="Cubana (Cubana De Aviación)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA022" Text="DHL De Guatemala (DHL De Guatemala)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA023" Text="GOL Linhas Aéreas" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA024" Text="Lacsa (Líneas Aéreas Costarricences)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA025" Text="LAN Cargo" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA026" Text="Lan Chile Airlines (Línea Aérea Nacional De Chile)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA027" Text="Lan Colombia" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA028" Text="Lanperu" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA029" Text="Taca (Taca International Airlines)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA030" Text="Taca Peru (Trans American Airlines)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA038" Text="BahamasAir Holdings LTD" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA031" Text="Tam Linhas Aereas" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA032" Text="Tampa (Tampa Cargo)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA033" Text="Transcarga International Airways" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA034" Text="Tropic Air Limited" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA035" Text="Viva Air Colombia" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA036" Text="Volaris Costa Rica" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA037" Text="VRG Linhas Aereas, S.A." ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA039" Text="21 Air" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA040" Text="Abx (Abx Air)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA041" Text="Alaska Airlines" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA042" Text="American Airlines" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA043" Text="Amerijet International" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA044" Text="Ameristar Air Cargo" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA045" Text="Atlas Air" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA046" Text="BOSTON MAINE" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA047" Text="C&M AIRWAYS" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA048" Text="Caribbean Sun Airlines" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA049" Text="CENTURION" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA050" Text="Compass Airlines" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA051" Text="Continental Express (Express Jet)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA052" Text="Delta Airlines" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA053" Text="Delux Public Air Charter Inc" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA054" Text="Envoy Air, Inc" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA055" Text="FALCON AIR EXPRESS" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA056" Text="FEDEX (Federal Express)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA057" Text="Florida West" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA058" Text="Frontier" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA059" Text="Gulf & Caribbean Cargo" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA060" Text="Horizont Air (Horizont Air Industries)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA061" Text="Interjet West Inc" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA062" Text="Jet Blue Air (Jet Blue Airways Corporation)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA063" Text="Kalitta (Kalitta Charters II)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA064" Text="Kalitta Air" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA065" Text="Key Air Llc." ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA066" Text="Mesa Airlines (Mesa Airlines, Inc.)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA067" Text="Miami Air  (Miami Air International Inc)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA068" Text="MN Airlines" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA069" Text="National Air Cargo Group. Inc.(National Airlines)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA070" Text="Northern Air Cargo Inc." ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA071" Text="ORANGE AIR LLC" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA072" Text="Republic Airlines" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA073" Text="Sky Lease I, Inc" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA074" Text="Skywest Airlines" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA075" Text="Southwest Airlines" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA076" Text="Spirit Airlines" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA077" Text="Sun Country" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA078" Text="Swift Air" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA079" Text="Tatonduk Outfitters Limited DBA Everts Air Cargo" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA080" Text="Tem Enterprises" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA081" Text="U.S.A. Jet Airlines" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA082" Text="Ultimate Jet Charter" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA083" Text="United Airlines, Inc." ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA084" Text="Ups (United Parcel Service)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA085" Text="US Air (U.S. Airways)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA086" Text="Virgin America, Inc" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA087" Text="Eurowings GMBH." ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA088" Text="Air Atlanta Icelandic" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA089" Text="Air Berlín" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA090" Text="Air Europa (Air España)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA091" Text="Air France (Société Air France)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA092" Text="Alitalia" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA093" Text="Antonov Company (Aerolíneas Antonov)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA094" Text="Azur Air" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA095" Text="Blue Panorama" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA096" Text="British Airways" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA097" Text="C.A.L. Cargo Airlines" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA098" Text="CargoLogicAir" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA099" Text="Cargolux Airlines" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA100" Text="Cargolux Italia S. P. A." ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA101" Text="Corsair (Corse Air Int.)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA102" Text="Edelweiss (Edelweiss Air Ag) Air Ag" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA103" Text="Evelop Airlines" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA104" Text="Finn Air" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA105" Text="Flugleidir Hf. D/B/A Icelandair" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA106" Text="Hi-Fly Transportes Aereos" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA107" Text="Iberia (Iberia Líneas Aéreas De España)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA108" Text="IKAR LLC." ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA109" Text="K L M (Royal Dutch Airlines)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA110" Text="Lufthansa (Deutsche Lufthansa Ag)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA111" Text="Lufthansa Cargo Ag" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA112" Text="Martin Air (Martin Air Holland N.V)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA113" Text="Neos Air (Neos S.P.A.)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA114" Text="Nordwind" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA115" Text="Norwegian Air Shuttle " ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA116" Text="NOVA AIRLINES" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA117" Text="Orbest" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA118" Text="Polskie Linie Lotnicze" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA119" Text="Privilege Style" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA120" Text="Pullmantur" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA121" Text="Royal Flight" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA122" Text="SATA International  Servicios de Transportes Aereos, s.a." ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA123" Text="Scandinavia (Thomas Cook Airlines Scandinavia )" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA124" Text="Thomas Cook (Thomas Cook Ltd)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA125" Text="Thomson Airways (Thomson Airways Ltd) Ltd" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA126" Text="Thomson Fly Limited" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA127" Text="Titan Airways" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA128" Text="Transaero Airlines" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA129" Text="TRAVEL SERVICE" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA130" Text="TUI Airways" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA131" Text="Tui Belgium" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA132" Text="Tui Nederland" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA133" Text="TUIFLY GMBH" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA134" Text="Tuifly Nordic" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA135" Text="Turkish Airlines" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA136" Text="Virgin Atlantic Airways, Limited" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA137" Text="Wamos Air, S.A." ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA138" Text="White Airways" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA139" Text="Xl Airways (Xl Airways France)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA140" Text="Aéreo Calafia" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA141" Text="Aerolíneas Damojh (Global Air )" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA142" Text="Aeromar" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA143" Text="Aeroméxico (Aerovías De México)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA144" Text="Aeroméxico Connect (Aerolitoral)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA145" Text="Aeronaves TSM" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA146" Text="Aeroservicios de La Costa" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA147" Text="Aerounión (Aerotransportes De Carga Union)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA148" Text="Estafeta (Carga Aérea)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA149" Text="Interjet (Abc Aerolíneas)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA150" Text="Magnicharters (Grupo Aéreo Monterrey)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA151" Text="Mas Air (Más De Carga)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA152" Text="MCS Aerocarga De México, S.A De C.V." ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA153" Text="Servicios Integrales De Aviacion, S.A. De C.V." ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA154" Text="Transportes Aéreos Regionales (TAR)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA155" Text="Vivaaerobus (Aeroenlaces)" ></asp:ListItem>
 <asp:ListItem runat="server" Value="CA156" Text="Volaris (Concesionaria Vuela Cia De Aviación)" ></asp:ListItem>
                        </asp:DropDownList>
                        </td>

                </tr>
                <tr>
                 <td style="text-align: right;">NumRegIdTribTranspor:</td>
                      <td>   <asp:TextBox ID="txtNumRegIdTribTranspor" runat="server" CssClass="form-control2" MaxLength="40"></asp:TextBox>
                      </td>
                     <td style="text-align: right;">ResidenciaFiscalTranspor:</td>
           <td><cc1:DropDownListChosen ID="ddlResidenciaFiscalTranspor" runat="server"  CausesValidation="false" 
            NoResultsText="No hay resultados coincidentes."  Width="185px"  Height="16px"   SelectMethod=""          
            DataPlaceHolder="Escriba aquí..." AllowSingleDeselect="true" AutoPostBack="True" AppendDataBoundItems="True" >              
        </cc1:DropDownListChosen></td>
          <td style="text-align: right;">NombreTransportista:</td>
                      <td>   <asp:TextBox ID="txtNombreTransportista" runat="server" CssClass="form-control2" MaxLength="254"></asp:TextBox>
                      </td>
                </tr>
                <tr>
                   <td style="text-align: right;">RFCEmbarcador:</td>
                      <td>   <asp:TextBox ID="txtRFCEmbarcador" runat="server" CssClass="form-control2" MaxLength="13"></asp:TextBox>
                      </td>
                       <td style="text-align: right;">NumRegIdTribEmbarc:</td>
                      <td>   <asp:TextBox ID="txtNumRegIdTribEmbarc" runat="server" CssClass="form-control2" MaxLength="40"></asp:TextBox>
                      </td>
                    <td style="text-align: right;">ResidenciaFiscalEmbarc:</td>
           <td><cc1:DropDownListChosen ID="ddlResidenciaFiscalEmbarc" runat="server"  CausesValidation="false" 
            NoResultsText="No hay resultados coincidentes."  Width="185px"  Height="16px"   SelectMethod=""          
            DataPlaceHolder="Escriba aquí..." AllowSingleDeselect="true" AutoPostBack="True" AppendDataBoundItems="True" >              
        </cc1:DropDownListChosen></td>
                </tr>
                <tr>
                  <td style="text-align: right;">NombreEmbarcador:</td>
                      <td>   <asp:TextBox ID="txtNombreEmbarcador" runat="server" CssClass="form-control2" MaxLength="254"></asp:TextBox>
                      </td>
                
                </tr>
                </table> 
         </div>
         </div>

            <div style="border: solid 2px gray">
               &nbsp;&nbsp;&nbsp; <asp:CheckBox runat="server" ID="cbTransporteFerroviario" Text="TransporteFerroviario" 
                    AutoPostBack="True" oncheckedchanged="cbTransporteFerroviario_CheckedChanged" 
                    style="font-weight: 700; color:Black;"/>
		
       
          <div id="DivTransporteFerroviario"  style="width:100%" runat="server" visible="False">
        

                 <h1 style="text-align: center; " class="style156">
                <strong>TransporteFerroviario</strong></h1>
                <table>
                <tr>
                  <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>
                           TipoDeServicio:
                        </td>
                        <td>
                        <asp:DropDownList runat="server" ID="ddlTipoDeServicio" style="margin-left: 0px" CssClass="form-control2"  Width="180px">
                        <asp:ListItem runat="server" Value="TS01" Text="Carros Ferroviarios" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="TS02" Text="Carros Ferroviarios intermodal" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="TS03" Text="Tren unitario de carros ferroviarios" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="TS04" Text="Tren unitario Intermodal" ></asp:ListItem>
                         </asp:DropDownList>
                        </td>
                            <td style="text-align: right;">NombreAseg:</td>
                      <td>   <asp:TextBox ID="txtTransporteFerroviarioNombreAseg" runat="server" CssClass="form-control2" MaxLength="50"></asp:TextBox>
                      </td>
                       <td style="text-align: right;">NumPolizaSeguro:</td>
                      <td>   <asp:TextBox ID="txtTransporteFerroviarioNumPolizaSeguro" runat="server" CssClass="form-control2" MaxLength="30"></asp:TextBox>
                      </td>
                      </tr>
                      <tr>
                         <td style="text-align: right;">Concesionario:</td>
                      <td>   <asp:TextBox ID="txtConcesionario" runat="server" CssClass="form-control2" MaxLength="13"></asp:TextBox>
                      </td>
                </tr>
                </table> 

                <div style="width:100%;align-items: center;display: flex; justify-content: center;">
                 <div style="border: solid 2px gray; width:80%" >
               &nbsp;&nbsp;&nbsp; <asp:CheckBox runat="server" ID="cbDerechosDePaso" Text="DerechosDePaso" 
                    AutoPostBack="True" oncheckedchanged="cbDerechosDePaso_CheckedChanged" 
                    style="font-weight: 700; color:Black;"/>
		
       
          <div id="DivDerechosDePaso"  style="width:100%;" runat="server" visible="False">
        

                 <h1 style="text-align: center; " class="style156">
                <strong>DerechosDePaso</strong></h1>

                <table>
                <tr>
                 <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>
                           TipoDerechoDePaso:
                        </td>
                        <td>
                         <asp:DropDownList runat="server" ID="ddlTipoDerechoDePaso" style="margin-left: 0px" CssClass="form-control2"  Width="180px">
                   
                        <asp:ListItem runat="server" Value="CDP001" Text="CDP001" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="CDP002" Text="CDP002" ></asp:ListItem> 
                        <asp:ListItem runat="server" Value="CDP003" Text="CDP003" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="CDP004" Text="CDP004" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="CDP005" Text="CDP005" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="CDP006" Text="CDP006" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="CDP007" Text="CDP007" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="CDP008" Text="CDP008" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="CDP009" Text="CDP009" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="CDP010" Text="CDP010" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="CDP011" Text="CDP011" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="CDP012" Text="CDP012" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="CDP013" Text="CDP013" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP014" Text="CDP014" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP015" Text="CDP015" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP016" Text="CDP016" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP017" Text="CDP017" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP018" Text="CDP018" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP019" Text="CDP019" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP020" Text="CDP020" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP021" Text="CDP021" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP022" Text="CDP022" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP023" Text="CDP023" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP024" Text="CDP024" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP025" Text="CDP025" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP026" Text="CDP026" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP027" Text="CDP027" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP028" Text="CDP028" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP029" Text="CDP029" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP030" Text="CDP030" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP031" Text="CDP031" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP032" Text="CDP032" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP033" Text="CDP033" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP034" Text="CDP034" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP035" Text="CDP035" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP036" Text="CDP036" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP037" Text="CDP037" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP038" Text="CDP038" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP039" Text="CDP039" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP040" Text="CDP040" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP041" Text="CDP041" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP042" Text="CDP042" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP043" Text="CDP043" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP044" Text="CDP044" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP045" Text="CDP045" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP046" Text="CDP046" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP047" Text="CDP047" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP048" Text="CDP048" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP049" Text="CDP049" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP050" Text="CDP050" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP051" Text="CDP051" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP052" Text="CDP052" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP053" Text="CDP053" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP054" Text="CDP054" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP055" Text="CDP055" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP056" Text="CDP056" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP057" Text="CDP057" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP058" Text="CDP058" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP059" Text="CDP059" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP060" Text="CDP060" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP061" Text="CDP061" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP062" Text="CDP062" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP063" Text="CDP063" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP064" Text="CDP064" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP065" Text="CDP065" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP066" Text="CDP066" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP067" Text="CDP067" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP068" Text="CDP068" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP069" Text="CDP069" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP070" Text="CDP070" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP071" Text="CDP071" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP072" Text="CDP072" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP073" Text="CDP073" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP074" Text="CDP074" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP075" Text="CDP075" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP076" Text="CDP076" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP077" Text="CDP077" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP078" Text="CDP078" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP079" Text="CDP079" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP080" Text="CDP080" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP081" Text="CDP081" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP082" Text="CDP082" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP083" Text="CDP083" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP084" Text="CDP084" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP085" Text="CDP085" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP086" Text="CDP086" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP087" Text="CDP087" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP088" Text="CDP088" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP089" Text="CDP089" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP090" Text="CDP090" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP091" Text="CDP091" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP092" Text="CDP092" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP093" Text="CDP093" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP094" Text="CDP094" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP095" Text="CDP095" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP096" Text="CDP096" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP097" Text="CDP097" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP098" Text="CDP098" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP099" Text="CDP099" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP100" Text="CDP100" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP101" Text="CDP101" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP102" Text="CDP102" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP103" Text="CDP103" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP104" Text="CDP104" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP105" Text="CDP105" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP106" Text="CDP106" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP107" Text="CDP107" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP108" Text="CDP108" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP109" Text="CDP109" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP110" Text="CDP110" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP111" Text="CDP111" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP112" Text="CDP112" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP113" Text="CDP113" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP114" Text="CDP114" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP115" Text="CDP115" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP116" Text="CDP116" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP117" Text="CDP117" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP118" Text="CDP118" ></asp:ListItem>
<asp:ListItem runat="server" Value="CDP119" Text="CDP119" ></asp:ListItem>

                         </asp:DropDownList>
                        </td>

                           <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>KilometrajePagado:</td>
                      <td>   <asp:TextBox ID="txtKilometrajePagado" runat="server" CssClass="form-control2"></asp:TextBox>
                       <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender19" runat="server"
    TargetControlID="txtKilometrajePagado" FilterType="Custom, Numbers" ValidChars="." Enabled="True" />
                      </td>
                </tr>
                <tr>
                <td></td>
                <td></td>
                <td></td>
                <td><asp:RegularExpressionValidator id="RegularExpressionValidator20" 
            runat="server" Display="Dynamic" CssClass="alert-danger"
    ControlToValidate="txtKilometrajePagado" ErrorMessage="Dato invalido" 
                         ValidationExpression="[0-9]*\.?[0-9]*" 
                         ValidationGroup="AgregarDerechosDePaso" style="font-size: medium"/>
                         <asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator35" ControlToValidate="txtKilometrajePagado"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="AgregarDerechosDePaso" style="font-size: medium" />
                         </td>
                </tr>
                <tr>
                <td></td>
                   <td></td>
                   <td></td><td></td>
                   <td></td>
            <td style="text-align: right;" >   <asp:Button runat="server" ID="btnDerechosDePaso" Text="Agregar DerechosDePaso" 
        ValidationGroup="AgregarDerechosDePaso"  class="btn btn-primary" 
        onclick="btnDerechosDePaso_Click" Width="133px"/>
        
        </td>
              </tr>
             </table> 
             <div style="height: 100%; overflow-y: scroll" >
                <asp:GridView runat="server" ID="gvDerechosDePaso" AutoGenerateColumns="False"  CssClass="style124" Width="100%" 
                HorizontalAlign="Center"   ShowHeaderWhenEmpty="True" OnRowCommand="gvDerechosDePaso_RowCommand">
                    <Columns>
                      <asp:BoundField HeaderText="DerechosDePaso" DataField="id" Visible="false">
                       
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                       
                        <asp:BoundField HeaderText="TipoDerechoDePaso" DataField="TipoDerechoDePaso" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="KilometrajePagado" DataField="KilometrajePagado" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                         <asp:ButtonField Text="Eliminar" CommandName="EliminarDerechosDePaso" Visible="False" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:ButtonField>
                    </Columns>
                </asp:GridView>
            </div>
              
              <br />
              </div>
              </div>
              </div>

<table>
<tr>
         <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>
                           TipoCarro:
                        </td>
                        <td>
                        <asp:DropDownList runat="server" ID="ddlTipoCarro" style="margin-left: 0px" CssClass="form-control2"  Width="180px">
                        <asp:ListItem runat="server" Value="TC01" Text="Furgón" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="TC02" Text="Góndola" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="TC03" Text="Tolva" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="TC04" Text="Tanque" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="TC05" Text="Plataforma Intermodal" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="TC06" Text="Plataforma Especializada" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="TC07" Text="Plataforma Automotriz" ></asp:ListItem>
                        </asp:DropDownList>
                        </td>
                          <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>MatriculaCarro:</td>
                      <td>   <asp:TextBox ID="txtMatriculaCarro" runat="server" CssClass="form-control2" Width="72px"    MaxLength="15"></asp:TextBox>
                      </td>
                 <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>GuiaCarro:</td>
                      <td>   <asp:TextBox ID="txtGuiaCarro" runat="server" CssClass="form-control2"  Width="72px"  MaxLength="15"></asp:TextBox>
                      </td>
                      <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>ToneladasNetasCarro:</td>
                      <td>   <asp:TextBox ID="txtToneladasNetasCarro" runat="server" CssClass="form-control2"></asp:TextBox>
                       <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender20" runat="server"
    TargetControlID="txtToneladasNetasCarro" FilterType="Custom, Numbers" ValidChars="." Enabled="True" />
                      </td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>       <asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator36" ControlToValidate="txtMatriculaCarro"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="AgregarCarro" style="font-size: medium" /></td>
                           <td></td>
<td> <asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator37" ControlToValidate="txtGuiaCarro"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="AgregarCarro" style="font-size: medium" /></td>
                           <td></td>
                           <td><asp:RegularExpressionValidator id="RegularExpressionValidator21" 
            runat="server" Display="Dynamic" CssClass="alert-danger"
    ControlToValidate="txtToneladasNetasCarro" ErrorMessage="Dato invalido" 
                         ValidationExpression="[0-9]*\.?[0-9]*" 
                         ValidationGroup="AgregarCarro" style="font-size: medium"/><asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator38" ControlToValidate="txtToneladasNetasCarro"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="AgregarCarro" style="font-size: medium" /></td>

</tr>
   <tr>
                <td></td>
                   <td></td>
                   <td></td><td></td>
                   <td></td>
                   <td></td>
                   <td></td>
            <td style="text-align: right;" >   <asp:Button runat="server" ID="btnCarro" Text="Agregar Carro" 
        ValidationGroup="AgregarCarro"  class="btn btn-primary" 
        onclick="btnCarro_Click" Width="133px"/>
        
        </td>
              </tr>
</table>

   <div style="height: 100%; overflow-y: scroll" >
                <asp:GridView runat="server" ID="gvCarro" AutoGenerateColumns="False"  CssClass="style124" Width="100%" 
                HorizontalAlign="Center"   ShowHeaderWhenEmpty="True" OnRowCommand="gvCarro_RowCommand">
                    <Columns>
                      <asp:BoundField HeaderText="Carro" DataField="id" >
                       
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                       
                        <asp:BoundField HeaderText="TipoCarro" DataField="TipoCarro" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="MatriculaCarro" DataField="MatriculaCarro" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                          <asp:BoundField HeaderText="GuiaCarro" DataField="GuiaCarro" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="ToneladasNetasCarro" DataField="ToneladasNetasCarro" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                         <asp:ButtonField Text="Eliminar" CommandName="EliminarCarro" Visible="False" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:ButtonField>
                    </Columns>
                </asp:GridView>
            </div>

         <div style="width:100%;align-items: center;display: flex; justify-content: center;">
                 <div style="border: solid 2px gray; width:90%" >
               &nbsp;&nbsp;&nbsp; <asp:CheckBox runat="server" ID="cbContenedor" Text="Contenedor" 
                    AutoPostBack="True" oncheckedchanged="cbContenedor_CheckedChanged" 
                    style="font-weight: 700; color:Black;"/>
		
       
          <div id="DivContenedor"  style="width:100%;" runat="server" visible="False">
        

                 <h1 style="text-align: center; " class="style156">
                <strong>Contenedor</strong></h1>
                <table>
                <tr>
                 <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>
                           IDCarro:
                        </td>
                 <td>    <asp:DropDownList ID="ddlIDCarro" runat="server" AutoPostBack="True" Width="90px" CssClass="form-control0" >
                        </asp:DropDownList></td>
                  <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>
                           TipoContenedor:
                        </td>
                        <td>
                        <asp:DropDownList runat="server" ID="ddlContenedorTipoContenedor" style="margin-left: 0px" CssClass="form-control2"  Width="180px">
                        <asp:ListItem runat="server" Value="TC01" Text="Contenedor de 6.1 Mts de longitud" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="TC02" Text="Contenedor de 12.2 Mts de longitud" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="TC03" Text="Contenedor de 13.7 Mts de longitud" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="TC04" Text="Contenedor de 14.6 Mts de longitud" ></asp:ListItem>
                        <asp:ListItem runat="server" Value="TC05" Text="Contenedor de 16.1 Mts de longitud" ></asp:ListItem>
                              </asp:DropDownList>
                        </td>
                       <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>PesoContenedorVacio:</td>
                      <td>   <asp:TextBox ID="txtPesoContenedorVacio" runat="server" Width="75px" CssClass="form-control2"></asp:TextBox>
                       <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender21" runat="server"
    TargetControlID="txtPesoContenedorVacio" FilterType="Custom, Numbers" ValidChars="." Enabled="True" />
                      </td>
                      <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>PesoNetoMercancia:</td>
                      <td> <asp:TextBox ID="txtPesoNetoMercancia" runat="server" Width="75px" CssClass="form-control2"></asp:TextBox>
                       <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender22" runat="server"
    TargetControlID="txtPesoNetoMercancia" FilterType="Custom, Numbers" ValidChars="." Enabled="True" /></td>
                      </tr>
                      <tr>
                      <td></td>
                      <td></td>
                      <td></td>
                      <td></td>
                      <td></td>
                      <td>
                      <asp:RegularExpressionValidator id="RegularExpressionValidator22" 
            runat="server" Display="Dynamic" CssClass="alert-danger"
    ControlToValidate="txtPesoContenedorVacio" ErrorMessage="Dato invalido" 
                         ValidationExpression="[0-9]*\.?[0-9]*" 
                         ValidationGroup="AgregarContenedor" style="font-size: medium"/>
                         <asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator39" ControlToValidate="txtPesoContenedorVacio"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="AgregarContenedor" style="font-size: medium" /></td>
                           <td></td>
                           <td><asp:RegularExpressionValidator id="RegularExpressionValidator23" 
            runat="server" Display="Dynamic" CssClass="alert-danger"
    ControlToValidate="txtPesoNetoMercancia" ErrorMessage="Dato invalido" 
                         ValidationExpression="[0-9]*\.?[0-9]*" 
                         ValidationGroup="AgregarContenedor" style="font-size: medium"/><asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator40" ControlToValidate="txtPesoNetoMercancia"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="AgregarContenedor" style="font-size: medium" /></td>
                      </tr>
                      
               <tr>
               <td></td>
               <td></td>
               </tr>   
               <tr>
                <td></td>
                   <td></td>
                   <td></td><td></td>
                   <td></td>
                    <td></td>                
            <td colspan="2" style="text-align: right;"  >   <asp:Button runat="server" ID="btnContenedorTF" Text="Agregar Contenedor" 
        ValidationGroup="AgregarContenedor"  class="btn btn-primary" 
        onclick="btnContenedorTF_Click" Width="133px"/>
        
        </td>
              </tr>
                </table>
                   <div style="height: 100%; overflow-y: scroll" >
                <asp:GridView runat="server" ID="gvContenedor2" AutoGenerateColumns="False"  CssClass="style124" Width="100%" 
                HorizontalAlign="Center"   ShowHeaderWhenEmpty="True" OnRowCommand="gvContenedor2_RowCommand">
                    <Columns>
                      <asp:BoundField HeaderText="Carro" DataField="id" >
                       
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="TipoContenedor" DataField="tipoContenedor" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="PesoContenedorVacio" DataField="pesoContenedorVacio" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                          <asp:BoundField HeaderText="PesoNetoMercancia" DataField="pesoNetoMercancia" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                          <asp:ButtonField Text="Eliminar" CommandName="EliminarCarroContenedor" Visible="False" >
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
     
       <asp:TabPanel ID="TabPanel2" runat="server"  HeaderText="FiguraTransporte" CssClass="page1" >
                <HeaderTemplate>FiguraTransporte</HeaderTemplate>
                <ContentTemplate>
                
                   <asp:UpdatePanel ID="UpdatePanel1" runat="server"  UpdateMode="Conditional"  >
               <ContentTemplate>
              
                  <h1 style="text-align: center; " class="style156">
                <strong>FiguraTransporte</strong></h1>
            <table>
            <tr>
            <td></td>
            <td><asp:CheckBox runat="server" ID="cbFiguraTransporte" Text="FiguraTransporte" Checked="false"
                    AutoPostBack="True" oncheckedchanged="cbcbFiguraTransporte_CheckedChanged" 
                    style="font-weight: 700; color:Black;"/></td>
            </tr>
            <tr>
            <td></td>
               <td style="text-align: right;">
                            CveTransporte:
                        </td>
                        <td> <asp:DropDownList runat="server" ID="ddlCveTransporte"  Enabled="false" 
                                    style="margin-left: 0px"  CssClass="form-control2">                  
   <asp:ListItem runat="server" Value="01" Text="Autotransporte Federal"></asp:ListItem>
   <asp:ListItem runat="server" Value="02" Text="Transporte Marítimo"></asp:ListItem>
      <asp:ListItem runat="server" Value="03" Text="Transporte Aéreo"></asp:ListItem>
   <asp:ListItem runat="server" Value="04" Text="Transporte Ferroviario"></asp:ListItem>
      <asp:ListItem runat="server" Value="05" Text="Ducto"></asp:ListItem>
   </asp:DropDownList>
                        </td>
            </tr>
            </table>


              <div style="border: solid 2px gray">
               &nbsp;&nbsp;&nbsp; <asp:CheckBox runat="server" ID="cbOperador" Text="Operador"  Enabled="false" 
                    AutoPostBack="True" oncheckedchanged="cbOperador_CheckedChanged" 
                    style="font-weight: 700; color:Black;"/>
		
       
                <div id="DivOperador"  style="width:100%" runat="server" visible="False">
                 <h1 style="text-align: center; " class="style156">
                <strong>Operador</strong></h1>
                <table>
                <tr>
                       <td style="text-align: right;">RFCOperador:</td>
                      <td>   <asp:TextBox ID="txtRFCOperador" runat="server" CssClass="form-control2"  MaxLength="13"></asp:TextBox>
                      </td>
                        <td style="text-align: right;">NumLicencia:</td>
                      <td>   <asp:TextBox ID="txtNumLicencia" runat="server" CssClass="form-control2"  MaxLength="16"></asp:TextBox>
                      </td>
                             <td style="text-align: right;">NombreOperador:</td>
                      <td>   <asp:TextBox ID="txtNombreOperador" runat="server" CssClass="form-control2"  MaxLength="254"></asp:TextBox>
                      </td>
                     </tr>
                     <tr>
                             <td style="text-align: right;">NumRegIdTribOperador:</td>
                      <td>   <asp:TextBox ID="txtNumRegIdTribOperador" runat="server" CssClass="form-control2"  MaxLength="40"></asp:TextBox>
                      </td>
                     
                      <td style="text-align: right;">ResidenciaFiscalOperador:</td>
           <td><cc1:DropDownListChosen ID="ddlResidenciaFiscalOperador" runat="server"  CausesValidation="false" 
            NoResultsText="No hay resultados coincidentes."  Width="185px"  Height="16px"   SelectMethod=""          
            DataPlaceHolder="Escriba aquí..." AllowSingleDeselect="true" AutoPostBack="True" AppendDataBoundItems="True" >              
        </cc1:DropDownListChosen></td>
                     </tr>
                </table>

                   <div style="width:100%;align-items: center;display: flex; justify-content: center;">
                 <div style="border: solid 2px gray; width:90%" >
               &nbsp;&nbsp;&nbsp; <asp:CheckBox runat="server" ID="cbDomicilioOperador" Text="Domicilio" 
                    AutoPostBack="True" oncheckedchanged="cbDomicilioOperador_CheckedChanged" 
                    style="font-weight: 700; color:Black;"/>
		       
                <div id="DivcbDomicilioOperador"  style="width:100%;" runat="server" visible="False">
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
                           ValidationGroup="AgregarOperador" style="font-size: medium" /></td>
                      <td></td>
                      <td><asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator42" ControlToValidate="txtEstadoOperador"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="AgregarOperador" style="font-size: medium" /></td>
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
                           ValidationGroup="AgregarOperador" style="font-size: medium" /></td>

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
                           ValidationGroup="AgregarOperador" style="font-size: medium" />
                           </td> </tr>
                </table>
                </div>
                </div>
                </div>

                      <table width="90%" >
          <tr>
            <td style="text-align: right;" ><div style="width=100%; ">  <asp:Button runat="server" ID="btnOperador" Text="Agregar Operador" 
        ValidationGroup="AgregarOperador"  class="btn btn-primary" 
        onclick="btnOperador_Click" Width="133px"/>
        </div>
        </td>
        <td></td>
          </tr>
           </table>


                 <div style="height: 100%; overflow-y: scroll" >
                <asp:GridView runat="server" ID="gvOperador" AutoGenerateColumns="False"  CssClass="style124" Width="100%" 
                HorizontalAlign="Center"   ShowHeaderWhenEmpty="True" OnRowCommand="gvOperador_RowCommand">
                    <Columns>
                      <asp:BoundField HeaderText="Operador" DataField="id" Visible="false">
                       
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                          <asp:BoundField HeaderText="RFCO" DataField="rFCOperador" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="Nombre" DataField="nombreOperador" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="NumRegIdTrib" DataField="numRegIdTribOperador" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                          <asp:BoundField HeaderText="ResidenciaFiscal" DataField="residenciaFiscalOperador" >
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
                          <asp:ButtonField Text="Eliminar" CommandName="EliminarOperador" Visible="False" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:ButtonField>
                    </Columns>
                </asp:GridView>
            </div>


                </div>
                </div>

                 <div style="border: solid 2px gray">
               &nbsp;&nbsp;&nbsp; <asp:CheckBox runat="server" ID="cbPropietario" Text="Propietario"  Enabled="false" 
                    AutoPostBack="True" oncheckedchanged="cbPropietario_CheckedChanged" 
                    style="font-weight: 700; color:Black;"/>
		
       
                <div id="DivPropietario"  style="width:100%" runat="server" visible="False">
                 <h1 style="text-align: center; " class="style156">
                <strong>Propietario</strong></h1>
                <table>
                <tr>
                       <td style="text-align: right;">RFCPropietario:</td>
                      <td>   <asp:TextBox ID="txtRFCPropietario" runat="server" CssClass="form-control2"  MaxLength="13"></asp:TextBox>
                      </td>
                       <td style="text-align: right;">NombrePropietario:</td>
                      <td>   <asp:TextBox ID="txtNombrePropietario" runat="server" CssClass="form-control2"  MaxLength="254"></asp:TextBox>
                      </td>
                     
                             <td style="text-align: right;">NumRegIdTribPropietario:</td>
                      <td>   <asp:TextBox ID="txtNumRegIdTribPropietario" runat="server" CssClass="form-control2"  MaxLength="40"></asp:TextBox>
                      </td>
                     </tr>
                     <tr>
                      <td style="text-align: right;">ResidenciaFiscalPropietario:</td>
           <td><cc1:DropDownListChosen ID="ddlResidenciaFiscalPropietario" runat="server"  CausesValidation="false" 
            NoResultsText="No hay resultados coincidentes."  Width="185px"  Height="16px"   SelectMethod=""          
            DataPlaceHolder="Escriba aquí..." AllowSingleDeselect="true" AutoPostBack="True" AppendDataBoundItems="True" >              
        </cc1:DropDownListChosen></td>
                     </tr>
                </table>

                   <div style="width:100%;align-items: center;display: flex; justify-content: center;">
                 <div style="border: solid 2px gray; width:90%" >
               &nbsp;&nbsp;&nbsp; <asp:CheckBox runat="server" ID="cbDomicilioPropietario" Text="Domicilio" 
                    AutoPostBack="True" oncheckedchanged="cbDomicilioPropietario_CheckedChanged" 
                    style="font-weight: 700; color:Black;"/>
		
       
                <div id="DivdomicilioPropietario"  style="width:100%;" runat="server" visible="False">
        

                 <h1 style="text-align: center; " class="style156">
                <strong>Domicilio</strong></h1>
                <table>
                 <tr>
                 <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>Pais:</td>
           <td><cc1:DropDownListChosen ID="ddlPaisPropietario" runat="server"  CausesValidation="false" 
            NoResultsText="No hay resultados coincidentes."  Width="185px"  Height="16px"   SelectMethod=""          
            DataPlaceHolder="Escriba aquí..." AllowSingleDeselect="true"  onselectedindexchanged="ddlPaisPropietario_SelectedIndexChanged" AutoPostBack="True" AppendDataBoundItems="True" >              
        </cc1:DropDownListChosen></td>
                          <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>Estado:</td>
                      <td>   <asp:TextBox ID="txtEstadoPropietario" runat="server" CssClass="form-control2"  MaxLength="30"></asp:TextBox>
                       <asp:DropDownList ID="dllEstadoPropietario" runat="server" CssClass="form-control2" Width="180px" 
                  style="margin-left: 0px" AutoPostBack="True"  onselectedindexchanged="dllEstadoPropietario_SelectedIndexChanged">
               </asp:DropDownList>
                      </td>
                       
          <td style="text-align: right;">Municipio:</td>
                      <td>   <asp:TextBox ID="txtMunicipioPropietario" runat="server" CssClass="form-control2"  MaxLength="120"></asp:TextBox>
                          <asp:DropDownList ID="ddlMunicipioPropietario" runat="server" CssClass="form-control2" Width="180px" 
                  style="margin-left: 0px" AutoPostBack="True" >
               </asp:DropDownList>
                      </td>
                      </tr>
                      <tr>
                      <td></td>
                      <td>   <asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator58" ControlToValidate="ddlPaisPropietario"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="AgregarPropietario" style="font-size: medium" /></td>
                      <td></td>
                      <td><asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator45" ControlToValidate="txtEstadoPropietario"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="AgregarPropietario" style="font-size: medium" /></td>
                           <td></td>
                           <td>
                        </td>
                          
                      </tr>
                     
                <tr>
                         <td style="text-align: right;">Localidad:</td>
                      <td>   <asp:TextBox ID="txtLocalidadPropietario" runat="server" CssClass="form-control2"  MaxLength="120"></asp:TextBox>
                   <asp:DropDownList ID="dllLocalidadPropietario" runat="server" CssClass="form-control2" Width="180px" 
                  style="margin-left: 0px" AutoPostBack="True" >
               </asp:DropDownList>
                      </td>
                              <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>CodigoPostal:</td>
                      <td>   <asp:TextBox ID="txtCodigoPostalPropietario" runat="server" CssClass="form-control2"  MaxLength="12"></asp:TextBox>
                      </td>
                
                                 <td style="text-align: right;">Referencia:</td>
                      <td>   <asp:TextBox ID="txtReferenciaPropietario" runat="server" CssClass="form-control2"  MaxLength="250"></asp:TextBox>
                      </td>
                      </tr>
                      <tr>
                      <td></td>
                      <td></td>
                      <td></td>
                      <td><asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator46" ControlToValidate="txtCodigoPostalPropietario"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="AgregarPropietario" style="font-size: medium" />
                           </td>

                      </tr>
                      <tr>
                             <td style="text-align: right;">Colonia:</td>
                      <td>   <asp:TextBox ID="txtColoniaPropietario" runat="server" CssClass="form-control2" Width="250px"  MaxLength="120"></asp:TextBox>
                      </td>
                   
                            <td style="text-align: right;">NumeroExterior:</td>
                      <td>   <asp:TextBox ID="txtNumeroExteriorPropietario" runat="server" CssClass="form-control2"  MaxLength="55"></asp:TextBox>
                      </td>
                                 <td style="text-align: right;">NumeroInterior:</td>
                      <td>   <asp:TextBox ID="txtNumeroInteriorPropietario" runat="server" CssClass="form-control2"  MaxLength="55"></asp:TextBox>
                      </td>
                                  
                        </tr>
                      <tr>
                  
                      <td style="text-align: right;"><span class="style160" style="color: #FF0000">*</span>Calle:</td>
                      <td>   <asp:TextBox ID="txtCallePropietario" runat="server" CssClass="form-control2" Width="250px"  MaxLength="100"></asp:TextBox>
                      </td>    
                      </tr>
                      <tr>
                     <td></td>
                     <td><asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator44" ControlToValidate="txtCallePropietario"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="AgregarPropietario" style="font-size: medium" /></td> </tr>
                </table>
                </div>
                </div>
                </div>
                                  
                  <table width="90%" >
          <tr>
            <td style="text-align: right;" ><div style="width=100%; ">  <asp:Button runat="server" ID="btnPropietario" Text="Agregar Propietario" 
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
                          <asp:BoundField HeaderText="RFC" DataField="RFCPropietario" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="Nombre" DataField="NombrePropietario" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="NumRegIdTrib" DataField="NumRegIdTribPropietario" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                          <asp:BoundField HeaderText="ResidenciaFiscal" DataField="ResidenciaFiscalPropietario" >
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
                          <asp:ButtonField Text="Eliminar" CommandName="EliminarPropietario" Visible="False" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:ButtonField>
                    </Columns>
                </asp:GridView>
            </div>



                </div>
                </div>

                   <div style="border: solid 2px gray">
               &nbsp;&nbsp;&nbsp; <asp:CheckBox runat="server" ID="cbArrendatario" Text="Arrendatario"  Enabled="false"  
                    AutoPostBack="True" oncheckedchanged="cbArrendatario_CheckedChanged" 
                    style="font-weight: 700; color:Black;"/>
		
       
                <div id="DivArrendatario"  style="width:100%" runat="server" visible="False">
                 <h1 style="text-align: center; " class="style156">
                <strong>Arrendatario</strong></h1>
                 <table>
                <tr>
                       <td style="text-align: right;">RFCArrendatario:</td>
                      <td>   <asp:TextBox ID="txtRFCArrendatario" runat="server" CssClass="form-control2"  MaxLength="13"></asp:TextBox>
                      </td>
                       <td style="text-align: right;">NombreArrendatario:</td>
                      <td>   <asp:TextBox ID="txtNombreArrendatario" runat="server" CssClass="form-control2"  MaxLength="254"></asp:TextBox>
                      </td>
                     
                             <td style="text-align: right;">NumRegIdTribArrendatario:</td>
                      <td>   <asp:TextBox ID="txtNumRegIdTribArrendatario" runat="server" CssClass="form-control2"  MaxLength="40"></asp:TextBox>
                      </td>
                     </tr>
                     <tr>
                      <td style="text-align: right;">ResidenciaFiscalArrendatario:</td>
           <td><cc1:DropDownListChosen ID="ddlResidenciaFiscalArrendatario" runat="server"  CausesValidation="false" 
            NoResultsText="No hay resultados coincidentes."  Width="185px"  Height="16px"   SelectMethod=""          
            DataPlaceHolder="Escriba aquí..." AllowSingleDeselect="true" AutoPostBack="True" AppendDataBoundItems="True" >              
        </cc1:DropDownListChosen></td>
                     </tr>
                </table>

                                   <div style="width:100%;align-items: center;display: flex; justify-content: center;">
                 <div style="border: solid 2px gray; width:90%" >
               &nbsp;&nbsp;&nbsp; <asp:CheckBox runat="server" ID="cbDomicilioArrendatario" Text="Domicilio" 
                    AutoPostBack="True" oncheckedchanged="cbDomicilioArrendatario_CheckedChanged" 
                    style="font-weight: 700; color:Black;"/>
		
       
                <div id="DivDomicilioArrendatario"  style="width:100%;" runat="server" visible="False">
        

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
                           ValidationGroup="AgregarArrendatario" style="font-size: medium" /></td>
                      <td></td>
                      <td><asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator48" ControlToValidate="txtEstadoArrendatario"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="AgregarArrendatario" style="font-size: medium" /></td>
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
                           ValidationGroup="AgregarArrendatario" style="font-size: medium" /></td>
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
                           ValidationGroup="AgregarArrendatario" style="font-size: medium" /></td> </tr>
                </table>
                </div>
                </div>
                </div>
                   
                  <table width="90%" >
          <tr>
            <td style="text-align: right;" ><div style="width=100%; ">  <asp:Button runat="server" ID="btnArrendatario" Text="Agregar Arrendatario" 
        ValidationGroup="AgregarArrendatario"  class="btn btn-primary" 
        onclick="btnArrendatario_Click" Width="133px"/>
        </td>
        <td></td>
          </tr>
           </table>

                    <div style="height: 100%; overflow-y: scroll" >
                <asp:GridView runat="server" ID="gvArrendatario" AutoGenerateColumns="False"  CssClass="style124" Width="100%" 
                HorizontalAlign="Center"   ShowHeaderWhenEmpty="True" OnRowCommand="gvArrendatario_RowCommand">
                    <Columns>
                      <asp:BoundField HeaderText="Arrendatario" DataField="id" Visible="false">
                       
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                          <asp:BoundField HeaderText="RFC" DataField="rFCArrendatario" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="Nombre" DataField="nombreArrendatario" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="NumRegIdTrib" DataField="numRegIdTribArrendatario" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                          <asp:BoundField HeaderText="ResidenciaFiscal" DataField="residenciaFiscalArrendatario" >
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
                          <asp:ButtonField Text="Eliminar" CommandName="EliminarArrendatario" Visible="False" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:ButtonField>
                    </Columns>
                </asp:GridView>
            </div>

               </div>
                </div>

                  <div style="border: solid 2px gray">
               &nbsp;&nbsp;&nbsp; <asp:CheckBox runat="server" ID="cbNotificado" Text="Notificado"  Enabled="false" 
                    AutoPostBack="True" oncheckedchanged="cbNotificado_CheckedChanged" 
                    style="font-weight: 700; color:Black;"/>
		
       
                <div id="DivNotificado"  style="width:100%" runat="server" visible="False">
                 <h1 style="text-align: center; " class="style156">
                <strong>Notificado</strong></h1>
              <table>
                <tr>
                       <td style="text-align: right;">RFCNotificado:</td>
                      <td>   <asp:TextBox ID="txtRFCNotificado" runat="server" CssClass="form-control2"  MaxLength="13"></asp:TextBox>
                      </td>
                       <td style="text-align: right;">NombreNotificado:</td>
                      <td>   <asp:TextBox ID="txtNombreNotificado" runat="server" CssClass="form-control2"  MaxLength="254"></asp:TextBox>
                      </td>
                     
                             <td style="text-align: right;">NumRegIdTribNotificado:</td>
                      <td>   <asp:TextBox ID="txtNumRegIdTribNotificado" runat="server" CssClass="form-control2"  MaxLength="40"></asp:TextBox>
                      </td>
                     </tr>
                     <tr>
                      <td style="text-align: right;">ResidenciaFiscalNotificado:</td>
           <td><cc1:DropDownListChosen ID="ddlResidenciaFiscalNotificado" runat="server"  CausesValidation="false" 
            NoResultsText="No hay resultados coincidentes."  Width="185px"  Height="16px"   SelectMethod=""          
            DataPlaceHolder="Escriba aquí..." AllowSingleDeselect="true" AutoPostBack="True" AppendDataBoundItems="True" >              
        </cc1:DropDownListChosen></td>
                     </tr>
                </table>
                
                                   <div style="width:100%;align-items: center;display: flex; justify-content: center;">
                 <div style="border: solid 2px gray; width:90%" >
               &nbsp;&nbsp;&nbsp; <asp:CheckBox runat="server" ID="cbDomicilioNotificado" Text="Domicilio" 
                    AutoPostBack="True" oncheckedchanged="cbDomicilioNotificado_CheckedChanged" 
                    style="font-weight: 700; color:Black;"/>
		
       
                <div id="DivDomicilioNotificado"  style="width:100%;" runat="server" visible="False">
        

                 <h1 style="text-align: center; " class="style156">
                <strong>Domicilio</strong></h1>
                <table>
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
                           ValidationGroup="AgregarNotificado" style="font-size: medium" /></td>
                      <td></td>
                      <td><asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator51" ControlToValidate="txtEstadoNotificado"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="AgregarNotificado" style="font-size: medium" /></td>
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
                           ValidationGroup="AgregarNotificado" style="font-size: medium" /></td>

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
                      </tr>
                      <tr>
                     <td></td>
                     <td>
                           <asp:RequiredFieldValidator runat="server"  CssClass="alert-error"
                           ID="RequiredFieldValidator50" ControlToValidate="txtCalleNotificado"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                           ValidationGroup="AgregarNotificado" style="font-size: medium" />
                           </td> </tr>
                </table>
                </div>
                </div>
                </div>

                 
                  <table width="90%" >
          <tr>
            <td style="text-align: right;" ><div style="width=100%; ">  <asp:Button runat="server" ID="Button6" Text="Agregar Notificado" 
        ValidationGroup="AgregarNotificado"  class="btn btn-primary" 
        onclick="btnNotificado_Click" Width="133px"/>
        <td></td>
          </tr>
           </table>

                        <div style="height: 100%; overflow-y: scroll" >
                <asp:GridView runat="server" ID="gvNotificado" AutoGenerateColumns="False"  CssClass="style124" Width="100%" 
                HorizontalAlign="Center"   ShowHeaderWhenEmpty="True" OnRowCommand="gvNotificado_RowCommand">
                    <Columns>
                      <asp:BoundField HeaderText="Notificado" DataField="id"  Visible="false">
                       
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                          <asp:BoundField HeaderText="RFC" DataField="rFCNotificado" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="Nombre" DataField="nombreNotificado" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="NumRegIdTrib" DataField="numRegIdTribNotificado" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                          <asp:BoundField HeaderText="ResidenciaFiscal" DataField="residenciaFiscalNotificado" >
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
                          <asp:ButtonField Text="Eliminar" CommandName="EliminarNotificado" Visible="False" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:ButtonField>
                    </Columns>
                </asp:GridView>
            </div>



                </div>
                </div>


                 </ContentTemplate>
                 </asp:UpdatePanel>
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
