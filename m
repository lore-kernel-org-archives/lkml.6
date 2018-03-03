Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752333AbeCCTiM (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 14:38:12 -0500
Received: from mga03.intel.com ([134.134.136.65]:64696 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752306AbeCCTiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 14:38:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,419,1515484800";
   d="scan'208";a="21821878"
From: abhijeet.kumar@intel.com
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>,
        Guneshwor Singh <guneshwor.o.singh@intel.com>,
        Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>,
        Dharageswari R <dharageswari.r@intel.com>,
        G Kranthi <gudishax.kranthikumar@intel.com>,
        Pradeep Tewani <pradeep.d.tewani@intel.com>,
        Ramesh Babu <ramesh.babu@intel.com>,
        Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: abhijeet.kumar@intel.com
Subject: [PATCH] ASoC: Intel: Skylake: Fix typo
Date: Sun,  4 Mar 2018 01:16:39 +0530
Message-Id: <1520106400-22664-1-git-send-email-abhijeet.kumar@intel.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abhijeet Kumar <abhijeet.kumar@intel.com>

Spelling mistake in state. So fixing it.

Signed-off-by: Abhijeet Kumar <abhijeet.kumar@intel.com>
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
1.9.1
