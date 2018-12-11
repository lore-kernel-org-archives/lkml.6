Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2196C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6667C20855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544551374;
	bh=KdyxI7TE3Yqp+COAd+9kG2WERYSsyLTqUCaC7tpMNUA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=VIxzfXWyKuf/0+OyNiGj4kWRVMt0TIjTP4jTYbSPSI2mcJqTspDR8ckekKUOcXELN
	 +1obd5FJpNVpB4iupDs+M/gJ5nfCNxuee1gE/CHciak1uhclGItEGqWJ11JO1AhoKr
	 72xxXhmts5q7Ckot6jUKY46Ywpjx4rWxqLHCh/Yc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6667C20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbeLKSCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 13:02:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:47650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbeLKSCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 13:02:52 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C907A20855;
        Tue, 11 Dec 2018 18:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544551370;
        bh=KdyxI7TE3Yqp+COAd+9kG2WERYSsyLTqUCaC7tpMNUA=;
        h=From:To:Cc:Subject:Date:From;
        b=FRQfzCC1XkQx3C8nlZYFomn1vE9s/ehdvb4r+tqt6dODn7sq1BC9+WGQDtjoe7WTM
         qIbnDYXiUBlXy+iwoeDmWkBf53Lqb5x9FEXJPXYnhF9/hLL/+3y7gNyYuZ2uc2aLGm
         wjF6pythTc1T+MJIKVTvGNu1SOAf2ZzSb4c6SnX8=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH 1/2] clk: Tag clk core files with SPDX
Date:   Tue, 11 Dec 2018 10:02:49 -0800
Message-Id: <20181211180250.220623-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
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
 drivers/clk/clk-bulk.c       | 13 +------------
 drivers/clk/clk-conf.c       |  5 +----
 drivers/clk/clk-devres.c     |  7 +------
 drivers/clk/clk.c            |  5 +----
 drivers/clk/clk.h            |  7 +------
 include/linux/clk-provider.h |  7 +------
 include/linux/clk/clk-conf.h |  5 +----
 7 files changed, 7 insertions(+), 42 deletions(-)

diff --git a/drivers/clk/clk-bulk.c b/drivers/clk/clk-bulk.c
index 6a7118d4250a..06499568cf07 100644
--- a/drivers/clk/clk-bulk.c
+++ b/drivers/clk/clk-bulk.c
@@ -1,19 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright 2017 NXP
  *
  * Dong Aisheng <aisheng.dong@nxp.com>
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
diff --git a/drivers/clk/clk-conf.c b/drivers/clk/clk-conf.c
index 49819b546134..2ef819606c41 100644
--- a/drivers/clk/clk-conf.c
+++ b/drivers/clk/clk-conf.c
@@ -1,10 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2014 Samsung Electronics Co., Ltd.
  * Sylwester Nawrocki <s.nawrocki@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/clk.h>
diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index 12c87457eca1..c9a86156ced8 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -1,9 +1,4 @@
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
+// SPDX-License-Identifier: GPL-2.0
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/export.h>
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index af011974d4ec..27260971bb39 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2010-2011 Canonical Ltd <jeremy.kerr@canonical.com>
  * Copyright (C) 2011-2012 Linaro Ltd <mturquette@linaro.org>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * Standard functionality for the common clock API.  See Documentation/driver-api/clk.rst
  */
 
diff --git a/drivers/clk/clk.h b/drivers/clk/clk.h
index 70c0ba6336c1..b02f5e604e69 100644
--- a/drivers/clk/clk.h
+++ b/drivers/clk/clk.h
@@ -1,12 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
- * linux/drivers/clk/clk.h
- *
  * Copyright (C) 2013 Samsung Electronics Co., Ltd.
  * Sylwester Nawrocki <s.nawrocki@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 struct clk_hw;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 60c51871b04b..a2daf4572b05 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -1,12 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
- *  linux/include/linux/clk-provider.h
- *
  *  Copyright (c) 2010-2011 Jeremy Kerr <jeremy.kerr@canonical.com>
  *  Copyright (C) 2011-2012 Linaro Ltd <mturquette@linaro.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 #ifndef __LINUX_CLK_PROVIDER_H
 #define __LINUX_CLK_PROVIDER_H
diff --git a/include/linux/clk/clk-conf.h b/include/linux/clk/clk-conf.h
index e0c362363c38..85f8cf9d1226 100644
--- a/include/linux/clk/clk-conf.h
+++ b/include/linux/clk/clk-conf.h
@@ -1,10 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2014 Samsung Electronics Co., Ltd.
  * Sylwester Nawrocki <s.nawrocki@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/types.h>
-- 
Sent by a computer through tubes

