Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753406AbeEAIZz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 04:25:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55646 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751421AbeEAIZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 04:25:53 -0400
From: Colin King <colin.king@canonical.com>
To: Michal Kalderon <Michal.Kalderon@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>,
        Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/qedr: fix spelling mistake: "failes" -> "fails"
Date: Tue,  1 May 2018 09:25:49 +0100
Message-Id: <20180501082549.22215-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in DP_ERR error message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/infiniband/hw/qedr/verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 7d3763b2e01c..35f3b6f8fd45 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -2579,7 +2579,7 @@ static int qedr_set_page(struct ib_mr *ibmr, u64 addr)
 	u32 pbes_in_page;
 
 	if (unlikely(mr->npages == mr->info.pbl_info.num_pbes)) {
-		DP_ERR(mr->dev, "qedr_set_page failes when %d\n", mr->npages);
+		DP_ERR(mr->dev, "qedr_set_page fails when %d\n", mr->npages);
 		return -ENOMEM;
 	}
 
-- 
2.17.0
