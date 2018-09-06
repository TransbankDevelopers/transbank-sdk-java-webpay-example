<%@page import="com.transbank.webpay.wswebpay.service.NullificationOutput"%>
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
    <h1>Ejemplos Webpay - Transaccion Anulaci&oacute;n</h1>
    
          <%

        String action = request.getParameter("action");  
        if(action == null)action="webpayNormalInit";
        
        Webpay webpay = new Webpay(Configuration.forTestingWebpayPlusNormal());
       
        /** Si la URL no trae data muestra Menú */
        if (action == null) {      
       
        } else if (action.equalsIgnoreCase("webpayNormalInit")) {
           
            WsInitTransactionOutput resultInit = new WsInitTransactionOutput();
            String txType="", buyOrder="", idSession="", urlReturn="", urlFinal="";
            int amount=0;
            String urlNextStep = request.getRequestURL().toString()+"?action=nullify";

 %>  
          
            <h2>Step: Init</h2>
           
                <form id="formulario" action="<%=urlNextStep%>" method="post">
                <form method="post">
                    <fieldset>
                        <legend>Formulario de Anulaci&oacute;n</legend><br/><br/>
                            <label>authorizationCode:</label>
                                <input id="authorizationCode" name="authorizationCode" type="text" />&nbsp;&nbsp;&nbsp;
                            <label>authorizedAmount:</label>
                                <input id="authorizedAmount" name="authorizedAmount" type="text" />&nbsp;&nbsp;&nbsp;
                            <label>buyOrder:</label>
                                <input id="buyOrder" name="buyOrder" type="text" />&nbsp;&nbsp;&nbsp;
                            <label>nullifyAmount:</label>
                                <input id="nullifyAmount" name="nullifyAmount" type="text" /><br/><br/><br/>
                            <input id="campo3" name="enviar" type="submit" value="Enviar" />
                    </fieldset>
                </form>
                <br>
                <a href=".">&laquo; volver a index</a>
                    
     
          <%               
                
  
        }else if(action.equalsIgnoreCase("nullify")){
            NullificationOutput result = new NullificationOutput();
            
            try{
             /** Codigo de Comercio */
             Long commercecode = null;

             /** Código de autorización de la transacción que se requiere anular */
             String authorizationCode = request.getParameter("authorizationCode");

             /** Monto autorizado de la transacción que se requiere anular */
             String authorizedAmount = request.getParameter("authorizedAmount");

             /** Orden de compra de la transacción que se requiere anular */
             String buyOrder = request.getParameter("buyOrder");

             /** Monto que se desea anular de la transacción */
             String nullifyAmount = request.getParameter("nullifyAmount");

             /** Se convierten los valores decimales*/
              BigDecimal authAmount = new BigDecimal(authorizedAmount.trim());       
              BigDecimal nullAmount = new BigDecimal(nullifyAmount.trim());

              //out.print(authorizationCode +"-"+ authAmount +"-"+ buyOrder +"-"+ nullAmount +"-"+ commercecode);

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
                