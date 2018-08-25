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
<%@page import="com.transbank.webpay.wswebpay.service.WsCompleteInitTransactionOutput"%>
<%@page import="com.transbank.webpay.wswebpay.service.WsCompleteQuerySharesOutput"%>
<%@page import="com.transbank.webpay.wswebpay.service.WsCompleteAuthorizeOutput"%>
<%@page import="com.transbank.webpay.wswebpay.service.NullificationOutput"%>
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
    <h1>Ejemplos Webpay - Transaccion Complete</h1>
    
          <%

        String urlNextStep = "";
        
        WsCompleteInitTransactionOutput resultInit = new WsCompleteInitTransactionOutput();
        String action = request.getParameter("action");
        String buyOrder = "", authorizationCode="", authorizedAmount=""; 
        
        
        if(action == null)action="webpayNormalInit";
        
        Configuration configuration = new Configuration();
        configuration.setCommerceCode((String)session.getAttribute("COMMERCE_CODE"));
        configuration.setPrivateKey((String)session.getAttribute("PRIVATE_KEY"));
        configuration.setPublicCert((String)session.getAttribute("PUBLIC_CERT"));
        configuration.setEnvironment("INTEGRACION");
                
        Webpay webpay = new Webpay(configuration);

       
        /** Si la URL no trae data muestra Menú */
        if (action == null) {      
       
        } else if (action.equalsIgnoreCase("webpayNormalInit")) {
           

        String tx_step = "Init";

        /** Monto de la transacción */
        Long amount = new Long(9990);

        /** Orden de compra del comercio */
        
        //Se genera un numero aleatorio para la orden de compra.
        Random r = new Random();
        int menor = 150987676;
        int mayor = 356000000;
        int intervalo = mayor - menor;
        int Result = r.nextInt(intervalo) + menor;

        buyOrder = String.valueOf(Result);

        /** (Opcional) Identificador de sesión */
        String sessionId = "575c1116a86d9b";

        /** Fecha de expiración de tarjeta, formato YY/MM */
        String cardExpirationDate = "18/04";

        /** Código de verificación de la tarjeta */
        String cvv = "123";

        /** Número de la tarjeta */
        String cardNumber = "4051885600446623";
        
        urlNextStep = request.getRequestURL().toString()+"?action=CompleteQueryShare";

        
            /** Transaccion normal */
            try{
                String urlReturn = request.getRequestURL().toString()+"?action=webpayNormalGetResult";
                String urlFinal = request.getRequestURL().toString()+"?action=end";
                
                resultInit = webpay.getCompleteTransaction().initCompleteTransaction(amount, buyOrder, sessionId, cardExpirationDate, cvv, cardNumber);              
                                
                        
                System.out.println("Result initTransaction: " + resultInit + ", token: " + resultInit.getToken());            

            }catch(Exception e){
                System.out.println("ERROR initCompleteTransaction: " + e);
		%>
                <p><samp>Error: <%out.print(e.toString().replace("<", ""));%></samp></p><br>
               <a href=".">&laquo; volver a index</a>
               <%
            }
 %>  
          
            <h2>Step: Init</h2>

            <div style="background-color:lightyellow;">
                    <h3>request</h3>
                    <%out.print("[amount] = "+amount+", [buyOrder] = "+buyOrder+", [sessionId] = "+sessionId+
                    ", [cardExpirationDate] = "+cardExpirationDate+", [cvv] = "+cvv+", [cardNumber] = "+cardNumber);%>                  
            </div>
            <div style="background-color:lightgrey;">
                    <h3>result</h3>
                    <%out.print("[token] = "+resultInit.getToken());%>
            </div>
                    <%if(resultInit.getToken()!=null){    %>
            <p><samp>Sesion iniciada con exito en Webpay</samp></p>
            
            <br><form action='<%=urlNextStep%>' method="post">
                <input type="hidden" name="token_ws" value='<%=resultInit.getToken()%>'>
                <input type="hidden" name="buyOrder" value='<%=buyOrder%>'>
                <input type="submit" value="QueryShare"></form>
            <br>         
            
                    <%}else{                                    %>                    
            <p><samp>Ocurrio un error en la operacion InitTransaction Webpay.</samp></p>                            
                    <%}                               %>
            <a href=".">&laquo; volver a index</a>
                    
          
        
      <%       
     
            
        } else if (action.equalsIgnoreCase("CompleteQueryShare")) {
          
            WsCompleteQuerySharesOutput result = new WsCompleteQuerySharesOutput();
            String token = "";
            int responseCode = 0;
            urlNextStep = request.getRequestURL().toString()+"?action=CompleteAuthorize";
            
            try{                
                /** Token de la transacción */
                token = request.getParameter("token_ws");
                /** Orden de compra de la transacción */
                buyOrder = request.getParameter("buyOrder");                        
                /** Número de cuotas */
                int shareNumber = 2;
             
                result = webpay.getCompleteTransaction().queryShare(token, buyOrder, shareNumber);
                
                System.out.println("Result QueryShare: " + result );            
                
                %>
                
                
            <h2>Step: QueryShare</h2>

            <div style="background-color:lightyellow;">
                    <h3>request</h3>  
                    <%out.print("[token] = "+token+", [buyOrder] = "+buyOrder+", [shareNumber] = "+shareNumber);%>  
            </div>
            <div style="background-color:lightgrey;">
                    <h3>result</h3>
                    <%out.print("[buyOrder] ="+result.getBuyOrder()+
                                ", [queryId] = "+result.getQueryId()+
                                ", [shareAmount] = "+result.getShareAmount()+", [token] = "+result.getToken());
                    
                    %> 
                                                        
            </div>
                    <%if(responseCode!=0){%>                     
            <p><samp>Pago RECHAZADO por webpay </samp></p>
                    <%}else{%> 
            <p><samp>Pago ACEPTADO por webpay (se deben guardar datos para mostrar voucher)</samp></p>
                    <% }%>            
          <br><form action="<%=urlNextStep%>" method="post">
                <input type="hidden" name="token_ws" value='<%=result.getToken()%>'>
                <input type="hidden" name="buyOrder" value='<%=buyOrder%>'>
                <input type="hidden" name="queryId" value='<%=result.getQueryId()%>'>
                <input type="submit" value="Authorize &raquo;">
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

            
        } else if (action.equalsIgnoreCase("CompleteAuthorize")) {
          
            WsCompleteAuthorizeOutput result = new WsCompleteAuthorizeOutput();
            String token = "";
            int responseCode = 0;
            urlNextStep = request.getRequestURL().toString()+"?action=end";           
            
            token = request.getParameter("token_ws");
            buyOrder = request.getParameter("buyOrder");
            
            /** Flag que indica si aplica o no periodo de gracia */
            boolean gracePeriod = false;
            
            /** (Opcional) Lista de contiene los meses en los cuales se puede diferir el pago, y el monto asociado a cada periodo (0 = No aplica) */
            int deferredPeriodIndex = 0;
            
            /** Identificador de la consulta de cuota */
            int idQueryShare = Integer.parseInt(request.getParameter("queryId"));
            
            try{
                token = request.getParameter("token_ws");
                
                //while(!request.getParameterNames().hasMoreElements())out.print(request.getParameterNames().nextElement()+", ");
                result = webpay.getCompleteTransaction().autorize(token, buyOrder, gracePeriod, idQueryShare, deferredPeriodIndex);
                
                System.out.println("Result Authorize: " + result );
                                
                //out.print(token);
                
                %>
                
                
            <h2>Step: Authorize</h2>

            <div style="background-color:lightyellow;">
                    <h3>request</h3>  
                    <%out.print("[token] = "+token);%>  
                    <%out.print(", [buyOrder] = "+buyOrder);%> 
                    <%out.print(", [gracePeriod] = "+gracePeriod);%> 
                    <%out.print(", [idQueryShare] = "+idQueryShare);%> 
                    <%out.print(", [deferredPeriodIndex] = "+deferredPeriodIndex);%>                     
                    
            </div>
            <div style="background-color:lightgrey;">
                    <h3>result</h3>
                    <%out.print("[buyOrder] ="+result.getBuyOrder()+", detailOutput: ");
                    
                    //while(resultGetResult.getDetailOutput().listIterator().hasNext()){
                                            
                    if(!result.getDetailsOutput().isEmpty()){
                                                
                        responseCode = result.getDetailsOutput().get(0).getResponseCode();
                        out.print(", [sharesNumber] = "+result.getDetailsOutput().get(0).getSharesNumber());
                        buyOrder = result.getDetailsOutput().get(0).getBuyOrder();
                        authorizationCode = result.getDetailsOutput().get(0).getAuthorizationCode();
                        authorizedAmount = result.getDetailsOutput().get(0).getAmount().toString();
                        out.print(", [amount] = "+authorizedAmount);
                        out.print(", [commerceCode] = "+result.getDetailsOutput().get(0).getCommerceCode());
                        out.print(", [buyOrder] = "+buyOrder);
                        out.print(", [authorizationCode] = "+authorizationCode);
                        out.print(", [paymentTypeCode] = "+result.getDetailsOutput().get(0).getPaymentTypeCode());
                        out.print(", [responseCode] = "+responseCode);
                        out.print("} ");                             
            }            

                    out.print(", [sessionId] = "+result.getSessionId()+", [transactionDate] = "+ result.getTransactionDate().toString());
                    
                    %> 
                                                        
            </div>
                    <%if(responseCode!=0){%>                     
            <p><samp>Pago RECHAZADO por webpay </samp></p>
                    <%}else{%> 
            <p><samp>Pago ACEPTADO por webpay (se deben guardar datos para mostrar voucher)</samp></p>
                    <% }%>            
          <br><form action="<%=urlNextStep%>" method="post">
                <input type="hidden" name="authorizationCode" value="<%=authorizationCode%>">
                <input type="hidden" name="token_ws" value="<%=token%>">
                <input type="hidden" name="authorizedAmount" value="<%=authorizedAmount%>">
                <input type="hidden" name="buyOrder" value="<%=buyOrder%>">
                <input type="hidden" name="queryId" value='<%=request.getParameter("queryId")%>'>
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
            urlNextStep = request.getRequestURL().toString()+"?action=nullify";
            
           %> 
           
           <h2>Step: End</h2>

            <div style="background-color:lightyellow;">
                    <h3>request</h3>
                    <%out.print("No request");%>                     
            </div>
            <div style="background-color:lightgrey;">
                    <h3>result</h3>
                    <%out.print("[token_ws] = "+token);%> 
                    <%out.print("[authorizationCode] = "+request.getParameter("authorizationCode"));%>
                    <%out.print("[queryId] = "+request.getParameter("queryId"));%>
                    <%out.print("[buyOrder] = "+request.getParameter("buyOrder"));%>

                    
            </div>
            <p><samp>Transacion Finalizada</samp></p>
            <br><form action="<%=urlNextStep%>" method="post">
                <input type="hidden" name="token_ws" value="<%=token%>">
                <input type="hidden" name="authorizationCode" value="<%=request.getParameter("authorizationCode")%>">
                <input type="hidden" name="authorizedAmount" value="<%=request.getParameter("authorizedAmount")%>">
                <input type="hidden" name="buyOrder" value="<%=request.getParameter("buyOrder")%>">
                <input type="submit" value="Anular Transaccion &raquo;">
          </form>
            <br>
            <a href=".">&laquo; volver a index</a>
     <%               
                
  
        }else if(action.equalsIgnoreCase("nullify")){
            String token = request.getParameter("token_ws");
            NullificationOutput result = new NullificationOutput();
            
       try{
        /** Codigo de Comercio */
        Long commercecode = null;
        
        /** Código de autorización de la transacción que se requiere anular */
        authorizationCode = request.getParameter("authorizationCode");

        /** Monto autorizado de la transacción que se requiere anular */
        authorizedAmount = request.getParameter("authorizedAmount");

        /** Orden de compra de la transacción que se requiere anular */
        buyOrder = request.getParameter("buyOrder");

        /** Monto que se desea anular de la transacción */
        String nullifyAmount = authorizedAmount;

        /** Se convierten los valores decimales*/
         BigDecimal authAmount = new BigDecimal(authorizedAmount.trim());       
         BigDecimal nullAmount = new BigDecimal(nullifyAmount.trim());
        

        /** Iniciamos Transaccion */
        result = webpay.getNullifyTransaction().nullify(authorizationCode, authAmount, buyOrder, nullAmount, commercecode);
          
        
            
           %> 
           
           <h2>Step: Nullify</h2>

            <div style="background-color:lightyellow;">
                    <h3>request</h3>     
                    <%out.print("[authorizationCode] = "+authorizationCode);%>  
                    <%out.print(", [authorizedAmount] = "+authorizedAmount);%> 
                    <%out.print(", [buyOrder] = "+buyOrder);%> 
                    <%out.print(", [nullifyAmount] = "+nullifyAmount);%> 
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