Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EE8C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8DE921582
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwlf8HhN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8DE921582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbeI0XYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:24:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbeI0XYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:24:02 -0400
Received: from localhost.localdomain (unknown [178.38.103.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A6AC21566;
        Thu, 27 Sep 2018 17:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538067888;
        bh=Stsxz9rm1Iy5qCpV64yewtYA9u5OGcZpxSpAIln2h0c=;
        h=From:To:Subject:Date:From;
        b=mwlf8HhNIpGER8eAk9WebsXq2u/yjqUf6uiH00UkP3ndBs+Jn8erXskO/PjRNURIV
         gJTKhGqJM6zeOVLjjrxMYZ78EhUOSD4oo6sJ9kK3tmxPHxZM732SScZcEQRbKx4zG0
         rERihhch7MNGkA69y2iSo82FDxD9YRDEhor1bF8E=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND] dt-bindings: clock: samsung: Add SPDX license identifiers
Date:   Thu, 27 Sep 2018 19:03:47 +0200
Message-Id: <20180927170347.12909-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace GPL license statements with SPDX license identifiers (GPL-2.0).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/clock/exynos3250.h     | 5 +----
 include/dt-bindings/clock/exynos4.h        | 7 ++-----
 include/dt-bindings/clock/exynos5250.h     | 7 ++-----
 include/dt-bindings/clock/exynos5260-clk.h | 7 ++-----
 include/dt-bindings/clock/exynos5410.h     | 7 ++-----
 include/dt-bindings/clock/exynos5420.h     | 7 ++-----
 include/dt-bindings/clock/exynos5433.h     | 5 +----
 include/dt-bindings/clock/exynos7-clk.h    | 7 ++-----
 include/dt-bindings/clock/s3c2410.h        | 5 +----
 include/dt-bindings/clock/s3c2412.h        | 5 +----
 include/dt-bindings/clock/s3c2443.h        | 5 +----
 11 files changed, 17 insertions(+), 50 deletions(-)

diff --git a/include/dt-bindings/clock/exynos3250.h b/include/dt-bindings/clock/exynos3250.h
index c796ff02ceeb..fe8214017b46 100644
--- a/include/dt-bindings/clock/exynos3250.h
+++ b/include/dt-bindings/clock/exynos3250.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2014 Samsung Electronics Co., Ltd.
  * 	Author: Tomasz Figa <t.figa@samsung.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * Device Tree binding constants for Samsung Exynos3250 clock controllers.
  */
 
diff --git a/include/dt-bindings/clock/exynos4.h b/include/dt-bindings/clock/exynos4.h
index f59ea85d77bd..a0439ce8e8d3 100644
--- a/include/dt-bindings/clock/exynos4.h
+++ b/include/dt-bindings/clock/exynos4.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2013 Samsung Electronics Co., Ltd.
  * Author: Andrzej Hajda <a.hajda@samsung.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * Device Tree binding constants for Exynos4 clock controller.
-*/
+ */
 
 #ifndef _DT_BINDINGS_CLOCK_EXYNOS_4_H
 #define _DT_BINDINGS_CLOCK_EXYNOS_4_H
diff --git a/include/dt-bindings/clock/exynos5250.h b/include/dt-bindings/clock/exynos5250.h
index 15508adcdfde..bc8a3c53a54b 100644
--- a/include/dt-bindings/clock/exynos5250.h
+++ b/include/dt-bindings/clock/exynos5250.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2013 Samsung Electronics Co., Ltd.
  * Author: Andrzej Hajda <a.hajda@samsung.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * Device Tree binding constants for Exynos5250 clock controller.
-*/
+ */
 
 #ifndef _DT_BINDINGS_CLOCK_EXYNOS_5250_H
 #define _DT_BINDINGS_CLOCK_EXYNOS_5250_H
diff --git a/include/dt-bindings/clock/exynos5260-clk.h b/include/dt-bindings/clock/exynos5260-clk.h
index a4bac9a1764f..98a58cbd81b2 100644
--- a/include/dt-bindings/clock/exynos5260-clk.h
+++ b/include/dt-bindings/clock/exynos5260-clk.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2014 Samsung Electronics Co., Ltd.
  * Author: Rahul Sharma <rahul.sharma@samsung.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * Provides Constants for Exynos5260 clocks.
-*/
+ */
 
 #ifndef _DT_BINDINGS_CLK_EXYNOS5260_H
 #define _DT_BINDINGS_CLK_EXYNOS5260_H
diff --git a/include/dt-bindings/clock/exynos5410.h b/include/dt-bindings/clock/exynos5410.h
index 6cb4e90f81fc..f179eabbcdb7 100644
--- a/include/dt-bindings/clock/exynos5410.h
+++ b/include/dt-bindings/clock/exynos5410.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2014 Samsung Electronics Co., Ltd.
  * Copyright (c) 2016 Krzysztof Kozlowski
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * Device Tree binding constants for Exynos5421 clock controller.
-*/
+ */
 
 #ifndef _DT_BINDINGS_CLOCK_EXYNOS_5410_H
 #define _DT_BINDINGS_CLOCK_EXYNOS_5410_H
diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
index 2740ae0424a9..355f469943f1 100644
--- a/include/dt-bindings/clock/exynos5420.h
+++ b/include/dt-bindings/clock/exynos5420.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2013 Samsung Electronics Co., Ltd.
  * Author: Andrzej Hajda <a.hajda@samsung.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * Device Tree binding constants for Exynos5420 clock controller.
-*/
+ */
 
 #ifndef _DT_BINDINGS_CLOCK_EXYNOS_5420_H
 #define _DT_BINDINGS_CLOCK_EXYNOS_5420_H
diff --git a/include/dt-bindings/clock/exynos5433.h b/include/dt-bindings/clock/exynos5433.h
index be39d23e6a32..98bd85ce1e45 100644
--- a/include/dt-bindings/clock/exynos5433.h
+++ b/include/dt-bindings/clock/exynos5433.h
@@ -1,10 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2014 Samsung Electronics Co., Ltd.
  * Author: Chanwoo Choi <cw00.choi@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef _DT_BINDINGS_CLOCK_EXYNOS5433_H
diff --git a/include/dt-bindings/clock/exynos7-clk.h b/include/dt-bindings/clock/exynos7-clk.h
index 10c558611085..fce33c7050c8 100644
--- a/include/dt-bindings/clock/exynos7-clk.h
+++ b/include/dt-bindings/clock/exynos7-clk.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2014 Samsung Electronics Co., Ltd.
  * Author: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #ifndef _DT_BINDINGS_CLOCK_EXYNOS7_H
 #define _DT_BINDINGS_CLOCK_EXYNOS7_H
diff --git a/include/dt-bindings/clock/s3c2410.h b/include/dt-bindings/clock/s3c2410.h
index 352a7673fc69..0fb65c3f2f59 100644
--- a/include/dt-bindings/clock/s3c2410.h
+++ b/include/dt-bindings/clock/s3c2410.h
@@ -1,10 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2013 Heiko Stuebner <heiko@sntech.de>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * Device Tree binding constants clock controllers of Samsung S3C2410 and later.
  */
 
diff --git a/include/dt-bindings/clock/s3c2412.h b/include/dt-bindings/clock/s3c2412.h
index aac1dcfda81c..b4656156cc0f 100644
--- a/include/dt-bindings/clock/s3c2412.h
+++ b/include/dt-bindings/clock/s3c2412.h
@@ -1,10 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2013 Heiko Stuebner <heiko@sntech.de>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * Device Tree binding constants clock controllers of Samsung S3C2412.
  */
 
diff --git a/include/dt-bindings/clock/s3c2443.h b/include/dt-bindings/clock/s3c2443.h
index f3ba68a25ecb..a9d2f105d536 100644
--- a/include/dt-bindings/clock/s3c2443.h
+++ b/include/dt-bindings/clock/s3c2443.h
@@ -1,10 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2013 Heiko Stuebner <heiko@sntech.de>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * Device Tree binding constants clock controllers of Samsung S3C2443 and later.
  */
 
-- 
2.17.1

