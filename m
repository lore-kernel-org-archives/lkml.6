Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752322AbeBLRRA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 12:17:00 -0500
Received: from mga02.intel.com ([134.134.136.20]:30285 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751383AbeBLRQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 12:16:58 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,503,1511856000";
   d="scan'208";a="26713847"
Date: Tue, 13 Feb 2018 01:16:06 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: "oder_chiou@realtek.com" <oder_chiou@realtek.com>
Cc: kbuild-all@01.org, alsa-devel@alsa-project.org,
        Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH asoc] ASoC: rt5659: rt5659_intel_hd_header_probe_setup()
 can be static
Message-ID: <20180212171606.GA15960@lkp-wsm-ep1>
References: <201802130145.hD2DgN3c%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201802130145.hD2DgN3c%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 041e74b71491 ("ASoC: rt5659: Add the support of Intel HDA Header")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 rt5659.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index ef3a44d..b772194 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -4038,7 +4038,7 @@ static void rt5659_calibrate(struct rt5659_priv *rt5659)
 	regmap_write(rt5659->regmap, RT5659_HP_CHARGE_PUMP_1, 0x0c16);
 }
 
-void rt5659_intel_hd_header_probe_setup(struct rt5659_priv *rt5659)
+static void rt5659_intel_hd_header_probe_setup(struct rt5659_priv *rt5659)
 {
 	int value;
 
