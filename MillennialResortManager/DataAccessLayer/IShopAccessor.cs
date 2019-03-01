﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataObjects;

/// <summary>
/// Author: Kevin Broskow
/// Created : 2/27/2019
/// The IShopManager is an interface designed to assure methodology in subsiquent accessors.
/// </summary>
namespace DataAccessLayer
{
    public interface IShopAccessor
    {
        int CreateShop(Shop shop);
    }
}
