Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC2FC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8911120880
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544702955;
	bh=tnBDwuK3I9tRJaef0xormeXeJL8htMHSkNitpzlalac=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Wn6YcQ8Lx30bi1tnym4IZ0X2muFAeJabhihFWnFFwQBUI3ia3WjoPskpl7PLt0ZOk
	 lpA1ddzseZXx+MsUEMrvCTD7CbCoU3RMb8lEwXCR2D50NynWO0yitXgkDHCE27xd/f
	 PMZef3i7QK9sdEgSP3dVCBve1GJS8JR1BVKObAlg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8911120880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbeLMMJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:09:14 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50128 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728944AbeLMMJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:09:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=LlPXnbJt0ovvrXHbwrawpSbQ1d6oU7E3piB764jsGbs=; b=JE7S6F7j7gVI
        XhNWSH+dGV6MqUxVpohgaNA0wDaC8KrE1GjcK4Wjed12+8IR1zjqyauUyIlqk0eSjFwgijqfpWrRE
        O3TJFdQDqxcdoXXdvYq0wHCfhMYZgbp3dlfOPwtUW1XrAgz0e6AaV1pTQAwg2vpqHzsFf4HTZGaxJ
        bR3hI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gXPnc-0000zA-Qe; Thu, 13 Dec 2018 12:09:04 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 83E1111254D1; Thu, 13 Dec 2018 12:09:04 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: act8945a-regulator: Implement PM functionalities" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20181213120904.83E1111254D1@debutante.sirena.org.uk>
Date:   Thu, 13 Dec 2018 12:09:04 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: act8945a-regulator: Implement PM functionalities

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 7482d6ecc68e16a2b8272b0c9cbcc5c50edf013f Mon Sep 17 00:00:00 2001
From: Boris Brezillon <boris.brezillon@bootlin.com>
Date: Tue, 11 Dec 2018 15:56:41 +0000
Subject: [PATCH] regulator: act8945a-regulator: Implement PM functionalities

The regulator supports a dedicated suspend mode.
Implement the appropriate ->set_suspend_xx() hooks, add support for
->set_mode(), and provide basic PM ops functionalities to setup the
regulator in a suspend state when the system is entering suspend.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
[claudiu.beznea@microchip.com: remove shutdown function, use dev_pm_ops,
 fix checkpatch warning, adapt commit message, add LDO modes support,
 move modes constants to active-semi,8945a-regulator.h, remove rdevs from
 struct act8945a_pmic, add op_mode to act8945a_pmic]
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/act8945a-regulator.c        | 186 +++++++++++++++++-
 .../regulator/active-semi,8945a-regulator.h   |  30 +++
 2 files changed, 211 insertions(+), 5 deletions(-)
 create mode 100644 include/dt-bindings/regulator/active-semi,8945a-regulator.h

diff --git a/drivers/regulator/act8945a-regulator.c b/drivers/regulator/act8945a-regulator.c
index 8d71d9893d0d..f37d1a860407 100644
--- a/drivers/regulator/act8945a-regulator.c
+++ b/drivers/regulator/act8945a-regulator.c
@@ -18,6 +18,7 @@
 #include <linux/regmap.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
+#include <dt-bindings/regulator/active-semi,8945a-regulator.h>
 
 /**
  * ACT8945A Global Register Map.
@@ -28,20 +29,27 @@
 #define ACT8945A_DCDC1_VSET1	0x20
 #define ACT8945A_DCDC1_VSET2	0x21
 #define ACT8945A_DCDC1_CTRL	0x22
+#define ACT8945A_DCDC1_SUS	0x24
 #define ACT8945A_DCDC2_VSET1	0x30
 #define ACT8945A_DCDC2_VSET2	0x31
 #define ACT8945A_DCDC2_CTRL	0x32
+#define ACT8945A_DCDC2_SUS	0x34
 #define ACT8945A_DCDC3_VSET1	0x40
 #define ACT8945A_DCDC3_VSET2	0x41
 #define ACT8945A_DCDC3_CTRL	0x42
+#define ACT8945A_DCDC3_SUS	0x44
 #define ACT8945A_LDO1_VSET	0x50
 #define ACT8945A_LDO1_CTRL	0x51
+#define ACT8945A_LDO1_SUS	0x52
 #define ACT8945A_LDO2_VSET	0x54
 #define ACT8945A_LDO2_CTRL	0x55
+#define ACT8945A_LDO2_SUS	0x56
 #define ACT8945A_LDO3_VSET	0x60
 #define ACT8945A_LDO3_CTRL	0x61
+#define ACT8945A_LDO3_SUS	0x62
 #define ACT8945A_LDO4_VSET	0x64
 #define ACT8945A_LDO4_CTRL	0x65
+#define ACT8945A_LDO4_SUS	0x66
 
 /**
  * Field Definitions.
@@ -62,7 +70,12 @@ enum {
 	ACT8945A_ID_LDO2,
 	ACT8945A_ID_LDO3,
 	ACT8945A_ID_LDO4,
-	ACT8945A_REG_NUM,
+	ACT8945A_ID_MAX,
+};
+
+struct act8945a_pmic {
+	struct regmap *regmap;
+	u32 op_mode[ACT8945A_ID_MAX];
 };
 
 static const struct regulator_linear_range act8945a_voltage_ranges[] = {
@@ -71,6 +84,143 @@ static const struct regulator_linear_range act8945a_voltage_ranges[] = {
 	REGULATOR_LINEAR_RANGE(2400000, 48, 63, 100000),
 };
 
+static int act8945a_set_suspend_state(struct regulator_dev *rdev, bool enable)
+{
+	struct regmap *regmap = rdev->regmap;
+	int id = rdev->desc->id, reg, val;
+
+	switch (id) {
+	case ACT8945A_ID_DCDC1:
+		reg = ACT8945A_DCDC1_SUS;
+		val = 0xa8;
+		break;
+	case ACT8945A_ID_DCDC2:
+		reg = ACT8945A_DCDC2_SUS;
+		val = 0xa8;
+		break;
+	case ACT8945A_ID_DCDC3:
+		reg = ACT8945A_DCDC3_SUS;
+		val = 0xa8;
+		break;
+	case ACT8945A_ID_LDO1:
+		reg = ACT8945A_LDO1_SUS;
+		val = 0xe8;
+		break;
+	case ACT8945A_ID_LDO2:
+		reg = ACT8945A_LDO2_SUS;
+		val = 0xe8;
+		break;
+	case ACT8945A_ID_LDO3:
+		reg = ACT8945A_LDO3_SUS;
+		val = 0xe8;
+		break;
+	case ACT8945A_ID_LDO4:
+		reg = ACT8945A_LDO4_SUS;
+		val = 0xe8;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (enable)
+		val |= BIT(4);
+
+	/*
+	 * Ask the PMIC to enable/disable this output when entering hibernate
+	 * mode.
+	 */
+	return regmap_write(regmap, reg, val);
+}
+
+static int act8945a_set_suspend_enable(struct regulator_dev *rdev)
+{
+	return act8945a_set_suspend_state(rdev, true);
+}
+
+static int act8945a_set_suspend_disable(struct regulator_dev *rdev)
+{
+	return act8945a_set_suspend_state(rdev, false);
+}
+
+static unsigned int act8945a_of_map_mode(unsigned int mode)
+{
+	switch (mode) {
+	case ACT8945A_REGULATOR_MODE_FIXED:
+	case ACT8945A_REGULATOR_MODE_NORMAL:
+		return REGULATOR_MODE_NORMAL;
+	case ACT8945A_REGULATOR_MODE_LOWPOWER:
+		return REGULATOR_MODE_STANDBY;
+	default:
+		return REGULATOR_MODE_INVALID;
+	}
+}
+
+static int act8945a_set_mode(struct regulator_dev *rdev, unsigned int mode)
+{
+	struct act8945a_pmic *act8945a = rdev_get_drvdata(rdev);
+	struct regmap *regmap = rdev->regmap;
+	int id = rdev->desc->id;
+	int reg, ret, val = 0;
+
+	switch (id) {
+	case ACT8945A_ID_DCDC1:
+		reg = ACT8945A_DCDC1_CTRL;
+		break;
+	case ACT8945A_ID_DCDC2:
+		reg = ACT8945A_DCDC2_CTRL;
+		break;
+	case ACT8945A_ID_DCDC3:
+		reg = ACT8945A_DCDC3_CTRL;
+		break;
+	case ACT8945A_ID_LDO1:
+		reg = ACT8945A_LDO1_SUS;
+		break;
+	case ACT8945A_ID_LDO2:
+		reg = ACT8945A_LDO2_SUS;
+		break;
+	case ACT8945A_ID_LDO3:
+		reg = ACT8945A_LDO3_SUS;
+		break;
+	case ACT8945A_ID_LDO4:
+		reg = ACT8945A_LDO4_SUS;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (mode) {
+	case REGULATOR_MODE_STANDBY:
+		if (rdev->desc->id > ACT8945A_ID_DCDC3)
+			val = BIT(5);
+		break;
+	case REGULATOR_MODE_NORMAL:
+		if (rdev->desc->id <= ACT8945A_ID_DCDC3)
+			val = BIT(5);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = regmap_update_bits(regmap, reg, BIT(5), val);
+	if (ret)
+		return ret;
+
+	act8945a->op_mode[id] = mode;
+
+	return 0;
+}
+
+static unsigned int act8945a_get_mode(struct regulator_dev *rdev)
+{
+	struct act8945a_pmic *act8945a = rdev_get_drvdata(rdev);
+	int id = rdev->desc->id;
+
+	if (id < ACT8945A_ID_DCDC1 || id >= ACT8945A_ID_MAX)
+		return -EINVAL;
+
+	return act8945a->op_mode[id];
+}
+
 static const struct regulator_ops act8945a_ops = {
 	.list_voltage		= regulator_list_voltage_linear_range,
 	.map_voltage		= regulator_map_voltage_linear_range,
@@ -78,7 +228,11 @@ static const struct regulator_ops act8945a_ops = {
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
+	.set_mode		= act8945a_set_mode,
+	.get_mode		= act8945a_get_mode,
 	.is_enabled		= regulator_is_enabled_regmap,
+	.set_suspend_enable	= act8945a_set_suspend_enable,
+	.set_suspend_disable	= act8945a_set_suspend_disable,
 };
 
 #define ACT89xx_REG(_name, _family, _id, _vsel_reg, _supply)		\
@@ -86,6 +240,7 @@ static const struct regulator_ops act8945a_ops = {
 		.name			= _name,			\
 		.supply_name		= _supply,			\
 		.of_match		= of_match_ptr("REG_"#_id),	\
+		.of_map_mode		= act8945a_of_map_mode,		\
 		.regulators_node	= of_match_ptr("regulators"),	\
 		.id			= _family##_ID_##_id,		\
 		.type			= REGULATOR_VOLTAGE,		\
@@ -124,13 +279,17 @@ static int act8945a_pmic_probe(struct platform_device *pdev)
 {
 	struct regulator_config config = { };
 	const struct regulator_desc *regulators;
+	struct act8945a_pmic *act8945a;
 	struct regulator_dev *rdev;
-	struct regmap *regmap;
 	int i, num_regulators;
 	bool voltage_select;
 
-	regmap = dev_get_regmap(pdev->dev.parent, NULL);
-	if (!regmap) {
+	act8945a = devm_kzalloc(&pdev->dev, sizeof(*act8945a), GFP_KERNEL);
+	if (!act8945a)
+		return -ENOMEM;
+
+	act8945a->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!act8945a->regmap) {
 		dev_err(&pdev->dev,
 			"could not retrieve regmap from parent device\n");
 		return -EINVAL;
@@ -149,6 +308,7 @@ static int act8945a_pmic_probe(struct platform_device *pdev)
 
 	config.dev = &pdev->dev;
 	config.dev->of_node = pdev->dev.parent->of_node;
+	config.driver_data = act8945a;
 	for (i = 0; i < num_regulators; i++) {
 		rdev = devm_regulator_register(&pdev->dev, &regulators[i], &config);
 		if (IS_ERR(rdev)) {
@@ -159,13 +319,29 @@ static int act8945a_pmic_probe(struct platform_device *pdev)
 		}
 	}
 
+	platform_set_drvdata(pdev, act8945a);
+
 	/* Unlock expert registers. */
-	return regmap_write(regmap, ACT8945A_SYS_UNLK_REGS, 0xef);
+	return regmap_write(act8945a->regmap, ACT8945A_SYS_UNLK_REGS, 0xef);
 }
 
+static int act8945a_suspend(struct device *pdev)
+{
+	struct act8945a_pmic *act8945a = dev_get_drvdata(pdev);
+
+	/*
+	 * Ask the PMIC to enter the suspend mode on the next PWRHLD
+	 * transition.
+	 */
+	return regmap_write(act8945a->regmap, ACT8945A_SYS_CTRL, 0x42);
+}
+
+SIMPLE_DEV_PM_OPS(act8945a_pm, act8945a_suspend, NULL);
+
 static struct platform_driver act8945a_pmic_driver = {
 	.driver = {
 		.name = "act8945a-regulator",
+		.pm = &act8945a_pm,
 	},
 	.probe = act8945a_pmic_probe,
 };
diff --git a/include/dt-bindings/regulator/active-semi,8945a-regulator.h b/include/dt-bindings/regulator/active-semi,8945a-regulator.h
new file mode 100644
index 000000000000..9bdba5e3141a
--- /dev/null
+++ b/include/dt-bindings/regulator/active-semi,8945a-regulator.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018 Microchip Technology, Inc. All rights reserved.
+ *
+ * Device Tree binding constants for the ACT8945A PMIC regulators
+ */
+
+#ifndef _DT_BINDINGS_REGULATOR_ACT8945A_H
+#define _DT_BINDINGS_REGULATOR_ACT8945A_H
+
+/*
+ * These constants should be used to specify regulator modes in device tree for
+ * ACT8945A regulators as follows:
+ * ACT8945A_REGULATOR_MODE_FIXED:	It is specific to DCDC regulators and it
+ *					specifies the usage of fixed-frequency
+ *					PWM.
+ *
+ * ACT8945A_REGULATOR_MODE_NORMAL:	It is specific to LDO regulators and it
+ *					specifies the usage of normal mode.
+ *
+ * ACT8945A_REGULATOR_MODE_LOWPOWER:	For DCDC and LDO regulators; it specify
+ *					the usage of proprietary power-saving
+ *					mode.
+ */
+
+#define ACT8945A_REGULATOR_MODE_FIXED		1
+#define ACT8945A_REGULATOR_MODE_NORMAL		2
+#define ACT8945A_REGULATOR_MODE_LOWPOWER	3
+
+#endif
-- 
2.19.0.rc2

