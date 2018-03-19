Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755462AbeCSOdE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 10:33:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60942 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933087AbeCSOdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 10:33:01 -0400
From: Colin King <colin.king@canonical.com>
To: Ariel Elior <ariel.elior@cavium.com>, everest-linux-l2@cavium.com,
        netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bnx2x: fix spelling mistake: "registeration" -> "registration"
Date: Mon, 19 Mar 2018 14:32:59 +0000
Message-Id: <20180319143259.5796-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in BNX2X_ERR error message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 74fc9af4aadb..b8388e93520a 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -13913,7 +13913,7 @@ static void bnx2x_register_phc(struct bnx2x *bp)
 	bp->ptp_clock = ptp_clock_register(&bp->ptp_clock_info, &bp->pdev->dev);
 	if (IS_ERR(bp->ptp_clock)) {
 		bp->ptp_clock = NULL;
-		BNX2X_ERR("PTP clock registeration failed\n");
+		BNX2X_ERR("PTP clock registration failed\n");
 	}
 }
 
-- 
2.15.1
