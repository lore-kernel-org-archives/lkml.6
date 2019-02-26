Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF58C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940F221871
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551182805;
	bh=it6hoDTLgvQFVKJeYF28WPtt85lp+WGhzoOWWgQasX8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=eKcDGRzvbu/0pKKXf680jP9arQWkJoPilxa0nhVq0CgNSsubr43OfFRoY4WD0sijI
	 4jgKiiqwEX+WEB/7PIozxDnbq7gkhQjshtMkLb9eJcJNenZvpSpZwOoHyn+XLq9RfI
	 Tznx+juMb4O65ZMbsbHHpcD/dNZsemMwk5qINWc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfBZMGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:06:43 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57874 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfBZMGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 07:06:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=h69tZeIg+iAIWWSgIDx1lo0jdDdyzy+q24a/sx7hS7k=; b=bk9LC0N2qDdL
        DMC86ZS82NdFFEC6QIREvs8BDkdSc6v9zqrVPlnbj4WwIExBEKjz+y3Duc0G5bag3bfM1JYoYI83g
        FJKa/t6jI7Hl18xL/9EeySgIZIrLiGVutrmeKFWCyu2/6cSls4k5kR00yedwFJxHti7akovAJNxom
        d8JbY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gybV7-0007hU-74; Tue, 26 Feb 2019 12:06:21 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B465F11284E3; Tue, 26 Feb 2019 12:06:20 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Jiada Wang <jiada_wang@mentor.com>
Cc:     Timo Wischer <twischer@de.adit-jv.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>, patch@alsa-project.org,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        kuninori.morimoto.gx@renesas.com,
        linux-renesas-soc@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Timo Wischer <twischer@de.adit-jv.com>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: rsnd: gen: fix SSI9 4/5/6/7 busif related register address" to the asoc tree
In-Reply-To:  <1551093260-28998-1-git-send-email-twischer@de.adit-jv.com>
X-Patchwork-Hint: ignore
Message-Id: <20190226120620.B465F11284E3@debutante.sirena.org.uk>
Date:   Tue, 26 Feb 2019 12:06:20 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rsnd: gen: fix SSI9 4/5/6/7 busif related register address

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

From 8af6c521cc236534093f9e744cfa004314bfe5ae Mon Sep 17 00:00:00 2001
From: Jiada Wang <jiada_wang@mentor.com>
Date: Mon, 25 Feb 2019 12:14:20 +0100
Subject: [PATCH] ASoC: rsnd: gen: fix SSI9 4/5/6/7 busif related register
 address

Currently each SSI unit 's busif mode/adinr/dalign address is
registered by: (in busif4 case)
RSND_GEN_M_REG(SSI_BUSIF4_MODE, 0x500, 0x80)
RSND_GEN_M_REG(SSI_BUSIF4_ADINR,0x504, 0x80)
RSND_GEN_M_REG(SSI_BUSIF4_DALIGN, 0x508, 0x80)

But according to user manual 41.1.4 Register Configuration
ssi9 4/5/6/7 busif mode/adinr/dalign register address
( SSI9-[4/5/6/7]_BUSIF_[MODE/ADINR/DALIGN] )
are out of this rule.

This patch registers ssi9 4/5/6/7 mode/adinr/dalign register
as single register, and access these registers in case of
SSI9 BUSIF 4/5/6/7.

Fixes: commit 8c9d75033340 ("ASoC: rsnd: ssiu: Support BUSIF other than BUSIF0")
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/gen.c  | 24 ++++++++++++++++++++++++
 sound/soc/sh/rcar/rsnd.h | 27 +++++++++++++++++++++++++++
 sound/soc/sh/rcar/ssiu.c | 24 +++++++++++-------------
 3 files changed, 62 insertions(+), 13 deletions(-)

diff --git a/sound/soc/sh/rcar/gen.c b/sound/soc/sh/rcar/gen.c
index 7cda60188f41..af19010b9d88 100644
--- a/sound/soc/sh/rcar/gen.c
+++ b/sound/soc/sh/rcar/gen.c
@@ -255,6 +255,30 @@ static int rsnd_gen2_probe(struct rsnd_priv *priv)
 		RSND_GEN_M_REG(SSI_MODE,		0xc,	0x80),
 		RSND_GEN_M_REG(SSI_CTRL,		0x10,	0x80),
 		RSND_GEN_M_REG(SSI_INT_ENABLE,		0x18,	0x80),
+		RSND_GEN_S_REG(SSI9_BUSIF0_MODE,	0x48c),
+		RSND_GEN_S_REG(SSI9_BUSIF0_ADINR,	0x484),
+		RSND_GEN_S_REG(SSI9_BUSIF0_DALIGN,	0x488),
+		RSND_GEN_S_REG(SSI9_BUSIF1_MODE,	0x4a0),
+		RSND_GEN_S_REG(SSI9_BUSIF1_ADINR,	0x4a4),
+		RSND_GEN_S_REG(SSI9_BUSIF1_DALIGN,	0x4a8),
+		RSND_GEN_S_REG(SSI9_BUSIF2_MODE,	0x4c0),
+		RSND_GEN_S_REG(SSI9_BUSIF2_ADINR,	0x4c4),
+		RSND_GEN_S_REG(SSI9_BUSIF2_DALIGN,	0x4c8),
+		RSND_GEN_S_REG(SSI9_BUSIF3_MODE,	0x4e0),
+		RSND_GEN_S_REG(SSI9_BUSIF3_ADINR,	0x4e4),
+		RSND_GEN_S_REG(SSI9_BUSIF3_DALIGN,	0x4e8),
+		RSND_GEN_S_REG(SSI9_BUSIF4_MODE,	0xd80),
+		RSND_GEN_S_REG(SSI9_BUSIF4_ADINR,	0xd84),
+		RSND_GEN_S_REG(SSI9_BUSIF4_DALIGN,	0xd88),
+		RSND_GEN_S_REG(SSI9_BUSIF5_MODE,	0xda0),
+		RSND_GEN_S_REG(SSI9_BUSIF5_ADINR,	0xda4),
+		RSND_GEN_S_REG(SSI9_BUSIF5_DALIGN,	0xda8),
+		RSND_GEN_S_REG(SSI9_BUSIF6_MODE,	0xdc0),
+		RSND_GEN_S_REG(SSI9_BUSIF6_ADINR,	0xdc4),
+		RSND_GEN_S_REG(SSI9_BUSIF6_DALIGN,	0xdc8),
+		RSND_GEN_S_REG(SSI9_BUSIF7_MODE,	0xde0),
+		RSND_GEN_S_REG(SSI9_BUSIF7_ADINR,	0xde4),
+		RSND_GEN_S_REG(SSI9_BUSIF7_DALIGN,	0xde8),
 	};
 
 	static const struct rsnd_regmap_field_conf conf_scu[] = {
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 605e4b934982..90625c57847b 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -191,6 +191,30 @@ enum rsnd_reg {
 	SSI_SYS_STATUS7,
 	HDMI0_SEL,
 	HDMI1_SEL,
+	SSI9_BUSIF0_MODE,
+	SSI9_BUSIF1_MODE,
+	SSI9_BUSIF2_MODE,
+	SSI9_BUSIF3_MODE,
+	SSI9_BUSIF4_MODE,
+	SSI9_BUSIF5_MODE,
+	SSI9_BUSIF6_MODE,
+	SSI9_BUSIF7_MODE,
+	SSI9_BUSIF0_ADINR,
+	SSI9_BUSIF1_ADINR,
+	SSI9_BUSIF2_ADINR,
+	SSI9_BUSIF3_ADINR,
+	SSI9_BUSIF4_ADINR,
+	SSI9_BUSIF5_ADINR,
+	SSI9_BUSIF6_ADINR,
+	SSI9_BUSIF7_ADINR,
+	SSI9_BUSIF0_DALIGN,
+	SSI9_BUSIF1_DALIGN,
+	SSI9_BUSIF2_DALIGN,
+	SSI9_BUSIF3_DALIGN,
+	SSI9_BUSIF4_DALIGN,
+	SSI9_BUSIF5_DALIGN,
+	SSI9_BUSIF6_DALIGN,
+	SSI9_BUSIF7_DALIGN,
 
 	/* SSI */
 	SSICR,
@@ -209,6 +233,9 @@ enum rsnd_reg {
 #define SSI_BUSIF_MODE(i)	(SSI_BUSIF0_MODE + (i))
 #define SSI_BUSIF_ADINR(i)	(SSI_BUSIF0_ADINR + (i))
 #define SSI_BUSIF_DALIGN(i)	(SSI_BUSIF0_DALIGN + (i))
+#define SSI9_BUSIF_MODE(i)	(SSI9_BUSIF0_MODE + (i))
+#define SSI9_BUSIF_ADINR(i)	(SSI9_BUSIF0_ADINR + (i))
+#define SSI9_BUSIF_DALIGN(i)	(SSI9_BUSIF0_DALIGN + (i))
 #define SSI_SYS_STATUS(i)	(SSI_SYS_STATUS0 + (i))
 
 
diff --git a/sound/soc/sh/rcar/ssiu.c b/sound/soc/sh/rcar/ssiu.c
index c74991dd18ab..2347f3404c06 100644
--- a/sound/soc/sh/rcar/ssiu.c
+++ b/sound/soc/sh/rcar/ssiu.c
@@ -181,28 +181,26 @@ static int rsnd_ssiu_init_gen2(struct rsnd_mod *mod,
 	if (rsnd_ssi_use_busif(io)) {
 		int id = rsnd_mod_id(mod);
 		int busif = rsnd_mod_id_sub(mod);
+		enum rsnd_reg adinr_reg, mode_reg, dalign_reg;
 
-		/*
-		 * FIXME
-		 *
-		 * We can't support SSI9-4/5/6/7, because its address is
-		 * out of calculation rule
-		 */
 		if ((id == 9) && (busif >= 4)) {
-			struct device *dev = rsnd_priv_to_dev(priv);
-
-			dev_err(dev, "This driver doesn't support SSI%d-%d, so far",
-				id, busif);
+			adinr_reg = SSI9_BUSIF_ADINR(busif);
+			mode_reg = SSI9_BUSIF_MODE(busif);
+			dalign_reg = SSI9_BUSIF_DALIGN(busif);
+		} else {
+			adinr_reg = SSI_BUSIF_ADINR(busif);
+			mode_reg = SSI_BUSIF_MODE(busif);
+			dalign_reg = SSI_BUSIF_DALIGN(busif);
 		}
 
-		rsnd_mod_write(mod, SSI_BUSIF_ADINR(busif),
+		rsnd_mod_write(mod, adinr_reg,
 			       rsnd_get_adinr_bit(mod, io) |
 			       (rsnd_io_is_play(io) ?
 				rsnd_runtime_channel_after_ctu(io) :
 				rsnd_runtime_channel_original(io)));
-		rsnd_mod_write(mod, SSI_BUSIF_MODE(busif),
+		rsnd_mod_write(mod, mode_reg,
 			       rsnd_get_busif_shift(io, mod) | 1);
-		rsnd_mod_write(mod, SSI_BUSIF_DALIGN(busif),
+		rsnd_mod_write(mod, dalign_reg,
 			       rsnd_get_dalign(mod, io));
 	}
 
-- 
2.20.1

