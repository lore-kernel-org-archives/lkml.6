Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B3CC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 23:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0DAB21568
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 23:22:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0DAB21568
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391625AbeIVFN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 01:13:56 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54766 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725748AbeIVFN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 01:13:56 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2C4222071E; Sat, 22 Sep 2018 01:22:49 +0200 (CEST)
Received: from localhost (unknown [67.133.97.99])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0AEFE20618;
        Sat, 22 Sep 2018 01:22:37 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: lib: correct documentation typo
Date:   Sat, 22 Sep 2018 01:22:34 +0200
Message-Id: <20180921232234.23164-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtc_time64_to_tm has not been called rtc_time_to_tm64

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-lib.c b/drivers/rtc/rtc-lib.c
index 4a3c0f3aab14..ef160da84220 100644
--- a/drivers/rtc/rtc-lib.c
+++ b/drivers/rtc/rtc-lib.c
@@ -47,7 +47,7 @@ EXPORT_SYMBOL(rtc_year_days);
 
 
 /*
- * rtc_time_to_tm64 - Converts time64_t to rtc_time.
+ * rtc_time64_to_tm - Converts time64_t to rtc_time.
  * Convert seconds since 01-01-1970 00:00:00 to Gregorian date.
  */
 void rtc_time64_to_tm(time64_t time, struct rtc_time *tm)
-- 
2.19.0

