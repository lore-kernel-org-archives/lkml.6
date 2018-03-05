Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932197AbeCERSa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 12:18:30 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41172 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932106AbeCERS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 12:18:29 -0500
From: Mark Brown <broonie@kernel.org>
To: Abhijeet Kumar <abhijeet.kumar@intel.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>,
        Guneshwor Singh <guneshwor.o.singh@intel.com>,
        Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>,
        Dharageswari R <dharageswari.r@intel.com>,
        G Kranthi <gudishax.kranthikumar@intel.com>,
        Pradeep Tewani <pradeep.d.tewani@intel.com>,
        Ramesh Babu <ramesh.babu@intel.com>,
        Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        abhijeet.kumar@intel.com, alsa-devel@alsa-project.org
Subject: Applied "ASoC: Intel: Skylake: Fix typo" to the asoc tree
In-Reply-To: <1520106400-22664-1-git-send-email-abhijeet.kumar@intel.com>
Message-Id: <E1estkQ-0007tK-Ej@debutante>
Date: Mon, 05 Mar 2018 17:18:02 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: Intel: Skylake: Fix typo

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

>From 12af5004145a3fa53246cca4cbb2c57d18dde202 Mon Sep 17 00:00:00 2001
From: Abhijeet Kumar <abhijeet.kumar@intel.com>
Date: Sun, 4 Mar 2018 01:16:39 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix typo

Spelling mistake in state. So fixing it.

Signed-off-by: Abhijeet Kumar <abhijeet.kumar@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-messages.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 60d76adade43..f161907859f3 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -1210,7 +1210,7 @@ int skl_bind_modules(struct skl_sst *ctx,
 static int skl_set_pipe_state(struct skl_sst *ctx, struct skl_pipe *pipe,
 	enum skl_ipc_pipeline_state state)
 {
-	dev_dbg(ctx->dev, "%s: pipe_satate = %d\n", __func__, state);
+	dev_dbg(ctx->dev, "%s: pipe_state = %d\n", __func__, state);
 
 	return skl_ipc_set_pipeline_state(&ctx->ipc, pipe->ppl_id, state);
 }
-- 
2.16.2
