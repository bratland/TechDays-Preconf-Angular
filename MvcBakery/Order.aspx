<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Import Namespace="MvcBakery.Models" %>

<%
    // Demo quality = true ;)
    var prod = int.Parse(Request["prod"]);
    var product = (new TartfabrikenEntities()).Products.Single(t => t.Id == prod);
%>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title>Tårtfabriken HB - lägg en order</title>
	<link href="favicon.ico" rel="shortcut icon" type="image/x-icon" />
    <script src="Scripts/jquery-2.1.1.min.js"></script>   
    <script src="/Scripts/jquery.signalR-2.1.2.min.js"></script>
    <link href="/Content/bootstrap-theme.min.css" rel="stylesheet" />
    <link href="/Content/bootstrap.css" rel="stylesheet" />
    <script src="/Scripts/bootstrap.min.js"></script>
    <script src="/signalr/hubs"></script>
</head>
<body class="container">
	<p class="site-title"><a href="Default.aspx">Tartfabriken</a></p>
	<h1>Gör en beställning: <%=product.Name%></h1>
	<form action="" method="post" role="form">
		<fieldset class="no-legend">
			<legend>Lägg en order</legend>
			<img class="product-image order-image" src="Images/Products/Thumbnails/<%=product.ImageName%>" alt="Image of <%=product.Name %>" />
					<div>
						<p class="description"><%=product.Description%></p>
					</div>
				<div class="form-group">
					<div class="fieldcontainer">
						<label for="orderEmail">Epost</label>
						<input type="text" id="orderEmail" name="orderEmail" class="form-control"/>
					</div>
				</div>
				<div class="form-group">
					<div class="fieldcontainer">
						<label for="orderShipping">Adress</label>
						<textarea rows="4" id="orderShipping" name="orderShipping" class="form-control"></textarea>
					</div>
				</div>
				<div class="form-group">
					<div class="fieldcontainer">
						<label for="orderQty">Antal</label>
						<input runat="server" type="text" id="orderQty" name="orderQty" value="1" class="form-control"/>
						x
						<span id="orderPrice"><%=string.Format("{0:f}", product.Price)%></span>
						=
						<span id="orderTotal"><%=string.Format("{0:f}", product.Price)%></span>
					</div>
				</div>
			<p class="actions">
				<input type="hidden" id="prodId" name="ProductId" value="<%=product.Id%>" />
				<input id="order" type="submit" value="Beställ" class="btn btn-info" />
			</p>
		</fieldset>
	</form>
</body>
    <script>
        var hub = $.connection.cakeHub;
        $.connection.hub.start().done(function () {
            $('#order').click(function () {
                var order = {};
                order.Quantity = $('#orderQty').val();
                order.ProductId = $('#prodId').val();
                order.email = $('#orderEmail').val();
                order.Shipping = $('#orderShipping').val();
                order.Isopen = true;
                hub.server.addOrder(order);
                // Clear text box and reset focus for next comment. 
            });
        });
    </script>

</html>

