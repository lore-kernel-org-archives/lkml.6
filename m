Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6447C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 05:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 871FA2083A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 05:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 871FA2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbeJRNJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 09:09:44 -0400
Received: from a2nlsmtp01-05.prod.iad2.secureserver.net ([198.71.225.49]:39454
        "EHLO a2nlsmtp01-05.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727337AbeJRNJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 09:09:44 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id D0Ywg47xmbOGjD0Ywgan4G; Wed, 17 Oct 2018 22:09:34 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1gD0Yv-0007HM-Vv; Wed, 17 Oct 2018 22:09:34 -0700
From:   kys@linuxonhyperv.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc:     Haiyang Zhang <haiyangz@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>
Subject: [PATCH V2 2/5] hv_utils: update name in struct hv_driver util_drv
Date:   Thu, 18 Oct 2018 05:09:29 +0000
Message-Id: <20181018050932.27932-2-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181018050932.27932-1-kys@linuxonhyperv.com>
References: <20181018050835.27828-1-kys@linuxonhyperv.com>
 <20181018050932.27932-1-kys@linuxonhyperv.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfCVdhjszUBFJw4+JbZsb4HZB9P6m7Q8jcwGY4vImu7PBjBhrWxk0ogP7BBuNQoLAITXNrqbJ5WKsHeOLQXCC+j70/DHsiuHXzZZ2PsC8B3t1xAybRpcR
 bSLp7yBb3VCt8W0zL1Kn16tgk/6jlIB2bTy23e17cD8wETrni63hu5eWdmio+j3UeQVUNG1lHAIpPhQSlkdnSTBaDwvvvhEs3jOgIg8ggXqaCUk/3q87hwmp
 Ts0HHqnK3ZG+50XTLJHbuRUUNppxuuB9JAcdYJAC8aK+o7OFxbi4GGbu4RHCo4Ya8+MYaOifdm0z2sN1CtC0s+7th5HOXPc2E5AKYp0aKvY4rR7AyY7PnAD/
 55XIIlKMuYB4cSowoCwejT/CEFS5CHH5nW8OAebcaINGjHgxhBv8ZmD0gnKMM/4szxAJ9FGex6MLJYPnxHRq+kbX3ReXtS7dO97/Ye40aqF+8ZJNj2v+VC21
 eLYs4RJBJUFavK7VqlS749hQrgK3LnbLlJvIDtKi65+iaAZYI0mDrmq2xLS2Cm2pIKdsDADH2s6Eiy1gIWm8225UjjTm2OAKnHbF9g==
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

