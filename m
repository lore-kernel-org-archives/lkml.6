Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751433AbeCIFPB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 00:15:01 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:41249 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751298AbeCIFO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 00:14:58 -0500
X-Google-Smtp-Source: AG47ELvaivO19U+fJVm5QxwETW/oRP8/CI2rbJQ4jBJDjYcM0RU0sGKVrXS5+aBIk6GOxtCaUfIWBg==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: linus.walleij@linaro.org, robh+dt@kernel.org, afaerber@suse.de
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com, manivannanece23@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 2/9] arm64: actions: Enable PINCTRL in platforms Kconfig
Date: Fri,  9 Mar 2018 10:43:38 +0530
Message-Id: <20180309051345.1011-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180309051345.1011-1-manivannan.sadhasivam@linaro.org>
References: <20180309051345.1011-1-manivannan.sadhasivam@linaro.org>
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
