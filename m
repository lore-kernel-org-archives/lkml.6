Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B446C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B78F20880
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544724721;
	bh=+LZJe2GKcs94/m6XrG8Tfg4nAhPvhH0Xg/QLP55BVXU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=wVa1MIS2uj1iWQGw8EgqO5GhlZt76WJ2nGkUq4svRWfi1koha7pDr1B7i0mhFhCxT
	 OSE/cjK8xvNbxXVNpBslCRXXa9MspzcELV04COR3Ej8OlfGbUEdZIUaICf3ufJkdqO
	 PgmVjaAdFKe/fxMMxgpZxrjxU9drqOr6Tllne+i0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B78F20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbeLMSL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 13:11:59 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37716 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729797AbeLMSLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 13:11:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=EIv3B2nzBQF12AuMbWDaWyOpEQ87adi/yIr4RxFSIoo=; b=Gt/ID8UhXYOe
        Pu1pjyh++Rvn0znZ1U54CXFYPPfqokUF8JgL4WUpjHM+Bm7Kak2FOBShw+xYa3KuIqrNr6UkeWBIL
        Oo0zTnUtFdJwjHHHcspJGQtsxJrl7zjNuGAPRbNsf3m6dSbSsQAyQCHSG1AMbT5eoZ0lBEAHsAsQI
        EAFec=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gXVSZ-0002Rb-0V; Thu, 13 Dec 2018 18:11:43 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id A5F3911254D1; Thu, 13 Dec 2018 18:11:42 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Olliver Schinagl <oliver@schinagl.nl>
Cc:     Priit Laes <plaes@plaes.org>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: axp20x: add support for set_ramp_delay for AXP209" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20181213181142.A5F3911254D1@debutante.sirena.org.uk>
Date:   Thu, 13 Dec 2018 18:11:42 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: axp20x: add support for set_ramp_delay for AXP209

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

From d29f54df8b167be6174881f265b12453a558e48a Mon Sep 17 00:00:00 2001
From: Olliver Schinagl <oliver@schinagl.nl>
Date: Tue, 11 Dec 2018 17:17:06 +0200
Subject: [PATCH] regulator: axp20x: add support for set_ramp_delay for AXP209

The AXP209 supports ramping up voltages on several regulators such as
DCDC2 and LDO3.

This patch adds preliminary support for the regulator-ramp-delay property
for these 2 regulators. Note that the voltage ramp only works when
regulator is already enabled. E.g. when going from say 0.7 V to 3.6 V.

When turning on the regulator, no voltage ramp is performed in hardware.

What this means, is that if the bootloader brings up the voltage at 0.7 V,
the ramp delay property is properly applied. If however, the bootloader
leaves the power off, no ramp delay is applied when the power is
enabled by the regulator framework.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
Signed-off-by: Priit Laes <plaes@plaes.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/axp20x-regulator.c | 85 ++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 9a2db28effb5..1d9fa6238aec 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -51,6 +51,17 @@
 #define AXP20X_PWR_OUT_DCDC2_MASK	BIT_MASK(4)
 #define AXP20X_PWR_OUT_LDO3_MASK	BIT_MASK(6)
 
+#define AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_RATE_MASK	BIT_MASK(0)
+#define AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_RATE(x) \
+	((x) << 0)
+#define AXP20X_DCDC2_LDO3_V_RAMP_LDO3_RATE_MASK		BIT_MASK(1)
+#define AXP20X_DCDC2_LDO3_V_RAMP_LDO3_RATE(x) \
+	((x) << 1)
+#define AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN_MASK		BIT_MASK(2)
+#define AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN		BIT(2)
+#define AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN_MASK		BIT_MASK(3)
+#define AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN		BIT(3)
+
 #define AXP20X_LDO4_V_OUT_1250mV_START	0x0
 #define AXP20X_LDO4_V_OUT_1250mV_STEPS	0
 #define AXP20X_LDO4_V_OUT_1250mV_END	\
@@ -346,6 +357,79 @@
 		.ops		= &axp20x_ops_range,				\
 	}
 
+static const int axp209_dcdc2_ldo3_slew_rates[] = {
+	1600,
+	 800,
+};
+
+static int axp20x_set_ramp_delay(struct regulator_dev *rdev, int ramp)
+{
+	struct axp20x_dev *axp20x = rdev_get_drvdata(rdev);
+	const struct regulator_desc *desc = rdev->desc;
+	u8 reg, mask, enable, cfg = 0xff;
+	const int *slew_rates;
+	int rate_count = 0;
+
+	if (!rdev)
+		return -EINVAL;
+
+	switch (axp20x->variant) {
+	case AXP209_ID:
+		if (desc->id == AXP20X_DCDC2) {
+			rate_count = ARRAY_SIZE(axp209_dcdc2_ldo3_slew_rates);
+			reg = AXP20X_DCDC2_LDO3_V_RAMP;
+			mask = AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_RATE_MASK |
+			       AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN_MASK;
+			enable = (ramp > 0) ?
+				 AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN :
+				 !AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN;
+			break;
+		}
+
+		if (desc->id == AXP20X_LDO3) {
+			slew_rates = axp209_dcdc2_ldo3_slew_rates;
+			rate_count = ARRAY_SIZE(axp209_dcdc2_ldo3_slew_rates);
+			reg = AXP20X_DCDC2_LDO3_V_RAMP;
+			mask = AXP20X_DCDC2_LDO3_V_RAMP_LDO3_RATE_MASK |
+			       AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN_MASK;
+			enable = (ramp > 0) ?
+				 AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN :
+				 !AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN;
+			break;
+		}
+
+		if (rate_count > 0)
+			break;
+
+		/* fall through */
+	default:
+		/* Not supported for this regulator */
+		return -ENOTSUPP;
+	}
+
+	if (ramp == 0) {
+		cfg = enable;
+	} else {
+		int i;
+
+		for (i = 0; i < rate_count; i++) {
+			if (ramp <= slew_rates[i])
+				cfg = AXP20X_DCDC2_LDO3_V_RAMP_LDO3_RATE(i);
+			else
+				break;
+		}
+
+		if (cfg == 0xff) {
+			dev_err(axp20x->dev, "unsupported ramp value %d", ramp);
+			return -EINVAL;
+		}
+
+		cfg |= enable;
+	}
+
+	return regmap_update_bits(axp20x->regmap, reg, mask, cfg);
+}
+
 static const struct regulator_ops axp20x_ops_fixed = {
 	.list_voltage		= regulator_list_voltage_linear,
 };
@@ -366,6 +450,7 @@ static const struct regulator_ops axp20x_ops = {
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
 	.is_enabled		= regulator_is_enabled_regmap,
+	.set_ramp_delay		= axp20x_set_ramp_delay,
 };
 
 static const struct regulator_ops axp20x_ops_sw = {
-- 
2.19.0.rc2

