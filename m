Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D703C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8692184D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551198173;
	bh=MGan8GgYLJLdSvqamkyp7h7lO1lAWzAxC3wdpucAwYE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=MGmBKzESClZA+TMKniXxqFPFWJ373MiNE/M+hng0zbBcI8om6jiKHUkTHagwE9N0r
	 1fosgHdmOLvEzbhq8IBL5zvbrg54rQdihT/tDy3BqkVofTl7fSKyV8JwT/zCdlVMvh
	 4HDALPHBPrLWF4R7ThW8BUMP4K7TzUSyn2Lta9oc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbfBZQWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:22:52 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36352 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbfBZQWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 11:22:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=4Nc9a0wJGEbR1iazYPACCFVA5P0adEytR2EU2ufxVok=; b=qQunmxXtET52
        XYcY2FJPyUhX+SIouM4HFaYwZTTc4V+gqxini3pT8k0HYEzrs+jUp2/2WgUtHdW7hc5HvTiI9fNpO
        QH1+IxJK/AtjXz0s/ZW/mh+UG1SD7xo2QJKBkrp5U/mFDRJrsJLQTaLemG1cK1iojieYKTWcKVgPj
        teO+Q=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gyfV6-00009l-NO; Tue, 26 Feb 2019 16:22:36 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 3FB7D1121A0A; Tue, 26 Feb 2019 16:22:36 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, olivier.moysan@st.com,
        arnaud.pouliquen@st.com, benjamin.gaignard@st.com,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: stm32: i2s: fix IRQ clearing" to the asoc tree
In-Reply-To:  <1551189070-15469-2-git-send-email-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190226162236.3FB7D1121A0A@debutante.sirena.org.uk>
Date:   Tue, 26 Feb 2019 16:22:36 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: stm32: i2s: fix IRQ clearing

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

From 8ba3c5215d69c09f5c39783ff3b78347769822ad Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Tue, 26 Feb 2019 14:51:04 +0100
Subject: [PATCH] ASoC: stm32: i2s: fix IRQ clearing

Because of regmap cache, interrupts may not be cleared
as expected.
Declare IFCR register as write only and make writings
to IFCR register unconditional.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_i2s.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index a25919d32187..339cd4715b2e 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -247,8 +247,8 @@ static irqreturn_t stm32_i2s_isr(int irq, void *devid)
 		return IRQ_NONE;
 	}
 
-	regmap_update_bits(i2s->regmap, STM32_I2S_IFCR_REG,
-			   I2S_IFCR_MASK, flags);
+	regmap_write_bits(i2s->regmap, STM32_I2S_IFCR_REG,
+			  I2S_IFCR_MASK, flags);
 
 	if (flags & I2S_SR_OVR) {
 		dev_dbg(&pdev->dev, "Overrun\n");
@@ -277,7 +277,6 @@ static bool stm32_i2s_readable_reg(struct device *dev, unsigned int reg)
 	case STM32_I2S_CFG2_REG:
 	case STM32_I2S_IER_REG:
 	case STM32_I2S_SR_REG:
-	case STM32_I2S_IFCR_REG:
 	case STM32_I2S_TXDR_REG:
 	case STM32_I2S_RXDR_REG:
 	case STM32_I2S_CGFR_REG:
@@ -559,8 +558,8 @@ static int stm32_i2s_startup(struct snd_pcm_substream *substream,
 	i2s->refcount++;
 	spin_unlock(&i2s->lock_fd);
 
-	return regmap_update_bits(i2s->regmap, STM32_I2S_IFCR_REG,
-				  I2S_IFCR_MASK, I2S_IFCR_MASK);
+	return regmap_write_bits(i2s->regmap, STM32_I2S_IFCR_REG,
+				 I2S_IFCR_MASK, I2S_IFCR_MASK);
 }
 
 static int stm32_i2s_hw_params(struct snd_pcm_substream *substream,
@@ -611,8 +610,8 @@ static int stm32_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 			return ret;
 		}
 
-		regmap_update_bits(i2s->regmap, STM32_I2S_IFCR_REG,
-				   I2S_IFCR_MASK, I2S_IFCR_MASK);
+		regmap_write_bits(i2s->regmap, STM32_I2S_IFCR_REG,
+				  I2S_IFCR_MASK, I2S_IFCR_MASK);
 
 		if (playback_flg) {
 			ier = I2S_IER_UDRIE;
-- 
2.20.1

