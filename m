Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751736AbeDIMnm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 08:43:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55373 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbeDIMnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 08:43:40 -0400
From: Colin King <colin.king@canonical.com>
To: Saeed Mahameed <saeedm@mellanox.com>,
        Matan Barak <matanb@mellanox.com>, Leon Romanovsky <leon@kernel.org>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net/mlx5: remove some extraneous spaces in indentations
Date: Mon,  9 Apr 2018 13:43:36 +0100
Message-Id: <20180409124336.29274-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are several lines where there is an extraneous space causing
indentation misalignment. Remove them.

Cleans up Cocconelle warnings:

./drivers/net/ethernet/mellanox/mlx5/core/qp.c:409:3-18: code aligned
with following code on line 410
./drivers/net/ethernet/mellanox/mlx5/core/qp.c:415:3-18: code aligned
with following code on line 416
./drivers/net/ethernet/mellanox/mlx5/core/qp.c:421:3-18: code aligned
with following code on line 422

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/qp.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/qp.c b/drivers/net/ethernet/mellanox/mlx5/core/qp.c
index 02d6c5b5d502..4ca07bfb6b14 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/qp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/qp.c
@@ -407,21 +407,21 @@ static int modify_qp_mbox_alloc(struct mlx5_core_dev *dev, u16 opcode, int qpn,
 	case MLX5_CMD_OP_RST2INIT_QP:
 		if (MBOX_ALLOC(mbox, rst2init_qp))
 			return -ENOMEM;
-		 MOD_QP_IN_SET_QPC(rst2init_qp, mbox->in, opcode, qpn,
-				   opt_param_mask, qpc);
-		 break;
+		MOD_QP_IN_SET_QPC(rst2init_qp, mbox->in, opcode, qpn,
+				  opt_param_mask, qpc);
+		break;
 	case MLX5_CMD_OP_INIT2RTR_QP:
 		if (MBOX_ALLOC(mbox, init2rtr_qp))
 			return -ENOMEM;
-		 MOD_QP_IN_SET_QPC(init2rtr_qp, mbox->in, opcode, qpn,
-				   opt_param_mask, qpc);
-		 break;
+		MOD_QP_IN_SET_QPC(init2rtr_qp, mbox->in, opcode, qpn,
+				  opt_param_mask, qpc);
+		break;
 	case MLX5_CMD_OP_RTR2RTS_QP:
 		if (MBOX_ALLOC(mbox, rtr2rts_qp))
 			return -ENOMEM;
-		 MOD_QP_IN_SET_QPC(rtr2rts_qp, mbox->in, opcode, qpn,
-				   opt_param_mask, qpc);
-		 break;
+		MOD_QP_IN_SET_QPC(rtr2rts_qp, mbox->in, opcode, qpn,
+				  opt_param_mask, qpc);
+		break;
 	case MLX5_CMD_OP_RTS2RTS_QP:
 		if (MBOX_ALLOC(mbox, rts2rts_qp))
 			return -ENOMEM;
-- 
2.15.1
