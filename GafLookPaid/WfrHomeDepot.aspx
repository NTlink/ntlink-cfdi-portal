<%@ Page AutoEventWireup="true" CodeBehind="WfrHomeDepot.aspx.cs" Inherits="GafLookPaid.WfrHomeDepot" Language="C#" MasterPageFile="~/Site.Master" Title="" %>
<%@ MasterType VirtualPath="~/Site.Master" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
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
        .style16
        {
            height: 36px;
        }
        .style17
        {
            width: 78px;
            height: 36px;
        }
        .style18
        {
            width: 13%;
            height: 36px;
        }
        .style19
        {
            width: 25%;
            height: 36px;
        }
        .style20
        {
            width: 22%;
        }
        .style22
        {
            width: 29%;
            text-align: right;
        }
        .style23
        {
            width: 22%;
            text-align: right;
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


    <h1>
        Generar CFDI Home Depot</h1>
    <p>
        Empresa:&nbsp;<asp:DropDownList runat="server" ID="ddlEmpresa" AutoPostBack="True"
            DataTextField="RazonSocial" DataValueField="idEmpresa" OnSelectedIndexChanged="ddlEmpresa_SelectedIndexChanged" />
    </p>
    <asp:UpdatePanel ID="up1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <table width="90%">
                <tr>
                    <td style="text-align:right">
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
                        <%--Días Revisión--%>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtDiasRevision" Width="50px" Visible="false" />
                        <asp:CompareValidator runat="server" ID="cvTxtDiasRevision" ControlToValidate="txtDiasRevision"
                            Display="Dynamic" ErrorMessage="* Dato invalido" Type="Integer" Operator="DataTypeCheck" />
                    </td>
                </tr>
            </table>
            <p>
                Cliente:&nbsp;<asp:DropDownList runat="server" ID="ddlClientes" AutoPostBack="True"
                    DataTextField="RazonSocial" DataValueField="idCliente" OnSelectedIndexChanged="ddlClientes_SelectedIndexChanged" /><br />
                <br />
                <asp:TextBox runat="server" TextMode="MultiLine"  CssClass="page1" ID="txtRazonSocial" Width="500px"
                    Height="75px" Enabled="False" />
            </p>

            <tr> 
        <td class="style13"></td>
        <td class="style16">
            <table style="text-align:left" width="100%">
                <tr ID="trDonativo" runat="server" visible="False">
                    <td class="style20" style="text-align: right">
                        N. de autorización del Donativo:
                    </td>
                    <td>
                        <asp:TextBox ID="txtDonatAutorizacion" runat="server"></asp:TextBox>
                    </td>
                    <td class="style23">
                        Fecha de autorización del donativo:
                    </td>
                    <td>
                        <asp:TextBox ID="txtDonatFechautorizacion" runat="server"></asp:TextBox>
                        <asp:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" 
                            PopupButtonID="txtDonatFechautorizacion" 
                            TargetControlID="txtDonatFechautorizacion" />
                    </td>
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
                    <td class="style20" style="text-align: right;">
                        Sucursal
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlSucursales" runat="server" AppendDataBoundItems="True" 
                            DataTextField="Nombre" DataValueField="LugarExpedicion" />
                    </td>
                    <td class="style23" style="text-align:right">
                        Observaciones
                    </td>
                    <td>
                        <asp:TextBox ID="txtProyecto" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td class="style20" style="text-align: right">
                        Fondo de Pago
                    </td>
                    <td width="25%">
                        <asp:DropDownList ID="ddlCondicionesPago" runat="server" AutoPostBack="True" 
                            OnSelectedIndexChanged="ddlCondicionesPago_SelectedIndexChanged">
                            <asp:ListItem runat="server" Text="Pago en una sola exhibición" 
                                Value="Pago en una sola exhibición"></asp:ListItem>
                            <asp:ListItem runat="server" Text="En parcialidades" Value="En parcialidades"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
            <div ID="divParcialidades" runat="server" visible="False">
                <h1 style="text-align: center">
                    Parcialidades</h1>
                <table  width="95%">
                    <tr>
                        <td style="text-align: right">
                            Folio Fiscal Original
                        </td>
                        <td>
                            <asp:TextBox ID="txtFolioOriginal" runat="server" />
                        </td>
                        <td class="style3" style="text-align:right;">
                            Fecha del Folio Fiscal Original:
                        </td>
                        <td>
                            <asp:TextBox ID="txtFechaOriginal" runat="server" Width="100%" />
                            <asp:CalendarExtender ID="ceFechaOriginal" runat="server" 
                                PopupButtonID="txtFechaOriginal" TargetControlID="txtFechaOriginal" />
                            <asp:CompareValidator ID="dvFechaOriginal" runat="server" 
                                ControlToValidate="txtFechaOriginal" Display="Dynamic" 
                                ErrorMessage="* Fecha Invalida" Operator="DataTypeCheck" Type="Date" 
                                ValidationGroup="CrearFactura" />
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align:right;">
                            Monto del Folio Fiscal Original
                        </td>
                        <td>
                            <asp:TextBox ID="txtMontoOriginal" runat="server" Width="100%" />
                            <asp:CompareValidator ID="cvMontoOriginal" runat="server" 
                                ControlToValidate="txtMontoOriginal" Display="Dynamic" 
                                ErrorMessage="* Monto invalido" Operator="DataTypeCheck" Type="Currency" 
                                ValidationGroup="CrearFactura" />
                        </td>
                    </tr>
                </table>
            </div>
            <div ID="divViasConcesionadas" runat="server" visible="False">
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
                            <asp:TextBox ID="txtVoBoNombre" runat="server"></asp:TextBox>
                        </td>
                        <td style="text-align: right">
                            Puesto:
                        </td>
                        <td>
                            <asp:TextBox ID="txtVoBoPuesto" runat="server"></asp:TextBox>
                        </td>
                        <td style="text-align: right">
                            Area:
                        </td>
                        <td>
                            <asp:TextBox ID="txtVoBoArea" runat="server"></asp:TextBox>
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
                            <asp:TextBox ID="txtRecibiNombre" runat="server"></asp:TextBox>
                        </td>
                        <td style="text-align: right">
                            Puesto:
                        </td>
                        <td>
                            <asp:TextBox ID="txtRecibiPuesto" runat="server"></asp:TextBox>
                        </td>
                        <td style="text-align: right">
                            Area:
                        </td>
                        <td>
                            <asp:TextBox ID="txtRecibiArea" runat="server"></asp:TextBox>
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
                            <asp:TextBox ID="txtAutorizoNombre" runat="server"></asp:TextBox>
                        </td>
                        <td style="text-align: right">
                            Puesto:
                        </td>
                        <td>
                            <asp:TextBox ID="txtAutorizoPuesto" runat="server"></asp:TextBox>
                        </td>
                        <td style="text-align: right">
                            Area:
                        </td>
                        <td>
                            <asp:TextBox ID="txtAutorizoArea" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </div>
            <h1 style="text-align: center">
                Conceptos</h1>
            <table width="100%">
                <tr>
                    <td>
                        &nbsp;</td>
                </tr>
            </table>
            <asp:TabContainer ID="TabConceptosAddenda" runat="server" ActiveTabIndex="0" 
                Width="100%">
                <asp:TabPanel ID="tabConceptos" runat="server"  CssClass="page1" HeaderText="Conceptos">
                    <ContentTemplate>
                        <table width="95%">
                            <tr>
                                <td style="text-align: right;" width="15%">
                                    Cantidad
                                </td>
                                <td class="style1">
                                    <asp:TextBox ID="txtCantidad" runat="server" />
                                    <asp:CompareValidator ID="cvCantidad" runat="server" 
                                        ControlToValidate="txtCantidad" Display="Dynamic" 
                                        ErrorMessage="* Cantidad Invalida" Operator="DataTypeCheck" Type="Double" 
                                        ValidationGroup="AgregarConcepto" />
                                    <asp:RequiredFieldValidator ID="rfvCantidad" runat="server" 
                                        ControlToValidate="txtCantidad" Display="Dynamic" ErrorMessage="* Requerido" 
                                        ValidationGroup="AgregarConcepto" />
                                </td>
                                <td style="text-align: right;" width="15%">
                                    Unidad
                                </td>
                                <td>
                                    <asp:TextBox ID="txtUnidad" runat="server" />
                                    &nbsp;
                                    <asp:RequiredFieldValidator ID="rfvUnidad" runat="server" 
                                        ControlToValidate="txtUnidad" Display="Dynamic" ErrorMessage="* Requerido" 
                                        ValidationGroup="AgregarConcepto" />
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right;" width="15%">
                                    Gtin
                                </td>
                                <td class="style1">
                                    <asp:TextBox ID="txtCodigo" runat="server" />
                                </td>
                                <td style="text-align: right;" width="15%">
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
                                <td style="text-align: right;">
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
                                <td style="text-align: right;">
                                    &nbsp;
                                </td>
                                <td>
                                    <asp:TextBox ID="txtCuentaPredial" runat="server" Visible="False" />
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right;" width="15%">
                                    Descripción
                                </td>
                                <td colspan="3">
                                    <asp:TextBox ID="txtDescripcion" runat="server" TextMode="MultiLine" 
                                        Width="80%" />
                                    <asp:RequiredFieldValidator ID="rfvDescripcion" runat="server" 
                                        ControlToValidate="txtDescripcion" Display="Dynamic" ErrorMessage="* Requerido" 
                                        ValidationGroup="AgregarConcepto" />
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right;" width="15%">
                                    Observaciones
                                </td>
                                <td class="style1">
                                    <asp:TextBox ID="txtDetalles" runat="server" TextMode="MultiLine" Width="90%" />
                                </td>
                                <td>
                                    <asp:Button ID="btnAgregar" runat="server" class="btn btn-primary" 
                                        OnClick="btnAgregar_Click" Text="Agregar Concepto" 
                                        ValidationGroup="AgregarConcepto" />
                                </td>
                                <td>
                                    <asp:Button ID="btnBuscar" runat="server" class="btn btn-primary" 
                                        OnClick="btnBuscar_Click" Text="Buscar" Width="80px" />
                                    <asp:HiddenField ID="txtIdProducto" runat="server" />
                                </td>
                            </tr>
                            <br></br>
                            <tr>
                                <td colspan="4" style="overflow-y: scroll" >
                                    <asp:GridView ID="gvDetalles" runat="server" CssClass="style124" AutoGenerateColumns="False" 
                                        OnRowCommand="gvDetalles_RowCommand" ShowHeaderWhenEmpty="True" Width="100%">
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
                                            <asp:BoundField DataField="Descripcion2" HeaderText="Observaciones" />
                                            <asp:BoundField DataField="CuentaPredial" HeaderText="Cuenta Predial" />
                                            <asp:BoundField DataField="Precio" DataFormatString="{0:C}" 
                                                HeaderText="Precio Unitario">
                                            <ItemStyle HorizontalAlign="Right" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="PorcentajeIva" HeaderText="%I.V.A.">
                                            <ItemStyle HorizontalAlign="Right" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="ImporteIva" DataFormatString="{0:C}" 
                                                HeaderText="I.V.A.">
                                            <ItemStyle HorizontalAlign="Right" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="TotalPartida" DataFormatString="{0:C}" 
                                                HeaderText="Total">
                                            <ItemStyle HorizontalAlign="Right" />
                                            </asp:BoundField>
                                            <asp:ButtonField CommandName="Editar" Text="Editar" Visible="False">
                                            <ItemStyle HorizontalAlign="Center" />
                                            </asp:ButtonField>
                                            <asp:ButtonField CommandName="EliminarConcepto" Text="Eliminar" Visible="False">
                                            <ItemStyle HorizontalAlign="Center" />
                                            </asp:ButtonField>
                                        </Columns>
                                    </asp:GridView>
                                </td>
                                
                            </tr>
                        </table><br></br>
                    </ContentTemplate>
                </asp:TabPanel>
                <asp:TabPanel ID="TabAddendaAmc" runat="server"  CssClass="page1" HeaderText="Addenda AMC 7.1">
                    <ContentTemplate>
                        <asp:TabContainer ID="Options" runat="server" ActiveTabIndex="6" Width="100%">
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
                                                <asp:TextBox ID="RequestforPayment_UniqueCreatorIdentification" runat="server" 
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
                                                <td class="style5" style="text-align: right;">
                                                    Reference Identification
                                                </td>
                                                <td class="style8">
                                                    <asp:TextBox ID="OrderIdentification_ReferenceIdentification" runat="server"></asp:TextBox>
                                                    &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                                                        ControlToValidate="OrderIdentification_ReferenceIdentification" 
                                                        Display="Dynamic" 
                                                        ErrorMessage="Addenda-&gt;Order Identification *Campo Requerido" 
                                                        ValidationGroup="CrearFactura"></asp:RequiredFieldValidator>
                                                    &nbsp;
                                                </td>
                                                <td style="text-align: right">
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
                                                <td class="style5" style="text-align: right;">
                                                    Reference Identification
                                                </td>
                                                <td class="style7">
                                                    <asp:TextBox ID="AdditionalInformation_ReferenceIdentification" runat="server"></asp:TextBox>
                                                </td>
                                                <td style="text-align: right">
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
                                            <td colspan="6" style="text-align: center;" width="15%">
                                                Buyer
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right;" width="15%">
                                                Gln
                                            </td>
                                            <td colspan="5" style="text-align: left;" width="15%">
                                                <asp:TextBox ID="BuyerSeller_GlnBuyer" runat="server" MaxLength="13" 
                                                    OnTextChanged="TextBox3_TextChanged"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="text-align: center;" width="15%">
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
                                            <td class="style4" style="text-align: left;">
                                                <asp:TextBox ID="BuyerSeller_AlternatePrtyId" runat="server" MaxLength="40"></asp:TextBox>
                                            </td>
                                            <td style="text-align: right;" width="15%">
                                                Type
                                            </td>
                                            <td style="text-align: right;" width="15%">
                                                <asp:DropDownList ID="BuyerSeller_ListBox_Type" runat="server">
                                                    <asp:ListItem Value="IEPS_REFERENCE"></asp:ListItem>
                                                    <asp:ListItem Selected="True" Value="SELLER_ASSIGNED_IDENTIFIER_FOR_A_PARTY"></asp:ListItem>
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
                                                        <asp:ListItem>MXN</asp:ListItem>
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
                                                        <asp:ListItem>PAYMENT_CURRENCY</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td class="style10" style="text-align: right;">
                                                    Rate of change
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="Currency_RateOfChange" runat="server" Width="73px"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                                                        ControlToValidate="Currency_RateOfChange" 
                                                        ErrorMessage="Addenda-&gt;Currency *Tipo de cambio requerido" 
                                                        Operator="DataTypeCheck" Type="Double" ValidationGroup="CrearFactura"></asp:RequiredFieldValidator>
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
                                                        ControlToValidate="ReqForPayment_Percentage" 
                                                        ErrorMessage="Addenda-&gt;Req for Payment *Valor Porcentaje Requerido" 
                                                        Operator="DataTypeCheck" Type="Double" ValidationGroup="CrearFactura"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </ContentTemplate>
                            </asp:TabPanel>
                            <asp:TabPanel ID="TabPanel9" runat="server" HeaderText="TabPanel9">
                                <HeaderTemplate>
                                    Addenda Home Depot
                                </HeaderTemplate>
                                <ContentTemplate>
                                    <table style="width: 95%">
                                        <tr>
                                            <td style="text-align: right;" width="15%">
                                                Alternate trade item identification</td>
                                            <td class="style1">
                                                <asp:DropDownList ID="addendaHomeDeppot_AltTradItemId_DList" runat="server">
                                                    <asp:ListItem>BUYER_ASSIGNED</asp:ListItem>
                                                    <asp:ListItem>SUPPLIER_ASSIGNED</asp:ListItem>
                                                    <asp:ListItem>SERIAL_NUMBER</asp:ListItem>
                                                    <asp:ListItem>GLOBAL_TRADE_ITEM_IDENTIFICATION</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td colspan="3">
                                                <asp:TextBox ID="addendaHomeDeppot_AltTradItemId_Txt" runat="server" 
                                                    Width="465px"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style16" style="text-align: right;" width="15%">
                                                Pallet Quantity
                                            </td>
                                            <td class="style17">
                                                <asp:TextBox ID="addendaHomeDeppot_PalletQuantity" runat="server" 
                                                    MaxLength="15"></asp:TextBox>
                                            </td>
                                            <td class="style18" style="text-align: right;">
                                                Description</td>
                                            <td class="style19">
                                                <asp:DropDownList ID="addendaHomeDeppot_PalletInfo_Description_DList" 
                                                    runat="server">
                                                    <asp:ListItem>EXCHANGE_PALLETS</asp:ListItem>
                                                    <asp:ListItem>RETURN_PALLETS</asp:ListItem>
                                                    <asp:ListItem>PALLET_80x100</asp:ListItem>
                                                    <asp:ListItem>CASE</asp:ListItem>
                                                    <asp:ListItem>BOX</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td class="style16">
                                                <asp:TextBox ID="addendaHomeDeppot_Descriptiondesc_TextBox" runat="server" 
                                                    ontextchanged="addendaHomeDeppot_Descriptiondesc_TextBox_TextChanged" 
                                                    Width="266px"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right;" width="15%">
                                                Transport</td>
                                            <td class="style1" colspan="3">
                                                <asp:DropDownList ID="addendaHomeDeppot_Transport_Dlist" runat="server">
                                                    <asp:ListItem>PREPAID_BY_SELLER</asp:ListItem>
                                                    <asp:ListItem>PAID_BY_BUYER</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                            </asp:TabPanel>
                        </asp:TabContainer>
                        &nbsp;
                    </ContentTemplate>
                </asp:TabPanel>
            </asp:TabContainer>
            <div style="width: 900px">
            </div>
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
            <br/>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
                ValidationGroup="CrearFactura" />
            <div style="float: right">
                <table style="text-align: right;">
                    <tr style="width: 150px">
                        <td>
                            Subtotal:
                        </td>
                        <td>
                            <asp:Label ID="lblSubtotal" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            I.V.A.
                        </td>
                        <td>
                            <asp:Label ID="lblIva" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Total
                        </td>
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
                    OnClick="btnLimpiar_Click" Text="Limpiar" Width="70px" />
                &nbsp;&nbsp;&nbsp;
                <asp:Button ID="BtnVistaPrevia" runat="server" class="btn btn-primary" 
                    OnClick="btnGenerarPreview_Click" Text="Vista Previa" 
                    ValidationGroup="CrearFactura" />
                &nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnGenerarFactura" runat="server" class="btn btn-primary" 
                    OnClick="btnGenerarFactura_Click" style="height: 26px" Text="Generar Factura" 
                    ValidationGroup="CrearFactura" />
                <asp:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" 
                    ConfirmText="Confirma que deseas generar el comprobante" 
                    TargetControlID="btnGenerarFactura" />
            </p>
                </td>
        
         </tr>
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
                    Cuenta Predial:
                </td>
                <td style="text-align: left;">
                    <asp:TextBox runat="server" ID="txtCuentaPredialEdita" />
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
