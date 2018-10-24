Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB74C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 06:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EB452081B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 06:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EB452081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbeJXOiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 10:38:24 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38155 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726080AbeJXOiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 10:38:24 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DF3BDAF810F98;
        Wed, 24 Oct 2018 14:11:41 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.408.0; Wed, 24 Oct 2018 14:11:37 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <davem@davemloft.net>
CC:     <wg@grandegger.com>, <mkl@pengutronix.de>,
        <martin.elshuber@theobroma-systems.com>,
        <philipp.tomsich@theobroma-systems.com>,
        <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] can: usb: Remove some duplicated includes from ucan.c
Date:   Wed, 24 Oct 2018 13:58:58 +0800
Message-ID: <1540360738-65328-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just remove same duplicated includes.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/net/can/usb/ucan.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index 0678a38..c6f4b41 100644
--- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -35,10 +35,6 @@
 #include <linux/slab.h>
 #include <linux/usb.h>
 
-#include <linux/can.h>
-#include <linux/can/dev.h>
-#include <linux/can/error.h>
-
 #define UCAN_DRIVER_NAME "ucan"
 #define UCAN_MAX_RX_URBS 8
 /* the CAN controller needs a while to enable/disable the bus */
-- 
1.7.12.4

