<%@ Page Language="C#"%>
<%@ Import Namespace="Tartfabriken.HB.Lib.Data" %>
<%
	var orderIdStr = Request.QueryString["OrderId"];
	int orderId;
	if (!int.TryParse(orderIdStr, out orderId))
	{
		Response.Redirect("LagdaOrdrar.aspx");
	}

	var connectionString = ConfigurationManager.ConnectionStrings["tartfabriken"].ConnectionString;
	var repository = new Repository(connectionString);
	repository.CloseOrder(orderId);

	Response.Redirect("LagdaOrdrar.aspx");
%>