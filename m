Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753744AbeBFWxe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 17:53:34 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:44707 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753302AbeBFWxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 17:53:32 -0500
X-Google-Smtp-Source: AH8x2260fdLyzHRBx8ujwCl4Sztwp3d5+hsKiYYceL7jixnEipyID4zr5maye/B0hMbAiwvAYO7XlA==
From: Ulf Magnusson <ulfalizer@gmail.com>
To: broonie@kernel.org, linux-kernel@vger.kernel.org
Cc: clabbe.montjoie@gmail.com, viresh.kumar@linaro.org,
        matthias.bgg@gmail.com, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com, b.zolnierkie@samsung.com,
        daniel.vetter@ffwll.ch, christophe.leroy@c-s.fr, seanpaul@chromium.org,
        linux-spi@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, Ulf Magnusson <ulfalizer@gmail.com>
Subject: [PATCH] video: console: kconfig: Remove AVR32 dep. from VGA_CONSOLE
Date: Tue,  6 Feb 2018 23:52:46 +0100
Message-Id: <20180206225254.20036-1-ulfalizer@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180206120825.GF5681@sirena.org.uk>
References: <20180206120825.GF5681@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AVR32 symbol was removed in commit 26202873bb51 ("avr32: remove
support for AVR32 architecture").

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
---
 drivers/video/console/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index 7f1f1fbcef9e..be63759b6027 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -7,7 +7,7 @@ menu "Console display driver support"
 config VGA_CONSOLE
 	bool "VGA text console" if EXPERT || !X86
 	depends on !4xx && !PPC_8xx && !SPARC && !M68K && !PARISC && !FRV && \
-		!SUPERH && !BLACKFIN && !AVR32 && !MN10300 && !CRIS && \
+		!SUPERH && !BLACKFIN && !MN10300 && !CRIS && \
 		(!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER) && \
 		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC
 	default y
-- 
2.14.1
