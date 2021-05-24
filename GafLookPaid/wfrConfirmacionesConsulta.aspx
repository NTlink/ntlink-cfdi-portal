<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="wfrConfirmacionesConsulta.aspx.cs" Inherits="GafLookPaid.wfrConfirmacionesConsulta" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<link href="Styles/StyleBoton.css" rel="stylesheet" type="text/css" />
 
	<h1>Reporte de CONFIRMACIONES</h1>
	<p>
		<asp:Label runat="server" ID="lblError" ForeColor="Red" />
	</p>
   
	Empresa:&nbsp;<asp:DropDownList runat="server" ID="ddlEmpresas" AutoPostBack="true" DataTextField="RazonSocial" CssClass="form-control2"
		DataValueField="idEmpresa" onselectedindexchanged="ddlEmpresas_SelectedIndexChanged" />
	<div style="clear: both"></div>
	<table>
  <%--
		<tr>
			<td>Fecha Inicial:</td>
			<td>
				<asp:TextBox runat="server" ID="txtFechaInicial" Width="75px" />
				<asp:CompareValidator runat="server" ID="cvFechaInicial" ControlToValidate="txtFechaInicial" Display="Dynamic" 
				 ErrorMessage="* Fecha Invalida" Operator="DataTypeCheck" Type="Date" />
				<asp:CalendarExtender runat="server" ID="ceFechaInicial" Animated="False" PopupButtonID="txtFechaInicial" TargetControlID="txtFechaInicial" Format="dd/MM/yyyy" />
			</td>
			<td>Fecha Final:</td>
			<td>
				<asp:TextBox runat="server" ID="txtFechaFinal" />
				<asp:CompareValidator runat="server" ID="cvFechaFinal" ControlToValidate="txtFechaFinal" Display="Dynamic" 
				 ErrorMessage="* Fecha Invalida" Operator="DataTypeCheck" Type="Date" />
				<asp:CalendarExtender runat="server" ID="ceFechaFinal" Animated="False" PopupButtonID="txtFechaFinal" TargetControlID="txtFechaFinal" Format="dd/MM/yyyy" />
			</td>
			<td />
		</tr>
--%>
		<tr>
			<td>Clientes:</td>
			<td><asp:DropDownList runat="server" ID="ddlClientes" AppendDataBoundItems="True" DataTextField="RazonSocial"
			 DataValueField="idCliente" CssClass="form-control0" Width= "430px" /></td>
			<td><asp:Button runat="server" ID="btnBuscar" Text="Buscar" class="btn btn-primary"
			 onclick="btnBuscar_Click" /></td>
			<td></td>
			<td />
		</tr>
		<tr>
			<td />
			<td>
				&nbsp;</td>
			<td />
			<td></td>
			<td></td>
            <td></td>
		</tr>
	</table>
    <div></div>
    <div
        <asp:HiddenField runat="server" ID="hidSel" Value="Sel"/>
        <asp:GridView ShowFooter="True" runat="server" ID="gvFacturas" 
            AutoGenerateColumns="False" DataKeyNames="IdTimbre,Folio,RfcReceptor"
		onrowcommand="gvFacturas_RowCommand" AllowPaging="True" PageSize="9" CssClass="form-control2"
		onpageindexchanging="gvFacturas_PageIndexChanging" 
		onrowdatabound="gvFacturas_RowDataBound" style="text-align: center">
		<PagerSettings Position="Bottom" Visible="true" />
	    <FooterStyle BackColor="GreenYellow" Font-Bold="True" />
		<Columns>
        	
            <asp:BoundField HeaderText="Folio" DataField="Folio" />
			<asp:BoundField HeaderText="Timbrado" DataField="procesado" />
            <asp:BoundField HeaderText="Código de Confirmación" DataField="Confirmacion" />
			<asp:BoundField HeaderText="Fecha Emisión" DataField="FechaFactura" DataFormatString="{0:d}" />
			<asp:BoundField HeaderText="RfcReceptor" DataField="RfcReceptor" />
            <asp:BoundField HeaderText="RfcEmisor" DataField="RfcEmisor" />
            <asp:BoundField HeaderText="Error" DataField="Error" />
	     
	      <asp:TemplateField  HeaderText="Confirmar">
               <ItemTemplate>
                    <asp:Button class="btn btn-primary"   runat="server" Text="Confirmar"  CommandName="Confirmar" ID="btnCancelarf" CommandArgument='<%#Eval("IdTimbre") %>' Visible='<%# ProcessMyDataItem(Eval("Confirmacion")) == ""  %>' />
                    <asp:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" TargetControlID="btnCancelarf" ConfirmText="¿Confirmar Documento?" Enabled='<%#ProcessMyDataItem( Eval("Confirmacion")) == ""  %>' />
                </ItemTemplate>
                </asp:TemplateField>
            </Columns>
	</asp:GridView> 
    </div>
	
   
    <br />
   
	<asp:ModalPopupExtender runat="server" ID="mpePagar" TargetControlID="btnpagarDummy" BackgroundCssClass="mpeBack"
	 CancelControlID="btnCerrarPagar" PopupControlID="pnlPagar"/>

	<asp:ModalPopupExtender runat="server" ID="mpeEmail" TargetControlID="btnEmailDummy" BackgroundCssClass="mpeBack"
	 CancelControlID="btnCerrarEmail" PopupControlID="pnlEmail" />
	<asp:Button runat="server" ID="btnEmailDummy" style="display: none;" class="btn btn-primary"/>
	<asp:Button runat="server" ID="btnPagarDummy" style="display: none;" class="btn btn-primary"/>
</asp:Content>