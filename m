Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751495AbeECNfP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 09:35:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43068 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbeECNfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 09:35:09 -0400
From: Colin King <colin.king@canonical.com>
To: Saeed Mahameed <saeedm@mellanox.com>,
        Matan Barak <matanb@mellanox.com>, Leon Romanovsky <leon@kernel.org>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net/mlx5: fix spelling mistake: "modfiy" -> "modify"
Date: Thu,  3 May 2018 14:35:03 +0100
Message-Id: <20180503133503.14508-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in netdev_warn warning message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
index 610d485c4b03..f64b5e78519b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
@@ -565,7 +565,7 @@ static void arfs_modify_rule_rq(struct mlx5e_priv *priv,
 	err =  mlx5_modify_rule_destination(rule, &dst, NULL);
 	if (err)
 		netdev_warn(priv->netdev,
-			    "Failed to modfiy aRFS rule destination to rq=%d\n", rxq);
+			    "Failed to modify aRFS rule destination to rq=%d\n", rxq);
 }
 
 static void arfs_handle_work(struct work_struct *work)
-- 
2.17.0
