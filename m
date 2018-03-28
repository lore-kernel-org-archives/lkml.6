Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753850AbeC1Wsz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 18:48:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54759 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753429AbeC1Wsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 18:48:54 -0400
From: Colin King <colin.king@canonical.com>
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: ab8500_fg: fix spelling mistake: "Disharge" -> "Discharge"
Date: Wed, 28 Mar 2018 23:48:50 +0100
Message-Id: <20180328224850.27833-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in dev_dbg message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/power/supply/ab8500_fg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index c569f82a0071..993898d1712f 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -1408,7 +1408,7 @@ static void ab8500_fg_charge_state_to(struct ab8500_fg *di,
 static void ab8500_fg_discharge_state_to(struct ab8500_fg *di,
 	enum ab8500_fg_discharge_state new_state)
 {
-	dev_dbg(di->dev, "Disharge state from %d [%s] to %d [%s]\n",
+	dev_dbg(di->dev, "Discharge state from %d [%s] to %d [%s]\n",
 		di->discharge_state,
 		discharge_state[di->discharge_state],
 		new_state,
-- 
2.15.1
