<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Operacionesconderivados.ascx.cs" Inherits="GafLookPaid.controles.Operacionesconderivados" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit, Version=3.5.7.607, Culture=neutral, PublicKeyToken=28f01b0e84b6d53e" %>



<hr width="100%" align="left"> 
<table width="100%">
<tr>
<td colspan="3"  style="text-align: left; font-weight: 700;" >

<asp:Label ID="Label1" runat="server" Text="Operaciones Conderivados" Font-Bold="True"  style="font-size: medium"></asp:Label>
   </td>
</tr>
<tr>
<td class="style1" style="text-align: right"> 
    <asp:Label ID="Label3" runat="server" ForeColor="Red" Text="*"></asp:Label>
    MontGanAcum:</td><td class="style3">
        <asp:TextBox ID="txtMontGanAcum" runat="server" CssClass="form-control2"
         ToolTip="Atributo requerido para expresar el monto de la ganancia acumulable" 
          ></asp:TextBox>
        <br />
      <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ErrorMessage="Requerido" Display="Dynamic"
              ControlToValidate="txtMontGanAcum" ValidationGroup="GeneraRetencion"></asp:RequiredFieldValidator>
         <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" FilterType="Numbers, Custom"
    ValidChars="." TargetControlID="txtMontGanAcum" />

    <asp:RegularExpressionValidator id="RegularExpressionValidator1" runat="server" Display="Dynamic"
    ControlToValidate="txtMontGanAcum" ErrorMessage="Dato invalido" ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" ValidationGroup="GeneraRetencion"/>

      </td>
    
<td style="text-align: right" > 
    <asp:Label ID="Label4" runat="server" ForeColor="Red" Text="*"></asp:Label>
    MontPerdDed:</td><td class="style5">
        <asp:TextBox ID="txtMontPerdDed" runat="server"
         ToolTip="Atributo requerido para expresar el monto de la pérdida deducible" 
         CssClass="form-control2"></asp:TextBox><br />
          <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ErrorMessage="Requerido" Display="Dynamic"
              ControlToValidate="txtMontPerdDed" ValidationGroup="GeneraRetencion"></asp:RequiredFieldValidator>

               <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender6" runat="server" FilterType="Numbers, Custom"
    ValidChars="." TargetControlID="txtMontPerdDed" />

    <asp:RegularExpressionValidator id="RegularExpressionValidator6" runat="server" Display="Dynamic"
    ControlToValidate="txtMontPerdDed" ErrorMessage="Dato invalido" ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" ValidationGroup="GeneraRetencion"/>

    </td>
   
<td style="text-align: right" > 
    &nbsp;</td><td style="text-align: left">
        <br />

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