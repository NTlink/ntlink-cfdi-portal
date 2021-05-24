<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ASONIOSCOC32.aspx.cs" Inherits="GafLookPaid.ASONIOSCOC32" %>
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
        .style3
        {
            width: 102px;
            text-align: right;
        }
        .style5
        {
            width: 139px;
            text-align: left;
        }
        .style8
        {
            text-align: left;
        }
        .style10
        {
            width: 139px;
        }
        .style12
        {
            width: 100px;
        }
        .style13
        {
            width: 196px;
        }
        .style14
        {
            width: 97px;
            text-align: right;
        }
        .style15
        {
            width: 97px;
        }
        .style16
        {
            width: 100px;
            text-align: right;
        }
        .style17
        {
            width: 16%;
        }
        .style18
        {
            width: 390px;
        }
        .style19
        {
            width: 31%;
        }
        .style20
        {
            width: 31%;
            color: #000099;
        }
        .style21
        {
            width: 155px;
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
       
    }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

	<h1>Generar CFDI ASONIOSCOC</h1>
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
                        <asp:TextBox runat="server" ID="txtSerie" Width="75px" />
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
		<asp:TextBox runat="server" TextMode="MultiLine" ID="txtRazonSocial" Width="500px"  CssClass="page1" Height="75px" Enabled="False" />

	</p>
	
    
	<table width="95%">
		<tr>
			<td colspan="4" style="text-align: center;">
				<h1> Datos de la Factura</h1>
			</td>
		</tr>
		<tr> 
        <td class="style17"></td>
        <td class="style20">&nbsp;</td>
        <td class="style21"></td>
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
			<td style="text-align:right" class="style17">
				Sucursal
			</td>
			<td class="style19" >
				<asp:DropDownList runat="server" ID="ddlSucursales" AppendDataBoundItems="True" DataValueField="LugarExpedicion"
					DataTextField="Nombre" />			
			</td>
			<td style="text-align: right" class="style21">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Observaciones
			</td>
			<td >
				<asp:TextBox runat="server" ID="txtProyecto" Width="100%" />
			</td>
		</tr>
		<tr>
    <td style="text-align:right" class="style17">
		Forma de Pago
	</td>
	<td class="style19">
		<asp:DropDownList runat="server" ID="ddlCondicionesPago" AutoPostBack="True" 
            onselectedindexchanged="ddlCondicionesPago_SelectedIndexChanged">
		    <asp:ListItem runat="server" Text="En una sola exhibición" Value="En una sola exhibición"></asp:ListItem>
            <asp:ListItem runat="server" Text="En parcialidades" Value="En parcialidades"></asp:ListItem>
		</asp:DropDownList>
	</td>
    <td style="text-align:left" class="style21">
				
			</td>
			<td >
				&nbsp;</td>
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
	</td>
	
</tr>
		</table>

    </div>
	<asp:TabContainer ID="tabContainerAduana"  runat="server" Width="100%" 
		ActiveTabIndex="0" style="margin-right: 5px">
	    <asp:TabPanel HeaderText="Addenda" runat="server" CssClass="page2" ID="datosAddenda">
        <HeaderTemplate>Addenda</HeaderTemplate><ContentTemplate>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" >
        <ContentTemplate>
        <div align="center"><table width="100%"><caption style="text-align:center">DATOS ADDENDA<tr><td style="text-align: right" class="style12"></td><td colspan="5" class="style8">&#160;</td></tr></TR><tr><td class="style16">TipoProveedor:</td><td class="style5"><asp:TextBox runat="server" ID="txtTipoProveedor"
              ToolTip="Indica el tipo de proveedor, proporcionad por Asofarma" 
               Width="50px" MaxLength="2" /><asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator5" ErrorMessage="Requerido" Display="Dynamic"
              ControlToValidate="txtTipoProveedor" ValidationGroup="CrearFactura"></asp:RequiredFieldValidator><asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender6" runat="server" FilterType="Custom, Numbers"
             TargetControlID="txtTipoProveedor" Enabled="True" /></td><td class="style16">NoProveedor:</td><td class="style13" style="text-align: left"><asp:TextBox runat="server" 
                    ID="txtNoProveedor" ToolTip="Numero de Proveedor Asofarma" 
                       Width="100px" MaxLength="10" /><asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator6" ErrorMessage="Requerido" Display="Dynamic"
              ControlToValidate="txtNoProveedor" ValidationGroup="CrearFactura"></asp:RequiredFieldValidator></td><td class="style14">OrdenCompra:</td><td style="text-align: left"><asp:TextBox runat="server" ID="txtOrdenCompra" 
                   ToolTip="NC:mero de Orden de compra Asofarma" 
                      Width="100px" MaxLength="12"  /><asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator7" ErrorMessage="Requerido" Display="Dynamic"
              ControlToValidate="txtOrdenCompra" ValidationGroup="CrearFactura"></asp:RequiredFieldValidator></td></tr><tr><td colspan="6"><hr width="100%" align="left" /></td></tr><tr><td style="text-align: right" class="style12">NoPartida:</td><td style="text-align: left" class="style10"><asp:TextBox ID="txtNoPartida" runat="server"  ToolTip="NC:mero de Partida"  Width="50px" /><br /><asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator8" ErrorMessage="Requerido" Display="Dynamic"
              ControlToValidate="txtNoPartida" ValidationGroup="AgregarAtributos"></asp:RequiredFieldValidator><asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" FilterType="Custom, Numbers"
             TargetControlID="txtNoPartida" Enabled="True" /></td><td style="text-align: right" class="style12">IvaAcreditable:</td><td style="text-align: left" class="style13"><asp:TextBox ID="txtIvaAcreditable"  ToolTip="Importe del IVA acreditable" runat="server">
                </asp:TextBox><asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator9" ErrorMessage="Requerido" Display="Dynamic"
                ControlToValidate="txtIvaAcreditable" ValidationGroup="AgregarAtributos"></asp:RequiredFieldValidator><br /><asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server" FilterType="Numbers, Custom"
    ValidChars="." TargetControlID="txtIvaAcreditable" /><asp:RegularExpressionValidator id="RegularExpressionValidator3" runat="server" Display="Dynamic"
    ControlToValidate="txtIvaAcreditable" ErrorMessage="Dato invalido" ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" ValidationGroup="AgregarAtributos"/></td><td style="text-align: right" class="style15">IvaDevengado:</td><td style="text-align: left"><asp:TextBox ID="txtIvaDevengado"  ToolTip="Importe del IVA devengado"  runat="server"></asp:TextBox><asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator10" ErrorMessage="Requerido" Display="Dynamic"
                ControlToValidate="txtIvaDevengado" ValidationGroup="AgregarAtributos"></asp:RequiredFieldValidator><br /><asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender3" runat="server" FilterType="Numbers, Custom"
    ValidChars="." TargetControlID="txtIvaDevengado" /><asp:RegularExpressionValidator id="RegularExpressionValidator1" runat="server" Display="Dynamic"
    ControlToValidate="txtIvaDevengado" ErrorMessage="Dato invalido" ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" ValidationGroup="AgregarAtributos"/></td></tr><tr><td style="text-align: right" class="style12">Otros:</td><td colspan="5" style="text-align: left"><asp:TextBox 
            ID="txtOtros" runat="server" TextMode="MultiLine" Width="80%"></asp:TextBox><asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator11" ErrorMessage="Requerido" Display="Dynamic"
                ControlToValidate="txtOtros" ValidationGroup="AgregarAtributos"></asp:RequiredFieldValidator></td></tr><tr><td colspan="6" style="text-align: right"><asp:Button ID="btnAtributos" runat="server" Text="Agregar Atributo" Width="114px" 
                                onclick="btnAtributos_Click" class="btn btn-primary" ValidationGroup="AgregarAtributos" />&#160;&#160;&#160;&#160;&#160;&#160;</td></tr><tr><td colspan="6" style="text-align: right">
                                <asp:panel runat="server" Width="100%" ScrollBars="Horizontal">
                                <div style="width: 100%; overflow: auto">
                                <asp:GridView Width="100%" runat="server" ID="gvAmazon" AutoGenerateColumns="False" CssClass="style124"
			ShowHeaderWhenEmpty="True" onrowcommand="gvAmazon_RowCommand"  style="text-align: center">
            <Columns><asp:BoundField HeaderText="NoPartida" DataField="noPartida" ><ItemStyle HorizontalAlign="Center" /></asp:BoundField><asp:BoundField HeaderText="IvaAcreditable" DataField="ivaAcreditable" ><ItemStyle HorizontalAlign="Center" /></asp:BoundField><asp:BoundField HeaderText="IvaDevengado" DataField="ivaDevengado" ><ItemStyle HorizontalAlign="Center" /></asp:BoundField><asp:BoundField HeaderText="Otros" DataField="Otros" ><ItemStyle HorizontalAlign="Center" /></asp:BoundField><asp:ButtonField Text="Eliminar" CommandName="EliminarAtributo" ><ItemStyle HorizontalAlign="Center" /></asp:ButtonField></Columns>
            </asp:GridView>
            </div>
            </asp:panel>
            </td></tr></caption></table></div>
            </ContentTemplate>
            <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btnAtributos" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="gvAmazon" />
            </Triggers>
            </asp:UpdatePanel>
            <div style="width: 900px"></div></ContentTemplate></asp:TabPanel> 
       
        <asp:TabPanel ID="tabGeneral" HeaderText="Datos Generales" CssClass="page2" runat="server"><HeaderTemplate>Conceptos</HeaderTemplate>
        <ContentTemplate>
        <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional" >
        <ContentTemplate>
        <div align="center"><h1>Conceptos</h1></div><table width="100%" ><tr><td style="text-align: right;" width="15%">Cantidad</td><td class="style1" ><asp:TextBox runat="server" ID="txtCantidad" /><asp:CompareValidator runat="server" ID="cvCantidad" ControlToValidate="txtCantidad" Display="Dynamic" Type="Double"
				 ErrorMessage="* Cantidad Invalida" ValidationGroup="AgregarConcepto" Operator="DataTypeCheck" /><asp:RequiredFieldValidator runat="server" ID="rfvCantidad" ControlToValidate="txtCantidad" Display="Dynamic"
				 ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" /></td><td style="text-align: right;" width="15%">Unidad </td><td ><asp:TextBox runat="server" ID="txtUnidad"  />&nbsp; <asp:RequiredFieldValidator runat="server" ID="rfvUnidad" ControlToValidate="txtUnidad" Display="Dynamic"
		 ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" /></td></tr><tr><td style="text-align: right;" width="15%">Código:</td><td class="style1" ><asp:TextBox runat="server" ID="txtCodigo" /></td><td style="text-align: right;" width="15%">Precio Unitario: $ </td><td ><asp:TextBox runat="server" ID="txtPrecio" /><asp:RequiredFieldValidator runat="server" ID="rfvPrecio" ControlToValidate="txtPrecio" Display="Dynamic"
		 ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" />&nbsp; <asp:CompareValidator runat="server" ID="cvPrecio"  
                    ControlToValidate="txtPrecio" Display="Dynamic"
		 ErrorMessage="* Precio Inválido" Type="Double" Operator="DataTypeCheck" 
                    ValidationGroup="AgregarConcepto" /></td></tr><tr><td style="text-align: right;"><asp:CheckBox runat="server" ID="cbIva" Text="I.V.A." AutoPostBack="True" Checked="True"/></td><td style="text-align: left;"><asp:TextBox runat="server" ID="txtIvaConcepto" Text="16"/>% <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="txtIvaConcepto" Display="Dynamic" 
				ValidationGroup="AgregarConcepto" ErrorMessage="* Dato Inválido" Operator="DataTypeCheck" Type="Integer" /></td><td style="text-align: right">&nbsp;</td><td style="text-align: left">&nbsp;</td></tr><tr><td style="text-align: right;" width="15%">Descripción </td><td colspan="3"><asp:TextBox runat="server" ID="txtDescripcion" Width="80%" TextMode="MultiLine" /><asp:RequiredFieldValidator runat="server" ID="rfvDescripcion" ControlToValidate="txtDescripcion" Display="Dynamic"
				 ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" /></td></tr><tr><td style="text-align: right;" width="15%"></td><td class="style1" ></td><td>
                 <asp:Button runat="server" ID="btnAgregar" Text="Agregar Concepto" ValidationGroup="AgregarConcepto" onclick="btnAgregar_Click" class="btn btn-primary"/></td><td>
                 <asp:Button runat="server" ID="btnBuscar" Text="Buscar" 
                    onclick="btnBuscar_Click" class="btn btn-primary" Width="80px"/><asp:HiddenField ID="txtIdProducto" runat="server" /></td></tr></table><br />
                    <div style="width: 100%">
                    <asp:panel ID="Panel1" runat="server" Width="100%" ScrollBars="Horizontal">
                        
                        <div style="height: 100%; overflow-y: scroll" >
                            <asp:GridView ID="gvDetalles" runat="server" AutoGenerateColumns="False" 
                                CssClass="style124" onrowcommand="gvDetalles_RowCommand" 
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
                                    <ItemStyle HorizontalAlign="left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="PorcentajeIva" HeaderText="%I.V.A.">
                                    <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ImporteIva" DataFormatString="{0:C}" 
                                        HeaderText="I.V.A">
                                    <ItemStyle HorizontalAlign="left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="PorcentajeRetencionIva" HeaderText="%Retención">
                                    <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="RetencionIva" DataFormatString="{0:C}" 
                                        HeaderText="Retención">
                                    <ItemStyle HorizontalAlign="left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="TotalPartida" DataFormatString="{0:C}" 
                                        HeaderText="Total">
                                    <ItemStyle HorizontalAlign="left" />
                                    </asp:BoundField>
                                    <asp:ButtonField CommandName="Editar" Text="Editar" Visible="False">
                                    <ItemStyle HorizontalAlign="Center" />
                                    </asp:ButtonField>
                                    <asp:ButtonField CommandName="EliminarConcepto" Text="Eliminar" Visible="False">
                                    <ItemStyle HorizontalAlign="Center" />
                                    </asp:ButtonField>
                                </Columns>
                            </asp:GridView><br />
                        </div>
                       
                    </asp:panel>
                    </div>
           
            <asp:ModalPopupExtender ID="mpeEdita" runat="server" 
                BackgroundCssClass="mpeBack" CancelControlID="btnCancelar" 
                PopupControlID="panelEditaConcepto" TargetControlID="btnEditarDummy" />
            <asp:Panel ID="panelEditaConcepto" runat="server" BackColor="White" 
                style="text-align: center;" Width="800px">
                <h1>
                    <asp:Label ID="lblConcepto" runat="server">Editar Concepto</asp:Label>
                </h1>
                <table width="600px">
                    <tr>
                        <td>
                            Cantidad:</td>
                        <td align="left">
                            <asp:TextBox ID="txtCantidadEdita" runat="server" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                ControlToValidate="txtCantidadEdita" Display="Dynamic" 
                                ErrorMessage="* Requerido" ValidationGroup="Concepto" />
                            <asp:CompareValidator ID="CompareValidator2" runat="server" 
                                ControlToValidate="txtCantidadEdita" Display="Dynamic" 
                                ErrorMessage="* Cantidad Invalida" Operator="DataTypeCheck" Type="Double" 
                                ValidationGroup="Concepto" />
                            <asp:HiddenField ID="hidDetalle" runat="server" />
                            <asp:HiddenField ID="hidNumero" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Unidad de Medida:</td>
                        <td align="left">
                            <asp:TextBox ID="txtUnidadEdita" runat="server" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                ControlToValidate="txtUnidadEdita" Display="Dynamic" ErrorMessage="* Requerido" 
                                ValidationGroup="Concepto" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            N° de identificación:</td>
                        <td align="left">
                            <asp:TextBox ID="txtCodigoEdita" runat="server" Width="400px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Descripción:</td>
                        <td align="left">
                            <asp:TextBox ID="txtDescripcionEdita" runat="server" Width="400px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                                ControlToValidate="txtDescripcionEdita" Display="Dynamic" 
                                ErrorMessage="* Requerido" ValidationGroup="Concepto" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Observaciones:</td>
                        <td align="left">
                            <asp:TextBox ID="txtObservacionesEdita" runat="server" Width="400px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Precio Unitario:</td>
                        <td align="left">
                            <asp:TextBox ID="txtPrecioUnitarioEdita" runat="server"></asp:TextBox>
                            <asp:CompareValidator ID="CompareValidator3" runat="server" 
                                ControlToValidate="txtPrecioUnitarioEdita" Display="Dynamic" 
                                ErrorMessage="* Cantidad Invalida" Operator="DataTypeCheck" Type="Double" 
                                ValidationGroup="Concepto" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                                ControlToValidate="txtPrecioUnitarioEdita" Display="Dynamic" 
                                ErrorMessage="* Requerido" ValidationGroup="Concepto" />
                        </td>
                    </tr>
                </table>
                <div align="right">
                    <asp:Button ID="btnGuardar" runat="server" class="btn btn-primary" 
                        onclick="btnGuardar_Click" style="width: 68px" Text="Guardar" 
                        ValidationGroup="Concepto" />
                    &nbsp;&nbsp;&nbsp;
                    <asp:Button ID="btnCancelar" runat="server" CausesValidation="False" 
                        class="btn btn-primary" Text="Cancelar" />
                </div>
                <br />
            </asp:Panel>
            <asp:Button ID="btnEditarDummy" runat="server" class="btn btn-primary" 
                style="display: none;" />
            <br>
            </br>

                    </ContentTemplate>
            <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btnBuscar" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btnAgregar" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="gvDetalles" />
            </Triggers>
            </asp:UpdatePanel>
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
			<td>Total</td>
			<td><asp:Label runat="server" ID="lblTotal" /></td>
		</tr>
		<tr>
			<td colspan="2"></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
			
			<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
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
			<asp:Button runat="server" ID="btnBuscarConcepto" Text="Buscar" onclick="btnBuscarConcepto_Click" class="btn btn-primary" />
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
	<asp:Button runat="server" ID="btnConceptoDummy" style="display: none;"/>

	
</asp:Content>
