Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753429AbeBLRx5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 12:53:57 -0500
Received: from mga01.intel.com ([192.55.52.88]:1272 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751287AbeBLRx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 12:53:56 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,503,1511856000";
   d="scan'208";a="203582162"
Date: Tue, 13 Feb 2018 01:53:10 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: kbuild-all@01.org, alsa-devel@alsa-project.org,
        Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH asoc] ASoC: uniphier: aiodma_rb_get_rp() can be static
Message-ID: <20180212175310.GA13659@lkp-wsm-ep1>
References: <201802130150.A223WMAh%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201802130150.A223WMAh%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: f37fe2f9987b ("ASoC: uniphier: add support for UniPhier AIO common driver")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 aio-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/uniphier/aio-core.c b/sound/soc/uniphier/aio-core.c
index 7e9451c..1e5f053 100644
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
