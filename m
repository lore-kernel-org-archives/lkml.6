Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5ABC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BEFE2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:23:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BEFE2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732473AbeKNAVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:21:55 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:46192 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbeKNAVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:21:55 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gMZbE-0002s0-LP; Tue, 13 Nov 2018 14:23:28 +0000
From:   Colin King <colin.king@canonical.com>
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] af_key: fix indentation on declaration statement
Date:   Tue, 13 Nov 2018 14:23:28 +0000
Message-Id: <20181113142328.8322-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is an indentation issue before the declaration of xfrm_ctx. Remove
spaces and replace with a tab.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 net/key/af_key.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/key/af_key.c b/net/key/af_key.c
index 9d61266526e7..655c787f9d54 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -2020,7 +2020,7 @@ parse_ipsecrequests(struct xfrm_policy *xp, struct sadb_x_policy *pol)
 
 static inline int pfkey_xfrm_policy2sec_ctx_size(const struct xfrm_policy *xp)
 {
-  struct xfrm_sec_ctx *xfrm_ctx = xp->security;
+	struct xfrm_sec_ctx *xfrm_ctx = xp->security;
 
 	if (xfrm_ctx) {
 		int len = sizeof(struct sadb_x_sec_ctx);
-- 
2.19.1

