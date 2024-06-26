﻿using DataObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace Presentation
{
    /// <summary>
    /// Interaction logic for frmConfirmAction.xaml
    /// </summary>
    public partial class frmConfirmAction : Window
    {
        public frmConfirmAction(CrudFunction crudFuction)
        {
            InitializeComponent();
            lblPrompt.Content = "Are you sure you would like to " + crudFuction.ToString() + " this record?";
        }

        private void BtnExit_Click(object sender, RoutedEventArgs e)
        {
            this.DialogResult = false;
        }

        private void BtnSubmit_Click(object sender, RoutedEventArgs e)
        {
            this.DialogResult = true;
        }
    }
}
