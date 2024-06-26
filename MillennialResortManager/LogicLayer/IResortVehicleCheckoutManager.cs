﻿using System.Collections.Generic;
using DataObjects;

namespace LogicLayer
{
    /// <summary>
    /// Francis Mingomba
    /// Created: 2019/04/03
    ///
    /// Resort Vehicle Checkout Manager Interface
    /// </summary>
    public interface IResortVehicleCheckoutManager
    {
        int AddVehicleCheckout(ResortVehicleCheckout checkout);

        ResortVehicleCheckout RetrieveVehicleCheckoutById(int vehicleCheckoutId);

        IEnumerable<ResortVehicleCheckout> RetrieveVehicleCheckouts();

        void UpdateVehicleCheckouts(ResortVehicleCheckout old, ResortVehicleCheckout newResortVehicleCheckOut);

        void DeleteVehicleCheckout(int vehicleCheckoutId);
    }
}