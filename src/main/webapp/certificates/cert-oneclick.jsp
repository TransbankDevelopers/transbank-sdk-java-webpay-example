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
    
    String commerce_code = "597020000547";
         
    String private_key = "-----BEGIN RSA PRIVATE KEY-----\n" +
"MIIEpAIBAAKCAQEA5Fqy3C/dhgdVsGkv5p5GLvd9OxeOv+poK41zTxIUXOLpG6NE\n" +
"W+Hb5Qz0rTk1TEVJUCSVb0bV8nfsD0oHolD/7IU/zvvEWJ8zI5ca7VZ2uZ27Luee\n" +
"AaszRfRGWkJ8TqRB8qE/QuHIUVJEgY9YxpEmD25hEIlZU94FRRRcHSpJ1+8o3K9D\n" +
"Sqkbe9aWGGvs+hxzrlThO48HAUwL0F2oyMqysSQhRqZffeSZMp4qsKlE7iIr5pk8\n" +
"373QqLrfbwm2fc56+RG0gVQ47SKTfpPx2RVM9nbJ3AoYtpoEc4HRaUnVCJ5YiGYy\n" +
"69CsUNJPsj9ZTL1avTJK6XnygoVPol9d7X13KwIDAQABAoIBAQDPB6/rUvYbIqE8\n" +
"nFESW+KziCwgm/4O3x1shwTI5lJR2GORbBd42i973aAjQJ+is5qBL3nP9j/YYYNC\n" +
"ZVLAhYFR1YkBRl9AHa3GkaOXE/H13RwsrU8ioi2NOadjA64humgT6r8pCvyLRfPY\n" +
"JrdM56HDEcassGmtULgkZg4RXxqtym6dcpPmuXtCHFZ7JEWVSKWH+STReAh7unwD\n" +
"TYOZlsnU5FuSzYlN2IC0OtZORviTSiEkI1XMyrDm97HQWOCkwa6OizKf/xFdvX5X\n" +
"xcksALubSX1I+2sUHqP0LbZ3rkxgG6VoaJGF3zZdsjUPfFHBy/IGnbpcMqe/YkZl\n" +
"AduyI4KhAoGBAP5iLhQr9k/vKUXNgl/9H5wMWBqf3WvOgH4WiApUZ5i5e5JkOgav\n" +
"6LSsGdLYhEADYAKYgRUOpwDE6IBcWobTCwe6O0R7Us9r/c1ex3zEPcqiMqULyAxx\n" +
"LLu34O75t7ctPvhewKfNs16qzl751ZWYInBbQoZf8CkZMDSxsQGCbTIRAoGBAOXO\n" +
"LOutW0anleTsBbQwbR1k0hIPk6CwQnutq1BcsELYBSNKh6DIA16zBqyE9oFDsS34\n" +
"VLvXETZZKGEUoPju28DVH+Scic5E15CPNUaJie+Ief97fA/iPLJNJFSpcsJG/+Rd\n" +
"jB1hurkcvjzp67wNk9z+WJBxcMfAo/KwSxbkNtl7AoGBAKUitycBIvThHLnjny8Q\n" +
"8uQqX0dpYCQL+f3gQo/yGw5Z2o494i1VJIuk7V6ij7e+eSU2OxWgXWlyajxpt5qu\n" +
"hgqOKstaA3gDcs9PJ9Em07YndRkPfN4W2iNCSxLXqRuQk8BIQmiscDSUTUP6i1yB\n" +
"Vln55EW3IgCMCW8rqux/7sMBAoGAHkrqUvrcIFkxAic2rUUA7TIAGw9gl3sEmIcR\n" +
"IRvGxFjzfG5zqHcVMqOIyq8QS4Pf1D569PPpue9QylNM0OOzphyyApG7/KvIeq7W\n" +
"CAFTZHbqFgpyFSnudFaE5oAbt45iZvkJ4kmisooebassPvLPPf9tL0U056/2LKSe\n" +
"kVrt/AcCgYAWmgeAtQ4H6mX3yPeEa4uDJevjaVKxlKYUPdd8kCD3OTjX9/Pig2GH\n" +
"XhI5UeVd2k4EBdrY1DRVr+cJ8/fEKzcjOKyrbs0XTld8XCBeVuQKAliYS7PpG70C\n" +
"3/jXM8HZyqbPB+apW35Ucqo84ClgPN8LUOi/tE/aP11awxmgTk9F+w==\n" +
"-----END RSA PRIVATE KEY-----";
    
    
     String public_cert = "-----BEGIN CERTIFICATE-----\n" +
"MIIDujCCAqICCQCFNCTEl24W2TANBgkqhkiG9w0BAQsFADCBnjELMAkGA1UEBhMC\n" +
"Q0wxETAPBgNVBAgMCFNhbnRpYWdvMRIwEAYDVQQKDAlUcmFuc2JhbmsxETAPBgNV\n" +
"BAcMCFNhbnRpYWdvMRUwEwYDVQQDDAw1OTcwMjAwMDA1NDcxFzAVBgNVBAsMDkNh\n" +
"bmFsZXNSZW1vdG9zMSUwIwYJKoZIhvcNAQkBFhZpbnRlZ3JhZG9yZXNAdmFyaW9z\n" +
"LmNsMB4XDTE2MDYyMzE2MzcxM1oXDTI0MDYyMTE2MzcxM1owgZ4xCzAJBgNVBAYT\n" +
"AkNMMREwDwYDVQQIDAhTYW50aWFnbzESMBAGA1UECgwJVHJhbnNiYW5rMREwDwYD\n" +
"VQQHDAhTYW50aWFnbzEVMBMGA1UEAwwMNTk3MDIwMDAwNTQ3MRcwFQYDVQQLDA5D\n" +
"YW5hbGVzUmVtb3RvczElMCMGCSqGSIb3DQEJARYWaW50ZWdyYWRvcmVzQHZhcmlv\n" +
"cy5jbDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAORastwv3YYHVbBp\n" +
"L+aeRi73fTsXjr/qaCuNc08SFFzi6RujRFvh2+UM9K05NUxFSVAklW9G1fJ37A9K\n" +
"B6JQ/+yFP877xFifMyOXGu1Wdrmduy7nngGrM0X0RlpCfE6kQfKhP0LhyFFSRIGP\n" +
"WMaRJg9uYRCJWVPeBUUUXB0qSdfvKNyvQ0qpG3vWlhhr7Pocc65U4TuPBwFMC9Bd\n" +
"qMjKsrEkIUamX33kmTKeKrCpRO4iK+aZPN+90Ki6328Jtn3OevkRtIFUOO0ik36T\n" +
"8dkVTPZ2ydwKGLaaBHOB0WlJ1QieWIhmMuvQrFDST7I/WUy9Wr0ySul58oKFT6Jf\n" +
"Xe19dysCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAubHNHDzyMLXuNQwawdhrzJYf\n" +
"Cvi2NsAqVBKICp+VC94OqVsdWknrqm8+Wz+1DZV1ezTvoVgagiC/ZrfHvn9DEP45\n" +
"7JttrOt2Sbr+F2Pj3oBl1RiQ2QkIXBRaSmipKaQB/cWRd0ZiO7uT5mP7eQtO5qFJ\n" +
"4WST6dXtks2Oz4G7eMpqnctOfFiGBi1i6omD7LZg+qpbeTFWTEgZFcAUTrViRLl2\n" +
"PEhUMVAobvvY7zUmzeu2mAMlWVNoaJysl6sH7Gii3T/xbxHsbxV8bZgvgQwiwFVP\n" +
"+ffp06jqVndIhoeiTOz0MXgPIXIESaDraY2dgNTgEs2GwLNjy2cMB5pkjkAZ4g==\n" +
"-----END CERTIFICATE-----";



    session.setAttribute("ENVIRONMENT", environment);
    session.setAttribute("COMMERCE_CODE",commerce_code);
    session.setAttribute("PRIVATE_KEY",private_key);
    session.setAttribute("PUBLIC_CERT",public_cert);
    response.sendRedirect("../tbk-oneclick.jsp");
    
 %> 