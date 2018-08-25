/**
  * @author     Allware Ltda. (http://www.allware.cl)
  * @copyright  2015 Transbank S.A. (http://www.tranbank.cl)
  * @date       Jan 2016
  * @license    GNU LGPL
  * @version    2.0.1
  *
  */


<%
    String environment = "INTEGRACION";         
    
    String commerce_code = "597020000543";
         
    /** Llave Privada */
    String private_key = "-----BEGIN RSA PRIVATE KEY-----\n" +
"MIIEogIBAAKCAQEApEXusrSCV0B8JwJyBM3926Wr3Zp/tY1mXwljUxN2qr9kzJ9I\n" +
"qUMu5BumTvF0Et4EnZSCZJy3Xkig6YMi7RqyT+30d5FQlNfkU/vSE93Mtr/ArRbq\n" +
"jtZDUU5TXwArjGMakkzypwDj5HbuNBH4tpKvGnY74KrJZZSjJGGB/RyIF4UgaTjG\n" +
"h5DR56HPlDBat6SS+ffnJoTIL4xmbqHMHeIHzOUVjU6kK+ShNi35jl7QfzlMN13T\n" +
"E8vX3uVxDKp8Q4Yso2CiaDrS7y030h1Hwl6A/HBwaHVoUD7LhO6M7mAzd8gR6SHA\n" +
"LUgOwsX06aMLuhopA+0yPr9HV3c57dDwBYlLrQIDAQABAoIBAFrheZISPT3KJiVq\n" +
"u+uejsASoseBrv+hD66qQfH3BaKnKjvuL0O9MFbwWQy5lg7OF12aiJzi+qtFoQgv\n" +
"DYaBS37e1W3EzgDag65W1b056wR7hzv7Pp7xOOLlY0hejrknJs8jlOcBnhKKHXRf\n" +
"MOrIsekA2lWMBsmU9sCs1T5Tp5Lip8bD/aDq9C1B0eq6BwrOMfAirei0lV6bTKW1\n" +
"IJJ8i3j+DwRQI5QLr1AVNWqthTY/aL3sGkO8OxRGfmfYi5KLNihyFRNX6JLEsKU/\n" +
"wrthyKs897R1zay7Pp/hAYQ8pPtsIV/YQS2QM021NocJLo45R0pnR+KOdNfd03lm\n" +
"pj7fnUECgYEAztA2m+IDPUPsM497pcyBwTnopiradAYVEdlEMLZlaISmGIsQqGZJ\n" +
"eG1ZU69ZHfWWMi1UKRZ65abCzjJquHafCHDxAwIAgLvW0y0+GKoXoBJu3rN7CZ93\n" +
"OriQ0ayU9nTBjYRHbnSH8nwJiZ15gSCzLOJ+AdGpod3mEhUa467zA7ECgYEAy1er\n" +
"m0s4qS12u44AbzWW5/03DgJVkIBdVMKKqNC0YYEaJw15f7pmHeQ3J8ZcEmGc1sT/\n" +
"0CHxkkvH/GpJrqOK9Xxd8i7fO0UHnSpYMpFUOuGmGR8GtgcXFnwd5JFGbpWls8Ow\n" +
"EVuKFTdceDPljLi9Jm0tc7OgKuRFTqEfDriXMr0CgYBuDDtSvXRN0GvKj+oSsnzF\n" +
"DgRvD1SI8oeZpMv1Q8k4UYV0f+NQSIWF0GH89sxr9beDYb1r06t3skHsqMVC/NPp\n" +
"EPgeSp1r4wgP/P4S78d8hPJ8DHNHDpTKKVXeTIBDmKM5o47DBr0kWb5VfPcfr//H\n" +
"vYmhfChQmpwHOTXCu+BSMQKBgHvRHHtpKE1Lk7rM0tLkzMjiVP3Ayh09LJeKBiiZ\n" +
"PN0KYcRZ3hu6gqe86SDdFf9TVM8qEaLIqHIuls3KYqdmihzE5+eqRt+uPt6ihCX2\n" +
"fFWGRT+StuFsG9DjLsiY9Uws70Mw6ysGlGQq27GN2D8B1ptpa33CaMr1SIaCcYjj\n" +
"OZ35AoGAT/UQVsYRFv3l+gEcerxg9PdtbPiQ88cd1cr/hsZpRFs104qNSjO79nul\n" +
"ErLrqFaws1DcozVmv1KH5o69IrB4pJwjuBl9RVfmlXdYKjvn7ae2oJIsQgM1Ce4Q\n" +
"0pahLmQG0n4Qfpk0ADeYHvtprATasclmHGdtH4y7wcPyWPY9ITk=\n" +
"-----END RSA PRIVATE KEY-----";
    
    /** Certificado Publico */

    String public_cert = "-----BEGIN CERTIFICATE-----\n" +
"MIIDujCCAqICCQC79QjbBVPw0TANBgkqhkiG9w0BAQsFADCBnjELMAkGA1UEBhMC\n" +
"Q0wxETAPBgNVBAgMCFNhbnRpYWdvMRIwEAYDVQQKDAlUcmFuc2JhbmsxETAPBgNV\n" +
"BAcMCFNhbnRpYWdvMRUwEwYDVQQDDAw1OTcwMjAwMDA1NDIxFzAVBgNVBAsMDkNh\n" +
"bmFsZXNSZW1vdG9zMSUwIwYJKoZIhvcNAQkBFhZpbnRlZ3JhZG9yZXNAdmFyaW9z\n" +
"LmNsMB4XDTE2MDcwNDE2MDgwMVoXDTI0MDcwMjE2MDgwMVowgZ4xCzAJBgNVBAYT\n" +
"AkNMMREwDwYDVQQIDAhTYW50aWFnbzESMBAGA1UECgwJVHJhbnNiYW5rMREwDwYD\n" +
"VQQHDAhTYW50aWFnbzEVMBMGA1UEAwwMNTk3MDIwMDAwNTQyMRcwFQYDVQQLDA5D\n" +
"YW5hbGVzUmVtb3RvczElMCMGCSqGSIb3DQEJARYWaW50ZWdyYWRvcmVzQHZhcmlv\n" +
"cy5jbDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKRF7rK0gldAfCcC\n" +
"cgTN/dulq92af7WNZl8JY1MTdqq/ZMyfSKlDLuQbpk7xdBLeBJ2UgmSct15IoOmD\n" +
"Iu0ask/t9HeRUJTX5FP70hPdzLa/wK0W6o7WQ1FOU18AK4xjGpJM8qcA4+R27jQR\n" +
"+LaSrxp2O+CqyWWUoyRhgf0ciBeFIGk4xoeQ0eehz5QwWrekkvn35yaEyC+MZm6h\n" +
"zB3iB8zlFY1OpCvkoTYt+Y5e0H85TDdd0xPL197lcQyqfEOGLKNgomg60u8tN9Id\n" +
"R8JegPxwcGh1aFA+y4TujO5gM3fIEekhwC1IDsLF9OmjC7oaKQPtMj6/R1d3Oe3Q\n" +
"8AWJS60CAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAZ6unfp9XlP/2zk0bHtXHNlEm\n" +
"W81TMIDytgNi8LHkdLboZUCLOirYgcKqGsX2kF0y6Kmv1Cd23H5Tuz1+eC/gRY7M\n" +
"n4E7KYPZ4asjWhXJUlTi3IP34fKSh1xihK+EN9Ke1GZXIu+tZOs2U0DP7N0BTCGh\n" +
"0FQJGI381EpGP+tYdc9ZKMLULj31urcY/P/6XjMSj9aCVutnc22FyRmPupwClLgj\n" +
"D2t6Fqp2aT4rrCZj5bpm42h3sXQLLHvkha2k1v+8QCY45JOiLrbtByFHOP4+7Gp8\n" +
"UOMdL/AMq4KIS4NlJI7digGw6i2CseDm23JUMloLueWmCRO+92rTm4aQ30T4uQ==\n" +
"-----END CERTIFICATE-----";

    session.setAttribute("ENVIRONMENT", environment);
    session.setAttribute("COMMERCE_CODE",commerce_code);
    session.setAttribute("PRIVATE_KEY",private_key);
    session.setAttribute("PUBLIC_CERT",public_cert);
    response.sendRedirect("../tbk-nullify-mall-normal.jsp");   
    
 %> 