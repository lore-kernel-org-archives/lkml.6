Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753221AbeC1RyB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 13:54:01 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35072 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753198AbeC1Rx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 13:53:58 -0400
X-Google-Smtp-Source: AIpwx4/dA64+ajA70dX1yl+UNftRekdUGvuY14uszdoGEzBWFz5WHMd0aI3fOAYIdkBuRExP4Crz2w==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: linus.walleij@linaro.org, robh+dt@kernel.org, afaerber@suse.de
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com, manivannanece23@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 2/9] arm64: actions: Enable PINCTRL in platforms Kconfig
Date: Wed, 28 Mar 2018 23:16:56 +0530
Message-Id: <20180328174703.19778-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180328174703.19778-1-manivannan.sadhasivam@linaro.org>
References: <20180328174703.19778-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select PINCTRL for Actions Semi SoCs

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index fbedbd8f619a..bae1289bdc3f 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -3,6 +3,7 @@ menu "Platform selection"
 config ARCH_ACTIONS
 	bool "Actions Semi Platforms"
 	select OWL_TIMER
+	select PINCTRL
 	help
 	  This enables support for the Actions Semiconductor S900 SoC family.
 
-- 
2.14.1
