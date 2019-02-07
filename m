Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C6BC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA5E21920
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549552968;
	bh=6UhG4lVX861dpjDWtz4l6lfKKpLuSVJF8aBTVLWRi2w=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=dXlVPe/AvhOlffoFvy1vHxc5idx8oVXkw5/oJazirVhhn4sNXV8sWfYetJTufrrZM
	 Sbanyr95Bv9wlEPUjqyp1bIr54gNzcG01hup6tmsAz+MOeyHGJ0HP6pdEpstXTBI9Y
	 kwaHaVbgp2FhoQvEfdTdlPuwZB/DJQcMxMDOKack=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfBGPWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:22:41 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43734 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfBGPWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:22:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=uAdjSaHAUqa7f5Zfk+SAJ5jqio2HDr3bAyFjYPp0Zmg=; b=Csx+KYtlkEBB
        cxOjOMXzNwMwUA5H6HJtDGqyjTeyupvaAoZYeHqSH8MvvrkiD/lh5sUHga/eHbVVVFIY/okI70ZF0
        Kd1Yxi9T4JJYOZnbwBO8XDNsMl1zYRQmeEQvvfMHYlDL1hRvQ23igCrrgRKmDN8vH41+mOUnfIZb9
        36eVM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1grlVV-0006O7-Lo; Thu, 07 Feb 2019 15:22:29 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 3486D1127EF9; Thu,  7 Feb 2019 15:22:29 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: codecs: jz4725b: Use C++ style comments in header" to the asoc tree
In-Reply-To:  <20190207133143.5232-6-paul@crapouillou.net>
X-Patchwork-Hint: ignore
Message-Id: <20190207152229.3486D1127EF9@debutante.sirena.org.uk>
Date:   Thu,  7 Feb 2019 15:22:29 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: codecs: jz4725b: Use C++ style comments in header

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

From a50e32694fbcdbf55875095258b9398e2eabd71f Mon Sep 17 00:00:00 2001
From: Paul Cercueil <paul@crapouillou.net>
Date: Thu, 7 Feb 2019 10:31:43 -0300
Subject: [PATCH] ASoC: codecs: jz4725b: Use C++ style comments in header

Change the header comment to use C++ style, so that it looks more
consistent with the rest of ASoC.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/jz4725b.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/jz4725b.c b/sound/soc/codecs/jz4725b.c
index 24b1b23b99c9..103ccbc5d55c 100644
--- a/sound/soc/codecs/jz4725b.c
+++ b/sound/soc/codecs/jz4725b.c
@@ -1,9 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * JZ4725B CODEC driver
- *
- * Copyright (C) 2019, Paul Cercueil <paul@crapouillou.net>
- */
+//
+// JZ4725B CODEC driver
+//
+// Copyright (C) 2019, Paul Cercueil <paul@crapouillou.net>
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-- 
2.20.1

