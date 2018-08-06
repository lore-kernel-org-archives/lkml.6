Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410D3C46470
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 03:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E339D219CB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 03:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E339D219CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeHFFfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 01:35:12 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10669 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726554AbeHFFfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 01:35:12 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 022007C87A838;
        Mon,  6 Aug 2018 11:28:07 +0800 (CST)
Received: from szvp000100637.huawei.com (10.162.55.131) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.399.0; Mon, 6 Aug 2018
 11:27:58 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>,
        "Julia Lawall" <julia.lawall@lip6.fr>,
        zhong jiang <zhongjiang@huawei.com>,
        Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        <weidu.du@huawei.com>, Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH] staging: erofs: remove an extra semicolon in z_erofs_vle_unzip_all
Date:   Mon, 6 Aug 2018 11:27:53 +0800
Message-ID: <1533526073-116588-1-git-send-email-gaoxiang25@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.162.55.131]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an extra semicolon in z_erofs_vle_unzip_all, remove it.

Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: zhong jiang <zhongjiang@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---

zhongjiang <zhongjiang@huawei.com> also submitted a patch yesterday titled
    "drivers/staging: Remove some unneeded semicolon"

Since it was reported by Julia Lawall <julia.lawall@lip6.fr> weeks ago
and already pending for review in linux-erofs mailing list. Add
   Signed-off-by: zhong jiang <zhongjiang@huawei.com>
in this patch.

Thanks,
Gao Xiang

 drivers/staging/erofs/unzip_vle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 45b1255..8721f0a 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -1017,7 +1017,7 @@ static void z_erofs_vle_unzip_all(struct super_block *sb,
 		owned = READ_ONCE(grp->next);
 
 		z_erofs_vle_unzip(sb, grp, page_pool);
-	};
+	}
 }
 
 static void z_erofs_vle_unzip_wq(struct work_struct *work)
-- 
1.9.1

