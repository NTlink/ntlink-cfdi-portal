using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.ServiceModel;
using System.ServiceProcess;
using System.Text;
using System.Xml;
using ServicioLocal;
using ServicioLocalContract;
using log4net;
using log4net.Config;
using log4net.Repository.Hierarchy;

namespace NtLinkServicioLocal
{
    public partial class NtLinkServicioLocal : ServiceBase
    {
        private ServiceHost host;
        protected static ILog Logger = LogManager.GetLogger(typeof(NtLinkServicioLocal));
        public NtLinkServicioLocal()
        {
            log4net.Config.XmlConfigurator.Configure();
            InitializeComponent();
        }

        protected override void OnStart(string[] args)
        {


            try
            {
                System.Net.ServicePointManager.DefaultConnectionLimit = 200;
                Logger.Info("Iniciando servicio local...");
                XmlConfigurator.Configure();
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
                string uriLocal = "net.tcp://localhost:" + puerto + "/ServicioLocal";
                Logger.Info("Uri:" + uriLocal);
                host = new ServiceHost(typeof(ServicioLocalProcess)); 
                host.AddServiceEndpoint(typeof(IServicioLocal), tcpBinding, uriLocal);
                host.Open();
            }
            catch (Exception ex)
            {
                Logger.Error("Error al iniciar el servicio. Error:" + ex);
            }
        }

        protected override void OnStop()
        {
            try
            {
                Logger.Error("Deteniendo servicio local...");
                host.Close();
            }
            catch (Exception ex)
            {
                Logger.Error("Error al detener el servicio. Error:" + ex);
            }
        }
    }
}
