Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935971AbeCHRWm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 12:22:42 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38228 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933876AbeCHRWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 12:22:41 -0500
From: Mark Brown <broonie@kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: uniphier: remove superfluous <linux/mfd/syscon.h> inclusion" to the asoc tree
In-Reply-To: <1520496569-32032-1-git-send-email-yamada.masahiro@socionext.com>
Message-Id: <E1etzFV-0007XV-Lg@debutante>
Date: Thu, 08 Mar 2018 17:22:37 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: uniphier: remove superfluous <linux/mfd/syscon.h> inclusion

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

>From d2b9430771cae7edc9927b36ce0e76a336fd952c Mon Sep 17 00:00:00 2001
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 8 Mar 2018 17:09:29 +0900
Subject: [PATCH] ASoC: uniphier: remove superfluous <linux/mfd/syscon.h>
 inclusion

None of aio-compress.c depends on the syscon header.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/uniphier/aio-compress.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/uniphier/aio-compress.c b/sound/soc/uniphier/aio-compress.c
index 4751c8bdabec..4c1027aa615e 100644
--- a/sound/soc/uniphier/aio-compress.c
+++ b/sound/soc/uniphier/aio-compress.c
@@ -22,7 +22,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
-#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
-- 
2.16.2
