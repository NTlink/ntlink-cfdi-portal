using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ServicioLocalContract.Entities
{
        [Serializable()]
 
    public class InformacionAduanera
    {
        public string Partida { get; set; }
        public string NumeroPedimento { get; set; }
    }
}
