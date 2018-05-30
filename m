Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932083AbeE3S0G (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 14:26:06 -0400
Received: from mga12.intel.com ([192.55.52.136]:29841 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932074AbeE3S0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 14:26:01 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,461,1520924400";
   d="scan'208";a="233033667"
Date: Thu, 31 May 2018 02:25:45 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Cc: kbuild-all@01.org, alsa-devel@alsa-project.org,
        Steven Eckhoff <steven.eckhoff.opensource@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] ASoC: TSCS454: tscs454_set_sysclk() can be static
Message-ID: <20180530182545.GA106931@lkp-hsx03>
References: <20180529105147.GA32219@t7-ThinkPad-E560>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529105147.GA32219@t7-ThinkPad-E560>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 3bed8970d09a ("ASoC: TSCS454: Add Support")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 tscs454.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tscs454.c b/sound/soc/codecs/tscs454.c
index 8d8cac3..d7e4f7c 100644
--- a/sound/soc/codecs/tscs454.c
+++ b/sound/soc/codecs/tscs454.c
@@ -2626,7 +2626,7 @@ static struct snd_soc_dapm_route const tscs454_intercon[] = {
 };
 
 /* This is used when BCLK is sourcing the PLLs */
-int tscs454_set_sysclk(struct snd_soc_dai *dai, int clk_id, unsigned int freq,
+static int tscs454_set_sysclk(struct snd_soc_dai *dai, int clk_id, unsigned int freq,
 		int dir)
 {
 	struct snd_soc_component *component = dai->component;
