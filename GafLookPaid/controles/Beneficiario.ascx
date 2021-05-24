<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Beneficiario.ascx.cs" Inherits="GafLookPaid.controles.Beneficiario" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit, Version=3.5.7.607, Culture=neutral, PublicKeyToken=28f01b0e84b6d53e" %>






<table width="100%">
<tr>
<td  style="text-align: left" 
        class="style2" >
<asp:Label ID="Label1" runat="server" Text="Beneficiarios" Font-Bold="True"  
        style="font-size: small"></asp:Label>
</td>
</tr>
<tr>
<td style="text-align:right" class="style2" > 
    <asp:Label ID="Label3" runat="server" ForeColor="Red" Text="*"></asp:Label>
    RFC:</td><td class="style3">
        <asp:TextBox ID="txtRFC" runat="server" 
        
            ToolTip="Atributo requerido para expresar la clave del registro federal de contribuyentes del representante legal en México" CssClass="form-control2"
        ></asp:TextBox><br />

        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ErrorMessage="Requerido" Display="Dynamic"
              ControlToValidate="txtRFC" ValidationGroup="GeneraRetencion"></asp:RequiredFieldValidator>
         
       <asp:RegularExpressionValidator id="RegularExpressionValidator6" runat="server" Display="Dynamic"
    ControlToValidate="txtRFC" ErrorMessage="Dato invalido" ValidationExpression="[A-Z,Ñ,&amp;]{3,4}[0-9]{2}[0-1][0-9][0-3][0-9][A-Z,0-9][A-Z,0-9][0-9,A-Z]" ValidationGroup="GeneraRetencion"/>

    </td>
   
<td  style="text-align: right"> 
    <asp:Label ID="Label4" runat="server" ForeColor="Red" Text="*"></asp:Label>
    CURP:</td><td >
        <asp:TextBox ID="txtCURP" runat="server" 
        
            ToolTip="Atributo requerido para la expresión de la CURP del representante legal" CssClass="form-control2"
        ></asp:TextBox>
         <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator4" ErrorMessage="*Requerido" Display="Dynamic"
              ControlToValidate="txtCURP" ValidationGroup="GeneraRetencion" style="color: #F72020"></asp:RequiredFieldValidator>
     
          <asp:RegularExpressionValidator id="RegularExpressionValidator1" runat="server" Display="Dynamic"
    ControlToValidate="txtCURP" ErrorMessage="*Dato invalido" ValidationExpression="[A-Z][A,E,I,O,U,X][A-Z]{2}[0-9]{2}[0-1][0-9][0-3][0-9][M,H][A-Z]{2}[B,C,D,F,G,H,J,K,L,M,N,Ñ,P,Q,R,S,T,V,W,X,Y,Z]{3}[0-9,A-Z][0-9]" ValidationGroup="GeneraRetencion" style="color: #F72020"/>

    </td>
 

</tr>
<tr>
<td style="text-align:right" class="style2" > 
    <asp:Label ID="Label6" runat="server" ForeColor="Red" Text="*"></asp:Label>
    NomDenRazSocB:</td>
<td >
    <asp:TextBox ID="txtNomDenRazSocB" runat="server"
      ToolTip="Atributo requerido para expresar el nombre, denominación o razón social del contribuyente en México" 
      CssClass="form-control2"></asp:TextBox><br />
       <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ErrorMessage="Requerido" Display="Dynamic"
              ControlToValidate="txtNomDenRazSocB" ValidationGroup="GeneraRetencion"></asp:RequiredFieldValidator>
  
 
    </td>
<td style="text-align:right"> 
    <asp:Label ID="Label7" runat="server" ForeColor="Red" Text="*"></asp:Label>
    ConceptoPago:</td>
<td >
    <asp:DropDownList ID="ddlConceptoPago" runat="server" CssClass="form-control2"
      ToolTip="Atributo requerido para expresar  el tipo contribuyente sujeto a la retención, conforme al catálogo" >

    <asp:ListItem Value="1"> 1 (Artistas, deportistas y espectáculos públicos)</asp:ListItem>
    <asp:ListItem Value="2"> 2 (Otras personas físicas)</asp:ListItem>
    <asp:ListItem Value="3"> 3 (Persona moral)</asp:ListItem>
    <asp:ListItem Value="4"> 4 (Fideicomiso)</asp:ListItem>
    <asp:ListItem Value="5"> 5 (Asociación en participación)</asp:ListItem>
    <asp:ListItem Value="6"> 6 (Organizaciones Internacionales o de gobierno)</asp:ListItem>
    <asp:ListItem Value="7"> 7 (Organizaciones exentas)</asp:ListItem>
    <asp:ListItem Value="8"> 8 (Agentes pagadores)</asp:ListItem>
    <asp:ListItem Value="9"> 9 (Otros)</asp:ListItem>

    </asp:DropDownList>
    <br />
       
    </td>

<td >
       

        

   <%--<asp:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtPerdida"
                        Mask="9{9}.9999" MaskType="Number" InputDirection="RightToLeft" />--%>
   

    </td>
</tr>
<tr>
<td  style="text-align:right" class="style2"> 
    <asp:Label ID="Label8" runat="server" ForeColor="Red" Text="*"></asp:Label>
    DescripcionConcepto:</td>
<td colspan="2">
        <asp:TextBox ID="txtDescripcionConcepto" runat="server" 
        
            
        
            ToolTip="Atributo requerido para expresar la descripción de la definición del pago del residente en el extranjero" CssClass="form-control2"
        ></asp:TextBox>    <br />
        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ErrorMessage="Requerido" Display="Dynamic"
              ControlToValidate="txtDescripcionConcepto" ValidationGroup="GeneraRetencion"></asp:RequiredFieldValidator>
        </td>
        <td>
        
        </td>
</tr>

</table>
