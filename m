Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751575AbeBEX6w (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 18:58:52 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33308 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752087AbeBEX6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 18:58:11 -0500
X-Google-Smtp-Source: AH8x2260fVUL0COK9mCw2IIIIu6IGFj5JDdFNxif1hbXaC9IvycFYW0guIyLVNJ1QbNerhjhdzStuA==
From: Brendan Higgins <brendanhiggins@google.com>
To: robh+dt@kernel.org, linux@armlinux.org.uk, mark.rutland@arm.com,
        tmaimon77@gmail.com, avifishman70@gmail.com, f.fainelli@gmail.com,
        julien.thierry@arm.com, pombredanne@nexb.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org,
        Brendan Higgins <brendanhiggins@google.com>
Subject: [PATCH v9 3/3] MAINTAINERS: Add entry for the Nuvoton NPCM architecture
Date: Mon,  5 Feb 2018 15:57:57 -0800
Message-Id: <20180205235757.246758-4-brendanhiggins@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
In-Reply-To: <20180205235757.246758-1-brendanhiggins@google.com>
References: <20180205235757.246758-1-brendanhiggins@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainers and reviewers for the Nuvoton NPCM architecture.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Tomer Maimon <tmaimon77@gmail.com>
Reviewed-by: Avi Fishman <avifishman70@gmail.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 44cb004c765d..2fa95aba0f7f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1598,6 +1598,20 @@ F:	drivers/pinctrl/nomadik/
 F:	drivers/i2c/busses/i2c-nomadik.c
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
 
+ARM/NUVOTON NPCM ARCHITECTURE
+M:	Avi Fishman <avifishman70@gmail.com>
+M:	Tomer Maimon <tmaimon77@gmail.com>
+R:	Patrick Venture <venture@google.com>
+R:	Nancy Yuen <yuenn@google.com>
+R:	Brendan Higgins <brendanhiggins@google.com>
+L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
+S:	Supported
+F:	arch/arm/mach-npcm/
+F:	arch/arm/boot/dts/nuvoton-npcm*
+F:	include/dt-bindings/clock/nuvoton,npcm7xx-clks.h
+F:	drivers/*/*npcm*
+F:	Documentation/*/*npcm*
+
 ARM/NUVOTON W90X900 ARM ARCHITECTURE
 M:	Wan ZongShun <mcuos.com@gmail.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.16.0.rc1.238.g530d649a79-goog
