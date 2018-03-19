Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755575AbeCSNdV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 09:33:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59518 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933333AbeCSNdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 09:33:17 -0400
From: Colin King <colin.king@canonical.com>
To: Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>,
        Alex Elder <elder@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        ceph-devel@vger.kernel.org, linux-block@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rbd: fix spelling mistake: "reregisteration" -> "re-registration"
Date: Mon, 19 Mar 2018 13:33:10 +0000
Message-Id: <20180319133310.4251-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in rdb_warn message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/block/rbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 1e03b04819c8..7b97240ff15e 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3887,7 +3887,7 @@ static void rbd_reregister_watch(struct work_struct *work)
 
 	ret = rbd_dev_refresh(rbd_dev);
 	if (ret)
-		rbd_warn(rbd_dev, "reregisteration refresh failed: %d", ret);
+		rbd_warn(rbd_dev, "re-registration refresh failed: %d", ret);
 }
 
 /*
-- 
2.15.1
