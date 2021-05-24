<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="Lco.aspx.cs" Inherits="NtLinkAdministracion.Lco" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Tarea de Descarga de LCO
    </h1>
    <div align="center">Descargar archivo de LCO <asp:Button runat="server" 
            ID="btnDescarga" Text="Ejecutar" onclick="btnDescarga_Click" />
    </div>
    <div align="center">
        <asp:Label runat="server" ID="lblMensaje" ForeColor="Red"></asp:Label>  
    </div>
    <div align="center">
        <asp:GridView ID="GvLogLco" runat="server" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="Fecha" HeaderText="Fecha" />
                <asp:BoundField DataField="NoRegistros" HeaderText="Numero de Registros" />
                <asp:BoundField DataField="Error" HeaderText="Error" />
            </Columns>
        </asp:GridView>
    </div>
    <div align="center">
        <h1>Últimos 10 mensajes de la aplicación</h1>
    </div>
    
    <div align="center">
        <asp:GridView ID="gridErrores" runat="server" AutoGenerateColumns="False" Width="700px" >
            <Columns>
                <asp:BoundField DataField="Date" HeaderText="Fecha" />
                <asp:BoundField DataField="Level" HeaderText="Nivel" />
                <asp:BoundField DataField="Message" HeaderText="Mensaje"/>
            </Columns>
        </asp:GridView>
    </div>
    <div align="center"> <asp:Button ID="Button1" runat="server" Text="Refrescar" 
            onclick="Button1_Click" /></div>
    

</asp:Content>
