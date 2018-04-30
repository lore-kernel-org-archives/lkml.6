Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754764AbeD3QEx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 12:04:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44368 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753334AbeD3QEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 12:04:52 -0400
From: Colin King <colin.king@canonical.com>
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: ab8500_charger: fix spelling mistake: "faile" -> "failed"
Date: Mon, 30 Apr 2018 17:04:50 +0100
Message-Id: <20180430160450.29264-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

trivial fix to spelling mistake in dev_error message.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/power/supply/ab8500_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index ba0e97284ae5..98b335042ba6 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -3066,7 +3066,7 @@ static int ab8500_charger_init_hw_registers(struct ab8500_charger *di)
 		AB8500_SYS_CTRL2_BLOCK,
 		AB8500_MAIN_WDOG_CTRL_REG, MAIN_WDOG_ENA);
 	if (ret) {
-		dev_err(di->dev, "faile to enable main watchdog\n");
+		dev_err(di->dev, "failed to enable main watchdog\n");
 		goto out;
 	}
 
-- 
2.17.0
