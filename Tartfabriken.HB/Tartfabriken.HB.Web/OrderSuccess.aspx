<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title>Tårtfabriken HB - order bekräftas</title>
	<link href="Content/Site.css" rel="stylesheet" />
	<link href="favicon.ico" rel="shortcut icon" type="image/x-icon" />
</head>
<body>
	<ol id="orderProcess">
		<li><span class="step-number">1</span>Välj Produkt</li>
		<li><span class="step-number">2</span>Detaljer &amp; Beställ</li>
		<li class="current"><span class="step-number">3</span>Kvitto</li>
	</ol>
	<p class="site-title"><a href="Default.aspx">Tartfabriken</a></p>
	<h1>Orderbekräftelse</h1>
	<div class="message order-success">
		<h2>Tack för din beställning!</h2>
		<p>Vi håller på och bakar den och har skickat dig en bekräftelse i ett epost. Hoppas det ska smaka!</p>
	</div>
</body>
</html>