Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3152CC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 06:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D42D721829
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 06:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D42D721829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbeHMIyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 04:54:32 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10706 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726345AbeHMIyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 04:54:31 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EEE292AE07FFF;
        Mon, 13 Aug 2018 14:13:42 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.399.0; Mon, 13 Aug 2018
 14:13:36 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] virtio_net: remove duplicated include from virtio_net.c
Date:   Mon, 13 Aug 2018 14:13:15 +0800
Message-ID: <20180813061315.9084-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicated include linux/netdevice.h

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/virtio_net.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index eb00ae6..7659209 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -30,7 +30,6 @@
 #include <linux/cpu.h>
 #include <linux/average.h>
 #include <linux/filter.h>
-#include <linux/netdevice.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <net/route.h>
-- 
2.7.0


