Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3E5C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 02:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0401421871
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 02:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfAECDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 21:03:41 -0500
Received: from mga07.intel.com ([134.134.136.100]:49511 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfAECDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 21:03:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jan 2019 18:03:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,441,1539673200"; 
   d="scan'208";a="307634693"
Received: from kgandham-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.139.169])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jan 2019 18:03:38 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@linux.intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 03/21] ASoC: es8316: remove unused constant variables
Date:   Fri,  4 Jan 2019 20:02:31 -0600
Message-Id: <20190105020249.8639-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
References: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix warnings with W=1

If these variables are useful this driver should be modified to expose
them.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/es8316.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index e97d12d578b0..b10c4d812958 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -159,8 +159,6 @@ static const char * const es8316_hpmux_texts[] = {
 	"lin-rin with Boost and PGA"
 };
 
-static const unsigned int es8316_hpmux_values[] = { 0, 1, 2, 3 };
-
 static SOC_ENUM_SINGLE_DECL(es8316_left_hpmux_enum, ES8316_HPMIX_SEL,
 	4, es8316_hpmux_texts);
 
@@ -191,8 +189,6 @@ static const char * const es8316_dacsrc_texts[] = {
 	"RDATA TO LDAC, LDATA TO RDAC",
 };
 
-static const unsigned int es8316_dacsrc_values[] = { 0, 1, 2, 3 };
-
 static SOC_ENUM_SINGLE_DECL(es8316_dacsrc_mux_enum, ES8316_DAC_SET1,
 	6, es8316_dacsrc_texts);
 
-- 
2.17.1

