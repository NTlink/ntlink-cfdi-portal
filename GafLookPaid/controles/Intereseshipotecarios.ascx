<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Intereseshipotecarios.ascx.cs" Inherits="GafLookPaid.controles.Intereseshipotecarios" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit, Version=3.5.7.607, Culture=neutral, PublicKeyToken=28f01b0e84b6d53e" %>





<hr width="100%" align="left"> 
<table width="100%">
<tr>
<td colspan="3"  style="text-align: left; font-weight: 700;" >

<asp:Label ID="Label1" runat="server" Text="Intereses Hipotecarios" Font-Bold="True"  style="font-size: medium"></asp:Label>
   </td>
</tr>
<tr>
<td  style="text-align: right"> 
    <asp:Label ID="Label3" runat="server" ForeColor="Red" Text="*"></asp:Label>
    CreditoDeInstFinanc:</td><td >
        <asp:DropDownList ID="ddlCreditoDeInstFinanc" runat="server" CssClass="form-control2">
            <asp:ListItem>SI</asp:ListItem>
            <asp:ListItem>NO</asp:ListItem>
        </asp:DropDownList>
        <br />
           
      </td>
    
<td style="text-align: right" > 
    MontTotIntNominalesDevYPag:</td><td>
    <asp:TextBox ID="txtMontTotIntNominalesDevYPag" runat="server" 
    ToolTip="Atributo opcional que expresa el monto total de intereses nominales devengados y pagados"
   CssClass="form-control2"></asp:TextBox>
        <br />
              <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender4" runat="server" FilterType="Numbers, Custom"
    ValidChars="." TargetControlID="txtMontTotIntNominalesDevYPag" />

    <asp:RegularExpressionValidator id="RegularExpressionValidator5" runat="server" Display="Dynamic"
    ControlToValidate="txtMontTotIntNominalesDevYPag" ErrorMessage="Dato invalido" ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" ValidationGroup="GeneraRetencion"/>

    
    </td>
   
<td style="text-align: right" > 
    PropDeducDelCredit:</td><td style="text-align: left">
    <asp:TextBox ID="txtPropDeducDelCredit"  runat="server"
    ToolTip="Atributo opcional que expresa la proporción deducible del crédito aplicable sobre los intereses reales devengados y pagados" 
    CssClass="form-control2" ></asp:TextBox><br />
        

     <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender3" runat="server" FilterType="Numbers, Custom"
    ValidChars="." TargetControlID="txtPropDeducDelCredit" />
 <asp:RegularExpressionValidator id="RegularExpressionValidator4" runat="server" Display="Dynamic"
    ControlToValidate="txtPropDeducDelCredit" ErrorMessage="Dato invalido" ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" ValidationGroup="GeneraRetencion"/>

    </td>
   
</tr>
<tr>
<td  style="text-align: right"> 
    
    MontTotIntNominalesDev:<br /></td>
<td style="text-align: left" >
    <asp:TextBox ID="txtMontTotIntNominalesDev" runat="server" 
    ToolTip="Atributo opcional que expresa el monto total de intereses nominales devengados" 
  CssClass="form-control2"></asp:TextBox><br />
        <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server" FilterType="Numbers, Custom"
    ValidChars="." TargetControlID="txtMontTotIntNominalesDev" />

    <asp:RegularExpressionValidator id="RegularExpressionValidator3" runat="server" Display="Dynamic"
    ControlToValidate="txtMontTotIntNominalesDev" ErrorMessage="Dato invalido" ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" ValidationGroup="GeneraRetencion"/>

    </td>
<td  style="text-align: right"> 
    <asp:Label ID="Label5" runat="server" ForeColor="Red" Text="*"></asp:Label>
    SaldoInsoluto:<br /></td>
<td style="text-align: left">
    <br />
    
     <asp:TextBox ID="txtSaldoInsoluto" runat="server"
         ToolTip="Atributo requerido para expresar el  saldo insoluto al 31 de diciembre del ejercicio inmediato anterior o fecha de contratación si se llevo a cabo en el ejercicio en curso" 
         CssClass="form-control2"></asp:TextBox>
         <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ErrorMessage="Requerido" Display="Dynamic"
              ControlToValidate="txtSaldoInsoluto" ValidationGroup="GeneraRetencion"></asp:RequiredFieldValidator>

               <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender6" runat="server" FilterType="Numbers, Custom"
    ValidChars="." TargetControlID="txtSaldoInsoluto" />

    <asp:RegularExpressionValidator id="RegularExpressionValidator6" runat="server" Display="Dynamic"
    ControlToValidate="txtSaldoInsoluto" ErrorMessage="Dato invalido" ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" ValidationGroup="GeneraRetencion"/>

</td>

<td style="text-align: right">    
    MontTotIntRealPagDeduc:<br /></td>
<td style="text-align: left">
    <asp:TextBox ID="txtMontTotIntRealPagDeduc"  runat="server"
    ToolTip="Atributo opcional que expresa el monto total de intereses reales pagados deducibles" 
    CssClass="form-control2"></asp:TextBox><br />
     
     <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender7" runat="server" FilterType="Numbers, Custom"
    ValidChars="." TargetControlID="txtMontTotIntRealPagDeduc" />

    <asp:RegularExpressionValidator id="RegularExpressionValidator1" runat="server" Display="Dynamic"
    ControlToValidate="txtMontTotIntRealPagDeduc" ErrorMessage="Dato invalido" ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" ValidationGroup="GeneraRetencion"/>

    </td>
</tr>
<tr>
<td  style="text-align: right" >NumContrato:</td>
<td style="text-align: left"> <asp:TextBox ID="txtNumContrato"  runat="server"
    ToolTip="Atributo opcional que expresa el número de contrato del crédito hipotecario" 
    CssClass="form-control2" ></asp:TextBox><br />
    </td>
<td style="text-align: right"> 
    </td>
<td style="text-align: left">        &nbsp;</td>
<td style="text-align: right">&nbsp;</td>
<td style="text-align: left"><br />
     
</td>
</tr>

</table>