Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D93C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F42D2145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkqRvJN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F42D2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbeKOIsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:48:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:34402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728649AbeKOI1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:27:20 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6371522522;
        Wed, 14 Nov 2018 22:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234137;
        bh=vixQHU+p4mGHhHl2YenHr4mVIWYzd6mb++cR/rQwSJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fkqRvJN+E6kpWDCDwHVs9rw0mCdW4qBo3+dWP3K2DOB3tSZCpOc4uEAfNv+fh4g6b
         fLoJASMIzvnybbddPTVkL5HpRNXtMun3BMZ/AYk0LT3hjVPQZ1UDwHpcRudbOz5PbZ
         TvVgatpY5pyG9eXuiXz1WbuA5ih/a+XEEi8RbW3g=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 38/73] mtd: nand: Fix nanddev_pos_next_page() kernel-doc header
Date:   Wed, 14 Nov 2018 17:21:32 -0500
Message-Id: <20181114222207.98701-38-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222207.98701-1-sashal@kernel.org>
References: <20181114222207.98701-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <boris.brezillon@bootlin.com>

[ Upstream commit 98ee3fc7ef8395f8b7a379e6608aee91efc66d48 ]

Function name is wrong in the kernel-doc header.

Fixes: 9c3736a3de21 ("mtd: nand: Add core infrastructure to deal with NAND devices")
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/mtd/nand.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index abe975c87b90..ad8f0325c027 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -569,7 +569,7 @@ static inline void nanddev_pos_next_eraseblock(struct nand_device *nand,
 }
 
 /**
- * nanddev_pos_next_eraseblock() - Move a position to the next page
+ * nanddev_pos_next_page() - Move a position to the next page
  * @nand: NAND device
  * @pos: the position to update
  *
-- 
2.17.1

