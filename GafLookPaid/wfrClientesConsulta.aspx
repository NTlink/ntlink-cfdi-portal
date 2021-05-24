 
     <%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="wfrClientesConsulta.aspx.cs" Inherits="GafLookPaid.wfrClientesConsulta" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
  
    <style type="text/css">
        .style125
        {
            width: 69px;
        }
        .style126
        {
            width: 128px;
        }
        .style127
        {
            width: 128px;
        }
    </style>
  
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<link href="Styles/StyleBoton.css" rel="stylesheet" type="text/css" />
    <h1>Consulta de Clientes</h1>
    <table class="table-bordered">
        <tr>
    <td class="style126"> Empresa:</td>
       
     <td><asp:DropDownList runat="server" ID="ddlEmpresa" AppendDataBoundItems="True" DataTextField="RazonSocial"
         DataValueField="IdEmpresa" Enabled="False" CssClass="form-control2" /></td>
  
    
     <td>
        <asp:Label runat="server" ID="lblError" ForeColor="Red" CssClass="alert-error" />
    </td>
      </tr>

      <br />
      
    <tr>
    <td class="style127">RFC o Razón Social:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td>
        <td><asp:TextBox runat="server" ID="txtBusqueda" CssClass="form-control2" Width="300"/>
           </td> 
              <td> <asp:Button runat="server" ID="btnBuscar" Text="Buscar" 
            onclick="btnBuscar_Click" class="btn btn-primary" 
            />
            </td>
           <td><asp:Button ID="Button1" runat="server" Text="Nuevo Cliente" OnClick="btnNuevoCliente_Click" class="btn btn-primary" />
  </td>  </tr>
    </table>
    <br />
     <br />
      <br />
    <asp:GridView runat="server" ID="gvClientes" AutoGenerateColumns="False" class="table-hover" Width="90%"
        onrowcommand="gvClientes_RowCommand" 
     DataKeyNames="idCliente" AllowPaging="True" 
        onpageindexchanging="gvClientes_PageIndexChanging" style="color: #000000" >
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
                <asp:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" TargetControlID="btnEliminarCliente" ConfirmText="Confirma que deseas eliminar el registro" />
             </ItemTemplate>
            </asp:TemplateField>
            </Columns>
    </asp:GridView>
    
</asp:Content>
