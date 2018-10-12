Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10414C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 02:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 662C22098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 02:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 662C22098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbeJLKIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 06:08:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51859 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726034AbeJLKIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 06:08:05 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 052DD8826F6EA;
        Fri, 12 Oct 2018 10:37:53 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.399.0; Fri, 12 Oct 2018
 10:37:45 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <natechancellor@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: fddi: skfp: Remove unused macros 'PNMI_GET_ID' and 'PNMI_SET_ID'
Date:   Fri, 12 Oct 2018 10:37:41 +0800
Message-ID: <20181012023741.13224-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two PNMI macros are never used

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/fddi/skfp/h/cmtdef.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/fddi/skfp/h/cmtdef.h b/drivers/net/fddi/skfp/h/cmtdef.h
index a12f464..448d66c 100644
--- a/drivers/net/fddi/skfp/h/cmtdef.h
+++ b/drivers/net/fddi/skfp/h/cmtdef.h
@@ -655,14 +655,6 @@ void dump_hex(char *p, int len);
 #ifndef PNMI_INIT
 #define	PNMI_INIT(smc)	/* Nothing */
 #endif
-#ifndef PNMI_GET_ID
-#define PNMI_GET_ID( smc, ndis_oid, buf, len, BytesWritten, BytesNeeded ) \
-		( 1 ? (-1) : (-1) )
-#endif
-#ifndef PNMI_SET_ID
-#define PNMI_SET_ID( smc, ndis_oid, buf, len, BytesRead, BytesNeeded, \
-		set_type) ( 1 ? (-1) : (-1) )
-#endif
 
 /*
  * SMT_PANIC defines
-- 
2.7.0


