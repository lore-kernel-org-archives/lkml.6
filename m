Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BE7E7601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752730AbeFFPLb (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 11:11:31 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56824 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752448AbeFFPJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:09:12 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: [PATCH v3 05/12] rtc: cros-ec: Make license text and module license match.
Date: Wed,  6 Jun 2018 17:08:53 +0200
Message-Id: <20180606150900.8342-6-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180606150900.8342-1-enric.balletbo@collabora.com>
References: <20180606150900.8342-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The license text is specifying "GPLv2" but the MODULE_LICENSE is set to
GPL which means GNU Public License v2 or later. When MODULE_LICENSE and
boiler plate does not match, go for boiler plate license.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v3: None
Changes in v2: None

 drivers/rtc/rtc-cros-ec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-cros-ec.c b/drivers/rtc/rtc-cros-ec.c
index bf7ced095c94..f2b87f9159c1 100644
--- a/drivers/rtc/rtc-cros-ec.c
+++ b/drivers/rtc/rtc-cros-ec.c
@@ -409,5 +409,5 @@ module_platform_driver(cros_ec_rtc_driver);
 
 MODULE_DESCRIPTION("RTC driver for Chrome OS ECs");
 MODULE_AUTHOR("Stephen Barber <smbarber@chromium.org>");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.17.1
