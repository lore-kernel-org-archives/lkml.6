Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A67C5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 03:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A85E214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 03:15:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A85E214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbeJQLIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 07:08:40 -0400
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net ([198.71.225.36]:44682
        "EHLO a2nlsmtp01-02.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727208AbeJQLIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 07:08:40 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id CcHggp7V9M0DPCcHgged8Y; Tue, 16 Oct 2018 20:14:08 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1gCcHg-0000DK-HS; Tue, 16 Oct 2018 20:14:08 -0700
From:   kys@linuxonhyperv.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc:     Haiyang Zhang <haiyangz@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>
Subject: [PATCH 2/5] hv_utils: update name in struct hv_driver util_drv
Date:   Wed, 17 Oct 2018 03:14:03 +0000
Message-Id: <20181017031406.773-2-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181017031406.773-1-kys@linuxonhyperv.com>
References: <20181017031241.669-1-kys@linuxonhyperv.com>
 <20181017031406.773-1-kys@linuxonhyperv.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfP/JrwSBu5d8yh9iANiFAMjt6iDCYsdc5PjziJI2+mF6q0Yz9ohItO7a1BB8PNcU+A4ppMVuDLjoonBoKpD4c9jdLBFVhjkVcBrurQE7TkLR0We3EBnT
 N95jD0tTU0Qhj0s9xX36+5V/H8fs7diSBnisuyUrKLBBYAep1JhB353qHBXWa1N4BTkXxZ6M1CjQQlXIhug3KnhADfr4BMrv188UD2JJ9yt8It29HneECNbp
 /xorPVBg2qpod2P5jb64T4wztpDYA++P33N9xscyofJX+C/UrhQ8ZRE4n212D+zEekWu1qLeUZ0mowGuAHCN/6GEV/H18var7f5Z4Ddlp2c6pJtMSswkowcL
 8uF2yYH1yiG6QbXAofsdxaGUSx/XdnBursvbndwhkI1SJrhm/KBG7nGE6Z63UIYz3Xb2WZwu4dLm+RLPXjtHr8sv3olXJB2+TL0JNmGmJkWPaxfQWN+7+qnc
 5mxfWWeJc1xRaCQWg4mHqYiB6PTPUWAmC9MHDCaubvIbYuka7xhZtZUD3Shx96svPexKEO84+TaUU1GaUHe7WjTWPspfCIsgqUVR3g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haiyang Zhang <haiyangz@microsoft.com>

The correct module name is hv_utils. This patch corrects
the name in struct hv_driver util_drv.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/hv/hv_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index 423205077bf6..f10eeb120c8b 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -483,7 +483,7 @@ MODULE_DEVICE_TABLE(vmbus, id_table);
 
 /* The one and only one */
 static  struct hv_driver util_drv = {
-	.name = "hv_util",
+	.name = "hv_utils",
 	.id_table = id_table,
 	.probe =  util_probe,
 	.remove =  util_remove,
-- 
2.18.0

