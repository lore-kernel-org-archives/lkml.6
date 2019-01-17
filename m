Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFB3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B1C2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbfAQADb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 19:03:31 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53414 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfAQADa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 19:03:30 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gjv9a-00039D-Pc; Thu, 17 Jan 2019 00:03:26 +0000
From:   Colin King <colin.king@canonical.com>
To:     Guo-Fu Tseng <cooldavid@cooldavid.org>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: jme: fix indentation issues
Date:   Thu, 17 Jan 2019 00:03:26 +0000
Message-Id: <20190117000326.29632-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are two lines that have indentation issues, fix these. Also remove
an empty line.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/jme.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/jme.c b/drivers/net/ethernet/jme.c
index a5ab6f3403ae..763ee5281177 100644
--- a/drivers/net/ethernet/jme.c
+++ b/drivers/net/ethernet/jme.c
@@ -2034,10 +2034,9 @@ static void jme_drop_tx_map(struct jme_adapter *jme, int startidx, int count)
 				ctxbi->len,
 				PCI_DMA_TODEVICE);
 
-				ctxbi->mapping = 0;
-				ctxbi->len = 0;
+		ctxbi->mapping = 0;
+		ctxbi->len = 0;
 	}
-
 }
 
 static int
-- 
2.19.1

