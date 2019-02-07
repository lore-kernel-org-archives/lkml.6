Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00999C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50112175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549541781;
	bh=hkgYwArp6as184/xTAJlTB+YAVYZXI7d09TbRpBlTTk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=QacH0lTcgIy31BIp7ZUEYZooL1whYPtmjZhmWw8UiEIvfNg7QvCIv4mu41UdsBYCK
	 ngG1P2Vij6t+pLFYAbqY6GiAFfhmA0RAZqrYJugoBh7rhvMr037zu1FgoN10EOSFz6
	 tF6SfW6JqfuOqQBMaDU1WBk1YAdQOA8P9S55Pc90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfBGMQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:16:20 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41560 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfBGMQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:16:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=MrsaG6iFkSxO3C/XbKr/61fkO1l3IfXqdRAcNRexF90=; b=gYSi9deIfkDl
        L7WU59o15/gWVVqfywpfsJGFBGutGkzfDYKXzMkD70qioxmNbwD7mcyjC2xoVEF3sjcP4chlgghjP
        HtK8ESHrqW9i1llQcWHzsMyyu2ukboGab7J9IrQODspthFXy4F/O5utEAMxT1vgOwzdNg4KSREPCz
        OZC74=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1grib9-0004vk-Pr; Thu, 07 Feb 2019 12:16:07 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 712341127EF9; Thu,  7 Feb 2019 12:16:07 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild test robot <fengguang.wu@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        kbuild-all@01.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: wcd9335: fix semicolon.cocci warnings" to the asoc tree
In-Reply-To:  <20190204213325.GA104011@lkp-hsx02>
X-Patchwork-Hint: ignore
Message-Id: <20190207121607.712341127EF9@debutante.sirena.org.uk>
Date:   Thu,  7 Feb 2019 12:16:07 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: wcd9335: fix semicolon.cocci warnings

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

From afb86626509205b009d636dcc098066ccf3954c6 Mon Sep 17 00:00:00 2001
From: kbuild test robot <lkp@intel.com>
Date: Tue, 5 Feb 2019 05:33:25 +0800
Subject: [PATCH] ASoC: wcd9335: fix semicolon.cocci warnings

sound/soc/codecs/wcd-clsh-v2.c:545:2-3: Unneeded semicolon
sound/soc/codecs/wcd-clsh-v2.c:211:2-3: Unneeded semicolon
sound/soc/codecs/wcd-clsh-v2.c:250:2-3: Unneeded semicolon

 Remove unneeded semicolon.

Generated by: scripts/coccinelle/misc/semicolon.cocci

Fixes: cc2e324d39b2 ("ASoC: wcd9335: add CLASS-H Controller support")
CC: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wcd-clsh-v2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wcd-clsh-v2.c b/sound/soc/codecs/wcd-clsh-v2.c
index 1bd70c5a7b63..c397d713f01a 100644
--- a/sound/soc/codecs/wcd-clsh-v2.c
+++ b/sound/soc/codecs/wcd-clsh-v2.c
@@ -208,7 +208,7 @@ static void wcd_clsh_set_gain_path(struct wcd_clsh_ctrl *ctrl, int mode)
 	case CLS_H_LP:
 		val = WCD9XXX_HPH_CONST_SEL_LP_PATH;
 		break;
-	};
+	}
 
 	snd_soc_component_update_bits(comp, WCD9XXX_HPH_L_EN,
 					WCD9XXX_HPH_CONST_SEL_L_MASK,
@@ -247,7 +247,7 @@ static void wcd_clsh_set_hph_mode(struct snd_soc_component *comp,
 		val = WCD9XXX_A_ANA_HPH_PWR_LEVEL_LP;
 		ipeak = WCD9XXX_CLASSH_CTRL_CCL_1_DELTA_IPEAK_30MA;
 		break;
-	};
+	}
 
 	snd_soc_component_update_bits(comp, WCD9XXX_A_ANA_HPH,
 					WCD9XXX_A_ANA_HPH_PWR_LEVEL_MASK, val);
@@ -542,7 +542,7 @@ int wcd_clsh_ctrl_set_state(struct wcd_clsh_ctrl *ctrl,
 	case WCD_CLSH_EVENT_POST_PA:
 		_wcd_clsh_ctrl_set_state(ctrl, nstate, CLSH_REQ_DISABLE, mode);
 		break;
-	};
+	}
 
 	ctrl->state = nstate;
 	ctrl->mode = mode;
-- 
2.20.1

