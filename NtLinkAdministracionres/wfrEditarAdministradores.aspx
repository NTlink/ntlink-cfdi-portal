<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="wfrEditarAdministradores.aspx.cs" Inherits="NtLinkAdministracion.wfrEditarAdministradores" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server"> 
<link href="Styles/StyleBoton.css" rel="stylesheet" type="text/css" />
    <div id="dvData">
        <table>
            <tr>
                <td>Usuario</td>
                <td>
                    <asp:TextBox ID="txbUser" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="rfvUser" ValidationGroup="user" Display="Dynamic" ControlToValidate="txbUser"
                        ErrorMessage="* Requerido"></asp:RequiredFieldValidator>
                </td>
                <td>Nombre</td>
                <td>
                    <asp:TextBox ID="txbName" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="rfvName" ValidationGroup="user" Display="Dynamic" ControlToValidate="txbName"
                        ErrorMessage="* Requerido"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>Apellido Paterno</td>
                <td>
                    <asp:TextBox ID="txbAPaterno" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="rfvPaterno" ValidationGroup="user" Display="Dynamic" ControlToValidate="txbAPaterno"
                        ErrorMessage="* Requerido"></asp:RequiredFieldValidator>
                </td>
                <td>Apellido Materno</td>
                <td>
                    <asp:TextBox ID="txbAMaterno" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="rfvMaterno" ValidationGroup="user" Display="Dynamic" ControlToValidate="txbAMaterno"
                        ErrorMessage="* Requerido"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td><asp:label runat="server" ID="lblPass">Password Actual</asp:label></td>
                <td>
                    <asp:TextBox ID="txbPass" runat="server" Text="[Oculto]" TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="rfvPass" ValidationGroup="password" Display="Dynamic" ControlToValidate="txbPass"
                        ErrorMessage="* Requerido"></asp:RequiredFieldValidator>
                </td>
                <td>
                   
                </td>
                <td>      
                </td>
            </tr>
            <tr>
                <td><asp:label runat="server" ID="lblPassRefresh"  Visible="false">Nuevo Password</asp:label></td>
                <td>
                    <asp:TextBox ID="txbPassRefresh" runat="server" Visible="false" TextMode="Password"></asp:TextBox>
                </td>
                <td><asp:label runat="server" ID="lblConfirm" Visible="false">Confirmar</asp:label></td>
                <td>
                    <asp:TextBox ID="txbConfirm" runat="server" Visible="false" Text="" TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="rfvConfirm" Display="Dynamic" ValidationGroup="password" ControlToValidate="txbConfirm"
                        ErrorMessage="* Requerido"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr/>
            </table>
         Para cambiar el password debes de ingresar tu password actual
                    <br />
                    <asp:Button runat="server" ID="lnkChange" OnClick="lnkChange_Click" ValidationGroup="password" class="btn btn-primary"
                        Text="Cambiar password">
                        
                    </asp:Button>
        <br/><br/>
        <table>
            <tr>
                <td>
                    <asp:Button runat="server" ID="lnkSave"  class="btn btn-primary" OnClick="lnkSave_Click" ValidationGroup="user" Text="Guardar">
                        
                    </asp:Button>
                </td>
            </tr>
            <tr/>
            <tr>
                <asp:GridView DataKeyNames="path"  runat="server" ID="gvAdminSettings" Visible="false" AutoGenerateColumns="false" OnRowDataBound="gvAdminSettings_RowDataBound">
                    <Columns>
                        <asp:TemplateField>
                                <HeaderTemplate>Path</HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblUser" runat="server" Text='<%# Eval("path") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>Selecionados</HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="ckbSelected" AutoPostBack="true" runat="server" OnCheckedChanged="ckbSelected_CheckedChanged"/>          
                                </ItemTemplate>
                            </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </tr>
        </table>
    </div>
</asp:Content>