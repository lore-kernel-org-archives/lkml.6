Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031725AbeEZN4M (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 09:56:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56194 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754669AbeEZN4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 09:56:08 -0400
From: Colin King <colin.king@canonical.com>
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: max1721x: fix spelling mistake "RSenese" -> "RSense"
Date: Sat, 26 May 2018 14:56:06 +0100
Message-Id: <20180526135606.1153-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in dev_warn message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/power/supply/max1721x_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/max1721x_battery.c b/drivers/power/supply/max1721x_battery.c
index 9ee601a03d9b..9ca895b0dabb 100644
--- a/drivers/power/supply/max1721x_battery.c
+++ b/drivers/power/supply/max1721x_battery.c
@@ -372,7 +372,7 @@ static int devm_w1_max1721x_add_device(struct w1_slave *sl)
 	}
 
 	if (!info->rsense) {
-		dev_warn(info->w1_dev, "RSenese not calibrated, set 10 mOhms!\n");
+		dev_warn(info->w1_dev, "RSense not calibrated, set 10 mOhms!\n");
 		info->rsense = 1000; /* in regs in 10^-5 */
 	}
 	dev_info(info->w1_dev, "RSense: %d mOhms.\n", info->rsense / 100);
-- 
2.17.0
