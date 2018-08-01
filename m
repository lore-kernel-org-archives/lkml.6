Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C527C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D40208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Lyf3G7lH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D40208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388949AbeHANCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 09:02:39 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50358 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387590AbeHANCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 09:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=JMnHpi32kS0doFk1YhruoTasJXoea/bAXG8RnAHzS2s=; b=Lyf3G7lH6Xeh
        +yO+HeqM/stR/okCgFDzj+4MHeMrahmAAcZkUNFi4Rrj5NmG7FgYELukP2ECcCFUyUVbThAju9Ryz
        w4JEPSrRd+f+qxq533OLiLKhQg9HQ3AKtL0a53wXlgI19y9wQLMOn4D6YNz2HisJi84tyOZpgWN+9
        nGrw0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fkp7j-0000nl-RQ; Wed, 01 Aug 2018 11:16:59 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6C39F1124241; Wed,  1 Aug 2018 12:16:59 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jaya Kumar <jayakumar.alsa@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Olivier Moysan <olivier.moysan@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: stm32: remove redundant pointers 'priv' and 'rtd'" to the asoc tree
In-Reply-To:  <20180801104742.4328-8-colin.king@canonical.com>
Message-Id: <20180801111659.6C39F1124241@debutante.sirena.org.uk>
Date:   Wed,  1 Aug 2018 12:16:59 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: stm32: remove redundant pointers 'priv' and 'rtd'

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

From 18127744cf446f113ca33f07e5cea893388f781a Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Wed, 1 Aug 2018 11:47:40 +0100
Subject: [PATCH] ASoC: stm32: remove redundant pointers 'priv' and 'rtd'

Pointer 'priv' is assigned and not used, removing this allows
the removal of pointer 'rtd'.

Cleans up clang warning:
warning: variable 'priv' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_adfsdm.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/sound/soc/stm/stm32_adfsdm.c b/sound/soc/stm/stm32_adfsdm.c
index 0e9373064032..706ff005234f 100644
--- a/sound/soc/stm/stm32_adfsdm.c
+++ b/sound/soc/stm/stm32_adfsdm.c
@@ -269,16 +269,10 @@ static int stm32_adfsdm_pcm_new(struct snd_soc_pcm_runtime *rtd)
 static void stm32_adfsdm_pcm_free(struct snd_pcm *pcm)
 {
 	struct snd_pcm_substream *substream;
-	struct snd_soc_pcm_runtime *rtd;
-	struct stm32_adfsdm_priv *priv;
 
 	substream = pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream;
-	if (substream) {
-		rtd = substream->private_data;
-		priv = snd_soc_dai_get_drvdata(rtd->cpu_dai);
-
+	if (substream)
 		snd_pcm_lib_preallocate_free_for_all(pcm);
-	}
 }
 
 static struct snd_soc_component_driver stm32_adfsdm_soc_platform = {
-- 
2.18.0

