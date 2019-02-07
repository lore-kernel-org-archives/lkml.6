Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489A0C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11A2C2146E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="otSwXedA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfBGNcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 08:32:09 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:56034 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfBGNcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 08:32:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1549546325; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0IHQRn/honER6JHTx7p3v7K+1PpZxisknFPV85Z9kmU=;
        b=otSwXedAsB8ACtGPEf54/L36PUjfZC9xIWGO7lCnxvC8PIA/JE2c4L8FMXZQqKn/LKeYp+
        mF0GW9yYgSsUx59lcAkU/sIFJECJkMGn0Sx8HAXUhuju9MtbkvPhb+WBFlTr3iOo5rO4XT
        AxJScwb3P94BrHaVFwGALhLc2R5VvzE=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 3/6] ASoC: codecs: jz4740: Use SPDX license notifier
Date:   Thu,  7 Feb 2019 10:31:40 -0300
Message-Id: <20190207133143.5232-3-paul@crapouillou.net>
In-Reply-To: <20190207133143.5232-1-paul@crapouillou.net>
References: <20190207133143.5232-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add license information as a standard SPDX license notifier instead of
custom text.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Changes:

v2: Use C++ style comment

 sound/soc/codecs/jz4740.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/jz4740.c b/sound/soc/codecs/jz4740.c
index 9395b583432c..9b3e1227a971 100644
--- a/sound/soc/codecs/jz4740.c
+++ b/sound/soc/codecs/jz4740.c
@@ -1,15 +1,8 @@
-/*
- * Copyright (C) 2009-2010, Lars-Peter Clausen <lars@metafoo.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// JZ4740 CODEC driver
+//
+// Copyright (C) 2009-2010, Lars-Peter Clausen <lars@metafoo.de>
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-- 
2.11.0

