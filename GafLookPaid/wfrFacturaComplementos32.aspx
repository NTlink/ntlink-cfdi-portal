<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="wfrFacturaComplementos32.aspx.cs" Inherits="GafLookPaid.wfrFacturaComplementos32" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<%@ Register Src="~/controles/ImpuestosLocales.ascx" TagPrefix="uc" TagName="UCImpuestosLocales" %>
<%@ Register Src="~/controles/InformacionAduanera.ascx" TagPrefix="uc" TagName="UCInformacionAduanera" %>
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
            width: 204px;
        }
        .style3
        {
            width: 170px;
        }
        .style6
        {
            width: 280px;
            text-align: right;
        }
        .style10
        {
            width: 17%;
        }
        .style11
        {
            width: 162px;
        }
        .style13
        {
            width: 32%;
        }
        .style14
        {
            text-align: justify;
            width: 162px;
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
        .style125
        {
            width: 129px;
        }
        .style126
        {
            width: 105px;
        }
        .style129
        {
            width: 197px;
        }
        .style131
        {
            text-align: right;
            width: 204px;
        }
        .style132
        {
            width: 8%;
        }
        .style133
        {
            width: 119px;
        }
        .style137
        {
            width: 280px;
        }
        .style139
        {
            width: 376px;
        }
        .style140
        {
            width: 260px;
        }
        .style141
        {
            width: 204px;
        }
        .style142
        {
            width: 316px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

	<h1>Generar CFDI Complementos</h1>
	<p>
		Empresa:&nbsp;<asp:DropDownList runat="server" ID="ddlEmpresa" AutoPostBack="True"
		 DataTextField="RazonSocial" DataValueField="idEmpresa" onselectedindexchanged="ddlEmpresa_SelectedIndexChanged" />
	</p>
    	<asp:UpdatePanel ID="up1" runat="server" UpdateMode="Conditional">
		<ContentTemplate>
	<table width="90%" >
		<tr>
			<td style="text-align:right">
				Status Factura    
			</td>
			<td>
				<asp:DropDownList runat="server" ID="ddlStatusFactura" AutoPostBack="True" 
					onselectedindexchanged="ddlStatusFactura_SelectedIndexChanged" >
					<asp:ListItem Value="0" Text="Pendiente"></asp:ListItem>
					<asp:ListItem Value="1" Text="Pagada"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td style="text-align:right" class="style126">
				<asp:Label runat="server" ID="lblFechaPago" Text="Fecha de Pago" 
                    Visible="False" style="text-align: right" />

			</td>
			<td>
				<asp:TextBox runat="server" ID="txtFechaPago" Width="75px" Visible="False" />
				<asp:CompareValidator runat="server" ID="cvFechaInicial" ControlToValidate="txtFechaPago" Display="Dynamic" ValidationGroup="CrearFactura"
				 ErrorMessage="* Fecha Invalida" Operator="DataTypeCheck" Type="Date" />
				<asp:CalendarExtender runat="server" ID="ceFechaInicial" Animated="False" PopupButtonID="txtFechaPago" TargetControlID="txtFechaPago" Format="dd/MM/yyyy" />
                <asp:CustomValidator runat="server" id="cusCustom" controltovalidate="txtFechaPago" ValidationGroup="CrearFactura" onservervalidate="fechaPago_ServerValidate" errormessage="Fecha fuera de rango" />

			</td>
			<td style="text-align:right" class="style125">
                        Tipo de Documento
                    </td>
                    <td>
                        <asp:DropDownList runat="server" ID="ddlTipoDocumento">
                            <asp:ListItem runat="server" Text="Factura" Value="Ingreso" Selected="True" />
                            <asp:ListItem runat="server" Text="Nota de Crédito" Value="Egreso" />
                            
                        </asp:DropDownList>
                    </td>
		</tr>
		<tr>
			<td style="text-align:right">Serie:</td>
			<td>
				<asp:TextBox runat="server" ID="txtSerie" Width="75px" MaxLength="25" />
			</td>
			<td style="text-align:right" class="style126">Folio:</td>
			<td><asp:TextBox runat="server" ID="txtFolio" Width="50px" Enabled="False" /></td>
			<td style="text-align: right" class="style125">Moneda:</td>
			<td>
				<asp:DropDownList runat="server" ID="ddlMoneda" onselectedindexchanged="ddlMoneda_SelectedIndexChanged">
					<asp:ListItem Value="1" Text="MXN" />
					<asp:ListItem Value="2" Text="USD" />
                     <asp:ListItem Value="3" Text="EUR" />
                            <asp:ListItem Value="4" Text="JPY" />
				</asp:DropDownList>
			</td>
			<td style="text-align:right"><asp:Label runat="server" ID="lblTipoCambio" Text="Tipo Cambio USD:" Visible="False" /></td>
			<td><asp:TextBox runat="server" ID="txtTipoCambio" Visible="False" Width="50px" /></td>
			<td><%--Días Revisión--%></td>
			<td>
				<asp:TextBox runat="server" ID="txtDiasRevision" Width="50px" Visible="false" />
				<asp:CompareValidator runat="server" ID="cvTxtDiasRevision" ControlToValidate="txtDiasRevision" Display="Dynamic"
				 ErrorMessage="* Dato invalido" Type="Integer" Operator="DataTypeCheck"  />
			</td>
			<td>
				
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
        <td class="style10"></td>
        <td class="style13">&nbsp;</td>
        <td class="style11"></td>
        <td></td>
        
         </tr>
		<tr>
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
                    TextMode="MultiLine" Width="100%" Height="72px" /> <br />
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
		<tr >
			<td style="text-align:right" class="style10">
				Sucursal
			</td>
			<td class="style13" >
				<asp:DropDownList runat="server" ID="ddlSucursales" AppendDataBoundItems="True" DataValueField="LugarExpedicion"
					DataTextField="Nombre" />			
			</td>
			<td style="text-align:right;" class="style14">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Observaciones
			</td>
			<td >
				<asp:TextBox runat="server" ID="txtProyecto" Width="100%" />
			</td>
		</tr>
		<tr>
    <td style="text-align:right" class="style10">
		Forma de Pago
	</td>
	<td class="style13">
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
        <table width="95%">
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
	         <asp:Panel ID="Panel1" runat="server" BorderStyle="Double" CssClass="page1" HorizontalAlign="Center" Width="100%" > 
     
       
	<h1 style="text-align: center">Conceptos</h1>
	<table width="95%" >
		<tr>
			<td style="text-align: right;" class="style137">Cantidad</td>
			<td style="text-align: left" class="style142"  >
				<asp:TextBox runat="server" ID="txtCantidad" />
				<asp:CompareValidator runat="server" ID="cvCantidad" ControlToValidate="txtCantidad" Display="Dynamic" Type="Double"
				 ErrorMessage="* Cantidad Invalida" ValidationGroup="AgregarConcepto" Operator="DataTypeCheck" />
				<asp:RequiredFieldValidator runat="server" ID="rfvCantidad" ControlToValidate="txtCantidad" Display="Dynamic"
				 ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" />
			</td>
			<td class="style131">
				Unidad
			</td>
			<td style="text-align: left" class="style140" >
				<asp:TextBox runat="server" ID="txtUnidad"  />&nbsp;
		<asp:RequiredFieldValidator runat="server" ID="rfvUnidad" ControlToValidate="txtUnidad" Display="Dynamic"
		 ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" />
			</td>
		</tr>
	   
		 <tr>
			<td style="text-align: right;" class="style137">
			Código
			</td>
			<td style="text-align: left" class="style142"  >
				<asp:TextBox runat="server" ID="txtCodigo" />
			</td>
			<td style="text-align: right;" class="style141">
			Precio Unitario: $
			</td>
			<td style="text-align: left" class="style140" >
				<asp:TextBox runat="server" ID="txtPrecio" />
				<asp:RequiredFieldValidator runat="server" ID="rfvPrecio" ControlToValidate="txtPrecio" Display="Dynamic"
		 ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" />&nbsp;
		<asp:CompareValidator runat="server" ID="cvPrecio"  ControlToValidate="txtPrecio" Display="Dynamic"
		 ErrorMessage="* Precio invalido" Type="Double" Operator="DataTypeCheck" ValidationGroup="AgregarConcepto" />
			</td>
		</tr>
        <tr>
			    <td style="text-align: right;" class="style137">
				    <asp:CheckBox runat="server" ID="cbIva" Text="I.V.A." AutoPostBack="True" Checked="True"/>  
			    </td>
			    <td style="text-align: left;" class="style142">
				    <asp:TextBox runat="server" ID="txtIvaConcepto" Text="16"/> %
				    <asp:CompareValidator ID="CompareValidator4" runat="server" ControlToValidate="txtIvaConcepto" Display="Dynamic" 
				    ValidationGroup="AgregarConcepto" ErrorMessage="* Dato Inválido" Operator="DataTypeCheck" Type="Double" />  
			    </td>
                
			   
                </tr>
                <tr>
                <td  style="text-align: right;" class="style137">
                    <asp:CheckBox ID="cbRetencionIva" runat="server" AutoPostBack="True" oncheckedchanged="cbRetencionIva_CheckedChanged" 
                        Text="Retención I.V.A." />
                </td>
                <td style="text-align: left" class="style142">  <asp:TextBox ID="txtRetencionIva" runat="server" Text="0.00" />
                            %
                            <asp:CompareValidator ID="CompareValidator3" runat="server" 
                                ControlToValidate="txtRetencionIva" Display="Dynamic" 
                                ErrorMessage="* Dato Inválido" Operator="DataTypeCheck" Type="Double" 
                                ValidationGroup="AgregarConcepto" /></td>
                <td  style="text-align: right;" class="style141">
                    <asp:CheckBox ID="cbRetIsr" runat="server" AutoPostBack="True" 
                        oncheckedchanged="cbRetIsr_CheckedChanged" Text="Retención I.S.R." 
                        style="text-align: center" />
                    </td>
                <td style="text-align: left" class="style140">  <asp:TextBox ID="txtRetIsr" runat="server" Text="0.00" />
                            %
                            <asp:CompareValidator ID="CompareValidator5" runat="server" 
                                ControlToValidate="txtRetIsr" Display="Dynamic" 
                                ErrorMessage="* Dato Inválido" Operator="DataTypeCheck" Type="Double" 
                                ValidationGroup="AgregarConcepto" /></td>
                
                
                </tr>
        
		<tr>

			<td style="text-align: right;" class="style137">
			Descripción
			</td>
			<td colspan="3" style="text-align: left">
				<asp:TextBox runat="server" ID="txtDescripcion" Width="80%" TextMode="MultiLine" />
				<asp:RequiredFieldValidator runat="server" ID="rfvDescripcion" ControlToValidate="txtDescripcion" Display="Dynamic"
				 ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" />
			</td>
		</tr>
		<tr>
        <td class="style6">
            <asp:CheckBox ID="cbIA" runat="server" AutoPostBack="True" oncheckedchanged="cbIA_CheckedChanged" 
                        Text="Información Aduanera." style="text-align: right" /></td>
        <td colspan="3">
        <uc:UCInformacionAduanera id="UCInformacionAduanera1" runat="server"></uc:UCInformacionAduanera>
       
        </td>
        </tr>
		 <tr>
			<td style="text-align: right;" class="style137">
			
			</td>
            <td class="style142" >
				
		</td>
			<td class="style141" >
				
		</td>
		<td class="style140">
			<asp:Button runat="server" ID="btnAgregar" Text="Agregar Concepto" class="btn btn-primary"
                ValidationGroup="AgregarConcepto" onclick="btnAgregar_Click" 
                style="height: 26px"/>

		</td>
		<td class="style133">
			<asp:Button runat="server" ID="btnBuscar" Text="Buscar" 
                onclick="btnBuscar_Click" class="btn btn-primary" Width="80px"/>
			<asp:HiddenField ID="txtIdProducto" runat="server" />
		</td>
        <td></td>
		</tr>        	
	</table><br />
                
                 <div style="height: 100%; overflow-y: scroll">
                     <asp:GridView ID="gvDetalles" runat="server" AutoGenerateColumns="False" 
                         CssClass="style124" HorizontalAlign="Center" 
                         onrowcommand="gvDetalles_RowCommand" ShowHeaderWhenEmpty="True" 
                         style="text-align: left" Width="98%">
                         <Columns>
                             <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" 
                                 ItemStyle-HorizontalAlign="Center" />
                             <asp:BoundField DataField="Unidad" HeaderText="Unidad" 
                                 ItemStyle-HorizontalAlign="Center" />
                             <asp:BoundField DataField="Codigo" HeaderText="Código" 
                                 ItemStyle-HorizontalAlign="Center" />
                             <asp:BoundField DataField="Descripcion" HeaderText="Descripción" />
                             <asp:BoundField DataField="Precio" DataFormatString="{0:C}" 
                                 HeaderText="Precio Unitario" ItemStyle-HorizontalAlign="Right" />
                             <asp:BoundField DataField="PorcentajeIva" HeaderText="%I.V.A." 
                                 ItemStyle-HorizontalAlign="Right" />
                             <asp:BoundField DataField="ImporteIva" DataFormatString="{0:C}" 
                                 HeaderText="I.V.A." ItemStyle-HorizontalAlign="Right" />
                             <asp:BoundField DataField="RetencionIva" DataFormatString="{0:C}" 
                                 HeaderText="R. I.V.A." ItemStyle-HorizontalAlign="Right" />
                             <asp:BoundField DataField="ISR" DataFormatString="{0:C}" HeaderText="I.S.R." 
                                 ItemStyle-HorizontalAlign="Right" />
                             <asp:BoundField DataField="IAnumero" HeaderText="Numero" 
                                 ItemStyle-HorizontalAlign="Right" />
                             <asp:BoundField DataField="IAfecha" HeaderText="Fecha" 
                                 ItemStyle-HorizontalAlign="Right" />
                             <asp:BoundField DataField="IAaduana" HeaderText="Aduana" 
                                 ItemStyle-HorizontalAlign="Right" />
                             <asp:BoundField DataField="TotalPartida" DataFormatString="{0:C}" 
                                 HeaderText="Total" ItemStyle-HorizontalAlign="Right" />
                             <asp:ButtonField CommandName="Editar" ItemStyle-HorizontalAlign="Center" 
                                 Text="Editar" Visible="False" />
                             <asp:ButtonField CommandName="EliminarConcepto" 
                                 ItemStyle-HorizontalAlign="Center" Text="Eliminar" Visible="False" />
                         </Columns>
                     </asp:GridView>
                     <br />
                   </div>
                                
    
        </asp:Panel>
        <br />
		<div>
		    <table width="100%">
		    <tr>
                        
                        
                       
                        <td style="text-align: left">
                          <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
		<ContentTemplate>
        <asp:Panel ID="Panel2" runat="server"  CssClass="page1" BorderStyle="Double" HorizontalAlign="Center" Width="100%" > 
          <asp:CheckBoxList ID="ckeckboxlist1" runat="server" Font-Bold="True"  Width="100%"
             onselectedindexchanged="ckeckboxlist1_SelectedIndexChanged"  RepeatLayout="table" RepeatColumns="2" RepeatDirection="vertical"
                AutoPostBack="True" style="text-align: left">
             <asp:ListItem>Impuestos Locales</asp:ListItem>
          
       </asp:CheckBoxList>
       </asp:Panel>
       <div id="Complementos" style="width:100%" runat="server" >
           
          <uc:UCImpuestosLocales id="ImpuestosLocales" runat="server"></uc:UCImpuestosLocales>
        
      </div>
     </ContentTemplate>
    </asp:UpdatePanel>
                        </td>

		</tr>
        </table>
		</div>
        <br /> <br />
		   <asp:UpdateProgress AssociatedUpdatePanelID="up1" ID="UpdateProgress1" runat="server">
			<ProgressTemplate>
			<div align="center" >
			  <asp:Image ImageUrl="images/ajax-loader.gif" runat="server"/> 
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
				<td>&nbsp;Retenciónes Locales.</td>
				<td><asp:Label runat="server" ID="lblRetencionLocal" /></td>
			</tr>
             <tr>
				<td>Traslado Locales.</td>
				<td><asp:Label runat="server" ID="lblTrasladoLocal" /></td>
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
		<asp:Button runat="server" ID="btnLimpiar" Text="Limpiar" class="btn btn-primary"
			onclick="btnLimpiar_Click" Width="70px"/>&nbsp;&nbsp;&nbsp;
		<asp:Button runat="server" ID="BtnVistaPrevia" Text="Vista Previa" onclick="btnGenerarPreview_Click" class="btn btn-primary"
		 ValidationGroup="CrearFactura" />&nbsp;&nbsp;&nbsp;
		<asp:Button runat="server" ID="btnGenerarFactura" Text="Generar Factura" onclick="btnGenerarFactura_Click" class="btn btn-primary"
		 ValidationGroup="CrearFactura" />
         <asp:ConfirmButtonExtender runat="server" TargetControlID="btnGenerarFactura" ConfirmText="Confirma que deseas generar el comprobante"/>
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
			<asp:Button runat="server" ID="btnBuscarConcepto" Text="Buscar" onclick="btnBuscarConcepto_Click" />
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
		<asp:Button runat="server" ID="btnCerrarConcepto" Text="Cancelar" class="btn btn-primary"/>
	</asp:Panel>
	<asp:Button runat="server" ID="btnConceptoDummy" style="display: none;" class="btn btn-primary"/>

	<asp:ModalPopupExtender runat="server" ID="mpeEdita" TargetControlID="btnEditarDummy" BackgroundCssClass="mpeBack"
	 CancelControlID="btnCancelar" PopupControlID="panelEditaConcepto" />
	<asp:Panel runat="server" ID="panelEditaConcepto" style="text-align: center;" Width="800px" BackColor="White">
		<h1><asp:Label runat="server" ID="lblConcepto" >Editar Concepto</asp:Label></h1>
		 <table width="600px">
		 <tr>
			<td>Cantidad:</td>
			<td align="left">
				<asp:TextBox runat="server" ID="txtCantidadEdita" />
				<asp:RequiredFieldValidator runat="server" ErrorMessage="* Requerido" Display="Dynamic"
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
				<asp:RequiredFieldValidator runat="server" ErrorMessage="* Requerido" Display="Dynamic"
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
				<asp:RequiredFieldValidator runat="server" ErrorMessage="* Requerido" Display="Dynamic"
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
				<asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ErrorMessage="* Requerido" Display="Dynamic"
				 ControlToValidate="txtPrecioUnitarioEdita" ValidationGroup="Concepto" />
			</td>
		</tr>

	</table>
	<div align="right">
		<asp:Button runat="server" ID="btnGuardar" Text="Guardar"  class="btn btn-primary"
			ValidationGroup="Concepto" onclick="btnGuardar_Click"
			 />&nbsp;&nbsp;&nbsp;
		<asp:Button runat="server" ID="btnCancelar" Text="Cancelar" class="btn btn-primary"
			CausesValidation="False" />
	</div>
	<br />
	</asp:Panel>
	<asp:Button runat="server" ID="btnEditarDummy" style="display: none;" class="btn btn-primary"/>
</asp:Content>
