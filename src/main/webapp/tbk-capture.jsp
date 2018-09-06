<%@page import="com.transbank.webpay.wswebpay.service.CaptureOutput"%>
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
    <h1>Ejemplos Webpay - Transaccion Captura</h1>
    
          <%

        String action = request.getParameter("action");  
        String urlNextStep="";
        if(action == null)action="init";
        
        Webpay webpay = new Webpay(Configuration.forTestingWebpayPlusCapture());

        /** Si la URL no trae data muestra Menú */
        if (action == null) {      
       
        }else if(action.equalsIgnoreCase("init"))
        {
       
             urlNextStep = request.getRequestURL().toString()+"?action=capture";
 %>  
          
            <h2>Step: Init</h2>

        <form id="formulario" action="<%=urlNextStep%>" method="post">
            <fieldset>
                <legend>Formulario de Captura</legend><br/><br/>
                <label>authorizationCode:</label>
                <input id="authorizationCode" name="authorizationCode" type="text" />&nbsp;&nbsp;&nbsp;
                <label>captureAmount:</label>
                <input id="captureAmount" name="captureAmount" type="text" />&nbsp;&nbsp;&nbsp;
                <label>buyOrder:</label>
                <input id="buyOrder" name="buyOrder" type="text" />&nbsp;&nbsp;&nbsp;<br/><br/><br/>
                <input name="enviar" type="submit" value="Enviar" />
            </fieldset>
        </form>
        <br>
        <a href=".">&laquo; volver a index</a>
                    
          
      <%       
     
            
        } else if (action.equalsIgnoreCase("capture")) {
            
            String buyOrder = "";
            String authorizationCode = "";
            String captureAmount = "";
            int authCode;
            BigDecimal capAmount;
            CaptureOutput result = new CaptureOutput();

            /** Transaccion normal */
            try{
                
                buyOrder = request.getParameter("buyOrder");
                authorizationCode = request.getParameter("authorizationCode");
                captureAmount = request.getParameter("captureAmount");
                urlNextStep = request.getRequestURL().toString()+"?action=end";
                boolean error = false;
                                        
                if(!buyOrder.isEmpty()&&!authorizationCode.isEmpty()&&!captureAmount.isEmpty()){
                    
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
                    
                    <%out.print("[authorizationCode] =\'"+authorizationCode+"', [authorizedAmount] ="+captureAmount+", [buyOrder] = "+buyOrder);%>
            </div>
            <div style="background-color:lightgrey;">
                    <h3>result</h3>
                    <%out.print("[authorizationCode] =\'"+result.getAuthorizationCode()+"', [authorizationDate] ="+result.getAuthorizationDate()+
                                ", [capturedAmount] = "+result.getCapturedAmount().toString()+
                                ", [token] = "+result.getToken());
                    
                    %> 

                    
            </div>
                    <%if(error){%>                     
            <p><samp>Pago RECHAZADO por webpay </samp></p>
                    <%}else{%> 
            <p><samp>Pago ACEPTADO por webpay (se deben guardar datos para mostrar voucher)</samp></p>
                    <% }%>            
          <br><form action="<%=urlNextStep%>" method="post">
                <input type="hidden" name="token" value="<%=result.getToken()%>">
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
            String token = request.getParameter("token");
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
            <p><samp>Transaccion Finalizada</samp></p>
            <br>
            <a href=".">&laquo; volver a index</a>
        <%       
        }    
   %>
                