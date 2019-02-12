<%@page import="java.util.UUID"%>
<%@page import="cl.transbank.webpay.Webpay"%>
<%@page import="cl.transbank.webpay.configuration.Configuration"%>
<%@page import="cl.transbank.patpass.PatPassByWebpayNormal"%>
<%@page import="cl.transbank.patpass.PatPassInfo"%>

<%@page import="java.util.Random"%>
<%@page import="com.transbank.webpay.wswebpay.service.TransactionResultOutput"%>
<%@page import="com.transbank.webpay.wswebpay.service.WsInitTransactionOutput"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.util.ListIterator"%>
<%@page import="java.lang.reflect.Field"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="cl.transbank.webpay.security.SoapSignature"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ejemplos SDK PatPass by WebPay</title>
        <style type="text/css">
            body { font-family: Tahoma, Helvetica, Arial, Verdana, sans-serif; }
            table { border: 1px solid lightgrey; border-spacing: 3px; }
            td, th { border: 1px solid lightgrey;  padding: 10px 10px; }
            th { background:lightgrey;}
            .request { background-color:lightyellow; }
            .result { background-color:lightgrey; }

        </style>
    </head>
    <h1>Ejemplo PatPass by Webpay para Java</h1>

          <%

        String action = request.getParameter("action");
        if(action == null)action="webpayNormalInit";
        String buyOrder = "", authorizationCode="", authorizedAmount="", fechaTrans="", cardNumber="";

        PatPassByWebpayNormal patPass = new Webpay(
            Configuration.forTestingPatPassByWebpayNormal("testpatpassbywebpay@mailinator.com")
        ).getPatPassByWebpayTransaction();


        /** Si la URL no trae data muestra Menú */
        if (action == null) {

        } else if (action.equalsIgnoreCase("webpayNormalInit")) {

            WsInitTransactionOutput result = new WsInitTransactionOutput();
            String idSession="", urlReturn="", urlFinal="" , serviceId="" , cardHolderId="" , cardHolderName="" , cardHolderLastName1="" , cardHolderLastName2="", cardHolderMail="" ,cellPhoneNumber="",expirationDate=""   ;
            int amount=0;

            /** Transaccion normal */
            try{
                urlReturn = request.getRequestURL().toString()+"?action=webpayNormalGetResult";
                urlFinal = request.getRequestURL().toString()+"?action=end";
                amount = 1000;

                //Se genera un numero aleatorio para la orden de compra.
                Random r = new Random();
                int menor = 150987676;
                int mayor = 356000000;
                int intervalo = mayor - menor;
                int Result = r.nextInt(intervalo) + menor;

                buyOrder = String.valueOf(Result);
                idSession = UUID.randomUUID().toString();
                PatPassInfo info = new PatPassInfo()
                    .setServiceId("335456675433")
                    .setCardHolderId("11.111.111-1")
                    .setCardHolderName("Juan Pedro")
                    .setCardHolderLastName1("Alarcón")
                    .setCardHolderLastName2("Perez")
                    .setCardHolderMail("example@example.com")
                    .setCellPhoneNumber("1234567")
                    .setExpirationDate(new GregorianCalendar(2019, 1, 1));

                result = patPass.initTransaction(amount, buyOrder, idSession, urlReturn, urlFinal, info);


            }catch(Exception e){
                System.out.println("ERROR: " + e);
               %>
               <p><samp>Error: <%out.print(e.toString().replace("<", ""));%></samp></p><br>
               <a href=".">&laquo; Volver al &Iacute;ndice</a>
               <%
            }
 %>

            <h2>Etapa: Inicio de Transacción</h2>

            <div class="request" >
                    <h3>request</h3>
                    <%out.print("[amount] = "+amount+", [buyOrder] = "+buyOrder+", [idSession] = "+idSession+", [urlReturn] = "+urlReturn+", [urlFinal] = "+urlFinal+", [serviceId] = "+serviceId+", [cardHolderId] = "+cardHolderId+", [cardHolderName] = "+cardHolderName+", [cardHolderLastName1] = "+cardHolderLastName1+", [cardHolderLastName2] = "+cardHolderLastName2+", [cardHolderMail] = "+cardHolderMail+", [cellPhoneNumber] = "+cellPhoneNumber+", [expirationDate] = "+expirationDate);%>
            </div>
            <div class="result">
                    <h3>result</h3>
                    <%out.print("[url] = "+result.getUrl()+", [token_ws] = "+result.getToken());%>
            </div>
                    <%if(result.getToken()!=null){    %>
            <p>Sesión iniciada con exito en Webpay</p>
            <form action='<%=result.getUrl()%>' method="post"><input type="hidden" name="token_ws" value='<%=result.getToken()%>'><input type="submit" value="Ir a PatPass &raquo;"></form>

                    <%}else{                                    %>
            <p>Ocurrio un error en la operacion InitTransaction PatPass.</p>
                    <%}                               %>
                    </br>
            <a href=".">&laquo; Volver al &Iacute;ndice</a>


      <%
        } else if (action.equalsIgnoreCase("webpayNormalGetResult")) {

            TransactionResultOutput result = new TransactionResultOutput();
            String token = "";
            int responseCode = 0;

            try{
                token = request.getParameter("token_ws");
                result = patPass.getTransactionResult(token);
                %>


            <h2>Etapa: Obtención de resultado de la Transacción</h2>

            <div class="request">
                    <h3>request</h3>
                    <%out.print("token_ws: "+token);%>
            </div>
            <div class="result">
                    <h3>result</h3>
                    <%out.print("[accountingDate] =\'"+result.getAccountingDate()+"', [buyOrder] ="+result.getBuyOrder()+
                                ", [cardDetail] = cardExpirationDate: "+result.getCardDetail().getCardExpirationDate()+
                                ", [cardNumber] = "+result.getCardDetail().getCardNumber()+", detailOutput: ");


                    if(!result.getDetailOutput().isEmpty()){
                        authorizationCode = result.getDetailOutput().get(0).getAuthorizationCode();
                        authorizedAmount = result.getDetailOutput().get(0).getAmount().toString();
                        buyOrder = result.getDetailOutput().get(0).getBuyOrder();
                        fechaTrans =  result.getTransactionDate().toString();
                        cardNumber = result.getCardDetail().getCardNumber();
                        out.print(", [authorizationCode] = "+authorizationCode);
                        out.print(", [paymentTypeCode] = "+result.getDetailOutput().get(0).getPaymentTypeCode());
                        responseCode = result.getDetailOutput().get(0).getResponseCode();
                        out.print(", [responseCode] = "+result.getDetailOutput().get(0).getResponseCode());
                        out.print(", [sharesNumber] = "+result.getDetailOutput().get(0).getSharesNumber());
                        out.print(", [amount] = "+authorizedAmount);
                        out.print(", [commerceCode] = "+result.getDetailOutput().get(0).getCommerceCode());
                        out.print(", [buyOrder] = "+buyOrder);
                    }

                    out.print(", [sessionId] = "+result.getSessionId()+", [transactionDate] = "+ fechaTrans+
                              ", [urlRedirection] = "+result.getUrlRedirection()+", [VCI] = "+result.getVCI());

                    %>

            <script>window.localStorage.clear();</script>';
            <script>localStorage.setItem("authorizationCode", "<%=authorizationCode%>");</script>
            <script>localStorage.setItem("authorizedAmount", "<%=authorizedAmount%>");</script>
            <script>localStorage.setItem("buyOrder", "<%=buyOrder%>");</script>
            <script>localStorage.setItem("fechaTrans", "<%=fechaTrans%>");</script>
            <script>localStorage.setItem("cardNumber", "<%=cardNumber%>");</script>

            </div>
                    <%if(responseCode!=0){%>
                        <p>Suscripci&oacute;n RECHAZADO por PatPass (Rechazo de transacción) </p>
                    <%}else{%>
                        <p>Suscripción ACEPTADA por PatPass (se deben guardar datos para mostrar voucher)</p>
                        <form action="<%=result.getUrlRedirection()%>" method="post">
                        <input type="submit" value="Continuar &raquo;">
                    <% }%>
          </br>
                <input type="hidden" name="token_ws" value="<%=token%>">

          </form>
            </br>
            <a href=".">&laquo; Volver al &Iacute;ndice</a>

          <%

            }catch(Exception e){
                System.out.println("ERROR: " + e);
               %>
               <p>Error: <%out.print(e.toString().replace("<", ""));%></p><br>
               <a href=".">&laquo; Volver al &Iacute;ndice</a>
               <%
            }
        }else if(action.equalsIgnoreCase("end")){
            String token = request.getParameter("token_ws");
            buyOrder = request.getParameter("buyOrder");
            authorizationCode = request.getParameter("authorizationCode");
            authorizedAmount = request.getParameter("authorizedAmount");
           %>

           <h2>Etapa: Fin de la Transacción</h2>

            <div class="request">
                    <h3>request</h3>
                    <%out.print("No request");%>
            </div>
            <script>
                var authorizationCode = localStorage.getItem('authorizationCode');
                document.getElementById("authorizationCode").value = authorizationCode;

                var amount = localStorage.getItem('authorizedAmount');
                document.getElementById("authorizedAmount").value = amount;

                var buyOrder = localStorage.getItem('buyOrder');
                document.getElementById("buyOrder").value = buyOrder;
                localStorage.clear();
            </script>

             <p>
                <%
                    if(token != null){
                        %>
                        <div class="result">
                            <h3>result</h3>
                            <%out.print("[token_ws] = "+token);%>
                        </div>
                        <p>Transacci&oacute;n Finalizada<br/></p>
                        <%
                        out.print("<pre>VOUCHER COMERCIO:<br/>"
                        +"<br>Monto: $<script>document.write(localStorage.getItem('authorizedAmount'));</script><br/>"
                        + "C&oacute;digo Autorizaci&oacute;n: <script>document.write(localStorage.getItem('authorizationCode'));</script><br/>"
                        + "Orden de Compra: <script>document.write(localStorage.getItem('buyOrder'));</script><br/>"
                        + "Nro Tarjeta: XXXX-<script>document.write(localStorage.getItem('cardNumber'));</script><br/>"
                        + "Fecha: <script>document.write(localStorage.getItem('fechaTrans'));</script><br/></pre>");
                    }else{
                        %>
                        <div class="result">
                            <h3>result</h3>
                            <% out.print("[TBK_TOKEN] = "+request.getParameter("TBK_TOKEN")+", [TBK_ID_SESION] = " + request.getParameter("TBK_ID_SESION")+", [TBK_ORDEN_COMPRA] = "+request.getParameter("TBK_ORDEN_COMPRA")); %>
                        </div>
                        <p>Transacción anulada por el cliente<br/></p>
                        <%
                    }
                %>
            </p>
            </br>
            <a href=".">&laquo; Volver al &Iacute;ndice</a>

        <%

        }
   %>