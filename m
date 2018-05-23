Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934591AbeEWT6b (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 15:58:31 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34542 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934090AbeEWT60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 15:58:26 -0400
X-Google-Smtp-Source: AB8JxZpP6eVyj2ukeSg8d5LCVw438gFhlmQL5cTGYp9x6PqPAQvAPHsOV95N3vY94SIIR1lRxZlCow==
From: Mathieu Malaterre <malat@debian.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: trivial@kernel.org, Mathieu Malaterre <malat@debian.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix a typo in RTC documentation for RTC_DRV_JZ4740
Date: Wed, 23 May 2018 21:58:14 +0200
Message-Id: <20180523195814.568-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo introduced for RTC_DRV_JZ4740 in commit 586655d278ba ("rtc:
jz4740: make the driver buildable as a module again").

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/rtc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 59e6dede3db3..a2ba5db36145 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1613,7 +1613,7 @@ config RTC_DRV_JZ4740
 	  If you say yes here you get support for the Ingenic JZ47xx SoCs RTC
 	  controllers.
 
-	  This driver can also be buillt as a module. If so, the module
+	  This driver can also be built as a module. If so, the module
 	  will be called rtc-jz4740.
 
 config RTC_DRV_LPC24XX
-- 
2.11.0
