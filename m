Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759748AbeD1JWZ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 05:22:25 -0400
Received: from mga09.intel.com ([134.134.136.24]:9689 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759620AbeD1JWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 05:22:23 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,338,1520924400";
   d="scan'208";a="195094916"
Date: Sat, 28 Apr 2018 17:21:22 +0800
From: kbuild test robot <lkp@intel.com>
To: Jean-Jacques Hiblot <jjhiblot@ti.com>
Cc: kbuild-all@01.org, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com,
        dannenberg@ti.com, afd@ti.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean-Jacques Hiblot <jjhiblot@ti.com>
Subject: [RFC PATCH] ASoC: tas6424: diags_enum can be static
Message-ID: <20180428092122.GA115601@ivytown2>
References: <1524837349-16350-4-git-send-email-jjhiblot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524837349-16350-4-git-send-email-jjhiblot@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: c9f4b53ff449 ("ASoC: tas6424: Allow disabling auto diagnostics for faster power-on")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 tas6424.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas6424.c b/sound/soc/codecs/tas6424.c
index 8eb4842..8bca6b2 100644
--- a/sound/soc/codecs/tas6424.c
+++ b/sound/soc/codecs/tas6424.c
@@ -58,7 +58,7 @@ static DECLARE_TLV_DB_SCALE(dac_tlv, -10350, 50, 0);
 
 static const char * const diags_enum_texts[] = {"OFF", "ON"};
 static unsigned int diags_enum_values[] = {1, 0};
-SOC_VALUE_ENUM_SINGLE_DECL(diags_enum, TAS6424_DC_DIAG_CTRL1,
+static SOC_VALUE_ENUM_SINGLE_DECL(diags_enum, TAS6424_DC_DIAG_CTRL1,
 			   TAS6424_LDGBYPASS_SHIFT, TAS6424_LDGBYPASS_MASK,
 			   diags_enum_texts, diags_enum_values);
 
