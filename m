Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D87C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF28C20663
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="FQojp7eD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfBGNcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 08:32:22 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:56144 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfBGNcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 08:32:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1549546337; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Rw7gQB2frOCl7pJyH2E/ulHtR62yolEE+dS9lQXMuSI=;
        b=FQojp7eDNaF9YGSxbiuIePe2T/obBoyOyMdTr+vXwqkLFHh2UXyK9Jk3NhnZOHx015GqJ2
        kQLUvB3TkOmIm8a00i6+Bq08RYcENVuqrb1KPOJmF2bl1mSx/bLZm4kScKyGhVx2IhTkjl
        jzYIVORMj1YHoD+Cz5zZwPaLeXvpw90=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 6/6] ASoC: codecs: jz4725b: Use C++ style comments in header
Date:   Thu,  7 Feb 2019 10:31:43 -0300
Message-Id: <20190207133143.5232-6-paul@crapouillou.net>
In-Reply-To: <20190207133143.5232-1-paul@crapouillou.net>
References: <20190207133143.5232-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the header comment to use C++ style, so that it looks more
consistent with the rest of ASoC.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Changes:

v2: New patch

 sound/soc/codecs/jz4725b.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/jz4725b.c b/sound/soc/codecs/jz4725b.c
index 24b1b23b99c9..103ccbc5d55c 100644
--- a/sound/soc/codecs/jz4725b.c
+++ b/sound/soc/codecs/jz4725b.c
@@ -1,9 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * JZ4725B CODEC driver
- *
- * Copyright (C) 2019, Paul Cercueil <paul@crapouillou.net>
- */
+//
+// JZ4725B CODEC driver
+//
+// Copyright (C) 2019, Paul Cercueil <paul@crapouillou.net>
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-- 
2.11.0

