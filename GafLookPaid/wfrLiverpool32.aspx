<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="wfrLiverpool32.aspx.cs" Inherits="GafLookPaid.wfrLiverpool32" %>
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
        .style5
        {
            width: 20%;
        }
        .style8
        {
            width: 336px;
        }
        .style11
        {
            width: 22%;
        }
        .style13
        {
            color: #000099;
        }
        .style14
        {
            width: 31%;
            text-align: right;
        }
        .style15
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
                    <td style="text-align: right">
                        <asp:Label runat="server" ID="lblFechaPago" Text="Fecha de Pago" Visible="False" />
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtFechaPago" Width="75px" Visible="False" />
                        <asp:CompareValidator runat="server" ID="cvFechaInicial" ControlToValidate="txtFechaPago"
                            Display="Dynamic" ErrorMessage="* Fecha Invalida" Operator="DataTypeCheck" Type="Date" />
                        <asp:CalendarExtender runat="server" ID="ceFechaInicial" Animated="False" PopupButtonID="txtFechaPago"
                            TargetControlID="txtFechaPago" Format="dd/MM/yyyy" />
                    </td>
                    <td style="text-align: right">
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
                        <asp:TextBox runat="server" ID="txtDiasRevision" Width="50px" Visible="false" />
                        <asp:CompareValidator runat="server" ID="cvTxtDiasRevision" ControlToValidate="txtDiasRevision"
                            Display="Dynamic" ErrorMessage="* Dato invalido" Type="Integer" Operator="DataTypeCheck" />
                    </td>
                </tr>
            </table>
            <p>
                Cliente:&nbsp;<asp:DropDownList runat="server" ID="ddlClientes" AutoPostBack="True"
                    DataTextField="RazonSocial" DataValueField="idCliente" 
                    OnSelectedIndexChanged="ddlClientes_SelectedIndexChanged" Height="17px" 
                    Width="137px" />
               &nbsp;&nbsp;
                <asp:TextBox ID="txtRazonSocial" runat="server" CssClass="page1" 
                    Enabled="False" Height="26px" TextMode="MultiLine" Width="291px" />
                  </p>
            <tr> 
        <td class="style13"></td>
        <td class="style16"><span class="style13">&nbsp;</span></td>
        <td class="style26"></td>
        <td></td>
        
         </tr>
            </span>
            <table width="100%" style="text-align:left">
                <tr runat="server" id="trDonativo" visible="False">
                    <td class="style11" style="text-align:right" >
                        N. de autorización del Donativo:
                    </td>
                    <td>    <asp:TextBox runat="server" ID="txtDonatAutorizacion"></asp:TextBox>
                    
                    </td>
                    <td class="style15" >
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
                    <td style="text-align:right;" class="style11">
                        Sucursal
                    </td>
                    <td>
                        <asp:DropDownList runat="server" ID="ddlSucursales" AppendDataBoundItems="True" DataValueField="LugarExpedicion"
                            DataTextField="Nombre" />
                    </td>
                    <td style="text-align:right" class="style15" >
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Observaciones
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtProyecto" Width="353px" />
                    </td>
                </tr>
                <tr>
                    <td style="text-align:right;" class="style11">
                        forma de Pago
                    </td>
                    <td width="25%">
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
                        <td style="text-align: right;">
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
                        <td style="text-align: right;">
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
            <h1 style="text-align: center">
                Conceptos</h1>
            <asp:TabContainer runat="server" ID="TabConceptosAddenda"  Width="100%" 
                ActiveTabIndex="1">
                <asp:TabPanel ID="tabConceptos" runat="server" CssClass="page1" HeaderText="Conceptos">
                    <ContentTemplate>
                        <table width="100%">
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
                                    &nbsp;
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtCuentaPredial" Visible="False" />
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
                                    <asp:Button runat="server" ID="btnBuscar" Text="Buscar" 
                                        OnClick="btnBuscar_Click" class="btn btn-primary" Width="80px"/>
                                    <asp:HiddenField ID="txtIdProducto" runat="server" />
                                </td>
                            </tr><br />
                            <caption>
                                                               
                                <tr>
                                    <td colspan="4" style="overflow-y: scroll">
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
                                        <br />
                                    </td>
                                </tr>
                              
                            </caption>
                        </table>
                    </ContentTemplate>
                </asp:TabPanel>
                <asp:TabPanel runat="server" CssClass="page1" HeaderText="Complemento Detallista" ID="TabAddendaAmc">
                    <ContentTemplate>
                        <table>
                            <tr>
                                <td style="text-align: right;" class="style5">
                                    Reference Identification
                                </td>
                                <td class="style8">
                                    <asp:TextBox ID="OrderIdentification_ReferenceIdentification" runat="server"></asp:TextBox>
                                    &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="detallista->Order Identification *Campo Requerido"
                                        ControlToValidate="OrderIdentification_ReferenceIdentification" Display="Dynamic"
                                        ValidationGroup="CrearFactura"></asp:RequiredFieldValidator>
                                    &nbsp;
                                </td>
                                <td style="text-align: right;" class="style5">
                                    Delivery Note
                                </td>
                                <td class="style8">
                                    <asp:TextBox ID="txtDeliveryNote" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="detallista->Delivery Note *Campo Requerido"
                                        ControlToValidate="txtDeliveryNote" Display="Dynamic"
                                        ValidationGroup="CrearFactura"></asp:RequiredFieldValidator>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right;">
                                    Buyer GLN
                                </td>
                                <td>
                                    <asp:TextBox ID="BuyerSeller_GlnBuyer" runat="server" MaxLength="13" ></asp:TextBox>
                                </td>
                                 <td style="text-align: right;">
                                    Person or Department Name
                                </td>
                                <td>
                                    <asp:TextBox ID="txtpersonOrDepartmentName" runat="server" ></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right;">
                                    Seller GLN
                                </td>
                                <td>
                                    <asp:TextBox ID="txtSellerGln" runat="server" MaxLength="13" ></asp:TextBox>
                                </td>
                                 <td style="text-align: right;">
                                    Alternate Party Identification
                                </td>
                                <td>
                                    <asp:TextBox ID="txtalternatePartyIdentification" runat="server" ></asp:TextBox>
                                </td>
                            </tr>
                            <tr><td></td></tr>
                        </table>
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
            <br />
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="CrearFactura" />
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
                    OnClick="btnLimpiar_Click" class="btn btn-primary" Width="70px"/>&nbsp;&nbsp;&nbsp;
                <asp:Button runat="server" ID="BtnVistaPrevia" Text="Vista Previa" OnClick="btnGenerarPreview_Click" class="btn btn-primary"
                    ValidationGroup="CrearFactura" />&nbsp;&nbsp;&nbsp;
                <asp:Button runat="server" ID="btnGenerarFactura" Text="Generar Factura" OnClick="btnGenerarFactura_Click" class="btn btn-primary"
                    ValidationGroup="CrearFactura" Style="height: 26px" />
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
