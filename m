Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751808AbeBQUqS (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 15:46:18 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46696 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751769AbeBQUqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 15:46:14 -0500
X-Google-Smtp-Source: AH8x227puf/HfSb7eHPmtg/RvH0Gq8jl2hYSwlpjfLS4eXmK6vX7dzIg2qcHRoa737GXL3FDkAasNA==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: linus.walleij@linaro.org, robh+dt@kernel.org, afaerber@suse.de
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 10/10] MAINTAINERS: Add Actions Semi S900 pinctrl and gpio entries
Date: Sun, 18 Feb 2018 02:14:33 +0530
Message-Id: <20180217204433.3095-11-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180217204433.3095-1-manivannan.sadhasivam@linaro.org>
References: <20180217204433.3095-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add S900 pinctrl and gpio entries under ARCH_ACTIONS

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 96b8b6531196..b718be5af680 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1126,11 +1126,15 @@ F:	arch/arm/boot/dts/owl-*
 F:	arch/arm64/boot/dts/actions/
 F:	drivers/clocksource/owl-*
 F:	drivers/soc/actions/
+F:	drivers/pinctrl/actions/*
+F:	drivers/gpio/gpio-owl.c
 F:	include/dt-bindings/power/owl-*
 F:	include/linux/soc/actions/
 F:	Documentation/devicetree/bindings/arm/actions.txt
 F:	Documentation/devicetree/bindings/power/actions,owl-sps.txt
 F:	Documentation/devicetree/bindings/timer/actions,owl-timer.txt
+F:	Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
+F:	Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt
 
 ARM/ADS SPHERE MACHINE SUPPORT
 M:	Lennert Buytenhek <kernel@wantstofly.org>
-- 
2.14.1
