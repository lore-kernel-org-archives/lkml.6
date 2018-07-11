Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348A1C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C56F320883
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="lGMadOME"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C56F320883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732564AbeGKJgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:36:36 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37890 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbeGKJgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=hhiNvFOy6NxfaZUp+Qg7QHJ8EO2z8uOYLFtMLTq1xRg=; b=lGMadOMEvr/9
        gPMnctV4AabC0BWC51hyUDDlv0xtLMtpzfHbSXPNqJXt2toDuyUOtk5zf5pRb1mQ+nOuuseuEGL2W
        p7w5y+VhLY0075dIXYTNTN0dtTbXJT1u5NOX5NyMXe5Tw3IDY4TDZrT+BD9xzHjp7RF8ui5QbADTm
        qK77c=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fdBUe-0002lT-6m; Wed, 11 Jul 2018 09:33:04 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fdBUd-00032v-Oj; Wed, 11 Jul 2018 10:33:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: uniphier: add regulator driver for UniPhier SoC" to the regulator tree
In-Reply-To:  <1531283452-9705-3-git-send-email-hayashi.kunihiko@socionext.com>
Message-Id: <E1fdBUd-00032v-Oj@debutante>
Date:   Wed, 11 Jul 2018 10:33:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: uniphier: add regulator driver for UniPhier SoC

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

From 9df4f90954c860b9715f8fbca521781d8d5cf280 Mon Sep 17 00:00:00 2001
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Date: Wed, 11 Jul 2018 13:30:52 +0900
Subject: [PATCH] regulator: uniphier: add regulator driver for UniPhier SoC

Initial commit to add support for regulators implemented in UniPhier SoCs.
This supports USB VBUS only.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/Kconfig              |   8 +
 drivers/regulator/Makefile             |   1 +
 drivers/regulator/uniphier-regulator.c | 213 +++++++++++++++++++++++++
 3 files changed, 222 insertions(+)
 create mode 100644 drivers/regulator/uniphier-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 2964eaea94c0..8233dc7f0a68 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -950,6 +950,14 @@ config REGULATOR_TWL4030
 	  This driver supports the voltage regulators provided by
 	  this family of companion chips.
 
+config REGULATOR_UNIPHIER
+	tristate "UniPhier regulator driver"
+	depends on ARCH_UNIPHIER || COMPILE_TEST
+	depends on OF && MFD_SYSCON
+	default ARCH_UNIPHIER
+	help
+	  Support for regulators implemented on Socionext UniPhier SoCs.
+
 config REGULATOR_VCTRL
 	tristate "Voltage controlled regulators"
 	depends on OF
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index bd818ceb7c72..b7839f41591e 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -118,6 +118,7 @@ obj-$(CONFIG_REGULATOR_TPS65912) += tps65912-regulator.o
 obj-$(CONFIG_REGULATOR_TPS80031) += tps80031-regulator.o
 obj-$(CONFIG_REGULATOR_TPS65132) += tps65132-regulator.o
 obj-$(CONFIG_REGULATOR_TWL4030) += twl-regulator.o twl6030-regulator.o
+obj-$(CONFIG_REGULATOR_UNIPHIER) += uniphier-regulator.o
 obj-$(CONFIG_REGULATOR_VCTRL) += vctrl-regulator.o
 obj-$(CONFIG_REGULATOR_VEXPRESS) += vexpress-regulator.o
 obj-$(CONFIG_REGULATOR_WM831X) += wm831x-dcdc.o
diff --git a/drivers/regulator/uniphier-regulator.c b/drivers/regulator/uniphier-regulator.c
new file mode 100644
index 000000000000..abf22acbd13e
--- /dev/null
+++ b/drivers/regulator/uniphier-regulator.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Regulator controller driver for UniPhier SoC
+// Copyright 2018 Socionext Inc.
+// Author: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/of_regulator.h>
+#include <linux/reset.h>
+
+#define MAX_CLKS	2
+#define MAX_RSTS	2
+
+struct uniphier_regulator_soc_data {
+	int nclks;
+	const char * const *clock_names;
+	int nrsts;
+	const char * const *reset_names;
+	const struct regulator_desc *desc;
+	const struct regmap_config *regconf;
+};
+
+struct uniphier_regulator_priv {
+	struct clk_bulk_data clk[MAX_CLKS];
+	struct reset_control *rst[MAX_RSTS];
+	const struct uniphier_regulator_soc_data *data;
+};
+
+static struct regulator_ops uniphier_regulator_ops = {
+	.enable     = regulator_enable_regmap,
+	.disable    = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+};
+
+static int uniphier_regulator_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct uniphier_regulator_priv *priv;
+	struct regulator_config config = { };
+	struct regulator_dev *rdev;
+	struct regmap *regmap;
+	struct resource *res;
+	void __iomem *base;
+	const char *name;
+	int i, ret, nr;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->data = of_device_get_match_data(dev);
+	if (WARN_ON(!priv->data))
+		return -EINVAL;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	for (i = 0; i < priv->data->nclks; i++)
+		priv->clk[i].id = priv->data->clock_names[i];
+	ret = devm_clk_bulk_get(dev, priv->data->nclks, priv->clk);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < priv->data->nrsts; i++) {
+		name = priv->data->reset_names[i];
+		priv->rst[i] = devm_reset_control_get_shared(dev, name);
+		if (IS_ERR(priv->rst[i]))
+			return PTR_ERR(priv->rst[i]);
+	}
+
+	ret = clk_bulk_prepare_enable(priv->data->nclks, priv->clk);
+	if (ret)
+		return ret;
+
+	for (nr = 0; nr < priv->data->nrsts; nr++) {
+		ret = reset_control_deassert(priv->rst[nr]);
+		if (ret)
+			goto out_rst_assert;
+	}
+
+	regmap = devm_regmap_init_mmio(dev, base, priv->data->regconf);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	config.dev = dev;
+	config.driver_data = priv;
+	config.of_node = dev->of_node;
+	config.regmap = regmap;
+	config.init_data = of_get_regulator_init_data(dev, dev->of_node,
+						      priv->data->desc);
+	rdev = devm_regulator_register(dev, priv->data->desc, &config);
+	if (IS_ERR(rdev)) {
+		ret = PTR_ERR(rdev);
+		goto out_rst_assert;
+	}
+
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+
+out_rst_assert:
+	while (nr--)
+		reset_control_assert(priv->rst[nr]);
+
+	clk_bulk_disable_unprepare(priv->data->nclks, priv->clk);
+
+	return ret;
+}
+
+static int uniphier_regulator_remove(struct platform_device *pdev)
+{
+	struct uniphier_regulator_priv *priv = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < priv->data->nrsts; i++)
+		reset_control_assert(priv->rst[i]);
+
+	clk_bulk_disable_unprepare(priv->data->nclks, priv->clk);
+
+	return 0;
+}
+
+/* USB3 controller data */
+#define USB3VBUS_OFFSET		0x0
+#define USB3VBUS_REG		BIT(4)
+#define USB3VBUS_REG_EN		BIT(3)
+static const struct regulator_desc uniphier_usb3_regulator_desc = {
+	.name = "vbus",
+	.of_match = of_match_ptr("vbus"),
+	.ops = &uniphier_regulator_ops,
+	.type = REGULATOR_VOLTAGE,
+	.owner = THIS_MODULE,
+	.enable_reg  = USB3VBUS_OFFSET,
+	.enable_mask = USB3VBUS_REG_EN | USB3VBUS_REG,
+	.enable_val  = USB3VBUS_REG_EN | USB3VBUS_REG,
+	.disable_val = USB3VBUS_REG_EN,
+};
+
+static const struct regmap_config uniphier_usb3_regulator_regconf = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = 1,
+};
+
+static const char * const uniphier_pro4_clock_reset_names[] = {
+	"gio", "link",
+};
+
+static const struct uniphier_regulator_soc_data uniphier_pro4_usb3_data = {
+	.nclks = ARRAY_SIZE(uniphier_pro4_clock_reset_names),
+	.clock_names = uniphier_pro4_clock_reset_names,
+	.nrsts = ARRAY_SIZE(uniphier_pro4_clock_reset_names),
+	.reset_names = uniphier_pro4_clock_reset_names,
+	.desc = &uniphier_usb3_regulator_desc,
+	.regconf = &uniphier_usb3_regulator_regconf,
+};
+
+static const char * const uniphier_pxs2_clock_reset_names[] = {
+	"link",
+};
+
+static const struct uniphier_regulator_soc_data uniphier_pxs2_usb3_data = {
+	.nclks = ARRAY_SIZE(uniphier_pxs2_clock_reset_names),
+	.clock_names = uniphier_pxs2_clock_reset_names,
+	.nrsts = ARRAY_SIZE(uniphier_pxs2_clock_reset_names),
+	.reset_names = uniphier_pxs2_clock_reset_names,
+	.desc = &uniphier_usb3_regulator_desc,
+	.regconf = &uniphier_usb3_regulator_regconf,
+};
+
+static const struct of_device_id uniphier_regulator_match[] = {
+	/* USB VBUS */
+	{
+		.compatible = "socionext,uniphier-pro4-usb3-regulator",
+		.data = &uniphier_pro4_usb3_data,
+	},
+	{
+		.compatible = "socionext,uniphier-pxs2-usb3-regulator",
+		.data = &uniphier_pxs2_usb3_data,
+	},
+	{
+		.compatible = "socionext,uniphier-ld20-usb3-regulator",
+		.data = &uniphier_pxs2_usb3_data,
+	},
+	{
+		.compatible = "socionext,uniphier-pxs3-usb3-regulator",
+		.data = &uniphier_pxs2_usb3_data,
+	},
+	{ /* Sentinel */ },
+};
+
+static struct platform_driver uniphier_regulator_driver = {
+	.probe = uniphier_regulator_probe,
+	.remove = uniphier_regulator_remove,
+	.driver = {
+		.name  = "uniphier-regulator",
+		.of_match_table = uniphier_regulator_match,
+	},
+};
+module_platform_driver(uniphier_regulator_driver);
+
+MODULE_AUTHOR("Kunihiko Hayashi <hayashi.kunihiko@socionext.com>");
+MODULE_DESCRIPTION("UniPhier Regulator Controller Driver");
+MODULE_LICENSE("GPL");
-- 
2.18.0.rc2

