<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm3.aspx.cs" Inherits="WhyMVVM.WebForm3" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" data-ng-app="app">
<head runat="server">
    <script src="Scripts/angular.js"></script>
     <title></title>
    <script>
        angular.module('app', []).controller('brandController',
            function($scope) {
                $scope.brands = ['Volvo', 'Saab', 'Toyota'];
            });

        angular.module('demo', []).directive('cake',function() {
            return {
                template: '<span>Kaka!!!</span>',
                restrict: 'AC',
                transclude: true
            };
        });
    </script>
</head>
<body>
    <form id="form1" runat="server" ng-controller="brandController">
<%--        <div class="cake"></div>--%>
        <input id="RadioButton1" type="radio" name="FuelType" value="gasoline" ng-model="fuel"><label for="RadioButton1">Bensin</label>
        <br>
        <input id="RadioButton2" type="radio" name="FuelType" value="diesel" ng-model="fuel"><label for="RadioButton2">Diesel</label>
        <br>
        <br>
        <select name="DropDownList1" id="DropDownList1" ng-model="brand" >
            <option data-ng-repeat="brand in brands" data-ng-value="brand">Märke: {{brand}}</option>
        </select>
        <br>
        <br>
        <input name="TextBox1" type="text" id="TextBox1" ng-model="name">
        <br>
        <br>
        <input type="submit" name="Button1" value="Button" id="Button1" ng-disabled="name != 'Anders' || brand != 'Volvo' || fuel != 'diesel'" >
    </form>
</body>
</html>
