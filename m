Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0A8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F07218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545321636;
	bh=IQv0+owOnHm5jd0DMSwdb1505S6n+Yvz03AGvS/Aefw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=n0BUw3VW5+pp7uOzDonUhEUvS5zvEwa4j0WjiOeXjY40X3rVo/Q6XIw+2GQ/KHvSV
	 KdtMw9m4Dr1HosphcGOFz7uH87MTxfQsKn68tpgBS3Mlr5Xnkwaj+oq3c6tkuh0mcO
	 8UxPdRrVdugK0D6o/iSeNwM28wK86uSat2W+044w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732180AbeLTQAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:00:35 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46654 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732086AbeLTQAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:00:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=P+Y9aP3JAzVCcKCcck49dhVQ4WWrHEscRp74Dl0XI3I=; b=XRiXaWZRWoFw
        2Uxm6jiYEB+9KBbJhFBehBV7Wl8fyPqxLFP4fmLFnr5dyt1z0NCSYiFh6cvyumOLfZj92quebjtOl
        KJkuOCvJOJJ6H+d+FN1V9pwLj/S55pJYYywyjJoD+6EzDnGZzfqDXTo0A9yPnSwKLh0EO8XLT/CzR
        S/AZA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ga0k3-0003qm-JS; Thu, 20 Dec 2018 16:00:07 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 193B81121B87; Thu, 20 Dec 2018 16:00:07 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Maruthi Srinivas Bayyavarapu 
        <maruthi.srinivas.bayyavarapu@xilinx.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vishal Sagar <vsagar@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: xlnx: change license header format style" to the asoc tree
In-Reply-To:  <1545212440-109949-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
X-Patchwork-Hint: ignore
Message-Id: <20181220160007.193B81121B87@debutante.sirena.org.uk>
Date:   Thu, 20 Dec 2018 16:00:07 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: xlnx: change license header format style

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

From b5ac0078aa6c40ea46760dcebf1ac4022217a51d Mon Sep 17 00:00:00 2001
From: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Date: Wed, 19 Dec 2018 15:10:40 +0530
Subject: [PATCH] ASoC: xlnx: change license header format style

Changed License header from C to C++ style comment block.

Signed-off-by: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/xilinx/xlnx_i2s.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/soc/xilinx/xlnx_i2s.c b/sound/soc/xilinx/xlnx_i2s.c
index d4ae9eff41ce..8b353166ad44 100644
--- a/sound/soc/xilinx/xlnx_i2s.c
+++ b/sound/soc/xilinx/xlnx_i2s.c
@@ -1,12 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * Xilinx ASoC I2S audio support
- *
- * Copyright (C) 2018 Xilinx, Inc.
- *
- * Author: Praveen Vuppala <praveenv@xilinx.com>
- * Author: Maruthi Srinivas Bayyavarapu <maruthis@xilinx.com>
- */
+//
+// Xilinx ASoC I2S audio support
+//
+// Copyright (C) 2018 Xilinx, Inc.
+//
+// Author: Praveen Vuppala <praveenv@xilinx.com>
+// Author: Maruthi Srinivas Bayyavarapu <maruthis@xilinx.com>
 
 #include <linux/io.h>
 #include <linux/module.h>
-- 
2.20.1

