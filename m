Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751291AbeECJM7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 05:12:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39041 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbeECJM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 05:12:57 -0400
From: Colin King <colin.king@canonical.com>
To: Saeed Mahameed <saeedm@mellanox.com>,
        Matan Barak <matanb@mellanox.com>, Leon Romanovsky <leon@kernel.org>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: [PATCH] net/mlx5e: fix spelling mistake: "loobpack" -> "loopback"
Date: Thu,  3 May 2018 10:12:53 +0100
Message-Id: <20180503091253.29324-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in netdev_err error message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c b/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
index 707976482c09..027f54ac1ca2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
@@ -290,7 +290,7 @@ static int mlx5e_test_loopback(struct mlx5e_priv *priv)
 
 	if (!test_bit(MLX5E_STATE_OPENED, &priv->state)) {
 		netdev_err(priv->netdev,
-			   "\tCan't perform loobpack test while device is down\n");
+			   "\tCan't perform loopback test while device is down\n");
 		return -ENODEV;
 	}
 
-- 
2.17.0
