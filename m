Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752775AbeAaAPt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 19:15:49 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:45280 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751629AbeAaAPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 19:15:48 -0500
X-Google-Smtp-Source: AH8x2279pj4ySzbmM9johKj4D6oMggdEkLMbwyMgDqSDHceBzflbGKj29PhrpiQM8a0+A1DwZ7rS1A==
From: Erik Mansson <erik@mansson.xyz>
To: lgirdwood@gmail.com
Cc: linux-kernel@vger.kernel.org, Erik Mansson <erik@mansson.xyz>
Subject: [PATCH] drivers: regulator: fan53555: fixed a coding style issue
Date: Wed, 31 Jan 2018 01:14:25 +0100
Message-Id: <20180131001425.22510-1-erik@mansson.xyz>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a couple of badly formatted comments.

Signed-off-by: Erik Mansson <erik@mansson.xyz>
---
 drivers/regulator/fan53555.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/fan53555.c b/drivers/regulator/fan53555.c
index a3bc8037153e..78f98e679fbf 100644
--- a/drivers/regulator/fan53555.c
+++ b/drivers/regulator/fan53555.c
@@ -114,8 +114,10 @@ static int fan53555_set_suspend_voltage(struct regulator_dev *rdev, int uV)
 					VSEL_NSEL_MASK, ret);
 	if (ret < 0)
 		return ret;
-	/* Cache the sleep voltage setting.
-	 * Might not be the real voltage which is rounded */
+	/*
+	 * Cache the sleep voltage setting.
+	 * Might not be the real voltage which is rounded
+	 */
 	di->sleep_vol_cache = uV;
 
 	return 0;
@@ -277,11 +279,12 @@ static int fan53555_voltages_setup_silergy(struct fan53555_device_info *di)
 	return 0;
 }
 
-/* For 00,01,03,05 options:
+/*
+ * For 00,01,03,05 options:
  * VOUT = 0.60V + NSELx * 10mV, from 0.60 to 1.23V.
  * For 04 option:
  * VOUT = 0.603V + NSELx * 12.826mV, from 0.603 to 1.411V.
- * */
+ */
 static int fan53555_device_setup(struct fan53555_device_info *di,
 				struct fan53555_platform_data *pdata)
 {
-- 
2.14.1
