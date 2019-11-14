package cl.transbank.webpayexample;

import com.codeborne.selenide.junit.ScreenShooter;
import org.junit.*;

import static com.codeborne.selenide.Condition.*;
import static com.codeborne.selenide.Configuration.*;
import static com.codeborne.selenide.Selectors.byText;
import static com.codeborne.selenide.Selectors.byValue;
import static com.codeborne.selenide.Selectors.withText;
import static com.codeborne.selenide.Selenide.*;
import static com.codeborne.selenide.WebDriverRunner.closeWebDriver;

public class ExampleTest {

   /* @Rule
    public ScreenShooter screenShooter = ScreenShooter.failedTests();

    @BeforeClass
    public static void setUp() {
        timeout = 10000;
        baseUrl = "http://localhost:8080";
        startMaximized = true;
    }

    @Before
    public void resetBrowser() {
        open("/");
    }

    @Test
    public void testWebpayPlusNormal() {
        $(byText("Webpay Plus Normal")).click();
        $("body").shouldHave(text("Sesion iniciada con exito en Webpay"));
        $("input[type=submit]").click(); // Ejecutar Pago con Webpay

        $("body").shouldHave(text("Selecciona tu medio de pago"));
        $("img[alt=visa]").click();
        $("#visa-card-show").setValue("4051885600446623").pressTab();
        $("#password-invalid").setValue("123").pressTab(); // CCV

        $("button[disabled]").should(disappear);
        $(withText("Continuar")).click();
        $("body").shouldHave(text("Sin cuotas"));
        $(withText("Continuar")).click();

        authorizeWebpayPayment();

        $("body").shouldHave(text("Pago ACEPTADO por webpay"));
        $("input[type=submit]").click();

        $("body").shouldHave(text("Su transacción fue realizada con éxito."));
        $(withText("Ir a detalle de la compra")).click();

        $("body").shouldHave(text("Transaccion Finalizada"));
        $("input[type=submit]").click(); // Anular Transaccion

        $("body").shouldHave(text("Anulacion realizada con exito"));
    }

    @Test
    public void testWebpayPlusMall() {
        $(byText("Webpay Plus Mall")).click();

        $("body").shouldHave(text("Sesion iniciada con exito en Webpay"));
        $("input[type=submit]").click(); // Ejecutar Pago con Webpay

        $("body").shouldHave(text("Selecciona tu medio de pago"));
        $("img[alt=visa]").click();
        $("#visa-card-show").setValue("4051885600446623").pressTab();

        $("button[disabled]").should(disappear);
        $(withText("Continuar")).click();
        $("body").shouldHave(text("Sin cuotas"));
        $(withText("Continuar")).click();

        authorizeWebpayPayment();

        $("body").shouldHave(text("Pago ACEPTADO por webpay"));
        $("input[type=submit]").click();

        $("body").shouldHave(text("Su transacción fue realizada con éxito."));
        $(withText("Ir a detalle de la compra")).click();

        $("body").shouldHave(text("Transaccion Finalizada"));
        $("input[type=submit]").click(); // Anular

        $("body").shouldHave(text("Anulacion realizada con exito"));
    }

    @Test
    public void testWebpayPlusCapture() {
        $(byText("Webpay Plus Captura Diferida")).click();

        $("body").shouldHave(text("Sesion iniciada con exito en Webpay"));
        $("input[type=submit]").click(); // Ejecutar Pago con Webpay

        $("body").shouldHave(text("Esta transacción se esta realizando bajo un sistema seguro"));
        $("#visa-card-show").setValue("4051885600446623").pressTab();
        $("#password-invalid").setValue("123").pressTab(); // CCV

        $("button[disabled]").should(disappear);
        $(withText("Continuar")).click();
        $("body").shouldHave(text("Sin cuotas"));
        $(withText("Continuar")).click();

        authorizeWebpayPayment();

        $("body").shouldHave(text("Pago ACEPTADO por webpay"));
        $("input[type=submit]").click();

        $("body").shouldHave(text("Su transacción fue realizada con éxito."));
        $(withText("Ir a detalle de la compra")).click();

        $("body").shouldHave(text("Transaccion Finalizada"));
        $("input[type=submit]").click(); // Realizar Captura diferida

        $("body").shouldHave(text("Pago ACEPTADO por webpay"));
    }

    @Test
    public void testWebpayOneClickNormal() {
        $(byText("Webpay OneClick Normal")).click();

        $("body").shouldHave(text("Sesion iniciada con exito en Webpay"));
        $("input[type=submit]").click(); // Ejecutar Inscripcion con Webpay

        $("body").shouldHave(text("Esta transacción se esta realizando bajo un sistema seguro"));
        $("#visa-card-show").setValue("4051885600446623").pressTab();
        $("#password-invalid").setValue("123").pressTab(); // CCV

        $("button[disabled]").should(disappear);
        $(withText("Continuar")).click();

        authorizeWebpayPayment();

        $("body").shouldHave(text("Pago ACEPTADO por webpay"));
        $("input[type=submit]").click(); // Ejecutar Authorize

        $("body").shouldHave(text("Pago ACEPTADO por webpay"));
        $("input[type=submit]").click(); // Ejecutar Reverse Transaction

        $("body").shouldHave(text("Operacion ACEPTADA por webpay"));
        $("input[type=submit]").click(); // Ejecutar Remove User

        $("body").shouldHave(text("Operacion ACEPTADA por webpay"));

    }

    private void authorizeWebpayPayment() {
        switchTo().frame("transicion");
        $("body").shouldHave(text("BIENVENIDO"));
        $("#rutClient").setValue("11.111.111-1").pressTab();
        $("#passwordClient").setValue("123").pressTab();
        $(byValue("Aceptar")).click();
        $(byValue("Continuar")).click();
    }


    @AfterClass
    public static void logout() {
        closeWebDriver();
    }*/

}