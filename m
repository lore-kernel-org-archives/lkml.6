Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A981C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D138020870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544724691;
	bh=yd9H0xBqZIlyXlAcZJWTHXwadbaLBUa+SU1kgaX6Or8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=1RDpO7Z4KC94ItpAszSY4x3/QteQH4fh+OFdHpx2AVlCiPFfYK0R75papBApJdOJ3
	 /8SlL/3yFkualwfpP/VjTLyRWFn4XmrNqRGDgI111ta53QfMxKkpFSWPeFQZBnO8vw
	 MYDd6WXw55XG2uZzXCrSuQIUMkMwP09XZP13bpDU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D138020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbeLMSL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 13:11:29 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37194 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbeLMSL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 13:11:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=xb4olY8YyV0MlBUgRpCusoCTHfpyzp71vb60Z5ZQD2c=; b=mn2HMH7c2fV+
        wqkoCmR5AhAMSwEy7w9s35f/Qzf7lEnH1kjtnNef7TRr/t0dHkjCEiTU/eD1PWnP0X53qOtt5+KbM
        fic7OAcs0VR6wOs4/Y0RmTecpN/nV9WkcR3FOgoMuI6xuudRywhlGuhKysHP2fMrdfXAUp0x6aSjL
        j7Kzs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gXVSI-0002Qg-Et; Thu, 13 Dec 2018 18:11:26 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 2E02711254D1; Thu, 13 Dec 2018 18:11:26 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regmap: irq: handle HW using separate rising/falling edge interrupts" to the regmap tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20181213181126.2E02711254D1@debutante.sirena.org.uk>
Date:   Thu, 13 Dec 2018 18:11:26 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regmap: irq: handle HW using separate rising/falling edge interrupts

has been applied to the regmap tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git 

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

From bc998a730367a69a1449320d321187d7414668fa Mon Sep 17 00:00:00 2001
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Fri, 7 Dec 2018 14:04:52 +0100
Subject: [PATCH] regmap: irq: handle HW using separate rising/falling edge
 interrupts

Some interrupt controllers use separate bits for controlling rising
and falling edge interrupts in the mask register i.e. they have one
interrupt for rising edge and one for falling.

We already handle the case where we have a single interrupt in the
mask register and a separate type configuration register.

Add a new switch to regmap_irq_chip which tells the framework to use
the mask_base address for configuring the edge of the interrupts that
define type_falling/rising_mask values.

For such interrupts we never update the type_base bits. For interrupts
that don't define type masks or their regmap irq chip doesn't set the
type_in_mask to true everything stays the same.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap-irq.c | 64 ++++++++++++++++++++++----------
 include/linux/regmap.h           |  4 ++
 2 files changed, 48 insertions(+), 20 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 429ca8ed7e51..603b1554f81c 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -157,20 +157,23 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 		}
 	}
 
-	for (i = 0; i < d->chip->num_type_reg; i++) {
-		if (!d->type_buf_def[i])
-			continue;
-		reg = d->chip->type_base +
-			(i * map->reg_stride * d->type_reg_stride);
-		if (d->chip->type_invert)
-			ret = regmap_irq_update_bits(d, reg,
-				d->type_buf_def[i], ~d->type_buf[i]);
-		else
-			ret = regmap_irq_update_bits(d, reg,
-				d->type_buf_def[i], d->type_buf[i]);
-		if (ret != 0)
-			dev_err(d->map->dev, "Failed to sync type in %x\n",
-				reg);
+	/* Don't update the type bits if we're using mask bits for irq type. */
+	if (!d->chip->type_in_mask) {
+		for (i = 0; i < d->chip->num_type_reg; i++) {
+			if (!d->type_buf_def[i])
+				continue;
+			reg = d->chip->type_base +
+				(i * map->reg_stride * d->type_reg_stride);
+			if (d->chip->type_invert)
+				ret = regmap_irq_update_bits(d, reg,
+					d->type_buf_def[i], ~d->type_buf[i]);
+			else
+				ret = regmap_irq_update_bits(d, reg,
+					d->type_buf_def[i], d->type_buf[i]);
+			if (ret != 0)
+				dev_err(d->map->dev, "Failed to sync type in %x\n",
+					reg);
+		}
 	}
 
 	if (d->chip->runtime_pm)
@@ -194,8 +197,27 @@ static void regmap_irq_enable(struct irq_data *data)
 	struct regmap_irq_chip_data *d = irq_data_get_irq_chip_data(data);
 	struct regmap *map = d->map;
 	const struct regmap_irq *irq_data = irq_to_regmap_irq(d, data->hwirq);
+	unsigned int mask, type;
+
+	type = irq_data->type_falling_mask | irq_data->type_rising_mask;
+
+	/*
+	 * The type_in_mask flag means that the underlying hardware uses
+	 * separate mask bits for rising and falling edge interrupts, but
+	 * we want to make them into a single virtual interrupt with
+	 * configurable edge.
+	 *
+	 * If the interrupt we're enabling defines the falling or rising
+	 * masks then instead of using the regular mask bits for this
+	 * interrupt, use the value previously written to the type buffer
+	 * at the corresponding offset in regmap_irq_set_type().
+	 */
+	if (d->chip->type_in_mask && type)
+		mask = d->type_buf[irq_data->reg_offset / map->reg_stride];
+	else
+		mask = irq_data->mask;
 
-	d->mask_buf[irq_data->reg_offset / map->reg_stride] &= ~irq_data->mask;
+	d->mask_buf[irq_data->reg_offset / map->reg_stride] &= ~mask;
 }
 
 static void regmap_irq_disable(struct irq_data *data)
@@ -430,6 +452,7 @@ int regmap_add_irq_chip(struct regmap *map, int irq, int irq_flags,
 	struct regmap_irq_chip_data *d;
 	int i;
 	int ret = -ENOMEM;
+	int num_type_reg;
 	u32 reg;
 	u32 unmask_offset;
 
@@ -479,13 +502,14 @@ int regmap_add_irq_chip(struct regmap *map, int irq, int irq_flags,
 			goto err_alloc;
 	}
 
-	if (chip->num_type_reg) {
-		d->type_buf_def = kcalloc(chip->num_type_reg,
-					sizeof(unsigned int), GFP_KERNEL);
+	num_type_reg = chip->type_in_mask ? chip->num_regs : chip->num_type_reg;
+	if (num_type_reg) {
+		d->type_buf_def = kcalloc(num_type_reg,
+					  sizeof(unsigned int), GFP_KERNEL);
 		if (!d->type_buf_def)
 			goto err_alloc;
 
-		d->type_buf = kcalloc(chip->num_type_reg, sizeof(unsigned int),
+		d->type_buf = kcalloc(num_type_reg, sizeof(unsigned int),
 				      GFP_KERNEL);
 		if (!d->type_buf)
 			goto err_alloc;
@@ -600,7 +624,7 @@ int regmap_add_irq_chip(struct regmap *map, int irq, int irq_flags,
 		}
 	}
 
-	if (chip->num_type_reg) {
+	if (chip->num_type_reg && !chip->type_in_mask) {
 		for (i = 0; i < chip->num_irqs; i++) {
 			reg = chip->irqs[i].type_reg_offset / map->reg_stride;
 			d->type_buf_def[reg] |= chip->irqs[i].type_rising_mask |
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 3930f3331652..c54c778f3051 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1137,6 +1137,9 @@ struct regmap_irq {
  * @ack_invert:  Inverted ack register: cleared bits for ack.
  * @wake_invert: Inverted wake register: cleared bits are wake enabled.
  * @type_invert: Invert the type flags.
+ * @type_in_mask: Use the mask registers for controlling irq type. For
+ *                interrupts defining type_rising/falling_mask use mask_base
+ *                for edge configuration and never update bits in type_base.
  * @runtime_pm:  Hold a runtime PM lock on the device when accessing it.
  *
  * @num_regs:    Number of registers in each control bank.
@@ -1175,6 +1178,7 @@ struct regmap_irq_chip {
 	bool wake_invert:1;
 	bool runtime_pm:1;
 	bool type_invert:1;
+	bool type_in_mask:1;
 
 	int num_regs;
 
-- 
2.19.0.rc2

