Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE8FC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107822086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:04:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 107822086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbeJLRgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 13:36:19 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:56272 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726917AbeJLRgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 13:36:18 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.7447944|0.7713539;BR=01201311R131ec;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03276;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=17;RT=17;SR=0;TI=SMTPD_---.D13UTFm_1539338646;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.D13UTFm_1539338646)
          by smtp.aliyun-inc.com(10.147.41.199);
          Fri, 12 Oct 2018 18:04:06 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     akpm@linux-foundation.org, arnd@arndb.de,
        daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, hch@infradead.org,
        marc.zyngier@arm.com, mark.rutland@arm.com, peterz@infradead.org,
        robh@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        c-sky_gcc_upstream@c-sky.com, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V8 19/21] dt-bindings: Add vendor prefix for csky
Date:   Fri, 12 Oct 2018 12:42:54 +0800
Message-Id: <64488ca37a3dcb9b040aebebb80d4ca261c0203d.1539315391.git.ren_guo@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1539315390.git.ren_guo@c-sky.com>
References: <cover.1539315390.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1539315390.git.ren_guo@c-sky.com>
References: <cover.1539315390.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add csky vendor definition.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 2c3fc51..a728ee3 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -84,6 +84,7 @@ cosmic	Cosmic Circuits
 crane	Crane Connectivity Solutions
 creative	Creative Technology Ltd
 crystalfontz	Crystalfontz America, Inc.
+csky	Hangzhou C-SKY Microsystems Co., Ltd
 cubietech	Cubietech, Ltd.
 cypress	Cypress Semiconductor Corporation
 cznic	CZ.NIC, z.s.p.o.
-- 
2.7.4

