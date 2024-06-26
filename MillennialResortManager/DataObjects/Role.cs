﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataObjects
{

    /// <summary>
    /// Eduardo Colon
    /// Created: 2019/01/30
    /// 
    /// the role dataObjects
    /// </summary>
    public class Role
    {
        public string RoleID { get; set; }

        public string Description { get; set; }
        //  public bool Active { get; set; }

        /// <summary>
        /// Alisa Roehr
        /// Created: 2019/04/05
        /// </summary>
        /// <returns></returns>
        public override string ToString()
        {
            return RoleID;
        }
    }

}
