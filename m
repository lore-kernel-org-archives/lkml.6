Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752199AbeBHCoh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 21:44:37 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:40105 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751706AbeBHCoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 21:44:34 -0500
X-Google-Smtp-Source: AH8x225ZAdMt0xk/bZfN2ZKhTsh5gCMOGGtWt0W/NuRgsQ8wQmkcDsaZi+BF5TZou8gun/s3Y4VjLA==
Date: Thu, 8 Feb 2018 03:44:14 +0100
From: Ulf Magnusson <ulfalizer@gmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org,
        clabbe.montjoie@gmail.com, viresh.kumar@linaro.org,
        linux-pwm@vger.kernel.org, thierry.reding@gmail.com,
        b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch,
        christophe.leroy@c-s.fr, seanpaul@chromium.org,
        linux-spi@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: [PATCH v2] spi: kconfig: Remove AVR32 dep. from SPI_ATMEL
Message-ID: <20180208024414.jjcxvd2q4o5rifgh@huvuddator>
References: <20180206120825.GF5681@sirena.org.uk>
 <20180206225519.20248-1-ulfalizer@gmail.com>
 <7f2bebe1-2931-7ec9-ef9f-0d3e6dda6c0b@gmail.com>
 <a8d2076b-6863-6ff1-5442-0587ad973766@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a8d2076b-6863-6ff1-5442-0587ad973766@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AVR32 symbol was removed in commit 26202873bb51 ("avr32: remove
support for AVR32 architecture").
---
Changes in v2:
Remove the AVR32 reference from the help text too.

 drivers/spi/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 603783976b81..6fb0347a24f2 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -72,10 +72,10 @@ config SPI_ARMADA_3700
 config SPI_ATMEL
 	tristate "Atmel SPI Controller"
 	depends on HAS_DMA
-	depends on (ARCH_AT91 || AVR32 || COMPILE_TEST)
+	depends on (ARCH_AT91 || COMPILE_TEST)
 	help
 	  This selects a driver for the Atmel SPI Controller, present on
-	  many AT32 (AVR32) and AT91 (ARM) chips.
+	  many AT91 (ARM) chips.
 
 config SPI_AU1550
 	tristate "Au1550/Au1200/Au1300 SPI Controller"
-- 
2.14.1
