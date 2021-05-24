using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;

namespace ServicioLocalContract.entities
{
    [Serializable()]
    public class UsuarioSistem
    {
        [DataMemberAttribute]
        public string Email { get; set; }
        [DataMemberAttribute]
        public string LastLoginDate { get; set; }
    }
}
