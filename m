Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759819AbeD1J5K (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 05:57:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41158 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759745AbeD1J5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 05:57:09 -0400
From: Colin King <colin.king@canonical.com>
To: Li Yang <leoyang.li@nxp.com>, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: ethernet: ucc: fix spelling mistake: "tx-late-collsion" -> "tx-late-collision"
Date: Sat, 28 Apr 2018 10:57:07 +0100
Message-Id: <20180428095707.7424-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in tx_fw_stat_gstrings text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/freescale/ucc_geth_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth_ethtool.c b/drivers/net/ethernet/freescale/ucc_geth_ethtool.c
index 4df282ed22c7..0beee2cc2ddd 100644
--- a/drivers/net/ethernet/freescale/ucc_geth_ethtool.c
+++ b/drivers/net/ethernet/freescale/ucc_geth_ethtool.c
@@ -61,7 +61,7 @@ static const char hw_stat_gstrings[][ETH_GSTRING_LEN] = {
 static const char tx_fw_stat_gstrings[][ETH_GSTRING_LEN] = {
 	"tx-single-collision",
 	"tx-multiple-collision",
-	"tx-late-collsion",
+	"tx-late-collision",
 	"tx-aborted-frames",
 	"tx-lost-frames",
 	"tx-carrier-sense-errors",
-- 
2.17.0
