<%@page import="com.transbank.webpayserver.webservices.OneClickPayOutput"%>
<%@page import="com.transbank.webpayserver.webservices.OneClickFinishInscriptionOutput"%>
<%@page import="com.transbank.webpayserver.webservices.OneClickInscriptionOutput"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.util.Random"%>
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
    <h1>Ejemplos Webpay - Transaccion OneClick</h1>
    
          <%

        String action = request.getParameter("action");  
        if(action == null)action="OneClickInitInscription";
        
        Webpay webpay = new Webpay(Configuration.forTestingWebpayOneClick());

        String username = "ebertuzzi2";
        String tbkUser = "";
        
        /** Si la URL no trae data muestra Menú */
        if (action == null) {      
       
        } else if (action.equalsIgnoreCase("OneClickInitInscription")) {
           
            OneClickInscriptionOutput result = new OneClickInscriptionOutput();

            String urlReturn = request.getRequestURL().toString()+"?action=OneClickFinishInscription";            
            String email = "ebertuzzi@allware.cl";
            
            /** Init Inscription */
            try{
                                                       
                result = webpay.getOneClickTransaction().initInscription(username, email, urlReturn);                                               
                                
                System.out.println("Result InitInscription: tbkUser " + result.getToken());            

            }catch(Exception e){
                System.out.println("ERROR: " + e);
               %>
               <p><samp>Error: <%out.print(e.toString().replace("<", ""));%></samp></p><br>
               <a href=".">&laquo; volver a index</a>
               <%                
            }
 %>  
          
            <h2>Step: Init Inscription</h2>

            <div style="background-color:lightyellow;">
                    <h3>request</h3>
                    <%out.print("[username] = "+username+", [email] = "+email+", [urlReturn] = "+urlReturn);%>                  
            </div>
            <div style="background-color:lightgrey;">
                    <h3>result</h3>
                    <%out.print("[url] = "+result.getUrlWebpay()+", [token_ws] = "+result.getToken());%>
            </div>
                    <%if(result.getToken()!=null){    %>
            <p><samp>Sesion iniciada con exito en Webpay</samp></p>
            <br><form action='<%=result.getUrlWebpay()%>' method="post"><input type="hidden" name="TBK_TOKEN" value='<%=result.getToken()%>'><input type="submit" value="Ejecutar Inscripcion con WebPay"></form>
            <br>                        
                    <%}else{                                    %>                    
            <p><samp>Ocurrio un error en la operacion InitTransaction Webpay.</samp></p>                            
                    <%}                               %>
            <a href=".">&laquo; volver a index</a>
                    
          
      <%       
     
            
        } else if (action.equalsIgnoreCase("OneClickFinishInscription")) {
          
            OneClickFinishInscriptionOutput result = new OneClickFinishInscriptionOutput();
            String token = "";
            int responseCode = 0;
            String urlNextStep = request.getRequestURL().toString()+"?action=OneClickAuthorize";
            
            
            try{
                token = request.getParameter("TBK_TOKEN");
                
                //while(!request.getParameterNames().hasMoreElements())out.print(request.getParameterNames().nextElement()+", ");
                result = webpay.getOneClickTransaction().finishInscription(token);
                
                System.out.println("Result FinishInscription " + result + ", TbkUser " + result.getTbkUser() + ", Auth Code: " + result.getAuthCode() + ", Last 4 card digits" + result.getLast4CardDigits());            
                //out.print(token);
                
                %>
                                
            <h2>Step: Finish Inscription</h2>

            <div style="background-color:lightyellow;">
                    <h3>request</h3>  
                    <%out.print("[TBK_TOKEN] = "+token);%>  
            </div>
            <div style="background-color:lightgrey;">
                    <h3>result</h3>
                    <%
                    responseCode = result.getResponseCode();
                    if(responseCode==0){
                        //tbkUser = resultFinish.getTbkUser();                   
                        out.print("[responseCode] = "+result.getResponseCode());
                        out.print(", [authCode] = "+result.getAuthCode());
                        out.print(", [tbkUser] = "+result.getTbkUser());
                        out.print(", [last4CardDigits] = "+result.getLast4CardDigits());
                        out.print(", [CreditCardType] = "+result.getCreditCardType().value());  
                    }else{
                        out.print("[responseCode] = "+result.getResponseCode());
                    }
                                        
                    %> 
                                                        
            </div>
                    <%if(responseCode!=0){%>                     
            <p><samp>Pago RECHAZADO por webpay </samp></p>
                    <%}else{%> 
            <p><samp>Pago ACEPTADO por webpay (se deben guardar datos para mostrar voucher)</samp></p>
                    <% }%>            
          <br><form action="<%=urlNextStep%>" method="post">
                <input type="hidden" name="TBK_TOKEN" value="<%=token%>">
                <input type="hidden" name="tbk_user" value="<%=result.getTbkUser()%>">
                <input type="submit" value="Ejecutar Authorize &raquo;">
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
 
        } else if (action.equalsIgnoreCase("OneClickAuthorize")) {
          
            OneClickPayOutput result = new OneClickPayOutput();
            String token = "";
            int responseCode = 0;
            BigDecimal amount = BigDecimal.valueOf(24300);
            Random rn = new Random();            
            Long buyOrder = Math.abs(rn.nextLong());                    
            String urlNextStep = request.getRequestURL().toString()+"?action=OneClickReverseTransaction";

                    
            try{
                token = request.getParameter("TBK_TOKEN");   
                tbkUser = request.getParameter("tbk_user");   
                
                //while(!request.getParameterNames().hasMoreElements())out.print(request.getParameterNames().nextElement()+", ");
                result = webpay.getOneClickTransaction().authorize(buyOrder, tbkUser, username, amount);
                
                System.out.println("Result Authorize " + result + ", Auth Code: " + result.getAuthorizationCode() + ", Last 4 card digits" + result.getLast4CardDigits());            
                //out.print(token);
                
                %>
                
                
            <h2>Step: Authorize</h2>

            <div style="background-color:lightyellow;">
                    <h3>request</h3>  
                     
                    <%out.print("[buyOrder] = "+buyOrder);%>  
                    <%out.print(", [tbkUser] = "+tbkUser);%> 
                    <%out.print(", [username] = "+username);%> 
                    <%out.print(", [amount] = "+amount);%> 
            </div>
            <div style="background-color:lightgrey;">
                    <h3>result</h3>
                    <%                                     
                     out.print("[responseCode] = "+result.getResponseCode());                   
                     out.print(", [authCode] = "+result.getAuthorizationCode());
                     out.print(", [last4CardDigits] = "+result.getLast4CardDigits()); 
                     out.print(", [creditCardType] = "+result.getCreditCardType().value()); 
                     out.print(", [transactionId] = "+result.getTransactionId()); 
                    %> 
                                                        
            </div>
                    <%if(responseCode!=0){%>                     
            <p><samp>Pago RECHAZADO por webpay </samp></p>
                    <%}else{%> 
            <p><samp>Pago ACEPTADO por webpay </samp></p>
                    <% }%>            
          <br><form action="<%=urlNextStep%>" method="post">
                <input type="hidden" name="buyOrder" value="<%=buyOrder%>">
                <input type="hidden" name="TBK_USER" value="<%=tbkUser%>">
                <input type="submit" value="Ejecutar Reverse Transaction &raquo;">
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
            
        } else if (action.equalsIgnoreCase("OneClickReverseTransaction")) {
          
            Boolean result = false;
            String token = "", buyOrder="";
            Long buyOrderLong;
            BigDecimal amount = BigDecimal.valueOf(24300);
            Random rn = new Random();                        
            String urlNextStep = request.getRequestURL().toString()+"?action=OneClickRemoveUser";

                    
            try{
                token = request.getParameter("TBK_TOKEN");   
                buyOrder = request.getParameter("buyOrder");   
                buyOrderLong = Long.parseLong(buyOrder);
                tbkUser = request.getParameter("TBK_USER");  
                                
                result = webpay.getOneClickTransaction().reverseTransaction(buyOrderLong);
                
                System.out.println("Result Authorize " + result);            
                
                %>
                
                
            <h2>Step: Reverse Transaction</h2>

            <div style="background-color:lightyellow;">
                    <h3>request</h3>  
                     
                    <%out.print("[buyOrder] = "+buyOrder);%>  
            </div>
            <div style="background-color:lightgrey;">
                    <h3>result</h3>
                    <%
                                        
                     out.print("[response] = "+result);                                        
                    %> 
                                                        
            </div>
                    <%if(!result){%>                     
            <p><samp>Operacion RECHAZADA por webpay </samp></p>
                    <%}else{%> 
            <p><samp>Operacion ACEPTADA por webpay </samp></p>
                    <% }%>            
          <br><form action="<%=urlNextStep%>" method="post">
                <input type="hidden" name="TBK_USER" value="<%=tbkUser%>">
                <input type="hidden" name="USERNAME" value="<%=username%>">
                <input type="submit" value="Ejecutar Remove User &raquo;">
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
            
            
        } else if (action.equalsIgnoreCase("OneClickRemoveUser")) {
          
            Boolean result;
  
            try{
                username = request.getParameter("USERNAME");   
                tbkUser = request.getParameter("TBK_USER");   
                
                //while(!request.getParameterNames().hasMoreElements())out.print(request.getParameterNames().nextElement()+", ");
                result = webpay.getOneClickTransaction().removeUser(tbkUser, username);
                
                System.out.println("Result RemoveUser: " + result);            
                //out.print(token);
                
                %>
                
                
            <h2>Step: Remove User</h2>

            <div style="background-color:lightyellow;">
                    <h3>request</h3>  
                     
                    <%out.print("[tbkUser] = "+tbkUser);%>  
                    <%out.print(", [username] = "+username);%>
                    
            </div>
            <div style="background-color:lightgrey;">
                    <h3>result</h3>
                    <% out.print(", [result] = "+result); %> 
                                                        
            </div>
                    <%if(!result){%>                     
            <p><samp>Operacion RECHAZADA por webpay </samp></p>
                    <%}else{%> 
            <p><samp>Operacion ACEPTADA por webpay </samp></p>
                    <% }%>            
          <br>
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
                