Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757912AbeD0SIX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 14:08:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60946 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757845AbeD0SIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 14:08:21 -0400
From: Colin King <colin.king@canonical.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-crypto@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: ghash-clmulni: fix spelling mistake: "acclerated" -> "accelerated"
Date: Fri, 27 Apr 2018 19:08:05 +0100
Message-Id: <20180427180805.15536-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in module description text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/x86/crypto/ghash-clmulni-intel_glue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/crypto/ghash-clmulni-intel_glue.c b/arch/x86/crypto/ghash-clmulni-intel_glue.c
index 0420bab19efb..2ddbe3a1868b 100644
--- a/arch/x86/crypto/ghash-clmulni-intel_glue.c
+++ b/arch/x86/crypto/ghash-clmulni-intel_glue.c
@@ -364,5 +364,5 @@ module_exit(ghash_pclmulqdqni_mod_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("GHASH Message Digest Algorithm, "
-		   "acclerated by PCLMULQDQ-NI");
+		   "accelerated by PCLMULQDQ-NI");
 MODULE_ALIAS_CRYPTO("ghash");
-- 
2.17.0
