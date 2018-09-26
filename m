Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37237C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61E0208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E61E0208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeIZNpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 09:45:12 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12705 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726595AbeIZNpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 09:45:11 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DDB7F18FF7472;
        Wed, 26 Sep 2018 15:33:32 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.399.0; Wed, 26 Sep 2018
 15:33:24 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <plai@codeaurora.org>, <bgoswami@codeaurora.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: qcom: qdsp6: remove duplicated include
Date:   Wed, 26 Sep 2018 15:33:03 +0800
Message-ID: <20180926073303.25796-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicated includes linux/of_platform.h
and linux/wait.h

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/qcom/qdsp6/q6asm.c  | 1 -
 sound/soc/qcom/qdsp6/q6core.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index 2b2c723..e1cfa84 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -11,7 +11,6 @@
 #include <linux/spinlock.h>
 #include <linux/kref.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
 #include <uapi/sound/asound.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
diff --git a/sound/soc/qcom/qdsp6/q6core.c b/sound/soc/qcom/qdsp6/q6core.c
index ca1be73..cdfc8ab 100644
--- a/sound/soc/qcom/qdsp6/q6core.c
+++ b/sound/soc/qcom/qdsp6/q6core.c
@@ -10,7 +10,6 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/jiffies.h>
-#include <linux/wait.h>
 #include <linux/soc/qcom/apr.h>
 #include "q6core.h"
 #include "q6dsp-errno.h"
-- 
2.7.0


