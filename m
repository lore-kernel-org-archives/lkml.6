Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A98C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD534214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547121289;
	bh=pnGi9ghz+sruP4xD27/HKWPCbuX1k5hgPZ3INB7x8Ko=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=h2rCIn8QtFuVs5c9/vJvY0VsmV5RlSj1ftCXwFnaqoBt45PRbf/cOckr3rTN4Wja9
	 bX+BCDvPRTEeRd1FKp7ThAUNYSmyTXFWuC84PvjxnHvbbcezNve9p1aFGu5Wgmn8aS
	 a64YN1tY4o6riq/JpowVflwG+dgsY2bldc6PQkgs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbfAJLys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 06:54:48 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:32856 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbfAJLyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 06:54:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=9ii/SwTbzoAw7ZUDADMijsWgJ6Y/Kph6hmRMA8PIEOQ=; b=I1va7rdqO+5d
        3FsOApzx3/1q91pST+GMS39jRqdY6wc9qFVgciGZk8AJuL2pVMshv8vLVRVY2l301lNcH1I2DqhnF
        LDoa6IbLmC4TKAN8xDKnBy5m+NXLnqyp7MJLraRt5Vy0R8tUFlrHptFcsL3G7HxKk7wdfdhyvE0dr
        DCh/g=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ghYut-0003Pi-Cy; Thu, 10 Jan 2019 11:54:31 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 092A91127052; Thu, 10 Jan 2019 11:54:26 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: Intel: bytcht_es8316: use correct drvdata in snd_byt_cht_es8316_mc_remove()" to the asoc tree
In-Reply-To:  <1547084589-40006-1-git-send-email-weiyongjun1@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190110115426.092A91127052@debutante.sirena.org.uk>
Date:   Thu, 10 Jan 2019 11:54:26 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: Intel: bytcht_es8316: use correct drvdata in snd_byt_cht_es8316_mc_remove()

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

From f833fe2056b3a6d69598ef029cede6e77dcc1b14 Mon Sep 17 00:00:00 2001
From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Thu, 10 Jan 2019 01:43:09 +0000
Subject: [PATCH] ASoC: Intel: bytcht_es8316: use correct drvdata in
 snd_byt_cht_es8316_mc_remove()

The snd_byt_cht_es8316_mc_remove() use the platform drvdata as a type
of 'struct byt_cht_es8316_private', but snd_byt_cht_es8316_mc_probe()
set it to 'struct snd_soc_card', as suggested by Dan Carpenter, fix
the usage in snd_byt_cht_es8316_mc_remove().

Fixes: 0d3e91da0750 ("ASoC: Intel: bytcht_es8316: Add external speaker mux support")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcht_es8316.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index cdf2061e7613..fa9c4cf97686 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -544,7 +544,8 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 
 static int snd_byt_cht_es8316_mc_remove(struct platform_device *pdev)
 {
-	struct byt_cht_es8316_private *priv = platform_get_drvdata(pdev);
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+	struct byt_cht_es8316_private *priv = snd_soc_card_get_drvdata(card);
 
 	gpiod_put(priv->speaker_en_gpio);
 	return 0;
-- 
2.20.1

