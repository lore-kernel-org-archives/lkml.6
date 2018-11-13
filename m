Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DA7C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B7A2251B
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Pwv/TnKG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51B7A2251B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730848AbeKNFpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:45:24 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50722 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbeKNFpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:45:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Mac7ZB8OwkErzpJrkq30qtWgYC+fFU2AEx867EBytrA=; b=Pwv/TnKGFbll
        8lasf2yCa7EG6X1klraU9yNHHnhigk14Hwyan3/dt78X16TJuTwM3D+no5et8ihSaI366WUK9KGw9
        XIIq3qs0VMl454+p5nDYxL/RBF+xl55AmfyurO5RO8mezYzTHKLwFUbM38KR0kozMWl6COuC26sB5
        6cGEs=;
Received: from [64.114.255.97] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gMed4-0002VQ-3B; Tue, 13 Nov 2018 19:45:42 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 23989440078; Tue, 13 Nov 2018 19:45:36 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>,
        Ravulapati Vishnu vardhan Rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Vijendar Mukunda <vijendar.mukunda@amd.com>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER, MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Vishnuvardhanrao.Ravulapati@amd.com,
        Mark Brown <broonie@kernel.org>, Alexander.Deucher@amd.com,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: amd: add acp3x runtime pm ops" to the asoc tree
In-Reply-To:  <1542000903-19020-10-git-send-email-Vijendar.Mukunda@amd.com>
Message-Id: <20181113194536.23989440078@finisterre.ee.mobilebroadband>
Date:   Tue, 13 Nov 2018 19:45:36 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: amd: add acp3x runtime pm ops

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

From 56e4dd8f68019f50a885be9122981f1899cd89ed Mon Sep 17 00:00:00 2001
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Date: Mon, 12 Nov 2018 11:05:00 +0530
Subject: [PATCH] ASoC: amd: add acp3x runtime pm ops

Added runtime PM operations for ACP3x PCM platform device.

Signed-off-by: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
Tested-by: Ravulapati Vishnu vardhan Rao <Vishnuvardhanrao.Ravulapati@amd.com>
Signed-off-by: Vijendar Mukunda <vijendar.mukunda@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 39 +++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index 15a5f3b4db71..710c5c5ae625 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/pm_runtime.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -660,6 +661,9 @@ static int acp3x_audio_probe(struct platform_device *pdev)
 		goto dev_err;
 	}
 
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 10000);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
 	return 0;
 dev_err:
 	status = acp3x_deinit(adata->acp3x_base);
@@ -682,14 +686,49 @@ static int acp3x_audio_remove(struct platform_device *pdev)
 	else
 		dev_info(&pdev->dev, "ACP de-initialized\n");
 
+	pm_runtime_disable(&pdev->dev);
 	return 0;
 }
 
+static int acp3x_pcm_runtime_suspend(struct device *dev)
+{
+	int status;
+	struct i2s_dev_data *adata = dev_get_drvdata(dev);
+
+	status = acp3x_deinit(adata->acp3x_base);
+	if (status)
+		dev_err(dev, "ACP de-init failed\n");
+	else
+		dev_info(dev, "ACP de-initialized\n");
+
+	rv_writel(0, adata->acp3x_base + mmACP_EXTERNAL_INTR_ENB);
+
+	return 0;
+}
+
+static int acp3x_pcm_runtime_resume(struct device *dev)
+{
+	int status;
+	struct i2s_dev_data *adata = dev_get_drvdata(dev);
+
+	status = acp3x_init(adata->acp3x_base);
+	if (status)
+		return -ENODEV;
+	rv_writel(1, adata->acp3x_base + mmACP_EXTERNAL_INTR_ENB);
+	return 0;
+}
+
+static const struct dev_pm_ops acp3x_pm_ops = {
+	.runtime_suspend = acp3x_pcm_runtime_suspend,
+	.runtime_resume = acp3x_pcm_runtime_resume,
+};
+
 static struct platform_driver acp3x_dma_driver = {
 	.probe = acp3x_audio_probe,
 	.remove = acp3x_audio_remove,
 	.driver = {
 		.name = "acp3x_rv_i2s",
+		.pm = &acp3x_pm_ops,
 	},
 };
 
-- 
2.19.1

