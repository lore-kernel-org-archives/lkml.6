Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751935AbeB0WCU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 17:02:20 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:39164 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751813AbeB0WCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 17:02:15 -0500
X-Google-Smtp-Source: AG47ELupVnA7NCsuqPJ+X74D99WlBIGia8LDfe4drmR1CdB/UCscIeOjXxHBAjOXZRYmy7ku43lS8g==
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: herbert@gondor.apana.org.au, davem@davemloft.net,
        hernan@vanguardiasur.com.ar, steven.lin1@broadcom.com,
        arvind.yadav.cs@gmail.com, colin.king@canonical.com,
        raveendra.padasalagi@broadcom.com, ray.jui@broadcom.com,
        scott.branden@broadcom.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] crypto: bcm: Remove unused variable (char *tag_to_hash_idx[])
Date: Tue, 27 Feb 2018 19:01:25 -0300
Message-Id: <1519768888-19866-1-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note: this is compile only tested.
Variable was not used anywhere in the code, remove it and save 20 bytes.

add/remove: 0/1 grow/shrink: 0/0 up/down: 0/-20 (-20)
Function                                     old     new   delta
tag_to_hash_idx                               20       -     -20
Total: Before=9185256, After=9185236, chg -0.00%

Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
---
 drivers/crypto/bcm/spu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/crypto/bcm/spu.c b/drivers/crypto/bcm/spu.c
index dbb5c03..c3d177d 100644
--- a/drivers/crypto/bcm/spu.c
+++ b/drivers/crypto/bcm/spu.c
@@ -23,8 +23,6 @@
 #include "cipher.h"
 
 /* This array is based on the hash algo type supported in spu.h */
-char *tag_to_hash_idx[] = { "none", "md5", "sha1", "sha224", "sha256" };
-
 char *hash_alg_name[] = { "None", "md5", "sha1", "sha224", "sha256", "aes",
 	"sha384", "sha512", "sha3_224", "sha3_256", "sha3_384", "sha3_512" };
 
-- 
2.7.4
