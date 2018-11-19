Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2067C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 01:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E7B2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 01:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E7B2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbeKSLoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 06:44:16 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:49122 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbeKSLoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 06:44:16 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 92AFB29DF8; Sun, 18 Nov 2018 20:22:17 -0500 (EST)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <fff9ef81e86dc588335bdb0a623a851d324315e9.1542589838.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1542589838.git.fthain@telegraphics.com.au>
References: <cover.1542589838.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [RFC PATCH v2 03/14] m68k: mac: Clean up unused timer definitions
Date:   Mon, 19 Nov 2018 12:10:38 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/include/asm/macints.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/m68k/include/asm/macints.h b/arch/m68k/include/asm/macints.h
index cddb2d3ea49b..4da172bd048c 100644
--- a/arch/m68k/include/asm/macints.h
+++ b/arch/m68k/include/asm/macints.h
@@ -121,7 +121,4 @@
 #define SLOT2IRQ(x)	  (x + 47)
 #define IRQ2SLOT(x)	  (x - 47)
 
-#define INT_CLK   24576	    /* CLK while int_clk =2.456MHz and divide = 100 */
-#define INT_TICKS 246	    /* to make sched_time = 99.902... HZ */
-
 #endif /* asm/macints.h */
-- 
2.18.1

