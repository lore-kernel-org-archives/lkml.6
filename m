Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752266AbeERKJ3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 06:09:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55038 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751541AbeERKJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 06:09:27 -0400
From: Colin King <colin.king@canonical.com>
To: Jes Sorensen <jes@trained-monkey.org>,
        "David S . Miller" <davem@davemloft.net>, linux-hippi@sunsite.dk,
        netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hippi: fix spelling mistake: "Framming" -> "Framing"
Date: Fri, 18 May 2018 11:09:22 +0100
Message-Id: <20180518100922.28790-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in printk message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/hippi/rrunner.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/hippi/rrunner.c b/drivers/net/hippi/rrunner.c
index 1ab97d99b9ba..f41116488079 100644
--- a/drivers/net/hippi/rrunner.c
+++ b/drivers/net/hippi/rrunner.c
@@ -867,7 +867,7 @@ static u32 rr_handle_event(struct net_device *dev, u32 prodidx, u32 eidx)
 			       dev->name);
 			goto drop;
 		case E_FRM_ERR:
-			printk(KERN_WARNING "%s: Framming Error\n",
+			printk(KERN_WARNING "%s: Framing Error\n",
 			       dev->name);
 			goto drop;
 		case E_FLG_SYN_ERR:
-- 
2.17.0
