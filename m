Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753097AbeEKN23 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 09:28:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40674 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750777AbeEKN22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 09:28:28 -0400
From: Colin King <colin.king@canonical.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: hisilicon: fix spelling mistake: "uknown" -> "unknown"
Date: Fri, 11 May 2018 14:28:18 +0100
Message-Id: <20180511132818.16728-1-colin.king@canonical.com>
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
 sound/soc/hisilicon/hi6210-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/hisilicon/hi6210-i2s.c b/sound/soc/hisilicon/hi6210-i2s.c
index 07a57209e055..53344a3b7a60 100644
--- a/sound/soc/hisilicon/hi6210-i2s.c
+++ b/sound/soc/hisilicon/hi6210-i2s.c
@@ -498,7 +498,7 @@ static int hi6210_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 			hi6210_i2s_txctrl(cpu_dai, 0);
 		break;
 	default:
-		dev_err(cpu_dai->dev, "uknown cmd\n");
+		dev_err(cpu_dai->dev, "unknown cmd\n");
 		return -EINVAL;
 	}
 	return 0;
-- 
2.17.0
