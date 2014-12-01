using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WhyMVVM
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {


        }

        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {
            ValidateForm();
        }

        protected void RadioButton1_CheckedChanged(object sender, EventArgs e)
        {
            ValidateForm();
        }

        private void ValidateForm()
        {
            if (DropDownList1.SelectedValue == "Volvo" && TextBox1.Text == "Anders" && (!RadioButton1.Checked && RadioButton2.Checked))
            {
                Button1.Enabled = true;
            }
            else
            {
                Button1.Enabled = false;
            }

        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            ValidateForm();
        }
    }
}