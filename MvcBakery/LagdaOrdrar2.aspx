<%@ Page Language="C#" AutoEventWireup="true" %>

<%@ Import Namespace="Tartfabriken.HB.Lib.Data" %>
<%@ Import Namespace="Tartfabriken.HB.Lib.Entities" %>
<%
    string connectionString = ConfigurationManager.ConnectionStrings["tartfabriken"].ConnectionString;
    var repository = new Repository(connectionString);
    List<Order> orders = repository.OpenOrders();
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" ng-app="app">
<head runat="server">
    <title>Tårtfabriken HB - lagda ordrar</title>
    <link href="Content/Site.css" rel="stylesheet" />
    <link href="favicon.ico" rel="shortcut icon" type="image/x-icon" />
    <script src="/Scripts/angular.js"></script>
    <script src="/Scripts/angular-resource.js"></script>
    <script src="/Scripts/angular-animate.js"></script>
    <script src="/Scripts/jquery-2.1.1.min.js"></script>
    <script src="/JsApp/app.js"></script>
    <script src="/JsApp/services/cakeService.js"></script>
    <script src="/JsApp/controllers/cakeController.js"></script>
    <script src="/JsApp/controllers/orderController.js"></script>
    <script src="/JsApp/directives/cake.js"></script>
    <script src="/Scripts/jquery.signalR-2.1.2.min.js"></script>
    <script src="/signalr/hubs"></script>
    <link href="/Content/bootstrap-theme.min.css" rel="stylesheet" />
    <link href="/Content/bootstrap.css" rel="stylesheet" />
    <script src="/Scripts/bootstrap.min.js"></script>

</head>

<body ng-controller="orderCtrl">
    <p class="site-title"><a href="/">Tartfabriken</a></p>
    <h1>Pågående beställningar</h1>
    <div class="menu">
        [ <a href="/">Hem</a> | <a href="LagdaOrdrar.aspx">Lagda ordrar</a> ]
    </div>

    <div>
        <table class="table table-hover table-striped">
            <tr>
                <th>Order#</th>
                <th>Produkt</th>
                <th>Antal</th>
                <th>Öppen</th>
                <th>Pris</th>
                <th>Adress</th>
                <th>&nbsp;</th>
            </tr>

            <tr ng-repeat="order in orders" class="repeated-item">
                <td>{{order.Id}}</td>
                <td>{{order.ProductId}}</td>
                <td>{{order.Quantity}}</td>
                <td>{{order.IsOpen}}</td>
                <td>{{order.Price}}</td>
                <td>{{order.Shipping}}</td>
                <td><input type="button" ng-click="closeOrder(order) "value="Stäng Order"/></td>
            </tr>
        </table>
    </div>
</body>
</html>
