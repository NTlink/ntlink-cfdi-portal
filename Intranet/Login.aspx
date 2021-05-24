<%@ Page Title="" Language="C#" MasterPageFile="~/Login.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Intranet.Login1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="css/estilon.css" />
    <link href="https://fonts.googleapis.com/css?family=Arimo" rel="stylesheet">

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table style="width:100%">
        <tr >
            <td style="width:33.3%"></td>
           <td style="width:33.3%; height:100%" >
    <fieldset style=" padding:20px; width:20%; text-align:center" id="form" class="estilo.css">
         <legend>Inicio de sesión</legend>
    <table>

         <tr>
                                        <td>
                                           <div style="text-align:center"> <asp:Label ID="UserNameLabel" runat="server" 
                                             Width="298px">Usuario:</asp:Label></div>
                                        </td>
                                    </tr>
        <tr>
                                        <td>
                                            <asp:TextBox ID="UserName" runat="server"  BorderWidth="1px" Height="21px" Width="212px">
                                                </asp:TextBox>
                                            
                                        </td>
                                    </tr>

        <tr>
                                        <td>
                                            <asp:Label ID="PasswordLabel" runat="server" 
                                               Width="298px">Contraseña</asp:Label>
                                        </td>
                                    </tr>
        <tr>
                                        <td>
                                            <asp:TextBox ID="Password" runat="server"  BorderWidth="1px" 
                                                TextMode="Password" Height="21px" Width="214px"  ></asp:TextBox>
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" style="text-align: center" >
                                            <asp:Label ID="lblusuario" runat="server"></asp:Label>
                                            <br />
                                            <asp:Button ID="Log" runat="server" Text="Inicia Sesion" ValidationGroup="Valida" OnClick="Log_Click" CssClass="ButtonClass" />
                                        </td>
                                    </tr>




    </table>
         </fieldset>

</td>
           <td style="width:33.3%"></td>
        </tr>


    </table>




    

</asp:Content>
