<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SectorFinanciero.ascx.cs" Inherits="GafLookPaid.controles.SectorFinanciero" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit, Version=3.5.7.607, Culture=neutral, PublicKeyToken=28f01b0e84b6d53e" %>


<hr width="100%" align="left"> 
<table width="100%">
<tr>
<td colspan="3"  style="text-align: left; font-weight: 700;" >

<asp:Label ID="Label1" runat="server" Text="Sector Financiero" Font-Bold="True"  style="font-size: medium"></asp:Label>
   </td>
</tr>
<tr>
<td class="style1" style="text-align: right"> 
    <asp:Label ID="Label3" runat="server" ForeColor="Red" Text="*"></asp:Label>
    IdFideicom:</td><td class="style3">
    <asp:TextBox ID="txtIdFideicom" runat="server" CssClass="form-control2"
    ToolTip="Atributo requerido para expresar el Identificador o Número del Fideicomiso" 
   ></asp:TextBox>

       
        <br />
              
      </td>
    
<td style="text-align: right" > 
    NomFideicom:</td><td class="style5">
        <asp:TextBox ID="txtNomFideicom" runat="server" CssClass="form-control2"
         ToolTip="Atributo opcional para expresar el Nombre del Fideicomiso" 
         ></asp:TextBox><br />
         
    </td>
   

<td class="style1" style="text-align: right"> 
    
    <asp:Label ID="Label9" runat="server" ForeColor="Red" Text="*"></asp:Label>
    DescripFideicom:<br /></td>
<td style="text-align: left" >
    <asp:TextBox ID="txtDescripFideicom" runat="server" CssClass="form-control2"
    ToolTip="Atributo requerido para expresar el objeto o fin del Fideicomiso" 
    ></asp:TextBox><br />
           

    </td>

</tr>
    <tr>
        <td></td>
        <td>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtIdFideicom" Display="Dynamic" style="color: #F72020" ErrorMessage="*Requerido" ValidationGroup="GeneraRetencion"></asp:RequiredFieldValidator>
        </td>
        <td></td>
        <td></td>
        <td></td>
        <td><asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" style="color: #F72020" ErrorMessage="*Requerido" Display="Dynamic"
              ControlToValidate="txtDescripFideicom" ValidationGroup="GeneraRetencion"></asp:RequiredFieldValidator></td>
    </tr>

</table>