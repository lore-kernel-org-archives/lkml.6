Return-Path: <groeck7@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-3230508-1521476783-2-14438404500117976271
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_ENVFROM_END_DIGIT 0.25,
  FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.160.65', Host='mail-pl0-f65.google.com', Country='US',
  FromHeader='net', MailFrom='com'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: groeck7@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521476782; b=uFcL9AqBp3tF3mV+fxz7AxvwR+KCW1A2nQpkUX7EbO16m1+
    0uEcQZLtySfQeK6z5CLaGwxsN+6tgOO+T+dF8AJ5lYIdhrM0kMCFXCTW3lL7RkgU
    4xfDivOtMNJrb6bmwLNnILOlKd06NbyylrFPxlzzWLop/DcjfT66gixEdDLWJhln
    w3CCdeaGym42ImXp2MtxsTA3xyZH4SWAgLTpocmVF4Bzw4O/OQgXiyG3C8G0u7DH
    91z9zJhfKZ1J5DxBBA774enVdMPJSvyDuFj7KbKJ5D2eJOQpXAkPMBYM2DQqxa+W
    IuZjWw8MXTL+6EKiFES6Ao/Hq49SnTG4/AwIw6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=sender:date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=arctest; t=
    1521476782; bh=baUGE+5kzEblCS6GWBB0adBLDV+GB7Zx8mEdUXqId2k=; b=a
    Xh10wmI5uFNYfrMIgLP6HuHHsRStc0t6+WZ7IwQffcBt4FV8zcnVegijeiWFW1C1
    tjxNijjU5TWU6abBoQXoYxHspH6dTvrqx0pY3zltwiSLwFS9IpDWNBMG3umBDq9J
    MoixieHLITSv86QsacWTkKydTUeYn4yqPfQnvTg5x6DkYTeYspbdQylDaYrmr/Fz
    RdmMCCd/xr9o+4mwzfvSguA1R9xSRD2sACPuH0j0HWeV6wyAvY5esr3uaMq/10yH
    byzhqKOHA41Gnbe3zt+UY8jmn5RG56GIA43Ck/SBBvcbN9wHrKUKMQ6OyTF7rPHs
    yKa4tSudOWrqe0NPkrYEg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=u82aNtYy x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.85.160.65 (mail-pl0-f65.google.com);
    spf=pass smtp.mailfrom=groeck7@gmail.com smtp.helo=mail-pl0-f65.google.com;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekjeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucenucfjughrpehsfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhuvghnthgvrhcutfhovggtkhcuoehlihhnuhigsehrohgvtghkqdhushdrnhgvtheqnecukfhppedvtdelrdekhedrudeitddrieehpddutdekrddvvdefrdegtddrieeinecurfgrrhgrmhepihhnvghtpedvtdelrdekhedrudeitddrieehpdhhvghlohepmhgrihhlqdhplhdtqdhfieehrdhgohhoghhlvgdrtghomhdpmhgrihhlfhhrohhmpeeoghhrohgvtghkjeesghhmrghilhdrtghomhequcfukfgkgfepudegkedutdenucevlhhushhtvghrufhiiigvpedt;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KdWmHylq;
    x-ptr=pass x-ptr-helo=mail-pl0-f65.google.com x-ptr-lookup=mail-pl0-f65.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=u82aNtYy x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.85.160.65 (mail-pl0-f65.google.com);
    spf=pass smtp.mailfrom=groeck7@gmail.com smtp.helo=mail-pl0-f65.google.com;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekjeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucenucfjughrpehsfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhuvghnthgvrhcutfhovggtkhcuoehlihhnuhigsehrohgvtghkqdhushdrnhgvtheqnecukfhppedvtdelrdekhedrudeitddrieehpddutdekrddvvdefrdegtddrieeinecurfgrrhgrmhepihhnvghtpedvtdelrdekhedrudeitddrieehpdhhvghlohepmhgrihhlqdhplhdtqdhfieehrdhgohhoghhlvgdrtghomhdpmhgrihhlfhhrohhmpeeoghhrohgvtghkjeesghhmrghilhdrtghomhequcfukfgkgfepudegkedutdenucevlhhushhtvghrufhiiigvpedt;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KdWmHylq;
    x-ptr=pass x-ptr-helo=mail-pl0-f65.google.com x-ptr-lookup=mail-pl0-f65.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AG47ELubWIIOWLWRQmzQtz82h12qYoCBLUje2x8QCZqW7R4fbjS48OCgICFNLDMHmSrOw6YXS3CCzQ==
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 19 Mar 2018 09:26:17 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: ShuFan Lee <leechu729@gmail.com>
Cc: greg@kroah.com, heikki.krogerus@linux.intel.com, shufan_lee@richtek.com,
	cy_huang@richtek.com, jun.li@nxp.com, mats.dev.list@gmail.com,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: typec: rt1711h typec chip driver
Message-ID: <20180319162617.GA17189@roeck-us.net>
References: <1521431375-23207-1-git-send-email-leechu729@gmail.com>
 <1521431375-23207-2-git-send-email-leechu729@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521431375-23207-2-git-send-email-leechu729@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 11:49:34AM +0800, ShuFan Lee wrote:
> From: ShuFan Lee <shufan_lee@richtek.com>
> 
> Richtek RT1711H Type-C chip driver that works with
> Type-C Port Controller Manager to provide USB PD and
> USB Type-C functionalities.
> Add definition of TCPC_CC_STATUS_TOGGLING.
> 
> Signed-off-by: ShuFan Lee <shufan_lee@richtek.com>

No additional feedback on top of Heikki's comments.

As we get more drivers, it might make sense to provide an
API function for rt1711h_check_revision(), or even have
tcpci_register_port() validate vendor and product IDs.
But I think for now we are good.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/staging/typec/Kconfig         |   8 +
>  drivers/staging/typec/Makefile        |   1 +
>  drivers/staging/typec/tcpci.h         |   1 +
>  drivers/staging/typec/tcpci_rt1711h.c | 329 ++++++++++++++++++++++++++++++++++
>  4 files changed, 339 insertions(+)
>  create mode 100644 drivers/staging/typec/tcpci_rt1711h.c
> 
>  changelogs between v1 and v2
>  - use gpiod_* instead of gpio_*
> 
> diff --git a/drivers/staging/typec/Kconfig b/drivers/staging/typec/Kconfig
> index 5359f556d203..3aa981fbc8f5 100644
> --- a/drivers/staging/typec/Kconfig
> +++ b/drivers/staging/typec/Kconfig
> @@ -9,6 +9,14 @@ config TYPEC_TCPCI
>  	help
>  	  Type-C Port Controller driver for TCPCI-compliant controller.
>  
> +config TYPEC_RT1711H
> +	tristate "Richtek RT1711H Type-C chip driver"
> +	select TYPEC_TCPCI
> +	help
> +	  Richtek RT1711H Type-C chip driver that works with
> +	  Type-C Port Controller Manager to provide USB PD and USB
> +	  Type-C functionalities.
> +
>  endif
>  
>  endmenu
> diff --git a/drivers/staging/typec/Makefile b/drivers/staging/typec/Makefile
> index 53d649abcb53..7803d485e1b3 100644
> --- a/drivers/staging/typec/Makefile
> +++ b/drivers/staging/typec/Makefile
> @@ -1 +1,2 @@
>  obj-$(CONFIG_TYPEC_TCPCI)	+= tcpci.o
> +obj-$(CONFIG_TYPEC_RT1711H)	+= tcpci_rt1711h.o
> diff --git a/drivers/staging/typec/tcpci.h b/drivers/staging/typec/tcpci.h
> index 34c865f0dcf6..303ebde26546 100644
> --- a/drivers/staging/typec/tcpci.h
> +++ b/drivers/staging/typec/tcpci.h
> @@ -59,6 +59,7 @@
>  #define TCPC_POWER_CTRL_VCONN_ENABLE	BIT(0)
>  
>  #define TCPC_CC_STATUS			0x1d
> +#define TCPC_CC_STATUS_TOGGLING		BIT(5)
>  #define TCPC_CC_STATUS_TERM		BIT(4)
>  #define TCPC_CC_STATUS_CC2_SHIFT	2
>  #define TCPC_CC_STATUS_CC2_MASK		0x3
> diff --git a/drivers/staging/typec/tcpci_rt1711h.c b/drivers/staging/typec/tcpci_rt1711h.c
> new file mode 100644
> index 000000000000..12afac363d6d
> --- /dev/null
> +++ b/drivers/staging/typec/tcpci_rt1711h.c
> @@ -0,0 +1,329 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2018, Richtek Technology Corporation
> + *
> + * Richtek RT1711H Type-C Chip Driver
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/usb/tcpm.h>
> +#include <linux/regmap.h>
> +#include "tcpci.h"
> +
> +#define RT1711H_RTCTRL8		0x9B
> +
> +/* Autoidle timeout = (tout * 2 + 1) * 6.4ms */
> +#define RT1711H_RTCTRL8_SET(ck300, ship_off, auto_idle, tout) \
> +			    (((ck300) << 7) | ((ship_off) << 5) | \
> +			    ((auto_idle) << 3) | ((tout) & 0x07))
> +
> +#define RT1711H_RTCTRL11	0x9E
> +
> +/* I2C timeout = (tout + 1) * 12.5ms */
> +#define RT1711H_RTCTRL11_SET(en, tout) \
> +			     (((en) << 7) | ((tout) & 0x0F))
> +
> +#define RT1711H_RTCTRL13	0xA0
> +#define RT1711H_RTCTRL14	0xA1
> +#define RT1711H_RTCTRL15	0xA2
> +#define RT1711H_RTCTRL16	0xA3
> +
> +struct rt1711h_chip {
> +	struct tcpci_data data;
> +	struct tcpci *tcpci;
> +	struct device *dev;
> +	int irq;
> +};
> +
> +static int rt1711h_read16(struct rt1711h_chip *chip, unsigned int reg, u16 *val)
> +{
> +	return regmap_raw_read(chip->data.regmap, reg, val, sizeof(u16));
> +}
> +
> +static int rt1711h_write16(struct rt1711h_chip *chip, unsigned int reg, u16 val)
> +{
> +	return regmap_raw_write(chip->data.regmap, reg, &val, sizeof(u16));
> +}
> +
> +static int rt1711h_read8(struct rt1711h_chip *chip, unsigned int reg, u8 *val)
> +{
> +	return regmap_raw_read(chip->data.regmap, reg, val, sizeof(u8));
> +}
> +
> +static int rt1711h_write8(struct rt1711h_chip *chip, unsigned int reg, u8 val)
> +{
> +	return regmap_raw_write(chip->data.regmap, reg, &val, sizeof(u8));
> +}
> +
> +static const struct regmap_config rt1711h_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +
> +	.max_register = 0xFF, /* 0x80 .. 0xFF are vendor defined */
> +};
> +
> +static struct rt1711h_chip *tdata_to_rt1711h(struct tcpci_data *tdata)
> +{
> +	return container_of(tdata, struct rt1711h_chip, data);
> +}
> +
> +static int rt1711h_init(struct tcpci *tcpci, struct tcpci_data *tdata)
> +{
> +	int ret;
> +	struct rt1711h_chip *chip = tdata_to_rt1711h(tdata);
> +
> +	/* CK 300K from 320K, shipping off, auto_idle enable, tout = 32ms */
> +	ret = rt1711h_write8(chip, RT1711H_RTCTRL8,
> +			     RT1711H_RTCTRL8_SET(0, 1, 1, 2));
> +	if (ret < 0)
> +		return ret;
> +
> +	/* I2C reset : (val + 1) * 12.5ms */
> +	ret = rt1711h_write8(chip, RT1711H_RTCTRL11,
> +			     RT1711H_RTCTRL11_SET(1, 0x0F));
> +	if (ret < 0)
> +		return ret;
> +
> +	/* tTCPCfilter : (26.7 * val) us */
> +	ret = rt1711h_write8(chip, RT1711H_RTCTRL14, 0x0F);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*  tDRP : (51.2 + 6.4 * val) ms */
> +	ret = rt1711h_write8(chip, RT1711H_RTCTRL15, 0x04);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* dcSRC.DRP : 33% */
> +	return rt1711h_write16(chip, RT1711H_RTCTRL16, 330);
> +}
> +
> +static int rt1711h_set_vconn(struct tcpci *tcpci, struct tcpci_data *tdata,
> +			     bool enable)
> +{
> +	struct rt1711h_chip *chip = tdata_to_rt1711h(tdata);
> +
> +	return rt1711h_write8(chip, RT1711H_RTCTRL8,
> +			      RT1711H_RTCTRL8_SET(0, 1, enable ? 0 : 1, 2));
> +}
> +
> +static int rt1711h_start_drp_toggling(struct tcpci *tcpci,
> +				      struct tcpci_data *tdata,
> +				      enum typec_cc_status cc)
> +{
> +	struct rt1711h_chip *chip = tdata_to_rt1711h(tdata);
> +	int ret;
> +	unsigned int reg = 0;
> +
> +	switch (cc) {
> +	default:
> +	case TYPEC_CC_RP_DEF:
> +		reg |= (TCPC_ROLE_CTRL_RP_VAL_DEF <<
> +			TCPC_ROLE_CTRL_RP_VAL_SHIFT);
> +		break;
> +	case TYPEC_CC_RP_1_5:
> +		reg |= (TCPC_ROLE_CTRL_RP_VAL_1_5 <<
> +			TCPC_ROLE_CTRL_RP_VAL_SHIFT);
> +		break;
> +	case TYPEC_CC_RP_3_0:
> +		reg |= (TCPC_ROLE_CTRL_RP_VAL_3_0 <<
> +			TCPC_ROLE_CTRL_RP_VAL_SHIFT);
> +		break;
> +	}
> +
> +	if (cc == TYPEC_CC_RD)
> +		reg |= (TCPC_ROLE_CTRL_CC_RD << TCPC_ROLE_CTRL_CC1_SHIFT) |
> +			   (TCPC_ROLE_CTRL_CC_RD << TCPC_ROLE_CTRL_CC2_SHIFT);
> +	else
> +		reg |= (TCPC_ROLE_CTRL_CC_RP << TCPC_ROLE_CTRL_CC1_SHIFT) |
> +			   (TCPC_ROLE_CTRL_CC_RP << TCPC_ROLE_CTRL_CC2_SHIFT);
> +
> +	ret = rt1711h_write8(chip, TCPC_ROLE_CTRL, reg);
> +	if (ret < 0)
> +		return ret;
> +	usleep_range(500, 1000);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t rt1711h_irq(int irq, void *dev_id)
> +{
> +	int ret;
> +	u16 alert;
> +	u8 status;
> +	struct rt1711h_chip *chip = dev_id;
> +
> +	if (!chip->tcpci)
> +		return IRQ_HANDLED;
> +
> +	ret = rt1711h_read16(chip, TCPC_ALERT, &alert);
> +	if (ret < 0)
> +		goto out;
> +
> +	if (alert & TCPC_ALERT_CC_STATUS) {
> +		ret = rt1711h_read8(chip, TCPC_CC_STATUS, &status);
> +		if (ret < 0)
> +			goto out;
> +		/* Clear cc change event triggered by starting toggling */
> +		if (status & TCPC_CC_STATUS_TOGGLING)
> +			rt1711h_write8(chip, TCPC_ALERT, TCPC_ALERT_CC_STATUS);
> +	}
> +
> +out:
> +	return tcpci_irq(chip->tcpci);
> +}
> +
> +static int rt1711h_init_gpio(struct rt1711h_chip *chip)
> +{
> +	struct gpio_desc *gpio;
> +
> +	gpio = devm_gpiod_get(chip->dev, "rt,intr", GPIOD_IN);
> +	if (IS_ERR(gpio))
> +		return PTR_ERR(gpio);
> +
> +	chip->irq = gpiod_to_irq(gpio);
> +	if (chip->irq < 0)
> +		return chip->irq;
> +	return 0;
> +}
> +
> +static int rt1711h_init_alert(struct rt1711h_chip *chip)
> +{
> +	int ret;
> +
> +	/* Disable chip interrupts before requesting irq */
> +	ret = rt1711h_write16(chip, TCPC_ALERT_MASK, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!chip->irq) {
> +		ret = rt1711h_init_gpio(chip);
> +		if (ret < 0)
> +			return ret;
> +	}
> +	ret = devm_request_threaded_irq(chip->dev, chip->irq, NULL,
> +					rt1711h_irq,
> +					IRQF_ONESHOT | IRQF_TRIGGER_LOW,
> +					dev_name(chip->dev), chip);
> +	if (ret < 0)
> +		return ret;
> +	enable_irq_wake(chip->irq);
> +	return 0;
> +}
> +
> +static int rt1711h_sw_reset(struct rt1711h_chip *chip)
> +{
> +	int ret;
> +
> +	ret = rt1711h_write8(chip, RT1711H_RTCTRL13, 0x01);
> +	if (ret < 0)
> +		return ret;
> +
> +	usleep_range(1000, 2000);
> +	return 0;
> +}
> +
> +static int rt1711h_check_revision(struct i2c_client *i2c)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_read_word_data(i2c, TCPC_VENDOR_ID);
> +	if (ret < 0)
> +		return ret;
> +	if (ret != 0x29cf) {
> +		dev_err(&i2c->dev, "vid is not correct, 0x%04x\n", ret);
> +		return -ENODEV;
> +	}
> +	ret = i2c_smbus_read_word_data(i2c, TCPC_PRODUCT_ID);
> +	if (ret < 0)
> +		return ret;
> +	if (ret != 0x1711) {
> +		dev_err(&i2c->dev, "pid is not correct, 0x%04x\n", ret);
> +		return -ENODEV;
> +	}
> +	return 0;
> +}
> +
> +static int rt1711h_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *i2c_id)
> +{
> +	int ret;
> +	struct rt1711h_chip *chip;
> +
> +	ret = rt1711h_check_revision(client);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "check vid/pid fail\n");
> +		return ret;
> +	}
> +
> +	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	chip->data.regmap = devm_regmap_init_i2c(client,
> +						 &rt1711h_regmap_config);
> +	if (IS_ERR(chip->data.regmap))
> +		return PTR_ERR(chip->data.regmap);
> +
> +	chip->irq = client->irq;
> +	chip->dev = &client->dev;
> +	i2c_set_clientdata(client, chip);
> +
> +	ret = rt1711h_sw_reset(chip);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = rt1711h_init_alert(chip);
> +	if (ret < 0)
> +		return ret;
> +
> +	chip->data.init = rt1711h_init;
> +	chip->data.set_vconn = rt1711h_set_vconn;
> +	chip->data.start_drp_toggling = rt1711h_start_drp_toggling;
> +	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
> +	if (IS_ERR_OR_NULL(chip->tcpci))
> +		return PTR_ERR(chip->tcpci);
> +
> +	return 0;
> +}
> +
> +static int rt1711h_remove(struct i2c_client *client)
> +{
> +	struct rt1711h_chip *chip = i2c_get_clientdata(client);
> +
> +	tcpci_unregister_port(chip->tcpci);
> +	return 0;
> +}
> +
> +static const struct i2c_device_id rt1711h_id[] = {
> +	{ "rt1711h", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, rt1711h_id);
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id rt1711h_of_match[] = {
> +	{ .compatible = "richtek,rt1711h", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, rt1711h_of_match);
> +#endif
> +
> +static struct i2c_driver rt1711h_i2c_driver = {
> +	.driver = {
> +		.name = "rt1711h",
> +		.of_match_table = of_match_ptr(rt1711h_of_match),
> +	},
> +	.probe = rt1711h_probe,
> +	.remove = rt1711h_remove,
> +	.id_table = rt1711h_id,
> +};
> +module_i2c_driver(rt1711h_i2c_driver);
> +
> +MODULE_AUTHOR("ShuFan Lee <shufan_lee@richtek.com>");
> +MODULE_DESCRIPTION("RT1711H USB Type-C Port Controller Interface Driver");
> +MODULE_LICENSE("GPL");
> -- 
> 1.9.1
> 
