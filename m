Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753774AbeDRLAP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 07:00:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56373 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752145AbeDRLAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 07:00:13 -0400
From: Colin King <colin.king@canonical.com>
To: Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: caif: fix spelling mistake "UKNOWN" -> "UNKNOWN"
Date: Wed, 18 Apr 2018 12:00:08 +0100
Message-Id: <20180418110008.29841-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 net/caif/chnl_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/caif/chnl_net.c b/net/caif/chnl_net.c
index 53ecda10b790..13e2ae6be620 100644
--- a/net/caif/chnl_net.c
+++ b/net/caif/chnl_net.c
@@ -174,7 +174,7 @@ static void chnl_flowctrl_cb(struct cflayer *layr, enum caif_ctrlcmd flow,
 		flow == CAIF_CTRLCMD_DEINIT_RSP ? "CLOSE/DEINIT" :
 		flow == CAIF_CTRLCMD_INIT_FAIL_RSP ? "OPEN_FAIL" :
 		flow == CAIF_CTRLCMD_REMOTE_SHUTDOWN_IND ?
-		 "REMOTE_SHUTDOWN" : "UKNOWN CTRL COMMAND");
+		 "REMOTE_SHUTDOWN" : "UNKNOWN CTRL COMMAND");
 
 
 
-- 
2.17.0
