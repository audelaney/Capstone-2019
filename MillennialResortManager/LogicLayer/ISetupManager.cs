﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataObjects;

namespace LogicLayer
{
    /// <summary>
    /// Author: Caitlin Abelson
    /// Created Date: 2/28/19
    /// 
    /// The conrete interface for SetupManager
    /// </summary>
    public interface ISetupManager
    {
        int InsertSetup(Setup newSetup);
        void UpdateSetup(Setup newSetup, Setup oldSetup);
        Setup SelectSetup(int setupID);
        List<Setup> SelectAllSetups();
        void DeleteSetup(int setupID);
        List<VMSetup> SelectVMSetups();
        List<VMSetup> SelectDateEntered(DateTime dateEntered);
        List<VMSetup> SelectDateRequired(DateTime dateRequired);
        List<VMSetup> SelectSetupEventTitle(string eventTitle);
        
    }
}
