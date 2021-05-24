using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ServicioLocalContract.Entities
{
        [Serializable()]
 
    public class VUInformacionAduanera
    {
            public string numero { get; set; }
            public string fecha { get; set; }
            public string aduana { get; set; }
    }
}
