Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751423AbeEVIhf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 04:37:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58717 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbeEVIhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 04:37:32 -0400
From: Colin King <colin.king@canonical.com>
To: Tariq Toukan <tariqt@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net/mlx4: fix spelling mistake: "Inrerface" -> "Interface"
Date: Tue, 22 May 2018 09:37:28 +0100
Message-Id: <20180522083728.5874-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in mlx4_dbg debug message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/mellanox/mlx4/intf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/intf.c b/drivers/net/ethernet/mellanox/mlx4/intf.c
index 2edcce98ab2d..6bd4103265d2 100644
--- a/drivers/net/ethernet/mellanox/mlx4/intf.c
+++ b/drivers/net/ethernet/mellanox/mlx4/intf.c
@@ -172,7 +172,7 @@ int mlx4_do_bond(struct mlx4_dev *dev, bool enable)
 		list_add_tail(&dev_ctx->list, &priv->ctx_list);
 		spin_unlock_irqrestore(&priv->ctx_lock, flags);
 
-		mlx4_dbg(dev, "Inrerface for protocol %d restarted with when bonded mode is %s\n",
+		mlx4_dbg(dev, "Interface for protocol %d restarted with when bonded mode is %s\n",
 			 dev_ctx->intf->protocol, enable ?
 			 "enabled" : "disabled");
 	}
-- 
2.17.0
