Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DD5C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD6C20868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AD6C20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbeK3WR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 17:17:58 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:46704 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726507AbeK3WR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 17:17:58 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A71326E3DBFE;
        Fri, 30 Nov 2018 19:08:58 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Fri, 30 Nov 2018
 19:08:52 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <stuyoder@gmail.com>, <laurentiu.tudor@nxp.com>, <jroedel@suse.de>
CC:     <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <ruxandra.radulescu@nxp.com>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] bus: fsl-mc: remove duplicated include files
Date:   Fri, 30 Nov 2018 19:08:38 +0800
Message-ID: <20181130110838.26376-1-yuehaibing@huawei.com>
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


