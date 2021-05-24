<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="ConsultaProspecto.aspx.cs" Inherits="NtLinkAdministracion.ConsultaProspecto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <link href="Styles/StyleBoton.css" rel="stylesheet" type="text/css" />
    <h1>Consulta de PROSPECTOS</h1>
    <p>
        RFC o Razón Social: <asp:TextBox runat="server" ID="txtBusqueda" Width="399px" 
            Height="21px" />&nbsp;
        <asp:Button runat="server" ID="btnBuscar" Text="Buscar" class="btn btn-primary"
            onclick="btnBuscar_Click" />
    </p>
    <%--<p>
        Filtrar por ejecutivo de ventas
        <asp:DropDownList runat="server" ID="ddlEjecutivos" DataTextField="Nombre" AutoPostBack="True" OnSelectedIndexChanged="ddlEjecutivos_OnSelectedIndexChanged" DataValueField="IdPromotor"/>
    </p>--%>
    <asp:GridView runat ="server" id="tabla" Width="270px" CellPadding="3" OnSelectedIndexChanged="pruebagv_SelectedIndexChanged">
        <Columns>
            <asp:ButtonField ButtonType="Button" CommandName="Select" HeaderText="Alta" ShowHeader="True" Text="Dar alta"  />
        </Columns>
    </asp:GridView>
    
    <div align="right">
    </div>
    <table style: width="100%">
        <tr>

            <td>

            </td>

            <td>


                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Nuevo Prospecto" />
                <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Nuevo Cliente" />


            </td>

        </tr>


    </table>
</asp:Content>
