Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057B3C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32A620852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="OdMR57aU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B32A620852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389086AbeGYA3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 20:29:11 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:39898 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389035AbeGYA3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 20:29:10 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Paul Cercueil <paul@crapouillou.net>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org,
        linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v5 07/21] MAINTAINERS: Add myself as maintainer for Ingenic TCU drivers
Date:   Wed, 25 Jul 2018 01:19:44 +0200
Message-Id: <20180724231958.20659-8-paul@crapouillou.net>
In-Reply-To: <20180724231958.20659-1-paul@crapouillou.net>
References: <20180724231958.20659-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1532474420; bh=DtPYdTDkBrcKtIO8UHeqVD4/3vCKgyfZGF0Y7iVEjug=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=OdMR57aUUEggOf02EmTf3fQdS42ceoFemtDYElm1v5YZL7mV9v+3+8B/d2umEP57onrqoYD+2tQZJ0q5P7YLbRbGZwybENCh1fiDtTgV5SVG/6U2kok8tOeso85heC2QEVMYu20AGZpsO+oyOQ69wAGsQ+0aorzZiWu1CImlMiw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as maintainer for the ingenic-timer and ingenic-ost drivers.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

 v2: No change

 v3: No change

 v4: No change

 v5: Update with new files

diff --git a/MAINTAINERS b/MAINTAINERS
index 0fe4228f78cb..bd62185623e5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7073,6 +7073,15 @@ L:	linux-mtd@lists.infradead.org
 S:	Maintained
 F:	drivers/mtd/nand/raw/jz4780_*
 
+INGENIC TCU driver
+M:	Paul Cercueil <paul@crapouillou.net>
+S:	Maintained
+F:	drivers/clocksource/ingenic-ost.c
+F:	drivers/clocksource/ingenic-timer.c
+F:	drivers/clocksource/ingenic-timer.h
+F:	include/linux/mfd/ingenic-tcu.h
+F:	include/dt-bindings/clock/ingenic,tcu.h
+
 INOTIFY
 M:	Jan Kara <jack@suse.cz>
 R:	Amir Goldstein <amir73il@gmail.com>
-- 
2.11.0

