Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754841AbeD3Q3v (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 12:29:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44866 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754713AbeD3Q3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 12:29:49 -0400
From: Colin King <colin.king@canonical.com>
To: Tariq Toukan <tariqt@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net/mlx4: fix spelling mistake: "failedi" -> "failed"
Date: Mon, 30 Apr 2018 17:29:45 +0100
Message-Id: <20180430162945.5274-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

trivial fix to spelling mistake in mlx4_warn message.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/mellanox/mlx4/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/main.c b/drivers/net/ethernet/mellanox/mlx4/main.c
index bfef69235d71..211578ffc70d 100644
--- a/drivers/net/ethernet/mellanox/mlx4/main.c
+++ b/drivers/net/ethernet/mellanox/mlx4/main.c
@@ -1317,7 +1317,7 @@ static int mlx4_mf_unbond(struct mlx4_dev *dev)
 
 	ret = mlx4_unbond_fs_rules(dev);
 	if (ret)
-		mlx4_warn(dev, "multifunction unbond for flow rules failedi (%d)\n", ret);
+		mlx4_warn(dev, "multifunction unbond for flow rules failed (%d)\n", ret);
 	ret1 = mlx4_unbond_mac_table(dev);
 	if (ret1) {
 		mlx4_warn(dev, "multifunction unbond for MAC table failed (%d)\n", ret1);
-- 
2.17.0
