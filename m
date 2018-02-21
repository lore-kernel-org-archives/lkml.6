Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751745AbeBUXnJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 18:43:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:33212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750752AbeBUXlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 18:41:10 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EB8E21785
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
From: James Hogan <jhogan@kernel.org>
To: linux-metag@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, James Hogan <jhogan@kernel.org>
Subject: [PATCH 08/13] MAINTAINERS/CREDITS: Drop METAG ARCHITECTURE
Date: Wed, 21 Feb 2018 23:38:20 +0000
Message-Id: <20180221233825.10024-9-jhogan@kernel.org>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180221233825.10024-1-jhogan@kernel.org>
References: <20180221233825.10024-1-jhogan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core Meta architecture support has now been removed, so drop the
MAINTAINERS entry and add an entry to CREDITS.

Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: linux-metag@vger.kernel.org
---
 CREDITS     |  5 +++++
 MAINTAINERS | 14 --------------
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/CREDITS b/CREDITS
index a3ec0c744172..989cda91c427 100644
--- a/CREDITS
+++ b/CREDITS
@@ -1564,6 +1564,11 @@ W: http://www.carumba.com/
 D: bug toaster (A1 sauce makes all the difference)
 D: Random linux hacker
 
+N: James Hogan
+E: jhogan@kernel.org
+D: Metag architecture maintainer
+D: TZ1090 SoC maintainer
+
 N: Tim Hockin
 E: thockin@hockin.org
 W: http://www.hockin.org/~thockin
diff --git a/MAINTAINERS b/MAINTAINERS
index 9a7f76eadae9..d5ddf19e76bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9081,20 +9081,6 @@ F:	drivers/media/platform/meson/ao-cec.c
 F:	Documentation/devicetree/bindings/media/meson-ao-cec.txt
 T:	git git://linuxtv.org/media_tree.git
 
-METAG ARCHITECTURE
-M:	James Hogan <jhogan@kernel.org>
-L:	linux-metag@vger.kernel.org
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/metag.git
-S:	Odd Fixes
-F:	arch/metag/
-F:	Documentation/metag/
-F:	Documentation/devicetree/bindings/metag/
-F:	Documentation/devicetree/bindings/interrupt-controller/img,*
-F:	drivers/clocksource/metag_generic.c
-F:	drivers/irqchip/irq-metag.c
-F:	drivers/irqchip/irq-metag-ext.c
-F:	drivers/tty/metag_da.c
-
 MICROBLAZE ARCHITECTURE
 M:	Michal Simek <monstr@monstr.eu>
 W:	http://www.monstr.eu/fdt/
-- 
2.13.6
