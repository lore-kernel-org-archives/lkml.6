Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99B7C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 15:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84DA920659
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 15:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84DA920659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbeJMXXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 19:23:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35830 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbeJMXXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 19:23:03 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gBM6M-000364-4j; Sat, 13 Oct 2018 15:45:14 +0000
From:   Colin King <colin.king@canonical.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: wm8904: fix spelling mistake "Inveting" -> "Inverting"
Date:   Sat, 13 Oct 2018 16:45:13 +0100
Message-Id: <20181013154513.6155-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in sound control text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/wm8904.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 2a3e5fbd04e4..ef83dae6e5ae 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -870,7 +870,7 @@ static SOC_ENUM_SINGLE_DECL(lin_inv_enum, WM8904_ANALOGUE_LEFT_INPUT_1, 4,
 			    lin_text);
 
 static const struct snd_kcontrol_new lin_inv_mux =
-	SOC_DAPM_ENUM("Left Capture Inveting Mux", lin_inv_enum);
+	SOC_DAPM_ENUM("Left Capture Inverting Mux", lin_inv_enum);
 
 static const char *rin_text[] = {
 	"IN1R", "IN2R", "IN3R"
@@ -886,7 +886,7 @@ static SOC_ENUM_SINGLE_DECL(rin_inv_enum, WM8904_ANALOGUE_RIGHT_INPUT_1, 4,
 			    rin_text);
 
 static const struct snd_kcontrol_new rin_inv_mux =
-	SOC_DAPM_ENUM("Right Capture Inveting Mux", rin_inv_enum);
+	SOC_DAPM_ENUM("Right Capture Inverting Mux", rin_inv_enum);
 
 static const char *aif_text[] = {
 	"Left", "Right"
-- 
2.17.1

