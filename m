Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754071AbeDKQmB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 12:42:01 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46535 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754054AbeDKQl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 12:41:57 -0400
X-Google-Smtp-Source: AIpwx4/YO3deBEzL+H+ZZ/b3Qez4/88McuL0QTcHKPVA7JMHJr291owKPdtzdjWNVkAaQrZuU1ydug==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: afaerber@suse.de, robh+dt@kernel.org
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        manivannanece23@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 4/4] soc: actions: Fix help text in Kconfig for OWL_PM_DOMAINS
Date: Wed, 11 Apr 2018 22:10:36 +0530
Message-Id: <20180411164036.8046-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180411164036.8046-1-manivannan.sadhasivam@linaro.org>
References: <20180411164036.8046-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OWL_PM_DOMAINS is being used by 3 SoCs of OWL family. This fixes
the wording to use family name OWL instead of SoC name S500.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/soc/actions/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/actions/Kconfig b/drivers/soc/actions/Kconfig
index 9d68b5a771c3..26c3155d3738 100644
--- a/drivers/soc/actions/Kconfig
+++ b/drivers/soc/actions/Kconfig
@@ -10,7 +10,7 @@ config OWL_PM_DOMAINS
 	select PM_GENERIC_DOMAINS
 	help
 	  Say 'y' here to enable support for Smart Power System (SPS)
-	  power-gating on Actions Semiconductor S500 SoC.
+	  power-gating on Actions Semiconductor OWL SoCs.
 	  If unsure, say 'n'.
 
 endif
-- 
2.14.1
