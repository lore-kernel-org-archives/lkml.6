Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751070AbeBILxr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 06:53:47 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33415 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750863AbeBILxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 06:53:45 -0500
From: Colin King <colin.king@canonical.com>
To: Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: GPD pocket fan: fix spelling mistake: "Mill-celcius" -> "millicelsius"
Date: Fri,  9 Feb 2018 11:53:40 +0000
Message-Id: <20180209115340.32347-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in MODULE_PARM_DESC text and remove
unnecessary hyphen

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/platform/x86/gpd-pocket-fan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/gpd-pocket-fan.c b/drivers/platform/x86/gpd-pocket-fan.c
index 2d645c505f81..3b923df15b9b 100644
--- a/drivers/platform/x86/gpd-pocket-fan.c
+++ b/drivers/platform/x86/gpd-pocket-fan.c
@@ -19,12 +19,12 @@
 static int temp_limits[3] = { 55000, 60000, 65000 };
 module_param_array(temp_limits, int, NULL, 0444);
 MODULE_PARM_DESC(temp_limits,
-		 "Milli-celcius values above which the fan speed increases");
+		 "Millicelsius values above which the fan speed increases");
 
 static int hysteresis = 3000;
 module_param(hysteresis, int, 0444);
 MODULE_PARM_DESC(hysteresis,
-		 "Hysteresis in milli-celcius before lowering the fan speed");
+		 "Hysteresis in millicelsius before lowering the fan speed");
 
 static int speed_on_ac = 2;
 module_param(speed_on_ac, int, 0444);
-- 
2.15.1
