Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC98C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F042087F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544724671;
	bh=hNsfgtUxAcWYZxddKBkwXD2XLdUUHTxVFNq2jjotZUY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Uw5DX8Kys/gEaIt7wYOCAk/xgE7rvjZa3LlWfVD3jmlaFHxEY50Aptq6Jttgt6pfL
	 sOwtVwfifNPCJWwTDq5V4dA6yCtpEECn97EXGL9sgMlesxaE5c+CXCI/R1FPwNfwfD
	 kwit36SPdsSJKSoYccooJ61BZlaFrJUeE0W6Whak=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6F042087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbeLMSLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 13:11:10 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36580 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbeLMSLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 13:11:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=9oKAvdPFrYLHCugaf1jYrpc5CVM1vdxr3YeefcYI7R8=; b=QscdVVphWrBx
        SqWwrd2kQvS63/WLZH1/30TZEkjT1dBA7ArRH910E3mr+SPg9JVP0D3CYguGku89iVbPAx6zTiP4L
        7UN+GkReIWezFy74waUq22wu4ZZeto9J2yVTOqI/Xk7t9P/CkZ77Uri25cFWqvJ7swkXSgt5ZXQP4
        z7HSA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gXVRp-0002Oo-Q9; Thu, 13 Dec 2018 18:10:57 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 62C0011254D1; Thu, 13 Dec 2018 18:10:57 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Rohit kumar <rohitkr@codeaurora.org>
Cc:     Mark Brown <broonie@kernel.org>, plai@codeaurora.org,
        bgoswami@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com,
        srinivas.kandagatla@linaro.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: core: Invoke pcm_new() for all DAI-link" to the asoc tree
In-Reply-To:  <1541075929-29323-1-git-send-email-rohitkr@codeaurora.org>
X-Patchwork-Hint: ignore
Message-Id: <20181213181057.62C0011254D1@debutante.sirena.org.uk>
Date:   Thu, 13 Dec 2018 18:10:57 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: core: Invoke pcm_new() for all DAI-link

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

From de17f14ea576d8a0f2932404467fa916542da94d Mon Sep 17 00:00:00 2001
From: Rohit kumar <rohitkr@codeaurora.org>
Date: Thu, 1 Nov 2018 18:08:49 +0530
Subject: [PATCH] ASoC: core: Invoke pcm_new() for all DAI-link

Remove no_pcm check to invoke pcm_new() for backend dai-links
too. This fixes crash in hdmi codec driver during hdmi_codec_startup()
while accessing chmap_info struct. chmap_info struct memory is
allocated in pcm_new() of hdmi codec driver which is not invoked
in case of DPCM when hdmi codec driver is part of backend dai-link.

Below is the crash stack:

[   61.635493] Unable to handle kernel NULL pointer dereference at virtual address 00000018
..
[   61.666696]   CM = 0, WnR = 1
[   61.669778] user pgtable: 4k pages, 39-bit VAs, pgd = ffffffc0d6633000
[   61.676526] [0000000000000018] *pgd=0000000153fc8003, *pud=0000000153fc8003, *pmd=0000000000000000
[   61.685793] Internal error: Oops: 96000046 [#1] PREEMPT SMP
[   61.722955] CPU: 7 PID: 2238 Comm: aplay Not tainted 4.14.72 #21
..
[   61.740269] PC is at hdmi_codec_startup+0x124/0x164
[   61.745308] LR is at hdmi_codec_startup+0xe4/0x164

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b0db59e6339d..0462b3ec977a 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1467,7 +1467,7 @@ static int soc_link_dai_pcm_new(struct snd_soc_dai **dais, int num_dais,
 	for (i = 0; i < num_dais; ++i) {
 		struct snd_soc_dai_driver *drv = dais[i]->driver;
 
-		if (!rtd->dai_link->no_pcm && drv->pcm_new)
+		if (drv->pcm_new)
 			ret = drv->pcm_new(rtd, dais[i]);
 		if (ret < 0) {
 			dev_err(dais[i]->dev,
-- 
2.19.0.rc2

