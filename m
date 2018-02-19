Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753142AbeBSOvp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 09:51:45 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60192 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752901AbeBSOvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 09:51:41 -0500
From: Gilad Ben-Yossef <gilad@benyossef.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Ofir Drang <ofir.drang@arm.com>, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] crypto: ccree: remove unused definitions
Date: Mon, 19 Feb 2018 14:51:21 +0000
Message-Id: <1519051887-4668-2-git-send-email-gilad@benyossef.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519051887-4668-1-git-send-email-gilad@benyossef.com>
References: <1519051887-4668-1-git-send-email-gilad@benyossef.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove enum definition which are not used by the REE interface
driver.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---
 drivers/crypto/ccree/cc_crypto_ctx.h | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/crypto/ccree/cc_crypto_ctx.h b/drivers/crypto/ccree/cc_crypto_ctx.h
index 5cb4dde..06a7860 100644
--- a/drivers/crypto/ccree/cc_crypto_ctx.h
+++ b/drivers/crypto/ccree/cc_crypto_ctx.h
@@ -146,24 +146,4 @@ enum drv_hash_hw_mode {
 	DRV_HASH_HW_RESERVE32B = S32_MAX
 };
 
-/* drv_crypto_key_type[1:0] is mapped to cipher_do[1:0] */
-/* drv_crypto_key_type[2] is mapped to cipher_config2 */
-enum drv_crypto_key_type {
-	DRV_NULL_KEY = -1,
-	DRV_USER_KEY = 0,		/* 0x000 */
-	DRV_ROOT_KEY = 1,		/* 0x001 */
-	DRV_PROVISIONING_KEY = 2,	/* 0x010 */
-	DRV_SESSION_KEY = 3,		/* 0x011 */
-	DRV_APPLET_KEY = 4,		/* NA */
-	DRV_PLATFORM_KEY = 5,		/* 0x101 */
-	DRV_CUSTOMER_KEY = 6,		/* 0x110 */
-	DRV_END_OF_KEYS = S32_MAX,
-};
-
-enum drv_crypto_padding_type {
-	DRV_PADDING_NONE = 0,
-	DRV_PADDING_PKCS7 = 1,
-	DRV_PADDING_RESERVE32B = S32_MAX
-};
-
 #endif /* _CC_CRYPTO_CTX_H_ */
-- 
2.7.4
