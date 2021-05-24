<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="wfrReporteTimbra.aspx.cs" Inherits="GafLookPaid.wfrReporteTimbra" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<link href="Styles/StyleBoton.css" rel="stylesheet" type="text/css" />
    <div align="center">
             <asp:Panel ID="Panel3" runat="server" BorderStyle="Double" HorizontalAlign="Center" Width="100%" > 
     
      
        <h1>REPORTE GENERAL DE TIMBRADO</h1>
        <div style="width:100%;  text-align:center ">
               <asp:GridView ID="gvReporte" runat="server" AutoGenerateColumns="False"  HorizontalAlign="Center" 
            onrowdatabound="gvReporte_RowDataBound">
            <Columns>
                <asp:BoundField DataField="Rfc" HeaderText="RFC" />
                <asp:BoundField DataField="RazonSocial" HeaderText="Razon Social" />
                <asp:BoundField DataField="Contratados" HeaderText="Timbres Contratados" />
                <asp:BoundField DataField="Comsumidos" HeaderText="Timbres Comsumidos" />
                <asp:BoundField DataField="Porcentaje" HeaderText="%" />
            </Columns>
                   <RowStyle HorizontalAlign="Center" />
    </asp:GridView>
    </div>
    <br />

    </asp:Panel>
        <br />
                 <asp:Panel ID="Panel2" runat="server" BorderStyle="Double" HorizontalAlign="Center" Width="100%" > 
     
      
          <h1>REPORTE ANUAL </h1>
        <h3>&nbsp;</h3>
        <div style="text-align:center;">
    <table style="margin: 0 auto;">
        <tr>
           
            <td>Año:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td><asp:DropDownList runat="server" ID="ddlAnio2" AppendDataBoundItems="True"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td><asp:Button runat="server" ID="btnBuscar2" Text="Buscar" class="btn btn-primary"
                    onclick="btnBuscar2_Click" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td><asp:Button runat="server" ID="btnExcel" Text="Exportar a Excel" class="btn btn-primary"
                    onclick="btnExcel_Click"/></td>
        </tr>
    </table>
   
   
     </div>
    <div style="width:100%">
       <asp:GridView runat="server" ID="gvReporte2" AutoGenerateColumns="False" HorizontalAlign="Center" 
        CellPadding="4" style="text-align: center">
        <EmptyDataTemplate>
            No se encontraron registros.
        </EmptyDataTemplate>
        <Columns>
            <asp:BoundField HeaderText="RFC" DataField="Rfc"/>
            <asp:BoundField HeaderText="Cliente" DataField="Cliente"/>
            <asp:BoundField HeaderText="Emitidos" DataField="Emitidos" />
            <asp:BoundField HeaderText="Mes" DataField="Mes"/>
        </Columns>
    </asp:GridView>
    </div>
    <br />
    </asp:Panel>
        <br />
                 <asp:Panel ID="Panel1" runat="server" BorderStyle="Double" HorizontalAlign="Center" Width="100%" > 
     
      <h1>REPORTE DESGLOSADO POR EMPRESA</h1>
        <br />
        <div style="text-align:center;">
         <table style="margin: 0 auto;">
        <tr>
            <td>Mes:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td>
                <asp:DropDownList runat="server" ID="ddlMes">
                    <asp:ListItem Text="Todos" Value="0" />
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
            <td><asp:Button runat="server" ID="btnBuscar" Text="Buscar" 
                    onclick="btnBuscar_Click" class="btn btn-primary"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td>
                <asp:Button ID="btnExportar" runat="server" Text="Exportar a Excel" 
                    onclick="btnExportar_Click" class="btn btn-primary"/>
            </td>
        </tr>
    </table>
    </div>
    <div style="height: 450px;overflow: auto">
        <asp:GridView ID="gvReporteEmisor" runat="server" AutoGenerateColumns="False" HorizontalAlign="Center"  >
            <Columns>
                <asp:BoundField DataField="Rfc" HeaderText="RFC" />
                <asp:BoundField DataField="Cliente" HeaderText="Razon Social" />
                <asp:BoundField DataField="Emitidos" HeaderText="Timbres Emitidos" />
                <asp:BoundField DataField="Cancelados" HeaderText="Timbres Cancelados"  Visible="false"/>
            </Columns>
        </asp:GridView>
    </div>
             </asp:Panel>    
    </div>
    
</asp:Content>
