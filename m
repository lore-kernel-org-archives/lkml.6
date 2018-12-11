Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04022C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD4842082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="jHWoz/Yu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD4842082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=posteo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbeLKKzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:55:13 -0500
Received: from mout02.posteo.de ([185.67.36.66]:36541 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbeLKKzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:55:05 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 4E36D240102
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 11:55:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1544525704; bh=5RVTAE+67M1oxuAe05gzAyXY9sblhFrQsvOomeI+nuA=;
        h=From:To:Cc:Subject:Date:From;
        b=jHWoz/Yu+1WmsS6FfbZXP1g9A0pKbOsILamppzvRSn3g6MF5Yuw3yumjMZaSVTUky
         Dh9coKsxsYNbcjyeOL93upPkkGy5lP/pSJAbzl9vLCDYsPzs8Knk57E4/Z6jG98MA0
         A23wMrjQNbrL1YoeI0AKGt9SuFxJVU+UO8sYjjjTpLli/gg5JgZeClXlUrTM4qOW1q
         DhED0yocRjZDuBgawfDFOUnlM3eajEZTxdQFRitcJS6aY7eO9EcvBP+FGWr9wcpy2M
         Zb/Yrda1u5vf2lvnHudbc/F3Y6fDDzmcvXPRHPskLAQTQ0OOoj6b1D9o6rGQhDJkNr
         s+1zPmNnlOPIQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 43DcKL5qyXz9rxL;
        Tue, 11 Dec 2018 11:55:02 +0100 (CET)
From:   Aaron Strahlberger <aaron.strahlberger@posteo.de>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chao Yu <yuchao0@huawei.com>, linux-erofs@lists.ozlabs.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-kernel@i4.cs.fau.de,
        Aaron Strahlberger <aaron.strahlberger@posteo.de>,
        Julius Wiedmann <julius.wiedmann@fau.de>,
        Dominik Huber <domi250@gmx.de>
Subject: [PATCH 5/5] drivers: staging: erofs: Add blank line after function
Date:   Tue, 11 Dec 2018 11:54:43 +0100
Message-Id: <20181211105443.21826-6-aaron.strahlberger@posteo.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181211105443.21826-1-aaron.strahlberger@posteo.de>
References: <0ed9f3e7-9081-4a8a-06b0-e5ad14e2c872@huawei.com>
 <20181211105443.21826-1-aaron.strahlberger@posteo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix of checkpatch.pl issue:

CHECK: Please use a blank line after ... declarations

Signed-off-by: Aaron Strahlberger <aaron.strahlberger@posteo.de>
Signed-off-by: Julius Wiedmann <julius.wiedmann@fau.de>
Signed-off-by: Dominik Huber <domi250@gmx.de>
---
 drivers/staging/erofs/erofs_fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/erofs/erofs_fs.h b/drivers/staging/erofs/erofs_fs.h
index 892c913960c3..6a8c51d6ad61 100644
--- a/drivers/staging/erofs/erofs_fs.h
+++ b/drivers/staging/erofs/erofs_fs.h
@@ -58,6 +58,7 @@ enum {
 	EROFS_INODE_LAYOUT_INLINE,
 	EROFS_INODE_LAYOUT_MAX
 };
+
 #define EROFS_I_VERSION_BITS            1
 #define EROFS_I_DATA_MAPPING_BITS       3
 
-- 
2.19.2

