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
    
    String commerce_code = "597020000545";
         

    /** Llave Privada */
    String private_key = "-----BEGIN RSA PRIVATE KEY-----\n" +
"MIIEowIBAAKCAQEAs5+IGcfO4IZ6Du8N7IBUD7WcgP0j7jyjF2HaXT48upyzsABZ\n" +
"vhFEiuKGMM6IzrEse63xu6qgy2BAcGaZlCSHDp3Hq3NxHV/bpTPRLC73WsHyYRHe\n" +
"yj/8Zgtsz+FvWkzBALweyPhbY91xyX8ZbxsRAyymEjSrSlVofle6u8WVXs0q3orE\n" +
"v+IseKdv0No68IB/+p8RKPJvXwtbU5ecmbWm3nB/NrLTiGR30sjncgc9DnVE8sDa\n" +
"kfp6tMbgZYdoX0yMVMkSyv1aGbFh+5joh7t855d1Dj2HZjUXg6gL3q8we7jsjsED\n" +
"Y52+RRGj0KW5hhVcYgNwfiYaML6CbGYxrZ6wxwIDAQABAoIBAQCNAhfd5TVKnUcE\n" +
"ojXUC4nyKygJOrASPhfqKy85M7qI5KtK53uL8hJU1S9y8TAE0qGRFiRGptRD0/PC\n" +
"SUkXOvWrS8GLnryVysKrFdqHTPdxj/+upFC5hTGnCiEJsHex878vzH5+VjmoVBcX\n" +
"j2dwCVd5nntgn2g4moPFayl0bs+r8yLk/ITZeqXi5/JDaOfE5WopTi3AH+DvTF8b\n" +
"sIKey5UsRYoAcLDRTosMB41/NEA2DVAsg7RDJakwW6FsJ0VB/y1GGkNBY9NMqqhv\n" +
"NRB1fLrf5CZFPlwcxdi+7rf9qmVEGkS5zvP2DwpC3EmfUB4xXWde4HGD5DizhSYu\n" +
"j2E5XznBAoGBAOTxk3mhr9D8hNy3BKfb+ivqqJ3Nnh61ahjVu9yK9ILSrEDjGvPe\n" +
"U3WiyuD/s51G8iglSDXr9DYX+qG4Q1BQ7XAux8d5/dNLQtGOXUO9jcUU3Zl2EY0+\n" +
"52SRcoh3c4Chooa3QK+ouCgEXexZk4rt1ihqOOzjE3NnkudB5IiogS9VAoGBAMjZ\n" +
"0lfdwFpNiBjWG0LW/zALEJGeYF8TsI26FqxbRdaU9+v5vCvsyVV9uQgf6sZhf6h6\n" +
"GIFEAnb6et6+Gdn9jQLiai3rp1SRN/aQCXLRrSOZFw444+EtyEcVrg4HpOwq0Ztc\n" +
"t7XADowDSWi/l09E32xaeVhktR8fzSzNVHrrZcerAoGALr6YUtxNbokwg3Qm0jMa\n" +
"6D6YQOgLoc9+oyV4nvYMKG3lV7ZG+YXqWnlrnPb4cGNc7A94p/HOQgExXjWmIM71\n" +
"O9OBXNwulCaotOqxZjRcruGswTmXKdSvIByGWxCwl5HpAkKGRZdYSmth1fEQK+yV\n" +
"rljJ2Kwge46pMuiERdbJ0aUCgYBWV3UZ+qTu7Pd9ncT4Vc47y/Xic5AAL0mtk3qd\n" +
"u1rpZP6y/ZeL1m2yh6pcOMRHZbBoL5yLLT5WAVWCnXwlft74h3aXqP801nyVTNQS\n" +
"/NoOPIhxv7kOmwzGqiY5t8WJFNsoi5IZ2qcmP192XS5hkDzvqnERs7E84QHlqZsQ\n" +
"gFMvowKBgFpWIE/WVprPAjMgtyAvlB3v2hkuDyajBMzmklKmRl+hrtrOtf2UFBiu\n" +
"51HgvVREV+eTDEb5tJab5nkhex451iiq9IKpbQx98HTYquFWXjg9rAzInVZ8bqmJ\n" +
"7XTml1qqg0irt8/V+ICwBTkpsYpgiybjAwmRmKjDaWc4Ur1PJZYE\n" +
"-----END RSA PRIVATE KEY-----";

    /** Certificado Publico */
    String public_cert = "-----BEGIN CERTIFICATE-----\n" +
"MIIDujCCAqICCQDcNOEnbK+B0TANBgkqhkiG9w0BAQsFADCBnjELMAkGA1UEBhMC\n" +
"Q0wxETAPBgNVBAgMCFNhbnRpYWdvMRIwEAYDVQQKDAlUcmFuc2JhbmsxETAPBgNV\n" +
"BAcMCFNhbnRpYWdvMRUwEwYDVQQDDAw1OTcwMjAwMDA1NDUxFzAVBgNVBAsMDkNh\n" +
"bmFsZXNSZW1vdG9zMSUwIwYJKoZIhvcNAQkBFhZpbnRlZ3JhZG9yZXNAdmFyaW9z\n" +
"LmNsMB4XDTE2MDcwNjIxMDMxMVoXDTI0MDcwNDIxMDMxMVowgZ4xCzAJBgNVBAYT\n" +
"AkNMMREwDwYDVQQIDAhTYW50aWFnbzESMBAGA1UECgwJVHJhbnNiYW5rMREwDwYD\n" +
"VQQHDAhTYW50aWFnbzEVMBMGA1UEAwwMNTk3MDIwMDAwNTQ1MRcwFQYDVQQLDA5D\n" +
"YW5hbGVzUmVtb3RvczElMCMGCSqGSIb3DQEJARYWaW50ZWdyYWRvcmVzQHZhcmlv\n" +
"cy5jbDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALOfiBnHzuCGeg7v\n" +
"DeyAVA+1nID9I+48oxdh2l0+PLqcs7AAWb4RRIrihjDOiM6xLHut8buqoMtgQHBm\n" +
"mZQkhw6dx6tzcR1f26Uz0Swu91rB8mER3so//GYLbM/hb1pMwQC8Hsj4W2Pdccl/\n" +
"GW8bEQMsphI0q0pVaH5XurvFlV7NKt6KxL/iLHinb9DaOvCAf/qfESjyb18LW1OX\n" +
"nJm1pt5wfzay04hkd9LI53IHPQ51RPLA2pH6erTG4GWHaF9MjFTJEsr9WhmxYfuY\n" +
"6Ie7fOeXdQ49h2Y1F4OoC96vMHu47I7BA2OdvkURo9CluYYVXGIDcH4mGjC+gmxm\n" +
"Ma2esMcCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAIBKS3x/j80GLQ4mhrWS03xjk\n" +
"VuLvO5io0rOn3Gr93QqNyDOyhoVsj4IHEqA/dJLCOGtehWQE3lEk79YaKJpubjbL\n" +
"AB1rhGz7mXe/aIvMFUQMr6Lt5W2tzzVeJ1XyEp3erv3c2vySfEuAmS2XYFiuq4iP\n" +
"HDgl07tm+46k0m2dT+FW3kf1q2lDZI/YHAUgckL3IWdeHyH3aqFuaxZZrc0hCNBx\n" +
"f8Iu9jR87SqAGJmeukGHeiEHOlUvL0Q96P6y/EhCeW2DC0VIoLYrjZqAQpeS8bJQ\n" +
"93RRsSXHXr+g4jnVE0e6qWTgJHGNlsDaqS3MANwCGTsjv4kUQxUbhiooeKEgwA==\n" +
"-----END CERTIFICATE-----";

    session.setAttribute("ENVIRONMENT", environment);
    session.setAttribute("COMMERCE_CODE",commerce_code);
    session.setAttribute("PRIVATE_KEY",private_key);
    session.setAttribute("PUBLIC_CERT",public_cert);
    response.sendRedirect("../tbk-nullify-complete.jsp");
    
 %> 