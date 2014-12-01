<%@ Page Language="C#" AutoEventWireup="true" %>
<%@ Import Namespace="Tartfabriken.HB.Lib.Data" %>
<%@ Import Namespace="Tartfabriken.HB.Lib.Entities" %>

<%
	string connectionString = ConfigurationManager.ConnectionStrings["tartfabriken"].ConnectionString;
	var repository = new Repository(connectionString);
	IEnumerable<Product> products = repository.ReadAll().ToArray();
	var toSkip = new Random().Next(0, products.Count());
	Product featured = products.Skip(toSkip).First();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title>Tårtfabriken HB</title>
	<link href="Content/Site.css" rel="stylesheet" />
	<link href="favicon.ico" rel="shortcut icon" type="image/x-icon" />

</head>
<body >
	<p class="site-title"><a href="Default.aspx">Tartfabriken</a></p>
	<h1>Välkommen till Tartfabriken HB!</h1>
	<div class="menu">
		[ <a href="Default.aspx">Hem</a> | <a href="LagdaOrdrar.aspx">Lagda ordrar</a> ]
	</div>

	<div id="featuredProduct">
		<img alt="Featured Product" src="Images/Products/<%=featured.ImageName%>" />
		<div id="featuredProductInfo">
			<div id="productInfo">
				<h2><%=featured.Name%></h2>
				<p class="price">SEK <%=string.Format("{0:f}", featured.Price)%></p>
				<p class="description"><%=featured.Description%></p>
			</div>
			<div id="callToAction">
				<a class="order-button" href="Order.aspx?Id=<%=featured.Id%>" title="Order <%=featured.Name%>">Beställ nu</a>
			</div>
		</div>
	</div>

	<div id="productsWrapper">
		<ul id="products">
			<%foreach (var product in products)
		 {
			%>
			<li class="product">
				<a href="Order.aspx?Id=<%=product.Id%>" title="Order <%=product.Name%>">
					<img class="hide-from-desktop" src="Images/Products/Thumbnails/<%=product.ImageName%>" alt="Image of <%=product.Name%>" />

					<div class="productInfo">
						<h3><%=product.Name%></h3>
						<img class="product-image hide-from-mobile" src="Images/Products/Thumbnails/<%=product.ImageName%>" alt="Image of <%=product.Name%>" />
						<p class="description"><%=product.Description%></p>
						<p class="price hide-from-desktop">SEK <%=string.Format("{0:f}", product.Price)%></p>
					</div>
				</a>
				<div class="action hide-from-mobile">
					<p class="price">SEK <%=string.Format("{0:f}", product.Price)%></p>
					<a class="order-button" href="Order.aspx?Id=<%=product.Id%>" title="Order <%=product.Name%>">Beställ nu</a>
				</div>
			</li>
			<%
		 }
			%>
		</ul>
	</div>
</body>
</html>