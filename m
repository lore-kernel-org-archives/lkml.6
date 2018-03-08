Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935498AbeCHILp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 03:11:45 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:62999 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935333AbeCHILo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 03:11:44 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w2889iit018027
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ASoC: uniphier: remove superfluous <linux/mfd/syscon.h> inclusion
Date: Thu,  8 Mar 2018 17:09:29 +0900
Message-Id: <1520496569-32032-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

None of aio-compress.c depends on the syscon header.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---

 sound/soc/uniphier/aio-compress.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/uniphier/aio-compress.c b/sound/soc/uniphier/aio-compress.c
index 4751c8b..4c1027a 100644
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
2.7.4
