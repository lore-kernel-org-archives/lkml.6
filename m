Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753885AbeBFWzf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 17:55:35 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:42895 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753690AbeBFWzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 17:55:33 -0500
X-Google-Smtp-Source: AH8x227S04cHy6HrRFtGpMoCR56vgN9E2WW3/E2oWqPfjWO1mZ943hLlwNFI3PtJ5B0VTKbqBzKlVw==
From: Ulf Magnusson <ulfalizer@gmail.com>
To: broonie@kernel.org, linux-kernel@vger.kernel.org
Cc: clabbe.montjoie@gmail.com, viresh.kumar@linaro.org,
        matthias.bgg@gmail.com, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com, b.zolnierkie@samsung.com,
        daniel.vetter@ffwll.ch, christophe.leroy@c-s.fr, seanpaul@chromium.org,
        linux-spi@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, Ulf Magnusson <ulfalizer@gmail.com>
Subject: [PATCH] spi: kconfig: Remove AVR32 dep. from SPI_ATMEL
Date: Tue,  6 Feb 2018 23:55:15 +0100
Message-Id: <20180206225519.20248-1-ulfalizer@gmail.com>
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
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 603783976b81..c1e455d46c7f 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -72,7 +72,7 @@ config SPI_ARMADA_3700
 config SPI_ATMEL
 	tristate "Atmel SPI Controller"
 	depends on HAS_DMA
-	depends on (ARCH_AT91 || AVR32 || COMPILE_TEST)
+	depends on (ARCH_AT91 || COMPILE_TEST)
 	help
 	  This selects a driver for the Atmel SPI Controller, present on
 	  many AT32 (AVR32) and AT91 (ARM) chips.
-- 
2.14.1
