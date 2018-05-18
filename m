Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753120AbeERJWP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 05:22:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54119 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751320AbeERJWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 05:22:10 -0400
From: Colin King <colin.king@canonical.com>
To: Jay Cliburn <jcliburn@gmail.com>, Chris Snook <chris.snook@gmail.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net/atheros: fix spelling mistake: "Ddescription" -> "Description"
Date: Fri, 18 May 2018 10:22:06 +0100
Message-Id: <20180518092206.21635-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistakes in name field text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/atheros/atl1e/atl1e_param.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/atheros/atl1e/atl1e_param.c b/drivers/net/ethernet/atheros/atl1e/atl1e_param.c
index fa314282c9ad..6a375f4bd054 100644
--- a/drivers/net/ethernet/atheros/atl1e/atl1e_param.c
+++ b/drivers/net/ethernet/atheros/atl1e/atl1e_param.c
@@ -192,7 +192,7 @@ void atl1e_check_options(struct atl1e_adapter *adapter)
 	{ 		/* Transmit Ring Size */
 		struct atl1e_option opt = {
 			.type = range_option,
-			.name = "Transmit Ddescription Count",
+			.name = "Transmit Description Count",
 			.err  = "using default of "
 				__MODULE_STRING(ATL1E_DEFAULT_TX_DESC_CNT),
 			.def  = ATL1E_DEFAULT_TX_DESC_CNT,
-- 
2.17.0
