Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6B6C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 00:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 481892174E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 00:52:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 481892174E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbeI1HNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 03:13:35 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:59188 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726091AbeI1HNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 03:13:35 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2730789|-1;CH=blue;FP=3405870843719145107|1|1|12|0|-1|-1|-1;HT=e02c03306;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.CwkTG9O_1538095941;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CwkTG9O_1538095941)
          by smtp.aliyun-inc.com(10.147.40.200);
          Fri, 28 Sep 2018 08:52:21 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     akpm@linux-foundation.org, arnd@arndb.de,
        daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org,
        robh+dt@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        devicetree@vger.kernel.org, green.hu@gmail.com,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V6 26/33] MAINTAINERS: Add csky
Date:   Fri, 28 Sep 2018 08:51:23 +0800
Message-Id: <64738b50aea8b964e36550ec62fad0139ac5f0d7.1538058840.git.ren_guo@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <62098e7d0a7fbdd09f44d7e23333dad258a01bd2.1538058840.git.ren_guo@c-sky.com>
References: <62098e7d0a7fbdd09f44d7e23333dad258a01bd2.1538058840.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1538058840.git.ren_guo@c-sky.com>
References: <cover.1538058840.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a maintainer information for the csky(C-SKY) architecture.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 MAINTAINERS | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d870cb5..6b7c1be 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3211,6 +3211,22 @@ T:	git git://git.alsa-project.org/alsa-kernel.git
 S:	Maintained
 F:	sound/pci/oxygen/
 
+C-SKY ARCHITECTURE
+M:	Guo Ren <ren_guo@c-sky.com>
+T:	git https://github.com/c-sky/csky-linux.git
+S:	Supported
+F:	arch/csky/
+F:	Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
+F:	drivers/irqchip/irq-csky-mpintc.c
+F:	Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
+F:	drivers/irqchip/irq-csky-apb-intc.c
+F:	Documentation/devicetree/bindings/timer/csky,mptimer.txt
+F:	drivers/clocksource/csky_mptimer.c
+F:	Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt
+F:	drivers/clocksource/timer-gx6605s.c
+K:	csky
+N:	csky
+
 C6X ARCHITECTURE
 M:	Mark Salter <msalter@redhat.com>
 M:	Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
-- 
2.7.4

