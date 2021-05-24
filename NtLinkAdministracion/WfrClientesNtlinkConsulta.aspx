<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="WfrClientesNtlinkConsulta.aspx.cs" Inherits="NtLinkAdministracion.WfrClientesNtlinkConsulta" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<link href="Styles/StyleBoton.css" rel="stylesheet" type="text/css" />
    <h1>Consulta de Clientes</h1>
    <p>
        Empresa: <asp:DropDownList runat="server" ID="ddlEmpresa" AppendDataBoundItems="True" DataTextField="RazonSocial"
         DataValueField="IdEmpresa" Enabled="False" />
    </p>
    <p>
        RFC o Razón Social: <asp:TextBox runat="server" ID="txtBusqueda" Width="400px" />&nbsp;
        <asp:Button runat="server" ID="btnBuscar" class="btn btn-primary"  Text="Buscar" onclick="btnBuscar_Click"/>
    </p>
    <asp:GridView runat="server" ID="gvClientes" AutoGenerateColumns="False" onrowcommand="gvClientes_RowCommand"
     DataKeyNames="idCliente" AllowPaging="True" onpageindexchanging="gvClientes_PageIndexChanging" >
        <EmptyDataTemplate>
            No se encontraron registros.
        </EmptyDataTemplate>
        <Columns>
            <asp:BoundField HeaderText="RFC" DataField="RFC" />
            <asp:BoundField HeaderText="Razón Social" DataField="RazonSocial" />
            <asp:ButtonField Text="Editar" ButtonType="Link" CommandName="EditarCliente"/>
            <asp:TemplateField>
             <ItemTemplate>
                <asp:LinkButton Text="Eliminar" runat="server" ID="btnEliminarCliente" CommandArgument='<%# Eval("idCliente") %>' CommandName="Eliminar"/>
                <asp:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" TargetControlID="btnEliminarCliente" ConfirmText="Confirma que deseas eliminar el registro"/>
             </ItemTemplate>
            </asp:TemplateField>
            </Columns>
    </asp:GridView>
    <p><asp:Button ID="Button1" runat="server" class="btn btn-primary"  Text="Nuevo Cliente" OnClick="btnNuevoCliente_Click"/> </p>
     <p>
        <asp:Label runat="server" ID="lblError" ForeColor="Red" />
    </p>
</asp:Content>
