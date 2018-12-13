Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5B0C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA3820892
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544724705;
	bh=U5sYlPMwxu+veJlkFXkeXUGLxw3CMttXE4y6Iivojrk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=RJ7waZ8LMOYOnkIeg/5UtjTXMN/oKAv0jQizN1PHquwy8jpZXF9MrqzfpLAOIkAfv
	 EqzG3m0IoiA7/U1Ewc9OBQ076eDkUmbw+UUYC52VOE7xxl1TT1NwGU5OofKaPpIsKO
	 tEQqXqh0UYtALIpcdMnaZsZPDU02zCHpc+MdVxgg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA3820892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbeLMSLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 13:11:44 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37616 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729775AbeLMSLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 13:11:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=mnNOdcqlt8iupjbK3COqC7rtgPkWtpGCJDy7F4QPLnM=; b=tFxlUFVC9Cio
        9sg7WpG1zRzopEJIyPX5d5pkw8q2B3jbQ6Lg8qfGuF1aw+BSzuhRKBOXqe7cEX5nzbLLijIF6SyVh
        wdGAp5Qsi7wwKgvlmg33wTYxiyq/VXHDnjOBevTPrU1tvoyOWgvsCMS0GFxUFVFt7+s1jTd4VZV9Q
        NYy4o=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gXVSV-0002RN-Mh; Thu, 13 Dec 2018 18:11:39 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5F16011254D1; Thu, 13 Dec 2018 18:11:39 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Olliver Schinagl <oliver@schinagl.nl>
Cc:     Priit Laes <plaes@plaes.org>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: axp20x: add software based soft_start for AXP209 LDO3" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20181213181139.5F16011254D1@debutante.sirena.org.uk>
Date:   Thu, 13 Dec 2018 18:11:39 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: axp20x: add software based soft_start for AXP209 LDO3

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

From 77e3e3b165db94dc48c0de30498f51fa38f19d4d Mon Sep 17 00:00:00 2001
From: Olliver Schinagl <oliver@schinagl.nl>
Date: Tue, 11 Dec 2018 17:17:08 +0200
Subject: [PATCH] regulator: axp20x: add software based soft_start for AXP209
 LDO3

In the past, there have been words on various lists that if LDO3 is
disabled in u-boot, but enabled in the DTS, the axp209 driver would
fail to continue/hang. Several enable/disable patches have been
issues to devicetree's in both the kernel and u-boot to address
this issue.

What really happened however, was that the AXP209 shuts down without
a notice and without setting an interrupt. This is caused when LDO3
gets overloaded, for example with large capacitors on the LDO3 output.

Normally, we would expect that AXP209 would source 200 mA as per
datasheet and set and trigger an interrupt when being overloaded.
For some reason however, this does not happen.

As a work-around, we use the soft-start constraint of the regulator
node to first bring up the LDO3 to the lowest possible voltage and
then enable the LDO. After that, we can set the requested voltage
as usual.

Combining this setting with the regulator-ramp-delay allows LDO3 to
enable voltage slowly and staggered, potentially reducing overall
inrush current.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
Signed-off-by: Priit Laes <plaes@plaes.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/axp20x-regulator.c | 57 +++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 1d9fa6238aec..e8a895b81c90 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/mfd/axp20x.h>
@@ -23,6 +24,7 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
 #include <linux/regulator/of_regulator.h>
 
 #define AXP20X_GPIO0_FUNC_MASK		GENMASK(3, 0)
@@ -430,6 +432,59 @@ static int axp20x_set_ramp_delay(struct regulator_dev *rdev, int ramp)
 	return regmap_update_bits(axp20x->regmap, reg, mask, cfg);
 }
 
+static int axp20x_regulator_enable_regmap(struct regulator_dev *rdev)
+{
+	struct axp20x_dev *axp20x = rdev_get_drvdata(rdev);
+	const struct regulator_desc *desc = rdev->desc;
+
+	if (!rdev)
+		return -EINVAL;
+
+	switch (axp20x->variant) {
+	case AXP209_ID:
+		if ((desc->id == AXP20X_LDO3) &&
+		    rdev->constraints && rdev->constraints->soft_start) {
+			int v_out;
+			int ret;
+
+			/*
+			 * On some boards, the LDO3 can be overloaded when
+			 * turning on, causing the entire PMIC to shutdown
+			 * without warning. Turning it on at the minimal voltage
+			 * and then setting the voltage to the requested value
+			 * works reliably.
+			 */
+			if (regulator_is_enabled_regmap(rdev))
+				break;
+
+			v_out = regulator_get_voltage_sel_regmap(rdev);
+			if (v_out < 0)
+				return v_out;
+
+			if (v_out == 0)
+				break;
+
+			ret = regulator_set_voltage_sel_regmap(rdev, 0x00);
+			/*
+			 * A small pause is needed between
+			 * setting the voltage and enabling the LDO to give the
+			 * internal state machine time to process the request.
+			 */
+			usleep_range(1000, 5000);
+			ret |= regulator_enable_regmap(rdev);
+			ret |= regulator_set_voltage_sel_regmap(rdev, v_out);
+
+			return ret;
+		}
+		break;
+	default:
+		/* No quirks */
+		break;
+	}
+
+	return regulator_enable_regmap(rdev);
+};
+
 static const struct regulator_ops axp20x_ops_fixed = {
 	.list_voltage		= regulator_list_voltage_linear,
 };
@@ -447,7 +502,7 @@ static const struct regulator_ops axp20x_ops = {
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
 	.list_voltage		= regulator_list_voltage_linear,
-	.enable			= regulator_enable_regmap,
+	.enable			= axp20x_regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
 	.is_enabled		= regulator_is_enabled_regmap,
 	.set_ramp_delay		= axp20x_set_ramp_delay,
-- 
2.19.0.rc2

