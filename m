Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753939AbeCQXaO (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 19:30:14 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:38048 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753844AbeCQXaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 19:30:03 -0400
From: Paul Cercueil <paul@crapouillou.net>
To: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>
Cc: James Hogan <jhogan@kernel.org>,
        Maarten ter Huurne <maarten@treewalker.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v4 8/8] MAINTAINERS: Add myself as maintainer for Ingenic TCU drivers
Date: Sun, 18 Mar 2018 00:29:01 +0100
Message-Id: <20180317232901.14129-9-paul@crapouillou.net>
In-Reply-To: <20180317232901.14129-1-paul@crapouillou.net>
References: <20180110224838.16711-2-paul@crapouillou.net>
 <20180317232901.14129-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as maintainer for the ingenic-tcu-intc interrupt controller
driver, the ingenic-tcu-clocks clock driver, and the ingenic-tcu
clocksource driver.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

 v2: No change
 v3: No change
 v4: No change

diff --git a/MAINTAINERS b/MAINTAINERS
index 4623caf8d72d..46d3955b92aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6959,6 +6959,15 @@ L:	linux-mtd@lists.infradead.org
 S:	Maintained
 F:	drivers/mtd/nand/jz4780_*
 
+INGENIC JZ47xx TCU drivers
+M:	Paul Cercueil <paul@crapouillou.net>
+S:	Maintained
+F:	drivers/clk/ingenic/tcu.c
+F:	drivers/irqchip/irq-ingenic-tcu.c
+F:	drivers/clocksource/timer-ingenic.c
+F:	include/linux/mfd/syscon/ingenic-tcu.h
+F:	include/dt-bindings/clock/ingenic,tcu.h
+
 INOTIFY
 M:	Jan Kara <jack@suse.cz>
 R:	Amir Goldstein <amir73il@gmail.com>
-- 
2.11.0
