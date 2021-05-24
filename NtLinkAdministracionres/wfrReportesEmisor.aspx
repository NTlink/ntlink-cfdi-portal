<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="wfrReportesEmisor.aspx.cs" Inherits="NtLinkAdministracion.wfrReportesEmisor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<link href="Styles/StyleBoton.css" rel="stylesheet" type="text/css" />
    <h1>Reporte Por Cliente</h1>
    <h3>Mes de Generacion</h3>
    <table>
        <tr>
            <td>Mes:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td>
                <asp:DropDownList runat="server" ID="ddlMes">
                    <asp:ListItem Text="Enero" Value="1" />
                    <asp:ListItem Text="Febrero" Value="2" />
                    <asp:ListItem Text="Marzo" Value="3" />
                    <asp:ListItem Text="Abril" Value="4" />
                    <asp:ListItem Text="Mayo" Value="5" />
                    <asp:ListItem Text="Junio" Value="6" />
                    <asp:ListItem Text="Julio" Value="7" />
                    <asp:ListItem Text="Agosto" Value="8" />
                    <asp:ListItem Text="Septiembre" Value="9" />
                    <asp:ListItem Text="Octubre" Value="10" />
                    <asp:ListItem Text="Noviembre" Value="11" />
                    <asp:ListItem Text="Diciembre" Value="12" />
                </asp:DropDownList>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </td>
            <td>Año:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td><asp:DropDownList runat="server" ID="ddlAnio" AppendDataBoundItems="True"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td><asp:Button runat="server" ID="btnBuscar" Text="Buscar" class="btn btn-primary" 
                    onclick="btnBuscar_Click" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td><asp:Button runat="server" ID="btnExcel" Text="Exportar a Excel" class="btn btn-primary"
                    onclick="btnExcel_Click"/></td>
        </tr>
    </table>
    <table>
        <tr>
            <td>Cliente:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td><asp:DropDownList runat="server" ID="ddlCliente" AppendDataBoundItems="True" Width="95%"
                    AutoPostBack="True" onselectedindexchanged="ddlCliente_SelectedIndexChanged"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
        </tr>
    </table>
    <table>
        <tr>
            <td>Emisor:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td>
            
            <asp:DropDownList runat="server" ID="ddlEmisor" AppendDataBoundItems="True"  
                                  AutoPostBack="True" onselectedindexchanged="ddlEmisor_SelectedIndexChanged" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
        </tr>
    </table>
    <asp:GridView runat="server" ID="gvReporte" AutoGenerateColumns="False" CellPadding="4" style="text-align: center">
        <EmptyDataTemplate>
            No se encontraron registros.
        </EmptyDataTemplate>
        <Columns>
            <asp:BoundField HeaderText="RFC" DataField="Rfc"/>
            <asp:BoundField HeaderText="Cliente" DataField="Cliente"/>
            <asp:BoundField HeaderText="Emitidos" DataField="Emitidos"/>
            <%--<asp:BoundField HeaderText="Cancelados" DataField="Mes"/>--%>
        </Columns>
    </asp:GridView>
</asp:Content>
