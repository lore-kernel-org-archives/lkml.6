Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031901AbeEZPCc (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 11:02:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56669 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754946AbeEZPCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 11:02:31 -0400
From: Colin King <colin.king@canonical.com>
To: "Nicholas A . Bellinger" <nab@linux-iscsi.org>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: target: fix spelling mistake "Uknown" -> "Unknown"
Date: Sat, 26 May 2018 16:02:29 +0100
Message-Id: <20180526150229.10416-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in pr_err message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/target/target_core_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index bde14f46ed5b..f0e8f0f4ccb4 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -3366,7 +3366,7 @@ static void target_tmr_work(struct work_struct *work)
 		tmr->response = TMR_FUNCTION_REJECTED;
 		break;
 	default:
-		pr_err("Uknown TMR function: 0x%02x.\n",
+		pr_err("Unknown TMR function: 0x%02x.\n",
 				tmr->function);
 		tmr->response = TMR_FUNCTION_REJECTED;
 		break;
-- 
2.17.0
