<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="arrendamientoenfideicomiso.ascx.cs" Inherits="GafLookPaid.controles.arrendamientoenfideicomiso" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit, Version=3.5.7.607, Culture=neutral, PublicKeyToken=28f01b0e84b6d53e" %>

<style type="text/css">
    .style1
    {
        width: 48px;
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

<asp:Label ID="Label1" runat="server" Text="Arrendamiento en Fideicomiso" Font-Bold="True"  style="font-size: medium"></asp:Label>
   </td>
</tr>
<tr>
<td style="text-align: right"> 
    <asp:Label ID="Label3" runat="server" ForeColor="Red" Text="*"></asp:Label>
    PagProvEfecPorFiduc:</td><td class="style3">
        <asp:TextBox ID="txtPagProvEfecPorFiduc" runat="server"
          ToolTip="Atributo requerido para expresar el importe del  pago efectuado por parte del fiduciario al arrendador de bienes en el periodo" 
          CssClass="form-control2"></asp:TextBox>
        <br />
            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ErrorMessage="Requerido" Display="Dynamic"
              ControlToValidate="txtPagProvEfecPorFiduc" ValidationGroup="GeneraRetencion"></asp:RequiredFieldValidator>

               <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" FilterType="Numbers, Custom"
    ValidChars="." TargetControlID="txtPagProvEfecPorFiduc" />

    <asp:RegularExpressionValidator id="RegularExpressionValidator2" runat="server" Display="Dynamic"
    ControlToValidate="txtPagProvEfecPorFiduc" ErrorMessage="Dato invalido" ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" ValidationGroup="GeneraRetencion"/>

      </td>
    
<td style="text-align: right" > 
    <asp:Label ID="Label4" runat="server" ForeColor="Red" Text="*"></asp:Label>
    RendimFideicom:</td><td class="style5">
        <asp:TextBox ID="txtRendimFideicom" runat="server"
         ToolTip="Atributo requerido para expresar el importe de  los rendimientos obtenidos en el periodo por el arrendamiento de bienes." 
        CssClass="form-control2"></asp:TextBox><br />
          <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ErrorMessage="Requerido" Display="Dynamic"
              ControlToValidate="txtRendimFideicom" ValidationGroup="GeneraRetencion"></asp:RequiredFieldValidator>

               <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender6" runat="server" FilterType="Numbers, Custom"
    ValidChars="." TargetControlID="txtRendimFideicom" />

    <asp:RegularExpressionValidator id="RegularExpressionValidator6" runat="server" Display="Dynamic"
    ControlToValidate="txtRendimFideicom" ErrorMessage="Dato invalido" ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" ValidationGroup="GeneraRetencion"/>

    </td>
   
<td style="text-align: right" > 
    <asp:Label ID="Label8" runat="server" ForeColor="Red" Text="*"></asp:Label>
    DeduccCorresp:</td><td style="text-align: left">
    <asp:TextBox ID="txtDeduccCorresp"  runat="server"
    ToolTip="Atributo requerido para expresar el importe de las deducciones correspondientes al arrendamiento de los bienes durante el periodo" 
    CssClass="form-control2" ></asp:TextBox><br />
        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ErrorMessage="Requerido" Display="Dynamic"
              ControlToValidate="txtDeduccCorresp" ValidationGroup="GeneraRetencion"></asp:RequiredFieldValidator>

     <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender3" runat="server" FilterType="Numbers, Custom"
    ValidChars="." TargetControlID="txtDeduccCorresp" />
 <asp:RegularExpressionValidator id="RegularExpressionValidator4" runat="server" Display="Dynamic"
    ControlToValidate="txtDeduccCorresp" ErrorMessage="Dato invalido" ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" ValidationGroup="GeneraRetencion"/>

    </td>
   
</tr>
<tr>
<td  style="text-align: right"> 
    
    MontTotRet:<br /></td>
<td style="text-align: left" >
    <asp:TextBox ID="txtMontTotRet" runat="server" 
    ToolTip="Atributo opcional para expresar el monto total de la retención del arrendamiento de los bienes del periodo" 
    CssClass="form-control2"></asp:TextBox><br />
        <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server" FilterType="Numbers, Custom"
    ValidChars="." TargetControlID="txtMontTotRet" />

    <asp:RegularExpressionValidator id="RegularExpressionValidator3" runat="server" Display="Dynamic"
    ControlToValidate="txtMontTotRet" ErrorMessage="Dato invalido" ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" ValidationGroup="GeneraRetencion"/>

    </td>
<td  style="text-align: right"> 
    MontResFiscDistFibras:<br /></td>
<td style="text-align: left">
    <asp:TextBox ID="txtMontResFiscDistFibras" runat="server" 
    ToolTip="Atributo opcional para expresar el monto del resultado fiscal distribuido por FIBRAS"
   CssClass="form-control2"></asp:TextBox>
    <br />
    
     <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender4" runat="server" FilterType="Numbers, Custom"
    ValidChars="." TargetControlID="txtMontResFiscDistFibras" />

    <asp:RegularExpressionValidator id="RegularExpressionValidator5" runat="server" Display="Dynamic"
    ControlToValidate="txtMontResFiscDistFibras" ErrorMessage="Dato invalido" ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" ValidationGroup="GeneraRetencion"/>

</td>

<td style="text-align: right">    
    MontOtrosConceptDistr:<br /></td>
<td style="text-align: left">
    <asp:TextBox ID="txtMontOtrosConceptDistr"  runat="server"
    ToolTip="Atributo opcional para expresar el monto de otros conceptos distribuidos" 
    CssClass="form-control2" ></asp:TextBox><br />
     
     <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender7" runat="server" FilterType="Numbers, Custom"
    ValidChars="." TargetControlID="txtMontOtrosConceptDistr" />

    <asp:RegularExpressionValidator id="RegularExpressionValidator1" runat="server" Display="Dynamic"
    ControlToValidate="txtMontOtrosConceptDistr" ErrorMessage="Dato invalido" ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" ValidationGroup="GeneraRetencion"/>

    </td>
</tr>
<tr>
<td style="text-align: right">DescrMontOtrosConceptDistr:</td>
<td style="text-align: left"> <asp:TextBox ID="txtDescrMontOtrosConceptDistr"  runat="server"
    ToolTip="Atributo opcional para describir los conceptos distribuidos cuando se señalen otros conceptos." 
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