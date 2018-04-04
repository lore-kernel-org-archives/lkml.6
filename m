Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751935AbeDDLNZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 07:13:25 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:59421 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751356AbeDDLLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 07:11:54 -0400
From: Tomer Maimon <tmaimon77@gmail.com>
To: arnd@arndb.de, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, avifishman70@gmail.com,
        brendanhiggins@google.com, venture@google.com, joel@jms.id.au
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 5/6] arm: dts: modify Makefile NPCM750 configuration name
Date: Wed,  4 Apr 2018 14:11:01 +0300
Message-Id: <1522840262-21635-6-git-send-email-tmaimon77@gmail.com>
X-Mailer: git-send-email 1.8.3.4
In-Reply-To: <1522840262-21635-1-git-send-email-tmaimon77@gmail.com>
References: <1522840262-21635-1-git-send-email-tmaimon77@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 arch/arm/boot/dts/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 8164c1294226..7e2424957809 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -307,7 +307,7 @@ dtb-$(CONFIG_ARCH_LPC18XX) += \
 dtb-$(CONFIG_ARCH_LPC32XX) += \
 	lpc3250-ea3250.dtb \
 	lpc3250-phy3250.dtb
-dtb-$(CONFIG_ARCH_NPCM750) += \
+dtb-$(CONFIG_ARCH_NPCM7XX) += \
 	nuvoton-npcm750-evb.dtb
 dtb-$(CONFIG_MACH_MESON6) += \
 	meson6-atv1200.dtb
-- 
2.14.1
