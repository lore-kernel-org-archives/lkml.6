Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F89C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 03:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F1921927
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 03:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732523AbeLVDG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 22:06:58 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:49630 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbeLVDG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 22:06:58 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id DF6A4275C8;
        Fri, 21 Dec 2018 22:06:53 -0500 (EST)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <d31f51f45a7e36d59aca55575edc69933cd4481c.1545445081.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH] m68k/mac: Clean up unused timer definitions
Date:   Sat, 22 Dec 2018 13:18:01 +1100
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
2.19.2
