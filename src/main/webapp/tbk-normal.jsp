<%@page import="java.util.Random"%>
<%@page import="com.transbank.webpay.wswebpay.service.NullificationOutput"%>
<%@page import="com.transbank.webpay.wswebpay.service.TransactionResultOutput"%>
<%@page import="com.transbank.webpay.wswebpay.service.WsInitTransactionOutput"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="cl.transbank.webpay.configuration.Configuration"%>
<%@page import="java.util.ListIterator"%>
<%@page import="java.lang.reflect.Field"%>
<%@page import="java.util.ArrayList"%>
<%@page import="cl.transbank.webpay.Webpay"%>
<%@page import="cl.transbank.webpay.security.SoapSignature"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="common/shared.jsp" %>

<!DOCTYPE html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <h1>Ejemplos Webpay - Transaccion Normal</h1>
    
          <%

        String action = request.getParameter("action");  
        if(action == null)action="webpayNormalInit";
        String buyOrder = "", authorizationCode="", authorizedAmount=""; 

        if (configuration == null) {
            configuration = Configuration.forTestingWebpayPlusNormal();
            System.out.println("Credentials for testing");
        }
        Webpay webpay = new Webpay(configuration);
       
        /** Si la URL no trae data muestra Menú */
        if (action == null) {      
       
        } else if (action.equalsIgnoreCase("webpayNormalInit")) {
           
            WsInitTransactionOutput result = new WsInitTransactionOutput();
            String txType="", idSession="", urlReturn="", urlFinal="";
            int amount=0;

            /** Transaccion normal */
            try{
                urlReturn = request.getRequestURL().toString()+"?action=webpayNormalGetResult";
                urlFinal = request.getRequestURL().toString()+"?action=end";
                amount = 1;
                
                //Se genera un numero aleatorio para la orden de compra.
                Random r = new Random();
                int menor = 150987676;
                int mayor = 356000000;
                int intervalo = mayor - menor;
                int Result = r.nextInt(intervalo) + menor;
                
                buyOrder = String.valueOf(Result);
                idSession = "aj2h4kj2";
                
                result = webpay.getNormalTransaction().initTransaction(amount, idSession, buyOrder, urlReturn, urlFinal );                                               
                
                
                System.out.println("Result initTransaction: " + result + ", token: " + result.getToken() + ", url: " + result.getUrl());            

            }catch(Exception e){
                System.out.println("ERROR: " + e);
               %>
               <p><samp>Error: <%out.print(e.toString().replace("<", ""));%></samp></p><br>
               <a href=".">&laquo; volver a index</a>
               <%               
            }
 %>  
          
            <h2>Step: Init</h2>

            <div style="background-color:lightyellow;">
                    <h3>request</h3>
                    <%out.print("[amount] = "+amount+", [buyOrder] = "+buyOrder+", [idSession] = "+idSession+", [urlReturn] = "+urlReturn+", [urlFinal] = "+urlFinal);%>                  
            </div>
            <div style="background-color:lightgrey;">
                    <h3>result</h3>
                    <%out.print("[url] = "+result.getUrl()+", [token_ws] = "+result.getToken());%>
            </div>
                    <%if(result.getToken()!=null){    %>
            <p><samp>Sesion iniciada con exito en Webpay</samp></p>
            <br><form action='<%=result.getUrl()%>' method="post"><input type="hidden" name="token_ws" value='<%=result.getToken()%>'><input type="submit" value="Ejecutar Pago con Webpay"></form>
            <br>                        
                    <%}else{                                    %>                    
            <p><samp>Ocurrio un error en la operacion InitTransaction Webpay.</samp></p>                            
                    <%}                               %>
            <a href=".">&laquo; volver a index</a>
                    
          
      <%       
     
            
        } else if (action.equalsIgnoreCase("webpayNormalGetResult")) {
          
            TransactionResultOutput result = new TransactionResultOutput();
            String token = "";
            int responseCode = 0;

            try{
                token = request.getParameter("token_ws");
                
                //while(!request.getParameterNames().hasMoreElements())out.print(request.getParameterNames().nextElement()+", ");
                result = webpay.getNormalTransaction().getTransactionResult(token);
                
                System.out.println("Result getNormalTransaction: " + result + ", URLRedirection: " + result.getUrlRedirection() + ", VCI: " + result.getVCI());            
                //out.print(token);
                
                %>
                
                
            <h2>Step: Get Result</h2>

            <div style="background-color:lightyellow;">
                    <h3>request</h3>  
                    <%out.print("token_ws: "+token);%>  
            </div>
            <div style="background-color:lightgrey;">
                    <h3>result</h3>
                    <%out.print("[accountingDate] =\'"+result.getAccountingDate()+"', [buyOrder] ="+result.getBuyOrder()+
                                ", [cardDetail] = cardExpirationDate: "+result.getCardDetail().getCardExpirationDate()+
                                ", [cardNumber] = "+result.getCardDetail().getCardNumber()+", detailOutput: ");
                    
                    //while(resultGetResult.getDetailOutput().listIterator().hasNext()){
                                            
                    if(!result.getDetailOutput().isEmpty()){
                        authorizationCode = result.getDetailOutput().get(0).getAuthorizationCode();
                        authorizedAmount = result.getDetailOutput().get(0).getAmount().toString();
                        buyOrder = result.getDetailOutput().get(0).getBuyOrder();
                        out.print(", [authorizationCode] = "+authorizationCode);
                        out.print(", [paymentTypeCode] = "+result.getDetailOutput().get(0).getPaymentTypeCode());
                        responseCode = result.getDetailOutput().get(0).getResponseCode();
                        out.print(", [responseCode] = "+result.getDetailOutput().get(0).getResponseCode());
                        out.print(", [sharesNumber] = "+result.getDetailOutput().get(0).getSharesNumber());
                        out.print(", [amount] = "+authorizedAmount);
                        out.print(", [commerceCode] = "+result.getDetailOutput().get(0).getCommerceCode());
                        out.print(", [buyOrder] = "+buyOrder);
                    }

                    out.print(", [sessionId] = "+result.getSessionId()+", [transactionDate] = "+ result.getTransactionDate().toString()+
                              ", [urlRedirection] = "+result.getUrlRedirection()+", [VCI] = "+result.getVCI());
                    
                    %> 
                    
            <script>window.localStorage.clear();</script>';
            <script>localStorage.setItem("authorizationCode", "<%=authorizationCode%>");</script>
            <script>localStorage.setItem("authorizedAmount", "<%=authorizedAmount%>");</script>
            <script>localStorage.setItem("buyOrder", "<%=buyOrder%>");</script>

            </div>
                    <%if(responseCode!=0){%>                     
            <p><samp>Pago RECHAZADO por webpay </samp></p>
                    <%}else{%> 
            <p><samp>Pago ACEPTADO por webpay (se deben guardar datos para mostrar voucher)</samp></p>
                    <% }%>            
          <br><form action="<%=result.getUrlRedirection()%>" method="post">
                <input type="hidden" name="token_ws" value="<%=token%>">
                <input type="submit" value="Continuar &raquo;">
          </form>
            <br>
            <a href=".">&laquo; volver a index</a>
                          
          <%               
                
            }catch(Exception e){
                System.out.println("ERROR: " + e);
               %>
               <p><samp>Error: <%out.print(e.toString().replace("<", ""));%></samp></p><br>
               <a href=".">&laquo; volver a index</a>
               <%               
            }            
        }else if(action.equalsIgnoreCase("end")){
            String token = request.getParameter("token_ws");
            String urlNextStep = request.getRequestURL().toString()+"?action=nullify";
            buyOrder = request.getParameter("buyOrder");
            authorizationCode = request.getParameter("authorizationCode");
            authorizedAmount = request.getParameter("authorizedAmount");
           %> 
           
           <h2>Step: End</h2>

            <div style="background-color:lightyellow;">
                    <h3>request</h3>
                    <%out.print("No request");%>                     
            </div>
            <div style="background-color:lightgrey;">
                    <h3>result</h3>
                    <%out.print("[token_ws] = "+token);%> 
            </div>
            <p><samp>Transaccion Finalizada</samp></p>
            <br>
            <br><form action="<%=urlNextStep%>" method="post">
                <input type="hidden" name="authorizationCode" id="authorizationCode" value="<%=authorizationCode%>"> 
                <input type="hidden" name="buyOrder" id="buyOrder" value="<%=buyOrder%>"> 
                <input type="hidden" name="authorizedAmount" id="authorizedAmount" value="<%=authorizedAmount%>"> 
                <input type="hidden" name="token_ws" id="token_ws" value="<%=token%>">                 
                <input type="submit" value="Anular Transaccion &raquo;">
                <br>
            </form>
            <br>
            <a href=".">&laquo; volver a index</a>
                
            <script> 
                var authorizationCode = localStorage.getItem('authorizationCode');
                document.getElementById("authorizationCode").value = authorizationCode;

                var amount = localStorage.getItem('authorizedAmount');
                document.getElementById("authorizedAmount").value = amount;

                var buyOrder = localStorage.getItem('buyOrder');
                document.getElementById("buyOrder").value = buyOrder;            
                //localStorage.clear();            
            </script>
            
        <%       
  
        }else if(action.equalsIgnoreCase("nullify")){
            String token = request.getParameter("token_ws");
            NullificationOutput result = new NullificationOutput();
            
       try{
        /** Codigo de Comercio */
        Long commercecode = Long.valueOf(configuration.getCommerceCode());
        
        /** Código de autorización de la transacción que se requiere anular */
        authorizationCode = request.getParameter("authorizationCode");

        /** Monto autorizado de la transacción que se requiere anular */
        authorizedAmount = request.getParameter("authorizedAmount");

        /** Orden de compra de la transacción que se requiere anular */
        buyOrder = request.getParameter("buyOrder");

        /** Se convierten los valores decimales*/
         BigDecimal authAmount = new BigDecimal(authorizedAmount.trim());       
         BigDecimal nullAmount = authAmount;
        

        /** Iniciamos Transaccion */
        result = webpay.getNullifyTransaction().nullify(authorizationCode, authAmount, buyOrder, nullAmount, commercecode);
          
        
            
           %> 
           
           <h2>Step: Nullify</h2>

            <div style="background-color:lightyellow;">
                    <h3>request</h3>     
                    <%out.print("[authorizationCode] = "+authorizationCode);%>  
                    <%out.print(", [authorizedAmount] = "+authorizedAmount);%> 
                    <%out.print(", [buyOrder] = "+buyOrder);%> 
                    <%out.print(", [nullifyAmount] = "+nullAmount);%> 
                    <%out.print(", [commercecode] = "+configuration.getCommerceCode());%> 
                    
            </div>
            <div style="background-color:lightgrey;">
                    <h3>result</h3>
                    <%out.print("[authorizationCode] = "+result.getAuthorizationCode());%>  
                    <%out.print(", [authorizationDate] = "+result.getAuthorizationDate());%> 
                    <%out.print(", [balance] = "+result.getBalance());%> 
                    <%out.print(", [nullifiedAmount] = "+result.getNullifiedAmount());%> 
                    <%out.print(", [token] = "+result.getToken());%>                     
                    
            </div>
             <%if(result.getToken()!=null){    %>
            <p><samp>Anulacion realizada con exito.</samp></p>
            <br>                        
                    <%}else{                                    %>                    
            <p><samp>Ocurrio un error en la operacion.</samp></p>                            
                    <%}                               %>
            <br>
            <a href=".">&laquo; volver a index</a>
            
            
            <script>     
                var authorizationCode = localStorage.getItem('authorizationCode');
                document.getElementById("authorizationCode").value = authorizationCode;

                var amount = localStorage.getItem('captureAmount');
                document.getElementById("captureAmount").value = amount;

                var buyOrder = localStorage.getItem('buyOrder');
                document.getElementById("buyOrder").value = buyOrder;            
                //localStorage.clear();            
            </script>
            
        <%       
        }catch(Exception e){
            System.out.println("ERROR: " + e);
           %>
           <p><samp>Error: <%out.print(e.toString().replace("<", ""));%></samp></p><br>
           <a href=".">&laquo; volver a index</a>
           <%             
        } 
    }
   %>
                