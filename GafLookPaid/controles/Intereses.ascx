<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Intereses.ascx.cs" Inherits="GafLookPaid.controles.Intereses" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit, Version=3.5.7.607, Culture=neutral, PublicKeyToken=28f01b0e84b6d53e" %>

 <style type="text/css">
     .style1
     {
         text-align: right;
     }
     .style3
     {
         width: 211px;
     }
     .style7
     {
         width: 90px;
     }
     .style8
     {
         width: 150px;
         text-align: left;
     }
     .style10
     {
         width: 111px;
     }
     .style11
     {
         width: 154px;
     }
     .style12
     {
         width: 154px;
         text-align: left;
     }
 </style>


 <%--   <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script type="text/javascript">
    
    $(document).ready(function () {
        $(".prueba").keypress(function () {
            alert('hola');
        });
    });
</script>--%>


<hr width="100%" align="left"> 
<table   width="100%">
<tr>
<td  style="text-align: left" 
        class="style10" >
<asp:Label ID="Label1" runat="server" Text="Intereses" Font-Bold="True" 
        style="font-size: medium"></asp:Label>
</td>
</tr>
<tr>
<td align="right" class="style10" > 
    <asp:Label ID="Label3" runat="server" ForeColor="Red" Text="*"></asp:Label>
    SistFinanciero:</td><td class="style3">
    <asp:DropDownList ID="ddlSistFinanciero" runat="server" CssClass="form-control2"
     ToolTip="Atributo requerido para expresar si los interés obtenidos en el periodo o ejercicio provienen del sistema financiero"
    >
        <asp:ListItem>SI</asp:ListItem>
        <asp:ListItem>NO</asp:ListItem>
    </asp:DropDownList>
    </td>
   
<td class="style1"> 
    <asp:Label ID="Label4" runat="server" ForeColor="Red" Text="*"></asp:Label>
    RetiroAORESRetInt:</td><td class="style12">
     <asp:DropDownList ID="ddlRetiroAORESRetInt" runat="server" CssClass="form-control2"
      ToolTip="Atributo requerido para expresar si los intereses obtenidos fueron retirados en el periodo o ejercicio" 
      >
        <asp:ListItem>NO</asp:ListItem>
        <asp:ListItem>SI</asp:ListItem>
    </asp:DropDownList>
    </td>
 
<td class="style1"> 
    <asp:Label ID="Label5" runat="server" ForeColor="Red" Text="*"></asp:Label>
    OperFinancDerivad:</td><td class="style7" style="text-align: left">
     <asp:DropDownList ID="ddlOperFinancDerivad" runat="server" CssClass="form-control2"
      ToolTip="Atributo requerido para expresar si los intereses obtenidos corresponden a operaciones financieras derivadas." 
  >
        <asp:ListItem>NO</asp:ListItem>
        <asp:ListItem>SI</asp:ListItem>
    </asp:DropDownList>
    </td>
   
</tr>
<tr>
<td align="right" class="style10" > 
    <asp:Label ID="Label6" runat="server" ForeColor="Red" Text="*"></asp:Label>
    MontIntNominal:</td>
<td class="style3">
    <asp:TextBox ID="txtMontIntNominal" runat="server"
      ToolTip="Atributo requerido para expresar el importe del interés Nóminal obtenido en un periodo o ejercicio" 
      CssClass="form-control2"></asp:TextBox>
       
  
 
        <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server" FilterType="Numbers, Custom"
    ValidChars="." TargetControlID="txtMontIntNominal" />
   
    </td>
<td class="style1"> 
    <asp:Label ID="Label7" runat="server" ForeColor="Red" Text="*"></asp:Label>
    MontIntReal:</td>
<td class="style11">
    <asp:TextBox ID="txtMontIntReal" runat="server" 
     ToolTip="Atributo requerido para expresar el monto de los intereses reales " 
      CssClass="form-control2"></asp:TextBox>
         
  
     <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" FilterType="Numbers, Custom"
    ValidChars="." TargetControlID="txtMontIntReal" />
          
    </td>
<td class="style1"> 
    <asp:Label ID="Label8" runat="server" ForeColor="Red" Text="*"></asp:Label>
    Perdida:</td>
<td class="style8">
    <asp:TextBox ID="txtPerdida"  runat="server"
    ToolTip="Atributo requerido para expresar la pérdida por los intereses obtenidos en el periodo o ejercicio" 
    CssClass="form-control2" ></asp:TextBox>

       

        

   <%--<asp:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtPerdida"
                        Mask="9{9}.9999" MaskType="Number" InputDirection="RightToLeft" />--%>
   
     <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender7" runat="server" FilterType="Numbers, Custom"
    ValidChars="." TargetControlID="txtPerdida" />

    </td>
</tr>
<tr>
<td></td>
<td class="style3"><asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ErrorMessage="Requerido" Display="Dynamic"
              ControlToValidate="txtMontIntNominal" ValidationGroup="GeneraRetencion"></asp:RequiredFieldValidator>
              <asp:RegularExpressionValidator id="RegularExpressionValidator3" runat="server" Display="Dynamic"
    ControlToValidate="txtMontIntNominal" ErrorMessage="Dato invalido" ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" ValidationGroup="GeneraRetencion"/>
              </td>
              <td></td>
              <td class="style11">  <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ErrorMessage="Requerido" Display="Dynamic"
              ControlToValidate="txtMontIntReal" ValidationGroup="GeneraRetencion"></asp:RequiredFieldValidator>
              <asp:RegularExpressionValidator id="RegularExpressionValidator2" runat="server" Display="Dynamic"
    ControlToValidate="txtMontIntReal" ErrorMessage="Dato invalido" ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" ValidationGroup="GeneraRetencion" />
              </td>
              <td></td>
              <td>
     <asp:RequiredFieldValidator runat="server" ID="txtPerdidaField" ErrorMessage="Requerido" Display="Dynamic"
              ControlToValidate="txtPerdida" ValidationGroup="GeneraRetencion"></asp:RequiredFieldValidator>
              <asp:RegularExpressionValidator id="RegularExpressionValidator1" runat="server" Display="Dynamic"
    ControlToValidate="txtPerdida" ErrorMessage="Dato invalido" ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" ValidationGroup="GeneraRetencion"/>
              </td>
</tr>
</table>



