<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="wfrAnticiposFirmasCustom.aspx.cs" Inherits="GafLookPaid.wfrAnticiposFirmasCustom" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

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
            width: 15%;
        }
        .style3
        {
            text-align: left;
        }
        .style5
        {
            text-align: left;
        }
        .style9
        {
            width: 29%;
        }
        .style11
        {
            width: 20%;
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
        .style127
        {
            width: 13%;
        }
        .style128
        {
            width: 511px;
        }
        .style129
        {
            width: 10%;
        }
        .style130
        {
            width: 468px;
        }
        .style131
        {
            width: 7%;
        }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

	
	<h1>Generar CFDI ANTICIPO Y FIRMAS</h1>
	<asp:UpdatePanel ID="up1" runat="server" UpdateMode="Conditional">
		<ContentTemplate>
	<p>
		Empresa:&nbsp;<asp:DropDownList runat="server" ID="ddlEmpresa" AutoPostBack="True"
		 DataTextField="RazonSocial" DataValueField="idEmpresa" onselectedindexchanged="ddlEmpresa_SelectedIndexChanged" />
	</p>
	<table width="100%">
                <tr>
                    <td style="text-align: right">
                        Status Factura:
                    </td>
                    <td>
                        <asp:DropDownList runat="server" ID="ddlStatusFactura" AutoPostBack="True" OnSelectedIndexChanged="ddlStatusFactura_SelectedIndexChanged">
                            <asp:ListItem Value="0" Text="Pendiente"></asp:ListItem>
                            <asp:ListItem Value="1" Text="Pagada"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td style="text-align: right">
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
                    <td style="text-align: right">
                        Serie:
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtSerie" Width="75px" MaxLength="25" />
                    </td>
                    <td style="text-align: right">
                        Folio:
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtFolio" Width="50px" Enabled="False" />
                    </td>
                    <td style="text-align: right">
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
                    <td style="text-align: right">
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
            </table>
	<p>
		Cliente:&nbsp;<asp:DropDownList runat="server" ID="ddlClientes" AutoPostBack="True" 
		 DataTextField="RazonSocial" DataValueField="idCliente" onselectedindexchanged="ddlClientes_SelectedIndexChanged" /><br />
		<br/>
		<asp:TextBox runat="server" TextMode="MultiLine" ID="txtRazonSocial" Width="500px" CssClass="page1" Height="75px" Enabled="False" />

	</p>
	<div ID="divViasConcesionadas" runat="server" Visible="True" >
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
        </table>
        </center>
    </div>
	<table width="95%">
		<tr>
			<td colspan="4" style="text-align: center;">
				<h1> Datos de la Factura</h1>
			</td>
		</tr>
        <tr> 
        <td class="style11"></td>
        <td class="style9"></td>
        <td></td>
        <td></td>
        
         </tr>
		<tr >
			<td style="text-align: right; vertical-align:top;" class="style11">
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
			<td style="text-align: right;" class="style11">
				Sucursal
			</td>
			<td class="style9" >
				<asp:DropDownList runat="server" ID="ddlSucursales" AppendDataBoundItems="True" DataValueField="LugarExpedicion"
					DataTextField="Nombre" />			
			</td>
			<td style="text-align: right;">
				Observaciones
			</td>
			<td >
				<asp:TextBox runat="server" ID="txtProyecto" Width="100%" />
			</td>
		</tr>
		<tr>
    <td style="text-align: right;" class="style11">
		Forma de Pago
	</td>
	<td class="style9">
		<asp:DropDownList runat="server" ID="ddlCondicionesPago" AutoPostBack="True" 
            onselectedindexchanged="ddlCondicionesPago_SelectedIndexChanged">
		    <asp:ListItem runat="server" Text="Pago en una sola exhibición" Value="Pago en una sola exhibición"></asp:ListItem>
            <asp:ListItem runat="server" Text="En parcialidades" Value="En parcialidades"></asp:ListItem>
		</asp:DropDownList>
	</td>
    <td runat="server" ID="tdAnticipoLbl" style="text-align: right">
				&nbsp;</td>
			<td runat="server" ID="tdAnticipoTxt" >
				<asp:TextBox runat="server" ID="txtAnticipo" Visible="False" />
				 <asp:CompareValidator runat="server" ID="cvAnticipo" ControlToValidate="txtAnticipo" Display="Dynamic"
					ErrorMessage="* Monto inválido" Operator="DataTypeCheck" Type="Currency" ValidationGroup="CrearFactura" />	
					<asp:Button runat="server" ID="btnActualizar" Text="Calcular Totales" class="btn btn-primary" 
					onclick="btnActualizar_Click" Visible="False"/>
			</td>
</tr>
<tr runat="server" ID="trAtenogenes">
    
    <td class="style11">
        Texto:
        <asp:TextBox runat="server" ID="txtEstimacionTexto" TextMode="MultiLine" 
            Width="80%" Height="42px" />
	&nbsp;</td>
    
    <td class="style9">
        Importe
        <asp:TextBox runat="server" ID="txtImporteEstimacion" />
        <asp:CompareValidator runat="server" ID="CompareValidator6" ControlToValidate="txtImporteEstimacion" Display="Dynamic"
					ErrorMessage="* Monto inválido" Operator="DataTypeCheck" Type="Currency" ValidationGroup="CrearFactura" />	
    </td>
    <td colspan="2">
        <table>
            <tr>
                <td>
                    ProcentajedeAmortización<asp:TextBox ID="txtPorcentajeAnticipo" runat="server" 
                        TextMode="MultiLine" Width="95%"></asp:TextBox>
&nbsp;</td>
                
                <td>
                    <asp:TextBox runat="server" ID="txtAmortizacionAnticipo" />
        <asp:CompareValidator runat="server" ID="CompareValidator7" ControlToValidate="txtAmortizacionAnticipo" Display="Dynamic"
					ErrorMessage="* Monto inválido" Operator="DataTypeCheck" Type="Currency" ValidationGroup="CrearFactura" />	
                </td>
            </tr>
        </table>
		

        
     

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
    
    
    

	<asp:TabContainer ID="tabContainerAduana" runat="server" Width="100%" 
		ActiveTabIndex="0">
	    
		<asp:TabPanel ID="tabGeneral" HeaderText="Datos Generales" runat="server" CssClass="page1">
			<HeaderTemplate>
				Conceptos
			</HeaderTemplate>
			<ContentTemplate>
				<div align="center"><h1>Conceptos</h1></div>
	<asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
		<ContentTemplate>
	
    <asp:panel ID="Panel1" runat="server" Width="100%" ScrollBars="Horizontal">
                                <div style="width: 100%; overflow: auto">
	
		<table width="95%" ><tr><td style="text-align: right;" class="style127">Cantidad</td>
            <td class="style130" ><asp:TextBox runat="server" ID="txtCantidad" /><asp:CompareValidator runat="server" ID="cvCantidad" ControlToValidate="txtCantidad" Display="Dynamic" Type="Double"
				 ErrorMessage="* Cantidad Invalida" ValidationGroup="AgregarConcepto" Operator="DataTypeCheck" /><asp:RequiredFieldValidator runat="server" ID="rfvCantidad" ControlToValidate="txtCantidad" Display="Dynamic"
				 ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" /></td>
            <td style="text-align: right;" class="style131">Unidad </td><td ><asp:TextBox runat="server" ID="txtUnidad"  />&nbsp; <asp:RequiredFieldValidator runat="server" ID="rfvUnidad" ControlToValidate="txtUnidad" Display="Dynamic"
		 ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" /></td></tr><tr>
                <td style="text-align: right;" class="style127">
                Código:</td><td class="style130" ><asp:TextBox runat="server" ID="txtCodigo" /></td>
                <td style="text-align: right;" class="style131">Precio Unitario: $ </td><td ><asp:TextBox runat="server" ID="txtPrecio" /><asp:RequiredFieldValidator runat="server" ID="rfvPrecio" ControlToValidate="txtPrecio" Display="Dynamic"
		 ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" />&nbsp; 
                <asp:CompareValidator runat="server" ID="cvPrecio"  
                    ControlToValidate="txtPrecio" Display="Dynamic"
		 ErrorMessage="* Precio Inválido" Type="Double" Operator="DataTypeCheck" 
                    ValidationGroup="AgregarConcepto" /></td></tr><tr>
                <td style="text-align: right;" class="style127"><asp:CheckBox runat="server" ID="cbIva" Text="I.V.A." AutoPostBack="True" Checked="True"/></td>
                <td style="text-align: left;" class="style130"><asp:TextBox runat="server" ID="txtIvaConcepto" Text="16"/>% <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="txtIvaConcepto" Display="Dynamic" 
				ValidationGroup="AgregarConcepto" ErrorMessage="* Dato Inválido" Operator="DataTypeCheck" Type="Integer" /></td>
                <td style="text-align: right" class="style131">
                    &nbsp;</td><td style="text-align: left">&nbsp;</td></tr><tr>
            <td style="text-align: right;" class="style127">Descripción </td><td colspan="3"><asp:TextBox runat="server" ID="txtDescripcion" Width="80%" TextMode="MultiLine" /><asp:RequiredFieldValidator runat="server" ID="rfvDescripcion" ControlToValidate="txtDescripcion" Display="Dynamic"
				 ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" /></td></tr>
                 <tr><td style="text-align: right;" class="style127"></td><td class="style130" ></td>
                     <td class="style131" ><asp:Button runat="server" ID="btnAgregar" Text="Agregar Concepto" ValidationGroup="AgregarConcepto" onclick="btnAgregar_Click" class="btn btn-primary"/></td><td>
                <asp:Button runat="server" ID="btnBuscar" Text="Buscar" 
                    onclick="btnBuscar_Click" class="btn btn-primary" Width="80px"/><asp:HiddenField ID="txtIdProducto" runat="server" /></td></tr>
                    
                    </table><br />
        
		<asp:GridView runat="server" ID="gvDetalles" AutoGenerateColumns="False"  CssClass="style124" 
			Width="100%" ShowHeaderWhenEmpty="True" onrowcommand="gvDetalles_RowCommand" 
            ClientIDMode="Static">
			<Columns>
				<asp:BoundField HeaderText="Cantidad" DataField="Cantidad" >
				<ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
				<asp:BoundField HeaderText="Unidad" DataField="Unidad" >
				<ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
				<asp:BoundField HeaderText="Código" DataField="Codigo" >
				<ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
				<asp:BoundField HeaderText="Descripción" DataField="Descripcion" />
				<asp:BoundField HeaderText="Precio Unitario" DataField="Precio" 
                    DataFormatString="{0:C}" >
				<ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
				<asp:BoundField HeaderText="%I.V.A." DataField="PorcentajeIva" >
				<ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
				<asp:BoundField HeaderText="I.V.A" DataField="ImporteIva" 
                    DataFormatString="{0:C}" >
				
				<ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
				
				<asp:BoundField HeaderText="Retención" DataField="RetencionIva" 
                    DataFormatString="{0:C}" >
				<ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
				<asp:BoundField HeaderText="Total" DataField="TotalPartida" 
                    DataFormatString="{0:C}" >
				<ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
				<asp:ButtonField Text="Editar" CommandName="Editar" Visible="False">
				<ItemStyle HorizontalAlign="Center" />
                </asp:ButtonField>
				<asp:ButtonField Text="Eliminar" CommandName="EliminarConcepto" 
                    Visible="False" >
			    <ItemStyle HorizontalAlign="Center" />
                </asp:ButtonField>
			</Columns>
		</asp:GridView>
		</div>
        </asp:panel><br />

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
		<asp:Button runat="server" ID="btnGuardar" Text="Guardar"  class="btn btn-primary" 
			ValidationGroup="Concepto" onclick="btnGuardar_Click" style="width: 68px"
			 />&nbsp;&nbsp;&nbsp;
		<asp:Button runat="server" ID="btnCancelar" Text="Cancelar" 
			CausesValidation="False" class="btn btn-primary" />
	</div>
	<br />
	</asp:Panel>
	<asp:Button runat="server" ID="btnEditarDummy" style="display: none;" class="btn btn-primary" />

	</ContentTemplate>
       <Triggers>
              <asp:AsyncPostBackTrigger controlid="btnAgregar" eventname="Click" />
               <asp:AsyncPostBackTrigger controlid="btnBuscar" eventname="Click" />
              <asp:AsyncPostBackTrigger ControlID="gvDetalles" />
        </Triggers>
        
    </asp:UpdatePanel>

			</ContentTemplate>
		</asp:TabPanel>
        <asp:TabPanel HeaderText="Addenda" runat="server" ID="datosAddenda" CssClass="page1">
			<HeaderTemplate>
                Impuestos
            </HeaderTemplate>
			<ContentTemplate>
				<div align="center">
		
	   <div id="Complementos" style="width:100%" runat="server" >
       <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
		<ContentTemplate>
         <table width="100%">
<tr>
<td colspan="3"  style="text-align: left; font-weight: 700;" >

<div align="center"><h1>Impuestos Locales</h1></div>
   </td>
</tr>
<tr>
<td class="style2" style="text-align: right"> 
    <asp:Label ID="Label3" runat="server" ForeColor="Red" Text="*"></asp:Label>
    Impuesto Local:
    </td><td class="style3">
        <asp:DropDownList ID="ddlImpuestoLocal" runat="server"
     ToolTip="Nodo opcional para la expresión de los impuestos locales"
    >
            
    <asp:ListItem Value="RetencionesLocales">RetencionesLocales</asp:ListItem>
    <asp:ListItem Value="TrasladosLocales">TrasladosLocales</asp:ListItem>
     
       
    </asp:DropDownList>
        <br />
       
      </td>
    
<td style="text-align: right" > 
    <asp:Label ID="Label4" runat="server" ForeColor="Red" Text="*"></asp:Label>
    Nombre Impuesto:</td><td class="style5">
        <asp:TextBox ID="txtImpLoc" runat="server"
         ToolTip="Nombre del impuesto local" 
         Width="300px"></asp:TextBox><br />
          <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator5" ErrorMessage="Requerido" Display="Dynamic"
              ControlToValidate="txtImpLoc" ValidationGroup="AgregarImpuesto"></asp:RequiredFieldValidator>

      
    </td>
   
<td style="text-align: right" > 
  </td>
   
</tr>
<tr>
<td class="style2" style="text-align: right"> 
    
    <asp:Label ID="Label9" runat="server" ForeColor="Red" Text="*"></asp:Label>
    Importe:<br /></td>
<td style="text-align: left" >
    <asp:TextBox ID="txtImporte" runat="server" 
    ToolTip="Monto del impuesto local" 
    Width="100px"></asp:TextBox><br />
        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator6" ErrorMessage="Requerido" Display="Dynamic"
              ControlToValidate="txtImporte" ValidationGroup="AgregarImpuesto"></asp:RequiredFieldValidator>

        <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server" FilterType="Custom, Numbers"
    ValidChars="." TargetControlID="txtImporte" Enabled="True" />

    <asp:RegularExpressionValidator id="RegularExpressionValidator3" runat="server" Display="Dynamic"
    ControlToValidate="txtImporte" ErrorMessage="Dato invalido" ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" ValidationGroup="AgregarImpuesto"/>

    </td>
<td  style="text-align: right"> 
      <asp:Label ID="Label8" runat="server" ForeColor="Red" Text="*"></asp:Label>
    Tasa:<br /></td>
<td style="text-align: left">
    <asp:TextBox ID="txtTasa"  runat="server"
    ToolTip="Porcentaje del impuesto local" 
    class="prueba" Width="56px" ></asp:TextBox>
    
         <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator7" ErrorMessage="Requerido" Display="Dynamic"
              ControlToValidate="txtTasa" ValidationGroup="AgregarImpuesto"></asp:RequiredFieldValidator>

     <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender3" runat="server" FilterType="Custom, Numbers"
    ValidChars="." TargetControlID="txtTasa" Enabled="True" />
 <asp:RegularExpressionValidator id="RegularExpressionValidator4" runat="server" Display="Dynamic"
    ControlToValidate="txtTasa" ErrorMessage="Dato invalido" ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" ValidationGroup="AgregarImpuesto"/>

    <br />
    
</td>


<td style="text-align: left">
    <br />
     
    </td>
</tr>
<tr>
<td colspan="4" style="text-align: right">
<asp:Button runat="server" ID="btnAgregarImp" Text="Agregar Impuesto" 
        ValidationGroup="AgregarImpuesto"  class="btn btn-primary" 
        onclick="btnAgregarImp_Click" />
</td>
</tr>
<tr>
<td colspan="5">
<asp:panel ID="Panel2" runat="server" Width="100%" ScrollBars="Horizontal">
                                <div style="width: 100%; overflow: auto">
<asp:GridView runat="server" ID="gvImpuestosLocales" AutoGenerateColumns="False"  CssClass="style124" 
			Width="100%" ShowHeaderWhenEmpty="True" onrowcommand="gvImpuestosLocales_RowCommand">
			<Columns>
				<asp:BoundField HeaderText="ImpuestoLocal" DataField="ImpuestosLocales" >
				<ItemStyle HorizontalAlign="Center" Width="10%" />
                </asp:BoundField>
				<asp:BoundField HeaderText="Nombre Impuesto" DataField="ImpLoc" >
				<ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
				<asp:BoundField HeaderText="Tasa" DataField="Tasa" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Importe" DataField="Importe" 
                    DataFormatString="{0:C}" >
               			
				<ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
               			
				<asp:ButtonField Text="Eliminar"  CommandName="EliminarConcepto" 
                    Visible="False" ValidationGroup="AgregarImpuesto"  >
			    <ItemStyle HorizontalAlign="Center" />
                </asp:ButtonField>
			</Columns>
		</asp:GridView>
        </div>
        </asp:panel>
</td>
</tr>
</table>



       </ContentTemplate>
       <Triggers>
              <asp:AsyncPostBackTrigger controlid="btnAgregarImp" eventname="Click" />
              <asp:AsyncPostBackTrigger ControlID="gvImpuestosLocales" />
        </Triggers>
        
        </asp:UpdatePanel>
      </div>
	</div>
	

			</ContentTemplate>
		</asp:TabPanel>
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

     <asp:UpdatePanel ID="UpdateCantidades" runat="server" UpdateMode="Conditional">
		<ContentTemplate>
	<table style="text-align:right;" >
	    <tr runat="server" ID="trEstimacion" style="width: 150px">
			<td><asp:Label runat="server" ID="lblTextoAmortizacion"></asp:Label></td>
			<td><asp:Label runat="server" ID="lblEstimacion" /></td>
		</tr>
        <tr>
			<td>Anticipo:</td>
			<td><asp:Label runat="server" ID="lblAnticipo" /></td>
	
		<tr style="width: 150px">
			<td>Subtotal1:</td>
			<td><asp:Label runat="server" ID="lblSubtotal" /></td>
		</tr>
		<tr>
			<td>I.V.A.:</td>
			<td><asp:Label runat="server" ID="lblIva" /></td>
		</tr>
		<tr>
			<td>Subtotal2:</td>
			<td><asp:Label runat="server" ID="lblTotal" /></td>
		</tr>
        <tr>
				<td>&nbsp;Retenciónes Locales:</td>
				<td><asp:Label runat="server" ID="lblRetencionLocal" /></td>
			</tr>
             <tr>
				<td>Traslado Locales:</td>
				<td><asp:Label runat="server" ID="lblTrasladoLocal" /></td>
			</tr>
			</tr>
			
			<tr>
			<td><asp:TextBox runat="server" ID="txtNeto"></asp:TextBox></td>
			<td><asp:Label runat="server" ID="lblGranTotal" /></td>
		</tr>
		<tr>
			<td colspan="2"></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		
	</table>
    </ContentTemplate>
    </asp:UpdatePanel>

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
			<asp:Button runat="server" ID="btnBuscarConcepto" Text="Buscar" class="btn btn-primary"  onclick="btnBuscarConcepto_Click" />
		</p>
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
		<br />
		<%--<asp:Button runat="server" ID="btnSeleccionarConcepto" Text="Seleccionar" onclick="btnSeleccionarConcepto_Click" />&nbsp;&nbsp;--%>
		<asp:Button runat="server" ID="btnCerrarConcepto" Text="Cancelar" class="btn btn-primary" />
	</asp:Panel>
	<asp:Button runat="server" ID="btnConceptoDummy" style="display: none;" class="btn btn-primary" />

	
</asp:Content>
