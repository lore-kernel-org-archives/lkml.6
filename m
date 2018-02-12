Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754108AbeBLU7H (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 15:59:07 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44767 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754019AbeBLU6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 15:58:44 -0500
X-Google-Smtp-Source: AH8x227tsRQzVz/V+4z2A/8EbibJ+Ajt00EOR6hLPFbIbEUwoWigb+6gT58+UhR68LcbC4U2bSDikg==
From: Brendan Higgins <brendanhiggins@google.com>
To: linux@armlinux.org.uk, avifishman70@gmail.com, tmaimon77@gmail.com,
        venture@google.com, yuenn@google.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        openbmc@lists.ozlabs.org, Brendan Higgins <brendanhiggins@google.com>
Subject: [PATCH v1 2/2] MAINTAINERS: Add low-level debug files to Nuvoton NPCM section
Date: Mon, 12 Feb 2018 12:58:33 -0800
Message-Id: <20180212205833.151019-3-brendanhiggins@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
In-Reply-To: <20180212205833.151019-1-brendanhiggins@google.com>
References: <20180212205833.151019-1-brendanhiggins@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds low-level debug files for NPCM7XX architecture to the Nuvoton NPCM
architecture section.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fa95aba0f7f..4eaa66bc0562 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1608,6 +1608,7 @@ L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
 S:	Supported
 F:	arch/arm/mach-npcm/
 F:	arch/arm/boot/dts/nuvoton-npcm*
+F:	arch/arm/include/debug/npcm7xx.S
 F:	include/dt-bindings/clock/nuvoton,npcm7xx-clks.h
 F:	drivers/*/*npcm*
 F:	Documentation/*/*npcm*
-- 
2.16.0.rc1.238.g530d649a79-goog
