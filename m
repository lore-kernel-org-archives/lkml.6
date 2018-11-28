Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E394AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E13208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1E13208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbeK2CgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:36:14 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:47753 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbeK2CgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 21:36:14 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gS1qr-0006ma-Rs; Wed, 28 Nov 2018 15:34:09 +0000
From:   Colin King <colin.king@canonical.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [media] tda7432: fix spelling mistake "maximium" -> "maximum"
Date:   Wed, 28 Nov 2018 15:34:09 +0000
Message-Id: <20181128153409.13941-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the module description as well
as a comment. Fix them.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/media/i2c/tda7432.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/tda7432.c b/drivers/media/i2c/tda7432.c
index 9b4f21237810..06a78c2cdaab 100644
--- a/drivers/media/i2c/tda7432.c
+++ b/drivers/media/i2c/tda7432.c
@@ -19,7 +19,7 @@
  *
  * loudness - set between 0 and 15 for varying degrees of loudness effect
  *
- * maxvol   - set maximium volume to +20db (1), default is 0db(0)
+ * maxvol   - set maximum volume to +20db (1), default is 0db(0)
  */
 
 #include <linux/module.h>
@@ -53,7 +53,7 @@ MODULE_PARM_DESC(debug, "Set debugging level from 0 to 3. Default is off(0).");
 module_param(loudness, int, S_IRUGO);
 MODULE_PARM_DESC(loudness, "Turn loudness on(1) else off(0). Default is off(0).");
 module_param(maxvol, int, S_IRUGO | S_IWUSR);
-MODULE_PARM_DESC(maxvol, "Set maximium volume to +20dB(0) else +0dB(1). Default is +20dB(0).");
+MODULE_PARM_DESC(maxvol, "Set maximum volume to +20dB(0) else +0dB(1). Default is +20dB(0).");
 
 
 /* Structure of address and subaddresses for the tda7432 */
-- 
2.19.1

