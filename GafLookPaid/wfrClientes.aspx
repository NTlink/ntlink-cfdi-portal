<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="wfrClientes.aspx.cs" Inherits="GafLookPaid.wfrClientes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <link href="Styles/StyleBoton.css" rel="stylesheet" type="text/css" />    
     <table>
           <td><strong>Empresa Emisora:</strong></td>
            <td>
                <asp:DropDownList runat="server" ID="ddlEmpresa" AppendDataBoundItems="true" DataTextField="RazonSocial" 
                    DataValueField="IdEmpresa" CssClass="form-control2" Width="293px" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </td>
            <td><asp:Label runat="server" ID="lblError" ForeColor="Red" /></td>
        </table>
    <table>
            <tr>
            <td style="text-align: right">RFC:</td>
            <td><asp:TextBox runat="server" ID="txtRFC" CssClass="form-control2"/>
            </td>
            
            <td>CURP:</td>
        <td>
                <asp:TextBox ID="txtCurp" runat="server" CssClass="form-control2"></asp:TextBox>
  
        </td>
          <td>Nacionalidad:</td>
          <td>
                <asp:DropDownList runat="server" ID="ddlNacionalidad" CssClass="form-control2"  >
                    <asp:ListItem>Mexicana</asp:ListItem>
                    <asp:ListItem>Extranjero</asp:ListItem>
                </asp:DropDownList>
               
        </td>
        <td>NumRegIdTrib:</td>
        <td> <asp:TextBox ID="txtNumRegIdTrib" runat="server" CssClass="form-control0"></asp:TextBox>
          
        </td>
        </tr>
        <tr>
            <td>Razón Social:</td>
            <td>
                <asp:TextBox runat="server" ID="txtRazonSocial" 
                    CssClass="form-control2" Width="290px" /></td>
        </tr>
        </table>
         <table class="table">
        <tr>
            <td style="text-align: right" class="style131">Calle:</td>
            <td><asp:TextBox runat="server" ID="txtDireccion" CssClass="form-control2" /></td>
             <td class="style132">No Exterior:</td>
            <td class="style136"><asp:TextBox runat="server" ID="txtExt" CssClass="form-control2" /></td>
        
            <td style="text-align: right" class="style134">No Interior:</td>
            <td class="style139"><asp:TextBox runat="server" ID="txtInt" CssClass="form-control2" /></td>
        </tr>
        <tr>
            <td style="text-align: right" class="style131">Colonia:</td>
            <td><asp:TextBox runat="server" ID="txtColonia" CssClass="form-control2" /></td>
            <td class="style132" style="text-align: right">Municipio:</td>
            <td class="style136"><asp:TextBox runat="server" ID="txtMunicipio" CssClass="form-control2" /></td>
            <td style="text-align: right" class="style134">Localidad:</td>
            <td class="style139"><asp:TextBox runat="server" ID="txtLocalidad" CssClass="form-control2" /></td>
        </tr>
        <tr>
            <td style="text-align: right" class="style131">Referencia:</td>
            <td><asp:TextBox runat="server" ID="txtReferencia" CssClass="form-control2"/></td>
           <td class="style132" style="text-align: right" >Estado:</td>
            <td class="style136"><asp:TextBox runat="server" ID="txtEstado" CssClass="form-control2" /></td>
            <td class="style135">País:</td>
            <td class="style139"><asp:TextBox runat="server" ID="txtPais" CssClass="form-control2" >México</asp:TextBox> </td>
        </tr>
        <tr>
            <td style="text-align: right" class="style131">CP:</td>
            <td ><asp:TextBox runat="server" ID="txtCP" CssClass="form-control2" MaxLength="5" /></td>
            <td class="style132" style="text-align: right">Teléfono</td>
            <td class="style136"><asp:TextBox runat="server" ID="txtTelefono" CssClass="form-control2" /></td>
        </tr>
        <tr>
            <td class="style130">Email:</td>
            <td class="style125"><asp:TextBox runat="server" ID="txtEmail" CssClass="form-control2" /></td>
           <td class="style132">Bcc:</td>
            <td class="style136"><asp:TextBox runat="server" ID="txtBcc" CssClass="form-control2" /></td>
        </tr>
        <tr>
            <td style="text-align: right" class="style131">Web:</td>
            <td><asp:TextBox runat="server" ID="txtWeb" CssClass="form-control2" /></td>
            <td class="style132" style="text-align: right">Contacto:</td>
            <td class="style136"><asp:TextBox runat="server" ID="txtContacto" CssClass="form-control2" /></td>
        </tr>
        <tr>
            <td style="text-align: right" class="style131">Días Revisión:</td>
            <td>
                <asp:TextBox runat="server" ID="txtDiasRevision" CssClass="form-control2" />
                <asp:CompareValidator runat="server" ID="cvDiasRevision" ControlToValidate="txtDiasRevision" Display="Dynamic"
                 ErrorMessage="* Dato Invalido" Type="Integer" Operator="DataTypeCheck" />
            </td>
            <td class="style132" style="text-align: right">Cta. Contable:</td>
            <td class="style136"><asp:TextBox runat="server" ID="txtCuentaContable" 
                    CssClass="form-control2" /></td>
            <td class="style135">Cta. Depósito</td>
            <td class="style139"><asp:TextBox runat="server" ID="txtCuentaDeposito" 
                   CssClass="form-control2" /></td>
        </tr>
        
        <tr>
        <td class="style131"></td>
        </tr>
        <tr>
        <td></td>
      <td></td>
      <td></td>
        <td></td>
        
        <td class="style140"><div align="left">   
        <asp:Button runat="server" ID="btnSave" Text="Guardar" onclick="btnSave_Click"  
                class="btn btn-primary" Height="26px" Width="71px" />
       
    </div></td>
    <td style="text-align: left" class="style136"> <asp:Button runat="server" ID="btnCancel" Text="Cancelar" class="btn btn-primary" 
            onclick="btnCancel_Click" Height="28px" Width="74px" /></td>
        
        </tr>
        

    </table>
    
</asp:Content>
