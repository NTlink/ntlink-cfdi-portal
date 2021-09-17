using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ServicioLocalContract.Entities
{
       [Serializable()]
   public class AddendaConcepto
    {
         public  List<string> Concepto { get; set; }

           public AddendaConcepto()
           {
               Concepto = new List<string>();
           }
    }
}
