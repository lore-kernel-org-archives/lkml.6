Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751440AbeECPTl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 11:19:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45056 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751069AbeECPTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 11:19:38 -0400
From: Colin King <colin.king@canonical.com>
To: Ariel Elior <Ariel.Elior@cavium.com>, everest-linux-l2@cavium.com,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] qed: fix spelling mistake: "offloded" -> "offloaded"
Date: Thu,  3 May 2018 16:19:32 +0100
Message-Id: <20180503151932.22458-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in DP_NOTICE message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/qlogic/qed/qed_roce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_roce.c b/drivers/net/ethernet/qlogic/qed/qed_roce.c
index fb7c2d1562ae..6acfd43c1a4f 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_roce.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_roce.c
@@ -848,7 +848,7 @@ int qed_roce_query_qp(struct qed_hwfn *p_hwfn,
 
 	if (!(qp->resp_offloaded)) {
 		DP_NOTICE(p_hwfn,
-			  "The responder's qp should be offloded before requester's\n");
+			  "The responder's qp should be offloaded before requester's\n");
 		return -EINVAL;
 	}
 
-- 
2.17.0
