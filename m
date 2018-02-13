Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935185AbeBMMQL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:16:11 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36870 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934827AbeBMMQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:16:06 -0500
From: Mark Brown <broonie@kernel.org>
To: Wu Fengguang <fengguang.wu@intel.com>
Cc: Fengguang Wu <fengguang.wu@intel.com>, Mark Brown <broonie@kernel.org>,
        "oder_chiou@realtek.com" <oder_chiou@realtek.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, kbuild-all@01.org,
        Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: rt5659: rt5659_intel_hd_header_probe_setup() can be static" to the asoc tree
In-Reply-To: <20180212171606.GA15960@lkp-wsm-ep1>
Message-Id: <E1elZV8-0005WJ-IN@debutante>
Date: Tue, 13 Feb 2018 12:15:58 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rt5659: rt5659_intel_hd_header_probe_setup() can be static

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

>From 2fa0b7fdf8bd16b6cdda8516793989511c9322ed Mon Sep 17 00:00:00 2001
From: Wu Fengguang <fengguang.wu@intel.com>
Date: Tue, 13 Feb 2018 01:16:06 +0800
Subject: [PATCH] ASoC: rt5659: rt5659_intel_hd_header_probe_setup() can be
 static

Fixes: 041e74b71491 ("ASoC: rt5659: Add the support of Intel HDA Header")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5659.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index ef3a44d6386b..b7721940b76f 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -4038,7 +4038,7 @@ static void rt5659_calibrate(struct rt5659_priv *rt5659)
 	regmap_write(rt5659->regmap, RT5659_HP_CHARGE_PUMP_1, 0x0c16);
 }
 
-void rt5659_intel_hd_header_probe_setup(struct rt5659_priv *rt5659)
+static void rt5659_intel_hd_header_probe_setup(struct rt5659_priv *rt5659)
 {
 	int value;
 
-- 
2.16.1
