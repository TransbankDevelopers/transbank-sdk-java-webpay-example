<%-- 
/**
  * @brief      Ecommerce Plugin for chilean Webpay
  * @category   Plugins/SDK
  * @author     Allware Ltda. (http://www.allware.cl)
  * @copyright  2015 Transbank S.A. (http://www.tranbank.cl)
  * @date       Jan 2016
  * @license    GNU LGPL
  * @version    2.0.1
  * @link       http://transbankdevelopers.cl/
  *
  * This software was created for easy integration of ecommerce
  * portals with Transbank Webpay solution.
  *
  * Required:
  *  - Java Runtime 7   
  *
  * See documentation and how to install at link site
  *
  */
--%>

<%@page import="java.util.Random"%>
<%@page import="com.transbank.webpay.wswebpay.service.CaptureOutput"%>
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
<!DOCTYPE html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <h1>Ejemplos Webpay - Transaccion Normal Captura</h1>
    
          <%

        String action = request.getParameter("action");  
        String urlNextStep = "";
        if(action == null)action="webpayNormalInit";
        
        Configuration configuration = new Configuration();
        configuration.setCommerceCode((String)session.getAttribute("COMMERCE_CODE"));
        configuration.setPrivateKey((String)session.getAttribute("PRIVATE_KEY"));
        configuration.setPublicCert((String)session.getAttribute("PUBLIC_CERT"));
        configuration.setWebpayCert((String)session.getAttribute("WEBPAY_CERT"));
        configuration.setEnvironment("INTEGRACION");
                
        Webpay webpay = new Webpay(configuration);
       
        /** Si la URL no trae data muestra Menú */
        if (action == null) {      
       
        } else if (action.equalsIgnoreCase("webpayNormalInit")) {
           
            WsInitTransactionOutput resultInit = new WsInitTransactionOutput();
            String txType="", idSession="", urlReturn="", urlFinal="", buyOrder="";
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
                idSession = "aj2h4kj2";
                
                resultInit = webpay.getNormalTransaction().initTransaction(amount, idSession, buyOrder, urlReturn, urlFinal );                                               
                
                
                System.out.println("Result initTransaction: " + resultInit + ", token: " + resultInit.getToken() + ", url: " + resultInit.getUrl());            

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
                    <%out.print("[url] = "+resultInit.getUrl()+", [token_ws] = "+resultInit.getToken());%>
            </div>
                    <%if(resultInit.getToken()!=null){    %>
            <p><samp>Sesion iniciada con exito en Webpay</samp></p>
            <br><form action='<%=resultInit.getUrl()%>' method="post"><input type="hidden" name="token_ws" value='<%=resultInit.getToken()%>'><input type="submit" value="Ejecutar Pago con WebPay"></form>
            <br>                        
                    <%}else{                                    %>                    
            <p><samp>Ocurrio un error en la operacion InitTransaction Webpay.</samp></p>                            
                    <%}                               %>
            <a href=".">&laquo; volver a index</a>
                    
          
      <%       
     
            
        } else if (action.equalsIgnoreCase("webpayNormalGetResult")) {
          
            TransactionResultOutput resultGetResult = new TransactionResultOutput();
            String token = "", buyOrder = "", authorizationCode = "", captureAmount= "";
            int responseCode = 0;

            try{
                token = request.getParameter("token_ws");
                
                //while(!request.getParameterNames().hasMoreElements())out.print(request.getParameterNames().nextElement()+", ");
                resultGetResult = webpay.getNormalTransaction().getTransactionResult(token);
                
                System.out.println("Result getNormalTransaction: " + resultGetResult + ", URLRedirection: " + resultGetResult.getUrlRedirection() + ", VCI: " + resultGetResult.getVCI());            
                //out.print(token);
                
                %>
                
                
            <h2>Step: Get Result</h2>

            <div style="background-color:lightyellow;">
                    <h3>request</h3>  
                    <%out.print("token_ws: "+token);%>  
            </div>
            <div style="background-color:lightgrey;">
                    <h3>result</h3>
                    <%out.print("[accountingDate] =\'"+resultGetResult.getAccountingDate()+"', [buyOrder] ="+resultGetResult.getBuyOrder()+
                                ", [cardDetail] = cardExpirationDate: "+resultGetResult.getCardDetail().getCardExpirationDate()+
                                ", [cardNumber] = "+resultGetResult.getCardDetail().getCardNumber()+", detailOutput: ");
                    
                    //while(resultGetResult.getDetailOutput().listIterator().hasNext()){
                                            
                    if(!resultGetResult.getDetailOutput().isEmpty()){
                        authorizationCode = resultGetResult.getDetailOutput().get(0).getAuthorizationCode();
                        out.print(", [authorizationCode] = "+ authorizationCode);
                        out.print(", [paymentTypeCode] = "+resultGetResult.getDetailOutput().get(0).getPaymentTypeCode());
                        responseCode = resultGetResult.getDetailOutput().get(0).getResponseCode();
                        out.print(", [responseCode] = "+resultGetResult.getDetailOutput().get(0).getResponseCode());
                        out.print(", [sharesNumber] = "+resultGetResult.getDetailOutput().get(0).getSharesNumber());
                        captureAmount = resultGetResult.getDetailOutput().get(0).getAmount().toString();
                        out.print(", [amount] = "+captureAmount);
                        out.print(", [commerceCode] = "+resultGetResult.getDetailOutput().get(0).getCommerceCode());
                        buyOrder = resultGetResult.getDetailOutput().get(0).getBuyOrder();
                        out.print(", [buyOrder] = "+ buyOrder);
                    }

                    out.print(", [sessionId] = "+resultGetResult.getSessionId()+", [transactionDate] = "+ resultGetResult.getTransactionDate().toString()+
                              ", [urlRedirection] = "+resultGetResult.getUrlRedirection()+", [VCI] = "+resultGetResult.getVCI());
                    
                    
                    
            /** propiedad de HTML5 (web storage), que permite almacenar datos en nuestro navegador web */
            %> 
            <script>window.localStorage.clear();</script>';
            <script>localStorage.setItem("authorizationCode", "<%=authorizationCode%>");</script>
            <script>localStorage.setItem("captureAmount", "<%=captureAmount%>");</script>
            <script>localStorage.setItem("buyOrder", "<%=buyOrder%>");</script>

            </div>
                    <%if(responseCode!=0){%>                     
            <p><samp>Pago RECHAZADO por webpay </samp></p>
                    <%}else{%> 
            <p><samp>Pago ACEPTADO por webpay (se deben guardar datos para mostrar voucher)</samp></p>
                    <% }%>            
          <br><form action="<%=resultGetResult.getUrlRedirection()%>" method="post">
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

            urlNextStep = request.getRequestURL().toString()+"?action=capture";
            String token = request.getParameter("token_ws");
            String buyOrder = request.getParameter("buyOrder");
            String authorizationCode = request.getParameter("authorizationCode");
            String captureAmount = request.getParameter("captureAmount");
            
           %> 
           
           
           <h2>Step: End</h2>

            <div style="background-color:lightyellow;">
                    <h3>request</h3>
                    <%out.print("No request");%> 
            </div>
            <div style="background-color:lightgrey;">
                    <h3>result</h3>
                    <%out.print("[token] = "+token);%> 
            </div>
            <p><samp>Transacion Finalizada</samp></p>
            <br><form action="<%=urlNextStep%>" method="post">
                <input type="hidden" name="authorizationCode" id="authorizationCode" value="<%=authorizationCode%>"> 
                <input type="hidden" name="buyOrder" id="buyOrder" value="<%=buyOrder%>"> 
                <input type="hidden" name="captureAmount" id="captureAmount" value="<%=captureAmount%>"> 
                <input type="hidden" name="token_ws" id="token_ws" value="<%=token%>">                 
                <input type="submit" value="Realizar Captura diferida &raquo;">
                <br>
            </form>
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
     } else if (action.equalsIgnoreCase("capture")) {
            
            BigDecimal capAmount;
            CaptureOutput result = new CaptureOutput();
            boolean error = false;

            /** Transaccion normal */
            try{
                
                String buyOrder = request.getParameter("buyOrder");
                String authorizationCode = request.getParameter("authorizationCode");
                String captureAmount = request.getParameter("captureAmount");
                String token = request.getParameter("token_ws");
                                        
                if(!buyOrder.equalsIgnoreCase("null") && !authorizationCode.equalsIgnoreCase("null") && !captureAmount.equalsIgnoreCase("null") &&
                  !buyOrder.isEmpty()&&!authorizationCode.isEmpty()&&!captureAmount.isEmpty()){
                    
                    //Se transforman a enteros                    
                    capAmount = new BigDecimal(captureAmount.trim());                    
                    result = webpay.getCaptureTransaction().capture(authorizationCode, capAmount, buyOrder);
                    
                }else{
                    error = true;
                }
                
                %>
                
                
            <h2>Step: Capture</h2>

            <div style="background-color:lightyellow;">
                    <h3>request</h3>  
                    
                    <%out.print("[authorizationCode] ="+authorizationCode+", [authorizedAmount] ="+captureAmount+", [buyOrder] = "+buyOrder);%>
            </div>
            <div style="background-color:lightgrey;">
                    <h3>result</h3>
                    <%  if(!error){
                        out.print("[authorizationCode] =\'"+result.getAuthorizationCode()+"', [authorizationDate] ="+result.getAuthorizationDate()+
                                ", [capturedAmount] = "+result.getCapturedAmount().toString()+
                                ", [token] = "+result.getToken());
                    }                    
                    %> 

            <script>     
                var authorizationCode = localStorage.getItem('authorizationCode');
                document.getElementById("authorizationCode").value = authorizationCode;

                var amount = localStorage.getItem('captureAmount');
                document.getElementById("captureAmount").value = amount;

                var buyOrder = localStorage.getItem('buyOrder');
                document.getElementById("buyOrder").value = buyOrder;            
                //localStorage.clear();            
            </script>
                    
            </div>
                    <%if(error){%>                     
            <p><samp>Pago RECHAZADO por webpay </samp></p>
                    <%}else{%> 
            <p><samp>Pago ACEPTADO por webpay (se deben guardar datos para mostrar voucher)</samp></p>
                    <% }%>            
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
     }
           %> 
               