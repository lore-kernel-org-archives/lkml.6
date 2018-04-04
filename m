Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751973AbeDDRZ1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 13:25:27 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45706 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751713AbeDDRZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 13:25:24 -0400
X-Google-Smtp-Source: AIpwx484yOYiucyglMw4MYvSI6iMIBfqDJrgSARx4xM7VI1hmikG7FoIJ6NEuOT2dM6prd+2NlNINg==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: linus.walleij@linaro.org, robh+dt@kernel.org, afaerber@suse.de
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com, manivannanece23@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v7 9/9] MAINTAINERS: Add Actions Semi S900 pinctrl and gpio entries
Date: Wed,  4 Apr 2018 22:52:58 +0530
Message-Id: <20180404172258.7678-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180404172258.7678-1-manivannan.sadhasivam@linaro.org>
References: <20180404172258.7678-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add S900 pinctrl and gpio entries under ARCH_ACTIONS

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 640dabc4c311..d63793ee545e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1125,10 +1125,14 @@ F:	arch/arm/mach-actions/
 F:	arch/arm/boot/dts/owl-*
 F:	arch/arm64/boot/dts/actions/
 F:	drivers/clocksource/owl-*
+F:	drivers/gpio/gpio-owl.c
+F:	drivers/pinctrl/actions/*
 F:	drivers/soc/actions/
 F:	include/dt-bindings/power/owl-*
 F:	include/linux/soc/actions/
 F:	Documentation/devicetree/bindings/arm/actions.txt
+F:	Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt
+F:	Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
 F:	Documentation/devicetree/bindings/power/actions,owl-sps.txt
 F:	Documentation/devicetree/bindings/timer/actions,owl-timer.txt
 
-- 
2.14.1
