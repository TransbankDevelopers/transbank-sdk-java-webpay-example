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
        
        Configuration configuration = Configuration.forTestingWebpayPlusMall();
        // Para anular se debe especificar el código de comercio del store,
        // no del mall:
        configuration.setCommerceCode("597020000543")
        Webpay webpay = new Webpay(configuration);

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
                            <label>CommerceCode:</label>&nbsp;&nbsp;&nbsp;&nbsp;
                                <input id="commercecode" name="commercecode" type="text" />&nbsp;&nbsp;&nbsp;<br/><br/><br/>
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
            String token = request.getParameter("token_ws");
            NullificationOutput result = new NullificationOutput();
            
       try{
        /** Codigo de Comercio */
        String commercecode = request.getParameter("commercecode");
        commercecode = commercecode.trim();
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
            commcode = new Long(commercecode);
        }catch(Exception ex){
            %>
           <p><samp>Error: <%out.print(ex.toString().replace("<", ""));%></samp></p><br>
           <a href=".">&laquo; volver a index</a>
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