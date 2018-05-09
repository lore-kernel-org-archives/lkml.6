Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934631AbeEIJQy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 05:16:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51904 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934203AbeEIJQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 05:16:52 -0400
From: Colin King <colin.king@canonical.com>
To: Haren Myneni <haren@us.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, linux-crypto@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: nx: fix spelling mistake: "seqeunce" -> "sequence"
Date: Wed,  9 May 2018 10:16:36 +0100
Message-Id: <20180509091636.13589-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in CSB_ERR error message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/crypto/nx/nx-842-powernv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/nx/nx-842-powernv.c b/drivers/crypto/nx/nx-842-powernv.c
index 1e87637c412d..36afd6d8753c 100644
--- a/drivers/crypto/nx/nx-842-powernv.c
+++ b/drivers/crypto/nx/nx-842-powernv.c
@@ -334,7 +334,7 @@ static int wait_for_csb(struct nx842_workmem *wmem,
 		return -EPROTO;
 	case CSB_CC_SEQUENCE:
 		/* should not happen, we don't use chained CRBs */
-		CSB_ERR(csb, "CRB seqeunce number error");
+		CSB_ERR(csb, "CRB sequence number error");
 		return -EPROTO;
 	case CSB_CC_UNKNOWN_CODE:
 		CSB_ERR(csb, "Unknown subfunction code");
-- 
2.17.0
