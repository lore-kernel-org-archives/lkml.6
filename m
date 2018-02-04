Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752572AbeBDUjg (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 15:39:36 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:34540 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751724AbeBDUj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 15:39:27 -0500
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [RFC PATCH 1/3] pcmcia: remove mailing list, update MAINTAINERS
Date: Sun,  4 Feb 2018 21:12:04 +0100
Message-Id: <20180204201206.2300-2-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180204201206.2300-1-linux@dominikbrodowski.net>
References: <20180204201206.2300-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In recent years, the linux-pcmcia mailing list gained a pretty bad
signal-to-noise ratio. It does not seem worth the hassle to keep it
any longer. Thanks to David for hosting the list for the last couple
of years!

Acked-by: David Woodhouse <dwmw2@infradead.org>
CC: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 MAINTAINERS | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e3581413420c..3dc821ddfc6b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10641,11 +10641,9 @@ S:	Maintained
 F:	drivers/pci/dwc/*spear*
 
 PCMCIA SUBSYSTEM
-P:	Linux PCMCIA Team
-L:	linux-pcmcia@lists.infradead.org
-W:	http://lists.infradead.org/mailman/listinfo/linux-pcmcia
+M:	Dominik Brodowski <linux@dominikbrodowski.net>
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/brodo/pcmcia.git
-S:	Maintained
+S:	Odd Fixes
 F:	Documentation/pcmcia/
 F:	tools/pcmcia/
 F:	drivers/pcmcia/
-- 
2.16.1
