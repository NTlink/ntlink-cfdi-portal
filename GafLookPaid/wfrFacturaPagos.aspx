﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"  CodeBehind="wfrFacturaPagos.aspx.cs" Inherits="GafLookPaid.wfrFacturaPagos" %>
    <%@ Register TagPrefix="cc1" Namespace="WebControls.FilteredDropDownList" Assembly="WebControls.FilteredDropDownList" %>
     <%@ Register Assembly="DropDownChosen" Namespace="CustomDropDown" TagPrefix="cc1" %>


 <%@ MasterType VirtualPath="~/Site.Master" %>
 <%@ Register Src="~/controles/Impuestos.ascx" TagPrefix="uc" TagName="UCImpuestos" %>

<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

   

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


    <link href="Styles/StyleBoton.css"  rel="stylesheet" type="text/css" />
  <style type="text/css">
  GridView:nth-child(even){background-color: #E6E6E6}

        #Background
{
position:fixed;
top:0px;
bottom:0px;
left:0px;
right:0px;
overflow:hidden;
paddin:0;
margin:0;
background-color:transparent;
filter:alpha(opacity=80);
opacity:0.8;
z-index:10000;

}
        #Progress {
            position:fixed;
            top:40%;
            left:40%;
            height:20%;
            width:20%;
            z-index: 100001;
            background-color:transparent;
            border:0px;
            background-image:url("images/ajax-loader.gif");
            background-repeat:no-repeat;
            background-position:center;   
            text-align:center;         
        }

	.mpeBack
	{
		background-color: Gray;
		filter: alpha(opacity=70);
		opacity: 0.7;
	}		
		.auto-style8 {
            width: 117px;
        }
        .auto-style12 {
            width: 124px;
            text-align: left;
        }
        .auto-style149 {
            text-align: left;
            width: 182px;
        }
        .auto-style150 {
            width: 122px;
        }
		.auto-style152 {
            text-align: left;
            width: 144px;
            height: 24px;
        }
		.auto-style153 {
            height: 24px;
        }
		.auto-style154 {
            height: 18px;
        }
		.auto-style155 {
            width: 126px;
        }
		.auto-style156 {
            width: 112px;
        }
        
        .auto-style158 {
            width: 111px;
        }
        .auto-style159 {
            width: 203px;
        }
        .auto-style160 {
            width: 232px;
        }
        .auto-style161 {
            width: 53%;
        }
		.auto-style162 {
            color: #666666;
        }
		</style>  <style type="text/css">
       
        .style1
        {
            width: 38%;
            text-align: left;
        }
        .style3
        {
            width: 291px;
        }
        .style9
        {
            width: 236px;
            text-align: right;
        }
        .style124
    {
        border-left:  1px none #A8CF38;
    border-right:  1px none #A8CF38;
    border-top:  1px none #A8CF38;
    border-bottom:  1px none #A8CF38;
        border-radius: 15px;
        padding: 2px 4px;
        height:40%rem;
        width:50%;
        color: #000101;
        background-color:transparent;
        
     background-color: #DCD9D9;
        text-align: left;
        }
       
    }
        .style125
        {
            width: 145px;
        }
        .style127
        {
            width: 20%;
            text-align: left;
        }
        .style128
        {
            width: 20%;
        }
                      .style130
                      {
                          width: 290px;
                      }
                      .style141
                      {
                          width: 741px;
                      }
                      .style144
                      {
                          width: 236px;
                          text-align: right;
                      }
                      .style146
                      {
                          width: 13%;
                      }
                      .style147
                      {
                          width: 25%;
                      }
                      .style148
                      {
                          width: 267px;
                      }
                      .style149
                      {
                          width: 104px;
                      }
                      .style152
                      {
                          width: 79px;
                          text-align: right;
                      }
                      .style153
                      {
                          width: 35%;
                          text-align: left;
                      }
                      .style154
                      {
                          width: 35%;
                      }
                      .style155
                      {
                          height: 22px;
                      }
                      .style156
                      {
                          color: #2D5C94;
                      }
        </style>
    <h1 class="style156">
        Generar CFDI</h1>
    <tr><td><strong>Empresa:</td></strong>
    <td><asp:DropDownList runat="server" ID="ddlEmpresa" AutoPostBack="True" CssClass="page4"
            DataTextField="RazonSocial" DataValueField="idEmpresa" OnSelectedIndexChanged="ddlEmpresa_SelectedIndexChanged" />
    </td>
    </tr>
       <table>
  <tr>    <td class="style148">
                <strong>Cliente:</strong> &nbsp;<asp:DropDownList runat="server" ID="ddlClientes" AutoPostBack="True"
                    DataTextField="RazonSocial" DataValueField="idCliente" CssClass="page"
                    OnSelectedIndexChanged="ddlClientes_SelectedIndexChanged" Height="16px" 
                    Width="197px" /></td>
            
         <td>    
             <asp:TextBox ID="txtRazonSocial" runat="server"   CssClass="page" 
                    Enabled="true" Height="33px" TextMode="MultiLine" Width="443px" /></td> 
                </tr>
                  </table>
</br>
    <asp:UpdatePanel ID="up1" runat="server"  UpdateMode="Conditional" >
        <ContentTemplate>
            <table class="page2"  width="100%">
               <tr>
                    <td style="text-align: right; font-weight: 700;" class="style141">
                        Serie:
                    </td>
                    <td class="style146">
                        <asp:TextBox runat="server" ID="txtSerie" Width="210px" Height="18px" />
                    </td>
                    <td style="text-align: right" class="style144">
                        <strong>Folio: </strong>
                    </td>
                    <td class="style147">
                        <asp:TextBox runat="server" ID="txtFolio" Width="210px" Height="18px" Enabled="False" />
                    </td>
                     <td style="text-align: right; font-weight: 700;" class="style141">
                        Sucursal
                    </td>
                    <td class="style146">
                        <asp:DropDownList runat="server" ID="ddlSucursales" AppendDataBoundItems="True" DataValueField="LugarExpedicion"
                            DataTextField="Nombre" Width="213px" Height="20px" />
                    </td>
                  </tr>
                <tr>
                   <td style="text-align: right" class="style141">
                        Tipo de Documento:</td>
                    <td class="style146">
                        <asp:DropDownList runat="server" ID="ddlTipoDocumento" AutoPostBack="True" Width="213px" Height="20px"
                            OnSelectedIndexChanged="ddlTipoDocumento_SelectedIndexChanged" Enabled="False">
                            <asp:ListItem runat="server" Text="Pago" Value="P" Selected="True" />
                            
                        </asp:DropDownList>
                    </td>
                    <td style="text-align: right" class="style144">
                        Status Factura:
                    </td>
                    <td class="style147">
                        <asp:DropDownList runat="server" ID="ddlStatusFactura" AutoPostBack="True" OnSelectedIndexChanged="ddlStatusFactura_SelectedIndexChanged" Width="213px" Height="20px">
                            <asp:ListItem Value="0" Text="Pendiente"></asp:ListItem>
                            <asp:ListItem Value="1" Text="Pagada"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td style="text-align: right">
                        <asp:Label runat="server" ID="lblFechaPago" Text="Fecha de Pago:" Visible="False" />
                        </td>
                    <td class="style146">
                        <asp:TextBox runat="server" ID="txtFechaPago" Width="210px" Height="18px" Visible="False" />
                        <asp:CompareValidator runat="server" ID="cvFechaInicial" ControlToValidate="txtFechaPago"
                            Display="Dynamic" ErrorMessage="* Fecha Invalida" Operator="DataTypeCheck" Type="Date" />
                        <asp:CalendarExtender runat="server" ID="ceFechaInicial" Animated="False" PopupButtonID="txtFechaPago"
                            TargetControlID="txtFechaPago" Format="dd/MM/yyyy" />
                    </td>
                 
                </tr>
                
                <tr>
                <td style="text-align: right" class="style141">Confirmacion:</td>
                <td class="style146">
                    <asp:TextBox ID="txtConfirmacion" runat="server" Width="210px" Height="18px" />
                    </td>
                     <td style="text-align: right" class="style144">
                        Moneda:
                    </td>
                    <td class="style147">
                    <asp:DropDownList runat="server" ID="ddlMoneda" AutoPostBack="True" Width="213px" Height="20px"
                           OnSelectedIndexChanged="ddlMoneda_SelectedIndexChanged" Enabled="False">
                            <asp:ListItem runat="server" Text="XXX" Value="XXX" Selected="True" />
                            
                        </asp:DropDownList>
                   <%--     <cc1:DropDownListChosen ID="ddlMoneda" runat="server"  CausesValidation="false" 
            NoResultsText="No hay resultados coincidentes." width="210px"   SelectMethod=""  OnSelectedIndexChanged="ddlMoneda_SelectedIndexChanged"        
            DataPlaceHolder="Escriba aquí..." AllowSingleDeselect="true" AutoPostBack="True" 
                            Height="18px">                
        </cc1:DropDownListChosen>--%>
                    </td>
                    <td style="text-align: right">
                        <asp:Label runat="server" ID="lblTipoCambio" Text="Tipo Cambio:" 
                            Visible="False" />
                    </td>
                    <td class="style146">
                        <asp:TextBox runat="server" ID="txtTipoCambio" Width="210px" Height="18px" Visible="False" />
                    </td>
                  
                </tr>
          
            
                <tr runat="server" id="trDonativo" visible="False">
                    <td class="style141" style="text-align: right" >
                        N. de autorización del Donativo:
                    </td>
                    <td class="style146">    <asp:TextBox runat="server" ID="txtDonatAutorizacion" Width="210px" Height="18px"></asp:TextBox>
                    
                    </td>
                    <td class="style9" >
                        Fecha de autorización del donativo:
                        </td>
                    <td class="style147">
                        <asp:TextBox ID="txtDonatFechautorizacion" runat="server" Width="210px" Height="18px"></asp:TextBox>
                        <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" 
                            PopupButtonID="txtDonatFechautorizacion" 
                            TargetControlID="txtDonatFechautorizacion" />
                    </td>
                </tr>
               
                <tr>
			<td style="text-align: right; vertical-align:top;" class="style141">
				&nbsp;</td>
			
                 <td class="style146">
       
                     &nbsp;</td>
			
			<td class="style144">
                        &nbsp;</td>
                    <td class="style147">
                        &nbsp;</td>
			 <td style="text-align: right">&nbsp;</td>
         <td class="style146">&nbsp;</td>
		</tr>
         
         <tr>
        
         <td class="style141"></td>
         <td class="style146"></td>
         
         </tr>
                <tr>
                    
                    <td style="text-align: right" class="style141">
                        UsoCFDI</td>
                    <td class="style146">
                        <asp:DropDownList ID="ddlUsoCFDI" runat="server" AutoPostBack="True" 
                            Width="213px" Height="20px" Enabled="False" >
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
                       <td style="text-align: right" class="style144" >
                        Observaciones
                    </td>
                    <td class="style147">
                        <asp:TextBox runat="server" ID="txtProyecto" Width="100%" />
                    </td>
                </tr>
            </table>
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

            <asp:Panel ID="Panel5" runat="server"  CssClass="page1" BorderStyle="Double" HorizontalAlign="Left" Width="100%" > 
         		<asp:CheckBox runat="server" ID="cbCfdiRelacionados" Text="CfdiRelacionados" 
                    AutoPostBack="True" oncheckedchanged="cbCfdiRelacionados_CheckedChanged" 
                    style="font-weight: 700"/>
		
       
          <div id="DivCfdiRelacionados"  style="width:100%" runat="server" visible="false">
         <table width="100%">
         
<tr>
<td colspan="3"  style="text-align: left; font-weight: 700;" >

<asp:Label ID="Label6" runat="server" Text="CfdiRelacionado" Font-Bold="True"  style="font-size: medium"></asp:Label>
   </td>
</tr>
<tr>
         <td class="text-right">UUID:</td>
         <td>
             <asp:TextBox ID="txtUUDI" runat="server" />
         </td>
         <td class="text-right">TipoRelacion:</td>
         <td>       <asp:DropDownList runat="server" ID="ddlTipoRelacion" AutoPostBack="True" >
                      <asp:ListItem runat="server" Value="01" Text="Nota de crédito de los documentos relacionados" />
 <asp:ListItem runat="server" Value="02" Text="Nota de débito de los documentos relacionados" />
 <asp:ListItem runat="server" Value="03" Text="Devolución de mercancía sobre facturas o traslados previos" />
 <asp:ListItem runat="server" Value="04" Text="Sustitución de los CFDI previos" />
 <asp:ListItem runat="server" Value="05" Text="Traslados de mercancias facturados previamente" />
 <asp:ListItem runat="server" Value="06" Text="Factura generada por los traslados previos" />
 <asp:ListItem runat="server" Value="07" Text="CFDI por aplicación de anticipo" />
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
                <asp:Panel Visible="false" ID="Panel2" runat="server" CssClass="page1" BorderStyle="Double" HorizontalAlign="Center" Width="100%" > 
     
            <h1 style="text-align: center">
                Conceptos</h1>
            <table width="100%">
                         <tr>
                    <td style="text-align: right;">
                        ClaveUnidad</td>
                    <td style="text-align: left;">
                    <div>    
    
     <cc1:DropDownListChosen ID="ddlClaveUnidad" runat="server"  CausesValidation="false" 
            NoResultsText="No hay resultados coincidentes." width="206px"   SelectMethod=""          
            DataPlaceHolder="Escriba aquí..." AllowSingleDeselect="true" Height="16px">                
        </cc1:DropDownListChosen>  
        

        </div>
                        &nbsp;</td>
                    <td style="text-align: right;" class="style146">
                        &nbsp; NoIdentificacion</td>
                    <td style="text-align: left" class="style149">
                        <asp:TextBox ID="txtNoIdentificacion" runat="server" />
                             </td>
                </tr>
   <tr>
                <td style="text-align: right">Código </td>
                <td style="text-align: left">
                    <asp:TextBox ID="txtCodigo" runat="server" />
                    
                    </td>
                    <td><asp:Button ID="btnBuscarProducto" runat="server" class="btn btn-primary" 
                                OnClick="btnBuscarProducto_Click" Text="ClaveProdServ" Width="100px" /></td>
                                 <td>
                                     <input type="button" value="BuscadorSAT" onclick="javascript:window.open('http://200.57.3.46:443/PyS/catPyS.aspx','','width=600,height=400,left=50,top=50,toolbar=yes');" class="btn btn-primary" />
                                 </td>
                </tr>
                <tr>
                <td></td>
                <td><asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator6" ControlToValidate="txtCodigo"
                            Display="Dynamic" ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" /></td>
                            </tr>
                <tr>
                    <td style="text-align: right;" width="15%">
                        Cantidad
                    </td>
                    <td class="style1">
                        <asp:TextBox runat="server" ID="txtCantidad" />
                      
                       
                    </td>
                    <td>
                        Unidad
                    </td>
                    <td style="text-align: left" class="style149">
                        <asp:TextBox runat="server" ID="txtUnidad" />&nbsp;
                        
                    </td>
                       <td>
                        Descuento</td>
                    <td class="style153">
                        <asp:TextBox ID="txtDescuento" runat="server" Width="106px" />
                    </td>
                      <td style="text-align: right">
                        Precio Unitario: $
                    </td>
                    <td style="text-align: left">
                        <asp:TextBox runat="server" ID="txtPrecio" />
                        
                    </td>
                </tr>
                <tr>
                 <td></td>
                 <td> <asp:RequiredFieldValidator runat="server" ID="rfvCantidad" ControlToValidate="txtCantidad"
                            Display="Dynamic" ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" />  <asp:RegularExpressionValidator id="RegularExpressionValidator2" runat="server" Display="Dynamic"
    ControlToValidate="txtCantidad" ErrorMessage="Dato invalido" ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" ValidationGroup="AgregarConcepto"/></td>
                 <td class="style146"></td>
                 <td class="style149"><asp:RequiredFieldValidator runat="server" ID="rfvUnidad" ControlToValidate="txtUnidad"
                            Display="Dynamic" ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" /></td>
                 <td></td>
                 <td class="style154"></td>
                 <td class="style152"></td>
                 <td><asp:RequiredFieldValidator runat="server" ID="rfvPrecio" ControlToValidate="txtPrecio"
                            Display="Dynamic" ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" />&nbsp;
                        <asp:CompareValidator runat="server" ID="cvPrecio" ControlToValidate="txtPrecio"
                            Display="Dynamic" ErrorMessage="* Precio invalido" Type="Double" Operator="DataTypeCheck"
                            ValidationGroup="AgregarConcepto" /></td>
                  
                </tr>
                
                <tr>
                    <td style="text-align: right;" width="15%">
                        Descripción
                    </td>
                    <td colspan="3" style="text-align: left">
                        <asp:TextBox runat="server" ID="txtDescripcion" Width="80%" 
                            TextMode="MultiLine" />
                      
                    </td>
                     <td style="text-align: right;" width="15%">
                        Observaciones
                    </td>
                    <td class="style153">
                        <asp:TextBox runat="server" ID="txtDetalles" Width="193%" 
                            TextMode="MultiLine" Enabled="False" Visible="False" />
                    </td>
                </tr>
                <tr>
                   <td></td>
                   <td>  <asp:RequiredFieldValidator runat="server" ID="rfvDescripcion" ControlToValidate="txtDescripcion"
                            Display="Dynamic" ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" />
                            </td>
                            <td></td>
                            <td></td>
                            <td></td>
                    <td class="style154">
                        
                            <asp:Button runat="server" ID="btnAgregar" Text="Agregar Concepto" 
                                OnClick="btnAgregar_Click" class="btn btn-primary"
                    ValidationGroup="AgregarConcepto" Width="156px" />
                  
                      
                    </td> 
                  <td><asp:Button ID="btnBuscarHistorico" runat="server" class="btn btn-primary" 
                                OnClick="btnBuscarHistorico_Click" Text="Buscar" Width="100px" /></td>
                                <td>  <asp:HiddenField ID="txtIdProducto" runat="server"  /></td>
                </tr>
            </table><br />
            <div style="height: 100%; overflow-y: scroll" >
                <asp:GridView runat="server" ID="gvDetalles" AutoGenerateColumns="False"  CssClass="style124" Width="100%" HorizontalAlign="Center"
                    ShowHeaderWhenEmpty="True" OnRowCommand="gvDetalles_RowCommand">
                    <Columns>
                        <asp:BoundField HeaderText="ClaveProdServ" DataField="Codigo" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField HeaderText="NoIdentificacion" DataField="ConceptoNoIdentificacion" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField HeaderText="Cantidad" DataField="Cantidad" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField HeaderText="ClaveUnidad" DataField="ConceptoClaveUnidad" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField HeaderText="Unidad" DataField="Unidad" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField HeaderText="ValorUnitario" DataField="Precio" ItemStyle-HorizontalAlign="Center"  DataFormatString="{0:C}"/>
                        <asp:BoundField HeaderText="Descripción" DataField="Descripcion" />
                        <asp:BoundField HeaderText="Importe" DataField="Total" DataFormatString="{0:C}" />
                       <asp:BoundField HeaderText="Descuento" DataField="ConceptoDescuento" DataFormatString="{0:C}"
                            ItemStyle-HorizontalAlign="Right" />
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
                          
        <asp:Panel ID="Panel1" runat="server"  CssClass="page1" BorderStyle="Double" HorizontalAlign="Left" Width="100%" > 
         		<asp:CheckBox runat="server" ID="cbImpuestos" Text="Impuestos"  Visible="false"
                    AutoPostBack="True" oncheckedchanged="cbImpuestos_CheckedChanged" 
                    style="font-weight: 700"/>
		
       
          <div id="DivComplementos"  style="width:100%" runat="server" visible="false">
         <table width="100%">
<tr>
<td colspan="3"  style="text-align: left; font-weight: 700;" >

<asp:Label ID="Label2" runat="server" Text="Impuestos" Font-Bold="True"  style="font-size: medium"></asp:Label>
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
    <td>
        <asp:Label ID="Label11" runat="server" ForeColor="Red" Text="*"></asp:Label>
        Base:</td>
    <td>
        <asp:TextBox ID="txtBase" runat="server" Enabled="False" Width="100px"></asp:TextBox>
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
<td style="text-align: right" class="style128"> 
    <asp:Label ID="Label10" runat="server" ForeColor="Red" Text="*"></asp:Label>
    ClaveConcepto:</td>

<td class="style125">
        <asp:DropDownList ID="ddlConceptos" runat="server" AutoPostBack="True" 
            onselectedindexchanged="ddlConceptos_SelectedIndexChanged">
            
      
    </asp:DropDownList>
        </td>
<td style="text-align: right"> 
    <asp:Label ID="Label4" runat="server" ForeColor="Red" Text="*"></asp:Label>
    TipoFactor:</td>
<td>
    <asp:DropDownList ID="ddlTipoFactor" runat="server" AutoPostBack="True" 
        onselectedindexchanged="ddlTipoFactor_SelectedIndexChanged">
        <asp:ListItem Value="Tasa">Tasa</asp:ListItem>
        <asp:ListItem Value="Cuota">Cuota</asp:ListItem>
        <asp:ListItem Value="Exento">Exento</asp:ListItem>
    </asp:DropDownList>

    </td>
</tr>

<tr>
<td class="style127" style="text-align: right"> 
    <asp:Label ID="Label3" runat="server" ForeColor="Red" Text="*"></asp:Label>
    Impuesto:
    </td><td class="style125">
        <asp:DropDownList ID="ddlImpuesto" runat="server" AutoPostBack="True" onselectedindexchanged="ddlImpuesto_SelectedIndexChanged"
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
<td colspan="4" style="text-align: right">
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
              	<asp:BoundField HeaderText="TipoImpuesto" DataField="TipoImpuesto"  ItemStyle-HorizontalAlign="Center" />
                <asp:BoundField HeaderText="Impuesto" DataField="Impuesto" ItemStyle-HorizontalAlign="Center"  ItemStyle-Width="10%" />
				<asp:BoundField HeaderText="Base" DataField="Base" ItemStyle-HorizontalAlign="Center" />
				<asp:BoundField HeaderText="TasaOCuota" DataField="TasaOCuota"  ItemStyle-HorizontalAlign="Center" />
                <asp:BoundField HeaderText="Importe" DataField="Importe" DataFormatString="{0:C}" ItemStyle-HorizontalAlign="Center" />
               	<asp:BoundField HeaderText="TipoFactor" DataField="TipoFactor"  ItemStyle-HorizontalAlign="Center" />
                		
				<asp:ButtonField Text="Eliminar" CommandName="EliminarImpuesto" Visible="False" ItemStyle-HorizontalAlign="Center" />
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
        <asp:Panel ID="Panel3" runat="server"  CssClass="page1" BorderStyle="Double" HorizontalAlign="Left" Width="100%" > 
		
       
          <div id="DivComplementoPagos"  style="width:100%" runat="server" >
         <table width="100%">
<tr>
<td colspan="3"  style="text-align: left; font-weight: 700;" class="style155" >

<asp:Label ID="Label1" runat="server" Text="Pagos" Font-Bold="True"  style="font-size: medium"></asp:Label>
   </td>
</tr>
<tr>
<td style="text-align: right">
    <asp:Label ID="Label15" runat="server" ForeColor="Red" Text="*"></asp:Label>
    FechaPago:</td>
<td>  <asp:TextBox ID="txtFechaPagoP" runat="server" Width="210px" Height="18px"></asp:TextBox>
                        <asp:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" 
                            PopupButtonID="txtFechaPagoP" 
                            TargetControlID="txtFechaPagoP" />
                   </td>
<td class="text-right">
    <asp:Label ID="Label16" runat="server" ForeColor="Red" Text="*"></asp:Label>
    FormaDePagoP:</td>
<td>

<asp:DropDownList runat="server" ID="ddlFormaPagoP" AutoPostBack="True" 
                         OnSelectedIndexChanged="ddlFormaPagoP_SelectedIndexChanged" 
                         style="margin-left: 0px" Width="210px">
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
<asp:ListItem runat="server" Value="99" Text="Por definir"></asp:ListItem>
 </asp:DropDownList></td>

</tr>
<tr>
<td class="text-right">
    <asp:Label ID="Label17" runat="server" ForeColor="Red" Text="*"></asp:Label>
    MonedaP:</td>
<td>
 <cc1:DropDownListChosen ID="ddlMonedaP" runat="server"  CausesValidation="false" 
            NoResultsText="No hay resultados coincidentes." width="210px"   SelectMethod=""  OnSelectedIndexChanged="ddlMonedaP_SelectedIndexChanged"        
            DataPlaceHolder="Escriba aquí..." AllowSingleDeselect="true" AutoPostBack="True" 
                            Height="18px">                
        </cc1:DropDownListChosen></td>
<td class="text-right"><asp:Label runat="server" ID="lblTipoCambioP" Text="Tipo Cambio:" 
                            Visible="False" /></td>
<td>        <asp:TextBox runat="server" ID="txtTipoCambioP" Width="86px" Visible="False" />
                </td>

</tr>
<tr>
<td class="text-right">
    <asp:Label ID="Label18" runat="server" ForeColor="Red" Text="*"></asp:Label>
    Monto:</td>
<td>
    <asp:TextBox ID="txtMonto" runat="server"  Width="210px" Height="18px"></asp:TextBox>
    </td>
<td class="text-right">NumOperacion:</td>
<td>
    <asp:TextBox ID="txtNumOperacion" runat="server"  Width="210px" Height="18px"></asp:TextBox>
    </td>

</tr>
<tr>
<td class="text-right">
    RfcEmisorCtaOrd:</td>
<td>
    <asp:TextBox ID="txtRfcEmisorCtaOrd" runat="server"  Width="210px" Height="18px"></asp:TextBox>
    </td>
<td class="text-right">NomBancoOrdExt:</td>
<td>
    <asp:TextBox ID="txtNomBancoOrdExt" runat="server"  Width="210px" Height="18px"></asp:TextBox>
    </td>

</tr>
<tr>
<td class="text-right">
    CtaOrdenante:</td>
<td>
    <asp:TextBox ID="txtCtaOrdenante" runat="server"  Width="210px" Height="18px"></asp:TextBox>
    </td>
<td class="text-right">RfcEmisorCtaBen:</td>
<td>
    <asp:TextBox ID="txtRfcEmisorCtaBen" runat="server"  Width="210px" Height="18px" 
        ></asp:TextBox>
    </td>

</tr><tr>
<td class="text-right">
    CtaBeneficiario:</td>
<td>
    <asp:TextBox ID="txtCtaBeneficiario" runat="server"  Width="210px" Height="18px"></asp:TextBox>
    </td>
<td class="text-right">TipoCadPago:</td>
<td>
    <asp:TextBox ID="txtTipoCadPago" runat="server"  Width="210px" Height="18px" 
        ></asp:TextBox>
    </td>

</tr>
<tr>
<td class="text-right">CertPago:</td>
<td><asp:TextBox ID="txtCertPago" runat="server"  Width="210px" Height="18px"></asp:TextBox></td>
<td class="text-right">CadPago:</td>
<td><asp:TextBox ID="txtCadPago" runat="server"  Width="210px" Height="18px"></asp:TextBox></td>
</tr>
<tr>
<td class="text-right">SelloPago:</td>
<td><asp:TextBox ID="txtSelloPago" runat="server"  Width="210px" Height="18px"></asp:TextBox></td>
</tr>
<tr>
<td colspan="4" style="text-align: right">
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
             
        <asp:Panel ID="Panel4" runat="server"  CssClass="page1" BorderStyle="Double" HorizontalAlign="Left" Width="100%" > 
         		<asp:CheckBox runat="server" ID="cbDoctoRelacionado" Text="DoctoRelacionado" 
                    AutoPostBack="True" oncheckedchanged="cbDoctoRelacionado_CheckedChanged" 
                    style="font-weight: 700"/>
		
       
          <div id="DivDoctoRelacionado"  style="width:100%" runat="server" visible="false">
         <table width="100%">
<tr>
<td colspan="3"  style="text-align: left; font-weight: 700;" >

<asp:Label ID="Label5" runat="server" Text="DoctoRelacionado" Font-Bold="True"  style="font-size: medium"></asp:Label>
   </td>
</tr>
<tr>
<td class="text-right">
    <asp:Label ID="Label21" runat="server" ForeColor="Red" Text="*"></asp:Label>
    ID</td>
<td>
    <asp:DropDownList ID="ddlID" runat="server" AutoPostBack="True" 
        onselectedindexchanged="ddlID_SelectedIndexChanged">
    </asp:DropDownList>
    </td>
</tr>
<tr>
<td class="text-right">
    <asp:Label ID="Label20" runat="server" ForeColor="Red" Text="*"></asp:Label>
    IdDocumento:</td>
<td>
    <asp:TextBox ID="txtIdDocumento" runat="server" Width="210px" Height="18px"></asp:TextBox>
    </td>
<td class="text-right">Serie:</td>
<td>
    <asp:TextBox ID="txtSerieD" runat="server" Width="210px" Height="18px"></asp:TextBox>
    </td>
</tr>
<tr>
<td class="text-right">
     Folio:</td>
<td>
    <asp:TextBox ID="txtFolioD" runat="server" Width="210px" Height="18px"></asp:TextBox>
    </td>
<td class="text-right">MetodoDePagoDR:</td>
<td><asp:DropDownList runat="server" ID="ddlMetodoDePagoDR" AutoPostBack="True" OnSelectedIndexChanged="ddlMetodoDePagoDR_SelectedIndexChanged">
                           <asp:ListItem runat="server" Text="Pago en una sola exhibición" Value="PUE"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Pago en parcialidades o diferido" Value="PPD"></asp:ListItem>
                        </asp:DropDownList>
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
<td class="text-right">
    <asp:Label ID="lblTipoCambioDR" runat="server" Text="Tipo Cambio:" 
        Visible="False" />
    </td>
<td>
    <asp:TextBox ID="txtTipoCambioDR" runat="server" Visible="False" Width="86px" />
    </td>
</tr>
<tr>
<td class="text-right">NumParcialidad:</td>
<td>
    <asp:TextBox ID="txtNumParcialidad" runat="server" Width="100px"></asp:TextBox>
    </td>
<td class="text-right">ImpSaldoAnt:</td>
<td>
    <asp:TextBox ID="txtImpSaldoAnt" runat="server" Width="100px"></asp:TextBox>
    </td>
</tr>
<tr>
<td class="text-right">ImpPagado:</td>
<td>
    <asp:TextBox ID="txtImpPagado" runat="server" Width="100px"></asp:TextBox>
    </td>
<td class="text-right">ImpSaldoInsoluto:</td>
<td>
    <asp:TextBox ID="txtImpSaldoInsoluto" runat="server" Width="100px"></asp:TextBox>
    </td>
</tr>

<tr>
<td colspan="4" style="text-align: right">
<asp:Button runat="server" ID="AgregarDocumento" Text="Agregar Documento" 
        ValidationGroup="AgregarDocumento"  class="btn btn-primary" 
        onclick="btnAgregarDocumento_Click"/>
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
                		
				<asp:ButtonField Text="Eliminar" CommandName="EliminarDocumento" Visible="False" ItemStyle-HorizontalAlign="Center" />
			</Columns>
		</asp:GridView></td>
</tr>
</table>
    
        
      </div>
      </asp:Panel>
    
        </td></tr>
        </table>
		</div>
       
   

            <br />
            <asp:UpdateProgress AssociatedUpdatePanelID="up1" ID="UpdateProgress1"  runat="server">
			<ProgressTemplate>
			<div id="Background" ></div>
                <div id="Progress">
				    <br/><br/><br/><br/>
				    <br/>
				    <br>
				</br/>  CFDI en proceso ..
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
                    OnClick="btnLimpiar_Click" class="btn btn-primary" Width="70px"/>&nbsp;&nbsp;&nbsp;
                <asp:Button runat="server" ID="BtnVistaPrevia" Text="Vista Previa" OnClick="btnGenerarPreview_Click" class="btn btn-primary"
                    ValidationGroup="CrearFactura" />&nbsp;&nbsp;&nbsp;
                <asp:Button runat="server" ID="btnGenerarFactura" Text="Generar Factura" OnClick="btnGenerarFactura_Click" class="btn btn-primary"
                    ValidationGroup="CrearFactura" />
                <asp:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" TargetControlID="btnGenerarFactura"
                    ConfirmText="Confirma que deseas generar el comprobante" />
            </p>
       

    <asp:ModalPopupExtender runat="server" ID="mpeBuscarConceptos" TargetControlID="btnConceptoDummy"
        BackgroundCssClass="mpeBack" CancelControlID="btnCerrarConcepto" PopupControlID="pnlBuscarConceptos" />
    <asp:Panel runat="server" ID="pnlBuscarConceptos" Style="text-align: center;" Width="800px" CssClass="page3"
        BackColor="White">
        <h1>
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
            <asp:Label runat="server"  ID="lblConcepto">Editar Concepto</asp:Label></h1>
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
		<h1>Buscar Conceptos Historico</h1>
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

     </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnLimpiar" />
            <asp:PostBackTrigger ControlID="gvDetalles" />
            <asp:PostBackTrigger ControlID="BtnVistaPrevia" />
        </Triggers>
    </asp:UpdatePanel>
    
</asp:Content>
