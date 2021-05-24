<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="wfrComisionistasConsulta.aspx.cs" Inherits="GafLookPaid.wfrComisionistas" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<link href="Styles/StyleBoton.css" rel="stylesheet" type="text/css" />
    <h1>Consulta Promotores</h1>
    <asp:GridView runat="server" ID="gvComisionistas" onrowcommand="gvComisionistas_RowCommand" DataKeyNames="IdComisionista"
     AutoGenerateColumns="False" AllowPaging="True" onpageindexchanging="gvComisionistas_PageIndexChanging" >
        <EmptyDataTemplate>No existen registros</EmptyDataTemplate>
        <Columns>
            <asp:BoundField  DataField="Nombre" HeaderText="Nombre" />
            <asp:BoundField  DataField="Email" HeaderText="Email" />
            <asp:BoundField  DataField="Telefono" HeaderText="Teléfono" />
            <asp:ButtonField ButtonType="Link" Text="Editar" CommandName="EditarComisionista"/>
        </Columns>
    </asp:GridView>
    <div align="right">
        <asp:Button runat="server" ID="btnNuevoComisionista" Text="Nuevo Comisionista"  class="btn btn-primary"   onclick="btnNuevoComisionista_Click"/>
    </div>
</asp:Content>
