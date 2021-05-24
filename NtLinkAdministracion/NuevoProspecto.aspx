<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="NuevoProspecto.aspx.cs" Inherits="NtLinkAdministracion.NuevoProspecto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 138px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server" >
    <link href="Styles/StyleBoton.css" rel="stylesheet" type="text/css" />
    <h1><asp:Label ID="lblTitulo" runat="server"  ></asp:Label></h1>
    <h1>Prospecto</h1>
    <asp:Label runat="server" ID="lblError" ForeColor="Red" />
    <table>
        
    </table>
    <div runat="server" ID="divUsuarios">
    <table >
        <tr>
            <td class="auto-style1"></td>
            <td class="style1">
                &nbsp;</td>
        </tr>
        <tr>
            <td style="text-align: right" class="auto-style1">Tipo de Cliente:</td>
            <td><asp:DropDownList runat="server" ID="ddlTipoCliente" AutoPostBack="True" Width="269px">
                   <asp:ListItem runat="server" Text="Facturación" Value="0" ></asp:ListItem>
                   <asp:ListItem runat="server" Text="Timbrado Pre-Pago" Value="1"></asp:ListItem>
                   <%--<asp:ListItem runat="server" Text="Distribuidor" Value="2"></asp:ListItem>--%>
                   <asp:ListItem runat="server" Text="Timbrado Post-Pago" Value="3"></asp:ListItem> 
                </asp:DropDownList></td>
                <td style="text-align: right">Ejecutivo de ventas:</td>
            <td>
                <asp:DropDownList runat="server" ID="ddlEjecutivo" AutoPostBack="True" Width="269px">
                   <asp:ListItem runat="server" Text="Daniel Lopez" Value="3006" ></asp:ListItem>
                   <asp:ListItem runat="server" Text="Ivonne Ahuatzi" Value="3003"></asp:ListItem>
                   <%--<asp:ListItem runat="server" Text="Distribuidor" Value="2"></asp:ListItem>--%>
                   <asp:ListItem runat="server" Text="Jessica Ambros" Value="3004"></asp:ListItem> 
                    <asp:ListItem runat="server" Text="No Asignado" Value="0"></asp:ListItem> 
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td style="text-align: right" class="auto-style1">RFC:</td>
             <td><asp:TextBox runat="server" ID="txtRFC" Width="266px" MaxLength="14" /></td>
            <td style="text-align: right">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
         <tr>
            <td style="text-align: right" class="auto-style1">Razon Social:</td>
            <td><asp:TextBox runat="server" ID="txtRazonSocial" Width="266px" /></td>
        </tr>

        <tr>
            <td style="text-align: right" class="auto-style1">Telefono:</td>
            <td><asp:TextBox runat="server" ID="txtTelefono" Width="269px" /></td>
            <td style="text-align: right">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td style="text-align: right" class="auto-style1">Email</td>
            <td><asp:TextBox runat="server" ID="txtEmail" Width="269px" /></td>
             <td style="text-align: right">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td style="text-align: right" class="auto-style1">&nbsp;</td>
            <td>
                <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
            </td>
            <td style="text-align: right">&nbsp;</td>
            <td>
        <asp:Button runat="server" ID="btnGuardar"  class="btn btn-primary" Text="Guardar" OnClick="btnGuardar_Click" /></td>
        </tr>
        <tr>
            <td style="text-align: right" class="auto-style1">&nbsp;</td>
            <td>&nbsp;</td>
            <td style="text-align: right">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        
        <tr>
            <td style="text-align: right" class="auto-style1">&nbsp;</td>
            <td>&nbsp;</td>
            <td style="text-align: right">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        
        <tr>
            <td style="text-align: right" class="auto-style1">&nbsp;</td>
            <td>
                &nbsp;</td>
            <td style="text-align: right">&nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>

      <%--  <tr>
            <td>Folios Consumidos:</td>
            <td><asp:TextBox runat="server" ID="txtConsumidos" Width="400px" Enabled="False" />
            </td>
        </tr>--%>
        <tr>
            <td style="text-align: right" class="auto-style1">&nbsp;</td>
            <td>&nbsp;</td>
            <td style="text-align: right">&nbsp;</td>
             <td>&nbsp;</td>
        </tr>
        
         <tr>
            <td style="text-align: right" class="auto-style1">&nbsp;</td>
             <td>&nbsp;</td>
        </tr>
        <tr >
            <td colspan="2">
                <asp:Label ID="LblMensaje" runat="server" />    
            </td>
        </tr>
        </table>
        </div>
        
        
        <div align="right" runat="server"   ID="divUsers">
            &nbsp;&nbsp;
    </div>
   
</asp:Content>
