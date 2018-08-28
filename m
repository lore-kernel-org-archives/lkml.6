Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A811C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14BF52084C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=birdec.tech header.i=@birdec.tech header.b="ZVeDfo82"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14BF52084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=birdec.tech
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbeH2Bfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 21:35:42 -0400
Received: from host.euro-space.net ([87.117.239.2]:48877 "EHLO
        host.euro-space.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeH2Bfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 21:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=birdec.tech
        ; s=default; h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OXN7eFTN3RfuR3y3CCBS3jV78rIhRUEtx6L4PzVtbW8=; b=ZVeDfo82zMDbxF//vXyvbpTAPj
        T/SaWuhwr4JT/Rfwj+gabFt8vkT8Oim7YqIRboIqB3GUmv4HUQwO9cYwESHHubhfm44GFicuYMOKH
        S8ZIkdAJH/fz1QoQmw1dSlOp+mAaKidhsGzP2dFXKvy4karM5i4xFKV7MQi5KGPEMynd0YS6D3TZQ
        9tF9PLH15eHAr+ff2oS28yRJ4ImXvyGalVF+3pTb2qGYoXof8WPxx4y3e4ghF1HgLnbB5PgUAfS0V
        U1Lr1+LLj01DHKF8OGDAsq8z6GNvyQ5+z6NZbxoewbx2F0cH00OerGbgw2/+bKC4WOop9rUemg6M1
        ZLvOVwAQ==;
Received: from x55b35620.dyn.telefonica.de ([85.179.86.32]:36818 helo=gentoo0.localdomain)
        by host.euro-space.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <kmarinushkin@birdec.tech>)
        id 1fulkS-00052G-B2; Tue, 28 Aug 2018 22:42:04 +0100
From:   Kirill Marinushkin <kmarinushkin@birdec.tech>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        M R Swami Reddy <mr.swami.reddy@ti.com>,
        Vishwas A Deshpande <vishwas.a.deshpande@ti.com>,
        Kevin Cernekee <cernekee@chromium.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Kirill Marinushkin <kmarinushkin@birdec.tech>
Subject: [PATCH 1/2] ASoC: pcm3060: Improve stylistics of file comments
Date:   Tue, 28 Aug 2018 23:42:30 +0200
Message-Id: <20180828214231.10164-1-kmarinushkin@birdec.tech>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180828194045.GQ2414@sirena.org.uk>
References: <20180828194045.GQ2414@sirena.org.uk>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.euro-space.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - birdec.tech
X-Get-Message-Sender-Via: host.euro-space.net: authenticated_id: kmarinushkin@birdec.tech
X-Authenticated-Sender: host.euro-space.net: kmarinushkin@birdec.tech
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modified the complete file comments in C++ style, to make them look more
intentional

Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.tech>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
---
 sound/soc/codecs/pcm3060-i2c.c | 9 ++++-----
 sound/soc/codecs/pcm3060-spi.c | 9 ++++-----
 sound/soc/codecs/pcm3060.c     | 9 ++++-----
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/pcm3060-i2c.c b/sound/soc/codecs/pcm3060-i2c.c
index 03d2b4323626..cdc8314882bc 100644
--- a/sound/soc/codecs/pcm3060-i2c.c
+++ b/sound/soc/codecs/pcm3060-i2c.c
@@ -1,9 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * PCM3060 I2C driver
- *
- * Copyright (C) 2018 Kirill Marinushkin <kmarinushkin@birdec.tech>
- */
+//
+// PCM3060 I2C driver
+//
+// Copyright (C) 2018 Kirill Marinushkin <kmarinushkin@birdec.tech>
 
 #include <linux/i2c.h>
 #include <linux/module.h>
diff --git a/sound/soc/codecs/pcm3060-spi.c b/sound/soc/codecs/pcm3060-spi.c
index 8961e095ae73..f6f19fa80932 100644
--- a/sound/soc/codecs/pcm3060-spi.c
+++ b/sound/soc/codecs/pcm3060-spi.c
@@ -1,9 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * PCM3060 SPI driver
- *
- * Copyright (C) 2018 Kirill Marinushkin <kmarinushkin@birdec.tech>
- */
+//
+// PCM3060 SPI driver
+//
+// Copyright (C) 2018 Kirill Marinushkin <kmarinushkin@birdec.tech>
 
 #include <linux/module.h>
 #include <linux/spi/spi.h>
diff --git a/sound/soc/codecs/pcm3060.c b/sound/soc/codecs/pcm3060.c
index ef7c627c9ac5..5b9718fa766d 100644
--- a/sound/soc/codecs/pcm3060.c
+++ b/sound/soc/codecs/pcm3060.c
@@ -1,9 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * PCM3060 codec driver
- *
- * Copyright (C) 2018 Kirill Marinushkin <kmarinushkin@birdec.tech>
- */
+//
+// PCM3060 codec driver
+//
+// Copyright (C) 2018 Kirill Marinushkin <kmarinushkin@birdec.tech>
 
 #include <linux/module.h>
 #include <sound/pcm_params.h>
-- 
2.13.6

