Return-Path: <groeck7@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-1013802-1520616183-2-7787424394078719512
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_ENVFROM_END_DIGIT 0.25,
  FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES roenca, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='74.125.82.195', Host='mail-ot0-f195.google.com', Country='US',
  FromHeader='net', MailFrom='com'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: groeck7@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520616182; b=j+zbGw8F7wYLgtRztgyjwZ0rIv79gDxapXkIf812XUIj6Pg
    Gupen8fc6BFrt0k4vjTlI8346IJV67Odz2xBAvR1OJHhGIwZNTkDMWYYNc+whJfo
    I2aU5PTiwzc/BVN/7r7mP/uab8hnqOCm3yGnQQoBYLI58Ih1bhRvZSRNWUEt12nW
    xjNXlwOvnSdegrJhAJQKqooyhYLqeH/m212xYp4E3uuGjBKkvb+gQ58/j90goNBj
    1xaDX0sgGmY2NKXVuWJexTe027SDO8r1VkeSmOvQ8pFKS99rhk8AWIZYkwoUGc/M
    VvpgKYhmeofFqgYPoXJVrbbWmTUCsvGaeBItSVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=sender:date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=arctest; t=
    1520616182; bh=tET9gl2yh1C8I6Szk7Y8Lz8wBSL++kFieq9jfChlPkE=; b=Z
    1V8OSB63EB4W0tb3TphiUkSXxmmP/9ZMJGiPScWfVSZnYXXjm7z6YHhmYckYZVXM
    TkrV3NgOaVMDTl9hiJmv530HULEZv0MNOgk9+z3bGU7EuxqWij4v7xe5PG1Q61a/
    Y59c5Lusx6s2ZYv7qeCb4vdwxUS0RI0jwZe224rvcMNBUiurTuk0q/5dP8JT8N+k
    wnbqTaPmZZ6plgSeL/3nuuMlW56vL6cwWM8Hi6HOgUtYsvhV0cWWY0/CMdenxqZj
    fEwLX/1nbo4JKozDsGVdxFxHBpqZviErxfIpyZfXyNHp7xDnyFyEEQfQToeEcaPb
    RM59vnC1q6LO9yjj/BvjQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=iFr8OvLb x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=74.125.82.195 (mail-ot0-f195.google.com);
    spf=pass smtp.mailfrom=groeck7@gmail.com smtp.helo=mail-ot0-f195.google.com;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AaAjKsH3;
    x-ptr=pass x-ptr-helo=mail-ot0-f195.google.com x-ptr-lookup=mail-ot0-f195.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=iFr8OvLb x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=74.125.82.195 (mail-ot0-f195.google.com);
    spf=pass smtp.mailfrom=groeck7@gmail.com smtp.helo=mail-ot0-f195.google.com;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AaAjKsH3;
    x-ptr=pass x-ptr-helo=mail-ot0-f195.google.com x-ptr-lookup=mail-ot0-f195.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AG47ELud5tsi11XwozLXY0h5sUz4nz4g+crdbpylMCuQMm2U0YwIMxsWjPgvHhRaLILSHlEGxRo/KQ==
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 9 Mar 2018 09:22:57 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: ShuFan Lee <leechu729@gmail.com>
Cc: heikki.krogerus@linux.intel.com, greg@kroah.com, shufan_lee@richtek.com,
	cy_huang@richtek.com, jun.li@nxp.com, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH v7] staging: typec: handle vendor defined part and modify
 drp toggling flow
Message-ID: <20180309172257.GA9949@roeck-us.net>
References: <1520301032-10109-1-git-send-email-leechu729@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520301032-10109-1-git-send-email-leechu729@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 06, 2018 at 09:50:32AM +0800, ShuFan Lee wrote:
> From: ShuFan Lee <shufan_lee@richtek.com>
> 
> Handle vendor defined behavior in tcpci_init, tcpci_set_vconn, tcpci_start_drp_toggling
> and export tcpci_irq. More operations can be extended in tcpci_data if needed.
> According to TCPCI specification, 4.4.5.2 ROLE_CONTROL,
> TCPC shall not start DRP toggling until subsequently the TCPM
> writes to the COMMAND register to start DRP toggling.
> DRP toggling flow is changed as following:
>   - Write DRP = 1, Rp level and RC.CCx to Rd/Rd or Rp/Rp
>   - Set LOOK4CONNECTION command
> 
> Signed-off-by: ShuFan Lee <shufan_lee@richtek.com>

I am fine with this version.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/staging/typec/tcpci.c | 127 +++++++++++++++++++++++++++++++++---------
>  drivers/staging/typec/tcpci.h |  15 +++++
>  2 files changed, 116 insertions(+), 26 deletions(-)
> 
>  patch changelogs between v1 & v2
>  - Remove unnecessary i2c_client in the structure of tcpci.
>  - Rename structure of tcpci_vendor_data to tcpci_data.
>  - Not exporting tcpci read/write wrappers but register i2c regmap in glue driver.
>  - Add set_vconn ops in tcpci_data.
>    (It is necessary for RT1711H to enable/disable idle mode before disabling/enabling vconn)
>  - Export tcpci_irq so that vendor can call it in their own IRQ handler.
> 
>  patch changelogs between v2 & v3
>  - Change the return type of tcpci_irq from int to irqreturn_t.
> 
>  patch changelogs between v3 & v4
>  - Directly return regmap_write at the end of drp_toggling function.
>  - Because tcpci_irq is called in _tcpci_irq, move _tcpci_irq to the place after tcpci_irq.
> 
>  patch changelogs between v4 & v5
>  - Add a space between my first & last name, from ShuFanLee to ShuFan Lee.
> 
>  patch changelogs between v5 & v6
>  - Add start_drp_toggling in tcpci_data and call it at the beginning of tcpci_start_drp_toggling.
>  - Modify the flow of tcpci_start_drp_toggling as following:
>     - Set Rp level, RC.CCx to Rd/Rd or Rp/Rp and DRP = 1
>     - Set LOOK4CONNECTION command
> 
>  patch changelogs between v6 & v7
>  - Remove checking whether tcpci->data is NULL because it is guaranteed to be available.
> 
> diff --git a/drivers/staging/typec/tcpci.c b/drivers/staging/typec/tcpci.c
> index 9bd4412..8043740 100644
> --- a/drivers/staging/typec/tcpci.c
> +++ b/drivers/staging/typec/tcpci.c
> @@ -21,7 +21,6 @@
>  
>  struct tcpci {
>  	struct device *dev;
> -	struct i2c_client *client;
>  
>  	struct tcpm_port *port;
>  
> @@ -30,6 +29,12 @@ struct tcpci {
>  	bool controls_vbus;
>  
>  	struct tcpc_dev tcpc;
> +	struct tcpci_data *data;
> +};
> +
> +struct tcpci_chip {
> +	struct tcpci *tcpci;
> +	struct tcpci_data data;
>  };
>  
>  static inline struct tcpci *tcpc_to_tcpci(struct tcpc_dev *tcpc)
> @@ -37,8 +42,7 @@ static inline struct tcpci *tcpc_to_tcpci(struct tcpc_dev *tcpc)
>  	return container_of(tcpc, struct tcpci, tcpc);
>  }
>  
> -static int tcpci_read16(struct tcpci *tcpci, unsigned int reg,
> -			u16 *val)
> +static int tcpci_read16(struct tcpci *tcpci, unsigned int reg, u16 *val)
>  {
>  	return regmap_raw_read(tcpci->regmap, reg, val, sizeof(u16));
>  }
> @@ -98,9 +102,17 @@ static int tcpci_set_cc(struct tcpc_dev *tcpc, enum typec_cc_status cc)
>  static int tcpci_start_drp_toggling(struct tcpc_dev *tcpc,
>  				    enum typec_cc_status cc)
>  {
> +	int ret;
>  	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
>  	unsigned int reg = TCPC_ROLE_CTRL_DRP;
>  
> +	/* Handle vendor drp toggling */
> +	if (tcpci->data->start_drp_toggling) {
> +		ret = tcpci->data->start_drp_toggling(tcpci, tcpci->data, cc);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	switch (cc) {
>  	default:
>  	case TYPEC_CC_RP_DEF:
> @@ -117,7 +129,17 @@ static int tcpci_start_drp_toggling(struct tcpc_dev *tcpc,
>  		break;
>  	}
>  
> -	return regmap_write(tcpci->regmap, TCPC_ROLE_CTRL, reg);
> +	if (cc == TYPEC_CC_RD)
> +		reg |= (TCPC_ROLE_CTRL_CC_RD << TCPC_ROLE_CTRL_CC1_SHIFT) |
> +			   (TCPC_ROLE_CTRL_CC_RD << TCPC_ROLE_CTRL_CC2_SHIFT);
> +	else
> +		reg |= (TCPC_ROLE_CTRL_CC_RP << TCPC_ROLE_CTRL_CC1_SHIFT) |
> +			   (TCPC_ROLE_CTRL_CC_RP << TCPC_ROLE_CTRL_CC2_SHIFT);
> +	ret = regmap_write(tcpci->regmap, TCPC_ROLE_CTRL, reg);
> +	if (ret < 0)
> +		return ret;
> +	return regmap_write(tcpci->regmap, TCPC_COMMAND,
> +			    TCPC_CMD_LOOK4CONNECTION);
>  }
>  
>  static enum typec_cc_status tcpci_to_typec_cc(unsigned int cc, bool sink)
> @@ -178,6 +200,13 @@ static int tcpci_set_vconn(struct tcpc_dev *tcpc, bool enable)
>  	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
>  	int ret;
>  
> +	/* Handle vendor set vconn */
> +	if (tcpci->data->set_vconn) {
> +		ret = tcpci->data->set_vconn(tcpci, tcpci->data, enable);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	ret = regmap_write(tcpci->regmap, TCPC_POWER_CTRL,
>  			   enable ? TCPC_POWER_CTRL_VCONN_ENABLE : 0);
>  	if (ret < 0)
> @@ -323,6 +352,13 @@ static int tcpci_init(struct tcpc_dev *tcpc)
>  	if (time_after(jiffies, timeout))
>  		return -ETIMEDOUT;
>  
> +	/* Handle vendor init */
> +	if (tcpci->data->init) {
> +		ret = tcpci->data->init(tcpci, tcpci->data);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	/* Clear all events */
>  	ret = tcpci_write16(tcpci, TCPC_ALERT, 0xffff);
>  	if (ret < 0)
> @@ -344,9 +380,8 @@ static int tcpci_init(struct tcpc_dev *tcpc)
>  	return tcpci_write16(tcpci, TCPC_ALERT_MASK, reg);
>  }
>  
> -static irqreturn_t tcpci_irq(int irq, void *dev_id)
> +irqreturn_t tcpci_irq(struct tcpci *tcpci)
>  {
> -	struct tcpci *tcpci = dev_id;
>  	u16 status;
>  
>  	tcpci_read16(tcpci, TCPC_ALERT, &status);
> @@ -412,6 +447,14 @@ static irqreturn_t tcpci_irq(int irq, void *dev_id)
>  
>  	return IRQ_HANDLED;
>  }
> +EXPORT_SYMBOL_GPL(tcpci_irq);
> +
> +static irqreturn_t _tcpci_irq(int irq, void *dev_id)
> +{
> +	struct tcpci *tcpci = dev_id;
> +
> +	return tcpci_irq(tcpci);
> +}
>  
>  static const struct regmap_config tcpci_regmap_config = {
>  	.reg_bits = 8,
> @@ -435,22 +478,18 @@ static int tcpci_parse_config(struct tcpci *tcpci)
>  	return 0;
>  }
>  
> -static int tcpci_probe(struct i2c_client *client,
> -		       const struct i2c_device_id *i2c_id)
> +struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
>  {
>  	struct tcpci *tcpci;
>  	int err;
>  
> -	tcpci = devm_kzalloc(&client->dev, sizeof(*tcpci), GFP_KERNEL);
> +	tcpci = devm_kzalloc(dev, sizeof(*tcpci), GFP_KERNEL);
>  	if (!tcpci)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
>  
> -	tcpci->client = client;
> -	tcpci->dev = &client->dev;
> -	i2c_set_clientdata(client, tcpci);
> -	tcpci->regmap = devm_regmap_init_i2c(client, &tcpci_regmap_config);
> -	if (IS_ERR(tcpci->regmap))
> -		return PTR_ERR(tcpci->regmap);
> +	tcpci->dev = dev;
> +	tcpci->data = data;
> +	tcpci->regmap = data->regmap;
>  
>  	tcpci->tcpc.init = tcpci_init;
>  	tcpci->tcpc.get_vbus = tcpci_get_vbus;
> @@ -467,27 +506,63 @@ static int tcpci_probe(struct i2c_client *client,
>  
>  	err = tcpci_parse_config(tcpci);
>  	if (err < 0)
> -		return err;
> +		return ERR_PTR(err);
> +
> +	tcpci->port = tcpm_register_port(tcpci->dev, &tcpci->tcpc);
> +	if (PTR_ERR_OR_ZERO(tcpci->port))
> +		return ERR_CAST(tcpci->port);
> +
> +	return tcpci;
> +}
> +EXPORT_SYMBOL_GPL(tcpci_register_port);
> +
> +void tcpci_unregister_port(struct tcpci *tcpci)
> +{
> +	tcpm_unregister_port(tcpci->port);
> +}
> +EXPORT_SYMBOL_GPL(tcpci_unregister_port);
> +
> +static int tcpci_probe(struct i2c_client *client,
> +		       const struct i2c_device_id *i2c_id)
> +{
> +	struct tcpci_chip *chip;
> +	int err;
> +	u16 val = 0;
>  
> -	/* Disable chip interrupts */
> -	tcpci_write16(tcpci, TCPC_ALERT_MASK, 0);
> +	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	chip->data.regmap = devm_regmap_init_i2c(client, &tcpci_regmap_config);
> +	if (IS_ERR(chip->data.regmap))
> +		return PTR_ERR(chip->data.regmap);
>  
> -	err = devm_request_threaded_irq(tcpci->dev, client->irq, NULL,
> -					tcpci_irq,
> +	/* Disable chip interrupts before requesting irq */
> +	err = regmap_raw_write(chip->data.regmap, TCPC_ALERT_MASK, &val,
> +			       sizeof(u16));
> +	if (err < 0)
> +		return err;
> +
> +	err = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> +					_tcpci_irq,
>  					IRQF_ONESHOT | IRQF_TRIGGER_LOW,
> -					dev_name(tcpci->dev), tcpci);
> +					dev_name(&client->dev), chip);
>  	if (err < 0)
>  		return err;
>  
> -	tcpci->port = tcpm_register_port(tcpci->dev, &tcpci->tcpc);
> -	return PTR_ERR_OR_ZERO(tcpci->port);
> +	chip->tcpci = tcpci_register_port(&client->dev, &chip->data);
> +	if (PTR_ERR_OR_ZERO(chip->tcpci))
> +		return PTR_ERR(chip->tcpci);
> +
> +	i2c_set_clientdata(client, chip);
> +	return 0;
>  }
>  
>  static int tcpci_remove(struct i2c_client *client)
>  {
> -	struct tcpci *tcpci = i2c_get_clientdata(client);
> +	struct tcpci_chip *chip = i2c_get_clientdata(client);
>  
> -	tcpm_unregister_port(tcpci->port);
> +	tcpci_unregister_port(chip->tcpci);
>  
>  	return 0;
>  }
> diff --git a/drivers/staging/typec/tcpci.h b/drivers/staging/typec/tcpci.h
> index fdfb06c..a2c1754 100644
> --- a/drivers/staging/typec/tcpci.h
> +++ b/drivers/staging/typec/tcpci.h
> @@ -59,6 +59,7 @@
>  #define TCPC_POWER_CTRL_VCONN_ENABLE	BIT(0)
>  
>  #define TCPC_CC_STATUS			0x1d
> +#define TCPC_CC_STATUS_DRPRST		BIT(5)
>  #define TCPC_CC_STATUS_TERM		BIT(4)
>  #define TCPC_CC_STATUS_CC2_SHIFT	2
>  #define TCPC_CC_STATUS_CC2_MASK		0x3
> @@ -121,4 +122,18 @@
>  #define TCPC_VBUS_VOLTAGE_ALARM_HI_CFG		0x76
>  #define TCPC_VBUS_VOLTAGE_ALARM_LO_CFG		0x78
>  
> +struct tcpci;
> +struct tcpci_data {
> +	struct regmap *regmap;
> +	int (*init)(struct tcpci *tcpci, struct tcpci_data *data);
> +	int (*set_vconn)(struct tcpci *tcpci, struct tcpci_data *data,
> +			 bool enable);
> +	int (*start_drp_toggling)(struct tcpci *tcpci, struct tcpci_data *data,
> +				  enum typec_cc_status cc);
> +};
> +
> +struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data);
> +void tcpci_unregister_port(struct tcpci *tcpci);
> +irqreturn_t tcpci_irq(struct tcpci *tcpci);
> +
>  #endif /* __LINUX_USB_TCPCI_H */
> -- 
> 1.9.1
> 
