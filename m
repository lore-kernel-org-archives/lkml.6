Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF703C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE846222B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550058837;
	bh=S547tR1OMAaH1m+yG8dthyWTFBthdTiU/5sGK3V3AoU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=iNDfJ/klouksuLv26BNq8bQnpk5s6O+Ts4ZFJeKh6njJDM8XdQB8GwgmcUjwHdqmr
	 le9P4nPp1c0nuadbnB7JObr5MKwPU1KrCJIPvvXzlBptrGHZ6I2JXwYbm7wARcGR56
	 Rc+OH4twrGrmaNA5OJ4MiRstxsSyhk7UKkWSs5+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391985AbfBMLx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:53:56 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50014 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391960AbfBMLxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:53:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=8psaD6OeWfrNWeBlsc9tdgqdDqFgmdebl0o65KZNVc0=; b=qJVcAtltOFH7
        G8u90y+Y8Q34UGTPbnhHoXuPSsry0WcvCAlYjMz3kV5aPst+UVEwRUdmR0UBLRhaEFpPLYSyWprku
        7X/Gfz6NpEdpa4AlTYvH5zWzrozx52A4ipHgfR7Kf6TGSv5swxnTnskcOSsMklFRqGtahLKg6B9a+
        FrkT4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gtt6c-00045n-Em; Wed, 13 Feb 2019 11:53:34 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id E6EA01128158; Wed, 13 Feb 2019 11:53:33 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Brian Austin <brian.austin@cirrus.com>,
        Paul Handrigan <Paul.Handrigan@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: cs35l36: Remove unused including <linux/version.h>" to the asoc tree
In-Reply-To:  <20190213014332.148775-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190213115333.E6EA01128158@debutante.sirena.org.uk>
Date:   Wed, 13 Feb 2019 11:53:33 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: cs35l36: Remove unused including <linux/version.h>

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

From 51bef0f378f39ed0604296354b964e3919161396 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 13 Feb 2019 01:43:32 +0000
Subject: [PATCH] ASoC: cs35l36: Remove unused including <linux/version.h>

Remove including <linux/version.h> that don't need it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs35l36.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l36.c b/sound/soc/codecs/cs35l36.c
index 4f880a678812..e374fffb7e17 100644
--- a/sound/soc/codecs/cs35l36.c
+++ b/sound/soc/codecs/cs35l36.c
@@ -8,7 +8,6 @@
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/delay.h>
-- 
2.20.1

