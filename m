Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968754AbeE3JZM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 05:25:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59146 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964877AbeE3JZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 05:25:08 -0400
From: Colin King <colin.king@canonical.com>
To: QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ath9k: debug: fix spelling mistake "WATHDOG" -> "WATCHDOG"
Date: Wed, 30 May 2018 10:25:03 +0100
Message-Id: <20180530092503.10481-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in PR_IS message text.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/wireless/ath/ath9k/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/debug.c b/drivers/net/wireless/ath/ath9k/debug.c
index f685843a2ff3..0a6eb8a8c1ed 100644
--- a/drivers/net/wireless/ath/ath9k/debug.c
+++ b/drivers/net/wireless/ath/ath9k/debug.c
@@ -538,7 +538,7 @@ static int read_file_interrupt(struct seq_file *file, void *data)
 	if (sc->sc_ah->caps.hw_caps & ATH9K_HW_CAP_EDMA) {
 		PR_IS("RXLP", rxlp);
 		PR_IS("RXHP", rxhp);
-		PR_IS("WATHDOG", bb_watchdog);
+		PR_IS("WATCHDOG", bb_watchdog);
 	} else {
 		PR_IS("RX", rxok);
 	}
-- 
2.17.0
