Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3862CC04EBC
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 01:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084832080F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 01:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 084832080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbeKSLW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 06:22:59 -0500
Received: from mx.socionext.com ([202.248.49.38]:40749 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728200AbeKSLW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 06:22:59 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 19 Nov 2018 10:01:03 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 8C25360062;
        Mon, 19 Nov 2018 10:01:03 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Mon, 19 Nov 2018 10:01:03 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id EBE1940387;
        Mon, 19 Nov 2018 10:01:02 +0900 (JST)
Received: from M20VSDK.e01.socionext.com (unknown [10.213.118.34])
        by yuzu.css.socionext.com (Postfix) with ESMTP id CB13C120455;
        Mon, 19 Nov 2018 10:01:02 +0900 (JST)
From:   Sugaya Taichi <sugaya.taichi@socionext.com>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: [PATCH 14/14] MAINTAINERS: Add entry to MAINTAINERS for Milbeaut
Date:   Mon, 19 Nov 2018 10:02:16 +0900
Message-Id: <1542589336-13925-5-git-send-email-sugaya.taichi@socionext.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1542589336-13925-1-git-send-email-sugaya.taichi@socionext.com>
References: <1542589336-13925-1-git-send-email-sugaya.taichi@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entry to MAINTAINERS for Milbeaut that supported minimal drivers.

Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0abecc5..31dd29f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1782,6 +1782,15 @@ F:	drivers/watchdog/sama5d4_wdt.c
 X:	drivers/input/touchscreen/atmel_mxt_ts.c
 X:	drivers/net/wireless/atmel/
 
+ARM/MILBEAUT ARCHITECTURE
+M:	Taichi Sugaya <sugaya.taichi@socionext.com>
+M:	Takao Orito <orito.takao@socionext.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm/boot/dts/milbeaut*
+F:	arch/arm/mach-milbeaut/
+N:	milbeaut
+
 ARM/MIOA701 MACHINE SUPPORT
 M:	Robert Jarzmik <robert.jarzmik@free.fr>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
1.9.1

