<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="WfrFacturaCoppelMuebles.aspx.cs" Inherits="GafLookPaid.WfrFacturaCoppelMuebles" %>
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
            width: 17%;
        }
        .style3
        {
            width: 291px;
        }
        .style4
        {
            width: 39%;
        }
        .style5
        {
            width: 20%;
        }
        .style7
        {
            width: 287px;
        }
        .style8
        {
            width: 336px;
        }
        .style9
        {
            width: 5%;
        }
        .style10
        {
            width: 6%;
        }
        .style13
        {
            width: 33%;
        }
        .style14
        {
            width: 33%;
            color: #000099;
        }
        .style15
        {
            width: 19%;
        }
               
    
        .style16
        {
            text-align: right;
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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h1>
        Generar CFDI</h1>
    <p>
        Empresa:&nbsp;<asp:DropDownList runat="server" ID="ddlEmpresa" AutoPostBack="True"
            DataTextField="RazonSocial" DataValueField="idEmpresa" OnSelectedIndexChanged="ddlEmpresa_SelectedIndexChanged" />
    </p>
    <asp:UpdatePanel ID="up1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <table width="90%">
                <tr>
                    <td style="text-align: right">
                        Status Factura
                    </td>
                    <td>
                        <asp:DropDownList runat="server" ID="ddlStatusFactura" AutoPostBack="True" OnSelectedIndexChanged="ddlStatusFactura_SelectedIndexChanged">
                            <asp:ListItem Value="0" Text="Pendiente"></asp:ListItem>
                            <asp:ListItem Value="1" Text="Pagada"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td style="text-align:right">
                        <asp:Label runat="server" ID="lblFechaPago" Text="Fecha de Pago" Visible="False" />
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtFechaPago" Width="75px" Visible="False" />
                        <asp:CompareValidator runat="server" ID="cvFechaInicial" ControlToValidate="txtFechaPago"
                            Display="Dynamic" ErrorMessage="* Fecha Invalida" Operator="DataTypeCheck" Type="Date" />
                        <asp:CalendarExtender runat="server" ID="ceFechaInicial" Animated="False" PopupButtonID="txtFechaPago"
                            TargetControlID="txtFechaPago" Format="dd/MM/yyyy" />
                    </td>
                    <td style="text-align:right">
                        Tipo de Documento
                    </td>
                    <td>
                        <asp:DropDownList runat="server" ID="ddlTipoDocumento" AutoPostBack="True" OnSelectedIndexChanged="ddlTipoDocumento_SelectedIndexChanged">
                            <asp:ListItem runat="server" Text="Factura" Value="Ingreso" Selected="True" />
                            <asp:ListItem runat="server" Text="Nota de Crédito" Value="Egreso" />
                            <asp:ListItem runat="server" Text="Recibo de Donativo" Value="Donativo" />
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
                        <asp:Label runat="server" ID="lblTipoCambio" Text="Tipo Cambio USD:" Visible="False" />
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtTipoCambio" Visible="False" Width="50px" />
                    </td>
                    <td>
                        <%--Días Revisión--%>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtDiasRevision" Width="50px"  Visible="false"/>
                        <asp:CompareValidator runat="server" ID="cvTxtDiasRevision" ControlToValidate="txtDiasRevision"
                            Display="Dynamic" ErrorMessage="* Dato invalido" Type="Integer" Operator="DataTypeCheck" />
                    </td>
                </tr>
                <tr>
                    <td style="text-align:right">Fecha de promesa de entrega:</td>
                    <td>
                        <asp:TextBox runat="server" ID="txtFechaPromesaEntrega" Width="75px" Visible="True" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFechaPromesaEntrega" ErrorMessage="*Obligatorio"></asp:RequiredFieldValidator>
                        <asp:CompareValidator runat="server" ID="CompareValidator4" ControlToValidate="txtFechaPromesaEntrega"
                            Display="Dynamic" ErrorMessage="* Fecha Invalida" Operator="DataTypeCheck" Type="Date" />
                        <asp:CalendarExtender runat="server" ID="ceFechaInicialPe" Animated="False" PopupButtonID="txtFechaPromesaEntrega"
                            TargetControlID="txtFechaPromesaEntrega" Format="dd/MM/yyyy" />
                    </td>
                    <td style="text-align: right">Bodega receptora:</td>
                    <td>
                        <asp:TextBox runat="server" ID="txtBodegaReceptora"></asp:TextBox> 
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtBodegaReceptora" ErrorMessage="* Requerido"></asp:RequiredFieldValidator>
                    </td>
                    <td style="text-align:right">Bodega Destino:</td>
                    <td>
                        <asp:TextBox runat="server" ID="txtBodegaDestino"></asp:TextBox> 
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtBodegaDestino" ErrorMessage="* Requerido"></asp:RequiredFieldValidator>
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
                <tr runat="server" id="trDonativo" visible="False">
                    <td colspan="2">
                        Número de autorización del Donativo:
                        <asp:TextBox runat="server" ID="txtDonatAutorizacion"></asp:TextBox>
                    </td>
                    <td colspan="2">
                        Fecha de autorización del donativo:
                        <asp:TextBox runat="server" ID="txtDonatFechautorizacion"></asp:TextBox>
                        <asp:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtDonatFechautorizacion"
                            PopupButtonID="txtDonatFechautorizacion" Format="dd/MM/yyyy" />
                    </td>
                </tr>
                <tr> 
        <td class="style15"></td>
        <td class="style14">&nbsp;</td>
        <td></td>
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
                <tr>
                    <td style="text-align:right" class="style15">
                        Sucursal
                    </td>
                    <td class="style13">
                        <asp:DropDownList runat="server" ID="ddlSucursales" AppendDataBoundItems="True" DataValueField="LugarExpedicion"
                            DataTextField="Nombre" />
                    </td>
                    <td colspan="2" class="style16">
                        Observaciones
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtProyecto" />
                    </td>
                </tr>
                <tr>
                    <td style="text-align:right" width="25%" class="style15">
                        Forma de Pago
                    </td>
                    <td class="style13">
                        <asp:DropDownList runat="server" ID="ddlCondicionesPago" AutoPostBack="True" OnSelectedIndexChanged="ddlCondicionesPago_SelectedIndexChanged">
                            <asp:ListItem runat="server" Text="Pago en una sola exhibición" Value="Pago en una sola exhibición"></asp:ListItem>
                            <asp:ListItem runat="server" Text="En parcialidades" Value="En parcialidades"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
            <div runat="server" id="divParcialidades" visible="False">
                <h1 style="text-align: center">
                    Parcialidades</h1>
                <table table width="95%">
                    <tr>
                        <td style="text-align:right">
                            Folio Fiscal Original
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtFolioOriginal" />
                        </td>
                        <td style="text-align: right" class="style3">
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
                        <td style="text-align:right">
                            Monto del Folio Fiscal Original
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtMontoOriginal" Width="100%" />
                            <asp:CompareValidator runat="server" ID="cvMontoOriginal" ControlToValidate="txtMontoOriginal"
                                Display="Dynamic" ErrorMessage="* Monto invalido" Operator="DataTypeCheck" Type="Currency"
                                ValidationGroup="CrearFactura" />
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
                        <td style="text-align: right">
                            Nombre:
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtVoBoNombre"></asp:TextBox>
                        </td>
                        <td style="text-align: right">
                            Puesto:
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtVoBoPuesto"></asp:TextBox>
                        </td>
                        <td style="text-align: right">
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
                        <td style="text-align: right">
                            Nombre:
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtRecibiNombre"></asp:TextBox>
                        </td>
                        <td style="text-align: right">
                            Puesto:
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtRecibiPuesto"></asp:TextBox>
                        </td>
                        <td style="text-align: right">
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
                        <td style="text-align: right">
                            Nombre:
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtAutorizoNombre"></asp:TextBox>
                        </td>
                        <td style="text-align: right">
                            Puesto:
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtAutorizoPuesto"></asp:TextBox>
                        </td>
                        <td style="text-align: right">
                            Area:
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtAutorizoArea"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </div>
            <h1 style="text-align: center">
                Conceptos</h1>
            <asp:TabContainer runat="server" ID="TabConceptosAddenda"  Width="100%" ActiveTabIndex="1">
                <asp:TabPanel ID="tabConceptos" runat="server" CssClass="page2" HeaderText="Conceptos">
                    <ContentTemplate>
                        <table width="95%">
                            <tr>
                                <td style="text-align: right;" width="15%">
                                    Cantidad
                                </td>
                                <td class="style1">
                                    <asp:TextBox runat="server" ID="txtCantidad" />
                                    <asp:CompareValidator runat="server" ID="cvCantidad" ControlToValidate="txtCantidad"
                                        Display="Dynamic" Type="Double" ErrorMessage="* Cantidad Invalida" ValidationGroup="AgregarConcepto"
                                        Operator="DataTypeCheck" />
                                    <asp:RequiredFieldValidator runat="server" ID="rfvCantidad" ControlToValidate="txtCantidad"
                                        Display="Dynamic" ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" />
                                </td>
                                <td style="text-align: right;" width="15%">
                                    Unidad
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtUnidad" />&nbsp;
                                    <asp:RequiredFieldValidator runat="server" ID="rfvUnidad" ControlToValidate="txtUnidad"
                                        Display="Dynamic" ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" />
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right;" width="15%">
                                    Gtin
                                </td>
                                <td class="style1">
                                    <asp:TextBox runat="server" ID="txtCodigo" />
                                </td>
                                <td style="text-align: right;" width="15%">
                                    Precio Unitario: $
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtPrecio" />
                                    <asp:RequiredFieldValidator runat="server" ID="rfvPrecio" ControlToValidate="txtPrecio"
                                        Display="Dynamic" ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" />&nbsp;
                                    <asp:CompareValidator runat="server" ID="cvPrecio" ControlToValidate="txtPrecio"
                                        Display="Dynamic" ErrorMessage="* Precio invalido" Type="Double" Operator="DataTypeCheck"
                                        ValidationGroup="AgregarConcepto" />
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right;">
                                    <asp:CheckBox runat="server" ID="cbIva" Text="I.V.A." AutoPostBack="True" Checked="True" />
                                </td>
                                <td style="text-align: left;">
                                    <asp:TextBox runat="server" ID="txtIvaConcepto" Text="16" />
                                    %
                                    <asp:CompareValidator ID="CompareValidator3" runat="server" ControlToValidate="txtIvaConcepto"
                                        Display="Dynamic" ValidationGroup="AgregarConcepto" ErrorMessage="* Dato Inválido"
                                        Operator="DataTypeCheck" Type="Integer" />
                                </td>
                                <td style="text-align: right;">
                                    Modelo
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtModeloConcepto" Visible="True" />
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right;" width="15%">
                                    Descripción
                                </td>
                                <td colspan="3">
                                    <asp:TextBox runat="server" ID="txtDescripcion" Width="80%" TextMode="MultiLine" />
                                    <asp:RequiredFieldValidator runat="server" ID="rfvDescripcion" ControlToValidate="txtDescripcion"
                                        Display="Dynamic" ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" />
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right;" width="15%">
                                    Observaciones
                                </td>
                                <td class="style1">
                                    <asp:TextBox runat="server" ID="txtDetalles" Width="90%" TextMode="MultiLine" />
                                </td>
                                <td>
                                    <asp:Button runat="server" ID="btnAgregar" Text="Agregar Concepto" ValidationGroup="AgregarConcepto" class="btn btn-primary"
                                        OnClick="btnAgregar_Click" />
                                </td>
                                <td>
                                    <asp:Button runat="server" ID="btnBuscar" Text="Buscar" OnClick="btnBuscar_Click" class="btn btn-primary" Width="80px" />
                                    <asp:HiddenField ID="txtIdProducto" runat="server" />
                                </td>
                            </tr><br />
                            <tr>
                                <td style=" overflow-y: scroll" colspan="4">
                                    <asp:GridView ID="gvDetalles" runat="server" CssClass="style124" AutoGenerateColumns="False" OnRowCommand="gvDetalles_RowCommand"
                                        ShowHeaderWhenEmpty="True" Width="100%">
                                        <Columns>
                                            <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" ItemStyle-HorizontalAlign="Center" />
                                            <asp:BoundField DataField="Unidad" HeaderText="Unidad" ItemStyle-HorizontalAlign="Center" />
                                            <asp:BoundField DataField="Codigo" HeaderText="Código" ItemStyle-HorizontalAlign="Center" />
                                            <asp:BoundField DataField="Descripcion" HeaderText="Descripción" />
                                            <asp:BoundField DataField="Descripcion2" HeaderText="Observaciones" />
                                            <asp:BoundField DataField="ModeloConcepto" HeaderText="Modelo" />
                                            <asp:BoundField DataField="Precio" DataFormatString="{0:C}" HeaderText="Precio Unitario"
                                                ItemStyle-HorizontalAlign="Right" />
                                            <asp:BoundField DataField="PorcentajeIva" HeaderText="%I.V.A." ItemStyle-HorizontalAlign="Right" />
                                            <asp:BoundField DataField="ImporteIva" DataFormatString="{0:C}" HeaderText="I.V.A."
                                                ItemStyle-HorizontalAlign="Right" />
                                            <%--<asp:BoundField HeaderText="%Retención" DataField="PorcentajeRetencionIva" ItemStyle-HorizontalAlign="Right" />
				<asp:BoundField HeaderText="Retención" DataField="RetencionIva" DataFormatString="{0:C}" ItemStyle-HorizontalAlign="Right" />--%>
                                            <asp:BoundField DataField="TotalPartida" DataFormatString="{0:C}" HeaderText="Total"
                                                ItemStyle-HorizontalAlign="Right" />
                                            <asp:ButtonField CommandName="Editar" ItemStyle-HorizontalAlign="Center" Text="Editar"
                                                Visible="False" />
                                            <asp:ButtonField CommandName="EliminarConcepto" ItemStyle-HorizontalAlign="Center"
                                                Text="Eliminar" Visible="False" />
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                        <br></br>
                    </ContentTemplate>
                </asp:TabPanel>
                <asp:TabPanel runat="server" HeaderText="Addenda AMC 7.1"  CssClass="page2" ID="TabAddendaAmc">
                    <HeaderTemplate>
                        Addenda Coppel
                    </HeaderTemplate>
                    <ContentTemplate>
                        <asp:TabContainer runat="server" ID="Options" Width="100%" ActiveTabIndex="6">
                            <asp:TabPanel ID="TabPanel1" runat="server" HeaderText="TabPanel1">
                                <HeaderTemplate>
                                    Request for Payment Id
                                </HeaderTemplate>
                                <ContentTemplate>
                                    <table style="width: 95%">
                                        <tr>
                                            <td style="text-align: right;" width="15%">
                                                EntityType
                                            </td>
                                            <td class="style1">
                                                <asp:DropDownList ID="RequestforPayment_ListBox_EntityType" runat="server" 
                                                    onselectedindexchanged="RequestforPayment_ListBox_EntityType_SelectedIndexChanged">
                                                    <asp:ListItem Selected="True">INVOICE</asp:ListItem>
                                                    <asp:ListItem>DEBIT_NOTE</asp:ListItem>
                                                    <asp:ListItem>CREDIT_NOTE</asp:ListItem>
                                                    <asp:ListItem>LEASE_RECEIPT</asp:ListItem>
                                                    <asp:ListItem>HONORARY_RECEIPT</asp:ListItem>
                                                    <asp:ListItem>PARTIAL_INVOICE</asp:ListItem>
                                                    <asp:ListItem>TRANSPORT_DOCUMENT</asp:ListItem>
                                                    <asp:ListItem>AUTO_INVOICE</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td style="text-align: right;" width="15%">
                                                UniqueCreatorIdentification
                                            </td>
                                            <td>
                                                <asp:TextBox ID="RequestforPayment_UniqueCreatorIdentification" runat="server" Text="PBA1"
                                                    MaxLength="17"></asp:TextBox>
                                                &nbsp;</td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                            </asp:TabPanel>
                            <asp:TabPanel ID="TabPanel2" runat="server" HeaderText="TabPanel2">
                                <HeaderTemplate>
                                    Order Identification
                                </HeaderTemplate>
                                <ContentTemplate>
                                    <div>
                                        <table style="width: 95%">
                                            <tr>
                                                <td style="text-align: right;" class="style5">
                                                    Reference Identification
                                                </td>
                                                <td class="style8">
                                                    <asp:TextBox ID="OrderIdentification_ReferenceIdentification" runat="server"></asp:TextBox>
                                                    &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Addenda->Order Identification *Campo Requerido"
                                                        ControlToValidate="OrderIdentification_ReferenceIdentification" Display="Dynamic" ValidationGroup="CrearFactura"></asp:RequiredFieldValidator>
                                                    &nbsp;
                                                </td>
                                                <td>
                                                    Type
                                                </td>
                                                <td class="style1">
                                                    <asp:DropDownList ID="OrderIdentification_ListBox_Type" runat="server">
                                                        <asp:ListItem>ON</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </ContentTemplate>
                            </asp:TabPanel>
                            
                            <asp:TabPanel ID="TabPanel5" runat="server" HeaderText="TabPanel5">
                                <HeaderTemplate>
                                    Additional Information
                                </HeaderTemplate>
                                <ContentTemplate>
                                    <div>
                                        <table style="width: 95%">
                                            <tr>
                                                <td style="text-align: right;" class="style5">
                                                    Reference Identification
                                                </td>
                                                <td class="style7">
                                                    <asp:TextBox ID="AdditionalInformation_ReferenceIdentification" runat="server"></asp:TextBox>
                                                   
                                                </td>
                                                <td>
                                                    Type
                                                </td>
                                                <td class="style1">
                                                    
                                                    <asp:DropDownList ID="AdditionalInformation_ListBox_Type" runat="server">
                                                        <asp:ListItem>AAE</asp:ListItem>
                                                        <asp:ListItem>CK</asp:ListItem>
                                                        <asp:ListItem>ACE</asp:ListItem>
                                                        <asp:ListItem>ATZ</asp:ListItem>
                                                        <asp:ListItem>DQ</asp:ListItem>
                                                        <asp:ListItem>IV</asp:ListItem>
                                                        <asp:ListItem Selected="True">ON</asp:ListItem>
                                                        <asp:ListItem>AWR</asp:ListItem>
                                                    </asp:DropDownList>
                                                    
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </ContentTemplate>
                            </asp:TabPanel>
                            <asp:TabPanel ID="TabPanel3" runat="server" HeaderText="TabPanel3">
                                <HeaderTemplate>
                                    Buyer &amp; Seller
                                </HeaderTemplate>
                                <ContentTemplate>
                                    <table style="width: 95%">
                                        <tr>
                                            <td style="text-align: center;" width="15%" colspan="6">
                                                Buyer
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right;" width="15%">
                                                Gln
                                            </td>
                                            <td style="text-align: left;" width="15%" colspan="5">
                                                <asp:TextBox ID="BuyerSeller_GlnBuyer" runat="server" MaxLength="13" OnTextChanged="TextBox3_TextChanged"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: center;" width="15%" colspan="6">
                                                Seller
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right;" width="15%">
                                                Gln
                                            </td>
                                            <td class="style1">
                                                <asp:TextBox ID="BuyerSeller_GlnSeller" runat="server" MaxLength="13"></asp:TextBox>
                                            </td>
                                            <td class="style5" style="text-align: right;">
                                                Alternate Party Identification
                                            </td>
                                            <td class="style4" style="text-align: right;">
                                                <asp:TextBox ID="BuyerSeller_AlternatePrtyId" runat="server" MaxLength="40"></asp:TextBox>
                                            </td>
                                            <td style="text-align: right;" width="15%">
                                                Type
                                            </td>
                                            <td style="text-align: right;" width="15%">
                                                <asp:DropDownList ID="BuyerSeller_ListBox_Type" runat="server">
                                                    <asp:ListItem Value="IEPS_REFERENCE"></asp:ListItem>
                                                    <asp:ListItem Value="SELLER_ASSIGNED_IDENTIFIER_FOR_A_PARTY" Selected="True"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                            </asp:TabPanel>
                            <asp:TabPanel ID="TabPanel4" runat="server" HeaderText="TabPanel4">
                                <HeaderTemplate>
                                    Currency
                                </HeaderTemplate>
                                <ContentTemplate>
                                    <div>
                                        <br />
                                        <table style="width: 100%">
                                            <tr>
                                                <td style="text-align: right;" width="15%">
                                                    ISO Code
                                                </td>
                                                <td class="style9">
                                                    <asp:DropDownList ID="Currency_ListBox_ISOCode" runat="server">
                                                        <asp:ListItem Selected="True">MXN</asp:ListItem>
                                                        <asp:ListItem>XEU</asp:ListItem>
                                                        <asp:ListItem>USD</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td style="text-align: right;" width="15%">
                                                    Currency Function
                                                </td>
                                                <td class="style1">
                                                    <asp:DropDownList ID="Currency_ListBox_CurrencyFunction" runat="server">
                                                         <asp:ListItem>BILLING_CURRENCY</asp:ListItem>
                                                        <asp:ListItem>PRICE_CURRENCY</asp:ListItem>
                                                        <asp:ListItem Selected="True">PAYMENT_CURRENCY</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td style="text-align: right;" class="style10">
                                                    Rate of change
                                                </td>
                                                <td>
                                                    <asp:TextBox Text="1" ID="Currency_RateOfChange" runat="server" Width="73px"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                                                        ErrorMessage="Addenda->Currency *Tipo de cambio requerido" ControlToValidate="Currency_RateOfChange" Operator="DataTypeCheck"
                                Type="Double" ValidationGroup="CrearFactura" ></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </ContentTemplate>
                            </asp:TabPanel>
                            <asp:TabPanel ID="TabPanel6" runat="server" HeaderText="TabPanel6">
                                <HeaderTemplate>
                                    Ship To
                                </HeaderTemplate>
                                <ContentTemplate>
                                    <table style="width: 95%">
                                        <tr>
                                            <td style="text-align: right;" width="15%">
                                                Name
                                            </td>
                                            <td class="style1">
                                                
                                                <asp:TextBox ID="Shipto_Name" runat="server" MaxLength="35"></asp:TextBox>
                                                
                                            </td>
                                            <td style="text-align: right;" width="15%">
                                                Street Address
                                            </td>
                                            <td class="style1">
                                                
                                                <asp:TextBox ID="Shipto_StreetAddress" runat="server" MaxLength="35"></asp:TextBox>
                                                
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right;" width="15%">
                                                City</td>
                                            <td class="style1">
                                                <asp:TextBox ID="Shipto_City" runat="server" MaxLength="35"></asp:TextBox>
                                            </td>
                                            <td style="text-align: right;" width="15%">
                                                Postal Code</td>
                                            <td class="style1">
                                                <asp:TextBox ID="Shipto_PostalCode" runat="server" MaxLength="9"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right;" width="15%">
                                                Gln</td>
                                            <td class="style1" colspan="3">
                                                <asp:TextBox ID="Shipto_Gln" runat="server" MaxLength="13"></asp:TextBox>
                                            </td>
                                           
                                        </tr>
                                    </table>
                                </ContentTemplate>
                            </asp:TabPanel>
                            <asp:TabPanel ID="TabPanel7" runat="server" HeaderText="TabPanel7">
                                <HeaderTemplate>
                                    Request for payment allowance charge
                                </HeaderTemplate>
                                <ContentTemplate>
                                    <div>
                                        <br />
                                        <table style="width: 100%">
                                            <tr>
                                                <td style="text-align: right;" width="15%">
                                                    Percentage
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="ReqForPayment_Percentage" runat="server" Width="73px"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" 
                                                        ErrorMessage="Addenda->Req for Payment *Valor Porcentaje Requerido" ControlToValidate="ReqForPayment_Percentage" Operator="DataTypeCheck"
                                Type="Double" ValidationGroup="CrearFactura" ></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </ContentTemplate>
                            </asp:TabPanel>
                        </asp:TabContainer>
                        &nbsp;
                    </ContentTemplate>
                </asp:TabPanel>
                <asp:TabPanel runat="server"  CssClass="page2" HeaderText="FleteCaja">
                    <ContentTemplate>
                        <asp:Label runat="server" Text="Flete Caja"></asp:Label>
                        <asp:TextBox runat="server" ID="txtFleteCaja"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFleteCaja" ValidationGroup="CrearFactura" ErrorMessage="Campo Obligatorio"></asp:RequiredFieldValidator>
                        <asp:DropDownList ID="ddlFleteCaja" runat="server">
                            <asp:ListItem Value="SELLER_PROVIDED" Text="SELLER_PROVIDED" />
                            <asp:ListItem Value="BUYER_PROVIDED" Text="BUYER_PROVIDED" />

                        </asp:DropDownList>
                        <br />
                    </ContentTemplate>
                </asp:TabPanel>
            </asp:TabContainer>
            <div style="width: 900px">
            </div>
            <br /><br />
            <asp:UpdateProgress AssociatedUpdatePanelID="up1" ID="UpdateProgress1" runat="server">
                <ProgressTemplate>
                    <div align="center">
                        <asp:Image ID="Image1" ImageUrl="images/ajax-loader.gif" runat="server" />
                        <br />
                        CFDI en proceso ..
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <asp:Label runat="server" ID="lblError" ForeColor="Red" />
            <br/>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="CrearFactura"/>
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
                            I.V.A.
                        </td>
                        <td>
                            <asp:Label runat="server" ID="lblIva" />
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
                    OnClick="btnLimpiar_Click" class="btn btn-primary" Width="80px" />&nbsp;&nbsp;&nbsp;
                <asp:Button runat="server" ID="BtnVistaPrevia" Text="Vista Previa" OnClick="btnGenerarPreview_Click" class="btn btn-primary"
                    ValidationGroup="CrearFactura" />&nbsp;&nbsp;&nbsp;
                <asp:Button runat="server" ID="btnGenerarFactura" Text="Generar Factura" OnClick="btnGenerarFactura_Click" class="btn btn-primary"
                    ValidationGroup="CrearFactura" style="height: 26px" />
                <asp:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" TargetControlID="btnGenerarFactura"
                    ConfirmText="Confirma que deseas generar el comprobante" />
            </p>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnLimpiar" />
            <asp:PostBackTrigger ControlID="BtnVistaPrevia" />
            <asp:PostBackTrigger ControlID="TabConceptosAddenda" />
        </Triggers>
    </asp:UpdatePanel>
    <asp:ModalPopupExtender runat="server" ID="mpeBuscarConcepto" TargetControlID="btnConceptoDummy"
        BackgroundCssClass="mpeBack" CancelControlID="btnCerrarConcepto" PopupControlID="pnlBuscarConcepto" />
    <asp:Panel runat="server" ID="pnlBuscarConcepto" Style="text-align: center;" Width="800px"
        BackColor="White">
        <h1>
            Buscar Conceptos</h1>
        <p>
            <asp:TextBox runat="server" ID="txtConceptoBusqueda" Width="250px" />&nbsp;&nbsp;&nbsp;
            <asp:Button runat="server" ID="btnBuscarConcepto" Text="Buscar" OnClick="btnBuscarConcepto_Click" class="btn btn-primary"/>
        </p>
        <div style="height: 400px; overflow-y: scroll">
            <asp:Label runat="server" ID="lblMensaje" ForeColor="Red" />
            <asp:GridView runat="server" ID="gvBuscarConceptos" Width="100%" AutoGenerateColumns="False"
                DataKeyNames="IdProducto" ShowHeaderWhenEmpty="True" OnRowCommand="gvBuscarConceptos_RowCommand">
                <Columns>
                    <asp:BoundField HeaderText="Código" DataField="Codigo" />
                    <asp:BoundField HeaderText="Descripción" DataField="Descripcion" />
                    <asp:BoundField HeaderText="Observaciones" DataField="Observaciones" />
                    <asp:BoundField HeaderText="Precio" DataField="PrecioP" DataFormatString="{0:C}" />
                    <asp:ButtonField Text="Seleccionar" CommandName="Seleccionar" />
                </Columns>
            </asp:GridView>
        </div>
        <br />
        <%--<asp:Button runat="server" ID="btnSeleccionarConcepto" Text="Seleccionar" onclick="btnSeleccionarConcepto_Click" />&nbsp;&nbsp;--%>
        <asp:Button runat="server" ID="btnCerrarConcepto" Text="Cancelar" class="btn btn-primary"/>
    </asp:Panel>
    <asp:Button runat="server" ID="btnConceptoDummy" Style="display: none;" class="btn btn-primary"/>
    <asp:ModalPopupExtender runat="server" ID="mpeEdita" TargetControlID="btnEditarDummy"
        BackgroundCssClass="mpeBack" CancelControlID="btnCancelar" PopupControlID="panelEditaConcepto" />
    <asp:Panel runat="server" ID="panelEditaConcepto" Style="text-align: center;" Width="800px"
        BackColor="White">
        <h1>
            <asp:Label runat="server" ID="lblConcepto">Editar Concepto</asp:Label></h1>
        <table width="600px">
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
                    <asp:TextBox runat="server" ID="txtCodigoEdita" Width="400px"></asp:TextBox>
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
                    Modelo:
                </td>
                <td style="text-align: left;">
                    <asp:TextBox runat="server" ID="txtModeloItem"/>
                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator8" ErrorMessage="* Requerido"
                        Display="Dynamic" ControlToValidate="txtModeloItem" ValidationGroup="Concepto" />
                </td>
            </tr>
        </table>
        <br />
        <div align="right">
            <asp:Button runat="server" ID="btnGuardar" Text="Guardar" ValidationGroup="Concepto" class="btn btn-primary"
                OnClick="btnGuardar_Click" />
            &nbsp;&nbsp;&nbsp;
            <asp:Button runat="server" ID="btnCancelar" Text="Cancelar" CausesValidation="False" class="btn btn-primary"/>
        </div>
    </asp:Panel>
    <asp:Button runat="server" ID="btnEditarDummy" Style="display: none;" class="btn btn-primary"/>
</asp:Content>
