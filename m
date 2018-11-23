Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AC3C43610
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62AE620861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pIZMQdmx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62AE620861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409292AbeKWU7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:59:13 -0500
Received: from m50-133.163.com ([123.125.50.133]:45132 "EHLO m50-133.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409165AbeKWU7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:59:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=eNjDgxNxK94FlpUWlU
        xJYqyvAyZnHYY+ffr6ToADmNU=; b=pIZMQdmxQN+fkHQ+1IEl1H4+CSwvV+tF4B
        P5dOq8iEzwnEWQg+ZLAd1tpx3SctQ6Nn+y7yHq7CIzIbs2CXD+Im7khXbPV2EFGJ
        46f94SvnlOg9Zap7IaIrFq6GslbEqXx6XKDuUBZLHhnFPBL7XC0OQwV25PgnAwjT
        tXyXSlx6o=
Received: from localhost.localdomain (unknown [221.0.93.75])
        by smtp3 (Coremail) with SMTP id DdGowACHQbYM0_dbILFRAA--.19S2;
        Fri, 23 Nov 2018 18:15:05 +0800 (CST)
From:   zoro <long17.cool@163.com>
To:     alexandre.belloni@bootlin.com
Cc:     a.zummo@towertech.it, robh@kernel.org, mark.rutland@arm.com,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, zoro <long17.cool@163.com>
Subject: [PATCH 1/3] dt-bindings: define vendor prefix for whwave, Inc.
Date:   Fri, 23 Nov 2018 18:14:42 +0800
Message-Id: <1542968084-3982-1-git-send-email-long17.cool@163.com>
X-Mailer: git-send-email 1.7.9.5
X-CM-TRANSID: DdGowACHQbYM0_dbILFRAA--.19S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF15GryDWF1DJFWUKF45KFg_yoW3Zrb_Xa
        1xA34kZF45tF4Fgw4qyF4xGw1rGr1a9FW8u3Z0q3Z5A3W8Xasxtaykt3yUZrsruF4xua47
        urn3GrZrWrnrKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1cAw3UUUUU==
X-Originating-IP: [221.0.93.75]
X-CM-SenderInfo: 5orqwi2xof00ro6rljoofrz/1tbiPQkIF1SIZCQd6gAAsA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce vendor prefix for whwave, Inc.
for SD3078 rtc device.

Signed-off-by: zoro <long17.cool@163.com>
---
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 4b1a2a8..7d2e9b01 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -423,6 +423,7 @@ vot	Vision Optical Technology Co., Ltd.
 wd	Western Digital Corp.
 wetek	WeTek Electronics, limited.
 wexler	Wexler
+whwave	Shenzhen whwave Electronics crop
 wi2wi	Wi2Wi, Inc.
 winbond Winbond Electronics corp.
 winstar	Winstar Display Corp.
-- 
1.7.9.5


