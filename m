Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752710AbeC3Por (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 11:44:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34975 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752401AbeC3Pop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 11:44:45 -0400
From: Colin King <colin.king@canonical.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: atmel_ssc_dai: fix spelling mistake: "Stoping" -> "Stopping"
Date: Fri, 30 Mar 2018 16:44:20 +0100
Message-Id: <20180330154420.6903-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in pr_debug message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/atmel/atmel_ssc_dai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index a1e2c5682dcd..1c7af0ca98ec 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -820,7 +820,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 		if (ret < 0) {
 			printk(KERN_WARNING
 					"atmel_ssc_dai: request_irq failure\n");
-			pr_debug("Atmel_ssc_dai: Stoping clock\n");
+			pr_debug("Atmel_ssc_dai: Stopping clock\n");
 			clk_disable(ssc_p->ssc->clk);
 			return ret;
 		}
-- 
2.15.1
