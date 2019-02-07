Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5F7C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6068420844
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfBGJ1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 04:27:19 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43974 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfBGJ1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 04:27:18 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1grfxC-00029l-LF; Thu, 07 Feb 2019 09:26:42 +0000
From:   Colin King <colin.king@canonical.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Paul Cercueil <paul@crapouillou.net>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoC: codecs: jz4725b: fix spelling mistake "Deemphatize" -> "Deemphasize"
Date:   Thu,  7 Feb 2019 09:26:42 +0000
Message-Id: <20190207092642.6655-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the SOC_SINGLE control name. Fix this.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/jz4725b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/jz4725b.c b/sound/soc/codecs/jz4725b.c
index e3dba92f30bd..24b1b23b99c9 100644
--- a/sound/soc/codecs/jz4725b.c
+++ b/sound/soc/codecs/jz4725b.c
@@ -161,7 +161,7 @@ static const struct snd_kcontrol_new jz4725b_codec_controls[] = {
 	SOC_SINGLE("Master Playback Switch", JZ4725B_CODEC_REG_CR1,
 		   REG_CR1_DAC_MUTE_OFFSET, 1, 1),
 
-	SOC_SINGLE("Deemphatize Filter Playback Switch",
+	SOC_SINGLE("Deemphasize Filter Playback Switch",
 		   JZ4725B_CODEC_REG_CR2,
 		   REG_CR2_DAC_DEEMP_OFFSET, 1, 0),
 
-- 
2.20.1

