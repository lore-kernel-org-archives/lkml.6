Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965704AbeEJO7E (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 10:59:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50328 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965326AbeEJO7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 10:59:03 -0400
From: Colin King <colin.king@canonical.com>
To: Jun Nie <jun.nie@linaro.org>, Baoyou Xie <baoyou.xie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-arm-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: zx-i2s: fix spelling mistake: "timeing" -> "timing"
Date: Thu, 10 May 2018 15:58:38 +0100
Message-Id: <20180510145838.3907-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in dev_err message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/zte/zx-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/zte/zx-i2s.c b/sound/soc/zte/zx-i2s.c
index 9a0565937d1f..b6b056c607fa 100644
--- a/sound/soc/zte/zx-i2s.c
+++ b/sound/soc/zte/zx-i2s.c
@@ -197,7 +197,7 @@ static int zx_i2s_set_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 		val |= (ZX_I2S_TIMING_I2S | ZX_I2S_TIMING_LSB_JUSTIF);
 		break;
 	default:
-		dev_err(cpu_dai->dev, "Unknown i2s timeing\n");
+		dev_err(cpu_dai->dev, "Unknown i2s timing\n");
 		return -EINVAL;
 	}
 
-- 
2.17.0
