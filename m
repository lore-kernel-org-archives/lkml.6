Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752473AbeBTPVH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 10:21:07 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43890 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752395AbeBTPVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 10:21:04 -0500
From: Mark Brown <broonie@kernel.org>
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        alsa-devel@alsa-project.org, shengjiu.wang@nxp.com,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        cosmin.samoila@nxp.com, daniel.baluta@nxp.com, mihai.serban@gmail.com,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: ak5558: Fix style for SPDX identifier" to the asoc tree
In-Reply-To: <1519131190-15046-1-git-send-email-daniel.baluta@nxp.com>
Message-Id: <E1eo9j3-0003xF-PL@debutante>
Date: Tue, 20 Feb 2018 15:21:01 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: ak5558: Fix style for SPDX identifier

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

>From af3acca3e35c01920fe476f730dca7345d0a48df Mon Sep 17 00:00:00 2001
From: Daniel Baluta <daniel.baluta@nxp.com>
Date: Tue, 20 Feb 2018 14:53:10 +0200
Subject: [PATCH] ASoC: ak5558: Fix style for SPDX identifier

Use // for .c and /* for .h files according to:
Documentation/process/license-rules.rst file.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ak5558.c | 11 +++++------
 sound/soc/codecs/ak5558.h |  4 ++--
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/ak5558.c b/sound/soc/codecs/ak5558.c
index f2248315677e..f4ed5cc40661 100644
--- a/sound/soc/codecs/ak5558.c
+++ b/sound/soc/codecs/ak5558.c
@@ -1,10 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * Audio driver for AK5558 ADC
- *
- * Copyright (C) 2015 Asahi Kasei Microdevices Corporation
- * Copyright 2018 NXP
- */
+//
+// Audio driver for AK5558 ADC
+//
+// Copyright (C) 2015 Asahi Kasei Microdevices Corporation
+// Copyright 2018 NXP
 
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
diff --git a/sound/soc/codecs/ak5558.h b/sound/soc/codecs/ak5558.h
index 7c9e37374f39..61059086f161 100644
--- a/sound/soc/codecs/ak5558.h
+++ b/sound/soc/codecs/ak5558.h
@@ -1,5 +1,5 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * Audio driver header for AK5558
  *
  * Copyright (C) 2016 Asahi Kasei Microdevices Corporation
-- 
2.16.1
