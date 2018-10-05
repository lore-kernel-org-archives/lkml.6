Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6E4C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 791C520875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 791C520875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbeJEPcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:32:02 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:44012 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728483AbeJEPcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:32:02 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2618827|-1;CH=blue;FP=1111883868519880347|1|1|12|0|-1|-1|-1;HT=e02c03310;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=19;RT=19;SR=0;TI=SMTPD_---.CzfiA7j_1538728416;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CzfiA7j_1538728416)
          by smtp.aliyun-inc.com(10.147.41.231);
          Fri, 05 Oct 2018 16:33:36 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     akpm@linux-foundation.org, arnd@arndb.de,
        daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org,
        robh+dt@kernel.org, tglx@linutronix.de
Cc:     green.hu@gmail.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, devicetree@vger.kernel.org,
        c-sky_gcc_upstream@c-sky.com, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V7 20/20] MAINTAINERS: Add csky
Date:   Fri,  5 Oct 2018 16:33:16 +0800
Message-Id: <1f700f59aeec8d1e09b967bc3fe7271c00a9a3e9.1538715563.git.ren_guo@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <994158389acaf01d065bf1460eb51b3b7249bd07.1538715563.git.ren_guo@c-sky.com>
References: <994158389acaf01d065bf1460eb51b3b7249bd07.1538715563.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1538715563.git.ren_guo@c-sky.com>
References: <cover.1538715563.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a maintainer information for the csky(C-SKY) architecture.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d870cb5..9dac20e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3211,6 +3211,15 @@ T:	git git://git.alsa-project.org/alsa-kernel.git
 S:	Maintained
 F:	sound/pci/oxygen/
 
+C-SKY ARCHITECTURE
+M:	Guo Ren <ren_guo@c-sky.com>
+T:	git https://github.com/c-sky/csky-linux.git
+S:	Supported
+F:	arch/csky/
+F:	Documentation/devicetree/bindings/csky/
+K:	csky
+N:	csky
+
 C6X ARCHITECTURE
 M:	Mark Salter <msalter@redhat.com>
 M:	Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
-- 
2.7.4

