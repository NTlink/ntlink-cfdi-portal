<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="XMLprueba.aspx.cs" Inherits="GafLookPaid.XMLprueba" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 146px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<table style="width:100%">
    <tr>

        <td class="auto-style1" >

                        <asp:Label ID="Label1" runat="server" Text="Sube XML: "></asp:Label>
        </td>

        <td colspan="3">


       <asp:FileUpload ID="exaxml" runat="server" />




        </td>

        <td >



        </td>





    </tr>

    <tr>

        <td class="auto-style1"></td>
        <td></td>
        <td>

        </td>
    </tr>



</table>


</asp:Content>
