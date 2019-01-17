Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E87C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226EF20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbfAQHMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 02:12:10 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2251 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726018AbfAQHMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 02:12:10 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C4231A4D9598C36C1F95;
        Thu, 17 Jan 2019 15:12:07 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Thu, 17 Jan 2019
 15:12:00 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <sre@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <sebastian.reichel@collabora.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] power: supply: core: remove duplicated include from power_supply_core.c
Date:   Thu, 17 Jan 2019 15:11:43 +0800
Message-ID: <20190117071143.14652-1-yuehaibing@huawei.com>
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
 drivers/power/supply/power_supply_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 569790e..07a85e1 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -156,8 +156,6 @@ static void power_supply_deferred_register_work(struct work_struct *work)
 }
 
 #ifdef CONFIG_OF
-#include <linux/of.h>
-
 static int __power_supply_populate_supplied_from(struct device *dev,
 						 void *data)
 {
-- 
2.7.0


