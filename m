Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E193C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F189C21850
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551198175;
	bh=KMkTTZjqZrJ/LkYH4ExGNWMdsdH6Oor7dp35TgOwXqc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=GvlOSJNrtqnNMvNfdNlSPRTqnzs61euhNuY2/8Ra1jxtjKcAOJRSg884HSEL4AOtG
	 WC5OL5sfE1DEcnN+9ygyBT6m5iqXCoJ5SDUXO62TEqlhVMd2iIN7rY54e3ShKZBe/Z
	 EpqnJWYD3kGIIV5r3q6XfpsHiGZEsr2pEz2QL48A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbfBZQWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:22:53 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36382 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728814AbfBZQWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 11:22:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=CsiXLuPX7iUWE73DoVzUKNQczrazZ6zsIbdcwSI/GQc=; b=EybjA7FpFQpM
        16e7Abu1v6P00IgFkDrBfamNPPjcZFvLe4LQMGbsuhyEY6dT6MS6P4vga4SG2PnTypXaf8rC40RLm
        OfOFI8/+2F1/m412SBOmhh/RIs/Oud7yjK4kGIWCN3gQbqYEFZafKMwifl2uYsdfwGkMbNwIlTPBQ
        llcno=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gyfV2-00009D-69; Tue, 26 Feb 2019 16:22:32 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id CD2071121A0A; Tue, 26 Feb 2019 16:22:31 +0000 (GMT)
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
Subject: Applied "ASoC: stm32: i2s: fix stream count management" to the asoc tree
In-Reply-To:  <1551189070-15469-4-git-send-email-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190226162231.CD2071121A0A@debutante.sirena.org.uk>
Date:   Tue, 26 Feb 2019 16:22:31 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: stm32: i2s: fix stream count management

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

From ebf629d502cf7aa138b86f36dc016faf6c8e39e3 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Tue, 26 Feb 2019 14:51:06 +0100
Subject: [PATCH] ASoC: stm32: i2s: fix stream count management

Move counter handling to trigger start section
to manage multiple start/stop events.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_i2s.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 7d4c67433916..7f56d7b51ba3 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -554,10 +554,6 @@ static int stm32_i2s_startup(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	spin_lock(&i2s->lock_fd);
-	i2s->refcount++;
-	spin_unlock(&i2s->lock_fd);
-
 	return regmap_write_bits(i2s->regmap, STM32_I2S_IFCR_REG,
 				 I2S_IFCR_MASK, I2S_IFCR_MASK);
 }
@@ -613,18 +609,19 @@ static int stm32_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 		regmap_write_bits(i2s->regmap, STM32_I2S_IFCR_REG,
 				  I2S_IFCR_MASK, I2S_IFCR_MASK);
 
+		spin_lock(&i2s->lock_fd);
+		i2s->refcount++;
 		if (playback_flg) {
 			ier = I2S_IER_UDRIE;
 		} else {
 			ier = I2S_IER_OVRIE;
 
-			spin_lock(&i2s->lock_fd);
 			if (i2s->refcount == 1)
 				/* dummy write to trigger capture */
 				regmap_write(i2s->regmap,
 					     STM32_I2S_TXDR_REG, 0);
-			spin_unlock(&i2s->lock_fd);
 		}
+		spin_unlock(&i2s->lock_fd);
 
 		if (STM32_I2S_IS_SLAVE(i2s))
 			ier |= I2S_IER_TIFREIE;
@@ -649,7 +646,6 @@ static int stm32_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 			spin_unlock(&i2s->lock_fd);
 			break;
 		}
-		spin_unlock(&i2s->lock_fd);
 
 		dev_dbg(cpu_dai->dev, "stop I2S\n");
 
@@ -657,8 +653,10 @@ static int stm32_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 					 I2S_CR1_SPE, 0);
 		if (ret < 0) {
 			dev_err(cpu_dai->dev, "Error %d disabling I2S\n", ret);
+			spin_unlock(&i2s->lock_fd);
 			return ret;
 		}
+		spin_unlock(&i2s->lock_fd);
 
 		cfg1_mask = I2S_CFG1_RXDMAEN | I2S_CFG1_TXDMAEN;
 		regmap_update_bits(i2s->regmap, STM32_I2S_CFG1_REG,
-- 
2.20.1

