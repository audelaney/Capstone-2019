﻿using DataObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LogicLayer
{
    /// <summary>
    /// Author: Dalton Cleveland
    /// Created : 1/24/2019
    /// ISponsorManager is an interface meant to be the standard for interacting
    /// with Sponsors in a storage medium
    /// </summary>
    public interface ISponsorManager
    {
        void InsertSponsor(Sponsor newSponsor);
        bool UpdateSponsor(Sponsor oldSponsor, Sponsor newSponsor);
        Sponsor SelectSponsor(int sponsorID);
        List<Sponsor> SelectAllSponsors();
        List<string> RetrieveAllSponsorStatus();
        List<string> RetrieveAllStates();
        List<BrowseSponsor> SelectAllVMSponsors();
        void DeleteSponsor(int sponsorID, bool isActive);//run
    }
}
