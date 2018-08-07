Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBD4C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6580821987
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/qPNPlb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6580821987
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389640AbeHGScr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 14:32:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389182AbeHGScq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 14:32:46 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C8A921976;
        Tue,  7 Aug 2018 16:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533658663;
        bh=rm6ActB9VHbxXGY1xShkba6CNgtZdTDDRxmMFsD9Jq4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=f/qPNPlbxcq9HlEi+c8Ir+68AcEf+Kx6LHgCOxjDIBgI6KdN9O5BM00OkCpN7/S6c
         xo/1izQrcXECrJgirgvMYOE682108vrvt8heVObhjJ7iQ2WOKtLxnuTCLrVqu/hIsj
         NNCALGfGvHEBz9B6/hQJCexycaWB9NFTznmzN7Qw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/3] clk: s2mps11,s3c64xx: Add SPDX license identifiers
Date:   Tue,  7 Aug 2018 18:17:12 +0200
Message-Id: <20180807161713.28073-2-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180807161713.28073-1-krzk@kernel.org>
References: <20180807161713.28073-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace GPL v2.0 and v2.0+ license statements with SPDX license
identifiers.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/clk/clk-s2mps11.c                         | 21 +++++----------------
 include/dt-bindings/clock/samsung,s2mps11.h       |  5 +----
 include/dt-bindings/clock/samsung,s3c64xx-clock.h |  7 ++-----
 3 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/clk/clk-s2mps11.c b/drivers/clk/clk-s2mps11.c
index d44e0eea31ec..ebf9115dad1d 100644
--- a/drivers/clk/clk-s2mps11.c
+++ b/drivers/clk/clk-s2mps11.c
@@ -1,19 +1,8 @@
-/*
- * clk-s2mps11.c - Clock driver for S2MPS11.
- *
- * Copyright (C) 2013,2014 Samsung Electornics
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
+// clk-s2mps11.c - Clock driver for S2MPS11.
+//
+// Copyright (C) 2013,2014 Samsung Electornics
 
 #include <linux/module.h>
 #include <linux/err.h>
diff --git a/include/dt-bindings/clock/samsung,s2mps11.h b/include/dt-bindings/clock/samsung,s2mps11.h
index b903d7de27c9..5ece35d429ff 100644
--- a/include/dt-bindings/clock/samsung,s2mps11.h
+++ b/include/dt-bindings/clock/samsung,s2mps11.h
@@ -1,10 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2015 Markus Reichl
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * Device Tree binding constants clocks for the Samsung S2MPS11 PMIC.
  */
 
diff --git a/include/dt-bindings/clock/samsung,s3c64xx-clock.h b/include/dt-bindings/clock/samsung,s3c64xx-clock.h
index ad95c7f50090..19d233f37e2f 100644
--- a/include/dt-bindings/clock/samsung,s3c64xx-clock.h
+++ b/include/dt-bindings/clock/samsung,s3c64xx-clock.h
@@ -1,12 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2013 Tomasz Figa <tomasz.figa at gmail.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * Device Tree binding constants for Samsung S3C64xx clock controller.
-*/
+ */
 
 #ifndef _DT_BINDINGS_CLOCK_SAMSUNG_S3C64XX_CLOCK_H
 #define _DT_BINDINGS_CLOCK_SAMSUNG_S3C64XX_CLOCK_H
-- 
2.14.1

