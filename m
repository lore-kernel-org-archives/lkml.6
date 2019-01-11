Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9B3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 538412146F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbfAKJdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:33:19 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:4193 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727008AbfAKJdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:33:19 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0B9VZjf016823;
        Fri, 11 Jan 2019 10:33:13 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ptybne56d-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 11 Jan 2019 10:33:13 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 617CC3A;
        Fri, 11 Jan 2019 09:33:12 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 09F612696;
        Fri, 11 Jan 2019 09:33:12 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 11 Jan
 2019 10:33:11 +0100
Received: from localhost (10.201.20.178) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 11 Jan 2019 10:33:11
 +0100
From:   Loic Pallardy <loic.pallardy@st.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        <s-anna@ti.com>, Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH 1/1] rpmsg: virtio: change header file sort style
Date:   Fri, 11 Jan 2019 10:33:01 +0100
Message-ID: <1547199181-83058-1-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.178]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-11_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make header files alphabetical order.

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 664f957012cd..e1d563fbfe65 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -11,21 +11,21 @@
 
 #define pr_fmt(fmt) "%s: " fmt, __func__
 
+#include <linux/dma-mapping.h>
+#include <linux/idr.h>
+#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/virtio.h>
-#include <linux/virtio_ids.h>
-#include <linux/virtio_config.h>
+#include <linux/mutex.h>
+#include <linux/of_device.h>
+#include <linux/rpmsg.h>
 #include <linux/scatterlist.h>
-#include <linux/dma-mapping.h>
 #include <linux/slab.h>
-#include <linux/idr.h>
-#include <linux/jiffies.h>
 #include <linux/sched.h>
+#include <linux/virtio.h>
+#include <linux/virtio_ids.h>
+#include <linux/virtio_config.h>
 #include <linux/wait.h>
-#include <linux/rpmsg.h>
-#include <linux/mutex.h>
-#include <linux/of_device.h>
 
 #include "rpmsg_internal.h"
 
-- 
2.7.4

