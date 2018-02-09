Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751189AbeBIL7k (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 06:59:40 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33510 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750863AbeBIL7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 06:59:38 -0500
From: Colin King <colin.king@canonical.com>
To: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] CIFS: SMBD: fix spelling mistake: "faield" -> "failed"
Date: Fri,  9 Feb 2018 11:59:36 +0000
Message-Id: <20180209115936.32569-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in log_rdma_mr message text.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/cifs/smbdirect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
index 91710eb571fb..5405856a4c8e 100644
--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -2295,7 +2295,7 @@ static void smbd_mr_recovery_work(struct work_struct *work)
 				rc = ib_dereg_mr(smbdirect_mr->mr);
 				if (rc) {
 					log_rdma_mr(ERR,
-						"ib_dereg_mr faield rc=%x\n",
+						"ib_dereg_mr failed rc=%x\n",
 						rc);
 					smbd_disconnect_rdma_connection(info);
 				}
-- 
2.15.1
