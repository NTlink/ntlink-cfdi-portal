<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="wfrAdministradores.aspx.cs" Inherits="NtLinkAdministracion.wfrAdministradores" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<link href="Styles/StyleBoton.css" rel="stylesheet" type="text/css" /> 
    <div runat="server" style="overflow-x: auto;" ID="divUsuarios">
        <h1>Usuarios</h1>
        <br />
        <asp:GridView DataKeyNames="idusuario" runat="server" ID="gvUserView" CssClass="page3"
            OnRowCommand="gvUserView_RowCommand" AutoGenerateColumns="false" Width="306px">
            <Columns>
                <asp:TemplateField>
                    <HeaderTemplate>Usuario</HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblUser" runat="server" Text='<%# Eval("Nombre") %>'>></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton runat="server" ID="lnkEdit" CssClass="btn btn-info" CommandName="Edit" CommandArgument='<%# ((GridViewRow) Container).RowIndex %>'>
                            &nbsp;Editar
                        </asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        &nbsp;<br /><br />
        <asp:Button runat="server" ID="lnkCreate"  class="btn btn-primary" OnClick="lnkCreate_Click" Text="Crear">
            
        </asp:Button>
    </div> 
</asp:Content>
