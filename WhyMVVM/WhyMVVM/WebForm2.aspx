<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" Inherits="WhyMVVM.WebForm2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <script src="Scripts/knockout-3.2.0.js"></script>

    <title></title>
</head>
<body>
    <form id="form1" runat="server" >

        <input id="RadioButton1" type="radio" name="FuelType" value="gasoline" data-bind="checked: fuel"><label for="RadioButton1">Bensin</label>
        <br>
        <input id="RadioButton2" type="radio" name="FuelType" value="diesel" data-bind="checked: fuel"><label for="RadioButton2">Diesel</label>
        <br>
        <span data-bind="text: fuel"></span>
        <br>
        <select name="DropDownList1" id="DropDownList1" data-bind="value: brand" >
            <option value="Saab">Saab</option>
            <option value="Volvo">Volvo</option>
            <option  value="Toyota" >Toyota</option>
        </select>
        <br>
        <span data-bind="text: brand"></span>
        <br>
        <input name="TextBox1" type="text" id="TextBox1" data-bind="value: name">
        <br>
        <span data-bind="text: name"></span>
        <br>
        <input type="submit" name="Button1" value="Button" id="Button1" data-bind="enable: name() == 'Anders' && brand() == 'Volvo' && fuel() == 'diesel'" >
    </form>
</body>
    <script>
        var myViewModel = {
            fuel: ko.observable("gasoline"),
            brand: ko.observable("Toyota"),
            name: ko.observable("")
        };
        ko.applyBindings(myViewModel);
    </script>

</html>
