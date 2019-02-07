Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F6BC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1457921916
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549552974;
	bh=GoPmwo8g3fAlN59U/SM3KKvdXY/afU1d4m1A7ry0mIk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=rh8RR/BF1W906LmM53IS6eEeelyNay2BUgs/TWbK1EjK2F7NJjVUtRzXsDhfr2uVT
	 htZJ+r7WWymiCIuEzhzp7NR8hDx3XJFDEoo6GGwpNKwxs/sG20OBYIa9mP7RfQ/a4q
	 vSEFUsfkNGaZpde1Yw24dgmC2ExRUNi22hjJ5B5k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfBGPWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:22:52 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44038 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfBGPWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:22:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Dgzz07QSRvIT7sO+VX+hSWiVCx8UC4VPe2OpSyOLgzI=; b=w/dBjj+CugED
        61uvo03EOOHVqTC35nibgqsCv7jzX9zJOUeLF5+QlnkDsAicCgVPi7Q+SqFBTM+GUAbcJs0N5u06m
        OqbN7ODdjrehejsUoUDurr5pwzXZ+iF5h+AXxJ8YV6XQnlIFWcMl581gePkFNm3W4QBfz7jcnO4FX
        dsC2s=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1grlVg-0006OX-Vq; Thu, 07 Feb 2019 15:22:41 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 9A3251127EF9; Thu,  7 Feb 2019 15:22:35 +0000 (GMT)
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
Subject: Applied "ASoC: codecs: jz4740: Use SPDX license notifier" to the asoc tree
In-Reply-To:  <20190207133143.5232-3-paul@crapouillou.net>
X-Patchwork-Hint: ignore
Message-Id: <20190207152235.9A3251127EF9@debutante.sirena.org.uk>
Date:   Thu,  7 Feb 2019 15:22:35 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: codecs: jz4740: Use SPDX license notifier

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

From 06a334ae98d15c3e32ae4ef8ce18a241a12f3dff Mon Sep 17 00:00:00 2001
From: Paul Cercueil <paul@crapouillou.net>
Date: Thu, 7 Feb 2019 10:31:40 -0300
Subject: [PATCH] ASoC: codecs: jz4740: Use SPDX license notifier

Add license information as a standard SPDX license notifier instead of
custom text.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/jz4740.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/jz4740.c b/sound/soc/codecs/jz4740.c
index 9395b583432c..9b3e1227a971 100644
--- a/sound/soc/codecs/jz4740.c
+++ b/sound/soc/codecs/jz4740.c
@@ -1,15 +1,8 @@
-/*
- * Copyright (C) 2009-2010, Lars-Peter Clausen <lars@metafoo.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// JZ4740 CODEC driver
+//
+// Copyright (C) 2009-2010, Lars-Peter Clausen <lars@metafoo.de>
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-- 
2.20.1

