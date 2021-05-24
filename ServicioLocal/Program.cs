using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.ServiceModel;
using System.ServiceModel.Description;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using ClienteNtLink;
using ServicioLocalContract;
using ServicioLocal.Business;
using log4net;
using log4net.Config;

namespace ServicioLocal
{
    class Program
    {
        protected static ILog Logger = LogManager.GetLogger(typeof(NtLinkBusiness));
        static void Main(string[] args)
        {
            //File.WriteAllBytes(@"c:\pdf.pdf", new GeneradorCfdi().GetPdfFromComprobante(
            //File.ReadAllText(@"C:\Salida\SID080303VE0\307120E9-E2A6-41DD-B394-74F7D34CE1F4.xml")));

            XmlConfigurator.Configure();
            Logger.Debug("Iniciando servicio");
            NetTcpBinding tcpBinding = new NetTcpBinding();
            tcpBinding.TransactionFlow = false;
            tcpBinding.Security.Transport.ProtectionLevel =
               System.Net.Security.ProtectionLevel.EncryptAndSign;
            tcpBinding.Security.Transport.ClientCredentialType =
               TcpClientCredentialType.Windows;
            tcpBinding.Security.Mode = SecurityMode.None;
            XmlDictionaryReaderQuotas readerQuotas = new XmlDictionaryReaderQuotas();
            readerQuotas.MaxDepth = 32;
            readerQuotas.MaxStringContentLength = int.MaxValue;
            readerQuotas.MaxArrayLength = int.MaxValue;
            readerQuotas.MaxBytesPerRead = int.MaxValue;
            readerQuotas.MaxNameTableCharCount = int.MaxValue;
            tcpBinding.ReaderQuotas = readerQuotas;
            tcpBinding.MaxReceivedMessageSize = int.MaxValue;
            tcpBinding.MaxBufferSize = int.MaxValue;
            tcpBinding.ReceiveTimeout = TimeSpan.MaxValue;
            tcpBinding.SendTimeout = TimeSpan.MaxValue;
            ServicioLocalProcess p = new ServicioLocalProcess();
            string puerto = ConfigurationManager.AppSettings["puerto"];
            //string uriLocal = "net.tcp://" + TcpUtils.GetIpAddress() + ":" + puerto + "/ServicioLocal";.
            string uriLocal = "net.tcp://localhost:" + puerto + "/ServicioLocal";
            Logger.Info("Uri:" + uriLocal);
            ServiceHost host = new ServiceHost(typeof(ServicioLocalProcess));
            //ServiceHost host = new ServiceHost(p);
            host.AddServiceEndpoint(typeof(IServicioLocal), tcpBinding, uriLocal);
            //foreach (OperationDescription op in host.enContract.Operations)
            //{
            //    var dataContractBehavior = op.Behaviors.Find<DataContractSerializerOperationBehavior>();
            //    if (dataContractBehavior != null)
            //    {
            //        dataContractBehavior.MaxItemsInObjectGraph = int.MaxValue;
            //    }
            //}
            
            host.Open();
            Console.ReadKey();


        }
    }



    /*
            NtLinkUsuarios.CreateRole("Administrador");
            NtLinkUsuarios.CreateRole("Operador");
            var x = NtLinkLogin.ValidateUser("admin", "Admin123#");
            NtLinkUsuarios.AddUserToRoles("admin", new string[]{"Administrador"});
            Console.WriteLine(x.UserName);
     */
}
