Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752401AbeERCc4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 22:32:56 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46540 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752356AbeERCcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 22:32:52 -0400
X-Google-Smtp-Source: AB8JxZpUUimgIHvDRsGfoNIwfvfn9Mym9p2jUlGr5kGjU/zZ0EJEI7s7prhj0MoX/Hl+JmVEmjnxEw==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: linus.walleij@linaro.org, robh+dt@kernel.org, afaerber@suse.de
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com, manivannanece23@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 5/5] MAINTAINERS: Add Actions Semi S900 pinctrl entries
Date: Fri, 18 May 2018 08:00:56 +0530
Message-Id: <20180518023056.7869-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180518023056.7869-1-manivannan.sadhasivam@linaro.org>
References: <20180518023056.7869-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add S900 pinctrl entries under ARCH_ACTIONS

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 640dabc4c311..9e1a17c9b4a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1125,10 +1125,12 @@ F:	arch/arm/mach-actions/
 F:	arch/arm/boot/dts/owl-*
 F:	arch/arm64/boot/dts/actions/
 F:	drivers/clocksource/owl-*
+F:	drivers/pinctrl/actions/*
 F:	drivers/soc/actions/
 F:	include/dt-bindings/power/owl-*
 F:	include/linux/soc/actions/
 F:	Documentation/devicetree/bindings/arm/actions.txt
+F:	Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
 F:	Documentation/devicetree/bindings/power/actions,owl-sps.txt
 F:	Documentation/devicetree/bindings/timer/actions,owl-timer.txt
 
-- 
2.14.1
