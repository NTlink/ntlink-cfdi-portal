<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="wfrReportesMensual.aspx.cs" Inherits="NtLinkAdministracion.wfrReportesMensual" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<link href="Styles/StyleBoton.css" rel="stylesheet" type="text/css" />
    <h1>Reporte Mensual</h1>
    <h3></h3>
    <table>
        <tr>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td><asp:Button runat="server" ID="btnBuscar" Text="Buscar" class="btn btn-primary"
                    onclick="btnBuscar_Click" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td><asp:Button runat="server" ID="btnExcel" Text="Exportar a Excel" class="btn btn-primary"
                    onclick="btnExcel_Click"/></td>
        </tr>
    </table>
        <asp:Panel ID="Panel1" runat="server" BorderStyle="Double" HorizontalAlign="Center" Width="100%" > 
   
     <div style="width: 100%; overflow: auto">
      
    <asp:GridView runat="server" ID="gvReporte" AutoGenerateColumns="False" CellPadding="4" >
        <EmptyDataTemplate>
            No se encontraron registros.
        </EmptyDataTemplate>
        <Columns>
            <asp:BoundField HeaderText="IdSIstema" DataField="IdSIstema"/>
            <asp:BoundField HeaderText="RFC" DataField="Rfc"/>
            <asp:BoundField HeaderText="Razon Social" DataField="RazonSocial"/>
            <asp:BoundField HeaderText="Contacto" DataField="Contacto"/>
            <asp:BoundField HeaderText="Telefono" DataField="Telefono"/>
            <asp:BoundField HeaderText="Email" DataField="Email"/>
            <asp:BoundField HeaderText="Contratados" DataField="Timbrado"/>
            <asp:BoundField HeaderText="Emitidos" DataField="consumoEmision"/>
            <asp:BoundField HeaderText="Timbrado" DataField="consumoTimbrado"/>
             <asp:BoundField HeaderText="Totales" DataField="Totales"/>
             <asp:BoundField HeaderText="Porcentaje" DataField="porcentaje"/>
             <asp:BoundField HeaderText="Saldo" DataField="Saldo"/>
        </Columns>
    </asp:GridView>
    </div>
     </asp:Panel>
   
</asp:Content>
