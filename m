Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751721AbeBTMJS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 07:09:18 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60598 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751553AbeBTMJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 07:09:16 -0500
From: Mark Brown <broonie@kernel.org>
To: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        shengjiu.wang@nxp.com, linux-kernel@vger.kernel.org,
        wakasugi.jb@om.asahi-kasei.co.jp, linux-imx@nxp.com,
        daniel.baluta@nxp.com, mihai.serban@gmail.com,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: ak4458: Modify SPDX license format" to the asoc tree
In-Reply-To: <1519116968-31759-2-git-send-email-cosmin.samoila@nxp.com>
Message-Id: <E1eo6jT-00038Y-30@debutante>
Date: Tue, 20 Feb 2018 12:09:15 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: ak4458: Modify SPDX license format

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

>From 05aa6165cfdb796916197da6b8ef93b22a62e3a9 Mon Sep 17 00:00:00 2001
From: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
Date: Tue, 20 Feb 2018 10:56:07 +0200
Subject: [PATCH] ASoC: ak4458: Modify SPDX license format

Modify SPDX comment style to match the rules. Since the original
code had a GPL-2.0 license and SPDX is compatible with GPL-2.0+,
we also modified the MODULE_LICENSE.

Signed-off-by: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ak4458.c | 13 ++++++-------
 sound/soc/codecs/ak4458.h |  2 +-
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
index d2815ac9cffa..8a49dd24e6b7 100644
--- a/sound/soc/codecs/ak4458.c
+++ b/sound/soc/codecs/ak4458.c
@@ -1,10 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * Audio driver for AK4458 DAC
- *
- * Copyright (C) 2016 Asahi Kasei Microdevices Corporation
- * Copyright 2018 NXP
- */
+//
+// Audio driver for AK4458 DAC
+//
+// Copyright (C) 2016 Asahi Kasei Microdevices Corporation
+// Copyright 2018 NXP
 
 #include <linux/module.h>
 #include <linux/delay.h>
@@ -655,4 +654,4 @@ module_i2c_driver(ak4458_i2c_driver);
 MODULE_AUTHOR("Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>");
 MODULE_AUTHOR("Mihai Serban <mihai.serban@nxp.com>");
 MODULE_DESCRIPTION("ASoC AK4458 DAC driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/ak4458.h b/sound/soc/codecs/ak4458.h
index 16d9d22a413a..f906215f7e4e 100644
--- a/sound/soc/codecs/ak4458.h
+++ b/sound/soc/codecs/ak4458.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Audio driver for AK4458
  *
-- 
2.16.1
