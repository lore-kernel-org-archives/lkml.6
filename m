Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7200DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44427217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550515802;
	bh=3cXQ+0xCAaTduWip3T8EvLqFvQJMJwNHZvXs/IESxwk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=cbvNwfYzszZeQub4USXqbkHl+TAjezvN6kLUcMR2C+A20fxylFZE4wVn3OLOqIA5s
	 pMQDepPcw58ndM2kWNfZY5vrp8/p4t+YvE8exjzrFA/U7BwLutTNyXj287rjawv5BH
	 bHT24/ulwKd+6T37ILp9Y94nni8PJxEZeC2s7CDA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfBRSuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:50:01 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42500 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbfBRSty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:49:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=u/OkHuu+AV+tn03svW73wHPMHurg+7Ec81ryOycPr+0=; b=ay3SYFsbp4gC
        vuuWE2dWQCVzLI5AKfFRag4YlBpr4wcnB3NA11wohUMKuUOR0mSsGpiJjZ3uOKMNpF8ryDnXVM+ry
        ZjTM7pSgN/NSFTlRMjv73Ln7id70N5TzTPEQhV7b9djW95U1CGUZExja02yt7bLfi96po860WgTYZ
        Mu3Ck=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gvnz4-0001fO-FX; Mon, 18 Feb 2019 18:49:42 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id E31E11128008; Mon, 18 Feb 2019 18:49:41 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: fsi: fix spelling mistake "doens't" -> "doesn't"" to the asoc tree
In-Reply-To:  <20190217224830.17355-1-colin.king@canonical.com>
X-Patchwork-Hint: ignore
Message-Id: <20190218184941.E31E11128008@debutante.sirena.org.uk>
Date:   Mon, 18 Feb 2019 18:49:41 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: fsi: fix spelling mistake "doens't" -> "doesn't"

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

From cb8cdb6f3344bcb472640d2f5f956dbde0bfd509 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Sun, 17 Feb 2019 22:48:30 +0000
Subject: [PATCH] ASoC: fsi: fix spelling mistake "doens't" -> "doesn't"

There is a spelling mistake in a dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/fsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index aa7e902f0c02..db929b00ae5e 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -780,7 +780,7 @@ static int fsi_clk_init(struct device *dev,
 			return -EINVAL;
 		}
 		if (clock->div == clock->own) {
-			dev_err(dev, "cpu doens't support div clock\n");
+			dev_err(dev, "cpu doesn't support div clock\n");
 			return -EINVAL;
 		}
 	}
-- 
2.20.1

