<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EnajenaciondeAcciones.ascx.cs" Inherits="GafLookPaid.controles.EnajenaciondeAcciones" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit, Version=3.5.7.607, Culture=neutral, PublicKeyToken=28f01b0e84b6d53e" %>

<style type="text/css">
    .style1
    {
        width: 155px;
    }
  
    .style5
    {
        text-align: left;
    }
  
</style>

<hr width="100%" align="left"> 
<table width="100%">
<tr>
<td colspan="3"  style="text-align: left; font-weight: 700;" >

<asp:Label ID="Label1" runat="server" Text="Enajenacion de Acciones" Font-Bold="True"  style="font-size: medium"></asp:Label>
   </td>
</tr>
<tr>
<td class="style1" style="text-align: right"> 
    <asp:Label ID="Label3" runat="server" ForeColor="Red" Text="*"></asp:Label>
    ContratoIntermediacion:</td><td class="style3">
        <asp:TextBox ID="txtContratoIntermediacion" runat="server" CssClass="form-control2"
         ToolTip="Atributo requerido para expresar la descripción del contrato de intermediación" 
          ></asp:TextBox>
        <br />
      <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ErrorMessage="Requerido" Display="Dynamic"
              ControlToValidate="txtContratoIntermediacion" ValidationGroup="GeneraRetencion"></asp:RequiredFieldValidator>
      </td>
    
<td style="text-align: right" > 
    <asp:Label ID="Label4" runat="server" ForeColor="Red" Text="*"></asp:Label>
    Ganancia:</td><td class="style5">
        <asp:TextBox ID="txtGanancia" runat="server"
         ToolTip="Atributo requerido para expresar la ganancia obtenida por la enajenación de acciones u operación de valores" 
         CssClass="form-control2"></asp:TextBox><br />
          <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ErrorMessage="Requerido" Display="Dynamic"
              ControlToValidate="txtGanancia" ValidationGroup="GeneraRetencion"></asp:RequiredFieldValidator>

               <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender6" runat="server" FilterType="Numbers, Custom"
    ValidChars="." TargetControlID="txtGanancia" />

    <asp:RegularExpressionValidator id="RegularExpressionValidator6" runat="server" Display="Dynamic"
    ControlToValidate="txtGanancia" ErrorMessage="Dato invalido" ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" ValidationGroup="GeneraRetencion"/>

    </td>
   
<td style="text-align: right" > 
    <asp:Label ID="Label8" runat="server" ForeColor="Red" Text="*"></asp:Label>
    Perdida:</td><td style="text-align: left">
    <asp:TextBox ID="txtPerdida"  runat="server"
    ToolTip="Atributo requerido para expresar la pérdida en el contrato de intermediación" 
    CssClass="form-control2" ></asp:TextBox><br />
        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ErrorMessage="Requerido" Display="Dynamic"
              ControlToValidate="txtPerdida" ValidationGroup="GeneraRetencion"></asp:RequiredFieldValidator>

     <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender3" runat="server" FilterType="Numbers, Custom"
    ValidChars="." TargetControlID="txtPerdida" />
 <asp:RegularExpressionValidator id="RegularExpressionValidator4" runat="server" Display="Dynamic"
    ControlToValidate="txtPerdida" ErrorMessage="Dato invalido" ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" ValidationGroup="GeneraRetencion"/>

    </td>
   
</tr>
<tr>
<td class="style1"> 
    
    <br /></td>
<td style="text-align: left" >
    <br />

    </td>
<td  style="text-align: right"> 
    <br /></td>
<td style="text-align: left">
    <br />
    
</td>

<td style="text-align: right">    
    &nbsp;</td>
<td style="text-align: left">
    <br />
     
    </td>
</tr>

</table>