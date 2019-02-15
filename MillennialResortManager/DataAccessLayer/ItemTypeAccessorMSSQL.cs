﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using DataObjects;

namespace DataAccessLayer
{
    /// <summary>
	/// Kevin Broskow
	/// Created: 2019/01/20
	/// 
	/// ItemType Acccessor that utilizes SQL
	/// </summary>
    public class ItemTypeAccessorMSSQL : iItemTypeAccessor
    {
        public void CreateItemType(ItemType newItemType)
        {
            throw new NotImplementedException();
        }

        public void DeactivateItemType(ItemType deactivatingItemType)
        {
            throw new NotImplementedException();
        }

        public void PurgeItemType(ItemType purgingItemType)
        {
            throw new NotImplementedException();
        }
        /// <summary>
        /// Kevin Broskow
        /// Created: 2019/01/23
        /// 
        /// Method used to access the database and retrieve all item types.
        /// </summary>
        ///
        /// <remarks>
        /// Updater Name
        /// Updated: yyyy/mm/dd
        /// example: Fixed a problem when user inputs bad data
        /// </remarks>
        /// <returns>List<String> That contains all of the ItemTypeIDs</returns>	
        public List<String> RetrieveAllItemTypes()
        {
            List<String> itemTypes = new List<String>();
            var conn = DBConnection.GetDbConnection();
            var cmdText = @"sp_retrieve_itemtypes";

            var cmd = new SqlCommand(cmdText, conn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            try
            {
                conn.Open();

                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        itemTypes.Add(reader.GetString(0));
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                conn.Close();
            }
            return itemTypes;
        }

        public ItemType RetrieveItemType()
        {
            throw new NotImplementedException();
        }

        public void UpdateItemType(ItemType newItemType, ItemType oldItemType)
        {
            throw new NotImplementedException();
        }
    }
}