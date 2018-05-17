Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752539AbeEQQjK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 12:39:10 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48804 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751916AbeEQQjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 12:39:07 -0400
From: Mark Brown <broonie@kernel.org>
To: Pravin Shedge <pravin.shedge4linux@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, jun.nie@linaro.org,
        baoyou.xie@linaro.org, shawnguo@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        pravin.shedge4linux@gmail.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: zte: remove duplicate includes" to the asoc tree
In-Reply-To: <1512930723-5037-1-git-send-email-pravin.shedge4linux@gmail.com>
Message-Id: <20180517163843.7AFDF44007E@finisterre.ee.mobilebroadband>
Date: Thu, 17 May 2018 17:38:43 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: zte: remove duplicate includes

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

>From 3439a083a13981f0da276cb2aeae84bd4e437b2e Mon Sep 17 00:00:00 2001
From: Pravin Shedge <pravin.shedge4linux@gmail.com>
Date: Mon, 11 Dec 2017 00:02:03 +0530
Subject: [PATCH] ASoC: zte: remove duplicate includes

These duplicate includes have been found with scripts/checkincludes.pl but
they have been removed manually to avoid removing false positives.

Signed-off-by: Pravin Shedge <pravin.shedge4linux@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/zte/zx-i2s.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/zte/zx-i2s.c b/sound/soc/zte/zx-i2s.c
index b6b056c607fa..0d36630aa1a7 100644
--- a/sound/soc/zte/zx-i2s.c
+++ b/sound/soc/zte/zx-i2s.c
@@ -20,9 +20,6 @@
 #include <sound/core.h>
 #include <sound/dmaengine_pcm.h>
 #include <sound/initval.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include <sound/soc.h>
 
 #define ZX_I2S_PROCESS_CTRL	0x04
 #define ZX_I2S_TIMING_CTRL	0x08
-- 
2.17.0
