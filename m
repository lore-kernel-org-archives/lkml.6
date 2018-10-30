Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB0EC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA6020827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA6020827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbeJ3UuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 16:50:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49516 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbeJ3UuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 16:50:05 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gHSde-0006Vw-VA; Tue, 30 Oct 2018 11:56:51 +0000
From:   Colin King <colin.king@canonical.com>
To:     Mark Gross <mark.gross@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tlclk: lean an indentation issue, remove extraneous tabs
Date:   Tue, 30 Oct 2018 11:56:50 +0000
Message-Id: <20181030115650.21104-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to clean up an indentation issue, remove tabs

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/char/tlclk.c | 84 ++++++++++++++++++++++----------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/char/tlclk.c b/drivers/char/tlclk.c
index 8eeb4190207d..a0f2c0506176 100644
--- a/drivers/char/tlclk.c
+++ b/drivers/char/tlclk.c
@@ -506,27 +506,27 @@ static ssize_t store_select_amcb2_transmit_clock(struct device *d,
 
 	val = (unsigned char)tmp;
 	spin_lock_irqsave(&event_lock, flags);
-		if ((val == CLK_8kHz) || (val == CLK_16_384MHz)) {
-			SET_PORT_BITS(TLCLK_REG3, 0xc7, 0x28);
-			SET_PORT_BITS(TLCLK_REG1, 0xfb, ~val);
-		} else if (val >= CLK_8_592MHz) {
-			SET_PORT_BITS(TLCLK_REG3, 0xc7, 0x38);
-			switch (val) {
-			case CLK_8_592MHz:
-				SET_PORT_BITS(TLCLK_REG0, 0xfc, 2);
-				break;
-			case CLK_11_184MHz:
-				SET_PORT_BITS(TLCLK_REG0, 0xfc, 0);
-				break;
-			case CLK_34_368MHz:
-				SET_PORT_BITS(TLCLK_REG0, 0xfc, 3);
-				break;
-			case CLK_44_736MHz:
-				SET_PORT_BITS(TLCLK_REG0, 0xfc, 1);
-				break;
-			}
-		} else
-			SET_PORT_BITS(TLCLK_REG3, 0xc7, val << 3);
+	if ((val == CLK_8kHz) || (val == CLK_16_384MHz)) {
+		SET_PORT_BITS(TLCLK_REG3, 0xc7, 0x28);
+		SET_PORT_BITS(TLCLK_REG1, 0xfb, ~val);
+	} else if (val >= CLK_8_592MHz) {
+		SET_PORT_BITS(TLCLK_REG3, 0xc7, 0x38);
+		switch (val) {
+		case CLK_8_592MHz:
+			SET_PORT_BITS(TLCLK_REG0, 0xfc, 2);
+			break;
+		case CLK_11_184MHz:
+			SET_PORT_BITS(TLCLK_REG0, 0xfc, 0);
+			break;
+		case CLK_34_368MHz:
+			SET_PORT_BITS(TLCLK_REG0, 0xfc, 3);
+			break;
+		case CLK_44_736MHz:
+			SET_PORT_BITS(TLCLK_REG0, 0xfc, 1);
+			break;
+		}
+	} else
+		SET_PORT_BITS(TLCLK_REG3, 0xc7, val << 3);
 
 	spin_unlock_irqrestore(&event_lock, flags);
 
@@ -548,27 +548,27 @@ static ssize_t store_select_amcb1_transmit_clock(struct device *d,
 
 	val = (unsigned char)tmp;
 	spin_lock_irqsave(&event_lock, flags);
-		if ((val == CLK_8kHz) || (val == CLK_16_384MHz)) {
-			SET_PORT_BITS(TLCLK_REG3, 0xf8, 0x5);
-			SET_PORT_BITS(TLCLK_REG1, 0xfb, ~val);
-		} else if (val >= CLK_8_592MHz) {
-			SET_PORT_BITS(TLCLK_REG3, 0xf8, 0x7);
-			switch (val) {
-			case CLK_8_592MHz:
-				SET_PORT_BITS(TLCLK_REG0, 0xfc, 2);
-				break;
-			case CLK_11_184MHz:
-				SET_PORT_BITS(TLCLK_REG0, 0xfc, 0);
-				break;
-			case CLK_34_368MHz:
-				SET_PORT_BITS(TLCLK_REG0, 0xfc, 3);
-				break;
-			case CLK_44_736MHz:
-				SET_PORT_BITS(TLCLK_REG0, 0xfc, 1);
-				break;
-			}
-		} else
-			SET_PORT_BITS(TLCLK_REG3, 0xf8, val);
+	if ((val == CLK_8kHz) || (val == CLK_16_384MHz)) {
+		SET_PORT_BITS(TLCLK_REG3, 0xf8, 0x5);
+		SET_PORT_BITS(TLCLK_REG1, 0xfb, ~val);
+	} else if (val >= CLK_8_592MHz) {
+		SET_PORT_BITS(TLCLK_REG3, 0xf8, 0x7);
+		switch (val) {
+		case CLK_8_592MHz:
+			SET_PORT_BITS(TLCLK_REG0, 0xfc, 2);
+			break;
+		case CLK_11_184MHz:
+			SET_PORT_BITS(TLCLK_REG0, 0xfc, 0);
+			break;
+		case CLK_34_368MHz:
+			SET_PORT_BITS(TLCLK_REG0, 0xfc, 3);
+			break;
+		case CLK_44_736MHz:
+			SET_PORT_BITS(TLCLK_REG0, 0xfc, 1);
+			break;
+		}
+	} else
+		SET_PORT_BITS(TLCLK_REG3, 0xf8, val);
 	spin_unlock_irqrestore(&event_lock, flags);
 
 	return strnlen(buf, count);
-- 
2.19.1

