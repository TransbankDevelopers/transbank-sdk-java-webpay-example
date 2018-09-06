<%@page import="com.transbank.webpay.wswebpay.service.NullificationOutput"%>
<%@page import="java.util.Random"%>
<%@page import="com.transbank.webpay.wswebpay.service.TransactionResultOutput"%>
<%@page import="com.transbank.webpay.wswebpay.service.WsTransactionDetail"%>
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
    
    <h1>Ejemplos Webpay - Transaccion Mall Normal</h1>
    
          <%

        ArrayList storesTransaction = new ArrayList();
        
        String action = request.getParameter("action");  
        if(action == null)action="webpayNormalInit";
        Configuration configuration = Configuration.forTestingWebpayPlusMall();
        Webpay webpay = new Webpay(configuration);
       
        /** Si la URL no trae data muestra Menú */
        if (action == null) {      
       
        } else if (action.equalsIgnoreCase("webpayNormalInit")) {
           
            WsInitTransactionOutput resultInit = new WsInitTransactionOutput();
            String txType="", buyOrder="", sessionId="", urlReturn="", urlFinal="";

            /** Transaccion normal */
            try{
                urlReturn = request.getRequestURL().toString()+"?action=webpayNormalGetResult";
                urlFinal = request.getRequestURL().toString()+"?action=end";
                Random r = new Random();
                int menor = 150987676;
                int mayor = 356000000;
                int intervalo = mayor - menor;
                int Result = r.nextInt(intervalo) + menor;

                buyOrder = String.valueOf(Result);
                sessionId = "aj2h4kj2";
                ArrayList storeCodes = new ArrayList();
                storeCodes.add("597020000543");
                storeCodes.add("597020000544");
                               
                
                //Para el ejemplo se usaran 2 comercios. Los que fueron definidos en archivo cert-mall-normal.jsp
                //Commerce 1
                    BigDecimal amountStore = new BigDecimal("1200");
                    
                    WsTransactionDetail storeTransaction = new WsTransactionDetail();
                    storeTransaction.setAmount(amountStore);
                    
                    //Se genera un numero aleatorio para la orden de compra.
                    r = new Random();
                    menor = 150987676;
                    mayor = 356000000;
                    intervalo = mayor - menor;
                    Result = r.nextInt(intervalo) + menor;

                    buyOrder = String.valueOf(Result);
                    
                    storeTransaction.setBuyOrder(buyOrder);
                    storeTransaction.setCommerceCode((String)storeCodes.get(0));
                    
                    storesTransaction.add(storeTransaction);
                    
                //Commerce 2
                    amountStore = new BigDecimal("2500");
                    
                    storeTransaction = new WsTransactionDetail();
                    storeTransaction.setAmount(amountStore);
                    
                    //Se genera un numero aleatorio para la orden de compra.
                    r = new Random();
                    menor = 150987676;
                    mayor = 356000000;
                    intervalo = mayor - menor;
                    Result = r.nextInt(intervalo) + menor;

                    buyOrder = String.valueOf(Result);                    
                    storeTransaction.setBuyOrder(buyOrder);                    
                    storeTransaction.setCommerceCode((String)storeCodes.get(1));
                    
                    storesTransaction.add(storeTransaction);                    
                    
                resultInit = webpay.getMallNormalTransaction().initTransaction(buyOrder, sessionId, urlReturn, urlFinal, storesTransaction);
                               
                
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
                    
                    <%
                    for(int i=0; i < storesTransaction.size(); i++){
                        WsTransactionDetail txDetail = new WsTransactionDetail();
                        txDetail = (WsTransactionDetail)storesTransaction.get(i);
                        out.print("commerce nro "+(i+1)+": [amount] = "+txDetail.getAmount()+", [commerceCode] = "+txDetail.getCommerceCode()+", [buyOrder] = "+txDetail.getBuyOrder()+", ");
                    }
                    %>                                      
                    <%out.print(", [idSession] = "+sessionId+", [urlReturn] = "+urlReturn+", [urlFinal] = "+urlFinal);%>                  
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
            String token = "";
            int responseCode = 0;
            String commerceCode = "", nullifyAmount="", buyOrder="", authorizedAmount="", authorizationCode="";

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
                    <%out.print("[accountingDate] ="+resultGetResult.getAccountingDate()+", [buyOrder] ="+resultGetResult.getBuyOrder()+
                                ", [cardDetail] = cardExpirationDate: "+resultGetResult.getCardDetail().getCardExpirationDate()+
                                ", [cardNumber] = "+resultGetResult.getCardDetail().getCardNumber()+", [CommerceCode] = "+ configuration.getCommerceCode()+", detailOutput: ");
                    
                    //while(resultGetResult.getDetailOutput().listIterator().hasNext()){
                                            
    
                    if(!resultGetResult.getDetailOutput().isEmpty()){
                      for(int i=0; i<resultGetResult.getDetailOutput().size();i++){ 
                        out.print(", Commerce nro "+(i+1)+": {");
                        authorizationCode = resultGetResult.getDetailOutput().get(i).getAuthorizationCode();
                        out.print(", [authorizationCode] = "+resultGetResult.getDetailOutput().get(i).getAuthorizationCode());
                        out.print(", [paymentTypeCode] = "+resultGetResult.getDetailOutput().get(i).getPaymentTypeCode());
                        responseCode = resultGetResult.getDetailOutput().get(i).getResponseCode();
                        out.print(", [responseCode] = "+resultGetResult.getDetailOutput().get(i).getResponseCode());
                        out.print(", [sharesNumber] = "+resultGetResult.getDetailOutput().get(i).getSharesNumber());
                        authorizedAmount = resultGetResult.getDetailOutput().get(i).getAmount().toString();
                        out.print(", [amount] = "+authorizedAmount);
                        commerceCode = resultGetResult.getDetailOutput().get(i).getCommerceCode();
                        buyOrder = resultGetResult.getDetailOutput().get(i).getBuyOrder();
                        out.print(", [commerceCode] = "+commerceCode);
                        out.print(", [buyOrder] = "+resultGetResult.getDetailOutput().get(i).getBuyOrder());                    
                        out.print("} ");
                      }
                    }

                    out.print(", [sessionId] = "+resultGetResult.getSessionId()+", [transactionDate] = "+ resultGetResult.getTransactionDate().toString()+
                              ", [urlRedirection] = "+resultGetResult.getUrlRedirection()+", [VCI] = "+resultGetResult.getVCI());
                    
                    %> 
            
            <script>window.localStorage.clear();</script>';
            <script>localStorage.setItem("authorizationCode", "<%=authorizationCode%>");</script>
            <script>localStorage.setItem("authorizedAmount", "<%=authorizedAmount%>");</script>
            <script>localStorage.setItem("nullifyAmount", "<%=authorizedAmount%>");</script>
            <script>localStorage.setItem("buyOrder", "<%=buyOrder%>");</script>
            <script>localStorage.setItem("commerceCode", "<%=commerceCode%>");</script>
            
            
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
            String token = request.getParameter("token_ws");
            String urlNextStep = request.getRequestURL().toString()+"?action=nullify";
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
                <input type="hidden" name="authorizationCode" id="authorizationCode" value="<%=request.getParameter("authorizationCode")%>"> 
                <input type="hidden" name="buyOrder" id="buyOrder" value="<%=request.getParameter("buyOrder")%>"> 
                <input type="hidden" name="nullifyAmount" id="nullifyAmount" value="<%=request.getParameter("nullifyAmount")%>"> 
                <input type="hidden" name="authorizedAmount" id="authorizedAmount" value="<%=request.getParameter("authorizedAmount")%>">                 
                <input type="hidden" name="commerceCode" id="commerceCode" value="<%=request.getParameter("commerceCode")%>"> 
                <input type="submit" value="Anular &raquo;">
                <br>
            </form>
            <br>
            <a href=".">&laquo; volver a index</a>
            
            <script> 
                var authorizationCode = localStorage.getItem('authorizationCode');
                document.getElementById("authorizationCode").value = authorizationCode;

                var nullifyAmount = localStorage.getItem('nullifyAmount');
                document.getElementById("nullifyAmount").value = nullifyAmount;
                
                var authorizedAmount = localStorage.getItem('authorizedAmount');
                document.getElementById("authorizedAmount").value = authorizedAmount;
                
                var buyOrder = localStorage.getItem('buyOrder');
                document.getElementById("buyOrder").value = buyOrder;                

                var commerceCode = localStorage.getItem('commerceCode');
                document.getElementById("commerceCode").value = commerceCode;            
                //localStorage.clear();            
            </script>
            
        <%       

        }else if(action.equalsIgnoreCase("nullify")){
            String token = request.getParameter("token_ws");
            NullificationOutput result = new NullificationOutput();
            
       try{
        /** Codigo de Comercio */
        String commercecode = request.getParameter("commerceCode");
        
        /** Código de autorización de la transacción que se requiere anular */
        String authorizationCode = request.getParameter("authorizationCode");

        /** Monto autorizado de la transacción que se requiere anular */
        String authorizedAmount = request.getParameter("authorizedAmount");

        /** Orden de compra de la transacción que se requiere anular */
        String buyOrder = request.getParameter("buyOrder");

        /** Monto que se desea anular de la transacción */
        String nullifyAmount = request.getParameter("nullifyAmount");

        BigDecimal authAmount=new BigDecimal("0"), nullAmount=new BigDecimal("0");
        Long commcode = new Long("0");
        
        try{
        /** Se convierten los valores decimales*/
            authAmount = new BigDecimal(authorizedAmount.trim());       
            nullAmount = new BigDecimal(nullifyAmount.trim());         
            commcode = new Long(commercecode.trim());
        }catch(Exception ex){
            %>
           <p><samp>Error: <%out.print(ex.toString().replace("<", ""));%></samp></p><br>
           <%       
        }
        

        /** Iniciamos Transaccion */
        result = webpay.getNullifyTransaction().nullify(authorizationCode, authAmount, buyOrder, nullAmount, commcode);
          
        
            
           %> 
           
           <h2>Step: Nullify</h2>

            <div style="background-color:lightyellow;">
                    <h3>request</h3>     
                    <%out.print("[authorizationCode] = "+authorizationCode);%>  
                    <%out.print(", [authorizedAmount] = "+authorizedAmount);%> 
                    <%out.print(", [buyOrder] = "+buyOrder);%> 
                    <%out.print(", [nullifyAmount] = "+nullifyAmount);%> 
                    <%out.print(", [commercecode] = "+commercecode);%> 
                    
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

                var nullifyAmount = localStorage.getItem('nullifyAmount');
                document.getElementById("nullifyAmount").value = nullifyAmount;
                
                var authorizedAmount = localStorage.getItem('authorizedAmount');
                document.getElementById("authorizedAmount").value = authorizedAmount;
                
                var buyOrder = localStorage.getItem('buyOrder');
                document.getElementById("buyOrder").value = buyOrder;                

                var commerceCode = localStorage.getItem('commerceCode');
                document.getElementById("commerceCode").value = commerceCode;            
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
                