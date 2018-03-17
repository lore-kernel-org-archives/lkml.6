Return-Path: <leechu729@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-638976-1521265967-2-213051911825493012
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_ENVFROM_END_DIGIT 0.25, FREEMAIL_FROM 0.001,
  RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H3 -0.01,
  RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.220.194', Host='mail-qk0-f194.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: from='UTF-8', cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: leechu729@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521265966; b=LHnn5jlC8O8y0sjEYtH0urMvpiV6fp4n5jq/gcYIG+oM/V3
    VDrcPqGrE3378kyiicxXMt+YSNrCYYdjXulAblQDo+36bO5+mO2S3jH2H80OERl1
    gvo18W1Ipp6sTy9NzAH3Z+dHy/nNOm4N3PzpqesPG5sxxXY0GS4l26ixdz+kDbdw
    Jc0kRKfqxTTiI3mxhd7Yula2xgEnacGLZl4l2V90AmYf6DOUGBgSztzo/mrsy8G4
    8fFeYQpdqM0CgSoJGxf6Owy9dYcpBX6CDnUtZ0y+st6wgRbBTtUfKxC3kCWe1pYr
    Ui+4IaIW96vvg/bG0Qjth/uPhnO4l3AKrYqCh1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding; s=arctest; t=1521265966; bh=PayxYJgr
    mrXS5owTLxKEtCyW+ZD53YWMP2jj24sLzBQ=; b=FYj+E+lMWv3c1Yd3Ysz8HlI+
    41qj8csThotRKz/+Fmlil9z/BK87LaGV5vdyzl8irmGxcbyDB2rDKuwMVUcr3ZjI
    1rSn44mzSE5F8o5O1Szm3HtSfKwnON41vQNJpTjkHvGHxIhBZUdczq6B3sIYYpQ5
    NeuLcTMBifncrZEGYPn5DkBZQrSLkCGOYZ1xH/C8JvhIh5d1WSJ/tAVxOJeymsK1
    PVohpvkMFU1kOzzvtqCJY95pvWiuzkFZVsx6MkMJK4VJa5pQETdv8wotE+bIjpl1
    PdIIJq/c8DuyyOzjXQAXr5RAhjv6VHoBjWtaNKwRmy7kk3audvE+dz6WfN0Q3g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Ajun9Ox5 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.220.194 (mail-qk0-f194.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-qk0-f194.google.com;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=iN2h3r2R;
    x-ptr=pass x-ptr-helo=mail-qk0-f194.google.com x-ptr-lookup=mail-qk0-f194.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Ajun9Ox5 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.220.194 (mail-qk0-f194.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-qk0-f194.google.com;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=iN2h3r2R;
    x-ptr=pass x-ptr-helo=mail-qk0-f194.google.com x-ptr-lookup=mail-qk0-f194.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AG47ELv53ujg1wmO2erZ8cOG9V5Cv/ebuQNjC33fBd9EwhsEs++9M3buBsvMcERmTyDGv92f5dOKSlD+cY/VfZkLuTs=
MIME-Version: 1.0
In-Reply-To: <7ebc0dac-db70-3635-27c2-97ce0b5b9f4c@roeck-us.net>
References: <1521222040-30349-1-git-send-email-leechu729@gmail.com> <7ebc0dac-db70-3635-27c2-97ce0b5b9f4c@roeck-us.net>
From: =?UTF-8?B?5p2O5pu45biG?= <leechu729@gmail.com>
Date: Sat, 17 Mar 2018 13:52:43 +0800
Message-ID: <CAFaeLdQmHi02KqQUZkSR1ok84ETpCWVYZyPMghWo-0icECjWAg@mail.gmail.com>
Subject: Re: [PATCH v2] staging: typec: rt1711h typec chip driver
To: Guenter Roeck <linux@roeck-us.net>
Cc: Greg KH <greg@kroah.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	=?UTF-8?B?c2h1ZmFuX2xlZSjmnY7mm7jluIYp?= <shufan_lee@richtek.com>,
	=?UTF-8?B?Y3lfaHVhbmco6buD5ZWf5Y6fKQ==?= <cy_huang@richtek.com>,
	Jun Li <jun.li@nxp.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Guenter,

2018-03-17 10:16 GMT+08:00 Guenter Roeck <linux@roeck-us.net>:
> On 03/16/2018 10:40 AM, ShuFan Lee wrote:
>>
>> From: ShuFan Lee <shufan_lee@richtek.com>
>>
>> Richtek RT1711H Type-C chip driver that works with
>> Type-C Port Controller Manager to provide USB PD and
>> USB Type-C functionalities.
>> Add definition of TCPC_CC_STATUS_TOGGLING.
>>
>> Signed-off-by: ShuFan Lee <shufan_lee@richtek.com>
>
>
> Does this patch require DT review for the bindings ?
I see Jun is also working on the properties of DTS for TCPCI/TCPM in
his patches.
So, I plan to upload the devicetree binding file when it is ready to
move tcpci_rt1711h out of staging.
Is it OK or should I upload a version first?
>
> Gueter
>
>
>> ---
>>   drivers/staging/typec/Kconfig         |   8 +
>>   drivers/staging/typec/Makefile        |   1 +
>>   drivers/staging/typec/tcpci.h         |   1 +
>>   drivers/staging/typec/tcpci_rt1711h.c | 329
>> ++++++++++++++++++++++++++++++++++
>>   4 files changed, 339 insertions(+)
>>   create mode 100644 drivers/staging/typec/tcpci_rt1711h.c
>>
>>   changelogs between v1 and v2
>>   - use gpiod_* instead of gpio_*
>>
>> diff --git a/drivers/staging/typec/Kconfig b/drivers/staging/typec/Kconf=
ig
>> index 5359f556d203..3aa981fbc8f5 100644
>> --- a/drivers/staging/typec/Kconfig
>> +++ b/drivers/staging/typec/Kconfig
>> @@ -9,6 +9,14 @@ config TYPEC_TCPCI
>>         help
>>           Type-C Port Controller driver for TCPCI-compliant controller.
>>   +config TYPEC_RT1711H
>> +       tristate "Richtek RT1711H Type-C chip driver"
>> +       select TYPEC_TCPCI
>> +       help
>> +         Richtek RT1711H Type-C chip driver that works with
>> +         Type-C Port Controller Manager to provide USB PD and USB
>> +         Type-C functionalities.
>> +
>>   endif
>>     endmenu
>> diff --git a/drivers/staging/typec/Makefile
>> b/drivers/staging/typec/Makefile
>> index 53d649abcb53..7803d485e1b3 100644
>> --- a/drivers/staging/typec/Makefile
>> +++ b/drivers/staging/typec/Makefile
>> @@ -1 +1,2 @@
>>   obj-$(CONFIG_TYPEC_TCPCI)     +=3D tcpci.o
>> +obj-$(CONFIG_TYPEC_RT1711H)    +=3D tcpci_rt1711h.o
>> diff --git a/drivers/staging/typec/tcpci.h b/drivers/staging/typec/tcpci=
.h
>> index 34c865f0dcf6..303ebde26546 100644
>> --- a/drivers/staging/typec/tcpci.h
>> +++ b/drivers/staging/typec/tcpci.h
>> @@ -59,6 +59,7 @@
>>   #define TCPC_POWER_CTRL_VCONN_ENABLE  BIT(0)
>>     #define TCPC_CC_STATUS                      0x1d
>> +#define TCPC_CC_STATUS_TOGGLING                BIT(5)
>>   #define TCPC_CC_STATUS_TERM           BIT(4)
>>   #define TCPC_CC_STATUS_CC2_SHIFT      2
>>   #define TCPC_CC_STATUS_CC2_MASK               0x3
>> diff --git a/drivers/staging/typec/tcpci_rt1711h.c
>> b/drivers/staging/typec/tcpci_rt1711h.c
>> new file mode 100644
>> index 000000000000..12afac363d6d
>> --- /dev/null
>> +++ b/drivers/staging/typec/tcpci_rt1711h.c
>> @@ -0,0 +1,329 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright (C) 2018, Richtek Technology Corporation
>> + *
>> + * Richtek RT1711H Type-C Chip Driver
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/i2c.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/usb/tcpm.h>
>> +#include <linux/regmap.h>
>> +#include "tcpci.h"
>> +
>> +#define RT1711H_RTCTRL8                0x9B
>> +
>> +/* Autoidle timeout =3D (tout * 2 + 1) * 6.4ms */
>> +#define RT1711H_RTCTRL8_SET(ck300, ship_off, auto_idle, tout) \
>> +                           (((ck300) << 7) | ((ship_off) << 5) | \
>> +                           ((auto_idle) << 3) | ((tout) & 0x07))
>> +
>> +#define RT1711H_RTCTRL11       0x9E
>> +
>> +/* I2C timeout =3D (tout + 1) * 12.5ms */
>> +#define RT1711H_RTCTRL11_SET(en, tout) \
>> +                            (((en) << 7) | ((tout) & 0x0F))
>> +
>> +#define RT1711H_RTCTRL13       0xA0
>> +#define RT1711H_RTCTRL14       0xA1
>> +#define RT1711H_RTCTRL15       0xA2
>> +#define RT1711H_RTCTRL16       0xA3
>> +
>> +struct rt1711h_chip {
>> +       struct tcpci_data data;
>> +       struct tcpci *tcpci;
>> +       struct device *dev;
>> +       int irq;
>> +};
>> +
>> +static int rt1711h_read16(struct rt1711h_chip *chip, unsigned int reg,
>> u16 *val)
>> +{
>> +       return regmap_raw_read(chip->data.regmap, reg, val, sizeof(u16))=
;
>> +}
>> +
>> +static int rt1711h_write16(struct rt1711h_chip *chip, unsigned int reg,
>> u16 val)
>> +{
>> +       return regmap_raw_write(chip->data.regmap, reg, &val,
>> sizeof(u16));
>> +}
>> +
>> +static int rt1711h_read8(struct rt1711h_chip *chip, unsigned int reg, u=
8
>> *val)
>> +{
>> +       return regmap_raw_read(chip->data.regmap, reg, val, sizeof(u8));
>> +}
>> +
>> +static int rt1711h_write8(struct rt1711h_chip *chip, unsigned int reg, =
u8
>> val)
>> +{
>> +       return regmap_raw_write(chip->data.regmap, reg, &val, sizeof(u8)=
);
>> +}
>> +
>> +static const struct regmap_config rt1711h_regmap_config =3D {
>> +       .reg_bits =3D 8,
>> +       .val_bits =3D 8,
>> +
>> +       .max_register =3D 0xFF, /* 0x80 .. 0xFF are vendor defined */
>> +};
>> +
>> +static struct rt1711h_chip *tdata_to_rt1711h(struct tcpci_data *tdata)
>> +{
>> +       return container_of(tdata, struct rt1711h_chip, data);
>> +}
>> +
>> +static int rt1711h_init(struct tcpci *tcpci, struct tcpci_data *tdata)
>> +{
>> +       int ret;
>> +       struct rt1711h_chip *chip =3D tdata_to_rt1711h(tdata);
>> +
>> +       /* CK 300K from 320K, shipping off, auto_idle enable, tout =3D 3=
2ms
>> */
>> +       ret =3D rt1711h_write8(chip, RT1711H_RTCTRL8,
>> +                            RT1711H_RTCTRL8_SET(0, 1, 1, 2));
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       /* I2C reset : (val + 1) * 12.5ms */
>> +       ret =3D rt1711h_write8(chip, RT1711H_RTCTRL11,
>> +                            RT1711H_RTCTRL11_SET(1, 0x0F));
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       /* tTCPCfilter : (26.7 * val) us */
>> +       ret =3D rt1711h_write8(chip, RT1711H_RTCTRL14, 0x0F);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       /*  tDRP : (51.2 + 6.4 * val) ms */
>> +       ret =3D rt1711h_write8(chip, RT1711H_RTCTRL15, 0x04);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       /* dcSRC.DRP : 33% */
>> +       return rt1711h_write16(chip, RT1711H_RTCTRL16, 330);
>> +}
>> +
>> +static int rt1711h_set_vconn(struct tcpci *tcpci, struct tcpci_data
>> *tdata,
>> +                            bool enable)
>> +{
>> +       struct rt1711h_chip *chip =3D tdata_to_rt1711h(tdata);
>> +
>> +       return rt1711h_write8(chip, RT1711H_RTCTRL8,
>> +                             RT1711H_RTCTRL8_SET(0, 1, enable ? 0 : 1,
>> 2));
>> +}
>> +
>> +static int rt1711h_start_drp_toggling(struct tcpci *tcpci,
>> +                                     struct tcpci_data *tdata,
>> +                                     enum typec_cc_status cc)
>> +{
>> +       struct rt1711h_chip *chip =3D tdata_to_rt1711h(tdata);
>> +       int ret;
>> +       unsigned int reg =3D 0;
>> +
>> +       switch (cc) {
>> +       default:
>> +       case TYPEC_CC_RP_DEF:
>> +               reg |=3D (TCPC_ROLE_CTRL_RP_VAL_DEF <<
>> +                       TCPC_ROLE_CTRL_RP_VAL_SHIFT);
>> +               break;
>> +       case TYPEC_CC_RP_1_5:
>> +               reg |=3D (TCPC_ROLE_CTRL_RP_VAL_1_5 <<
>> +                       TCPC_ROLE_CTRL_RP_VAL_SHIFT);
>> +               break;
>> +       case TYPEC_CC_RP_3_0:
>> +               reg |=3D (TCPC_ROLE_CTRL_RP_VAL_3_0 <<
>> +                       TCPC_ROLE_CTRL_RP_VAL_SHIFT);
>> +               break;
>> +       }
>> +
>> +       if (cc =3D=3D TYPEC_CC_RD)
>> +               reg |=3D (TCPC_ROLE_CTRL_CC_RD << TCPC_ROLE_CTRL_CC1_SHI=
FT)
>> |
>> +                          (TCPC_ROLE_CTRL_CC_RD <<
>> TCPC_ROLE_CTRL_CC2_SHIFT);
>> +       else
>> +               reg |=3D (TCPC_ROLE_CTRL_CC_RP << TCPC_ROLE_CTRL_CC1_SHI=
FT)
>> |
>> +                          (TCPC_ROLE_CTRL_CC_RP <<
>> TCPC_ROLE_CTRL_CC2_SHIFT);
>> +
>> +       ret =3D rt1711h_write8(chip, TCPC_ROLE_CTRL, reg);
>> +       if (ret < 0)
>> +               return ret;
>> +       usleep_range(500, 1000);
>> +
>> +       return 0;
>> +}
>> +
>> +static irqreturn_t rt1711h_irq(int irq, void *dev_id)
>> +{
>> +       int ret;
>> +       u16 alert;
>> +       u8 status;
>> +       struct rt1711h_chip *chip =3D dev_id;
>> +
>> +       if (!chip->tcpci)
>> +               return IRQ_HANDLED;
>> +
>> +       ret =3D rt1711h_read16(chip, TCPC_ALERT, &alert);
>> +       if (ret < 0)
>> +               goto out;
>> +
>> +       if (alert & TCPC_ALERT_CC_STATUS) {
>> +               ret =3D rt1711h_read8(chip, TCPC_CC_STATUS, &status);
>> +               if (ret < 0)
>> +                       goto out;
>> +               /* Clear cc change event triggered by starting toggling =
*/
>> +               if (status & TCPC_CC_STATUS_TOGGLING)
>> +                       rt1711h_write8(chip, TCPC_ALERT,
>> TCPC_ALERT_CC_STATUS);
>> +       }
>> +
>> +out:
>> +       return tcpci_irq(chip->tcpci);
>> +}
>> +
>> +static int rt1711h_init_gpio(struct rt1711h_chip *chip)
>> +{
>> +       struct gpio_desc *gpio;
>> +
>> +       gpio =3D devm_gpiod_get(chip->dev, "rt,intr", GPIOD_IN);
>> +       if (IS_ERR(gpio))
>> +               return PTR_ERR(gpio);
>> +
>> +       chip->irq =3D gpiod_to_irq(gpio);
>> +       if (chip->irq < 0)
>> +               return chip->irq;
>> +       return 0;
>> +}
>> +
>> +static int rt1711h_init_alert(struct rt1711h_chip *chip)
>> +{
>> +       int ret;
>> +
>> +       /* Disable chip interrupts before requesting irq */
>> +       ret =3D rt1711h_write16(chip, TCPC_ALERT_MASK, 0);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       if (!chip->irq) {
>> +               ret =3D rt1711h_init_gpio(chip);
>> +               if (ret < 0)
>> +                       return ret;
>> +       }
>> +       ret =3D devm_request_threaded_irq(chip->dev, chip->irq, NULL,
>> +                                       rt1711h_irq,
>> +                                       IRQF_ONESHOT | IRQF_TRIGGER_LOW,
>> +                                       dev_name(chip->dev), chip);
>> +       if (ret < 0)
>> +               return ret;
>> +       enable_irq_wake(chip->irq);
>> +       return 0;
>> +}
>> +
>> +static int rt1711h_sw_reset(struct rt1711h_chip *chip)
>> +{
>> +       int ret;
>> +
>> +       ret =3D rt1711h_write8(chip, RT1711H_RTCTRL13, 0x01);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       usleep_range(1000, 2000);
>> +       return 0;
>> +}
>> +
>> +static int rt1711h_check_revision(struct i2c_client *i2c)
>> +{
>> +       int ret;
>> +
>> +       ret =3D i2c_smbus_read_word_data(i2c, TCPC_VENDOR_ID);
>> +       if (ret < 0)
>> +               return ret;
>> +       if (ret !=3D 0x29cf) {
>> +               dev_err(&i2c->dev, "vid is not correct, 0x%04x\n", ret);
>> +               return -ENODEV;
>> +       }
>> +       ret =3D i2c_smbus_read_word_data(i2c, TCPC_PRODUCT_ID);
>> +       if (ret < 0)
>> +               return ret;
>> +       if (ret !=3D 0x1711) {
>> +               dev_err(&i2c->dev, "pid is not correct, 0x%04x\n", ret);
>> +               return -ENODEV;
>> +       }
>> +       return 0;
>> +}
>> +
>> +static int rt1711h_probe(struct i2c_client *client,
>> +                        const struct i2c_device_id *i2c_id)
>> +{
>> +       int ret;
>> +       struct rt1711h_chip *chip;
>> +
>> +       ret =3D rt1711h_check_revision(client);
>> +       if (ret < 0) {
>> +               dev_err(&client->dev, "check vid/pid fail\n");
>> +               return ret;
>> +       }
>> +
>> +       chip =3D devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
>> +       if (!chip)
>> +               return -ENOMEM;
>> +
>> +       chip->data.regmap =3D devm_regmap_init_i2c(client,
>> +                                                &rt1711h_regmap_config)=
;
>> +       if (IS_ERR(chip->data.regmap))
>> +               return PTR_ERR(chip->data.regmap);
>> +
>> +       chip->irq =3D client->irq;
>> +       chip->dev =3D &client->dev;
>> +       i2c_set_clientdata(client, chip);
>> +
>> +       ret =3D rt1711h_sw_reset(chip);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       ret =3D rt1711h_init_alert(chip);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       chip->data.init =3D rt1711h_init;
>> +       chip->data.set_vconn =3D rt1711h_set_vconn;
>> +       chip->data.start_drp_toggling =3D rt1711h_start_drp_toggling;
>> +       chip->tcpci =3D tcpci_register_port(chip->dev, &chip->data);
>> +       if (IS_ERR_OR_NULL(chip->tcpci))
>> +               return PTR_ERR(chip->tcpci);
>> +
>> +       return 0;
>> +}
>> +
>> +static int rt1711h_remove(struct i2c_client *client)
>> +{
>> +       struct rt1711h_chip *chip =3D i2c_get_clientdata(client);
>> +
>> +       tcpci_unregister_port(chip->tcpci);
>> +       return 0;
>> +}
>> +
>> +static const struct i2c_device_id rt1711h_id[] =3D {
>> +       { "rt1711h", 0 },
>> +       { }
>> +};
>> +MODULE_DEVICE_TABLE(i2c, rt1711h_id);
>> +
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id rt1711h_of_match[] =3D {
>> +       { .compatible =3D "richtek,rt1711h", },
>> +       {},
>> +};
>> +MODULE_DEVICE_TABLE(of, rt1711h_of_match);
>> +#endif
>> +
>> +static struct i2c_driver rt1711h_i2c_driver =3D {
>> +       .driver =3D {
>> +               .name =3D "rt1711h",
>> +               .of_match_table =3D of_match_ptr(rt1711h_of_match),
>> +       },
>> +       .probe =3D rt1711h_probe,
>> +       .remove =3D rt1711h_remove,
>> +       .id_table =3D rt1711h_id,
>> +};
>> +module_i2c_driver(rt1711h_i2c_driver);
>> +
>> +MODULE_AUTHOR("ShuFan Lee <shufan_lee@richtek.com>");
>> +MODULE_DESCRIPTION("RT1711H USB Type-C Port Controller Interface
>> Driver");
>> +MODULE_LICENSE("GPL");
>>
>



--=20
Best Regards,
=E6=9B=B8=E5=B8=86
