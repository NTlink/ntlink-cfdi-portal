<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="wftTimbrado.aspx.cs" Inherits="NtLinkAdministracion.wftTimbrado" %>

<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit, Version=3.5.7.607, Culture=neutral, PublicKeyToken=28f01b0e84b6d53e" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<link href="Styles/StyleBoton.css" rel="stylesheet" type="text/css" />
    <h1>
        Consulta de Timbrado</h1>
    <table>
        <tr>
            <td>
                RFC Emisor
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtRfc"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Folio Factura (UUID)
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtUuid"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Fecha Inicial:
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtFechaInicial" Width="75px" />
                <asp:CompareValidator runat="server" ID="cvFechaInicial" ControlToValidate="txtFechaInicial"
                    Display="Dynamic" ErrorMessage="* Fecha Invalida" Operator="DataTypeCheck" Type="Date" />
                <asp:CalendarExtender runat="server" ID="ceFechaInicial" Animated="False" PopupButtonID="txtFechaInicial"
                    TargetControlID="txtFechaInicial" Format="dd/MM/yyyy" />
            </td>
            <td>
                Fecha Final:
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtFechaFinal" />
                <asp:CompareValidator runat="server" ID="cvFechaFinal" ControlToValidate="txtFechaFinal"
                    Display="Dynamic" ErrorMessage="* Fecha Invalida" Operator="DataTypeCheck" Type="Date" />
                <asp:CalendarExtender runat="server" ID="ceFechaFinal" Animated="False" PopupButtonID="txtFechaFinal"
                    TargetControlID="txtFechaFinal" Format="dd/MM/yyyy" />
            </td>
            <td />
        </tr>
        <tr>
            <td>
                
            </td>
            <td>
                <asp:Button runat="server" Text="Buscar" class="btn btn-primary"  OnClick="txtBuscar_OnClick" ID="txtBuscar"/>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label runat="server" ID="lblError"></asp:Label>
            </td>
        </tr>
    </table>
    <div style="height: 450px; overflow: scroll">
        <asp:GridView runat="server" ID="gvFacturas" AutoGenerateColumns="False" DataKeyNames="UUID, IdTimbre"
		Width="95%">
		<Columns>
			<asp:BoundField HeaderText="Uuid" DataField="Uuid" />
			<asp:BoundField HeaderText="RFC Emisor" DataField="RfcEmisor" />
			<asp:BoundField HeaderText="RFC Receptor" DataField="RfcReceptor" />
			<asp:BoundField HeaderText="Fecha Timbrado" DataField="FechaFactura" />
            <asp:BoundField HeaderText="Fecha Envío" DataField="FechaEnvio" />
		</Columns>
	</asp:GridView> 

    </div>

    
 
</asp:Content>
