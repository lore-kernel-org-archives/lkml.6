Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933240AbeBLWvy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:51:54 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:37597 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933076AbeBLWss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:48:48 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 42/45] rtc: tx4939: extend test coverage
Date: Mon, 12 Feb 2018 23:47:56 +0100
Message-Id: <20180212224759.15999-43-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
References: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rtc-tx4939 driver now compiles correctly on other architectures, add
COMPILE_TEST to improve code coverage.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 8ab5f0a5d323..f6d7e490e714 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1512,7 +1512,7 @@ config RTC_DRV_STARFIRE
 
 config RTC_DRV_TX4939
 	tristate "TX4939 SoC"
-	depends on SOC_TX4939
+	depends on SOC_TX4939 || COMPILE_TEST
 	help
 	  Driver for the internal RTC (Realtime Clock) module found on
 	  Toshiba TX4939 SoC.
-- 
2.16.1
