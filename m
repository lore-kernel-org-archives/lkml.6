Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8E5ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5A020854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pados.hu header.i=@pados.hu header.b="xExZqqRM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD5A020854
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=pados.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730628AbeGRWSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 18:18:07 -0400
Received: from erza.pados.hu ([176.9.136.194]:40300 "EHLO erza.pados.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbeGRWSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 18:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pados.hu;
         s=february2016; h=References:In-Reply-To:To:Subject:Message-ID:From:
        Content-Transfer-Encoding:Content-Type:Date:MIME-Version:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VEvsQo++7HKWwpTHAAKdVMLFINwQpHEDm5v/pBn0IeU=; b=xExZqqRMuKSIvgP5D5BIiexgBr
        eMPo6My8FGTlXZfYPXYxtSRKpsPHkkXF3YhWtaAmrgCsMzvt4JTm2IylNikm3s0M0T1iatxbIpn+D
        KgPNeTYm/RJOrJsqRpQY3Kl55lpyHedbJEJqNUpSju5nP0Y21KC/tp8+amKqJ9XrAuFclmwYK5NFG
        hp8CPyhfq3Ov5hWqAHGqGzPo/5UQPV1kICp0KNbB2sk9g4IRgUV1bgNkDGaNccfqPV4fFWR+E4Rbc
        9rrCARndEoOJJkeUfcxXCPF7nWF3r+7GQY0j+V0D8Lz25KiruQT1u2j3EaD7+k/VcaRCo/Ety83Ha
        B/c0FYfA==;
Received: from localhost ([127.0.0.1] helo=webmail.pados.hu)
        by erza with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <pados@pados.hu>)
        id 1ffu9G-0006F0-SH; Wed, 18 Jul 2018 23:38:15 +0200
MIME-Version: 1.0
Date:   Wed, 18 Jul 2018 21:38:12 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.12.0
From:   "Karoly Pados" <pados@pados.hu>
Message-ID: <ea05b80064d32c7beef3f2039adb89aa@pados.hu>
Subject: Re: [PATCH v2] USB: serial: cp210x: Implement GPIO support for
 CP2102N
To:     "Johan Hovold" <johan@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20180718212004.11852-1-pados@pados.hu>
References: <20180718212004.11852-1-pados@pados.hu>
X-Spam_score: -2.9
X-Spam_report: Spam detection software, running on the system "erza",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  Hello Johan, I hope maybe after you come back from your vacation
    you can still merge this into 4.19, I guess the merge window will still be
    open. Given that there are about another 5 weeks until 4.19rc1 merge window
    closes, I didn't think I'd be late with this patch, I am sorry. However,
   as already explained to you, it'd be very important for me to get this patch
    at least into 4.19, as otherwise the time I loose is much greater than a
   single release cycle (due to distro cycles), and I have actually a crowdfunding
    product depending on this. [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
  0.0 URIBL_BLOCKED          ADMINISTRATOR NOTICE: The query to URIBL was blocked.
                             See
                             http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
                              for more information.
                             [URIs: silabs.com]
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Johan,=0A=0AI hope maybe after you come back from your vacation you=
 can still=0Amerge this into 4.19, I guess the merge window will still be=
 open.=0A=0AGiven that there are=0Aabout another 5 weeks until 4.19rc1 me=
rge window closes,=0AI didn't think I'd be late with this patch, I am sor=
ry.=0AHowever, as already explained to you, it'd be very important=0Afor =
me to get this patch at least into 4.19, as otherwise the=0Atime I loose =
is much greater than a single release cycle (due=0Ato distro cycles), and=
 I have actually a crowdfunding product=0Adepending on this.=0A=0AThank y=
ou for your understanding,=0AKaroly=0A=0AJuly 18, 2018 11:20 PM, "Karoly =
Pados" <pados@pados.hu> wrote:=0A=0A> This is v2 of the patch and address=
es all feedback previously=0A> received from the maintainer. New input/ou=
tput support stayed=0A> as discussed on the e-mail lists separately. CP21=
05 is also=0A> using the new code structure, but due to missing way to ge=
t=0A> default pin states after reset from the device, support=0A> for thi=
s device is basically still output-only as before, at=0A> least in name. =
But CP2105 and CP2102N paths are unified.=0A> =0A> This patch is based on=
 the latest patch series by Johan just=0A> submitted today.=0A> =0A> Sign=
ed-off-by: Karoly Pados <pados@pados.hu>=0A> ---=0A> drivers/usb/serial/c=
p210x.c | 274 ++++++++++++++++++++++++++++++------=0A> 1 file changed, 23=
2 insertions(+), 42 deletions(-)=0A> =0A> diff --git a/drivers/usb/serial=
/cp210x.c b/drivers/usb/serial/cp210x.c=0A> index 4a118eb13590..81f9d3e18=
3c6 100644=0A> --- a/drivers/usb/serial/cp210x.c=0A> +++ b/drivers/usb/se=
rial/cp210x.c=0A> @@ -224,9 +224,19 @@ MODULE_DEVICE_TABLE(usb, id_table)=
;=0A> struct cp210x_serial_private {=0A> #ifdef CONFIG_GPIOLIB=0A> struct=
 gpio_chip gc;=0A> - u8 config;=0A> - u8 gpio_mode;=0A> bool gpio_registe=
red;=0A> +=0A> + /*=0A> + * The following three fields are for devices th=
at=0A> + * emulate input/output pins using open-drain/pushpull=0A> + * dr=
ive modes.=0A> + */=0A> + /* One bit for each GPIO, 1 if pin is pushpull =
*/=0A> + u8 gpio_pushpull;=0A> + /* One bit for each GPIO, 1 if pin is no=
t in GPIO mode */=0A> + u8 gpio_altfunc;=0A> + /* One bit for each GPIO, =
1 if pin direction is input */=0A> + u8 gpio_input;=0A> #endif=0A> u8 par=
tnum;=0A> speed_t max_speed;=0A> @@ -343,6 +353,7 @@ static struct usb_se=
rial_driver * const serial_drivers[] =3D {=0A> #define CONTROL_WRITE_RTS =
0x0200=0A> =0A> /* CP210X_VENDOR_SPECIFIC values */=0A> +#define CP210X_R=
EAD_2NCONFIG 0x000E=0A> #define CP210X_READ_LATCH 0x00C2=0A> #define CP21=
0X_GET_PARTNUM 0x370B=0A> #define CP210X_GET_PORTCONFIG 0x370C=0A> @@ -45=
2,6 +463,12 @@ struct cp210x_config {=0A> #define CP2105_GPIO1_RXLED_MODE=
 BIT(1)=0A> #define CP2105_GPIO1_RS485_MODE BIT(2)=0A> =0A> +/* CP2102N c=
onfiguration array indices */=0A> +#define CP210X_2NCONFIG_CONFIG_VERSION=
_IDX 2=0A> +#define CP210X_2NCONFIG_GPIO_MODE_IDX 581=0A> +#define CP210X=
_2NCONFIG_GPIO_RSTLATCH_IDX 587=0A> +#define CP210X_2NCONFIG_GPIO_CONTROL=
_IDX 600=0A> +=0A> /* CP210X_VENDOR_SPECIFIC, CP210X_WRITE_LATCH call wri=
tes these 0x2 bytes. */=0A> struct cp210x_gpio_write {=0A> u8 mask;=0A> @=
@ -1308,21 +1325,29 @@ static void cp210x_break_ctl(struct tty_struct *tt=
y, int break_state)=0A> }=0A> =0A> #ifdef CONFIG_GPIOLIB=0A> +=0A> +/*=0A=
> + * Helper to determine if a specific serial device belongs to the cp21=
02n=0A> + * family of devices.=0A> + */=0A> +static bool cp210x_is_cp2102=
n(struct usb_serial *serial)=0A> +{=0A> + struct cp210x_serial_private *p=
riv =3D usb_get_serial_data(serial);=0A> +=0A> + return (priv->partnum =
=3D=3D CP210X_PARTNUM_CP2102N_QFN28) ||=0A> + (priv->partnum =3D=3D CP210=
X_PARTNUM_CP2102N_QFN24) ||=0A> + (priv->partnum =3D=3D CP210X_PARTNUM_CP=
2102N_QFN20);=0A> +}=0A> +=0A> static int cp210x_gpio_request(struct gpio=
_chip *gc, unsigned int offset)=0A> {=0A> struct usb_serial *serial =3D g=
piochip_get_data(gc);=0A> struct cp210x_serial_private *priv =3D usb_get_=
serial_data(serial);=0A> =0A> - switch (offset) {=0A> - case 0:=0A> - if =
(priv->config & CP2105_GPIO0_TXLED_MODE)=0A> - return -ENODEV;=0A> - brea=
k;=0A> - case 1:=0A> - if (priv->config & (CP2105_GPIO1_RXLED_MODE |=0A> =
- CP2105_GPIO1_RS485_MODE))=0A> - return -ENODEV;=0A> - break;=0A> + if (=
priv->gpio_altfunc & BIT(offset)) {=0A> + dev_warn(&serial->interface->de=
v,=0A> + "Cannot control GPIO with active alternate function.\n");=0A> + =
return -ENODEV;=0A> }=0A> =0A> return 0;=0A> @@ -1331,10 +1356,15 @@ stat=
ic int cp210x_gpio_request(struct gpio_chip *gc, unsigned int offset)=0A>=
 static int cp210x_gpio_get(struct gpio_chip *gc, unsigned int gpio)=0A> =
{=0A> struct usb_serial *serial =3D gpiochip_get_data(gc);=0A> + struct c=
p210x_serial_private *priv =3D usb_get_serial_data(serial);=0A> + u8 req_=
type =3D REQTYPE_DEVICE_TO_HOST;=0A> int result;=0A> u8 buf;=0A> =0A> - r=
esult =3D cp210x_read_vendor_block(serial, REQTYPE_INTERFACE_TO_HOST,=0A>=
 + if (priv->partnum =3D=3D CP210X_PARTNUM_CP2105)=0A> + req_type =3D REQ=
TYPE_INTERFACE_TO_HOST;=0A> +=0A> + result =3D cp210x_read_vendor_block(s=
erial, req_type,=0A> CP210X_READ_LATCH, &buf, sizeof(buf));=0A> if (resul=
t < 0)=0A> return result;=0A> @@ -1345,34 +1375,82 @@ static int cp210x_g=
pio_get(struct gpio_chip *gc, unsigned int gpio)=0A> static void cp210x_g=
pio_set(struct gpio_chip *gc, unsigned int gpio, int value)=0A> {=0A> str=
uct usb_serial *serial =3D gpiochip_get_data(gc);=0A> + struct cp210x_ser=
ial_private *priv =3D usb_get_serial_data(serial);=0A> struct cp210x_gpio=
_write buf;=0A> + int result =3D 0;=0A> =0A> - if (value =3D=3D 1)=0A> - =
buf.state =3D BIT(gpio);=0A> - else=0A> - buf.state =3D 0;=0A> -=0A> + bu=
f.state =3D (value =3D=3D 1) ? BIT(gpio) : 0;=0A> buf.mask =3D BIT(gpio);=
=0A> =0A> - cp210x_write_vendor_block(serial, REQTYPE_HOST_TO_INTERFACE,=
=0A> - CP210X_WRITE_LATCH, &buf, sizeof(buf));=0A> + if (priv->partnum =
=3D=3D CP210X_PARTNUM_CP2105) {=0A> + result =3D cp210x_write_vendor_bloc=
k(serial,=0A> + REQTYPE_HOST_TO_INTERFACE,=0A> + CP210X_WRITE_LATCH, &buf=
,=0A> + sizeof(buf));=0A> + } else if (cp210x_is_cp2102n(serial)) {=0A> +=
 u16 wIndex =3D buf.state << 8 | buf.mask;=0A> +=0A> + result =3D usb_con=
trol_msg(serial->dev,=0A> + usb_sndctrlpipe(serial->dev, 0),=0A> + CP210X=
_VENDOR_SPECIFIC,=0A> + REQTYPE_HOST_TO_DEVICE,=0A> + CP210X_WRITE_LATCH,=
=0A> + wIndex,=0A> + NULL, 0, USB_CTRL_SET_TIMEOUT);=0A> + }=0A> +=0A> + =
if (result < 0)=0A> + dev_err(&serial->interface->dev, "Failed to set GPI=
O value.\n");=0A> }=0A> =0A> static int cp210x_gpio_direction_get(struct =
gpio_chip *gc, unsigned int gpio)=0A> {=0A> - /* Hardware does not suppor=
t an input mode */=0A> - return 0;=0A> + struct usb_serial *serial =3D gp=
iochip_get_data(gc);=0A> + struct cp210x_serial_private *priv =3D usb_get=
_serial_data(serial);=0A> +=0A> + return priv->gpio_input & BIT(gpio);=0A=
> }=0A> =0A> static int cp210x_gpio_direction_input(struct gpio_chip *gc,=
 unsigned int gpio)=0A> {=0A> - /* Hardware does not support an input mod=
e */=0A> - return -ENOTSUPP;=0A> + struct usb_serial *serial =3D gpiochip=
_get_data(gc);=0A> + struct cp210x_serial_private *priv =3D usb_get_seria=
l_data(serial);=0A> +=0A> + if (priv->partnum =3D=3D CP210X_PARTNUM_CP210=
5) {=0A> + /* Hardware does not support an input mode */=0A> + return -EN=
OTSUPP;=0A> + } else if (cp210x_is_cp2102n(serial)) {=0A> + /* Push-pull =
pins cannot be changed to be inputs */=0A> + if (priv->gpio_pushpull & BI=
T(gpio)) {=0A> + dev_warn(&serial->interface->dev,=0A> + "Cannot change d=
irection of a push-pull GPIO to input.\n");=0A> + return -EPERM;=0A> + }=
=0A> +=0A> + /* Make sure to release pin if it is being driven low */=0A>=
 + cp210x_gpio_set(gc, gpio, 1);=0A> +=0A> + /* Note pin direction to our=
selves */=0A> + priv->gpio_input |=3D BIT(gpio);=0A> +=0A> + return 0;=0A=
> + }=0A> +=0A> + return -EPERM;=0A> }=0A> =0A> static int cp210x_gpio_di=
rection_output(struct gpio_chip *gc, unsigned int gpio,=0A> int value)=0A=
> {=0A> + struct usb_serial *serial =3D gpiochip_get_data(gc);=0A> + stru=
ct cp210x_serial_private *priv =3D usb_get_serial_data(serial);=0A> +=0A>=
 + /* Note pin direction to ourselves */=0A> + priv->gpio_input &=3D ~BIT=
(gpio);=0A> +=0A> + /* Set requested initial output value */=0A> + cp210x=
_gpio_set(gc, gpio, value);=0A> +=0A> return 0;=0A> }=0A> =0A> @@ -1385,1=
1 +1463,11 @@ static int cp210x_gpio_set_config(struct gpio_chip *gc, uns=
igned int gpio,=0A> =0A> /* Succeed only if in correct mode (this can't b=
e set at runtime) */=0A> if ((param =3D=3D PIN_CONFIG_DRIVE_PUSH_PULL) &&=
=0A> - (priv->gpio_mode & BIT(gpio)))=0A> + (priv->gpio_pushpull & BIT(gp=
io)))=0A> return 0;=0A> =0A> if ((param =3D=3D PIN_CONFIG_DRIVE_OPEN_DRAI=
N) &&=0A> - !(priv->gpio_mode & BIT(gpio)))=0A> + !(priv->gpio_pushpull &=
 BIT(gpio)))=0A> return 0;=0A> =0A> return -ENOTSUPP;=0A> @@ -1402,13 +14=
80,14 @@ static int cp210x_gpio_set_config(struct gpio_chip *gc, unsigned=
 int gpio,=0A> * this driver that provide GPIO do so in a way that does n=
ot impact other=0A> * signals and are thus expected to have very differen=
t initialisation.=0A> */=0A> -static int cp2105_shared_gpio_init(struct u=
sb_serial *serial)=0A> +static int cp2105_gpioconf_init(struct usb_serial=
 *serial)=0A> {=0A> struct cp210x_serial_private *priv =3D usb_get_serial=
_data(serial);=0A> struct cp210x_pin_mode mode;=0A> struct cp210x_config =
config;=0A> u8 intf_num =3D cp210x_interface_num(serial);=0A> int result;=
=0A> + u8 iface_config;=0A> =0A> result =3D cp210x_read_vendor_block(seri=
al, REQTYPE_DEVICE_TO_HOST,=0A> CP210X_GET_DEVICEMODE, &mode,=0A> @@ -142=
4,20 +1503,25 @@ static int cp2105_shared_gpio_init(struct usb_serial *se=
rial)=0A> =0A> /* 2 banks of GPIO - One for the pins taken from each seri=
al port */=0A> if (intf_num =3D=3D 0) {=0A> - if (mode.eci =3D=3D CP210X_=
PIN_MODE_MODEM)=0A> + if (mode.eci =3D=3D CP210X_PIN_MODE_MODEM) {=0A> + =
/* Mark all GPIOs of this interface as reserved */=0A> + priv->gpio_altfu=
nc =3D 0xFF;=0A> return 0;=0A> + }=0A> =0A> - priv->config =3D config.eci=
_cfg;=0A> - priv->gpio_mode =3D (u8)((le16_to_cpu(config.gpio_mode) &=0A>=
 + iface_config =3D config.eci_cfg;=0A> + priv->gpio_pushpull =3D (u8)((l=
e16_to_cpu(config.gpio_mode) &=0A> CP210X_ECI_GPIO_MODE_MASK) >>=0A> CP21=
0X_ECI_GPIO_MODE_OFFSET);=0A> priv->gc.ngpio =3D 2;=0A> } else if (intf_n=
um =3D=3D 1) {=0A> - if (mode.sci =3D=3D CP210X_PIN_MODE_MODEM)=0A> - ret=
urn 0;=0A> + if (mode.sci =3D=3D CP210X_PIN_MODE_MODEM) {=0A> + /* Mark a=
ll GPIOs of this interface as reserved */=0A> + priv->gpio_altfunc =3D 0x=
FF;=0A> + }=0A> =0A> - priv->config =3D config.sci_cfg;=0A> - priv->gpio_=
mode =3D (u8)((le16_to_cpu(config.gpio_mode) &=0A> + iface_config =3D con=
fig.sci_cfg;=0A> + priv->gpio_pushpull =3D (u8)((le16_to_cpu(config.gpio_=
mode) &=0A> CP210X_SCI_GPIO_MODE_MASK) >>=0A> CP210X_SCI_GPIO_MODE_OFFSET=
);=0A> priv->gc.ngpio =3D 3;=0A> @@ -1445,6 +1529,118 @@ static int cp210=
5_shared_gpio_init(struct usb_serial *serial)=0A> return -ENODEV;=0A> }=
=0A> =0A> + /* Mark all pins which are not in GPIO mode */=0A> + priv->gp=
io_altfunc =3D 0;=0A> + if (iface_config & CP2105_GPIO0_TXLED_MODE) /* GP=
IO 0 */=0A> + priv->gpio_altfunc |=3D BIT(0);=0A> + if (iface_config & (C=
P2105_GPIO1_RXLED_MODE | /* GPIO 1 */=0A> + CP2105_GPIO1_RS485_MODE))=0A>=
 + priv->gpio_altfunc |=3D BIT(1);=0A> +=0A> + /* Driver implementation f=
or CP2105 only supports outputs */=0A> + priv->gpio_input =3D 0;=0A> +=0A=
> + return 0;=0A> +}=0A> +=0A> +static int cp2102n_gpioconf_init(struct u=
sb_serial *serial)=0A> +{=0A> + struct cp210x_serial_private *priv =3D us=
b_get_serial_data(serial);=0A> + const u16 CONFIG_SIZE =3D 0x02A6;=0A> + =
u8 gpio_rst_latch;=0A> + u8 config_version;=0A> + u8 gpio_pushpull;=0A> +=
 u8 *config_buf;=0A> + u8 gpio_latch;=0A> + u8 gpio_ctrl;=0A> + int resul=
t;=0A> + u8 i;=0A> +=0A> + /* Retrieve device configuration from the devi=
ce.=0A> + * The array received contains all customization settings=0A> + =
* done at the factory/manufacturer.=0A> + * Format of the array is docume=
nted at the time of writing at=0A> + *=0A> https://www.silabs.com/communi=
ty/interface/knowledge-base.entry.html/2017/03/31/cp2102n_setconfig-xs=0A=
> a=0A> + */=0A> + config_buf =3D kmalloc(CONFIG_SIZE, GFP_KERNEL);=0A> +=
 if (!config_buf)=0A> + return -ENOMEM;=0A> +=0A> + result =3D cp210x_rea=
d_vendor_block(serial,=0A> + REQTYPE_DEVICE_TO_HOST,=0A> + CP210X_READ_2N=
CONFIG,=0A> + config_buf,=0A> + CONFIG_SIZE);=0A> + if (result < 0) {=0A>=
 + kfree(config_buf);=0A> + return -EIO;=0A> + }=0A> +=0A> + config_versi=
on =3D config_buf[CP210X_2NCONFIG_CONFIG_VERSION_IDX];=0A> + gpio_pushpul=
l =3D config_buf[CP210X_2NCONFIG_GPIO_MODE_IDX];=0A> + gpio_ctrl =3D conf=
ig_buf[CP210X_2NCONFIG_GPIO_CONTROL_IDX];=0A> + gpio_rst_latch =3D config=
_buf[CP210X_2NCONFIG_GPIO_RSTLATCH_IDX];=0A> +=0A> + kfree(config_buf);=
=0A> +=0A> + /* Make sure this is a config format we understand */=0A> + =
if (config_version !=3D 0x01)=0A> + return -ENOTSUPP;=0A> +=0A> + /* We o=
nly support 4 GPIOs even on the QFN28 package, because=0A> + * config loc=
ations of GPIOs 4-6 determined using reverse=0A> + * engineering revealed=
 conflicting offsets with other=0A> + * documented functions. So we'll ju=
st play it safe for now.=0A> + */=0A> + priv->gc.ngpio =3D 4;=0A> +=0A> +=
 /* Get default pin states after reset. Needed so we can determine=0A> + =
* the direction of an open-drain pin.=0A> + */=0A> + gpio_latch =3D (gpio=
_rst_latch >> 3) & 0x0F;=0A> +=0A> + /* 0 indicates open-drain mode, 1 is=
 push-pull */=0A> + priv->gpio_pushpull =3D (gpio_pushpull >> 3) & 0x0F;=
=0A> +=0A> + /* 0 indicates GPIO mode, 1 is alternate function */=0A> + p=
riv->gpio_altfunc =3D (gpio_ctrl >> 2) & 0x0F;=0A> +=0A> + /* The CP2102N=
 does not strictly has input and output pin modes,=0A> + * it only knows =
open-drain and push-pull modes which is set at=0A> + * factory. An open-d=
rain pin can function both as an=0A> + * input or an output. We emulate i=
nput mode for open-drain pins=0A> + * by making sure they are not driven =
low, and we do not allow=0A> + * push-pull pins to be set as an input.=0A=
> + */=0A> + for (i =3D 0; i < priv->gc.ngpio; ++i) {=0A> + /* Set direct=
ion to "input" iff=0A> + * pin is open-drain and reset value is 1=0A> + *=
/=0A> + if (!(priv->gpio_pushpull & BIT(i)) && (gpio_latch & BIT(i)))=0A>=
 + priv->gpio_input |=3D BIT(i);=0A> + }=0A> +=0A> + return 0;=0A> +}=0A>=
 +=0A> +static int cp210x_gpio_init(struct usb_serial *serial)=0A> +{=0A>=
 + struct cp210x_serial_private *priv =3D usb_get_serial_data(serial);=0A=
> + int result =3D 0;=0A> +=0A> + if (cp210x_is_cp2102n(serial))=0A> + re=
sult =3D cp2102n_gpioconf_init(serial);=0A> + else if (priv->partnum =3D=
=3D CP210X_PARTNUM_CP2105)=0A> + result =3D cp2105_gpioconf_init(serial);=
=0A> + else=0A> + return 0;=0A> +=0A> + if (result < 0) {=0A> + dev_err(&=
serial->interface->dev,=0A> + "GPIO initialisation failed, continuing wit=
hout GPIO support\n");=0A> + return result;=0A> + }=0A> +=0A> priv->gc.la=
bel =3D "cp210x";=0A> priv->gc.request =3D cp210x_gpio_request;=0A> priv-=
>gc.get_direction =3D cp210x_gpio_direction_get;=0A> @@ -1477,7 +1673,7 @=
@ static void cp210x_gpio_remove(struct usb_serial *serial)=0A> =0A> #els=
e=0A> =0A> -static int cp2105_shared_gpio_init(struct usb_serial *serial)=
=0A> +static int cp210x_gpio_init(struct usb_serial *serial)=0A> {=0A> re=
turn 0;=0A> }=0A> @@ -1588,13 +1784,7 @@ static int cp210x_attach(struct =
usb_serial *serial)=0A> =0A> cp210x_init_max_speed(serial);=0A> =0A> - if=
 (priv->partnum =3D=3D CP210X_PARTNUM_CP2105) {=0A> - result =3D cp2105_s=
hared_gpio_init(serial);=0A> - if (result < 0) {=0A> - dev_err(&serial->i=
nterface->dev,=0A> - "GPIO initialisation failed, continuing without GPIO=
 support\n");=0A> - }=0A> - }=0A> + cp210x_gpio_init(serial);=0A> =0A> re=
turn 0;=0A> }=0A> -- =0A> 2.17.1
