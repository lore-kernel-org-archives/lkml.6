Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4964C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 23:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB2A20855
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 23:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB2A20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbeKZKE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 05:04:28 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55016 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeKZKE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 05:04:28 -0500
Received: from cpc129250-craw9-2-0-cust139.know.cable.virginm.net ([82.43.126.140] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gR3ZQ-0005UE-Lm; Sun, 25 Nov 2018 23:12:08 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: fix spelling mistake "Frequence" -> "Frequency"
Date:   Sun, 25 Nov 2018 23:12:08 +0000
Message-Id: <20181125231208.14350-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are spelling mistakes in equalizer name fields, fix them.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/usb/mixer_us16x08.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/usb/mixer_us16x08.c b/sound/usb/mixer_us16x08.c
index 26ed23b18b77..4f594f9552a8 100644
--- a/sound/usb/mixer_us16x08.c
+++ b/sound/usb/mixer_us16x08.c
@@ -1119,7 +1119,7 @@ static const struct snd_us16x08_control_params eq_controls[] = {
 		.control_id = SND_US16X08_ID_EQLOWFREQ,
 		.type = USB_MIXER_U8,
 		.num_channels = 16,
-		.name = "EQ Low Frequence",
+		.name = "EQ Low Frequency",
 	},
 	{ /* EQ mid low gain */
 		.kcontrol_new = &snd_us16x08_eq_gain_ctl,
@@ -1133,7 +1133,7 @@ static const struct snd_us16x08_control_params eq_controls[] = {
 		.control_id = SND_US16X08_ID_EQLOWMIDFREQ,
 		.type = USB_MIXER_U8,
 		.num_channels = 16,
-		.name = "EQ MidLow Frequence",
+		.name = "EQ MidLow Frequency",
 	},
 	{ /* EQ mid low Q */
 		.kcontrol_new = &snd_us16x08_eq_mid_width_ctl,
@@ -1154,7 +1154,7 @@ static const struct snd_us16x08_control_params eq_controls[] = {
 		.control_id = SND_US16X08_ID_EQHIGHMIDFREQ,
 		.type = USB_MIXER_U8,
 		.num_channels = 16,
-		.name = "EQ MidHigh Frequence",
+		.name = "EQ MidHigh Frequency",
 	},
 	{ /* EQ mid high Q */
 		.kcontrol_new = &snd_us16x08_eq_mid_width_ctl,
@@ -1175,7 +1175,7 @@ static const struct snd_us16x08_control_params eq_controls[] = {
 		.control_id = SND_US16X08_ID_EQHIGHFREQ,
 		.type = USB_MIXER_U8,
 		.num_channels = 16,
-		.name = "EQ High Frequence",
+		.name = "EQ High Frequency",
 	},
 };
 
-- 
2.19.1

