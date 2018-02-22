Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751283AbeBVFDf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 00:03:35 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43410 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbeBVFDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 00:03:34 -0500
X-Google-Smtp-Source: AH8x224o1DpR7PAlsUV0QFk2tof0vJPGypfld9pMiujsGy/XTuD+G8a5JqVmBV6nSBAa5Kdj0N+WGA==
From: Joel Stanley <joel@jms.id.au>
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Update ASPEED entry with details
Date: Thu, 22 Feb 2018 15:33:24 +1030
Message-Id: <20180222050324.21531-1-joel@jms.id.au>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am interested in all ASPEED drivers, and the previous match wasn't
grabbing files in nested directories. Use N instead.

Add the arm kernel mailing list so that patches get reviewed there, and
the linux-aspeed list which exists only so I can use patchwork to track
patches.

Add Andrew as a reviewer, because he is involved in reviewing ASPEED
stuff.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 MAINTAINERS | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a7f76eadae9..1ebf49797175 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1226,10 +1226,15 @@ F:	Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
 
 ARM/ASPEED MACHINE SUPPORT
 M:	Joel Stanley <joel@jms.id.au>
-S:	Maintained
+R:	Andrew Jeffery <andrew@aj.id.au>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
+Q:	https://patchwork.ozlabs.org/project/linux-aspeed/list/
+S:	Supported
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
 F:	arch/arm/mach-aspeed/
 F:	arch/arm/boot/dts/aspeed-*
-F:	drivers/*/*aspeed*
+N:	aspeed
 
 ARM/ATMEL AT91 Clock Support
 M:	Boris Brezillon <boris.brezillon@free-electrons.com>
-- 
2.15.1
