Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751522AbeE3KuL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 06:50:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:32982 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750872AbeE3KuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 06:50:10 -0400
From: Colin King <colin.king@canonical.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] crypto: aegis: fix indentation of a statement
Date: Wed, 30 May 2018 11:50:05 +0100
Message-Id: <20180530105005.13116-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trival fix to correct the indentation of a single statement

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 crypto/aegis128l.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/aegis128l.c b/crypto/aegis128l.c
index 0cc1a7525c85..64dc2654b863 100644
--- a/crypto/aegis128l.c
+++ b/crypto/aegis128l.c
@@ -121,7 +121,7 @@ static void crypto_aegis128l_ad(struct aegis_state *state,
 				(const union aegis_chunk *)src;
 
 		while (size >= AEGIS128L_CHUNK_SIZE) {
-                    crypto_aegis128l_update_a(state, src_chunk);
+			crypto_aegis128l_update_a(state, src_chunk);
 
 			size -= AEGIS128L_CHUNK_SIZE;
 			src_chunk += 1;
-- 
2.17.0
