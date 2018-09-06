package cl.transbank.webpayexample;

import com.codeborne.selenide.Selenide;
import com.codeborne.selenide.junit.ScreenShooter;
import org.junit.*;
import org.openqa.selenium.By;

import static com.codeborne.selenide.Condition.disappears;
import static com.codeborne.selenide.Condition.text;
import static com.codeborne.selenide.Condition.visible;
import static com.codeborne.selenide.Configuration.*;
import static com.codeborne.selenide.Selectors.byText;
import static com.codeborne.selenide.Selectors.byValue;
import static com.codeborne.selenide.Selenide.*;
import static com.codeborne.selenide.WebDriverRunner.addListener;
import static com.codeborne.selenide.WebDriverRunner.closeWebDriver;

public class ExampleTest {

    @Rule
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

        $("body").shouldHave(text("Esta transacción se está realizando sobre un sistema seguro"));
        $("#TBK_TIPO_TARJETA").click();
        $("#TBK_NUMERO_TARJETA").setValue("4051885600446623").pressTab();
        $("#TBK_CVV").setValue("123").pressTab();
        $("#button").click(); // Pagar

        authorizeWebpayPayment();

        $("body").shouldHave(text("Pago ACEPTADO por webpay"));
        $("input[type=submit]").click();

        $("body").shouldHave(text("Su transacción fue realizada con éxito."));
        $("#button4").click(); // Continuar

        $("body").shouldHave(text("Transaccion Finalizada"));
        $("input[type=submit]").click(); // Anular Transaccion

        $("body").shouldHave(text("Anulacion realizada con exito"));
    }

    @Test
    public void testWebpayPlusMall() {
        $(byText("Webpay Plus Mall")).click();

        $("body").shouldHave(text("Sesion iniciada con exito en Webpay"));
        $("input[type=submit]").click(); // Ejecutar Pago con Webpay

        $("body").shouldHave(text("Esta transacción se está realizando sobre un sistema seguro"));
        $("#TBK_TIPO_TARJETA").click();
        $("#TBK_NUMERO_TARJETA").setValue("4051885600446623").pressTab();
        $("#button").click(); // Pagar

        authorizeWebpayPayment();

        $("body").shouldHave(text("Pago ACEPTADO por webpay"));
        $("input[type=submit]").click();

        $("body").shouldHave(text("Su transacción fue realizada con éxito."));
        $("#button4").click(); // Continuar

        $("body").shouldHave(text("Transaccion Finalizada"));
        $("input[type=submit]").click(); // Anular

        $("body").shouldHave(text("Anulacion realizada con exito"));
    }

    @Test
    public void testWebpayPlusCapture() {
        $(byText("Webpay Plus Captura Diferida")).click();

        $("body").shouldHave(text("Sesion iniciada con exito en Webpay"));
        $("input[type=submit]").click(); // Ejecutar Pago con Webpay

        $("body").shouldHave(text("Esta transacción se está realizando sobre un sistema seguro"));
        $("#TBK_NUMERO_TARJETA").setValue("4051885600446623").pressTab();
        $("#TBK_CVV").setValue("123").pressTab();

        $("#button").click(); // Pagar

        authorizeWebpayPayment();

        $("body").shouldHave(text("Pago ACEPTADO por webpay"));
        $("input[type=submit]").click();

        $("body").shouldHave(text("Su transacción fue realizada con éxito."));
        $("#button4").click(); // Continuar

        $("body").shouldHave(text("Transaccion Finalizada"));
        $("input[type=submit]").click(); // Realizar Captura diferida

        $("body").shouldHave(text("Pago ACEPTADO por webpay"));
    }

    private void authorizeWebpayPayment() {
        switchTo().frame("transicion");
        $("body").shouldHave(text("BIENVENIDO"));
        $("#rutClient").setValue("11.111.111-1").pressTab();
        $("#passwordClient").setValue("123").pressTab();
        $(byValue("Aceptar")).click();
        $(byValue("Continuar")).click();
    }

    private void authorizeWebpayPaymentWithRutAndPassword() {

    }

    @AfterClass
    public static void logout() {
        closeWebDriver();
    }

}