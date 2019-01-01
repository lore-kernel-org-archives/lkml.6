Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5820FC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 10:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D7A82080D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 10:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbfAAKYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 05:24:07 -0500
Received: from mail115-63.sinamail.sina.com.cn ([218.30.115.63]:46228 "HELO
        mail115-63.sinamail.sina.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1728115AbfAAKYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 05:24:07 -0500
X-Greylist: delayed 1260 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Jan 2019 05:24:06 EST
Received: from unknown (HELO MiWiFi-R3-srv.localdomain)([171.223.33.27])
        by sina.com with ESMTP
        id 5C2B3AB200007385; Tue, 1 Jan 2019 18:02:28 +0800 (CST)
X-Sender: penghao122@sina.com.cn
X-Auth-ID: penghao122@sina.com.cn
X-SMAIL-MID: 113432131129
From:   Peng Hao <penghao122@sina.com.cn>
To:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH]  misc/mic/vop/vop_main : remove unneeded semicolon
Date:   Tue,  1 Jan 2019 18:02:24 +0800
Message-Id: <1546336944-14447-1-git-send-email-penghao122@sina.com.cn>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peng Hao <peng.hao2@zte.com.cn>

Remove unnecessary semicolon in two functions.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 drivers/misc/mic/vop/vop_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mic/vop/vop_main.c b/drivers/misc/mic/vop/vop_main.c
index 3633202..70d4b4d 100644
--- a/drivers/misc/mic/vop/vop_main.c
+++ b/drivers/misc/mic/vop/vop_main.c
@@ -213,7 +213,7 @@ static void vop_reset_inform_host(struct virtio_device *dev)
 		if (ioread8(&dc->host_ack))
 			break;
 		msleep(100);
-	};
+	}
 
 	dev_dbg(_vop_dev(vdev), "%s: retry: %d\n", __func__, retry);
 
@@ -408,7 +408,7 @@ static int vop_find_vqs(struct virtio_device *dev, unsigned nvqs,
 		if (!ioread8(&dc->used_address_updated))
 			break;
 		msleep(100);
-	};
+	}
 
 	dev_dbg(_vop_dev(vdev), "%s: retry: %d\n", __func__, retry);
 	if (!retry) {
-- 
1.8.3.1


