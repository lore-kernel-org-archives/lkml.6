Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153D0C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F73218EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546621755;
	bh=+fcl0PjsTro93+snGeoRTeKaBLtozQ3vuwLZDVKguEQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=iufNnO/LDHq7Li25C/2T7amj0Y667yp6j4zDgM4+xxKbmiWhE589mE/1oDGu5UJKK
	 FnB/KqLzdtfwBnsrplih0SXbzNZmU1NCebd4FqFVXtv8vjb0qa0bwGwW8tgCIUEXt+
	 3u/R6DSLOZ4LvkOm6YTUr1o37p+wuta0PbkYWpqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbfADRJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:09:14 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58956 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbfADRJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 12:09:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=e0fBSdAO5PjtDC0wVBHORxbqwBWBFdz5+Jgee6FFlAc=; b=o+9M8zE+cDGl
        p30WLc0yGdUOAw+oZUYUpecTzjVHTQRpoIOBV0ofXK3Ao4hFuqeJU0uTDoLNREDYW7yk7pP3EOY1S
        kXMF01ynX0J1XKhxGpnUWoa9uhAsaXfuSeGShk8uBSjKUb89ow0ARsB2MO2p244aCYH6+BNf5+Rl2
        ZudqI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gfSy5-0001pQ-3L; Fri, 04 Jan 2019 17:09:09 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 7DD6F11270A3; Fri,  4 Jan 2019 17:09:08 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: rockchip: add workaround for silence of rk3288 ACODEC" to the asoc tree
In-Reply-To:  <20181220153636.5213-2-katsuhiro@katsuster.net>
X-Patchwork-Hint: ignore
Message-Id: <20190104170908.7DD6F11270A3@debutante.sirena.org.uk>
Date:   Fri,  4 Jan 2019 17:09:08 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rockchip: add workaround for silence of rk3288 ACODEC

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

From f5758544d98c8bec7793aeea28928f5e8bd45d47 Mon Sep 17 00:00:00 2001
From: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Date: Fri, 21 Dec 2018 00:36:36 +0900
Subject: [PATCH] ASoC: rockchip: add workaround for silence of rk3288 ACODEC

This patch adds reset and precharge in shutdown of PCM device.

ACODEC goes to silence if we change Fs to 44.1kHz from 48kHz. This
workaround seems to work but I don't know this workaround is correct
sequence or not for ACODEC.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rk3328_codec.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rk3328_codec.c b/sound/soc/codecs/rk3328_codec.c
index 71f3fc2d970c..f3442a2283ea 100644
--- a/sound/soc/codecs/rk3328_codec.c
+++ b/sound/soc/codecs/rk3328_codec.c
@@ -261,9 +261,12 @@ static int rk3328_codec_close_playback(struct rk3328_codec_priv *rk3328)
 		mdelay(1);
 	}
 
+	/* Workaround for silence when changed Fs 48 -> 44.1kHz */
+	rk3328_codec_reset(rk3328);
+
 	regmap_update_bits(rk3328->regmap, DAC_PRECHARGE_CTRL,
 			   DAC_CHARGE_CURRENT_ALL_MASK,
-			   DAC_CHARGE_CURRENT_I);
+			   DAC_CHARGE_CURRENT_ALL_ON);
 
 	return 0;
 }
-- 
2.20.1

