Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58B3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8407D2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551198192;
	bh=X8h2/359Bb+qhebchhSM40pOp3GqCY/skeJluwiMdO0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=owYQM0BNN3OTvj4ar6f6JBfF/5z1YUkKA/WtGLjmsQ3t7StiEI6OcFYq5yCyauPS2
	 /3yPwFApcVIcRwOwa/SxjuANzjtZ+XEkYj3jPF4GFZJapkS/2oKBKDPVMV/H7jo2fZ
	 caGwteQwyZ/60udU5aWr/5fcZQmw83VEkkbND050=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbfBZQWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:22:40 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36034 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbfBZQWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 11:22:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=CRGUZseCBUYky7YtEIegsc/Lop0x0iU+0+L7EcP9ZtI=; b=awnD1nky0zmB
        Eu/6urr75UfFz4RGXAc7UhUWF7yvIuwoHqstpklqVotUK5VJf/yNuOa3GGPJ0l9mvivEYOQUfBgkm
        yEaQu9jnf+2HpWRulJCwxOR8/ojB4MANDvF1UWpbetIqWiMVGoTXZav1pU8KulDyFrJIpx7P9Xi2/
        9r0so=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gyfUy-000096-6W; Tue, 26 Feb 2019 16:22:28 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6DEFC1121A0A; Tue, 26 Feb 2019 16:22:27 +0000 (GMT)
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
Subject: Applied "ASoC: stm32: i2s: remove useless callback" to the asoc tree
In-Reply-To:  <1551189070-15469-6-git-send-email-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190226162227.6DEFC1121A0A@debutante.sirena.org.uk>
Date:   Tue, 26 Feb 2019 16:22:27 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: stm32: i2s: remove useless callback

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

From 88dce52ee9b58b627cf75f5aeb53ab5ea6340472 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Tue, 26 Feb 2019 14:51:08 +0100
Subject: [PATCH] ASoC: stm32: i2s: remove useless callback

Clocks do not need to be released on driver removal,
as this is already managed before.
Remove useless remove callback.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_i2s.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 95fffb61faa5..9edb753ffa1b 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -902,16 +902,6 @@ static int stm32_i2s_probe(struct platform_device *pdev)
 				  I2S_CGFR_I2SMOD, I2S_CGFR_I2SMOD);
 }
 
-static int stm32_i2s_remove(struct platform_device *pdev)
-{
-	struct stm32_i2s_data *i2s = platform_get_drvdata(pdev);
-
-	clk_disable_unprepare(i2s->i2sclk);
-	clk_disable_unprepare(i2s->pclk);
-
-	return 0;
-}
-
 MODULE_DEVICE_TABLE(of, stm32_i2s_ids);
 
 #ifdef CONFIG_PM_SLEEP
@@ -945,7 +935,6 @@ static struct platform_driver stm32_i2s_driver = {
 		.pm = &stm32_i2s_pm_ops,
 	},
 	.probe = stm32_i2s_probe,
-	.remove = stm32_i2s_remove,
 };
 
 module_platform_driver(stm32_i2s_driver);
-- 
2.20.1

