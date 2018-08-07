Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DBCC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC722198E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJZCnMoV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDC722198E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390185AbeHGSev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 14:34:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:60572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388939AbeHGSeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 14:34:50 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C95421976;
        Tue,  7 Aug 2018 16:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533658787;
        bh=zfg2apA2PmBA6a/PJLkwtmuc0SEHbXMqLWkHza7Ig3Y=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=rJZCnMoVYIfvHCgMQl0cv84rxdnxnrnrqgHi9WPFuh0Xk36RpRgoe4NJSJvgmBmM6
         iRQji/8vbM+ywzcvmP9PvGA9lyfqRIJ3QRak1EjSVhTpQlm1Fuv+HnHWevgzjulgsr
         VA+qzwA08h+ikOrlIapYuA+uj6l9XHB8iNcD5gec=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sangbeom Kim <sbkim73@samsung.com>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 2/2] rtc: s5m: Add SPDX license identifier
Date:   Tue,  7 Aug 2018 18:19:19 +0200
Message-Id: <20180807161919.7827-2-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180807161919.7827-1-krzk@kernel.org>
References: <20180807161919.7827-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace GPL v2.0+ license statement with SPDX license
identifier.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/rtc/rtc-s5m.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
index 8428455432ca..6495f84f7428 100644
--- a/drivers/rtc/rtc-s5m.c
+++ b/drivers/rtc/rtc-s5m.c
@@ -1,19 +1,9 @@
-/*
- * Copyright (c) 2013-2014 Samsung Electronics Co., Ltd
- *	http://www.samsung.com
- *
- *  Copyright (C) 2013 Google, Inc
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright (c) 2013-2014 Samsung Electronics Co., Ltd
+//	http://www.samsung.com
+//
+//  Copyright (C) 2013 Google, Inc
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-- 
2.14.1

