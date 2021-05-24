﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="wfrFacturaAduanal32.aspx.cs" Inherits="GafLookPaid.wfrFacturaAduanal32" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<%@ MasterType VirtualPath="~/Site.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    <link href="Styles/StyleBoton.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
	.mpeBack
	{
		background-color: Gray;
		filter: alpha(opacity=70);
		opacity: 0.7;
	}
	.style1
	{
		width: 38%;
	}
        .style2
        {
            text-align: right;
        }
        .style3
        {
            color: #000099;
        }
        .style6
        {
            width: 16%;
        }
        .style8
        {
            width: 201px;
        }
        .style124
    {
        border-left:  1px none #A8CF38;
    border-right:  1px none #A8CF38;
    border-top:  1px none #A8CF38;
    border-bottom:  1px none #b3b3b3;
        border-radius: 15px;
        padding: 2px 4px;
        height:40%rem;
        width:50%;
        color: #000101;
        background-color:transparent;
        
     background-color: #DCD9D9;
        text-align: left;
        }
       
    
        .style125
        {
            width: 12%;
        }
        .style127
        {
            width: 613px;
        }
        .style128
        {
            width: 8%;
        }
    </style>
	
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

	<h1>Generar CFDI Aduanal</h1>
	<asp:UpdatePanel ID="up1" runat="server" UpdateMode="Conditional">
		<ContentTemplate>
	<p>
		Empresa:&nbsp;<asp:DropDownList runat="server" ID="ddlEmpresa" AutoPostBack="True"
		 DataTextField="RazonSocial" DataValueField="idEmpresa" onselectedindexchanged="ddlEmpresa_SelectedIndexChanged" />
	</p>
	<table width="90%">
                <tr>
                    <td style="text-align:right">
                        Status Factura:
                    </td>
                    <td>
                        <asp:DropDownList runat="server" ID="ddlStatusFactura" AutoPostBack="True" OnSelectedIndexChanged="ddlStatusFactura_SelectedIndexChanged">
                            <asp:ListItem Value="0" Text="Pendiente"></asp:ListItem>
                            <asp:ListItem Value="1" Text="Pagada"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td style="text-align:left">
                        <asp:Label runat="server" ID="lblFechaPago" Text="Fecha de Pago:" 
                            Visible="False" style="text-align: right" />
                        </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtFechaPago" Width="75px" Visible="False" />
                        <asp:CompareValidator runat="server" ID="cvFechaInicial" ControlToValidate="txtFechaPago"
                            Display="Dynamic" ErrorMessage="* Fecha Invalida" Operator="DataTypeCheck" Type="Date" />
                        <asp:CalendarExtender runat="server" ID="ceFechaInicial" Animated="False" PopupButtonID="txtFechaPago"
                            TargetControlID="txtFechaPago" Format="dd/MM/yyyy" />
                    </td>
                    <td style="text-align:right">
                        Tipo de Documento:</td>
                    <td>
                        <asp:DropDownList runat="server" ID="ddlTipoDocumento" AutoPostBack="True" >
                            <asp:ListItem runat="server" Text="Factura" Value="Ingreso" Selected="True" />
                            <asp:ListItem runat="server" Text="Nota de Crédito" Value="Egreso" />
                            
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:right">
                        Serie:
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtSerie" Width="75px" MaxLength="25"/>
                    </td>
                    <td style="text-align:right">
                        Folio:
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtFolio" Width="50px" Enabled="False" />
                    </td>
                    <td style="text-align:right">
                        Moneda:
                    </td>
                    <td>
                        <asp:DropDownList runat="server" ID="ddlMoneda" OnSelectedIndexChanged="ddlMoneda_SelectedIndexChanged">
                            <asp:ListItem Value="1" Text="MXN" />
                            <asp:ListItem Value="2" Text="USD" />
                            <asp:ListItem Value="3" Text="EUR" />
                            <asp:ListItem Value="4" Text="JPY" />
                        </asp:DropDownList>
                    </td>
                    <td style="text-align:left">
                        <asp:Label runat="server" ID="lblTipoCambio" Text="Tipo Cambio USD:" Visible="False" />
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtTipoCambio" Visible="False" Width="50px" />
                    </td>
                  <td>
                       <%-- Días Revisión--%>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtDiasRevision" Width="50px"  Visible="false" 
                           />
                        <asp:CompareValidator runat="server" ID="cvTxtDiasRevision" ControlToValidate="txtDiasRevision"
                            Display="Dynamic" ErrorMessage="* Dato invalido" Type="Integer" Operator="DataTypeCheck" />
                    </td>
                </tr>
            </table><br />
	 <p>
                Cliente:&nbsp;<asp:DropDownList runat="server" ID="ddlClientes" AutoPostBack="True"
                    DataTextField="RazonSocial" DataValueField="idCliente" 
                    OnSelectedIndexChanged="ddlClientes_SelectedIndexChanged" Height="16px" 
                    Width="197px" />
               &nbsp;&nbsp;
                <asp:TextBox ID="txtRazonSocial" runat="server"  CssClass="page1" 
                    Enabled="true" Height="44px" TextMode="MultiLine" Width="429px" />
                  </p><br />
	<table width="95%">
		<tr>
			<td colspan="4" style="text-align: center;">
				<h1> Datos de la Factura</h1>
			</td>
		</tr>
        <tr> 
        <td class="style6"></td>
        <td class="style3">&nbsp;</td>
        <td class="style8"></td>
        <td></td>
        
         </tr>
		<tr >
			<td style="text-align: right; vertical-align:top;" class="style25">
				Método de Pago
			</td>
			
                 <td colspan="2">
       
              <asp:CheckBox ID="Check01" runat="server" Text="01-Efectivo"
                  AutoPostBack="True" oncheckedchanged="Check01_CheckedChanged" 
                    /><br />
        
              <asp:CheckBox ID="Check02" runat="server" Text="02-Cheque nominativo" 
                  AutoPostBack="True" oncheckedchanged="Check02_CheckedChanged" 
                   /> <br />
        
              <asp:CheckBox ID="Check03" runat="server"  AutoPostBack="True"
                  Text="03-Transferencia electrónica de fondos" 
                  oncheckedchanged="Check03_CheckedChanged1"  
                  /><br />
        
              <asp:CheckBox ID="Check04" runat="server" Text="04-Tarjeta de Crédito"  AutoPostBack="True"
                  oncheckedchanged="Check04_CheckedChanged"  /><br />
        
              <asp:CheckBox ID="Check05" runat="server" Text="05-Monedero Electrónico"  AutoPostBack="True"
                  oncheckedchanged="Check05_CheckedChanged" /><br />
        
              <asp:CheckBox ID="Check06" runat="server" Text="06-Dinero Electrónico"  AutoPostBack="True"
                  oncheckedchanged="Check06_CheckedChanged"  /><br />
        
              <asp:CheckBox ID="Check08" runat="server" Text="08-Vales de despensa" AutoPostBack="True"
                  oncheckedchanged="Check08_CheckedChanged"  /><br />
        
              <asp:CheckBox ID="Check28" runat="server" Text="28-Tarjeta de Débito" AutoPostBack="True"
                  oncheckedchanged="Check28_CheckedChanged"  /><br />
        
              <asp:CheckBox ID="Check29" runat="server" Text="29-Tarjeta de Servicio" AutoPostBack="True"
                  oncheckedchanged="Check29_CheckedChanged"  /><br />
        
              <asp:CheckBox ID="CheckNA" runat="server" Text="NA" AutoPostBack="True"
                  oncheckedchanged="CheckNA_CheckedChanged"  />&nbsp;<asp:Label ID="Label1" runat="server"
                      Text="Label">(Solo aplica para este caso:“Regla RMF 2.7.1.32.”) </asp:Label><br />
        
              <asp:CheckBox ID="Check99" runat="server" Text="99-Otros" AutoPostBack="True"
                  oncheckedchanged="Check99_CheckedChanged"  />

             
       
			</td>
			
			<td colspan="2" style=" vertical-align:top;" >
				 <asp:TextBox ID="txtMetodoPagoMul" runat="server" Enabled="False" CssClass="page2"
                    TextMode="MultiLine" Width="100%" Height="72px" /><br />
                 <br />
                Numero de Cuenta (Últimos 4 dígitos) 
                <asp:TextBox runat="server" ID="txtCuenta"  Width="60%" />
                <br />
			   (En caso de ser multiple separar por comas)
			</td>
			</td>
		</tr>
         
        <tr>
          
         <td colspan="2" style=" vertical-align:top">
             <asp:TextBox ID="txtMetodoPagoMulID" runat="server" Width="329px" 
                 Visible="False"></asp:TextBox>
             </td>
         
        
         </tr>
          <tr>
         <td style="text-align: right">Condiciones de Pago</td>
         <td><asp:TextBox ID="txtCondicionesPago" runat="server"></asp:TextBox></td>
         <td></td>
         <td></td>
         
         </tr>
		</tr>
		<tr>
    <td style="text-align:right" class="style6">
				&nbsp;&nbsp;&nbsp; Sucursales
			</td>
	<td>
		<asp:DropDownList runat="server" ID="ddlSucursales" AppendDataBoundItems="True" 
            DataTextField="Nombre" DataValueField="LugarExpedicion">
		</asp:DropDownList>
	</td>
    <td style="text-align:right" class="style8">
		Observaciones</td>
			<td >
				<asp:TextBox runat="server" ID="txtProyecto" Width="100%" />
			</td>
            <tr>
                <td class="style6" style="text-align:right">
                    Forma de Pago
                </td>
                <td width="25%">
                    <asp:DropDownList ID="ddlCondicionesPago" runat="server" AutoPostBack="True" 
                        onselectedindexchanged="ddlCondicionesPago_SelectedIndexChanged">
                        <asp:ListItem runat="server" Text="Pago en una sola exhibición" 
                            Value="Pago en una sola exhibición"></asp:ListItem>
                        <asp:ListItem runat="server" Text="En parcialidades" Value="En parcialidades"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="style8" style="text-align:right">
                    &nbsp;&nbsp;&nbsp; Anticipo:
                </td>
                <td>
                    <asp:TextBox ID="txtAnticipo" runat="server" />
                    <asp:CompareValidator ID="cvAnticipo" runat="server" 
                        ControlToValidate="txtAnticipo" Display="Dynamic" 
                        ErrorMessage="* Monto inválido" Operator="DataTypeCheck" Type="Currency" 
                        ValidationGroup="CrearFactura" />
                    <asp:Button ID="btnActualizar" runat="server" class="btn btn-primary" 
                        onclick="btnActualizar_Click" Text="Calcular Totales" />
                </td>
            </tr>
</tr>
 
		
	</table>
    <div runat="server" ID="divParcialidades" Visible="False">
        <h1 style="text-align: center">Parcialidades</h1>
        <table table width="95%">
        <tr >
	<td style="text-align: right;">
		Folio Fiscal Original
	</td>
	<td >
		<asp:TextBox runat="server" ID="txtFolioOriginal"  />			
	</td>
	<td style="text-align: right;" class="style3">
		Fecha del Folio Fiscal Original:
	</td>
	<td >
		<asp:TextBox ID="txtFechaOriginal" runat="server"  Width="100%" />
		<asp:CalendarExtender runat="server" ID="ceFechaOriginal" PopupButtonID="txtFechaOriginal" TargetControlID="txtFechaOriginal" />
		<asp:CompareValidator runat="server" ID="dvFechaOriginal" ErrorMessage="* Fecha Invalida" Display="Dynamic"
		 ControlToValidate="txtFechaOriginal" Operator="DataTypeCheck" Type="Date" ValidationGroup="CrearFactura" />
	</td>
</tr>
		<tr >
	<td style="text-align: right;">
		Monto del Folio Fiscal Original
	</td>
	<td >
		 <asp:TextBox runat="server" ID="txtMontoOriginal"  Width="100%" />
		 <asp:CompareValidator runat="server" ID="cvMontoOriginal" ControlToValidate="txtMontoOriginal" Display="Dynamic"
		 ErrorMessage="* Monto invalido" Operator="DataTypeCheck" Type="Currency" ValidationGroup="CrearFactura" />			
	</td>
	
</tr>
		</table>

    </div>
	<asp:TabContainer ID="tabContainerAduana"  runat="server" Width="100%" 
                ActiveTabIndex="0">
	    <asp:TabPanel HeaderText="Addenda"  BorderStyle="Inset"  CssClass="page1" runat="server" ID="datosAddenda" ><ContentTemplate><div align="center"><table width="95%"><tr><td colspan="2" style="text-align: center;"><h1>Datos del Embarque</h1></td><td colspan="2" style="text-align: center;"><h1>Datos del Despacho</h1></td></tr><tr><td style="text-align: right">Guia master / B.L.: </td><td style="text-align: left;"><asp:TextBox runat="server" ID="txtGuiaMaster" /></td><td style="text-align: right">Referencia Interna: </td><td style="text-align: left"><asp:TextBox runat="server" ID="txtReferenciaInterna" /></td></tr><tr><td style="text-align: right">Guia house / Talón: </td><td style="text-align: left"><asp:TextBox runat="server" ID="txtGuiaHouse" /></td><td style="text-align: right">Referencia: </td><td style="text-align: left"><asp:TextBox runat="server" ID="txtReferenciaPascal" /></td></tr><tr><td style="text-align: right">Tipo cambio Fletes: </td><td style="text-align: left"><asp:TextBox runat="server" ID="txtTipoCambioFletes" /></td><td style="text-align: right">Aduana: </td><td style="text-align: left"><asp:TextBox runat="server" ID="txtAduana" /></td></tr><tr><td style="text-align: right">Tipo Operación: </td><td style="text-align: left"><asp:TextBox runat="server" ID="txtTipoOperacion" /></td><td style="text-align: right">Pedimento: </td><td style="text-align: left"><asp:TextBox runat="server" ID="txtPedimento" /></td></tr><tr><td style="text-align: right">Valor aduana: </td><td style="text-align: left"><asp:TextBox runat="server" ID="txtValorAduana" /></td><td style="text-align: right">Tipo cambio Pedimento: </td><td style="text-align: left"><asp:TextBox runat="server" ID="txtTipoCambioPedimento" /></td></tr><tr><td style="text-align: right">Mercancía: </td><td style="text-align: left"><asp:TextBox runat="server" ID="txtMercancia" /></td><td style="text-align: right">L. Aer. / Mrtma. / Terr.: </td><td style="text-align: left"><asp:TextBox runat="server" ID="txtTerr" /></td></tr><tr><td style="text-align: right">No. Bultos: </td><td style="text-align: left"><asp:TextBox runat="server" ID="TextBox1" /></td><td style="text-align: right">Días de Crédito: </td><td style="text-align: left"><asp:TextBox runat="server" ID="txtDiasCredito" /></td></tr><tr><td style="text-align: right">Peso Bruto: </td><td style="text-align: left"><asp:TextBox runat="server" ID="txtPesoBruto" /></td><td style="text-align: right">Fecha Vencimiento: </td><td style="text-align: left"><asp:TextBox runat="server" ID="txtFechaVencimiento" /><asp:CalendarExtender runat="server" ID="ceVencimiento" Format="dd/MM/yyyy"
						PopupButtonID="txtFechaVencimiento" TargetControlID="txtFechaVencimiento" 
						Enabled="True" /><asp:CompareValidator runat="server" ID="cvVencimiento" ErrorMessage="* Fecha Invalida" Display="Dynamic"
					ControlToValidate="txtFechaVencimiento" Operator="DataTypeCheck" Type="Date" ValidationGroup="CrearFactura" /></td></tr><tr><td style="text-align: right">Contenedor(es): </td><td style="text-align: left"><asp:TextBox runat="server" ID="txtContenedores" TextMode="MultiLine" /></td><td style="text-align: right">Facturas: </td><td style="text-align: left"><asp:TextBox runat="server" ID="txtFacturas" /></td></tr></table></div><h1 align="center">Conceptos Addenda</h1><table width="100%"><tr>
            <td style="text-align: right">Descripción </td><td colspan="3"><asp:TextBox runat="server" ID="txtDescrpcionAdenda" Width="80%" /><asp:RequiredFieldValidator runat="server" ID="rfvDescripcionAduana" ErrorMessage="* Requerido" Display="Dynamic"
				 ControlToValidate="txtDescrpcionAdenda" ValidationGroup="AgregarConceptoAduana" /></td></tr><tr>
                <td style="text-align: right">Factura / Referencia:</td><td><asp:TextBox runat="server" ID="txtNoFactura" /></td>
                <td style="text-align: right">Importe:</td><td><asp:TextBox runat="server" ID="txtTotalFactura" /><asp:RequiredFieldValidator runat="server" ID="rfvTotalFactura" ErrorMessage="* Requerido" Display="Dynamic"
				 ControlToValidate="txtTotalFactura" ValidationGroup="AgregarConceptoAduana" /><asp:CompareValidator runat="server" ID="CompareValidator4" ErrorMessage="* Importe Inválido" Display="Dynamic"
					ControlToValidate="txtTotalFactura" Operator="DataTypeCheck" Type="Double" ValidationGroup="AgregarConceptoAduana" /></td><td><asp:Button runat="server" ID="btnAgregarConceptoAduana" ValidationGroup="AgregarConceptoAduana" class="btn btn-primary" 
				 Text="Agregar" onclick="btnAgregarConceptoAduana_Click"/></td></tr></table><div style="width: 100%">
                <asp:GridView runat="server" ID="gvConceptosAduana" AutoGenerateColumns="False" CssClass="style124"
			Width="100%" ShowHeaderWhenEmpty="True" onrowcommand="gvConceptosAduana_RowCommand"><Columns><asp:BoundField HeaderText="Descripción" DataField="Descripcion" ><ItemStyle HorizontalAlign="Center" /></asp:BoundField><asp:BoundField HeaderText="NoFactura" DataField="Descripcion2" ><ItemStyle HorizontalAlign="Center" /></asp:BoundField><asp:BoundField HeaderText="Total" DataField="Total" DataFormatString="{0:C}" ><ItemStyle HorizontalAlign="Right" /></asp:BoundField><asp:ButtonField Text="Eliminar" CommandName="EliminarConcepto" /></Columns></asp:GridView></div><div></div><div></div><br /></ContentTemplate></asp:TabPanel>
		<asp:TabPanel ID="tabGeneral" HeaderText="Datos Generales"  CssClass="page1" runat="server">
        <HeaderTemplate>Conceptos</HeaderTemplate>
        <ContentTemplate>
        <div align="center"><h1>Conceptos</h1></div>
        <table width="95%" >
        <tr>
            <td style="text-align: right;" class="style125">Cantidad</td>
            <td class="style127" ><asp:TextBox runat="server" ID="txtCantidad" /><asp:CompareValidator runat="server" ID="cvCantidad" ControlToValidate="txtCantidad" Display="Dynamic" Type="Double"
				 ErrorMessage="* Cantidad Invalida" ValidationGroup="AgregarConcepto" Operator="DataTypeCheck" /><asp:RequiredFieldValidator runat="server" ID="rfvCantidad" ControlToValidate="txtCantidad" Display="Dynamic"
				 ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" /></td>
            <td style="text-align: right;" class="style128">Unidad </td><td ><asp:TextBox runat="server" ID="txtUnidad"  />&nbsp;&nbsp;<asp:RequiredFieldValidator runat="server" ID="rfvUnidad" ControlToValidate="txtUnidad" Display="Dynamic"
		 ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" /></td></tr><tr>
                <td style="text-align: right;" class="style125">Código </td>
                <td class="style127" ><asp:TextBox runat="server" ID="txtCodigo" /></td>
                <td style="text-align: right;" class="style128">Precio Unitario: $ </td><td ><asp:TextBox runat="server" ID="txtPrecio" /><asp:RequiredFieldValidator runat="server" ID="rfvPrecio" ControlToValidate="txtPrecio" Display="Dynamic"
		 ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" />&nbsp;&nbsp;<asp:CompareValidator runat="server" ID="cvPrecio"  ControlToValidate="txtPrecio" Display="Dynamic"
		 ErrorMessage="* Precio Inválido" Type="Currency" Operator="DataTypeCheck" ValidationGroup="AgregarConcepto" /></td></tr><tr>
                <td style="text-align: right;" class="style125"><asp:CheckBox runat="server" ID="cbIva" Text="I.V.A." AutoPostBack="True" Checked="True"/></td>
                <td style="text-align: left;" class="style127"><asp:TextBox runat="server" ID="txtIvaConcepto" Text="16"/>% <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="txtIvaConcepto" Display="Dynamic" 
				ValidationGroup="AgregarConcepto" ErrorMessage="* Dato Inválido" Operator="DataTypeCheck" Type="Integer" /></td>
                <td style="text-align: right" class="style128"><asp:CheckBox runat="server" ID="cbRetencion" Text="Retención"/></td><td style="text-align: left"><asp:TextBox runat="server" ID="txtRetencion" Text="4" />% <asp:CompareValidator ID="CompareRetencion" runat="server" ControlToValidate="txtRetencion" Display="Dynamic" 
				ValidationGroup="AgregarConcepto" ErrorMessage="* Dato Inválido" Operator="DataTypeCheck" Type="Integer" /></td></tr><tr>
                <td style="text-align: right;" class="style125">Descripción </td><td colspan="3">
                <asp:TextBox runat="server" ID="txtDescripcion" Width="67%" 
                    TextMode="MultiLine" /><asp:RequiredFieldValidator runat="server" ID="rfvDescripcion" ControlToValidate="txtDescripcion" Display="Dynamic"
				 ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" /></td></tr><tr>
                <td style="text-align: right;" class="style125"></td><td class="style127" ></td>
                <td class="style128"><asp:Button runat="server" ID="btnAgregar" Text="Agregar Concepto"  class="btn btn-primary"  ValidationGroup="AgregarConcepto" onclick="btnAgregar_Click"/></td><td><asp:Button runat="server" ID="btnBuscar" Text="Buscar" 
                    onclick="btnBuscar_Click"  class="btn btn-primary" Width="80px" /><asp:HiddenField ID="txtIdProducto" runat="server" ></asp:HiddenField></td></tr></table><br /><div style="height: 100%; overflow-y: auto" >
                
                <asp:GridView ID="gvDetalles" runat="server" AutoGenerateColumns="False" 
                    CssClass="style124" OnRowCommand="gvDetalles_RowCommand" 
                    ShowHeaderWhenEmpty="True" Width="100%">
                    <Columns>
                        <asp:BoundField DataField="Cantidad" HeaderText="Cantidad">
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Unidad" HeaderText="Unidad">
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Codigo" HeaderText="Código">
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Descripcion" HeaderText="Descripción" />
                        <asp:BoundField DataField="Precio" DataFormatString="{0:C}" 
                            HeaderText="Precio Unitario">
                        <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="PorcentajeIva" HeaderText="%I.V.A.">
                        <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ImporteIva" DataFormatString="{0:C}" 
                            HeaderText="I.V.A">
                        <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="PorcentajeRetencionIva" HeaderText="%Retención">
                        <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="RetencionIva" DataFormatString="{0:C}" 
                            HeaderText="Retención">
                        <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="TotalPartida" DataFormatString="{0:C}" 
                            HeaderText="Total">
                        <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:ButtonField CommandName="Editar" Text="Editar" Visible="False">
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:ButtonField>
                        <asp:ButtonField CommandName="EliminarConcepto" Text="Eliminar" Visible="False">
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:ButtonField>
                    </Columns>
                </asp:GridView>
                </div><br /></ContentTemplate></asp:TabPanel>
	</asp:TabContainer>
	<br /> <br />
	<asp:UpdateProgress AssociatedUpdatePanelID="up1" ID="UpdateProgress1" runat="server">
	<ProgressTemplate>
	<div align="center" >
		<asp:Image ID="Image1" ImageUrl="images/ajax-loader.gif" runat="server"/> 
		<br />
		CFDI en proceso ..
		</div>
	</ProgressTemplate>
	</asp:UpdateProgress>
	<asp:Label runat="server" ID="lblError" ForeColor="Red" />
	<div style="float: right">
	<table style="text-align:right;" >
		<tr style="width: 150px">
			<td>Subtotal:</td>
			<td><asp:Label runat="server" ID="lblSubtotal" /></td>
		</tr>
		<tr>
			<td>I.V.A.</td>
			<td><asp:Label runat="server" ID="lblIva" /></td>
		</tr>
		<tr>
			<td>Retención I.V.A.</td>
			<td><asp:Label runat="server" ID="lblRetencionIva" /></td>
		</tr>
			
		<tr>
			<td>Total</td>
			<td><asp:Label runat="server" ID="lblTotal" /></td>
		</tr>
		<tr>
			<td colspan="2"></td>
		</tr>
		<tr>
			<td>Total Gastos Addenda</td>
			<td><asp:Label runat="server" ID="lblTotalAddenda" /></td>
		</tr>
		<tr>
			<td>Anticipo</td>
			<td><asp:Label runat="server" ID="lblAnticipo" /></td>
		</tr>
			
			<tr>
			<td>Saldo</td>
			<td><asp:Label runat="server" ID="lblGranTotal" /></td>
		</tr>
	</table>
	</div>
	<div style="clear: both"></div><div>
		<asp:Label runat="server" ID="lblLeyenda" Text="... "></asp:Label>
	</div>
	<p align="right">
		<asp:Button runat="server" ID="btnLimpiar" Text="Limpiar"  class="btn btn-primary" 
			onclick="btnLimpiar_Click" Width="70px"/>&nbsp;&nbsp;&nbsp;
		<asp:Button runat="server" ID="BtnVistaPrevia" Text="Vista Previa" onclick="btnGenerarPreview_Click" class="btn btn-primary" 
		 ValidationGroup="CrearFactura" />&nbsp;&nbsp;&nbsp;
		<asp:Button runat="server" ID="btnGenerarFactura" Text="Generar Factura" onclick="btnGenerarFactura_Click" class="btn btn-primary" 
		 ValidationGroup="CrearFactura" />
         <asp:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" TargetControlID="btnGenerarFactura" ConfirmText="Confirma que deseas generar el comprobante"/>
	</p>
   
	</ContentTemplate>
	<Triggers>
		<asp:PostBackTrigger ControlID="btnLimpiar" />
		<asp:PostBackTrigger ControlID="tabContainerAduana" />
		<asp:PostBackTrigger ControlID="BtnVistaPrevia"/>
	</Triggers>
	</asp:UpdatePanel>
	<asp:ModalPopupExtender runat="server" ID="mpeBuscarConcepto" TargetControlID="btnConceptoDummy" BackgroundCssClass="mpeBack"
	 CancelControlID="btnCerrarConcepto" PopupControlID="pnlBuscarConcepto" />
	<asp:Panel runat="server" ID="pnlBuscarConcepto" style="text-align: center;" Width="800px" BackColor="White">
		<h1>Buscar Conceptos</h1>
		<p>
			<asp:TextBox runat="server" ID="txtConceptoBusqueda" Width="250px" />&nbsp;&nbsp;&nbsp;
			<asp:Button runat="server" ID="btnBuscarConcepto" Text="Buscar" onclick="btnBuscarConcepto_Click"  class="btn btn-primary" />
		</p>
       <div style="overflow-x:auto;">
		<asp:Label runat="server" ID="lblMensaje" ForeColor="Red" />
		<asp:GridView runat="server" ID="gvBuscarConceptos" Width="100%" AutoGenerateColumns="False"
		 DataKeyNames="IdProducto" ShowHeaderWhenEmpty="True" 
			onrowcommand="gvBuscarConceptos_RowCommand">
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
		<asp:Button runat="server" ID="btnCerrarConcepto" Text="Cancelar"  class="btn btn-primary" />
	</asp:Panel>
	<asp:Button runat="server" ID="btnConceptoDummy" style="display: none;" class="btn btn-primary" />

	<asp:ModalPopupExtender runat="server" ID="mpeEdita" TargetControlID="btnEditarDummy" BackgroundCssClass="mpeBack"
	 CancelControlID="btnCancelar" PopupControlID="panelEditaConcepto" />
	<asp:Panel runat="server" ID="panelEditaConcepto" style="text-align: center;" Width="800px" BackColor="White">
		<h1><asp:Label runat="server" ID="lblConcepto" >Editar Concepto</asp:Label></h1>
		 <table width="600px">
		 <tr>
			<td>Cantidad:</td>
			<td align="left">
				<asp:TextBox runat="server" ID="txtCantidadEdita" />
				<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="* Requerido" Display="Dynamic"
				 ControlToValidate="txtCantidadEdita" ValidationGroup="Concepto" />
				 <asp:CompareValidator runat="server" ID="CompareValidator2" ControlToValidate="txtCantidadEdita" Display="Dynamic" Type="Double"
		 ErrorMessage="* Cantidad Invalida" ValidationGroup="Concepto" Operator="DataTypeCheck" />
				  <asp:HiddenField runat="server" ID="hidDetalle"/>
				  <asp:HiddenField runat="server" ID="hidNumero"/>
			</td>
		</tr>
		<tr>
			<td>Unidad de Medida:</td>
			<td align="left">
				<asp:TextBox runat="server" ID="txtUnidadEdita" />
				<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="* Requerido" Display="Dynamic"
				 ControlToValidate="txtUnidadEdita" ValidationGroup="Concepto" />
			</td>
		</tr>
		<tr>
			<td>N° de identificación:</td>
			<td align="left">
				<asp:TextBox runat="server" ID="txtCodigoEdita"  Width="400px"></asp:TextBox>
			</td>
		</tr>
		<tr>
			<td>Descripción:</td>
			<td align="left">
				<asp:TextBox runat="server" ID="txtDescripcionEdita"  Width="400px"></asp:TextBox>
				<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="* Requerido" Display="Dynamic"
				 ControlToValidate="txtDescripcionEdita" ValidationGroup="Concepto" />
			</td>
		</tr>
		<tr>
			<td>Observaciones:</td>
			<td align="left">
				<asp:TextBox runat="server" ID="txtObservacionesEdita"  Width="400px" ></asp:TextBox>
				
			</td>
		</tr>
		 <tr>
			<td>Precio Unitario:</td>
			<td align="left">
				<asp:TextBox runat="server" ID="txtPrecioUnitarioEdita"  ></asp:TextBox>
				<asp:CompareValidator runat="server" ID="CompareValidator3" ControlToValidate="txtPrecioUnitarioEdita" Display="Dynamic" Type="Double"
		 ErrorMessage="* Cantidad Invalida" ValidationGroup="Concepto" Operator="DataTypeCheck" />
				<asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator4" ErrorMessage="* Requerido" Display="Dynamic"
				 ControlToValidate="txtPrecioUnitarioEdita" ValidationGroup="Concepto" />
			</td>
		</tr>

	</table>
	<div align="right">
		<asp:Button runat="server" ID="btnGuardar" Text="Guardar"  
			ValidationGroup="Concepto" onclick="btnGuardar_Click" style="width: 68px" class="btn btn-primary" 
			 />&nbsp;&nbsp;&nbsp;
		<asp:Button runat="server" ID="btnCancelar" Text="Cancelar"  class="btn btn-primary" 
			CausesValidation="False" />
	</div>
	<br />
	</asp:Panel>
	<asp:Button runat="server" ID="btnEditarDummy" style="display: none;" class="btn btn-primary" />
</asp:Content>