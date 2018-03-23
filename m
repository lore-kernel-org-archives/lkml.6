Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752412AbeCWJT2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 05:19:28 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:39333 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752014AbeCWJPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 05:15:31 -0400
X-UUID: fe5a481ed9394905b6a8be80373bccff-20180323
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <sre@kernel.org>,
        <lee.jones@linaro.org>, <a.zummo@towertech.it>,
        <alexandre.belloni@free-electrons.com>, <eddie.huang@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 13/16] rtc: mediatek: update license converting to using SPDX identifiers
Date: Fri, 23 Mar 2018 17:15:10 +0800
Message-ID: <86450fc8dcc53c658e97ac739aac2bf7d1f94b64.1521794177.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1521794176.git.sean.wang@mediatek.com>
References: <cover.1521794176.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23736.004
X-TM-AS-Result: No-5.580400-8.000000-10
X-TMASE-MatchedRID: d0WP0JJEp0RBHBd/Q+ztB+G5dRZCgxC3VBDQSDMig9HEosIs7IJbkGcv
        LxxWTXnK7CW5xFA6WTJ8m0eKI/dFAJYfiJHiUPPG2Hdvv/MGE3WtfY6YPaw3YTzzULHH1XTjMA0
        TvVWjWva98qutvhuYitwezITcev2HHxPMjOKY7A8LbigRnpKlKWxlRJiH4397Tk1v6FWn3kDeUW
        2U/Cf2yeUE6zYBnqJBrH3PsN4Jf8Jpt/bXV4VNGg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.580400-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23736.004
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Update the license and as well convert to using SPDX identifiers.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/rtc/rtc-mt6397.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index f5dc70d..ad336a4 100644
--- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -1,16 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
-* Copyright (c) 2014-2015 MediaTek Inc.
-* Author: Tianping.Fang <tianping.fang@mediatek.com>
-*
-* This program is free software; you can redistribute it and/or modify
-* it under the terms of the GNU General Public License version 2 as
-* published by the Free Software Foundation.
-*
-* This program is distributed in the hope that it will be useful,
-* but WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-* GNU General Public License for more details.
-*/
+ * MediaTek PMIC RTC driver
+ *
+ * Copyright (C) 2014-2018 MediaTek Inc.
+ *
+ * Author: Tianping.Fang <tianping.fang@mediatek.com>
+ *	   Sean Wang <sean.wang@mediatek.com>
+ */
 
 #include <linux/err.h>
 #include <linux/interrupt.h>
-- 
2.7.4
