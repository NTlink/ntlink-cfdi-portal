<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="wfrFacturaFirmas.aspx.cs" Inherits="GafLookPaid.wfrFacturaFirmas" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<%@ MasterType VirtualPath="~/Site.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

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
            width: 206px;
        }
        .style3
        {
            width: 291px;
        }
	    .style5
        {
            color: #000099;
        }
	    .style6
        {
            width: 145px;
        }
        .style7
        {
            width: 66px;
        }
	    .style8
        {
            width: 284px;
            text-align: right;
        }
	    .style9
        {
            width: 227px;
        }
	    .style13
        {
            width: 13%;
        }
        .style14
        {
            width: 7%;
            text-align: right;
        }
	    .style15
        {
            width: 7%;
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
	<h1>Generar CFDI Firmas</h1>
	<p>
		Empresa:&nbsp;<asp:DropDownList runat="server" ID="ddlEmpresa" AutoPostBack="True"
		 DataTextField="RazonSocial" DataValueField="idEmpresa" onselectedindexchanged="ddlEmpresa_SelectedIndexChanged" />
	</p>
    <asp:UpdatePanel ID="up1" runat="server" UpdateMode="Conditional">
		<ContentTemplate>
	<table width="100%" >
		<tr>
			<td style="text-align:right">
			Status Factura    
			</td>
			<td class="style7">
				<asp:DropDownList runat="server" ID="ddlStatusFactura" AutoPostBack="True" 
					onselectedindexchanged="ddlStatusFactura_SelectedIndexChanged" >
					<asp:ListItem Value="0" Text="Pendiente"></asp:ListItem>
					<asp:ListItem Value="1" Text="Pagada"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td style="text-align: right">
				<asp:Label runat="server" ID="lblFechaPago" Text="Fecha de Pago" 
                    Visible="False" style="text-align: right" />

			</td>
			<td class="style6">
				<asp:TextBox runat="server" ID="txtFechaPago" Width="75px" Visible="False" />
				<asp:CompareValidator runat="server" ID="cvFechaInicial" ControlToValidate="txtFechaPago" Display="Dynamic" 
				 ErrorMessage="* Fecha Invalida" Operator="DataTypeCheck" Type="Date" />
				<asp:CalendarExtender runat="server" ID="ceFechaInicial" Animated="False" PopupButtonID="txtFechaPago" TargetControlID="txtFechaPago" Format="dd/MM/yyyy" />

			</td>
            <td style="text-align:right">
                Tipo de Documento
            </td>
            <td>
            <asp:DropDownList runat="server" ID="ddlTipoDocumento" AutoPostBack="True" 
                    onselectedindexchanged="ddlTipoDocumento_SelectedIndexChanged">
                <asp:ListItem runat="server" Text="Factura" Value="Ingreso" Selected="True" />
                <asp:ListItem runat="server" Text="Nota de Crédito" Value="Egreso" />
               <%-- <asp:ListItem runat="server" Text="Recibo de Donativo" Value="Donativo" />--%>
            </asp:DropDownList>
            </td>
			
		</tr>
		<tr>
			<td style="text-align:right">Serie:</td>
			<td class="style7">
				<asp:TextBox runat="server" ID="txtSerie" Width="75px" MaxLength="25" />
			</td>
			<td style="text-align: right">Folio:</td>
			<td class="style6"><asp:TextBox runat="server" ID="txtFolio" Width="50px" Enabled="False" /></td>
			<td style="text-align: right">Moneda:</td>
			<td>
				<asp:DropDownList runat="server" ID="ddlMoneda" onselectedindexchanged="ddlMoneda_SelectedIndexChanged">
					<asp:ListItem Value="1" Text="MXN" />
					<asp:ListItem Value="2" Text="USD" />
                    <asp:ListItem Value="3" Text="EUR" />
                    
                            <asp:ListItem Value="4" Text="JPY" />
				</asp:DropDownList>
			</td>
			<td style="text-align: right"><asp:Label runat="server" ID="lblTipoCambio" Text="Tipo Cambio USD:" Visible="False" /></td>
			<td><asp:TextBox runat="server" ID="txtTipoCambio" Visible="False" Width="50px" /></td>
			<td><%--Días Revisión--%></td>
			<td>
				<asp:TextBox runat="server" ID="txtDiasRevision" Width="50px"  Visible="false"/>
				<asp:CompareValidator runat="server" ID="cvTxtDiasRevision" ControlToValidate="txtDiasRevision" Display="Dynamic"
				 ErrorMessage="* Dato invalido" Type="Integer" Operator="DataTypeCheck"  />
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
		<table width="100%" style="text-align:left">
                <tr runat="server" id="trDonativo" visible="False">
                    <td class="style9" style="text-align:right" >
                        N. de autorización del Donativo:
                    </td>
                    <td>    <asp:TextBox runat="server" ID="txtDonatAutorizacion"></asp:TextBox>
                    
                    </td>
                    <td class="style8" >
                        Fecha de autorización del donativo:
                        </td>
                    <td>
                        <asp:TextBox ID="txtDonatFechautorizacion" runat="server"></asp:TextBox>
                        <asp:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" 
                            PopupButtonID="txtDonatFechautorizacion" 
                            TargetControlID="txtDonatFechautorizacion" />
                    </td>
                </tr>
                <tr> 
        <td class="style9"></td>
       
        <td class="style5">&nbsp;</td>
        <td class="style8"></td>
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
                    TextMode="MultiLine" Width="100%" Height="72px" />  <br />
                 <br />
                Numero de Cuenta (Últimos 4 dígitos) 
                <asp:TextBox runat="server" ID="txtCuenta"  Width="60%" /><br />
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
                <tr>
                    <td style="text-align:right" class="style9">
                        Sucursal
                    </td>
                    <td>
                        <asp:DropDownList runat="server" ID="ddlSucursales" AppendDataBoundItems="True" DataValueField="LugarExpedicion"
                            DataTextField="Nombre" />
                    </td>
                    <td style="text-align:right" class="style8" >
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Observaciones
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtProyecto" Width="326px" />
                    </td>
                </tr>
                <tr>
                    <td style="text-align:right" class="style9">
                        Forma de Pago
                    </td>
                    <td width="25%">
                        <asp:DropDownList runat="server" ID="ddlCondicionesPago" AutoPostBack="True" OnSelectedIndexChanged="ddlCondicionesPago_SelectedIndexChanged">
                            <asp:ListItem runat="server" Text="Pago en una sola exhibición" Value="Pago en una sola exhibición"></asp:ListItem>
                            <asp:ListItem runat="server" Text="En parcialidades" Value="En parcialidades"></asp:ListItem>
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
    <div ID="divViasConcesionadas" runat="server"  class="page1" Visible="True"  >
        <h1>Firmas</h1>
        <center>
        <table width="100%">
            <tr>
                <td>Seleccionar para vista</td>
                <td>Título de la firma</td>
                <td>Nombre</td>
                <td>Puesto</td>
                <td>Area</td>
            </tr>
            <tr>
                <td> <asp:CheckBox ID="cbVoBo" runat="server"/></td>
                <td> <asp:TextBox runat="server" ID="txtTituloVoBo"></asp:TextBox></td>
                <td> <asp:TextBox runat="server" ID="txtVoBoNombre"></asp:TextBox></td>
                <td> <asp:TextBox runat="server" ID="txtVoBoPuesto"></asp:TextBox></td>
                <td> <asp:TextBox runat="server" ID="txtVoBoArea"></asp:TextBox></td>
            </tr>
            <tr>
                <td> <asp:CheckBox ID="cbAutorizo" runat="server"/></td>
                <td> <asp:TextBox runat="server" ID="txtAutorizoTitulo"></asp:TextBox></td>
                <td> <asp:TextBox runat="server" ID="txtAutorizoNombre"></asp:TextBox></td>
                <td> <asp:TextBox runat="server" ID="txtAutorizoPuesto"></asp:TextBox></td>
                <td> <asp:TextBox runat="server" ID="txtAutorizoArea"></asp:TextBox></td>
            </tr>
             <tr>
                <td> <asp:CheckBox ID="cbRecibi" runat="server"/></td>
                <td> <asp:TextBox runat="server" ID="txtRecibiTitulo"></asp:TextBox></td>
                <td> <asp:TextBox runat="server" ID="txtRecibiNombre"></asp:TextBox></td>
                <td> <asp:TextBox runat="server" ID="txtRecibiPuesto"></asp:TextBox></td>
                <td> <asp:TextBox runat="server" ID="txtRecibiArea"></asp:TextBox></td>
            </tr>
            <tr>
                <td> <asp:CheckBox ID="cbAgregado" runat="server"/></td>
                <td> <asp:TextBox runat="server" ID="txtAgregadoTitulo"></asp:TextBox></td>
                <td> <asp:TextBox runat="server" ID="txtAgregadoNombre"></asp:TextBox></td>
                <td> <asp:TextBox runat="server" ID="txtAgregadoPuesto"></asp:TextBox></td>
                <td> <asp:TextBox runat="server" ID="txtAgregadoArea"></asp:TextBox></td>
            </tr>
            <tr>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
        </table>
        </center>
    </div>
	<h1 style="text-align: center">Conceptos</h1>
	<table width="100%"  class="page1">
		<tr>
			<td style="text-align: right;" class="style15">
				
		<caption>
            <tr>
            <td class="style14">Cantidad</td>
                <td>
                       <asp:TextBox ID="txtCantidad" runat="server" />
                    <asp:CompareValidator ID="cvCantidad" runat="server" 
                        ControlToValidate="txtCantidad" Display="Dynamic" 
                        ErrorMessage="* Cantidad Invalida" Operator="DataTypeCheck" Type="Double" 
                        ValidationGroup="AgregarConcepto" />
                    <asp:RequiredFieldValidator ID="rfvCantidad" runat="server" 
                        ControlToValidate="txtCantidad" Display="Dynamic" ErrorMessage="* Requerido" 
                        ValidationGroup="AgregarConcepto" />
                </td>
                <td style="text-align: right;" class="style13">
                    Unidad :</td>
                <td>
                    <asp:TextBox ID="txtUnidad" runat="server" />
                    &nbsp;
                    <asp:RequiredFieldValidator ID="rfvUnidad" runat="server" 
                        ControlToValidate="txtUnidad" Display="Dynamic" ErrorMessage="* Requerido" 
                        ValidationGroup="AgregarConcepto" />
                </td>
            </tr>
            <tr>
                <td class="style15" style="text-align:right">
                    Código
                </td>
                <td>
                    <asp:TextBox ID="txtCodigo" runat="server" />
                </td>
                <td style="text-align: right;" class="style13">
                    Precio Unitario: $
                </td>
                <td>
                    <asp:TextBox ID="txtPrecio" runat="server" />
                    <asp:RequiredFieldValidator ID="rfvPrecio" runat="server" 
                        ControlToValidate="txtPrecio" Display="Dynamic" ErrorMessage="* Requerido" 
                        ValidationGroup="AgregarConcepto" />
                    &nbsp;
                    <asp:CompareValidator ID="cvPrecio" runat="server" 
                        ControlToValidate="txtPrecio" Display="Dynamic" 
                        ErrorMessage="* Precio invalido" Operator="DataTypeCheck" Type="Double" 
                        ValidationGroup="AgregarConcepto" />
                </td>
            </tr>
            <tr>
                <td class="style15" style="text-align: right;">
                    <asp:CheckBox ID="cbIva" runat="server" AutoPostBack="True" Checked="True" 
                        Text="I.V.A." />
                </td>
                <td style="text-align: left;">
                    <asp:TextBox ID="txtIvaConcepto" runat="server" Text="16" />
                    %
                    <asp:CompareValidator ID="CompareValidator3" runat="server" 
                        ControlToValidate="txtIvaConcepto" Display="Dynamic" 
                        ErrorMessage="* Dato Inválido" Operator="DataTypeCheck" Type="Integer" 
                        ValidationGroup="AgregarConcepto" />
                </td>
                <td style="text-align: right;" class="style13">
                </td>
                <td>
                    <asp:TextBox ID="txtCuentaPredial" runat="server" Visible="False" />
                </td>
                <%--<td style="text-align: right">
				<asp:CheckBox runat="server" ID="cbRetencion" Text="Retención"/>
			</td>
			<td style="text-align: left">
				<asp:TextBox runat="server" ID="txtRetencion" Text="4" /> %
				<asp:CompareValidator ID="CompareValidator4" runat="server" ControlToValidate="txtRetencion" Display="Dynamic" 
				ValidationGroup="AgregarConcepto" ErrorMessage="* Dato Inválido" Operator="DataTypeCheck" Type="Integer" />  
			</td>--%>
            </tr>
            <tr>
                <td class="style15" style="text-align: right;">
                    Descripción
                </td>
                <td colspan="3">
                    <asp:TextBox ID="txtDescripcion" runat="server" TextMode="MultiLine" 
                        Width="68%" />
                    <asp:RequiredFieldValidator ID="rfvDescripcion" runat="server" 
                        ControlToValidate="txtDescripcion" Display="Dynamic" ErrorMessage="* Requerido" 
                        ValidationGroup="AgregarConcepto" />
                </td>
            </tr>
            <tr>
                <td class="style15" style="text-align: right;">
                    Observaciones
                </td>
                <td>
                    <asp:TextBox ID="txtDetalles" runat="server" TextMode="MultiLine" Width="90%" />
                </td>
                <td class="style13">
                    <asp:Button ID="btnAgregar" runat="server" class="btn btn-primary" 
                        onclick="btnAgregar_Click" Text="Agregar Concepto" 
                        ValidationGroup="AgregarConcepto" />
                </td>
                <td>
                    <asp:Button ID="btnBuscar" runat="server" class="btn btn-primary" 
                        onclick="btnBuscar_Click" Text="Buscar" Width="80px" />
                    <asp:HiddenField ID="txtIdProducto" runat="server" />
                   
                </td>
                
            </tr>
            </td>
            <tr>
              <td colspan="4">
             <div style="height: 100%; overflow-y: scroll" >
                <asp:GridView ID="gvDetalles" runat="server" CssClass="style124" AutoGenerateColumns="False" 
                    onrowcommand="gvDetalles_RowCommand" ShowHeaderWhenEmpty="True" Width="100%">
                    <Columns>
                        <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" 
                            ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField DataField="Unidad" HeaderText="Unidad" 
                            ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField DataField="Codigo" HeaderText="Código" 
                            ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField DataField="Descripcion" HeaderText="Descripción" />
                        <asp:BoundField DataField="Descripcion2" HeaderText="Observaciones" />
                        <asp:BoundField DataField="CuentaPredial" HeaderText="Cuenta Predial" />
                        <asp:BoundField DataField="Precio" DataFormatString="{0:C}" 
                            HeaderText="Precio Unitario" ItemStyle-HorizontalAlign="left" />
                        <asp:BoundField DataField="PorcentajeIva" HeaderText="%I.V.A." 
                            ItemStyle-HorizontalAlign="left" />
                        <asp:BoundField DataField="ImporteIva" DataFormatString="{0:C}" 
                            HeaderText="I.V.A." ItemStyle-HorizontalAlign="left" />
                        <%--<asp:BoundField HeaderText="%Retención" DataField="PorcentajeRetencionIva" ItemStyle-HorizontalAlign="Right" />
				<asp:BoundField HeaderText="Retención" DataField="RetencionIva" DataFormatString="{0:C}" ItemStyle-HorizontalAlign="Right" />--%>
                        <asp:BoundField DataField="TotalPartida" DataFormatString="{0:C}" 
                            HeaderText="Total" ItemStyle-HorizontalAlign="left" />
                        <asp:ButtonField CommandName="Editar" ItemStyle-HorizontalAlign="Center" 
                            Text="Editar" Visible="False" />
                        <asp:ButtonField CommandName="EliminarConcepto" 
                            ItemStyle-HorizontalAlign="Center" Text="Eliminar" Visible="False" />
                    </Columns>
                </asp:GridView>
            </div>
             </td>
            </tr>
            <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            
            </tr>
           </table>
            
            <br /><br />
            <asp:UpdateProgress ID="UpdateProgress1" runat="server" 
                AssociatedUpdatePanelID="up1">
                <ProgressTemplate>
                    <div align="center">
                        <asp:Image ID="Image1" runat="server" ImageUrl="images/ajax-loader.gif" />
                        <br />
                        CFDI en proceso ..
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <asp:Label ID="lblError" runat="server" ForeColor="Red" />
            <div style="float: right">
                <table style="text-align:right;">
                    <tr style="width: 150px">
                        <td>
                            Subtotal:</td>
                        <td>
                            <asp:Label ID="lblSubtotal" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            I.V.A.</td>
                        <td>
                            <asp:Label ID="lblIva" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Total</td>
                        <td>
                            <asp:Label ID="lblTotal" runat="server" />
                        </td>
                    </tr>
                </table>
            </div>
            <div style="clear: both">
            </div>
            <p align="right">
                <asp:Button ID="btnLimpiar" runat="server" class="btn btn-primary" 
                    onclick="btnLimpiar_Click" Text="Limpiar" />
                &nbsp;&nbsp;&nbsp;
                <asp:Button ID="BtnVistaPrevia" runat="server" class="btn btn-primary" 
                    onclick="btnGenerarPreview_Click" Text="Vista Previa" 
                    ValidationGroup="CrearFactura" />
                &nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnGenerarFactura" runat="server" class="btn btn-primary" 
                    onclick="btnGenerarFactura_Click" Text="Generar Factura" 
                    ValidationGroup="CrearFactura" />
                <asp:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" 
                    ConfirmText="Confirma que deseas generar el comprobante" 
                    TargetControlID="btnGenerarFactura" />
            </p>
            
	</ContentTemplate>
	<Triggers>
		<asp:PostBackTrigger ControlID="btnLimpiar" />
		<asp:PostBackTrigger ControlID="gvDetalles" />
		<asp:PostBackTrigger ControlID="BtnVistaPrevia"/>
        <asp:PostBackTrigger ControlID="btnBuscar"/>
        
	</Triggers>
	</asp:UpdatePanel>
	<asp:ModalPopupExtender runat="server" ID="mpeBuscarConcepto" TargetControlID="btnConceptoDummy" BackgroundCssClass="mpeBack"
	 CancelControlID="btnCerrarConcepto" PopupControlID="pnlBuscarConcepto" />
	<asp:Panel runat="server" ID="pnlBuscarConcepto" style="text-align: center;" Width="800px" BackColor="White">
		<h1>Buscar Conceptos</h1>
		<p>
			<asp:TextBox runat="server" ID="txtConceptoBusqueda" Width="250px" />&nbsp;&nbsp;&nbsp;
			<asp:Button runat="server" ID="btnBuscarConcepto" Text="Buscar" onclick="btnBuscarConcepto_Click" class="btn btn-primary"/>
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
		<asp:Button runat="server" ID="btnCerrarConcepto" Text="Cancelar" class="btn btn-primary" />
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
				<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="* Requerido" Display="Dynamic"
				 ControlToValidate="txtCantidadEdita" ValidationGroup="Concepto" />
				<asp:CompareValidator runat="server" ID="CompareValidator1" ControlToValidate="txtCantidadEdita"
                  Display="Dynamic" Type="Double" ErrorMessage="* Cantidad Invalida" ValidationGroup="Concepto"
                  Operator="DataTypeCheck" />
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
        <tr>
            <td>
                Cuenta Predial:
            </td>
            <td style="text-align: left;">
                <asp:TextBox runat="server" ID="txtCuentaPredialEdita" />
            </td>
        </tr>
	</table>
	<div align="right">
		<asp:Button runat="server" ID="btnGuardar" Text="Guardar" ValidationGroup="Concepto" onclick="btnGuardar_Click" class="btn btn-primary"/>
        &nbsp;&nbsp;&nbsp;
		<asp:Button runat="server" ID="btnCancelar" Text="Cancelar" CausesValidation="False" class="btn btn-primary"/>
	</div>
	<br />
	</asp:Panel>
	<asp:Button runat="server" ID="btnEditarDummy" style="display: none;" class="btn btn-primary"/>
</asp:Content>
