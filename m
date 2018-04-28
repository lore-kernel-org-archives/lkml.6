Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759774AbeD1JnY (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 05:43:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41012 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759622AbeD1JnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 05:43:22 -0400
From: Colin King <colin.king@canonical.com>
To: Ariel Elior <Ariel.Elior@cavium.com>, everest-linux-l2@cavium.com,
        netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] qed: fix spelling mistake: "checksumed" -> "checksummed"
Date: Sat, 28 Apr 2018 10:43:20 +0100
Message-Id: <20180428094320.7016-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in DP_INFO message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/qlogic/qed/qed_ll2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_ll2.c b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
index 74fc626b1ec1..38502815d681 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_ll2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
@@ -2370,7 +2370,7 @@ static int qed_ll2_start_xmit(struct qed_dev *cdev, struct sk_buff *skb)
 	u8 flags = 0;
 
 	if (unlikely(skb->ip_summed != CHECKSUM_NONE)) {
-		DP_INFO(cdev, "Cannot transmit a checksumed packet\n");
+		DP_INFO(cdev, "Cannot transmit a checksummed packet\n");
 		return -EINVAL;
 	}
 
-- 
2.17.0
