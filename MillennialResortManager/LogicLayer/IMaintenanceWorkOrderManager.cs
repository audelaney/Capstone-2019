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
    /// Created : 2/21/2019
    /// IMaintenanceWorkOrderManager is an interface meant to be the standard for interacting with WorkOrders in a storage medium
    /// </summary>
    public interface IMaintenanceWorkOrderManager
    {
        void AddMaintenanceWorkOrder(MaintenanceWorkOrder newMaintenanceWorkOrder);
        void EditMaintenanceWorkOrder(MaintenanceWorkOrder oldMaintenanceWorkOrder, MaintenanceWorkOrder newMaintenanceWorkOrder);
        MaintenanceWorkOrder RetrieveMaintenanceWorkOrder(int MaintenanceWorkOrderID);
        List<MaintenanceWorkOrder> RetrieveAllMaintenanceWorkOrders();
        void DeleteMaintenanceWorkOrder(int MaintenanceWorkOrderID, bool isActive);
    }
}
