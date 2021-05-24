<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="wfrEjecutivosConsulta.aspx.cs" Inherits="NtLinkAdministracion.wfrEjecutivosConsulta" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<link href="Styles/StyleBoton.css"  rel="stylesheet" type="text/css" />
     <h1>Ejecutivos de ventas</h1>
    <hr/>
    <asp:GridView runat="server" ID="gvEjecutivos" AutoGenerateColumns="False" onrowcommand="gvEjecutivos_OnRowCommand"
     DataKeyNames="IdPromotor"  >
        <EmptyDataTemplate>
            No se encontraron registros.
        </EmptyDataTemplate>
        <Columns>
            <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
            <asp:BoundField HeaderText="Email" DataField="Email" />
            <asp:BoundField HeaderText="Telefono" DataField="Telefono" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton Text="Editar" runat="server" ID="btnEditar" CommandName="Editar" CommandArgument='<%#Eval("IdPromotor") %>'></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
           <%-- <asp:ButtonField Text="Eliminar" CommandName="Eliminar" />--%>
        </Columns>
    </asp:GridView>
    <div align="right">
        <asp:Button runat="server" ID="btnNuevo" class="btn btn-primary"  Text="Nuevo Ejecutivo" OnClick="btnNuevo_OnClick" />
    </div>
</asp:Content>
