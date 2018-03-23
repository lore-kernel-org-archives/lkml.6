Return-Path: <Adam.Thomson.Opensource@diasemi.com>
X-Google-Smtp-Source: AG47ELsCOS20tQ1BnnCfMmHzP/8MzEKvJziCW5Ky02DbEk69UDYrxqXCJPMkmkT1Os0ceALHP5UM
ARC-Seal: i=1; a=rsa-sha256; t=1521799947; cv=none;
        d=google.com; s=arc-20160816;
        b=gN1CJvctx9IkFNa2awJ7CxkRw92eaNLbN8gISXGDPcsM7SugH0jSMbzKV94w9q2jwq
         09c5N9P/L5rlDvwU2zioRQdO1doGFWBi2bRzJl4fOoY3rIyTJcM1VbjDLjqrR5IrkkBB
         Fm06kPF6TfhGcxB+SLMderMw8HNjq61F4WS0APSW5hNhUQems+GIHcL+F+RSySw4pWbl
         7Jrf9qNK1OjOYchVlZL7FrC6xqRoudKeKtHLF1Upby/ninY/77BLRDB4b1ppNb5uhc1n
         tjzQZebhaQU1+Co/waHnOj9utKcUskSEusQbdiON6ALy+qhw3j5LKOgXXQoXSCbJchir
         8H3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:cc:to:subject:date:from:references:in-reply-to
         :message-id:arc-authentication-results;
        bh=yohAqR8y013VJBpXAmifqoi3x5a3Yu7E05ydPGdQkN4=;
        b=AJQPVF9POR35nFkMoi6qDum0lbRC8gZn8+8/MVdqkgidFmrk5IKkp4qPFT1fg0kuXd
         udpuG9scDQ/tEG14tUgu0gHEAIsLKrfQNfIUGuMGOXexP2kzCllKjd8AdpVP2jDzjj6W
         ex4hOWkerWSnbmH8gC5Nbk/Z/UgMCy2zYow+yxvAGTIa55dpdsfdwg73g3v4NQd4izvQ
         L36SvNsMagPjWgC76bEXv7+9uGXM8E7MvcCRTg7IQkGcVKYSvFc0o3/6wKUzlFCX5umQ
         bJVlR7HcFOlJ8amdvn9/7tPKDaoHAdFUEpZ02lLnbWZSLKdGAPnCJ9uyHDzYsOCgukUL
         SGUw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of adam.thomson.opensource@diasemi.com designates 85.158.142.117 as permitted sender) smtp.mailfrom=Adam.Thomson.Opensource@diasemi.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of adam.thomson.opensource@diasemi.com designates 85.158.142.117 as permitted sender) smtp.mailfrom=Adam.Thomson.Opensource@diasemi.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRWlGSWpSXmKPExsUSt3OpsS7X5S1
  RBncWyVg0L17PZvHm+HQmi67VO1ksrh3rZbK4vGsOm8Xn3iOMFouWtTJbPFl4hsni9O4SB06P
  Tas62TzmnQz02D93DbvHxnc7mDze77vK5rHzewO7x+dNcgHsUayZeUn5FQmsGTu+fmUpeJBRc
  WdxD3MD4/WILkYuDiGB9YwStxfeZ+pi5ARyKiR2fz7HCGLzCmRKzL6wihnE5hRwl7j3shOohg
  Ooxk1izyewMJuAhcTkEw/YQGwWAVWJ3//nsIKUCAsESjycYAQyXkTgPaPEp8cfWEBqmAXqJHp
  /v2WBGC8ocXLmE6i4hMTBFy+YIU4wkDi9oBEsLiFgLzH9/VVmkJkSAvoSjcdiIcKGEt9nfYMq
  MZeYdXYH2wRGwVlIps5CMnUBI9MqRoukosz0jJLcxMwcXUMDA11DQ2NdU11zI73EKt0kvdRS3
  eTUvJKiRKCkXmJ5sV5xZW5yTopeXmrJJkZgBDEAwQ7GvkOJhxglOZiURHkzj2+JEuJLyk+pzE
  gszogvKs1JLT7EKMPBoSTBG3ERKCdYlJqeWpGWmQOMZZi0BAePkggvL0iat7ggMbc4Mx0idYp
  Rl+PGi9dtzEIsefl5qVLivFEgRQIgRRmleXAjYGnlEqOslDAvI9BRQjwFqUW5mSWo8q8YxTkY
  lYR5nUCm8GTmlcBtegV0BBPQET5TwI4oSURISTUwTki/5nl42uogvxQj1uUlwsnfjI9zdcsHF
  WVyduTXKsxxiXvhzzVfcVNdYcWDqAaW0qbw8Dvvzgoa/udm6zn7t5Tt4AvpQ6WaXB6dqYHCi+
  04pv5vkMs5GV5zbO26bS8vBKVKBa/YwlG18mkBS3bqA6GJAjPtrio7FypKr+Ta9vIE6wtzvlN
  KLMUZiYZazEXFiQAcdIONJgMAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-21.tower-239.messagelabs.com!1521799945!578501!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Message-ID: <6cd6448a31f1d63ebaa789434c629b5e64e174fe.1521799705.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1521799705.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1521799705.git.Adam.Thomson.Opensource@diasemi.com>
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Fri, 23 Mar 2018 10:12:25 +0000
Subject: [PATCH v7 5/6] typec: tcpm: Represent source supply through power_supply
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Guenter Roeck
	<linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Jun
 Li <jun.li@nxp.com>
CC: <linux-usb@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 23/03/2018 08:40:00
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595722900998057147?=
X-GMAIL-MSGID: =?utf-8?q?1595722900998057147?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This commit adds a power_supply class instance to represent a
PD source's voltage and current properties. This provides an
interface for reading these properties from user-space or other
drivers.

For PPS enabled Sources, this also provides write access to set
the current and voltage and allows for swapping between standard
PDO and PPS APDO.

As this represents a superset of the information provided in the
fusb302 driver, the power_supply instance in that code is removed
as part of this change, so reverting the commit titled
'typec: tcpm: Represent source supply through power_supply class'

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/usb/typec/Kconfig           |   1 +
 drivers/usb/typec/fusb302/Kconfig   |   2 +-
 drivers/usb/typec/fusb302/fusb302.c |  63 +---------
 drivers/usb/typec/tcpm.c            | 245 +++++++++++++++++++++++++++++++++++-
 4 files changed, 248 insertions(+), 63 deletions(-)

diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
index bcb2744..1ef606d 100644
--- a/drivers/usb/typec/Kconfig
+++ b/drivers/usb/typec/Kconfig
@@ -48,6 +48,7 @@ if TYPEC
 config TYPEC_TCPM
 	tristate "USB Type-C Port Controller Manager"
 	depends on USB
+	select POWER_SUPPLY
 	help
 	  The Type-C Port Controller Manager provides a USB PD and USB Type-C
 	  state machine for use with Type-C Port Controllers.
diff --git a/drivers/usb/typec/fusb302/Kconfig b/drivers/usb/typec/fusb302/Kconfig
index 48a4f2f..fce099f 100644
--- a/drivers/usb/typec/fusb302/Kconfig
+++ b/drivers/usb/typec/fusb302/Kconfig
@@ -1,6 +1,6 @@
 config TYPEC_FUSB302
 	tristate "Fairchild FUSB302 Type-C chip driver"
-	depends on I2C && POWER_SUPPLY
+	depends on I2C
 	help
 	  The Fairchild FUSB302 Type-C chip driver that works with
 	  Type-C Port Controller Manager to provide USB PD and USB
diff --git a/drivers/usb/typec/fusb302/fusb302.c b/drivers/usb/typec/fusb302/fusb302.c
index 06794c0..6a8f279 100644
--- a/drivers/usb/typec/fusb302/fusb302.c
+++ b/drivers/usb/typec/fusb302/fusb302.c
@@ -18,7 +18,6 @@
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/pinctrl/consumer.h>
-#include <linux/power_supply.h>
 #include <linux/proc_fs.h>
 #include <linux/regulator/consumer.h>
 #include <linux/sched/clock.h>
@@ -99,11 +98,6 @@ struct fusb302_chip {
 	/* lock for sharing chip states */
 	struct mutex lock;
 
-	/* psy + psy status */
-	struct power_supply *psy;
-	u32 current_limit;
-	u32 supply_voltage;
-
 	/* chip status */
 	enum toggling_mode toggling_mode;
 	enum src_current_status src_current_status;
@@ -861,13 +855,11 @@ static int tcpm_set_vbus(struct tcpc_dev *dev, bool on, bool charge)
 		chip->vbus_on = on;
 		fusb302_log(chip, "vbus := %s", on ? "On" : "Off");
 	}
-	if (chip->charge_on == charge) {
+	if (chip->charge_on == charge)
 		fusb302_log(chip, "charge is already %s",
 			    charge ? "On" : "Off");
-	} else {
+	else
 		chip->charge_on = charge;
-		power_supply_changed(chip->psy);
-	}
 
 done:
 	mutex_unlock(&chip->lock);
@@ -883,11 +875,6 @@ static int tcpm_set_current_limit(struct tcpc_dev *dev, u32 max_ma, u32 mv)
 	fusb302_log(chip, "current limit: %d ma, %d mv (not implemented)",
 		    max_ma, mv);
 
-	chip->supply_voltage = mv;
-	chip->current_limit = max_ma;
-
-	power_supply_changed(chip->psy);
-
 	return 0;
 }
 
@@ -1686,43 +1673,6 @@ static irqreturn_t fusb302_irq_intn(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int fusb302_psy_get_property(struct power_supply *psy,
-				    enum power_supply_property psp,
-				    union power_supply_propval *val)
-{
-	struct fusb302_chip *chip = power_supply_get_drvdata(psy);
-
-	switch (psp) {
-	case POWER_SUPPLY_PROP_ONLINE:
-		val->intval = chip->charge_on;
-		break;
-	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
-		val->intval = chip->supply_voltage * 1000; /* mV -> µV */
-		break;
-	case POWER_SUPPLY_PROP_CURRENT_MAX:
-		val->intval = chip->current_limit * 1000; /* mA -> µA */
-		break;
-	default:
-		return -ENODATA;
-	}
-
-	return 0;
-}
-
-static enum power_supply_property fusb302_psy_properties[] = {
-	POWER_SUPPLY_PROP_ONLINE,
-	POWER_SUPPLY_PROP_VOLTAGE_NOW,
-	POWER_SUPPLY_PROP_CURRENT_MAX,
-};
-
-static const struct power_supply_desc fusb302_psy_desc = {
-	.name		= "fusb302-typec-source",
-	.type		= POWER_SUPPLY_TYPE_USB_TYPE_C,
-	.properties	= fusb302_psy_properties,
-	.num_properties	= ARRAY_SIZE(fusb302_psy_properties),
-	.get_property	= fusb302_psy_get_property,
-};
-
 static int init_gpio(struct fusb302_chip *chip)
 {
 	struct device_node *node;
@@ -1762,7 +1712,6 @@ static int fusb302_probe(struct i2c_client *client,
 	struct fusb302_chip *chip;
 	struct i2c_adapter *adapter;
 	struct device *dev = &client->dev;
-	struct power_supply_config cfg = {};
 	const char *name;
 	int ret = 0;
 	u32 v;
@@ -1809,14 +1758,6 @@ static int fusb302_probe(struct i2c_client *client,
 			return -EPROBE_DEFER;
 	}
 
-	cfg.drv_data = chip;
-	chip->psy = devm_power_supply_register(dev, &fusb302_psy_desc, &cfg);
-	if (IS_ERR(chip->psy)) {
-		ret = PTR_ERR(chip->psy);
-		dev_err(chip->dev, "Error registering power-supply: %d\n", ret);
-		return ret;
-	}
-
 	ret = fusb302_debugfs_init(chip);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
index 1a66c9e..57a7d1a 100644
--- a/drivers/usb/typec/tcpm.c
+++ b/drivers/usb/typec/tcpm.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/power_supply.h>
 #include <linux/proc_fs.h>
 #include <linux/sched/clock.h>
 #include <linux/seq_file.h>
@@ -277,6 +278,11 @@ struct tcpm_port {
 	u32 current_limit;
 	u32 supply_voltage;
 
+	/* Used to export TA voltage and current */
+	struct power_supply *psy;
+	struct power_supply_desc psy_desc;
+	enum power_supply_usb_type usb_type;
+
 	u32 bist_request;
 
 	/* PD state for Vendor Defined Messages */
@@ -1876,6 +1882,7 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port)
 	int ret = -EINVAL;
 
 	port->pps_data.supported = false;
+	port->usb_type = POWER_SUPPLY_USB_TYPE_PD;
 
 	/*
 	 * Select the source PDO providing the most power while staying within
@@ -1895,8 +1902,11 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port)
 			mv = pdo_min_voltage(pdo);
 			break;
 		case PDO_TYPE_APDO:
-			if (pdo_apdo_type(pdo) == APDO_TYPE_PPS)
+			if (pdo_apdo_type(pdo) == APDO_TYPE_PPS) {
 				port->pps_data.supported = true;
+				port->usb_type =
+					POWER_SUPPLY_USB_TYPE_PD_PPS;
+			}
 			continue;
 		default:
 			tcpm_log(port, "Invalid PDO type, ignoring");
@@ -2381,6 +2391,9 @@ static void tcpm_reset_port(struct tcpm_port *port)
 	port->try_snk_count = 0;
 	port->supply_voltage = 0;
 	port->current_limit = 0;
+	port->usb_type = POWER_SUPPLY_USB_TYPE_C;
+
+	power_supply_changed(port->psy);
 }
 
 static void tcpm_detach(struct tcpm_port *port)
@@ -2910,6 +2923,8 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_check_send_discover(port);
 		tcpm_pps_complete(port, port->pps_status);
 
+		power_supply_changed(port->psy);
+
 		break;
 
 	/* Accessory states */
@@ -4076,6 +4091,230 @@ int tcpm_update_sink_capabilities(struct tcpm_port *port, const u32 *pdo,
 }
 EXPORT_SYMBOL_GPL(tcpm_update_sink_capabilities);
 
+/* Power Supply access to expose source power information */
+enum tcpm_psy_online_states {
+	TCPM_PSY_OFFLINE = 0,
+	TCPM_PSY_FIXED_ONLINE,
+	TCPM_PSY_PROG_ONLINE,
+};
+
+static enum power_supply_property tcpm_psy_props[] = {
+	POWER_SUPPLY_PROP_USB_TYPE,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_MAX,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+};
+
+static int tcpm_psy_get_online(struct tcpm_port *port,
+			       union power_supply_propval *val)
+{
+	if (port->vbus_charge) {
+		if (port->pps_data.active)
+			val->intval = TCPM_PSY_PROG_ONLINE;
+		else
+			val->intval = TCPM_PSY_FIXED_ONLINE;
+	} else {
+		val->intval = TCPM_PSY_OFFLINE;
+	}
+
+	return 0;
+}
+
+static int tcpm_psy_get_voltage_min(struct tcpm_port *port,
+				    union power_supply_propval *val)
+{
+	if (port->pps_data.active)
+		val->intval = port->pps_data.min_volt * 1000;
+	else
+		val->intval = port->supply_voltage * 1000;
+
+	return 0;
+}
+
+static int tcpm_psy_get_voltage_max(struct tcpm_port *port,
+				    union power_supply_propval *val)
+{
+	if (port->pps_data.active)
+		val->intval = port->pps_data.max_volt * 1000;
+	else
+		val->intval = port->supply_voltage * 1000;
+
+	return 0;
+}
+
+static int tcpm_psy_get_voltage_now(struct tcpm_port *port,
+				    union power_supply_propval *val)
+{
+	val->intval = port->supply_voltage * 1000;
+
+	return 0;
+}
+
+static int tcpm_psy_get_current_max(struct tcpm_port *port,
+				    union power_supply_propval *val)
+{
+	if (port->pps_data.active)
+		val->intval = port->pps_data.max_curr * 1000;
+	else
+		val->intval = port->current_limit * 1000;
+
+	return 0;
+}
+
+static int tcpm_psy_get_current_now(struct tcpm_port *port,
+				    union power_supply_propval *val)
+{
+	val->intval = port->current_limit * 1000;
+
+	return 0;
+}
+
+static int tcpm_psy_get_prop(struct power_supply *psy,
+			     enum power_supply_property psp,
+			     union power_supply_propval *val)
+{
+	struct tcpm_port *port = power_supply_get_drvdata(psy);
+	int ret = 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_USB_TYPE:
+		val->intval = port->usb_type;
+		break;
+	case POWER_SUPPLY_PROP_ONLINE:
+		ret = tcpm_psy_get_online(port, val);
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
+		ret = tcpm_psy_get_voltage_min(port, val);
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
+		ret = tcpm_psy_get_voltage_max(port, val);
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		ret = tcpm_psy_get_voltage_now(port, val);
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_MAX:
+		ret = tcpm_psy_get_current_max(port, val);
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		ret = tcpm_psy_get_current_now(port, val);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int tcpm_psy_set_online(struct tcpm_port *port,
+			       const union power_supply_propval *val)
+{
+	int ret;
+
+	switch (val->intval) {
+	case TCPM_PSY_FIXED_ONLINE:
+		ret = tcpm_pps_activate(port, false);
+		break;
+	case TCPM_PSY_PROG_ONLINE:
+		ret = tcpm_pps_activate(port, true);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int tcpm_psy_set_prop(struct power_supply *psy,
+			     enum power_supply_property psp,
+			     const union power_supply_propval *val)
+{
+	struct tcpm_port *port = power_supply_get_drvdata(psy);
+	int ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		ret = tcpm_psy_set_online(port, val);
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		if (val->intval < port->pps_data.min_volt * 1000 ||
+		    val->intval > port->pps_data.max_volt * 1000)
+			ret = -EINVAL;
+		else
+			ret = tcpm_pps_set_out_volt(port, val->intval / 1000);
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		if (val->intval > port->pps_data.max_curr * 1000)
+			ret = -EINVAL;
+		else
+			ret = tcpm_pps_set_op_curr(port, val->intval / 1000);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int tcpm_psy_prop_writeable(struct power_supply *psy,
+				   enum power_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+static enum power_supply_usb_type tcpm_psy_usb_types[] = {
+	POWER_SUPPLY_USB_TYPE_C,
+	POWER_SUPPLY_USB_TYPE_PD,
+	POWER_SUPPLY_USB_TYPE_PD_PPS,
+};
+
+static const char *tcpm_psy_name_prefix = "tcpm-source-psy-";
+
+static int devm_tcpm_psy_register(struct tcpm_port *port)
+{
+	struct power_supply_config psy_cfg = {};
+	const char *port_dev_name = dev_name(port->dev);
+	size_t psy_name_len = strlen(tcpm_psy_name_prefix) +
+				     strlen(port_dev_name) + 1;
+	char *psy_name;
+
+	psy_cfg.drv_data = port;
+	psy_name = devm_kzalloc(port->dev, psy_name_len, GFP_KERNEL);
+	if (!psy_name)
+		return -ENOMEM;
+
+	snprintf(psy_name, psy_name_len, "%s%s", tcpm_psy_name_prefix,
+		 port_dev_name);
+	port->psy_desc.name = psy_name;
+	port->psy_desc.type = POWER_SUPPLY_TYPE_USB,
+	port->psy_desc.usb_types = tcpm_psy_usb_types;
+	port->psy_desc.num_usb_types = ARRAY_SIZE(tcpm_psy_usb_types);
+	port->psy_desc.properties = tcpm_psy_props,
+	port->psy_desc.num_properties = ARRAY_SIZE(tcpm_psy_props),
+	port->psy_desc.get_property = tcpm_psy_get_prop,
+	port->psy_desc.set_property = tcpm_psy_set_prop,
+	port->psy_desc.property_is_writeable = tcpm_psy_prop_writeable,
+
+	port->usb_type = POWER_SUPPLY_USB_TYPE_C;
+
+	port->psy = devm_power_supply_register(port->dev, &port->psy_desc,
+					       &psy_cfg);
+
+	return PTR_ERR_OR_ZERO(port->psy);
+}
+
 struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 {
 	struct tcpm_port *port;
@@ -4147,6 +4386,10 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 	port->partner_desc.identity = &port->partner_ident;
 	port->port_type = tcpc->config->type;
 
+	err = devm_tcpm_psy_register(port);
+	if (err)
+		goto out_destroy_wq;
+
 	port->typec_port = typec_register_port(port->dev, &port->typec_caps);
 	if (IS_ERR(port->typec_port)) {
 		err = PTR_ERR(port->typec_port);
-- 
1.9.1
