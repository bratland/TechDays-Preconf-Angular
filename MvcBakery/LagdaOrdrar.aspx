<%@ Page Language="C#" AutoEventWireup="true" %>
<%@ Import Namespace="Tartfabriken.HB.Lib.Data" %>
<%@ Import Namespace="Tartfabriken.HB.Lib.Entities" %>
<%
	string connectionString = ConfigurationManager.ConnectionStrings["tartfabriken"].ConnectionString;
	var repository = new Repository(connectionString);
	List<Order> orders = repository.OpenOrders();
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title>Tårtfabriken HB - lagda ordrar</title>
	<link href="Content/Site.css" rel="stylesheet" />
	<link href="favicon.ico" rel="shortcut icon" type="image/x-icon" />
</head>

<body>
	<p class="site-title"><a href="Default.aspx">Tartfabriken</a></p>
	<h1>Pågående beställningar</h1>
	<div class="menu">
		[ <a href="Default.aspx">Hem</a> | <a href="LagdaOrdrar.aspx">Lagda ordrar</a> ]
	</div>

	<div>
		<table>
			<tr>
				<td class="tableHeader">Order#</td>
				<td class="tableHeader">Produkt</td>
				<td class="tableHeader">Antal</td>
				<td class="tableHeader">Pris</td>
				<td class="tableHeader">Adress</td>
				<td class="tableHeader">&nbsp;</td>
			</tr>
			<% foreach (Order order in orders)
			{ %>
			<tr>
				<td><%=order.Id%></td>
				<td><%=repository.GetProductById(order.ProductId).Name%></td>
				<td><%=order.Quantity%></td>
				<td><%=order.Price%></td>
				<td><%=order.Shipping%></td>
				<td>(<a href="Close.aspx?OrderId=<%=order.Id%>">Stäng order</a>)</td>
			</tr>
			<% } %>
		</table>
	</div>
</body>
</html>