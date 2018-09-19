Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8192FECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A3A7214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A3A7214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbeISGwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 02:52:08 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33588 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729926AbeISGwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 02:52:07 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2EC1A20898; Wed, 19 Sep 2018 03:16:49 +0200 (CEST)
Received: from localhost (unknown [65.155.82.100])
        by mail.bootlin.com (Postfix) with ESMTPSA id 744552071E;
        Wed, 19 Sep 2018 03:16:38 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/2] rtc: test: make license text and module license match.
Date:   Wed, 19 Sep 2018 03:16:31 +0200
Message-Id: <20180919011632.4459-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The license text is specifying GPL v2 only but the MODULE_LICENSE is set to
GPL which means GNU Public License v2 or later. When MODULE_LICENSE and
boiler plate does not match, go for boiler plate license.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-test.c b/drivers/rtc/rtc-test.c
index ade6a82709be..93f1638fb8c8 100644
--- a/drivers/rtc/rtc-test.c
+++ b/drivers/rtc/rtc-test.c
@@ -197,7 +197,7 @@ static void __exit test_exit(void)
 
 MODULE_AUTHOR("Alessandro Zummo <a.zummo@towertech.it>");
 MODULE_DESCRIPTION("RTC test driver/device");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 
 module_init(test_init);
 module_exit(test_exit);
-- 
2.19.0

