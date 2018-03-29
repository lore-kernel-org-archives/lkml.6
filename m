Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752016AbeC2Q7x (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 12:59:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44577 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751193AbeC2Q7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 12:59:51 -0400
From: Colin King <colin.king@canonical.com>
To: Kalle Valo <kvalo@qca.qualcomm.com>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ath10k: fix spelling mistake: "tiggers" -> "triggers"
Date: Thu, 29 Mar 2018 17:59:49 +0100
Message-Id: <20180329165949.29155-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/wireless/ath/ath10k/wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index 9649bb752bbd..2f991f79a90f 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -7719,7 +7719,7 @@ ath10k_wmi_fw_pdev_tx_stats_fill(const struct ath10k_fw_stats_pdev *pdev,
 	len += scnprintf(buf + len, buf_len - len, "%30s %10d\n",
 			 "HW rate", pdev->data_rc);
 	len += scnprintf(buf + len, buf_len - len, "%30s %10d\n",
-			 "Sched self tiggers", pdev->self_triggers);
+			 "Sched self triggers", pdev->self_triggers);
 	len += scnprintf(buf + len, buf_len - len, "%30s %10d\n",
 			 "Dropped due to SW retries",
 			 pdev->sw_retry_failure);
-- 
2.15.1
