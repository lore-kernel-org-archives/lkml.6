Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968933AbeE3Jkg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 05:40:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59434 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965438AbeE3Jkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 05:40:33 -0400
From: Colin King <colin.king@canonical.com>
To: Michal Kalderon <Michal.Kalderon@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>,
        Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/qedr: fix spelling mistake: "adrresses" -> "addresses"
Date: Wed, 30 May 2018 10:40:29 +0100
Message-Id: <20180530094029.10747-1-colin.king@canonical.com>
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
index 988aace89430..614a954d0757 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -414,7 +414,7 @@ int qedr_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
 
 	if ((vma->vm_start & (PAGE_SIZE - 1)) || (len & (PAGE_SIZE - 1))) {
 		DP_ERR(dev,
-		       "failed mmap, adrresses must be page aligned: start=0x%pK, end=0x%pK\n",
+		       "failed mmap, addresses must be page aligned: start=0x%pK, end=0x%pK\n",
 		       (void *)vma->vm_start, (void *)vma->vm_end);
 		return -EINVAL;
 	}
-- 
2.17.0
