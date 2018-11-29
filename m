Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC4EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB82B208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB82B208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbeK2TNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 14:13:25 -0500
Received: from mx.socionext.com ([202.248.49.38]:4141 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727322AbeK2TNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 14:13:18 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 29 Nov 2018 17:08:46 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id E743360062;
        Thu, 29 Nov 2018 17:08:46 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 29 Nov 2018 17:08:46 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 5A3211A03A2;
        Thu, 29 Nov 2018 17:08:46 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH net 3/3] net: ethernet: ave: Add MODULE_AUTHOR and MAINTAINERS entry
Date:   Thu, 29 Nov 2018 17:08:38 +0900
Message-Id: <1543478918-13883-4-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543478918-13883-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1543478918-13883-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing MODULE_AUTHOR of ave driver and an entry to MAINTAINERS.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 MAINTAINERS                              | 7 +++++++
 drivers/net/ethernet/socionext/sni_ave.c | 1 +
 2 files changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 380e43f..0bbab10 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13824,6 +13824,13 @@ F:	drivers/md/raid*
 F:	include/linux/raid/
 F:	include/uapi/linux/raid/
 
+SOCIONEXT (SNI) AVE NETWORK DRIVER
+M:	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	drivers/net/ethernet/socionext/sni_ave.c
+F:	Documentation/devicetree/bindings/net/socionext,uniphier-ave4.txt
+
 SOCIONEXT (SNI) NETSEC NETWORK DRIVER
 M:	Jassi Brar <jaswinder.singh@linaro.org>
 L:	netdev@vger.kernel.org
diff --git a/drivers/net/ethernet/socionext/sni_ave.c b/drivers/net/ethernet/socionext/sni_ave.c
index 6710151..2c66c0e 100644
--- a/drivers/net/ethernet/socionext/sni_ave.c
+++ b/drivers/net/ethernet/socionext/sni_ave.c
@@ -1974,5 +1974,6 @@ static struct platform_driver ave_driver = {
 };
 module_platform_driver(ave_driver);
 
+MODULE_AUTHOR("Kunihiko Hayashi <hayashi.kunihiko@socionext.com>");
 MODULE_DESCRIPTION("Socionext UniPhier AVE ethernet driver");
 MODULE_LICENSE("GPL v2");
-- 
2.7.4

