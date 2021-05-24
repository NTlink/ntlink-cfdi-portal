﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="wfrFacturaArrendamiento.aspx.cs" Inherits="GafLookPaid.wfrFacturaArrendamiento" %>
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
            text-align: left;
        }
        .style2
        {
            width: 204px;
        }
        .style3
        {
            color: #000099;
        }
        .style4
        {
            width: 17%;
        }
        .style5
        {
            width: 120px;
        }
        .style6
        {
            text-align: justify;
            width: 120px;
        }
        .style7
        {
            color: #000099;
            width: 36%;
        }
        .style8
        {
            width: 36%;
        }
         .style124
    {
        border-style:solid;
        border-left:  #A8CF38;
    border-right:  #A8CF38;
    border-top:  #A8CF38;
    border-bottom:  #b3b3b3;
        border-radius: 15px ;
        border-width: 1px;
         padding: 2px 4px;
        height:40%rem;
        width:50%;
        color: #000101;
        background-color:transparent;
        
     background-color: #DCD9D9;
        text-align: center;}
       
    }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

	<h1>Generar CFDI Recibo de Arrendamiento</h1>
	<p>
		Empresa:&nbsp;<asp:DropDownList runat="server" ID="ddlEmpresa" AutoPostBack="True"
		 DataTextField="RazonSocial" DataValueField="idEmpresa" onselectedindexchanged="ddlEmpresa_SelectedIndexChanged" />
	</p>
    	<asp:UpdatePanel ID="up1" runat="server" UpdateMode="Conditional">
		<ContentTemplate>
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
                        <asp:Label runat="server" ID="lblFechaPago" Text="Fecha de Pago:" Visible="False" />
                        </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtFechaPago" Width="75px" Visible="False" />
                        <asp:CompareValidator runat="server" ID="cvFechaInicial" ControlToValidate="txtFechaPago"
                            Display="Dynamic" ErrorMessage="* Fecha Invalida" Operator="DataTypeCheck" Type="Date" />
                        <asp:CalendarExtender runat="server" ID="ceFechaInicial" Animated="False" PopupButtonID="txtFechaPago"
                            TargetControlID="txtFechaPago" Format="dd/MM/yyyy" />
                    </td>
                    <td style="text-align: right">
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
                        <asp:TextBox runat="server" ID="txtSerie" Width="75px" MaxLength="25" />
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
                        <asp:Label runat="server" ID="lblTipoCambio" Text="Tipo Cambio USD:" 
                            Visible="False" style="text-align: right" />
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
            </table>
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
        <td class="style4"></td>
        <td class="style7">&nbsp;</td>
        <td class="style5"></td>
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
                Numero de Cuenta (Últimos 4 dígitos) <br />
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

		<tr >
			<td style="text-align: right" class="style4">
				Sucursal
			</td>
			<td class="style8" >
				<asp:DropDownList runat="server" ID="ddlSucursales" AppendDataBoundItems="True" DataValueField="LugarExpedicion"
					DataTextField="Nombre" />			
			</td>
			<td style="text-align:right;" class="style6">
				Observaciones
			</td>
			<td >
				<asp:TextBox runat="server" ID="txtProyecto" Width="100%" />
			</td>
		</tr>
		<tr>
    <td style="text-align: right;" class="style4">
		Forma de Pago
	</td>
	<td class="style8">
		<asp:DropDownList runat="server" ID="ddlCondicionesPago" AutoPostBack="True" 
            onselectedindexchanged="ddlCondicionesPago_SelectedIndexChanged">
		    <asp:ListItem Text="Pago en una sola exhibición" Value="Pago en una sola exhibición"></asp:ListItem>
            <asp:ListItem Text="En parcialidades" Value="En parcialidades"></asp:ListItem>
		</asp:DropDownList>
	</td>
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
	       <asp:Panel ID="Panel2" runat="server" BorderStyle="Double" CssClass="page1" HorizontalAlign="Center" Width="100%" > 
     
       
	<h1 style="text-align: center">Conceptos</h1>
	<table width="95%" >
		<tr>
			<td style="text-align: right;" width="15%">Cantidad</td>
			<td class="style1" >
				<asp:TextBox runat="server" ID="txtCantidad" />
				<asp:CompareValidator runat="server" ID="cvCantidad" ControlToValidate="txtCantidad" Display="Dynamic" Type="Double"
				 ErrorMessage="* Cantidad Invalida" ValidationGroup="AgregarConcepto" Operator="DataTypeCheck" />
				<asp:RequiredFieldValidator runat="server" ID="rfvCantidad" ControlToValidate="txtCantidad" Display="Dynamic"
				 ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" />
			</td>
			<td style="text-align: right;" width="15%">
				Unidad
			</td>
			<td style="text-align: left" >
				<asp:TextBox runat="server" ID="txtUnidad"  />&nbsp;
		<asp:RequiredFieldValidator runat="server" ID="rfvUnidad" ControlToValidate="txtUnidad" Display="Dynamic"
		 ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" />
			</td>
		</tr>
	   
		 <tr>
			<td style="text-align: right;" width="15%">
			Código
			</td>
			<td class="style1" >
				<asp:TextBox runat="server" ID="txtCodigo" />
			</td>
			<td style="text-align: right;" width="15%">
			Precio Unitario: $
			</td>
			<td style="text-align: left" >
				<asp:TextBox runat="server" ID="txtPrecio" />
				<asp:RequiredFieldValidator runat="server" ID="rfvPrecio" ControlToValidate="txtPrecio" Display="Dynamic"
		 ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" />&nbsp;
		<asp:CompareValidator runat="server" ID="cvPrecio"  ControlToValidate="txtPrecio" Display="Dynamic"
		 ErrorMessage="* Precio invalido" Type="Currency" Operator="DataTypeCheck" ValidationGroup="AgregarConcepto" />
			</td>
		</tr>
        <tr>
			    <td style="text-align: right;">
				    <asp:CheckBox runat="server" ID="cbIva" Text="I.V.A." AutoPostBack="True" Checked="True"/>  
			    </td>
			    <td style="text-align: left;">
				    <asp:TextBox runat="server" ID="txtIvaConcepto" Text="16"/> %
				    <asp:CompareValidator ID="CompareValidator4" runat="server" ControlToValidate="txtIvaConcepto" Display="Dynamic" 
				    ValidationGroup="AgregarConcepto" ErrorMessage="* Dato Inválido" Operator="DataTypeCheck" Type="Double" />  
			    </td>
                
			    <td style="text-align: right;">
				    Cuenta Predial
			    </td>
			    <td style="text-align: left;">
				    <asp:TextBox runat="server" ID="txtCuentaPredial" /> 
			    </td>
                </tr>
        
		<tr>

			<td style="text-align: right;" width="15%">
			Descripción
			</td>
			<td colspan="3" style="text-align: left">
				<asp:TextBox runat="server" ID="txtDescripcion" Width="80%" TextMode="MultiLine" />
				<asp:RequiredFieldValidator runat="server" ID="rfvDescripcion" ControlToValidate="txtDescripcion" Display="Dynamic"
				 ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" />
			</td>
		</tr>
		
		 <tr>
			<td style="text-align: right;" width="15%">
			
			</td>
			<td class="style1" >
				
		</td>
		<td>
			<asp:Button runat="server" ID="btnAgregar" Text="Agregar Concepto"  class="btn btn-primary" ValidationGroup="AgregarConcepto" onclick="btnAgregar_Click"/>

		</td>
		<td>
			<asp:Button runat="server" ID="btnBuscar" Text="Buscar" 
                onclick="btnBuscar_Click" class="btn btn-primary" Width="80px" />
			<asp:HiddenField ID="txtIdProducto" runat="server" />
		</td>
		</tr>

		
	</table>
               <br></br>
    
	 <div style="height: 100%; overflow-y: scroll" >
		<asp:GridView runat="server" ID="gvDetalles" AutoGenerateColumns="False"  CssClass="style124" HorizontalAlign="Center" 
			Width="98%" ShowHeaderWhenEmpty="True" onrowcommand="gvDetalles_RowCommand">
			<Columns>
				<asp:BoundField HeaderText="Cantidad" DataField="Cantidad" ItemStyle-HorizontalAlign="Center" />
				<asp:BoundField HeaderText="Unidad" DataField="Unidad" ItemStyle-HorizontalAlign="Center" />
				<asp:BoundField HeaderText="Código" DataField="Codigo" ItemStyle-HorizontalAlign="Center" />
				<asp:BoundField HeaderText="Descripción" DataField="Descripcion" />
                <asp:BoundField HeaderText="Cuenta Predial" DataField="CuentaPredial" />
				<asp:BoundField HeaderText="Precio Unitario" DataField="Precio" DataFormatString="{0:C}" ItemStyle-HorizontalAlign="Right" />
				<asp:BoundField HeaderText="%I.V.A." DataField="PorcentajeIva" ItemStyle-HorizontalAlign="Right" />
				<asp:BoundField HeaderText="I.V.A." DataField="ImporteIva" DataFormatString="{0:C}" ItemStyle-HorizontalAlign="Right" />
				<asp:BoundField HeaderText="Total" DataField="TotalPartida" DataFormatString="{0:C}" ItemStyle-HorizontalAlign="Right" />
				<asp:ButtonField Text="Editar" CommandName="Editar" Visible="False" ItemStyle-HorizontalAlign="Center"/>
				<asp:ButtonField Text="Eliminar" CommandName="EliminarConcepto" Visible="False" ItemStyle-HorizontalAlign="Center" />
			</Columns>
		</asp:GridView>
		</div>
        <br />
        </asp:Panel>
		<br />
		<div>
		    <table>
		    <tr>
                        <td style="text-align: right">
                            <asp:CheckBox ID="cbRetencionIva" runat="server" Text="Retención I.V.A." AutoPostBack="True"
                                Checked="True" oncheckedchanged="cbRetencionIva_CheckedChanged" />
                        </td>
                        <td style="text-align: left">
                            <asp:TextBox ID="txtRetencionIva" runat="server" Text="10.66" />
                            %
                            <asp:CompareValidator ID="CompareValidator3" runat="server" 
                                ControlToValidate="txtRetencionIva" Display="Dynamic" 
                                ErrorMessage="* Dato Inválido" Operator="DataTypeCheck" Type="Double" 
                                ValidationGroup="AgregarConcepto" />
                        </td>
                        <td style="text-align: right">
                            <asp:CheckBox ID="cbRetIsr" runat="server" Text="Retención I.S.R." 
                                Checked="True" AutoPostBack="True" oncheckedchanged="cbRetIsr_CheckedChanged" />
                        </td>
                        <td style="text-align: left">
                            <asp:TextBox ID="txtRetIsr" runat="server" Text="10" />
                            %
                            <asp:CompareValidator ID="CompareValidator5" runat="server" 
                                ControlToValidate="txtRetIsr" Display="Dynamic" 
                                ErrorMessage="* Dato Inválido" Operator="DataTypeCheck" Type="Double" 
                                ValidationGroup="AgregarConcepto" />
                        </td>

		</tr>
        </table>
		</div> <br /> <br />
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
				<td>Retención I.S.R.</td>
				<td><asp:Label runat="server" ID="lblRetencionIsr" /></td>
			</tr>
			<tr>
				<td>Total</td>
				<td><asp:Label runat="server" ID="lblTotal" /></td>
			</tr>
		</table>
		</div>
		 
	<div style="clear: both"></div><div>
		<asp:Label runat="server" ID="lblLeyenda" Text="... "></asp:Label>
	</div>
	<p align="right">
		<asp:Button runat="server" ID="btnLimpiar" Text="Limpiar" 
			onclick="btnLimpiar_Click" class="btn btn-primary" Width="70px" />&nbsp;&nbsp;&nbsp;
		<asp:Button runat="server" ID="BtnVistaPrevia" Text="Vista Previa" onclick="btnGenerarPreview_Click" class="btn btn-primary" 
		 ValidationGroup="CrearFactura" />&nbsp;&nbsp;&nbsp;
		<asp:Button runat="server" ID="btnGenerarFactura" Text="Generar Factura" onclick="btnGenerarFactura_Click" class="btn btn-primary" 
		 ValidationGroup="CrearFactura" />
         <asp:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" TargetControlID="btnGenerarFactura" ConfirmText="Confirma que deseas generar el comprobante"/>
	</p>
   
	</ContentTemplate>
	<Triggers>
		<asp:PostBackTrigger ControlID="btnLimpiar" />
		<asp:PostBackTrigger ControlID="gvDetalles" />
		<asp:PostBackTrigger ControlID="BtnVistaPrevia"/>
        <asp:PostBackTrigger runat="server" ControlID="btnBuscar"/>
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
        <div style="height: 400px; overflow-y: scroll"  >
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
		<asp:Button runat="server" ID="btnCerrarConcepto" Text="Cancelar" class="btn btn-primary"  />
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
				 <asp:CompareValidator runat="server" ID="CompareValidator1" ControlToValidate="txtCantidadEdita" Display="Dynamic" Type="Double"
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
				<asp:CompareValidator runat="server" ID="CompareValidator2" ControlToValidate="txtPrecioUnitarioEdita" Display="Dynamic" Type="Double"
		 ErrorMessage="* Cantidad Invalida" ValidationGroup="Concepto" Operator="DataTypeCheck" />
				<asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator4" ErrorMessage="* Requerido" Display="Dynamic"
				 ControlToValidate="txtPrecioUnitarioEdita" ValidationGroup="Concepto" />
			</td>
		</tr>

	</table>
	<div align="right">
		<asp:Button runat="server" ID="btnGuardar" Text="Guardar"  class="btn btn-primary"  
			ValidationGroup="Concepto" onclick="btnGuardar_Click"
			 />&nbsp;&nbsp;&nbsp;
		<asp:Button runat="server" ID="btnCancelar" Text="Cancelar"  class="btn btn-primary" 
			CausesValidation="False" />
	</div>
	<br />
	</asp:Panel>
	<asp:Button runat="server" ID="btnEditarDummy" style="display: none;" class="btn btn-primary" />
</asp:Content>
