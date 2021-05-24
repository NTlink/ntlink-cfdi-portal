using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ServicioLocalContract.Entities
{
     [Serializable()]
    public class DatosAmazon
    {
        public List<AmazonLosAtributos> atributos { get; set; }
        public string TextoLibre { get; set; }

        public DatosAmazon()
        {
            atributos = new List<AmazonLosAtributos>();
        }
    }
    [Serializable()]
    public class AmazonLosAtributos
    {
        public string identificacionUnica { get; set; }
        public string nombreDelAtributo { get; set; }
        public string valorDelAtributo { get; set; }
    }
}
