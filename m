Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00144C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 07:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986AB20827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 07:45:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 986AB20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbeKFRJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 12:09:38 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:41106 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729160AbeKFRJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 12:09:38 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4047228|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07423;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.DEDP-Va_1541490338;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.DEDP-Va_1541490338)
          by smtp.aliyun-inc.com(10.147.43.230);
          Tue, 06 Nov 2018 15:45:38 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     daniel.lezcano@linaro.org, marc.zyngier@arm.com, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH] MAINTAINERS: add maintainer for C-SKY drivers
Date:   Tue,  6 Nov 2018 15:45:30 +0800
Message-Id: <1541490330-11616-1-git-send-email-ren_guo@c-sky.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two intc drivers and two clocksource drivers, also include
related dt-bindings' documentations.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f485597..fb7286a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3217,6 +3217,11 @@ T:	git https://github.com/c-sky/csky-linux.git
 S:	Supported
 F:	arch/csky/
 F:	Documentation/devicetree/bindings/csky/
+F:	drivers/irqchip/irq-csky-*
+F:	Documentation/devicetree/bindings/interrupt-controller/csky,*
+F:	drivers/clocksource/timer-gx6605s.c
+F:	drivers/clocksource/timer-mp-csky.c
+F:	Documentation/devicetree/bindings/timer/csky,*
 K:	csky
 N:	csky
 
-- 
2.7.4

