Return-Path: <leechu729@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-1701872-1519223458-2-6261252841324435240
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_ENVFROM_END_DIGIT 0.25, FREEMAIL_FROM 0.001,
  RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H2 -0.001, SPF_PASS -0.001,
  LANGUAGES roen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.192.194', Host='mail-pf0-f194.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: leechu729@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519223458; b=AZCdruR6LFVtrlpwpfy+IgTCcYxIamn03tfJnArGrh9PZlm
    s8iq03VZ8cssuwPHlyhHovOUtmKslpREXuWedSaAPc++lHSQjB/cOvAqCTU3Qq8h
    xFmicetBIpN79lt7A2sO2iOD+aQYbod0K3WTte5+rtctKU81Dm4ALD7vItOyD4MP
    q5DZi02+rWrLfPwdzuV95wB7RTpbQ+CfA8O8jFKCX8kf7OxADHjnp9DdBwXUzyAz
    rcuskkEyCIIgogp5Mri7s4nkCVuyz56/JI3ti/FCdNsTlosWmI+4A4U6bQfu6s6p
    wMFyS33kCzisXPfQSOjrlPxnetOYF+HSsKNjXpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id; s=
    arctest; t=1519223458; bh=s3nueMDqe7lNHFWBfG1VdUmwdWbF2Qb6dFVbdO
    O2KO0=; b=CtfbbRKMJQWvE1hZ2En3xsHJR7M21TFkMVoO2wZ55Ki2IkigIhCbss
    VVxx1o+dkBADem8QlUpF7m9sufps61sGfNpV/SYxoazNqJHi26PBDGT92Q/dxmh+
    24hMrOTv1zr2yJJRGjUJCwPnu0pHQxIRz0uJJGXUae2hQEJnQVH44I6o3aKQtXs+
    wTzn4SZu0Y5nViq+yWwuA9PeLfnJ8XhCNGzelZ4gHstVWcepH8wHvKNhbsUWxEAT
    DzYEJY/izoyFGnDEMqiPp/G3ZUBERbQMl+XL6Tv9HbfQ1i/tRl1fIRIYvPEjejPf
    P4FNSRbyaZHBdVHueYEUzGBGWYapevnQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Vp+a1/Co x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.192.194 (mail-pf0-f194.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-pf0-f194.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KNXrCrbz;
    x-ptr=pass x-ptr-helo=mail-pf0-f194.google.com x-ptr-lookup=mail-pf0-f194.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Vp+a1/Co x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.192.194 (mail-pf0-f194.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-pf0-f194.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KNXrCrbz;
    x-ptr=pass x-ptr-helo=mail-pf0-f194.google.com x-ptr-lookup=mail-pf0-f194.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x225ShpsX2UrnYkTuA6x5FYZCtKmKNfCIcyg0CFv7fHhKxyhbBWmTfWSYTAwvEdVyGa7H6vLG2A==
From: ShuFanLee <leechu729@gmail.com>
To: heikki.krogerus@linux.intel.com,
	linux@roeck-us.net,
	greg@kroah.com
Cc: shufan_lee@richtek.com,
	cy_huang@richtek.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH v3] Handle vendor defined behavior in tcpci_init, tcpci_set_vconn and export tcpci_irq. More operations can be extended in tcpci_data if needed. According to TCPCI specification, 4.4.5.2 ROLE_CONTROL, TCPC shall not start DRP toggling until subsequently the TCPM writes to the COMMAND register to start DRP toggling. DRP toggling flow is chagned as following:   - Write DRP = 0 & Rd/Rd   - Write DRP = 1   - Set LOOK4CONNECTION command
Date: Wed, 21 Feb 2018 22:30:34 +0800
Message-Id: <1519223434-7396-1-git-send-email-leechu729@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: ShuFanLee <shufan_lee@richtek.com>

Signed-off-by: ShuFanLee <shufan_lee@richtek.com>
---
 drivers/staging/typec/tcpci.c | 128 +++++++++++++++++++++++++++++++++---------
 drivers/staging/typec/tcpci.h |  13 +++++
 2 files changed, 115 insertions(+), 26 deletions(-)

 patch changelogs between v1 & v2
 - Remove unnecessary i2c_client in the structure of tcpci
 - Rename structure of tcpci_vendor_data to tcpci_data
 - Not exporting tcpci read/write wrappers but register i2c regmap in glue driver
 - Add set_vconn ops in tcpci_data
   (It is necessary for RT1711H to enable/disable idle mode before disabling/enabling vconn)
 - Export tcpci_irq so that vendor can call it in their own IRQ handler

 patch changelogs between v2 & v3
 - Change the return type of tcpci_irq from int to irqreturn_t
 - Disable IRQs and request threaded IRQ before registering tcpci port

diff --git a/drivers/staging/typec/tcpci.c b/drivers/staging/typec/tcpci.c
index 9bd4412..4959c69 100644
--- a/drivers/staging/typec/tcpci.c
+++ b/drivers/staging/typec/tcpci.c
@@ -21,7 +21,6 @@
 
 struct tcpci {
 	struct device *dev;
-	struct i2c_client *client;
 
 	struct tcpm_port *port;
 
@@ -30,6 +29,12 @@ struct tcpci {
 	bool controls_vbus;
 
 	struct tcpc_dev tcpc;
+	struct tcpci_data *data;
+};
+
+struct tcpci_chip {
+	struct tcpci *tcpci;
+	struct tcpci_data data;
 };
 
 static inline struct tcpci *tcpc_to_tcpci(struct tcpc_dev *tcpc)
@@ -37,8 +42,7 @@ static inline struct tcpci *tcpc_to_tcpci(struct tcpc_dev *tcpc)
 	return container_of(tcpc, struct tcpci, tcpc);
 }
 
-static int tcpci_read16(struct tcpci *tcpci, unsigned int reg,
-			u16 *val)
+static int tcpci_read16(struct tcpci *tcpci, unsigned int reg, u16 *val)
 {
 	return regmap_raw_read(tcpci->regmap, reg, val, sizeof(u16));
 }
@@ -98,8 +102,10 @@ static int tcpci_set_cc(struct tcpc_dev *tcpc, enum typec_cc_status cc)
 static int tcpci_start_drp_toggling(struct tcpc_dev *tcpc,
 				    enum typec_cc_status cc)
 {
+	int ret;
 	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
-	unsigned int reg = TCPC_ROLE_CTRL_DRP;
+	unsigned int reg = (TCPC_ROLE_CTRL_CC_RD << TCPC_ROLE_CTRL_CC1_SHIFT) |
+			   (TCPC_ROLE_CTRL_CC_RD << TCPC_ROLE_CTRL_CC2_SHIFT);
 
 	switch (cc) {
 	default:
@@ -117,7 +123,19 @@ static int tcpci_start_drp_toggling(struct tcpc_dev *tcpc,
 		break;
 	}
 
-	return regmap_write(tcpci->regmap, TCPC_ROLE_CTRL, reg);
+	ret = regmap_write(tcpci->regmap, TCPC_ROLE_CTRL, reg);
+	if (ret < 0)
+		return ret;
+	usleep_range(500, 1000);
+	reg |= TCPC_ROLE_CTRL_DRP;
+	ret = regmap_write(tcpci->regmap, TCPC_ROLE_CTRL, reg);
+	if (ret < 0)
+		return ret;
+	ret = regmap_write(tcpci->regmap, TCPC_COMMAND,
+			   TCPC_CMD_LOOK4CONNECTION);
+	if (ret < 0)
+		return ret;
+	return 0;
 }
 
 static enum typec_cc_status tcpci_to_typec_cc(unsigned int cc, bool sink)
@@ -178,6 +196,16 @@ static int tcpci_set_vconn(struct tcpc_dev *tcpc, bool enable)
 	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
 	int ret;
 
+	/* Handle vendor set vconn */
+	if (tcpci->data) {
+		if (tcpci->data->set_vconn) {
+			ret = tcpci->data->set_vconn(tcpci, tcpci->data,
+						     enable);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
 	ret = regmap_write(tcpci->regmap, TCPC_POWER_CTRL,
 			   enable ? TCPC_POWER_CTRL_VCONN_ENABLE : 0);
 	if (ret < 0)
@@ -323,6 +351,15 @@ static int tcpci_init(struct tcpc_dev *tcpc)
 	if (time_after(jiffies, timeout))
 		return -ETIMEDOUT;
 
+	/* Handle vendor init */
+	if (tcpci->data) {
+		if (tcpci->data->init) {
+			ret = tcpci->data->init(tcpci, tcpci->data);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
 	/* Clear all events */
 	ret = tcpci_write16(tcpci, TCPC_ALERT, 0xffff);
 	if (ret < 0)
@@ -344,9 +381,15 @@ static int tcpci_init(struct tcpc_dev *tcpc)
 	return tcpci_write16(tcpci, TCPC_ALERT_MASK, reg);
 }
 
-static irqreturn_t tcpci_irq(int irq, void *dev_id)
+static irqreturn_t _tcpci_irq(int irq, void *dev_id)
 {
 	struct tcpci *tcpci = dev_id;
+
+	return tcpci_irq(tcpci);
+}
+
+irqreturn_t tcpci_irq(struct tcpci *tcpci)
+{
 	u16 status;
 
 	tcpci_read16(tcpci, TCPC_ALERT, &status);
@@ -412,6 +455,7 @@ static irqreturn_t tcpci_irq(int irq, void *dev_id)
 
 	return IRQ_HANDLED;
 }
+EXPORT_SYMBOL_GPL(tcpci_irq);
 
 static const struct regmap_config tcpci_regmap_config = {
 	.reg_bits = 8,
@@ -435,22 +479,18 @@ static int tcpci_parse_config(struct tcpci *tcpci)
 	return 0;
 }
 
-static int tcpci_probe(struct i2c_client *client,
-		       const struct i2c_device_id *i2c_id)
+struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
 {
 	struct tcpci *tcpci;
 	int err;
 
-	tcpci = devm_kzalloc(&client->dev, sizeof(*tcpci), GFP_KERNEL);
+	tcpci = devm_kzalloc(dev, sizeof(*tcpci), GFP_KERNEL);
 	if (!tcpci)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
-	tcpci->client = client;
-	tcpci->dev = &client->dev;
-	i2c_set_clientdata(client, tcpci);
-	tcpci->regmap = devm_regmap_init_i2c(client, &tcpci_regmap_config);
-	if (IS_ERR(tcpci->regmap))
-		return PTR_ERR(tcpci->regmap);
+	tcpci->dev = dev;
+	tcpci->data = data;
+	tcpci->regmap = data->regmap;
 
 	tcpci->tcpc.init = tcpci_init;
 	tcpci->tcpc.get_vbus = tcpci_get_vbus;
@@ -467,27 +507,63 @@ static int tcpci_probe(struct i2c_client *client,
 
 	err = tcpci_parse_config(tcpci);
 	if (err < 0)
-		return err;
+		return ERR_PTR(err);
+
+	tcpci->port = tcpm_register_port(tcpci->dev, &tcpci->tcpc);
+	if (PTR_ERR_OR_ZERO(tcpci->port))
+		return ERR_CAST(tcpci->port);
 
-	/* Disable chip interrupts */
-	tcpci_write16(tcpci, TCPC_ALERT_MASK, 0);
+	return tcpci;
+}
+EXPORT_SYMBOL_GPL(tcpci_register_port);
+
+void tcpci_unregister_port(struct tcpci *tcpci)
+{
+	tcpm_unregister_port(tcpci->port);
+}
+EXPORT_SYMBOL_GPL(tcpci_unregister_port);
 
-	err = devm_request_threaded_irq(tcpci->dev, client->irq, NULL,
-					tcpci_irq,
+static int tcpci_probe(struct i2c_client *client,
+		       const struct i2c_device_id *i2c_id)
+{
+	struct tcpci_chip *chip;
+	int err;
+	u16 val = 0;
+
+	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->data.regmap = devm_regmap_init_i2c(client, &tcpci_regmap_config);
+	if (IS_ERR(chip->data.regmap))
+		return PTR_ERR(chip->data.regmap);
+
+	/* Disable chip interrupts before requesting irq */
+	err = regmap_raw_write(chip->data.regmap, TCPC_ALERT_MASK, &val,
+			       sizeof(u16));
+	if (err < 0)
+		return err;
+
+	err = devm_request_threaded_irq(&client->dev, client->irq, NULL,
+					_tcpci_irq,
 					IRQF_ONESHOT | IRQF_TRIGGER_LOW,
-					dev_name(tcpci->dev), tcpci);
+					dev_name(&client->dev), chip);
 	if (err < 0)
 		return err;
 
-	tcpci->port = tcpm_register_port(tcpci->dev, &tcpci->tcpc);
-	return PTR_ERR_OR_ZERO(tcpci->port);
+	chip->tcpci = tcpci_register_port(&client->dev, &chip->data);
+	if (PTR_ERR_OR_ZERO(chip->tcpci))
+		return PTR_ERR(chip->tcpci);
+
+	i2c_set_clientdata(client, chip);
+	return 0;
 }
 
 static int tcpci_remove(struct i2c_client *client)
 {
-	struct tcpci *tcpci = i2c_get_clientdata(client);
+	struct tcpci_chip *chip = i2c_get_clientdata(client);
 
-	tcpm_unregister_port(tcpci->port);
+	tcpci_unregister_port(chip->tcpci);
 
 	return 0;
 }
diff --git a/drivers/staging/typec/tcpci.h b/drivers/staging/typec/tcpci.h
index fdfb06c..40025b2 100644
--- a/drivers/staging/typec/tcpci.h
+++ b/drivers/staging/typec/tcpci.h
@@ -59,6 +59,7 @@
 #define TCPC_POWER_CTRL_VCONN_ENABLE	BIT(0)
 
 #define TCPC_CC_STATUS			0x1d
+#define TCPC_CC_STATUS_DRPRST		BIT(5)
 #define TCPC_CC_STATUS_TERM		BIT(4)
 #define TCPC_CC_STATUS_CC2_SHIFT	2
 #define TCPC_CC_STATUS_CC2_MASK		0x3
@@ -121,4 +122,16 @@
 #define TCPC_VBUS_VOLTAGE_ALARM_HI_CFG		0x76
 #define TCPC_VBUS_VOLTAGE_ALARM_LO_CFG		0x78
 
+struct tcpci;
+struct tcpci_data {
+	struct regmap *regmap;
+	int (*init)(struct tcpci *tcpci, struct tcpci_data *data);
+	int (*set_vconn)(struct tcpci *tcpci, struct tcpci_data *data,
+			 bool enable);
+};
+
+struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data);
+void tcpci_unregister_port(struct tcpci *tcpci);
+irqreturn_t tcpci_irq(struct tcpci *tcpci);
+
 #endif /* __LINUX_USB_TCPCI_H */
-- 
1.9.1
