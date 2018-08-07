Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1D3C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63052175E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHEeZmGl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C63052175E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390153AbeHGSeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 14:34:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387851AbeHGSeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 14:34:06 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A63E2174B;
        Tue,  7 Aug 2018 16:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533658744;
        bh=y2FeSwVT0yUQDIWAUOE+IJzkjX0hTfoy87PiA2E2Xqg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eHEeZmGlu+Td7VIUA39JbEXNxEnPtt9PTm3uPa0XKI8th41O2fCASAeiSGXc4isKT
         cbe/CVK7qqTIvo3Oax7XzMLLyHjy8I91gwvs2rEya8tiSBjU0QKTGX00XYOnpknYa+
         gxRkCGooSJ0Y3+AN50nMrDMIW9vfSiHFMnhAmML0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/2] regulator: samsung: Add SPDX license identifiers
Date:   Tue,  7 Aug 2018 18:18:26 +0200
Message-Id: <20180807161826.2222-2-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180807161826.2222-1-krzk@kernel.org>
References: <20180807161826.2222-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace GPL v2.0+ license statements with SPDX license
identifiers.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/regulator/s2mpa01.c | 14 ++++----------
 drivers/regulator/s2mps11.c | 21 ++++-----------------
 drivers/regulator/s5m8767.c | 16 ++++------------
 3 files changed, 12 insertions(+), 39 deletions(-)

diff --git a/drivers/regulator/s2mpa01.c b/drivers/regulator/s2mpa01.c
index 48f0ca90743c..095d25f3d2ea 100644
--- a/drivers/regulator/s2mpa01.c
+++ b/drivers/regulator/s2mpa01.c
@@ -1,13 +1,7 @@
-/*
- * Copyright (c) 2013 Samsung Electronics Co., Ltd
- *		http://www.samsung.com
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright (c) 2013 Samsung Electronics Co., Ltd
+//		http://www.samsung.com
 
 #include <linux/bug.h>
 #include <linux/err.h>
diff --git a/drivers/regulator/s2mps11.c b/drivers/regulator/s2mps11.c
index d1207ec683db..5bb6f4ca48db 100644
--- a/drivers/regulator/s2mps11.c
+++ b/drivers/regulator/s2mps11.c
@@ -1,20 +1,7 @@
-/*
- * s2mps11.c
- *
- * Copyright (c) 2012-2014 Samsung Electronics Co., Ltd
- *              http://www.samsung.com
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright (c) 2012-2014 Samsung Electronics Co., Ltd
+//              http://www.samsung.com
 
 #include <linux/bug.h>
 #include <linux/err.h>
diff --git a/drivers/regulator/s5m8767.c b/drivers/regulator/s5m8767.c
index 0cbc980753c2..667d16dc83ce 100644
--- a/drivers/regulator/s5m8767.c
+++ b/drivers/regulator/s5m8767.c
@@ -1,15 +1,7 @@
-/*
- * s5m8767.c
- *
- * Copyright (c) 2011 Samsung Electronics Co., Ltd
- *              http://www.samsung.com
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright (c) 2011 Samsung Electronics Co., Ltd
+//              http://www.samsung.com
 
 #include <linux/err.h>
 #include <linux/of_gpio.h>
-- 
2.14.1

