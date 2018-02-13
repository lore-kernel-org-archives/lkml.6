Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935199AbeBMMQR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:16:17 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37074 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934827AbeBMMQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:16:13 -0500
From: Mark Brown <broonie@kernel.org>
To: Wu Fengguang <fengguang.wu@intel.com>
Cc: Fengguang Wu <fengguang.wu@intel.com>, Mark Brown <broonie@kernel.org>,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Brown <broonie@kernel.org>, kbuild-all@01.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: uniphier: aiodma_rb_get_rp() can be static" to the asoc tree
In-Reply-To: <20180212175310.GA13659@lkp-wsm-ep1>
Message-Id: <E1elZVD-0005XS-NF@debutante>
Date: Tue, 13 Feb 2018 12:16:03 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: uniphier: aiodma_rb_get_rp() can be static

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

>From d732d89b154af23946180bf785b7b0ec42275b49 Mon Sep 17 00:00:00 2001
From: Wu Fengguang <fengguang.wu@intel.com>
Date: Tue, 13 Feb 2018 01:53:10 +0800
Subject: [PATCH] ASoC: uniphier: aiodma_rb_get_rp() can be static

Fixes: f37fe2f9987b ("ASoC: uniphier: add support for UniPhier AIO common driver")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/uniphier/aio-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/uniphier/aio-core.c b/sound/soc/uniphier/aio-core.c
index 7e9451ca24af..1e5f053d9f6b 100644
--- a/sound/soc/uniphier/aio-core.c
+++ b/sound/soc/uniphier/aio-core.c
@@ -904,7 +904,7 @@ void aiodma_ch_set_enable(struct uniphier_aio_sub *sub, int enable)
 	}
 }
 
-u64 aiodma_rb_get_rp(struct uniphier_aio_sub *sub)
+static u64 aiodma_rb_get_rp(struct uniphier_aio_sub *sub)
 {
 	struct regmap *r = sub->aio->chip->regmap;
 	u32 pos_u, pos_l;
-- 
2.16.1
