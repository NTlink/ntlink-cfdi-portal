using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Security.Cryptography.X509Certificates;
using Jose;
using System.Security.Cryptography;
using System.Web.Script.Serialization;
using System.Text;
using Newtonsoft.Json.Linq;
using System.Configuration;

/// <summary>
/// Descripción breve de TokenClass
/// </summary>
public class TokenClass
{
    public string Error { get; set; }
    public string Correo { get; set; }

    struct MyObj
    {
        public string iss { get; set; }
        public string usuario { get; set; }
        public string exp { get; set; }
    }

    public TokenClass()
    {
        //
        // TODO: Agregar aquí la lógica del constructor
        //
    }

    //-----------------------------------------------------------------------------------------------------
    // from JWT spec
    private byte[] Base64UrlDecode(string input)
    {
        var output = input;
        output = output.Replace('-', '+'); // 62nd char of encoding
        output = output.Replace('_', '/'); // 63rd char of encoding
        switch (output.Length % 4) // Pad with trailing '='s
        {
            case 0: break; // No pad chars in this case
            case 2: output += "=="; break; // Two pad chars
            case 3: output += "="; break; // One pad char
            default: throw new System.Exception("Illegal base64url string!");
        }
        var converted = Convert.FromBase64String(output); // Standard base64 decoder
        return converted;
    }

    //-----------------------------------------------------------------------------------------------------
    public string CuerpoDecode(string token)
    {
        var parts = token.Split('.');
        var header = parts[0];
        var payload = parts[1];
        byte[] crypto = Base64UrlDecode(parts[2]);

        // var headerJson = Encoding.UTF8.GetString(Base64UrlDecode(header));
        // var headerData = JObject.Parse(headerJson);
        var payloadJson = Encoding.UTF8.GetString(Base64UrlDecode(payload));
        var payloadData = JObject.Parse(payloadJson);
        var empresa = (string)payloadData["iss"];
        return empresa;
    }

    //-----------------------------------------------------------------------------------------------------
    public string codificar(string correo, string empresa)
    {
        try
        {
            var utc0 = new DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc);
            var issueTime = DateTime.Now;

            //var iat = (int)issueTime.Subtract(utc0).TotalSeconds;
            //var exp = (int)issueTime.AddMinutes(55).Subtract(utc0).TotalSeconds; // Expiration time is up to 1 hour, but lets play on safe side
            var exp = (int)issueTime.AddMinutes(455).Subtract(utc0).TotalSeconds; // Expiration time is up to 1 hour, but lets play on safe side


            string ruta = ConfigurationManager.AppSettings["LlaveToken"];
            string KEY = ConfigurationManager.AppSettings["KEYToken"];

            var privateKey = new X509Certificate2(@ruta, KEY, X509KeyStorageFlags.Exportable | X509KeyStorageFlags.MachineKeySet).PrivateKey as RSACryptoServiceProvider;


            var payload = new Dictionary<string, object>() 
        {
   
          {"iss", empresa},
          {"usuario", correo},
          {"exp", exp}
        };

            string token = Jose.JWT.Encode(payload, privateKey, JwsAlgorithm.RS512);

            return token;
        }
        catch (Exception ex)
        {
            return null;
        }

    }

    //-----------------------------------------------------------------------------------------------------
    public void decodificar(string token)
    {


        try
        {
            this.Error = "0";

            /*    
            string certificatePath2 = @"C:\Certificado\certificado.cer";
            X509Certificate2 _CertificadoPublico = new X509Certificate2(certificatePath2);
            byte[] publicKey = _CertificadoPublico.GetPublicKey();
            var privateKey = publicKey;
            */

            /*
            string certificatePath2 = @"C:\Certificado\certificado.cer";
            X509Certificate2 _CertificadoPublico = new X509Certificate2(certificatePath2);
            RSACryptoServiceProvider RSA2 = (RSACryptoServiceProvider)_CertificadoPublico.PublicKey.Key;
            byte[] privateKeyBlob = RSA2.ExportCspBlob(false);

            var privateKey = privateKeyBlob;
            */

            string ruta = ConfigurationManager.AppSettings["CertificadosToken"];
            var privateKey = new X509Certificate2(@ruta).PublicKey.Key as RSACryptoServiceProvider;

            // var privateKey = new X509Certificate2(@"C:\Certificado\deploy.cuentasporpagar.com.crt","" , X509KeyStorageFlags.Exportable | X509KeyStorageFlags.MachineKeySet).PrivateKey as RSACryptoServiceProvider;

            //var privateKey = new X509Certificate2(@"C:\Certificado\privada.p12", "#NTLink$", X509KeyStorageFlags.Exportable | X509KeyStorageFlags.MachineKeySet).PrivateKey as RSACryptoServiceProvider;

            string json = Jose.JWT.Decode(token, privateKey);



            JavaScriptSerializer json_serializer = new JavaScriptSerializer();
            MyObj routes_list = json_serializer.Deserialize<MyObj>(json);


            if (!String.IsNullOrEmpty(routes_list.exp))
            {
                var epoch = new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc);
                DateTime fecha;
                int firstCharacter = routes_list.exp.IndexOf(".");
                if (firstCharacter != -1)
                {
                    string fe = routes_list.exp.Remove(firstCharacter);
                    fecha = epoch.AddSeconds(Convert.ToInt64(fe));

                }
                else
                    fecha = epoch.AddSeconds(Convert.ToInt64(routes_list.exp));

                DateTime fecha2 = DateTime.Now;
                int result = DateTime.Compare(fecha, fecha2);
                if (result <= 0)
                { this.Error = "1"; }
                else
                {
                    if (!String.IsNullOrEmpty(routes_list.usuario))
                        this.Correo = routes_list.usuario;
                    else
                        this.Error = "1";
                }
            }
        }
        catch (Exception ex)
        {
            this.Error = "1";
        }


    }

    //-----------------------------------------------------------------------------------------------------

}