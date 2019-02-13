<%@page import="cl.transbank.webpay.configuration.Configuration"%>

<%
Configuration configuration = null;

String commerceCode = System.getenv("COMMERCE_CODE");
String privateKey = System.getenv("PRIVATE_KEY");
String publicCert = System.getenv("PUBLIC_CERT");

if (commerceCode != null && privateKey != null && publicCert != null) {
    System.out.println("Production credentials for " + commerceCode);
    configuration = new Configuration();
    configuration.setCommerceCode(commerceCode);
    configuration.setPrivateKey(privateKey);
    configuration.setPublicCert(publicCert);
    configuration.setEnvironment(Webpay.Environment.PRODUCCION);
}

%>