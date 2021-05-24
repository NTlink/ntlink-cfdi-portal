<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="wfrLicencias.aspx.cs" Inherits="NtLinkAdministracion.wfrLicencias" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<link href="Styles/StyleBoton.css" rel="stylesheet" type="text/css" />
    <h1>Consulta de Licencia y Altas</h1>
    <p>
       
        <asp:Button runat="server" ID="btnBuscar" Text="Generar" class="btn btn-primary"
            onclick="btnBuscar_Click" />
    </p>
    <asp:GridView runat="server" ID="gvLicencias" AutoGenerateColumns="False"  CssClass="page1"
     DataKeyNames="Id" onrowcommand="gvLicencias_RowCommand" 
        onrowdatabound="gvLicencias_RowDataBound" style="text-align: center" >
        <EmptyDataTemplate>
            No se encontraron registros.
        </EmptyDataTemplate>
        <Columns>
            <asp:BoundField HeaderText="RFC" DataField="RFC" />
            <asp:BoundField HeaderText="Licencia" DataField="key" />
             <asp:BoundField HeaderText="Fecha Alta" DataField="FechaAlta" />
              <asp:BoundField HeaderText="Fecha Activacion" DataField="FechaActivacion" />
            <asp:BoundField HeaderText="Administrador" DataField="Admin" />
   <%--         <asp:ButtonField Text="Editar" ButtonType="Link" CommandName="EditarSistema"/>
   --%>     </Columns>
    </asp:GridView>
    <div align="right">
    </div>
</asp:Content>
