Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752334AbeC2MLM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 08:11:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38204 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750753AbeC2MLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 08:11:11 -0400
From: Colin King <colin.king@canonical.com>
To: Michal Kalderon <Michal.Kalderon@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>,
        Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] qedr: ix spelling mistake: "hanlde" -> "handle"
Date: Thu, 29 Mar 2018 13:11:07 +0100
Message-Id: <20180329121107.27248-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in DP_ERR message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/infiniband/hw/qedr/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/main.c b/drivers/infiniband/hw/qedr/main.c
index 1f032fdbdb19..36d60d3c1630 100644
--- a/drivers/infiniband/hw/qedr/main.c
+++ b/drivers/infiniband/hw/qedr/main.c
@@ -708,7 +708,7 @@ static void qedr_affiliated_event(void *context, u8 e_code, void *fw_handle)
 			     "Error: CQ event with NULL pointer ibcq. Handle=%llx\n",
 			     roce_handle64);
 		}
-		DP_ERR(dev, "CQ event %d on hanlde %p\n", e_code, cq);
+		DP_ERR(dev, "CQ event %d on handle %p\n", e_code, cq);
 		break;
 	case EVENT_TYPE_QP:
 		qp = (struct qedr_qp *)(uintptr_t)roce_handle64;
@@ -724,7 +724,7 @@ static void qedr_affiliated_event(void *context, u8 e_code, void *fw_handle)
 			     "Error: QP event with NULL pointer ibqp. Handle=%llx\n",
 			     roce_handle64);
 		}
-		DP_ERR(dev, "QP event %d on hanlde %p\n", e_code, qp);
+		DP_ERR(dev, "QP event %d on handle %p\n", e_code, qp);
 		break;
 	default:
 		break;
-- 
2.15.1
