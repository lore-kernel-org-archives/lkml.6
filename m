Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DAAC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F11D20870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544551378;
	bh=vUwxGnAwijvpOD5m7Jdnt+freu/VCN/533NFd85d8q8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zj0TZOAVp4sy3+0B9nACc7SZ9+PFSa0kmy8xuB6P24Y8w6uFe+wuDOejKjUGLRfYv
	 Tfts6E+JPxR1HZDOCVKGRCF2H3k7cY1QOMCKgY0HikjGI3bf2NL18nlkklmsyBVJ3+
	 ugPZC3KPU+LzLG17dqn+yTBbGjCKC2Ea2WWpXtxU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F11D20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbeLKSCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 13:02:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:47658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbeLKSCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 13:02:52 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1888E20879;
        Tue, 11 Dec 2018 18:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544551371;
        bh=vUwxGnAwijvpOD5m7Jdnt+freu/VCN/533NFd85d8q8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cRt3pgXTHOsxMMrLh1wemScd9kmkCOmNlpDZUz59Vd1wWzXl1hm1u9sMf134FGSBc
         VKBVNd2k9PI/2WIseZeLn5qZxVyubhruuDIJR2Zsqgpo4fCminQMuelATFrydbvqeW
         Mu445CIxmdxtTXB1pwp2Kqq9tddnTx61jcDehL4s=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH 2/2] clk: Tag basic clk types with SPDX
Date:   Tue, 11 Dec 2018 10:02:50 -0800
Message-Id: <20181211180250.220623-2-sboyd@kernel.org>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
In-Reply-To: <20181211180250.220623-1-sboyd@kernel.org>
References: <20181211180250.220623-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are all GPL-2.0 files per the existing license text. Replace the
boiler plate with the tag.

Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk-composite.c          | 13 +------------
 drivers/clk/clk-divider.c            |  5 +----
 drivers/clk/clk-fixed-factor.c       |  7 +------
 drivers/clk/clk-fixed-rate.c         |  5 +----
 drivers/clk/clk-fractional-divider.c |  5 +----
 drivers/clk/clk-gate.c               |  5 +----
 drivers/clk/clk-gpio.c               |  5 +----
 drivers/clk/clk-multiplier.c         |  5 +----
 drivers/clk/clk-mux.c                |  5 +----
 9 files changed, 9 insertions(+), 46 deletions(-)

diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index 00269de2f390..46604214bba0 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -1,17 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2013 NVIDIA CORPORATION.  All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <linux/clk.h>
diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index b6234a5da12d..e5a17265cfaf 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2011 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
  * Copyright (C) 2011 Richard Zhao, Linaro <richard.zhao@linaro.org>
  * Copyright (C) 2011-2012 Mike Turquette, Linaro Ltd <mturquette@linaro.org>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * Adjustable divider clock implementation
  */
 
diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
index ef0ca9414f37..739e19dcacfa 100644
--- a/drivers/clk/clk-fixed-factor.c
+++ b/drivers/clk/clk-fixed-factor.c
@@ -1,11 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2011 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Standard functionality for the common clock API.
  */
 #include <linux/module.h>
 #include <linux/clk-provider.h>
diff --git a/drivers/clk/clk-fixed-rate.c b/drivers/clk/clk-fixed-rate.c
index 6d6475c32ee5..00ef4f5e53fe 100644
--- a/drivers/clk/clk-fixed-rate.c
+++ b/drivers/clk/clk-fixed-rate.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2010-2011 Canonical Ltd <jeremy.kerr@canonical.com>
  * Copyright (C) 2011-2012 Mike Turquette, Linaro Ltd <mturquette@linaro.org>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * Fixed rate clock implementation
  */
 
diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
index fdf625fb10fa..830f1361ff79 100644
--- a/drivers/clk/clk-fractional-divider.c
+++ b/drivers/clk/clk-fractional-divider.c
@@ -1,10 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2014 Intel Corporation
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * Adjustable fractional divider clock implementation.
  * Output rate = (m / n) * parent_rate.
  * Uses rational best approximation algorithm.
diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index dd82485e09a1..f05823cd9b21 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2010-2011 Canonical Ltd <jeremy.kerr@canonical.com>
  * Copyright (C) 2011-2012 Mike Turquette, Linaro Ltd <mturquette@linaro.org>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * Gated clock implementation
  */
 
diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
index 6a43ce420492..25eed3e0251f 100644
--- a/drivers/clk/clk-gpio.c
+++ b/drivers/clk/clk-gpio.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2013 - 2014 Texas Instruments Incorporated - http://www.ti.com
  *
@@ -5,10 +6,6 @@
  *    Jyri Sarha <jsarha@ti.com>
  *    Sergej Sawazki <ce3a@gmx.de>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * Gpio controlled clock implementation
  */
 
diff --git a/drivers/clk/clk-multiplier.c b/drivers/clk/clk-multiplier.c
index dc037c957acd..3c86f859c199 100644
--- a/drivers/clk/clk-multiplier.c
+++ b/drivers/clk/clk-multiplier.c
@@ -1,9 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2015 Maxime Ripard <maxime.ripard@free-electrons.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/bitops.h>
diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 1628b93655ed..2ad2df2e8909 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2011 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
  * Copyright (C) 2011 Richard Zhao, Linaro <richard.zhao@linaro.org>
  * Copyright (C) 2011-2012 Mike Turquette, Linaro Ltd <mturquette@linaro.org>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * Simple multiplexer clock implementation
  */
 
-- 
Sent by a computer through tubes

