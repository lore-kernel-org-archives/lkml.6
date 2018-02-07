Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754248AbeBGNqR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 08:46:17 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51953 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754213AbeBGNqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 08:46:13 -0500
X-Google-Smtp-Source: AH8x224izhlnrgSNPwXhDDp2T9bNNSVLb7Jf810V7sHh8YeoNxe943a+YvyO2fdQGsfBr40CoorQWg==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 6/7] ARM: davinci: select generic power domains for DaVinci in DT mode
Date: Wed,  7 Feb 2018 14:45:52 +0100
Message-Id: <20180207134553.13510-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180207134553.13510-1-brgl@bgdev.pl>
References: <20180207134553.13510-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Automatically select the genpd framework in DT mode.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index da8a039d65f9..cb5dd239e375 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -60,6 +60,7 @@ config MACH_DA8XX_DT
 	depends on ARCH_DAVINCI_DA850
 	select PINCTRL
 	select TIMER_OF
+	select PM_GENERIC_DOMAINS if PM
 	help
 	  Say y here to include support for TI DaVinci DA850 based using
 	  Flattened Device Tree. More information at Documentation/devicetree
-- 
2.16.1
