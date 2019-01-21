Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC3EC282F4
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8CB2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbfAUIU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:20:59 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2204 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729591AbfAUIUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:20:55 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 749A4166F47E0A6B2FD8;
        Mon, 21 Jan 2019 16:20:53 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.408.0; Mon, 21 Jan 2019 16:20:47 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Yue Haibing <yuehaibing@huawei.com>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] staging: gasket: interrupt: remove unused including <linux/version.h>
Date:   Mon, 21 Jan 2019 08:26:37 +0000
Message-ID: <1548059197-147949-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Haibing <yuehaibing@huawei.com>

Remove including <linux/version.h> that don't need it.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/staging/gasket/gasket_interrupt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_interrupt.c b/drivers/staging/gasket/gasket_interrupt.c
index 1cfbc12..176ac2a 100644
--- a/drivers/staging/gasket/gasket_interrupt.c
+++ b/drivers/staging/gasket/gasket_interrupt.c
@@ -9,7 +9,6 @@
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/printk.h>
-#include <linux/version.h>
 #ifdef GASKET_KERNEL_TRACE_SUPPORT
 #define CREATE_TRACE_POINTS
 #include <trace/events/gasket_interrupt.h>





