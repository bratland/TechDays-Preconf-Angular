<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Import Namespace="Tartfabriken.HB.AzureLib" %>
<%@ Import Namespace="Tartfabriken.HB.Lib" %>
<%@ Import Namespace="Tartfabriken.HB.Lib.Data" %>
<%@ Import Namespace="Tartfabriken.HB.Lib.Entities" %>

<%
	string productStr = Request.QueryString["id"];
	int productId;
	if (!int.TryParse(productStr, out productId))
	{
		Response.Redirect("/");
	}

	string connectionString = ConfigurationManager.ConnectionStrings["tartfabriken"].ConnectionString;
	var db = new Repository(connectionString);
	Product product = db.GetProductById(productId);

	if (product == null)
	{
		Response.Redirect("/");
	}

	string error = "";

	if (HttpContext.Current.Request.RequestType == "POST" &&
			Request.Form["orderEmail"] != null &&
			Request.Form["orderShipping"] != null)
	{
		Order order = new Order();
		order.ProductId = product.Id;

		string email = Request.Form["orderEmail"];

		if (email == null | email == "")
		{
			error = "Du måste ange epost adress.";
		}
		order.Email = email;

		string shipping = Request["orderShipping"];
		if (shipping == null | shipping == "")
		{
			error = "Du måste ange address.";
		}
		order.Shipping = shipping;

		// If there is no error try to process order
		string quantityStr = Request["orderQty"];
		int quantity;
		if (!int.TryParse(quantityStr, out quantity))
		{
			error = "Du måste ange antal.";
		}
		order.Quantity = quantity;
		order.Price = product.Price * quantity;

		IOrderingService orderingService = new OrderingService(connectionString);
		var webMail = new WebMail();
		var tartMailService = new TartMailService();
		string mailBody = tartMailService.CreateMailBodyFor(order, product);

		// Lägg order
		var orderSuccessfull = orderingService.Submit(order);

		if (orderSuccessfull)
		{
			// Skicka mail
			orderSuccessfull = webMail.Send("smtp.office365.com", 587, true, ConfigurationManager.AppSettings["EmailSendUserName"], ConfigurationManager.AppSettings["EmailSendPassWord"], ConfigurationManager.AppSettings["EmailSendUserName"], "Tartfabriken HB", email, "Beställning hos Tartfabriken", mailBody);
		}

		if (orderSuccessfull)
		{
			// Happy Path!
			Response.Redirect("OrderSuccess.aspx");
			return;
		}
		
		if (string.IsNullOrEmpty(error))
		{
			error = "Det blev något fel och din oder kunde inte processas just nu!";		
		}
	}
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="Scripts/jquery-1.9.0.min.js">    </script>
    <script type="text/javascript">
                         $(function () {
                             var price = parseFloat($("#orderPrice").text()).toFixed(2),
                                 total = $("#orderTotal"),
                                 orderQty = $("#orderQty");

                             orderQty.change(function () {
                                 var quantity = parseInt(orderQty.val());
                                 if (!quantity || quantity < 1) {
                                     orderQty.val(1);
                                     quantity = 1;
                                 } else if (quantity.toString() !== orderQty.val()) {
                                     orderQty.val(quantity);
                                 }
                                 total.text((price * quantity).toFixed(2) + "kr");
                             });
                         });
                     </script>
	<title>Tårtfabriken HB - lägg en order</title>
	<link href="Content/Site.css" rel="stylesheet" />
	<link href="favicon.ico" rel="shortcut icon" type="image/x-icon" />
        
</head>
<body>
	<ol id="orderProcess">
		<li><span class="step-number">1</span>Välj Produkt</li>
		<li class="current"><span class="step-number">2</span>Detaljer &amp; Beställ</li>
		<li><span class="step-number">3</span>Kvitto</li>
	</ol>
	<p class="site-title"><a href="Default.aspx">Tartfabriken</a></p>
	<h1>Gör en beställning: <%=product.Name%></h1>
	<form action="" method="post">
		<%=error%>

		<fieldset class="no-legend">
			<legend>Lägg en order</legend>
			<img class="product-image order-image" src="Images/Products/Thumbnails/<%=product.ImageName%>" alt="Image of <%=product.Name %>" />
			<ul class="orderPageList">
				<li>
					<div>
						<p class="description"><%=product.Description%></p>
					</div>
				</li>
				<li class="email">
					<div class="fieldcontainer">
						<label for="orderEmail">Epost</label>
						<input type="text" id="orderEmail" name="orderEmail" />
					</div>
				</li>
				<li class="shipping">
					<div class="fieldcontainer">
						<label for="orderShipping">Adress</label>
						<textarea rows="4" id="orderShipping" name="orderShipping"></textarea>
					</div>
				</li>
				<li class="quantity">
					<div class="fieldcontainer">
						<label for="orderQty">Antal</label>
						<input type="text" id="orderQty" name="orderQty" value="1" />
						x
						<span id="orderPrice"><%=string.Format("{0:f}", product.Price)%></span>
						=
						<span id="orderTotal"><%=string.Format("{0:f}", product.Price)%></span>
					</div>
				</li>
			</ul>
			<p class="actions">
				<input type="hidden" name="ProductId" value="<%=product.Id%>" />
				<input type="submit" value="Beställ!!!" />
			</p>
		</fieldset>
	</form>
</body>
</html>

