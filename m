Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C95CECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2DF320877
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2DF320877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbeISMgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 08:36:44 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40081 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727605AbeISMgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 08:36:44 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8DBB420798; Wed, 19 Sep 2018 09:00:11 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5616D20719;
        Wed, 19 Sep 2018 09:00:01 +0200 (CEST)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     arm@kernel.org, antoine.tenart@bootlin.com,
        tsahee@annapurnalabs.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: update the Annapurna Labs maintainer email
Date:   Wed, 19 Sep 2018 08:58:02 +0200
Message-Id: <20180919065802.18846-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free Electrons became Bootlin. Update my email accordingly.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ece30f15777..b63f3683d485 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1251,7 +1251,7 @@ N:	meson
 
 ARM/Annapurna Labs ALPINE ARCHITECTURE
 M:	Tsahee Zidenberg <tsahee@annapurnalabs.com>
-M:	Antoine Tenart <antoine.tenart@free-electrons.com>
+M:	Antoine Tenart <antoine.tenart@bootlin.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-alpine/
-- 
2.17.1

