Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751645AbeBTMI6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 07:08:58 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60026 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751460AbeBTMI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 07:08:56 -0500
From: Mark Brown <broonie@kernel.org>
To: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        shengjiu.wang@nxp.com, linux-kernel@vger.kernel.org,
        wakasugi.jb@om.asahi-kasei.co.jp, linux-imx@nxp.com,
        daniel.baluta@nxp.com, mihai.serban@gmail.com,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: ak4458: Sort headers alphabetically" to the asoc tree
In-Reply-To: <1519116968-31759-3-git-send-email-cosmin.samoila@nxp.com>
Message-Id: <E1eo6j6-00036r-V9@debutante>
Date: Tue, 20 Feb 2018 12:08:52 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: ak4458: Sort headers alphabetically

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

>From de03af56602a3b57bfef958045a4d43ad50db46a Mon Sep 17 00:00:00 2001
From: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
Date: Tue, 20 Feb 2018 10:56:08 +0200
Subject: [PATCH] ASoC: ak4458: Sort headers alphabetically

Keep headers sorted alphabetically.

Signed-off-by: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ak4458.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
index 8a49dd24e6b7..31ec0ba2e639 100644
--- a/sound/soc/codecs/ak4458.c
+++ b/sound/soc/codecs/ak4458.c
@@ -5,19 +5,19 @@
 // Copyright (C) 2016 Asahi Kasei Microdevices Corporation
 // Copyright 2018 NXP
 
-#include <linux/module.h>
 #include <linux/delay.h>
-#include <linux/slab.h>
 #include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/pm_runtime.h>
-#include <linux/i2c.h>
+#include <linux/slab.h>
+#include <sound/initval.h>
+#include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
-#include <sound/initval.h>
 #include <sound/tlv.h>
-#include <sound/pcm_params.h>
 
 #include "ak4458.h"
 
-- 
2.16.1
