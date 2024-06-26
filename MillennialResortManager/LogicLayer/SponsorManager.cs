﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataObjects;
using DataAccessLayer;

namespace LogicLayer
{
    /// <summary>
    /// Author: Gunardi Saputra
    /// Created : 2019/02/20
    /// SponsorManager Is an implementation of the 
    /// ISponsorManager Interface meant to interact 
    /// with the  SponsorAccessor
    /// </summary>
    public class SponsorManager : ISponsorManager
    {

        private ISponsorAccessor _sponsorAccessor;

        /// <summary>
        /// Author: Gunadi Saputra
        /// Created Date: 2019/02/28
        /// 
        /// The constructor for the SponsorManager class
        /// </summary>
        public SponsorManager()
        {
            _sponsorAccessor = new SponsorAccessor();
        }


        /// <summary>
        /// Author: Gunardi Saputra
        /// Created Date: 2019/02/20
        /// 
        /// The InsertSponsor method adds a sponsor to the database.
        /// </summary>
        public void InsertSponsor(Sponsor newSponsor)
        {
            try
            {
                if (!isValid(newSponsor))
                {
                    throw new ArgumentException("Invalid data for the sponsor.");
                }
                _sponsorAccessor.InsertSponsor(newSponsor);
            }
            catch (Exception)
            {
                throw;
            }

        }
        /// <summary>
        /// Author: Gunardi Saputra
        /// Created Date: 2019/02/20
        /// 
        /// Method to see if everything is valid.
        /// </summary>
        /// <param name="newSponsor"></param>
        public bool isValid(Sponsor newSponsor)
        {
            if (validateName(newSponsor.Name)
                && validateAddress(newSponsor.Address)
                && validateCity(newSponsor.City)
                && validateStatusID(newSponsor.StatusID)
                && validateState(newSponsor.State)
                && validatePhoneNumber(newSponsor.PhoneNumber)
                && validateEmail(newSponsor.Email)
                && validateContactFirstName(newSponsor.ContactFirstName)
                && validateContactLastName(newSponsor.ContactLastName))
            {
                return true;
            }

            return false;
        }

        /// <summary>
        /// Author: Gunardi Saputra
        /// Created Date: 2019/02/20
        /// 
        /// Validation for name
        /// </summary>
        /// <param name="name"></param>
        public bool validateName(string name)
        {

            if (name.Length < 1 || name.Length > 50)
            {
                return false;
            }
            return true;
        }

        /// <summary>
        /// Author: Gunardi Saputra
        /// Created Date: 2019/02/20
        /// 
        /// Validation for address
        /// </summary>
        /// <param name="address"></param>
        public bool validateAddress(string address)
        {

            if (address.Length < 7 || address.Length > 50)
            {
                return false;
            }
            return true;
        }

        /// <summary>
        /// Author: Gunardi Saputra
        /// Created Date: 2019/02/20
        /// 
        /// Validation for city
        /// </summary>
        /// <param name="city"></param>
        public bool validateCity(string city)
        {

            if (city.Length < 3 || city.Length > 50)
            {
                return false;
            }
            return true;
        }
        /// <summary>
        /// Author: Gunardi Saputra
        /// Created Date: 2019/02/20
        /// 
        /// Validation for contact first Name
        /// </summary>
        /// <param name="contactFirstName"></param>
        public bool validateContactFirstName(string contactFirstName)
        {

            if (contactFirstName.Length < 1 || contactFirstName.Length > 50)
            {
                return false;
            }
            return true;
        }
         /// <summary>
        /// Author: Gunardi Saputra
        /// Created Date: 2019/02/20
        /// 
        /// Validation for contact last name
        /// </summary>
        /// <param name="contactLastName"></param>
        public bool validateContactLastName(string contactLastName)
        {

            if (contactLastName.Length < 1 || contactLastName.Length > 50)
            {
                return false;
            }
            return true;
        }

        /// <summary>
        /// Author: Gunardi Saputra
        /// Created Date: 2019/02/20
        /// 
        /// Validation for phoneNumber
        /// </summary>
        /// <param name="phoneNumber"></param>
        public bool validatePhoneNumber(string phoneNumber)
        {

            if (phoneNumber.Length != 11)
            {
                return false;
            }
            return true;
        }

        /// <summary>
        /// Author: Gunardi Saputra
        /// Created Date: 2019/02/20
        /// 
        /// Validation for email
        /// </summary>
        /// <param name="email"></param>
        public bool validateEmail(string email)
        {

            if (email.Length < 7 || email.Length > 250)
            {
                return false;
            }
            return true;
        }

        /// <summary>
        /// Author: Gunardi Saputra
        /// Created Date: 2019/02/20
        /// 
        /// Validation for StatusID
        /// </summary>
        /// <param name="statusID"></param>
        public bool validateStatusID(string statusID)
        {
            if (statusID == null || statusID =="" )
            {
                return false;
            }
            return true;
        }
        /// <summary>
        /// Author: Gunardi Saputra
        /// Created Date: 2019/02/20
        /// 
        /// Validation for statusID
        /// </summary>
        /// <param name="state"></param>
        public bool validateState(string state)
        {
            if (state == null || state =="" )
            {
                return false;
            }
            return true;
        }

        /// <summary>
        /// Author: Gunardi Saputra
        /// Created Date: 2019/02/20
        /// 
        /// The DeleteSponsor method return an active or inactive sponsor
        /// from the SponsorAccessor
        /// </summary>
        /// <param name="sponsorID"></param>
        /// <param name="isActive"></param>
        public void DeleteSponsor(int sponsorID, bool isActive)
        {
            if (isActive)
            {
                //Is Active so we just deactivate it
                try
                {
                    _sponsorAccessor.DeactivateSponsor(sponsorID);
                }
                catch (Exception)
                {
                    throw;
                }
            }
            else
            {
                //Is Deactive so we remove it
                try
                {
                    _sponsorAccessor.DeleteSponsor(sponsorID);
                }
                catch (Exception)
                {
                    throw;
                }
            }
        }

        /// <summary>
        /// Author: Gunardi Saputra
        /// Created Date: 2019/02/20
        /// 
        /// The UpdateSponsor method returns 
        /// a new sponsor and an existing sponsor 
        /// from the SponsorAccessor
        /// </summary>
        /// <param name="oldSponsor"></param>
        /// <param name="newSponsor"></param>
        public bool UpdateSponsor(Sponsor oldSponsor, Sponsor newSponsor)
        {
            bool result = false;
            try
            {
                if (!isValid(newSponsor))
                {
                    throw new ArgumentException("Invalid data for the sponsor.");
                }
                result = 1 == _sponsorAccessor.UpdateSponsor(oldSponsor, newSponsor);
            }
            catch (Exception)
            {
                throw;
            }
            return result;
        }



        /// <summary>
        /// Author: Gunardi Saputra
        /// Created Date: 2019/02/28
        /// 
        /// Constructor for the mock accessor
        /// </summary>
        /// <param name="sponsorAccessorMock"></param>
        public SponsorManager(SponsorAccessorMock sponsorAccessorMock)
        {
            _sponsorAccessor = sponsorAccessorMock;
        }

        /// <summary>
        /// Author: Gunardi Saputra
        /// Created Date: 2019/02/20
        /// 
        /// This method gets all of the sponsors in the table
        /// </summary>
        public List<Sponsor> SelectAllSponsors()
        {
            List<Sponsor> sponsors = new List<Sponsor>(); 
            try
            {
                sponsors = _sponsorAccessor.SelectAllSponsors();
            }
            catch (Exception)
            {
                throw;
            }
            return sponsors;
        }

        /// <summary>
        /// Author: Gunardi Saputra
        /// Created Date: 2019/02/20
        /// 
        /// This method gets all of the sponsors in the table
        /// </summary>
        public List<BrowseSponsor> SelectAllVMSponsors()
        {
            List<BrowseSponsor> sponsors = new List<BrowseSponsor>();
            try
            {
                sponsors = _sponsorAccessor.SelectAllVMSponsors();
            }
            catch (Exception)
            {
                throw;
            }
            return sponsors;
        }
        /// <summary>
        /// Author: Gunardi Saputra
        /// Created Date: 2019/02/20
        /// 
        /// The RetrieveAllStates method returns States list
        /// from the SponsorAccessor
        /// </summary>
        public List<string> RetrieveAllStates()
        {
            List<string> allStates = null;

            try
            {
                allStates = _sponsorAccessor.SelectAllStates();
            }
            catch (Exception)
            {
                throw;
            }

            return allStates;
        }

        /// <summary>
        /// Author: Gunardi Saputra
        /// Created Date: 2019/02/20
        /// 
        /// The SelectAllSponsorStatus method returns sponsorStatus 
        /// from the SponsorAccessor
        /// </summary>
        public List<string> RetrieveAllSponsorStatus()
        {
            List<string> statusID = null;

            try
            {
                statusID = _sponsorAccessor.SelectAllSponsorStatus();
            }
            catch (Exception)
            {
                throw;
            }

            return statusID;
        }


        /// <summary>
        /// Author: Gunardi Saputra
        /// Created Date: 2019/02/20
        /// 
        /// The SelectSponsor method returns a sponsor 
        /// from the SponsorAccessor
        /// </summary>
        /// <param name="sponsorID"></param>
        public Sponsor SelectSponsor(int sponsorID)
        {
            Sponsor sponsor = new Sponsor();
            try
            {
                sponsor = _sponsorAccessor.SelectSponsor(sponsorID);
            }
            catch (Exception)
            {
                throw;
            }
            return sponsor;
        }


    }
}
