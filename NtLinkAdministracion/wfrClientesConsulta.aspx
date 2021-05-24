<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="wfrClientesConsulta.aspx.cs" Inherits="NtLinkAdministracion.wfrClientesConsulta" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<link href="Styles/StyleBoton.css" rel="stylesheet" type="text/css" />
    <h1>Consulta de Clientes</h1>
    <p>
        RFC o Razón Social: <asp:TextBox runat="server" ID="txtBusqueda" Width="399px" 
            Height="21px" />&nbsp;
        <asp:Button runat="server" ID="btnBuscar" Text="Buscar" class="btn btn-primary"
            onclick="btnBuscar_Click" />
    </p>
    <p>
        Filtrar por ejecutivo de ventas
        <asp:DropDownList runat="server" ID="ddlEjecutivos" DataTextField="Nombre" AutoPostBack="True" OnSelectedIndexChanged="ddlEjecutivos_OnSelectedIndexChanged" DataValueField="IdPromotor"/>
    </p>
    <asp:GridView runat="server" ID="gvClientes" AutoGenerateColumns="False"  CssClass="page1"
     DataKeyNames="IdSistema" onrowcommand="gvClientes_RowCommand" 
        onrowdatabound="gvClientes_RowDataBound" style="text-align: center" >
        <EmptyDataTemplate>
            No se encontraron registros.
        </EmptyDataTemplate>
        <Columns>
            <asp:BoundField HeaderText="RFC" DataField="Rfc" />
            <asp:BoundField HeaderText="Razon Social" DataField="RazonSocial" />
             <asp:BoundField HeaderText="Consumo Emision" DataField="ConsumoEmision" />
              <asp:BoundField HeaderText="Consumo Timbrado" DataField="ConsumoTimbrado" />
          <%--  <asp:BoundField DataField="TimbresConsumidos" HeaderText="Timbres Consumidos" />--%>
            <asp:BoundField DataField="SaldoEmision" HeaderText="Saldo Emision" />
            <asp:BoundField DataField="SaldoTimbrado" HeaderText="Saldo Timbrado" />
            <asp:ButtonField Text="Editar" ButtonType="Link" CommandName="EditarSistema"/>
            <asp:ButtonField Text="Contratos" ButtonType="Link" CommandName="Contratos"/>
           <%-- <asp:ButtonField CommandName="Bloqueo" Text="Bloquear" />--%>
        </Columns>
    </asp:GridView>
    <div align="right">
    </div>
</asp:Content>
