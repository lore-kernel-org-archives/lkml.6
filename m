Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751808AbeEFLYW (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 07:24:22 -0400
Received: from sauhun.de ([88.99.104.3]:37628 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751776AbeEFLYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 07:24:19 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: trivial@kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] hwmon: fschmd: fix typo 'can by' to 'can be'
Date: Sun,  6 May 2018 13:23:48 +0200
Message-Id: <20180506112404.24872-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180506112404.24872-1-wsa+renesas@sang-engineering.com>
References: <20180506112404.24872-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/hwmon/fschmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/fschmd.c b/drivers/hwmon/fschmd.c
index 5e78229ade049f..22d3a84f13ef58 100644
--- a/drivers/hwmon/fschmd.c
+++ b/drivers/hwmon/fschmd.c
@@ -105,7 +105,7 @@ static const u8 FSCHMD_REG_VOLT[7][6] = {
 static const int FSCHMD_NO_VOLT_SENSORS[7] = { 3, 3, 3, 3, 3, 3, 6 };
 
 /*
- * minimum pwm at which the fan is driven (pwm can by increased depending on
+ * minimum pwm at which the fan is driven (pwm can be increased depending on
  * the temp. Notice that for the scy some fans share there minimum speed.
  * Also notice that with the scy the sensor order is different than with the
  * other chips, this order was in the 2.4 driver and kept for consistency.
-- 
2.11.0
