<%
    String environment = "INTEGRACION";         
    
    String commerce_code = "597020000546";
         
    
    /** Llave Privada */
    String private_key = "-----BEGIN RSA PRIVATE KEY-----\n" +
"MIIEowIBAAKCAQEAxjhtR6728EnnGnFOWmDzZRmQDnpvLzDpfq2pIZI9wrrc7ZTz\n" +
"FQTUkh3m9+QjjSv8+Ef0QbbkiJt27A5lQMjU/Zpf2wH1znsQSjLGpSeiCAiVpOec\n" +
"ySqiFn0COm9aw/mnyZY87KCphwfX5chUP+JGTTMcdAALhdRuIdDzh46jKkJcPnGQ\n" +
"FPq/UpFmHzZXTQ37S3RWMQMH1HsNQu7R16hAQkyolt46e/1y1nsVh0uv793daK89\n" +
"lvPFwgPlXjePJfufdUQ58K8/3U/kG8PxlmoCXOsjKjQrjQG5tXM3DEGfro98Gzuj\n" +
"uITr4gEzRAi2UuzBvMvahTULTUcjuxYlHqdCJwIDAQABAoIBAHohslOEnmoXXumP\n" +
"/rL5IX6dbYE+Nttgy71dyuQAc0VUVWOdbtj4jPEqs3DxhGYrQEbKLtl+kvkIsRFp\n" +
"HUH5fCJ1x7HtV0LN2I+fEX4ZGWDRyUI94wCf4BbzFzhh/A7b+GHgy9EQfOPSFVhj\n" +
"QmXKSX6vi0x96pue8+yqDiLr4+TYv1gEiH0vvw/ibjk0U/pu6OfIVfUJTJ2tY+J1\n" +
"FdajWzZG+CAlAWV6Tm7f+uabioFp4887DoFqEF4IGu1kDOACwYI0n6o4sj3ZXLmr\n" +
"AHX5GMOh8qvifFsmjL4K+lzUUmMMs+NNi8x44uRVPPrJUONKDOVIiFDhke31mj3o\n" +
"HXezdQECgYEA+hrXlmKfAP6sTeqGg+kcc7vL/TTHbEbaamHjRUtiW73rad/GW/Xz\n" +
"GDMsglAacDZ1z79OGfG5oxjQXN0kuJKqWol0aC8JcH/WglBT3PSDRYM0sJNBx5Mp\n" +
"cg403dkfM3axEVDAwB8xjLpgHY/H9SeXDRORtBIUhyO5bJYVxGubLSECgYEAyuSC\n" +
"QuxAbh6HqIbVhvdJbacH473ULstqNKthDtg9xBkL3v2CHTINk0HcrRc/8zw0xQAw\n" +
"2DL7FNbyM76gZ1MizT7ZaykvwrHfKDXYpeITRrkiaXle7QgNiN+EYz5ABZGR1uWN\n" +
"8H5w0VBN7IvQ5c8vxHBJdPpUaJMZ37JjiSX3/kcCgYBeGslxgUwYoLqOWqcgbQ7S\n" +
"kR/Q9xHuML6v9oMAKLwqjsxMOvG02lcMjPy7T46TGDq931pwsp5JuuVze5X8iNrm\n" +
"U//jz4b6uG8q+zSC19GozxR9N/sxL7MRgjzsGGz//THktQDBiTsom1vc46O2H55b\n" +
"Qji5i3AD5TI4pEQuctqhYQKBgQCAU3VcNKcvvxmYauek/MUxmIKx9b+9dSUQeRDj\n" +
"Xbv7SsgqWvcv1hel+vNDe0AUbREHRO6f3+bUsHryZXB4yalqXYUQdTVjFDOL8Dq9\n" +
"+LaudawhQAXdL8m3t3+5cYb2vrKaVAipgp+ClCMlKO2QXLHeshKT7Tz0A45K4T55\n" +
"YU1wQwKBgEY4KoVPJwBLytrncyP4Ztgs6Qy3ibwh6LmI7eK9MflOpAiDktw+rVCO\n" +
"mRmQM1A6nXhwYSd4Hghv7P+fYFeJ23tUAgyJO3pXiQZVUQiVfsqtVZ0hpyrH1L9+\n" +
"7YAgwQAPiOiandz4yQI84v3H9STd2QJo3jPyuWcT+VfXcUjmtA2i\n" +
"-----END RSA PRIVATE KEY-----";

    /** Certificado Publico */
    String public_cert = "-----BEGIN CERTIFICATE-----\n" +
"MIIDujCCAqICCQCfLrBv34+BHDANBgkqhkiG9w0BAQsFADCBnjELMAkGA1UEBhMC\n" +
"Q0wxETAPBgNVBAgMCFNhbnRpYWdvMRIwEAYDVQQKDAlUcmFuc2JhbmsxETAPBgNV\n" +
"BAcMCFNhbnRpYWdvMRUwEwYDVQQDDAw1OTcwMjAwMDA1NDYxFzAVBgNVBAsMDkNh\n" +
"bmFsZXNSZW1vdG9zMSUwIwYJKoZIhvcNAQkBFhZpbnRlZ3JhZG9yZXNAdmFyaW9z\n" +
"LmNsMB4XDTE2MDcwNDIzNDcxOFoXDTI0MDcwMjIzNDcxOFowgZ4xCzAJBgNVBAYT\n" +
"AkNMMREwDwYDVQQIDAhTYW50aWFnbzESMBAGA1UECgwJVHJhbnNiYW5rMREwDwYD\n" +
"VQQHDAhTYW50aWFnbzEVMBMGA1UEAwwMNTk3MDIwMDAwNTQ2MRcwFQYDVQQLDA5D\n" +
"YW5hbGVzUmVtb3RvczElMCMGCSqGSIb3DQEJARYWaW50ZWdyYWRvcmVzQHZhcmlv\n" +
"cy5jbDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMY4bUeu9vBJ5xpx\n" +
"Tlpg82UZkA56by8w6X6tqSGSPcK63O2U8xUE1JId5vfkI40r/PhH9EG25IibduwO\n" +
"ZUDI1P2aX9sB9c57EEoyxqUnoggIlaTnnMkqohZ9AjpvWsP5p8mWPOygqYcH1+XI\n" +
"VD/iRk0zHHQAC4XUbiHQ84eOoypCXD5xkBT6v1KRZh82V00N+0t0VjEDB9R7DULu\n" +
"0deoQEJMqJbeOnv9ctZ7FYdLr+/d3WivPZbzxcID5V43jyX7n3VEOfCvP91P5BvD\n" +
"8ZZqAlzrIyo0K40BubVzNwxBn66PfBs7o7iE6+IBM0QItlLswbzL2oU1C01HI7sW\n" +
"JR6nQicCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAIn1CPsoAtsyLiJpcQ44rASNA\n" +
"FO4Le7c1MRNKgkWbJ/YWllC8anHhw63TbPLfukY7DJ662Yr6W7pMWtIjMXWFpE7g\n" +
"oGV1p2uoAvD0Rq1wLFeU0KWt/7uHo4k88QQm9JzF8ElqKJ0Y+93RrDaZEDpSBCEQ\n" +
"+rZgfodsxFftO62WDmRxtznnyu5jcyhLNz0NF4wH96KK3q6QJaTtzWxQvOoMlQ9J\n" +
"m8n7joymHLt8YQrneaX59hVxl3c9Dqi7JPbwcUuCOMKF9eurBQ6/QVpy9kj6nJST\n" +
"kdRxkc9RTcNXCaAydy+wgrTGoLicpb0qgHz5zdtIkbtgdKmO+JVoE6ueu8lbfA==\n" +
"-----END CERTIFICATE-----";


    session.setAttribute("ENVIRONMENT", environment);
    session.setAttribute("COMMERCE_CODE",commerce_code);
    session.setAttribute("PRIVATE_KEY",private_key);
    session.setAttribute("PUBLIC_CERT",public_cert);
    response.sendRedirect("../tbk-capture.jsp");
    
 %> 