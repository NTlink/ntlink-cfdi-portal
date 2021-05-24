﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="wfrEmpresasConsulta.aspx.cs" Inherits="GafLookPaid.wfrEmpresasConsulta" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .style1
        {
            color: #000000;
            font-weight: normal;
            border:1px;
        }
        .style124
    {
        border-style:solid;
        border-left:  #A8CF38;
    border-right:  #A8CF38;
    border-top:  #A8CF38;
    border-bottom:  #b3b3b3;
        border-radius: 15px ;
        border-width: 1px;
         padding: 2px 4px;
        height:40%rem;
        width:60%;
        color: #000101;
        background-color:transparent;
        
        background-color: #f2f2f2;
        text-align: center;
    }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<link href="Styles/StyleBoton.css" rel="stylesheet" type="text/css" />
    <h1 class="style1">Empresas</h1>
   </br>
    <asp:GridView runat="server" ID="gvEmpresas"  CssClass="style124" 
        AutoGenerateColumns="False" onrowcommand="gvEmpresas_RowCommand"
     DataKeyNames="IdEmpresa" AllowPaging="True" 
        onpageindexchanging="gvEmpresas_PageIndexChanging" >
        <EmptyDataTemplate>
            No se encontraron registros.
        </EmptyDataTemplate>
        <Columns>
            <asp:BoundField   HeaderText="RFC"   DataField="RFC" />
            <asp:BoundField HeaderText="Razón Social" DataField="RazonSocial" />
            <asp:ButtonField Text="Editar" CommandName="EditarEmpresa" />
            <asp:ButtonField Text="Sucursales" CommandName="EditarSucursal" />
            <asp:ButtonField Text="Conceptos" CommandName="EditarConceptos" />
        </Columns>
    </asp:GridView>
    <br />
    <div align="right" style="width:70%">
        <asp:Button runat="server" ID="btnNuevaEmpresa" Text="Nueva Empresa" onclick="btnNuevaEmpresa_Click"  class="btn btn-primary" />
    </div>
</asp:Content>
