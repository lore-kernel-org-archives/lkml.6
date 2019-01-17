Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D511EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A3920851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbfAQHWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 02:22:47 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:35964 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727364AbfAQHWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 02:22:47 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BACFA328BA704533938A;
        Thu, 17 Jan 2019 15:22:44 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Thu, 17 Jan 2019
 15:22:35 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <Ariel.Elior@cavium.com>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <everest-linux-l2@cavium.com>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] qed: remove duplicated include from qed_if.h
Date:   Thu, 17 Jan 2019 15:22:20 +0800
Message-ID: <20190117072220.14900-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicated include.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/linux/qed/qed_if.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/qed/qed_if.h b/include/linux/qed/qed_if.h
index 91c536a..5f818fd 100644
--- a/include/linux/qed/qed_if.h
+++ b/include/linux/qed/qed_if.h
@@ -38,7 +38,6 @@
 #include <linux/netdevice.h>
 #include <linux/pci.h>
 #include <linux/skbuff.h>
-#include <linux/types.h>
 #include <asm/byteorder.h>
 #include <linux/io.h>
 #include <linux/compiler.h>
-- 
2.7.0


