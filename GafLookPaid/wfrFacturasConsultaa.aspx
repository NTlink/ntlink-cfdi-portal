<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="wfrFacturasConsulta.aspx.cs" Inherits="GafLookPaid.wfrFacturasConsulta" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    <link href="Styles/StyleBoton.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .style125
        {
            width: 65px;
        }
        .style126
        {
            width: 39px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
  
	<h1>Reporte de CFDI</h1>
	<p>
		<asp:Label runat="server" ID="lblError" ForeColor="Red" CssClass="alert-error" />
	</p>
    <p>
        <a href="https://portalcfdi.facturaelectronica.sat.gob.mx" target="_blank">Sitio de cancelación del SAT</a>
    </p>
    <table class="table-bordered">
    <tr>
    <td>Empresa:</td>
	<td><asp:DropDownList runat="server" ID="ddlEmpresas" AutoPostBack="true" DataTextField="RazonSocial" CssClass="form-control2"
		DataValueField="idEmpresa" onselectedindexchanged="ddlEmpresas_SelectedIndexChanged" /></td>
      <td>Clientes:</td>
			<td><asp:DropDownList runat="server" ID="ddlClientes" AppendDataBoundItems="True" DataTextField="RazonSocial"
			 DataValueField="idCliente" CssClass="form-control0" Width= "480px" /></td>
		</tr>
        <tr>
     
        <td>Fecha Inicial:</td>
			<td>
				<asp:TextBox runat="server" ID="txtFechaInicial" CssClass="form-control2" />
				<asp:CompareValidator runat="server" ID="cvFechaInicial" ControlToValidate="txtFechaInicial" Display="Dynamic" 
				 ErrorMessage="* Fecha Invalida" Operator="DataTypeCheck" Type="Date" />
				<asp:CalendarExtender runat="server" ID="ceFechaInicial" Animated="False" PopupButtonID="txtFechaInicial" TargetControlID="txtFechaInicial" Format="dd/MM/yyyy" />
			</td>
			<td>Fecha Final:</td>
			<td>
				<asp:TextBox runat="server" ID="txtFechaFinal" CssClass="form-control2"/>
				<asp:CompareValidator runat="server" ID="cvFechaFinal" ControlToValidate="txtFechaFinal" Display="Dynamic" 
				 ErrorMessage="* Fecha Invalida" Operator="DataTypeCheck" Type="Date" />
				<asp:CalendarExtender runat="server" ID="ceFechaFinal" Animated="False" PopupButtonID="txtFechaFinal" TargetControlID="txtFechaFinal" Format="dd/MM/yyyy" />
			</td></tr>

		<tr>
			<td>Texto:</td>
			<td><asp:TextBox runat="server" ID="txtTexto" CssClass="form-control2" /></td>
		<td><asp:Button runat="server" ID="btnBuscar" Text="Buscar" 
			 onclick="btnBuscar_Click" class="btn btn-primary"/></td>
		</tr>
		<tr>
         <td></td>
		<td><asp:RadioButtonList RepeatDirection="Horizontal" ID="rbStatus" runat="server" > 
					<asp:ListItem Text="Todas" Value="Todos" Selected="True"/>
					
					<asp:ListItem Text="Pendientes" Value="Pendiente"/>
				    <asp:ListItem Text="Pagadas" Value="Pagado" />
                    <asp:ListItem Text="Canceladas" Value="Cancelado"/>
				
				</asp:RadioButtonList>
            
			<td><asp:Button runat="server" ID="btnExportar" Text="Exportar Excel" 
                    onclick="btnExportar_Click" class="btn btn-primary" /></td>
            <td><asp:Button runat="server"  ID="btnDescargarTodo" 
                    Text="Descargar Seleccionados" OnClick="btnDescargarTodo_OnClick" 
                    class="btn btn-primary"/></td>
                   
                   </td>
	</table><br />
    <div style="height:60%; overflow-y: scroll;>
        <asp:HiddenField runat="server" ID="hidSel"  Value="Sel"/>
        <asp:GridView ShowFooter="True" runat="server"  CssClass="style124" 
            ID="gvFacturas" AutoGenerateColumns="False" DataKeyNames="Guid,IdCliente,idventa"
		onrowcommand="gvFacturas_RowCommand" AllowPaging="True" PageSize="10" 
		onpageindexchanging="gvFacturas_PageIndexChanging" 
		onrowdatabound="gvFacturas_RowDataBound">
		<PagerSettings Position="Bottom" Visible="true" />
	    <FooterStyle BackColor="#A8CF38"  Font-Bold="True" />
		<Columns>
			<asp:BoundField HeaderText="Folio" DataField="folio" />
			<asp:BoundField HeaderText="Folio Fiscal" DataField="Guid" />
			<asp:BoundField HeaderText="Fecha Emisión" DataField="fecha" DataFormatString="{0:d}" />
			<asp:BoundField HeaderText="Cliente" DataField="Cliente" />
            <asp:BoundField HeaderText="RFC" DataField="Rfc" />
			<asp:BoundField HeaderText="% I.V.A." DataField="PorcentajeIva" DataFormatString="{0:F2}" ItemStyle-HorizontalAlign="Right" />
			<asp:BoundField HeaderText="SubTotal" DataField="Subtotal" DataFormatString="{0:C}" ItemStyle-HorizontalAlign="Right" />
			<asp:BoundField HeaderText="I.V.A." DataField="IVA" DataFormatString="{0:C}" ItemStyle-HorizontalAlign="Right" />
            <asp:BoundField HeaderText="Retención I.V.A." DataField="RetIva" DataFormatString="{0:C}" ItemStyle-HorizontalAlign="Right" />
            <asp:BoundField HeaderText="Retención I.S.R." DataField="RetIsr" DataFormatString="{0:C}" ItemStyle-HorizontalAlign="Right" />
            <asp:BoundField HeaderText="I.E.P.S." DataField="Ieps" DataFormatString="{0:C}" ItemStyle-HorizontalAlign="Right" />

			<asp:BoundField HeaderText="Total" DataField="Total" DataFormatString="{0:C}" ItemStyle-HorizontalAlign="Right" />
            <asp:BoundField HeaderText="Usuario" DataField="Usuario"/>
			<asp:BoundField HeaderText="Status CFDI" DataField="StatusFactura"/>
            <asp:BoundField HeaderText="Fecha Cancelación" DataField="FechaCancelacion" />
			<asp:ButtonField ButtonType="Link" Text="Pagar" CommandName="Pagar" />
			<asp:ButtonField ButtonType="Link" Text="XML" CommandName="DescargarXml" />
			<asp:ButtonField ButtonType="Link" Text="PDF" CommandName="DescargarPdf" />
			<asp:ButtonField ButtonType="Link" Text="Enviar Email" CommandName="EnviarEmail" />
            <asp:TemplateField  HeaderText="Cancelar">
                <ItemTemplate>
                    <asp:Button class="btn btn-primary"   runat="server" Text='<%# (short)Eval("Cancelado") == 1 ? "Acuse Cancelacion" : "Cancelar"  %>'  CommandName='<%# (short)Eval("Cancelado") == 1 ? "Acuse" : "Cancelar"  %>' ID="btnCancelarf" CommandArgument='<%#Eval("idventa") %>'  />
                    <asp:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" TargetControlID="btnCancelarf" ConfirmText="¿Cancelar Documento?" Enabled='<%# (short)Eval("Cancelado") != 1  %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField  HeaderText="Seleccionar" ItemStyle-HorizontalAlign="Center">
                <HeaderTemplate>
                    <asp:Button class="btn btn-primary"  runat="server" ID="btnSelectAll" Text='<%# this.SelText %>' CommandName="SelectAll" />
                </HeaderTemplate>
                <ItemTemplate> 
                    
                    <asp:CheckBox ID="cbChecked" runat="server" Checked='<%# (bool)Eval("Seleccionar") %>'/>
                </ItemTemplate>
            </asp:TemplateField>
		</Columns>
	</asp:GridView> 
    </div>
	
   
	<asp:GridView ID="gvFacturaCustumer"  CssClass="page2" Visible="False" runat="server" AutoGenerateColumns="False" >
        <Columns>
            <asp:BoundField HeaderText="Folio" DataField="folio" />
			<asp:BoundField HeaderText="Folio Fiscal" DataField="Guid" />
			<asp:BoundField HeaderText="Fecha" DataField="fecha" DataFormatString="{0:d}" />
			<asp:BoundField HeaderText="Cliente" DataField="Cliente" />
            <asp:BoundField HeaderText="RFC" DataField="Rfc" />
			<asp:BoundField HeaderText="% I.V.A." DataField="PorcentajeIva" DataFormatString="{0:F2}" ItemStyle-HorizontalAlign="Right" />
			<asp:BoundField HeaderText="SubTotal" DataField="Subtotal" DataFormatString="{0:C}" ItemStyle-HorizontalAlign="Right" />
			<asp:BoundField HeaderText="I.V.A." DataField="IVA" DataFormatString="{0:C}" ItemStyle-HorizontalAlign="Right" />
            <asp:BoundField HeaderText="Retención I.V.A." DataField="RetIva" DataFormatString="{0:C}" ItemStyle-HorizontalAlign="Right" />
            <asp:BoundField HeaderText="Retención I.S.R." DataField="RetIsr" DataFormatString="{0:C}" ItemStyle-HorizontalAlign="Right" />
            <asp:BoundField HeaderText="I.E.P.S." DataField="Ieps" DataFormatString="{0:C}" ItemStyle-HorizontalAlign="Right" />

			<asp:BoundField HeaderText="Total" DataField="Total" DataFormatString="{0:C}" ItemStyle-HorizontalAlign="Right" />
            <asp:BoundField HeaderText="Usuario" DataField="Usuario"/>
			<asp:BoundField HeaderText="Status" DataField="StatusFactura"/>
        </Columns>
    </asp:GridView>
    <br />
   
	<asp:ModalPopupExtender runat="server" ID="mpePagar" TargetControlID="btnpagarDummy" BackgroundCssClass="mpeBack"
	 CancelControlID="btnCerrarPagar" PopupControlID="pnlPagar"/>
	<asp:Panel runat="server" ID="pnlPagar" CssClass="page3" BackColor="White"  style="text-align: center;">
		<h1>Pagar Factura</h1>
		<asp:Label runat="server" ID="lblIdventa" Visible="False" />
		<asp:Label runat="server" ID="lblErrorPago" ForeColor="Red" />
	    No. de Folio: <asp:Label runat="server" ID="lblFolioPago" />
		<table class="table" align="center">
			<tr>
         
            
            <td>Fecha Pago: <asp:TextBox runat="server" ID="txtFechaPago" Text='<%# DateTime.Now %>' CssClass="form-control0" />
			<asp:CompareValidator runat="server" ID="cvFechaPago" ControlToValidate="txtFechaPago" Display="Dynamic" 
			 ErrorMessage="* Fecha Invalida" Operator="DataTypeCheck" Type="Date" ValidationGroup="Pago" />
            </td>
            </tr>

			<asp:CalendarExtender runat="server" ID="ceFechaPago" TargetControlID="txtFechaPago" PopupButtonID="txtFechaPago" Format="dd/MM/yyyy" />
			<asp:RequiredFieldValidator runat="server" ID="rfvFechaPago" ErrorMessage="* Requerido" ControlToValidate="txtFechaPago"
			 ValidationGroup="Pago" Display="Dynamic"/>
		<tr>
        
		<td>
			Referencia: <asp:TextBox runat="server" ID="txtReferenciaPago" CssClass="form-control0" />
			<asp:RequiredFieldValidator runat="server" ID="rfvReferenciaPago" ErrorMessage="* Requerido"
			 ControlToValidate="txtReferenciaPago" ValidationGroup="Pago" Display="Dynamic"/>
		</td>
        </tr>
        <tr>
       
	<td>	<asp:Button runat="server" ID="btnPagar" Text="Pagar" onclick="btnPagar_Click" ValidationGroup="Pago" class="btn btn-primary"/>&nbsp;&nbsp;
		<asp:Button runat="server" ID="btnCerrarPagar" Text="Cancelar" class="btn btn-primary"
            onclick="btnCerrarPagar_Click" />
		</td>
        </tr>
            <caption>
                <br />
                <br />
            </caption>
    </asp:Panel>
    </table>
	<asp:ModalPopupExtender runat="server" ID="mpeEmail" TargetControlID="btnEmailDummy" BackgroundCssClass="mpeBack"
	 CancelControlID="btnCerrarEmail" PopupControlID="pnlEmail" />
	<asp:Panel runat="server" ID="pnlEmail" style="text-align: center;" CssClass="page2" Width="800px" BackColor="White">
		<h1>Direcciones de envio</h1>
		<asp:Label runat="server" ID="lblGuid" Visible="False" />
		<p>
			Se enviara a: <asp:Label runat="server" ID="lblEmailCliente" />
		</p>
		<p>
			Correos adicionales:
			<asp:TextBox runat="server" ID="txtEmails" CssClass="form-control2" />&nbsp;&nbsp;&nbsp;
			<span style="font-size: 8pt;">Separados por comas</span>
		</p>
		<br />
		<asp:Button runat="server" ID="btnEnviarEmail" Text="Enviar" onclick="btnEnviarMail_Click" class="btn btn-primary"/>&nbsp;&nbsp;
		<asp:Button runat="server" ID="btnCerrarEmail" Text="Cancelar" class="btn btn-primary"/>
	</asp:Panel>
	<asp:Button runat="server" ID="btnEmailDummy" style="display: none;" class="btn btn-primary"/>
	<asp:Button runat="server" ID="btnPagarDummy" style="display: none;" class="btn btn-primary"/>
</asp:Content>