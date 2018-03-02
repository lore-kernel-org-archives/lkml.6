Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933747AbeCBWt0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 17:49:26 -0500
Received: from mail.bootlin.com ([62.4.15.54]:52400 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933562AbeCBWtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 17:49:20 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc: Allan Nielsen <Allan.Nielsen@microsemi.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v4 6/6] MAINTAINERS: Add entry for Microsemi MIPS SoCs
Date: Fri,  2 Mar 2018 23:48:11 +0100
Message-Id: <20180302224811.26840-7-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302224811.26840-1-alexandre.belloni@bootlin.com>
References: <20180302224811.26840-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as a maintainer for the Microsemi MIPS SoCs.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3bdc260e36b7..14ce8b290fea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9156,6 +9156,15 @@ S:	Maintained
 F:	drivers/usb/misc/usb251xb.c
 F:	Documentation/devicetree/bindings/usb/usb251xb.txt
 
+MICROSEMI MIPS SOCS
+M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
+L:	linux-mips@linux-mips.org
+S:	Maintained
+F:	arch/mips/generic/board-ocelot.c
+F:	arch/mips/configs/generic/board-ocelot.config
+F:	arch/mips/boot/dts/mscc/
+F:	Documentation/devicetree/bindings/mips/mscc.txt
+
 MICROSEMI SMART ARRAY SMARTPQI DRIVER (smartpqi)
 M:	Don Brace <don.brace@microsemi.com>
 L:	esc.storagedev@microsemi.com
-- 
2.16.2
