<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FideicomisoNoEmpresarial.ascx.cs" Inherits="GafLookPaid.controles.FideicomisoNoEmpresarial" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit, Version=3.5.7.607, Culture=neutral, PublicKeyToken=28f01b0e84b6d53e" %>

<style type="text/css">
      
  
    
  
  
</style>

<hr width="100%" align="left" /> 
<table width="100%" id="nueva">
<tr>
<td colspan="6"  style="text-align: left; font-weight: 700;" >
<asp:Label ID="Label1" runat="server" Text="FideicomisoNoEmpresarial" Font-Bold="True"  style="font-size: medium"></asp:Label>
    </td>
</tr>
<tr>
<td > 
    <asp:Label ID="Label3" runat="server" ForeColor="Red" Text="*"></asp:Label>
    <span class="t">MontTotEntradasPer</span>:</td><td style="text-align: left">
        <asp:TextBox ID="txtMontTotEntradasPeriodo" runat="server"
          ToolTip="Atributo requerido para expresar el importe total de los ingresos del periodo de los fideicomisos que no realizan actividades empresariales" 
          CssClass="form-control2" style="text-align: left"></asp:TextBox>
        <br />
            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ErrorMessage="Requerido" Display="Dynamic"
              ControlToValidate="txtMontTotEntradasPeriodo" ValidationGroup="GeneraRetencion"></asp:RequiredFieldValidator>

               <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" FilterType="Numbers, Custom"
    ValidChars="." TargetControlID="txtMontTotEntradasPeriodo" />

    <asp:RegularExpressionValidator id="RegularExpressionValidator2" runat="server" Display="Dynamic"
    ControlToValidate="txtMontTotEntradasPeriodo" ErrorMessage="Dato invalido" ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" ValidationGroup="GeneraRetencion"/>

      </td>
    
<td style="text-align: right" > 
    <asp:Label ID="Label4" runat="server" ForeColor="Red" Text="*"></asp:Label>
    <span class="t">PartPropAcumDelFideic</span>:</td><td class="style5">
        <asp:TextBox ID="txtPartPropAcumDelFideicom" runat="server"
         ToolTip="Atributo requerido para expresar la parte proporcional de los ingresos acumulables del periodo que correspondan al  fideicomisario o fideicomitente" 
         CssClass="form-control2"></asp:TextBox><br />
          <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ErrorMessage="Requerido" Display="Dynamic"
              ControlToValidate="txtPartPropAcumDelFideicom" ValidationGroup="GeneraRetencion"></asp:RequiredFieldValidator>

               <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender6" runat="server" FilterType="Numbers, Custom"
    ValidChars="." TargetControlID="txtPartPropAcumDelFideicom" />

    <asp:RegularExpressionValidator id="RegularExpressionValidator6" runat="server" Display="Dynamic"
    ControlToValidate="txtPartPropAcumDelFideicom" ErrorMessage="Dato invalido" ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" ValidationGroup="GeneraRetencion"/>

    </td>
   
<td style="text-align: right" > 
    <asp:Label ID="Label8" runat="server" ForeColor="Red" Text="*"></asp:Label>
    <span class="t">PropDelMontTot</span>:</td><td style="text-align: left">
    <asp:TextBox ID="txtPropDelMontTot"  runat="server"
    ToolTip="Atributo requerido para expresar la proporción de participación del fideicomisario o fideicomitente de acuerdo al contrato" 
    CssClass="form-control2" ></asp:TextBox><br />
        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ErrorMessage="Requerido" Display="Dynamic"
              ControlToValidate="txtPropDelMontTot" ValidationGroup="GeneraRetencion"></asp:RequiredFieldValidator>

     <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender3" runat="server" FilterType="Numbers, Custom"
    ValidChars="." TargetControlID="txtPropDelMontTot" />
 <asp:RegularExpressionValidator id="RegularExpressionValidator4" runat="server" Display="Dynamic"
    ControlToValidate="txtPropDelMontTot" ErrorMessage="Dato invalido" ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" ValidationGroup="GeneraRetencion"/>

    </td>
   
</tr>
<tr>
<td > 
    
    <asp:Label ID="Label9" runat="server" ForeColor="Red" Text="*"></asp:Label>
    
    IntegracIngresos:<br /></td>
<td style="text-align: left" >
    <asp:TextBox ID="txtIntegracIngresosConcepto" runat="server" CssClass="form-control2"
    ToolTip="Atributo requerido para expresar la descripción del concepto de ingresos de los fideicomisos que no realizan actividades empresariales" 
   ></asp:TextBox><br />
    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator4" ErrorMessage="Requerido" Display="Dynamic"
              ControlToValidate="txtIntegracIngresosConcepto" ValidationGroup="GeneraRetencion"></asp:RequiredFieldValidator>

    </td>
<td  style="text-align: right"> 
    <asp:Label ID="Label10" runat="server" ForeColor="Red" Text="*"></asp:Label>
    PartPropDelFideic:<br /></td>
<td style="text-align: left">
    <asp:TextBox ID="txtPartPropDelFideicom"  runat="server"
    ToolTip="Atributo requerido para expresar la parte proporcional de las deducciones autorizadas del periodo que corresponden al  fideicomisario o fideicomitente" 
    CssClass="form-control2" ></asp:TextBox>
    <br />
    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator5" ErrorMessage="Requerido" Display="Dynamic"
              ControlToValidate="txtPartPropDelFideicom" ValidationGroup="GeneraRetencion"></asp:RequiredFieldValidator>
   
    <asp:RegularExpressionValidator id="RegularExpressionValidator3" runat="server" Display="Dynamic"
    ControlToValidate="txtPartPropDelFideicom" ErrorMessage="Dato invalido" ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" ValidationGroup="GeneraRetencion"/>
        <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server" FilterType="Numbers, Custom"
    ValidChars="." TargetControlID="txtPartPropDelFideicom" />

</td>

<td style="text-align: right">    
    <asp:Label ID="Label11" runat="server" ForeColor="Red" Text="*"></asp:Label>
    MontTotEgresPeriodo:<br /></td>
<td style="text-align: left">
    <asp:TextBox ID="txtMontTotEgresPeriodo"  runat="server"
    ToolTip="Atributo requerido para expresar el importe total de los egresos del periodo de fideicomiso que no realizan actividades empresariales" 
   CssClass="form-control2" ></asp:TextBox><br />
     <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator6" ErrorMessage="Requerido" Display="Dynamic"
              ControlToValidate="txtMontTotEgresPeriodo" ValidationGroup="GeneraRetencion"></asp:RequiredFieldValidator>
     <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender7" runat="server" FilterType="Numbers, Custom"
    ValidChars="." TargetControlID="txtMontTotEgresPeriodo" />

    <asp:RegularExpressionValidator id="RegularExpressionValidator1" runat="server" Display="Dynamic"
    ControlToValidate="txtMontTotEgresPeriodo" ErrorMessage="Dato invalido" ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" ValidationGroup="GeneraRetencion"/>
      

    </td>
</tr>
<tr>
<td  > 
    <asp:Label ID="Label12" runat="server" ForeColor="Red" Text="*"></asp:Label>
    IntegracEgresos:</td>
<td style="text-align: left" > 
    <asp:TextBox ID="txtIntegracEgresosConcepto" runat="server" CssClass="form-control2"
    ToolTip="Atributo requerido para expresar la descripción del concepto de egresos de los fideicomisos que no realizan actividades empresariales"
    ></asp:TextBox>
    <br />

     <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator7" ErrorMessage="Requerido" Display="Dynamic"
              ControlToValidate="txtIntegracEgresosConcepto" ValidationGroup="GeneraRetencion"></asp:RequiredFieldValidator>
   
    </td>
<td style="text-align: right"> 
    <asp:Label ID="Label13" runat="server" ForeColor="Red" Text="*"></asp:Label>
    PropDelMontTotSalidas:</td>
<td style="text-align: left">        
    <asp:TextBox ID="txtPropDelMontTotSalidas"  runat="server"
    ToolTip="Atributo requerido para expresar la proporción de participación del fideicomisario o fideicomitente de acuerdo al contrato" 
    CssClass="form-control2" ></asp:TextBox>
    <br />
    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator8" ErrorMessage="Requerido" Display="Dynamic"
              ControlToValidate="txtPropDelMontTotSalidas" ValidationGroup="GeneraRetencion"></asp:RequiredFieldValidator>
     <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender4" runat="server" FilterType="Numbers, Custom"
    ValidChars="." TargetControlID="txtPropDelMontTotSalidas" />

    <asp:RegularExpressionValidator id="RegularExpressionValidator5" runat="server" Display="Dynamic"
    ControlToValidate="txtPropDelMontTotSalidas" ErrorMessage="Dato invalido" ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" ValidationGroup="GeneraRetencion"/>
      
    </td>
<td style="text-align: right">    
    <asp:Label ID="Label14" runat="server" ForeColor="Red" Text="*"></asp:Label>
    MontRetRelPagFideic:</td>
<td style="text-align: left">
    <asp:TextBox ID="txtMontRetRelPagFideic"  runat="server"
    ToolTip="Atributo requerido para expresar el importe total de los egresos del periodo de fideicomiso que no realizan actividades empresariales" 
    CssClass="form-control2"></asp:TextBox>
     <asp:FilteredTextBoxExtender ID="txtMontRetRelPagFideic_FilteredTextBoxExtender" 
        runat="server" FilterType="Numbers, Custom"
    ValidChars="." TargetControlID="txtMontRetRelPagFideic" />

    <br />
     <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator9" 
        ErrorMessage="Requerido" Display="Dynamic"
              ControlToValidate="txtMontRetRelPagFideic" 
        ValidationGroup="GeneraRetencion"></asp:RequiredFieldValidator>

    <asp:RegularExpressionValidator id="RegularExpressionValidator7" runat="server" Display="Dynamic"
    ControlToValidate="txtMontRetRelPagFideic" ErrorMessage="Dato invalido" 
        ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" 
        ValidationGroup="GeneraRetencion"/>
      

    <br />
     
</td>
</tr>
<tr>
<td >
    <asp:Label ID="Label15" runat="server" ForeColor="Red" Text="*"></asp:Label>
    DescRetRelPagFideic:</td>
<td>
    <asp:TextBox ID="DescRetRelPagFideic" runat="server" CssClass="form-control2"
    ToolTip="Atributo requerido para expresar la descripción del concepto de ingresos de los fideicomisos que no realizan actividades empresariales" 
   ></asp:TextBox><br />
    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator10" 
        ErrorMessage="Requerido" Display="Dynamic"
              ControlToValidate="DescRetRelPagFideic" 
        ValidationGroup="GeneraRetencion"></asp:RequiredFieldValidator>

</td>
<td>
</td>
<td>
</td>
</tr>
</table>