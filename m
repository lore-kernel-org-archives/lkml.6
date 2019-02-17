Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF17C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 22:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE1D218AC
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 22:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfBQWgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 17:36:32 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:41748 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfBQWgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 17:36:31 -0500
Received: from cpc129250-craw9-2-0-cust139.know.cable.virginm.net ([82.43.126.140] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gvV2w-0007sJ-TV; Sun, 17 Feb 2019 22:36:26 +0000
From:   Colin King <colin.king@canonical.com>
To:     Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: arm/arm64: fix spelling mistake: "auxilary" -> "auxiliary"
Date:   Sun, 17 Feb 2019 22:36:26 +0000
Message-Id: <20190217223626.16686-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a kvm_err error message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 virt/kvm/arm/arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 7fcc1c8c4020..99c37384ba7b 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -1563,7 +1563,7 @@ static int init_hyp_mode(void)
 
 	err = hyp_map_aux_data();
 	if (err)
-		kvm_err("Cannot map host auxilary data: %d\n", err);
+		kvm_err("Cannot map host auxiliary data: %d\n", err);
 
 	return 0;
 
-- 
2.20.1

