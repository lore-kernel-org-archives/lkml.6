Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751881AbeEMCcR (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 22:32:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56822 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751129AbeEMCcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 22:32:16 -0400
From: Mark Brown <broonie@kernel.org>
To: Colin Ian King <colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: hisilicon: fix spelling mistake: "uknown" -> "unknown"" to the asoc tree
In-Reply-To: <20180511132818.16728-1-colin.king@canonical.com>
Message-Id: <20180513023204.CCAB944007C@finisterre.ee.mobilebroadband>
Date: Sun, 13 May 2018 03:32:04 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: hisilicon: fix spelling mistake: "uknown" -> "unknown"

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

>From 2b8eae795580ca13ce6f035cac599f6a85c81bbf Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Fri, 11 May 2018 14:28:18 +0100
Subject: [PATCH] ASoC: hisilicon: fix spelling mistake: "uknown" -> "unknown"

Trivial fix to spelling mistake in dev_err message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
