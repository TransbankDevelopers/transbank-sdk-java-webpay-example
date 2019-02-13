<%@page import="cl.transbank.webpay.configuration.Configuration"%>
<%@page import="cl.transbank.webpay.Webpay"%>

<%!
Configuration createConfiguration(String prefixName) {
  Configuration configuration = null;
  String commerceCode = System.getenv(prefixName + "_COMMERCE_CODE");
  String privateKey = System.getenv(prefixName + "_PRIVATE_KEY");
  String publicCert = System.getenv(prefixName + "_PUBLIC_CERT");

  if (commerceCode != null && privateKey != null && publicCert != null) {
      System.out.println(prefixName + " - Production credentials for " + commerceCode);
      configuration = new Configuration();
      configuration.setCommerceCode(commerceCode);
      configuration.setPrivateKey(privateKey);
      configuration.setPublicCert(publicCert);
      configuration.setEnvironment(Webpay.Environment.PRODUCCION);
  }

  return configuration;
}
%>

<%
Configuration configurationPlusNormal = createConfiguration("PLUS_NORMAL");
Configuration configurationPlusMall = createConfiguration("PLUS_MALL");;
Configuration configurationPlusCapture = createConfiguration("PLUS_CAPTURE");;
Configuration configurationOneClickNormal = createConfiguration("ONECLICK_NORMAL");

Boolean isProduction = (configurationPlusNormal != null || configurationPlusMall != null || configurationPlusCapture != null || configurationOneClickNormal != null);
%>