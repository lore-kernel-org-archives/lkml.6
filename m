Return-Path: <leechu729@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-1794019-1519876065-2-3307650166805037846
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_ENVFROM_END_DIGIT 0.25, FREEMAIL_FROM 0.001,
  RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H3 -0.01,
  RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001, LANGUAGES ro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='74.125.83.68', Host='mail-pg0-f68.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: leechu729@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519876064; b=FngfeAPnzZ5OYOlRKZJoa31LLz5P6HXKC4sKq8ZfYb36Pc5
    A4stxV8/W5qQEJoD1FbZteDw6mRyrA/TE48j/nRToca6JPFRKw04gzTpeg3qQ/Zx
    /1NXjjKl12gbCvFVzroV3Vv6dFlWGvaWnJlz0xc+NV3syC0cb0IJI10cuVup5BDX
    hPyhc7TtYW+ksHyAjOds8VQBKqsbizFeiop3h4g3CVU+OAd3grEQ+JDVs1Ok8N44
    SUezkGD6KtMh12c6G50ODIEhUSOPUUb0McIR5mBgtNwpdaSq6d6ymaeuP/j3ckbG
    XFZfml0McvDK1iuBkk7kEBAtOpvmURX+LYB1V8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id; s=
    arctest; t=1519876064; bh=kxd8y8T67QiscEaskYnY+vOvQdXkdCYqEtpVWR
    BAeL4=; b=N6n1y9fXEig61pXN3IxqIRgjt5+TSGMJGU8TZ7SUA06zjwkAETY9Cz
    ryhckRsYEIgsKCDN1oMZzQgYklZiyUfqpguuZ97Y6mserGNFjLJ6Aivsjnf3UcOj
    HlU0JA2aqes1Yxbt66SS79rmuVJ0rCgf1Ynmmd3ReZ5kwr9+tI455fgM1OACUA6p
    FmRp0yJ+e+komCssDe93ys+piW1nr4kr9LOb6f/h2EPR6D04oKjR7zVOG4UDlM5M
    gscHC6jbJJ6vdhtuNUA7daUgtpx3jIlTm6DIs8m7JzY66XNEVJpRL5atAbJtfKag
    WVkcxQXDohGyHinQDPlyrix3bEXIecRg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=qPHf/iTf x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=74.125.83.68 (mail-pg0-f68.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-pg0-f68.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=U+a89Kzu;
    x-ptr=pass x-ptr-helo=mail-pg0-f68.google.com x-ptr-lookup=mail-pg0-f68.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=qPHf/iTf x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=74.125.83.68 (mail-pg0-f68.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-pg0-f68.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=U+a89Kzu;
    x-ptr=pass x-ptr-helo=mail-pg0-f68.google.com x-ptr-lookup=mail-pg0-f68.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AG47ELskj1m+slsGZw89rjKnf0OOjku0sgRYvPqgJSZtX3yoFPtgZbYsT8m/rl1vzia8cCsWKQaN0w==
From: ShuFanLee <leechu729@gmail.com>
To: heikki.krogerus@linux.intel.com,
	linux@roeck-us.net,
	greg@kroah.com
Cc: shufan_lee@richtek.com,
	cy_huang@richtek.com,
	jun.li@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH v4] staging: typec: handle vendor defined part and modify drp toggling flow
Date: Thu,  1 Mar 2018 11:47:16 +0800
Message-Id: <1519876036-13630-1-git-send-email-leechu729@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: ShuFanLee <shufan_lee@richtek.com>

Handle vendor defined behavior in tcpci_init, tcpci_set_vconn and export tcpci_irq.
More operations can be extended in tcpci_data if needed.
According to TCPCI specification, 4.4.5.2 ROLE_CONTROL,
TCPC shall not start DRP toggling until subsequently the TCPM
writes to the COMMAND register to start DRP toggling.
DRP toggling flow is chagned as following:
  - Write DRP = 0 & Rd/Rd
  - Write DRP = 1
  - Set LOOK4CONNECTION command

Signed-off-by: ShuFanLee <shufan_lee@richtek.com>
---
 drivers/staging/typec/tcpci.c | 127 +++++++++++++++++++++++++++++++++---------
 drivers/staging/typec/tcpci.h |  13 +++++
 2 files changed, 113 insertions(+), 27 deletions(-)

 patch changelogs between v1 & v2
 - Remove unnecessary i2c_client in the structure of tcpci
 - Rename structure of tcpci_vendor_data to tcpci_data
 - Not exporting tcpci read/write wrappers but register i2c regmap in glue driver
 - Add set_vconn ops in tcpci_data
   (It is necessary for RT1711H to enable/disable idle mode before disabling/enabling vconn)
 - Export tcpci_irq so that vendor can call it in their own IRQ handler

 patch changelogs between v2 & v3
 - Change the return type of tcpci_irq from int to irqreturn_t

 patch changelogs between v3 & v4
 - Directly return regmap_write at the end of drp_toggling function
 - Because tcpci_irq is called in _tcpci_irq, move _tcpci_irq to the place after tcpci_irq

diff --git a/drivers/staging/typec/tcpci.c b/drivers/staging/typec/tcpci.c
index 9bd4412..5bafcc4 100644
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
@@ -117,7 +123,16 @@ static int tcpci_start_drp_toggling(struct tcpc_dev *tcpc,
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
+	return regmap_write(tcpci->regmap, TCPC_COMMAND,
+			    TCPC_CMD_LOOK4CONNECTION);
 }
 
 static enum typec_cc_status tcpci_to_typec_cc(unsigned int cc, bool sink)
@@ -178,6 +193,16 @@ static int tcpci_set_vconn(struct tcpc_dev *tcpc, bool enable)
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
@@ -323,6 +348,15 @@ static int tcpci_init(struct tcpc_dev *tcpc)
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
@@ -344,9 +378,8 @@ static int tcpci_init(struct tcpc_dev *tcpc)
 	return tcpci_write16(tcpci, TCPC_ALERT_MASK, reg);
 }
 
-static irqreturn_t tcpci_irq(int irq, void *dev_id)
+irqreturn_t tcpci_irq(struct tcpci *tcpci)
 {
-	struct tcpci *tcpci = dev_id;
 	u16 status;
 
 	tcpci_read16(tcpci, TCPC_ALERT, &status);
@@ -412,6 +445,14 @@ static irqreturn_t tcpci_irq(int irq, void *dev_id)
 
 	return IRQ_HANDLED;
 }
+EXPORT_SYMBOL_GPL(tcpci_irq);
+
+static irqreturn_t _tcpci_irq(int irq, void *dev_id)
+{
+	struct tcpci *tcpci = dev_id;
+
+	return tcpci_irq(tcpci);
+}
 
 static const struct regmap_config tcpci_regmap_config = {
 	.reg_bits = 8,
@@ -435,22 +476,18 @@ static int tcpci_parse_config(struct tcpci *tcpci)
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
@@ -467,27 +504,63 @@ static int tcpci_probe(struct i2c_client *client,
 
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
