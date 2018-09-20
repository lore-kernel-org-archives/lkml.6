Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28903ECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3C6C20867
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3C6C20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388041AbeITIjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:39:09 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12651 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731858AbeITIjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:39:09 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B2EE6E53CEB7B;
        Thu, 20 Sep 2018 10:58:00 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.399.0; Thu, 20 Sep 2018
 10:57:56 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <stuyoder@gmail.com>, <laurentiu.tudor@nxp.com>,
        <tony@atomide.com>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] bus: fsl-mc: remove duplicated include
Date:   Thu, 20 Sep 2018 10:57:42 +0800
Message-ID: <20180920025742.26880-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicated include linux/fsl/mc.h

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/bus/fsl-mc/dpbp.c  | 1 -
 drivers/bus/fsl-mc/dpcon.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/bus/fsl-mc/dpbp.c b/drivers/bus/fsl-mc/dpbp.c
index 17e3c5d..9003cd3 100644
--- a/drivers/bus/fsl-mc/dpbp.c
+++ b/drivers/bus/fsl-mc/dpbp.c
@@ -5,7 +5,6 @@
  */
 #include <linux/kernel.h>
 #include <linux/fsl/mc.h>
-#include <linux/fsl/mc.h>
 
 #include "fsl-mc-private.h"
 
diff --git a/drivers/bus/fsl-mc/dpcon.c b/drivers/bus/fsl-mc/dpcon.c
index 760555d..97b6fa60 100644
--- a/drivers/bus/fsl-mc/dpcon.c
+++ b/drivers/bus/fsl-mc/dpcon.c
@@ -5,7 +5,6 @@
  */
 #include <linux/kernel.h>
 #include <linux/fsl/mc.h>
-#include <linux/fsl/mc.h>
 
 #include "fsl-mc-private.h"
 
-- 
2.7.0


