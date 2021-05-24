using System;
using System.Configuration;
using System.Net.Security;
using System.ServiceModel;
using System.ServiceModel.Description;
using System.Xml;

using System.Web;

namespace ServicioLocalContract
{
    public static class NtLinkClientFactory
    {

        public static IServicioLocalWEB Cliente()
        {
            string uri = ConfigurationManager.AppSettings["ServicioLocal"];

            XmlDictionaryReaderQuotas readerQuotas = new XmlDictionaryReaderQuotas();
            readerQuotas.MaxDepth = 32;
            readerQuotas.MaxStringContentLength = Int32.MaxValue;
            readerQuotas.MaxArrayLength = int.MaxValue;
            readerQuotas.MaxBytesPerRead = Int32.MaxValue;
            readerQuotas.MaxNameTableCharCount = Int32.MaxValue;

            WSHttpBinding httpbind = new WSHttpBinding();
            httpbind.Security.Mode = SecurityMode.None;
            httpbind.ReaderQuotas = readerQuotas;

            httpbind.ReceiveTimeout = TimeSpan.MaxValue;
            httpbind.SendTimeout = TimeSpan.MaxValue;
            httpbind.CloseTimeout = TimeSpan.MaxValue;
            httpbind.MaxReceivedMessageSize = Int32.MaxValue;
            //
            httpbind.MaxBufferPoolSize = Int32.MaxValue;
            httpbind.TransactionFlow = false;

            EndpointAddress address = new EndpointAddress(uri);
            ChannelFactory<IServicioLocalWEB> factory = new ChannelFactory<IServicioLocalWEB>(httpbind, address);

            foreach (OperationDescription op in factory.Endpoint.Contract.Operations)
            {
                var dataContractBehavior = op.Behaviors.Find<DataContractSerializerOperationBehavior>();
                if (dataContractBehavior != null)
                {
                    dataContractBehavior.MaxItemsInObjectGraph = int.MaxValue;
                }
            }
            IServicioLocalWEB cliente = factory.CreateChannel();

            return cliente;
        }
            /*
              public static IServicioLocal Cliente()
             {
       
            string uri = ConfigurationManager.AppSettings["ServicioLocal"];
            NetTcpBinding tcpBinding = new NetTcpBinding();
            tcpBinding.TransactionFlow = false;
            tcpBinding.Security.Transport.ProtectionLevel =
                ProtectionLevel.EncryptAndSign;
            tcpBinding.Security.Transport.ClientCredentialType =
                TcpClientCredentialType.Windows;
            tcpBinding.Security.Mode = SecurityMode.None;
            XmlDictionaryReaderQuotas readerQuotas = new XmlDictionaryReaderQuotas();
            readerQuotas.MaxDepth = 32;
            readerQuotas.MaxStringContentLength = Int32.MaxValue;
            readerQuotas.MaxArrayLength = int.MaxValue;
            readerQuotas.MaxBytesPerRead = Int32.MaxValue;
            readerQuotas.MaxNameTableCharCount = Int32.MaxValue;
            
            tcpBinding.ReaderQuotas = readerQuotas;
            tcpBinding.ReceiveTimeout = TimeSpan.MaxValue;
            tcpBinding.SendTimeout = TimeSpan.MaxValue;
            tcpBinding.CloseTimeout = TimeSpan.MaxValue;
            tcpBinding.MaxReceivedMessageSize = Int32.MaxValue;
            tcpBinding.MaxBufferSize = Int32.MaxValue;
            EndpointAddress address = new EndpointAddress(uri);
            ChannelFactory<IServicioLocal> factory = new ChannelFactory<IServicioLocal>(tcpBinding, address);
            
            foreach (OperationDescription op in factory.Endpoint.Contract.Operations)
            {
                var dataContractBehavior = op.Behaviors.Find<DataContractSerializerOperationBehavior>();
                if (dataContractBehavior != null)
                {
                    dataContractBehavior.MaxItemsInObjectGraph = int.MaxValue;
                }
                var debug = op.Behaviors.Find<ServiceDebugBehavior>();
                if (debug != null)
                {
                    debug.IncludeExceptionDetailInFaults = true;
                }
            }
            IServicioLocal cliente = factory.CreateChannel();
            return cliente;
              }
          */
        
    }
}
