﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataObjects
{
    /// <summary>
    /// Author: Caitlin Abelson
    /// Created Date: 1/27/19
    /// 
    /// The employee data objects class holds the objects for an employee that works at the resort.
    /// 
    /// Author: Matt LaMarche
    /// Created Date: 3/11/19
    /// Added in a List of Employee Roles
    /// </summary>
    public class Employee
    {
        public int EmployeeID { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string PhoneNumber { get; set; }
        public string DepartmentID { get; set; }
        public bool Active { get; set; }
        public List<Role> EmployeeRoles { get; set; }
        public Employee()
        {
            EmployeeRoles = new List<Role>();
        }
    }


}
