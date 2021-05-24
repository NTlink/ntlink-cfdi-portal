<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="wfrUsuariosAccesos.aspx.cs" Inherits="NtLinkAdministracion.wfrUsuariosAccesos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<link href="Styles/StyleBoton.css" rel="stylesheet" type="text/css" /> 
    <div runat="server" style="overflow-x: auto;" ID="divUsuarios">
        <h1>Usuarios</h1>
        <br />
        <p>
        Correo: <asp:TextBox runat="server" ID="txtBusqueda" Width="399px" 
            Height="21px" />&nbsp;
        <asp:Button runat="server" ID="btnBuscar" Text="Buscar" class="btn btn-primary"
            onclick="btnBuscar_Click" />
    </p>
        <asp:GridView DataKeyNames="Email" runat="server" ID="gvUserView" CssClass="page3"
            OnRowCommand="gvUserView_RowCommand" AutoGenerateColumns="false" Width="606px">
            <Columns>
                <asp:TemplateField>
                    <HeaderTemplate>Usuario</HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblUser" runat="server" Text='<%# Eval("Email") %>'>></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <HeaderTemplate>Ultimo Acceso</HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblFecha" runat="server" Text='<%# Eval("LastLoginDate") %>'>></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
              <%--  <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton runat="server" ID="lnkEdit" CssClass="btn btn-info" CommandName="Edit" CommandArgument='<%# ((GridViewRow) Container).RowIndex %>'>
                            &nbsp;Editar
                        </asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>--%>
            </Columns>
        </asp:GridView>
        &nbsp;<br /><br />
        
    </div> 
</asp:Content>
