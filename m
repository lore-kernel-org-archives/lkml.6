Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83873C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E7A52084D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="FHCuSl8T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E7A52084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbeH2AUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 20:20:33 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34448 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbeH2AUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 20:20:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Csvn9t2aVqTN0UFOfPZMG1lm246ly0Xc/MXxEAEOZeE=; b=FHCuSl8T0TM8
        BdMR4RnBaIYzACBbtCG2V2vMWHx4R3Q/Vdq2ZoTxTzXCVRvYnXP9KS/YUzsOB7hYtc+QEf5MNl9Nu
        sfu9seNeW8Jd5gYEr2MwL0kZBmA4N5VgAafybict3kQuTWvqMNHVuHSNLYDD4oumPq25SOdqKRKUp
        TT20Y=;
Received: from 188.29.165.122.threembb.co.uk ([188.29.165.122] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fukZn-0007fp-4R; Tue, 28 Aug 2018 20:27:01 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 4010A440078; Tue, 28 Aug 2018 21:26:55 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: atmel: tse850: switch to SPDX license identifier" to the asoc tree
In-Reply-To:  <20180820101409.23328-1-peda@axentia.se>
Message-Id: <20180828202655.4010A440078@finisterre.ee.mobilebroadband>
Date:   Tue, 28 Aug 2018 21:26:55 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: atmel: tse850: switch to SPDX license identifier

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

From 1b3b7981524af2b6dcdf78cfa6dca89522c13ade Mon Sep 17 00:00:00 2001
From: Peter Rosin <peda@axentia.se>
Date: Mon, 20 Aug 2018 12:14:09 +0200
Subject: [PATCH] ASoC: atmel: tse850: switch to SPDX license identifier

Convert to // comments in the leading comment, drop the boilerplate
license text and use the correct MODULE_LICENSE.

Signed-off-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/atmel/tse850-pcm5142.c | 78 +++++++++++++++-----------------
 1 file changed, 36 insertions(+), 42 deletions(-)

diff --git a/sound/soc/atmel/tse850-pcm5142.c b/sound/soc/atmel/tse850-pcm5142.c
index 3a1393283156..214adcad5419 100644
--- a/sound/soc/atmel/tse850-pcm5142.c
+++ b/sound/soc/atmel/tse850-pcm5142.c
@@ -1,44 +1,38 @@
-/*
- * TSE-850 audio - ASoC driver for the Axentia TSE-850 with a PCM5142 codec
- *
- * Copyright (C) 2016 Axentia Technologies AB
- *
- * Author: Peter Rosin <peda@axentia.se>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-/*
- *               loop1 relays
- *   IN1 +---o  +------------+  o---+ OUT1
- *            \                /
- *             +              +
- *             |   /          |
- *             +--o  +--.     |
- *             |  add   |     |
- *             |        V     |
- *             |      .---.   |
- *   DAC +----------->|Sum|---+
- *             |      '---'   |
- *             |              |
- *             +              +
- *
- *   IN2 +---o--+------------+--o---+ OUT2
- *               loop2 relays
- *
- * The 'loop1' gpio pin controlls two relays, which are either in loop
- * position, meaning that input and output are directly connected, or
- * they are in mixer position, meaning that the signal is passed through
- * the 'Sum' mixer. Similarly for 'loop2'.
- *
- * In the above, the 'loop1' relays are inactive, thus feeding IN1 to the
- * mixer (if 'add' is active) and feeding the mixer output to OUT1. The
- * 'loop2' relays are active, short-cutting the TSE-850 from channel 2.
- * IN1, IN2, OUT1 and OUT2 are TSE-850 connectors and DAC is the PCB name
- * of the (filtered) output from the PCM5142 codec.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// TSE-850 audio - ASoC driver for the Axentia TSE-850 with a PCM5142 codec
+//
+// Copyright (C) 2016 Axentia Technologies AB
+//
+// Author: Peter Rosin <peda@axentia.se>
+//
+//               loop1 relays
+//   IN1 +---o  +------------+  o---+ OUT1
+//            \                /
+//             +              +
+//             |   /          |
+//             +--o  +--.     |
+//             |  add   |     |
+//             |        V     |
+//             |      .---.   |
+//   DAC +----------->|Sum|---+
+//             |      '---'   |
+//             |              |
+//             +              +
+//
+//   IN2 +---o--+------------+--o---+ OUT2
+//               loop2 relays
+//
+// The 'loop1' gpio pin controlls two relays, which are either in loop
+// position, meaning that input and output are directly connected, or
+// they are in mixer position, meaning that the signal is passed through
+// the 'Sum' mixer. Similarly for 'loop2'.
+//
+// In the above, the 'loop1' relays are inactive, thus feeding IN1 to the
+// mixer (if 'add' is active) and feeding the mixer output to OUT1. The
+// 'loop2' relays are active, short-cutting the TSE-850 from channel 2.
+// IN1, IN2, OUT1 and OUT2 are TSE-850 connectors and DAC is the PCB name
+// of the (filtered) output from the PCM5142 codec.
 
 #include <linux/clk.h>
 #include <linux/gpio.h>
@@ -452,4 +446,4 @@ module_platform_driver(tse850_driver);
 /* Module information */
 MODULE_AUTHOR("Peter Rosin <peda@axentia.se>");
 MODULE_DESCRIPTION("ALSA SoC driver for TSE-850 with PCM5142 codec");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
-- 
2.18.0

