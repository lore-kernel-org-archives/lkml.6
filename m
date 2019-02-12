Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A95BC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC7172084D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549990749;
	bh=hVL9c2Eo3AlcNmQ6XcYephBWp0udL7Kh53ZZYqkQ0zs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=1lUE49VTCczLo6+Jl7q/V/kgo9CESQDCpFaRHOocSwIaIihRHmN1eXNE/IGqRQMT9
	 Ey60FwK53SGn3X+C2ameyTrhxXuXokNM0QcustwwHhOJzF8g7VepvRHmW0bbv6nGUV
	 froTKdDghvPK2uZDUZ+eDqJvRFVxawlyRuDkt/rM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731256AbfBLQ7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:59:03 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36388 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731213AbfBLQ7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=/y/poufru+40CcH06WsT0Cl8GQJ1FURdQ8lxmHNUyNY=; b=UALfcLFGaw6z
        LRHuafG/xEZshMuR+recLe4EWSZgAFZ3yBNwBhyYdfMaTtzFNeaQbO/a+haUi3MdkRTsD8kBOOT2p
        +pe6dPVkiz+R0MECo3awHKYui+J9J2m1aMW0x1/3zq8Kfjcka4iYDsAhRnhRLWhp1xQqDC2izT7Rt
        b3Q04=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gtbOa-0005iN-2f; Tue, 12 Feb 2019 16:58:56 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 957C61128113; Tue, 12 Feb 2019 16:58:55 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
        b.zolnierkie@samsung.com, sbkim73@samsung.com, lgirdwood@gmail.com,
        krzk@kernel.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, alsa-devel@alsa-project.org
Subject: Applied "ASoC: dmaengine: Improve of_node test in dmaengine_pcm_request_chan_of()" to the asoc tree
In-Reply-To:  <20190207170028.720-2-s.nawrocki@samsung.com>
X-Patchwork-Hint: ignore
Message-Id: <20190212165855.957C61128113@debutante.sirena.org.uk>
Date:   Tue, 12 Feb 2019 16:58:55 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: dmaengine: Improve of_node test in dmaengine_pcm_request_chan_of()

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

From 51256d348c9af1bf544a4432abc1d5f2fd3ef34b Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Thu, 7 Feb 2019 18:00:09 +0100
Subject: [PATCH] ASoC: dmaengine: Improve of_node test in
 dmaengine_pcm_request_chan_of()

Currently when of_node of the "PCM" device is null
dmaengine_pcm_request_chan_of() function will bail out, including cases
when custom DMA device is intended to be used.  To have the channels
properly requested when custom DMA device is provided extend the of_node
test to also consider dma_dev->of_node.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-generic-dmaengine-pcm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 30e791a53352..6d7638c1233d 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -415,7 +415,8 @@ static int dmaengine_pcm_request_chan_of(struct dmaengine_pcm *pcm,
 
 	if ((pcm->flags & (SND_DMAENGINE_PCM_FLAG_NO_DT |
 			   SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME)) ||
-	    !dev->of_node)
+	     (!dev->of_node && !(config && config->dma_dev &&
+				config->dma_dev->of_node)))
 		return 0;
 
 	if (config && config->dma_dev) {
-- 
2.20.1

