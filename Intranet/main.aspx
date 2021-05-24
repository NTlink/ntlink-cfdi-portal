<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="main.aspx.cs" Inherits="Intranet.main" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
      <link rel="stylesheet" type="text/css" href="css/estilon.css"/>
    <title>Intranet Ntlink</title>
    <style type="text/css">
        .auto-style1 {
            width: 325px;
            height: 93px;
        }
    </style>
</head>
<body style="background-color:#fcfcfc">
    <header style="border: groove; border-color:silver; background-color:white" ><div style="text-align:center";  > <a href="main.aspx"> <img src="Img/intraprueba.png" class="auto-style1" ></a></div></header>
     
    
    
    <div class="nav" runat="server"> <!-- Start of Nav Bar -->
    <ul>
        <li ><a href="Main.aspx">Inicio</a></li>
        <li ><a href="http://ntlink2.com.mx/">Sitio Web</a></li>

        <li ><a href="#">Facturacion</a>
            <ul>

                <li ><a href="http://pruebas.ntlink.com.mx/Factura_3.3/wfrLogin.aspx">Pruebas</a></li>
                <li><a href="https://cfdi33.ntlink.com.mx/Facturacion3.3/wfrLogin.aspx">Produccion</a></li>
            </ul>
        </li>
        
         <li ><a href="#">Administración</a>
            <ul>

                <li ><a href="http://cfdi33.ntlink.com.mx/administracion33/wfrLogin.aspx">Facturación</a></li>
                <li><a href="http://cfdi33.ntlink.com.mx/NominaAdminLocal3.3/wfrLogin.aspx">Nómina</a></li>
            </ul>
        </li>   
               
            
       
        <li ><a href="#">Nómina</a>
            <ul>

                <li ><a href="http://pruebas.ntlink.com.mx/NominaLocal3.3/wfrLogin.aspx">Pruebas</a></li>
                <li><a href="http://cfdi33.ntlink.com.mx/NominaLocal3.3/wfrLogin.aspx">Produccion</a></li>
            </ul>
        </li>

            <li ><a href="#">Documentos</a>
            <ul>

                <li ><a href="Docs/Lista de actividades Soporte.docx">Doc1</a></li>
                <li><a href="http://cfdi33.ntlink.com.mx/NominaLocal3.3/wfrLogin.aspx">Doc2</a></li>
            </ul>
        </li>
       
        
       
    </ul>
       
</div>

    <form id="form1" runat="server">
         
        <div>
            <asp:Button ID="Button1" runat="server" Text="Cerrar Sesion" BackColor="#A8CF38" Height="40px" OnClick="Button1_Click" Width="119px"  CssClass="ButtonClass" BorderStyle="None"/>
        </div>

    </form>



</body>
</html>
