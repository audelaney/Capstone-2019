﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataObjects;
using System.Data.SqlClient;
using System.Data;
/// <summary>
/// Author: Kevin Broskow
/// Created : 2/27/2019
/// The ShopAccessorMSSQL is used to access shop data store in a microsoft SQL server.
/// </summary>
namespace DataAccessLayer
{
    public class ShopAccessorMSSQL : IShopAccessor
    {
        private List<Shop> _shops = new List<Shop>();
        public ShopAccessorMSSQL()
        {

        }
        /// <summary>
        /// Author: Kevin Broskow
        /// Created : 2/28/2019
        /// Creating a shop object to insert into the database for further use.
        /// </summary>
        /// <param name="shop">The data object of type shop to be added into the database</param>

        public int CreateShop(Shop shop)
        {
            int shopID=0;

            var conn = DBConnection.GetDbConnection();
            var cmdText = @"sp_insert_shop";

            SqlCommand cmd = new SqlCommand(cmdText, conn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@RoomID", shop.RoomID);
            cmd.Parameters.AddWithValue("@Name", shop.Name);
            cmd.Parameters.AddWithValue("@Description", shop.Description);

            try
            {
                conn.Open();
                shopID = cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                conn.Close();
            }

            return shopID;

        }

        public int DeactivateShop(Shop shop)
        {
            throw new NotImplementedException();
        }

        public int DeleteShop(Shop shop)
        {
            throw new NotImplementedException();
        }

        public Shop SelectShopByID(int id)
        {
            throw new NotImplementedException();
        }


        /// <summary>
        /// James Heim
        /// Created 2019-02-28
        /// 
        /// Select all shops from the database.
        /// </summary>
        /// <returns>All Shops</returns>
        public IEnumerable<Shop> SelectShops()
        {
            List<Shop> shops = new List<Shop>();

            var conn = DBConnection.GetDbConnection();
            String cmdText = @"sp_select_shops";
            var cmd = new SqlCommand(cmdText, conn);
            cmd.CommandType = CommandType.StoredProcedure;

            try
            {
                conn.Open();

                var reader = cmd.ExecuteReader();

                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        shops.Add(new Shop()
                        {
                            ShopID = reader.GetInt32(0),
                            RoomID = reader.GetInt32(1),
                            Name = reader.GetString(2),
                            Description = reader.GetString(3),
                            Active = reader.GetBoolean(4)
                        });
                    }
                }
            }
            catch (Exception)
            {

                throw;
            }
            finally
            {
                conn.Close();
            }

            return shops;
        }

        /// <summary>
        /// Author: James Heim
        /// Created 2019-02-28
        /// 
        /// Select all shops from table as well as their
        /// corresponding RoomNumber and BuildingID from
        /// the Room Table.
        /// </summary>
        /// <returns></returns>
        public List<VMBrowseShop> SelectVMShops()
        {
            List<VMBrowseShop> shops = new List<VMBrowseShop>();

            var conn = DBConnection.GetDbConnection();
            var cmdText = @"sp_select_view_model_shops";
            var cmd = new SqlCommand(cmdText, conn);
            cmd.CommandType = CommandType.StoredProcedure;

            try
            {
                conn.Open();

                var reader = cmd.ExecuteReader();

                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        VMBrowseShop shop = new VMBrowseShop()
                        {
                            ShopID = reader.GetInt32(0),
                            RoomID = reader.GetInt32(1),
                            Name = reader.GetString(2),
                            Description = reader.GetString(3),
                            Active = reader.GetBoolean(4),
                            RoomNumber = reader.GetString(5),
                            BuildingID = reader.GetString(6)
                        };
                        shops.Add(shop);
                    }
                }
            }
            catch (Exception)
            {

                throw;
            }
            finally
            {
                conn.Close();
            }

            return shops;
        }

        public int UpdateShop(Shop newShop, Shop oldShop)
        {
            throw new NotImplementedException();
        }
    }
}