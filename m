Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934349AbeB1RvO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 12:51:14 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46923 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932464AbeB1RvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 12:51:11 -0500
X-Google-Smtp-Source: AH8x2246MK5QZleEE8eOEK2cMMvsbGKqhJ6qB7oflegbd7VsSVNjFertWCzpy5/GZT4UvzRVtncGLw==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: linus.walleij@linaro.org, robh+dt@kernel.org, afaerber@suse.de
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 03/10] arm64: actions: Enable PINCTRL in platforms Kconfig
Date: Wed, 28 Feb 2018 23:18:59 +0530
Message-Id: <20180228174906.22721-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180228174906.22721-1-manivannan.sadhasivam@linaro.org>
References: <20180228174906.22721-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select PINCTRL for Actions Semi SoCs

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
