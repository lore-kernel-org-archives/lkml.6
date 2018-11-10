Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EB6C0044B
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 08:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E7CF20858
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 08:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dj8481+B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E7CF20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbeKJSlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 13:41:18 -0500
Received: from m50-132.163.com ([123.125.50.132]:37662 "EHLO m50-132.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728766AbeKJSlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 13:41:18 -0500
X-Greylist: delayed 925 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Nov 2018 13:41:17 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=VYMiLmPONxQsftIy7F
        2iJGqQ57x5RPGI4vSw7FbMggE=; b=dj8481+BJKfaVwZI5TZrL71fRyLXC7taXQ
        aa/yq4CPTvHcKp2tEcBf2Qz2buoILbGpDLu5ULMjZwQzn4Hlkcj8MR6UJvu9X4uT
        9r7OkoAqYNJ5MYOGj6Xay9/1H+8TSw/X4pcByEmEKp6ZfiCTgiA1kAG4wKbpQDiK
        F8/sj3H/U=
Received: from localhost.localdomain (unknown [221.0.93.75])
        by smtp2 (Coremail) with SMTP id DNGowAAX70KfmeZbl86zAA--.73S2;
        Sat, 10 Nov 2018 16:41:17 +0800 (CST)
From:   zoro <long17.cool@163.com>
To:     a.zummo@towertech.it
Cc:     alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        zoro <long17.cool@163.com>
Subject: [PATCH 1/3] dt-bindings: define vendor prefix for whwave, Inc.
Date:   Sat, 10 Nov 2018 16:40:59 +0800
Message-Id: <1541839261-28765-1-git-send-email-long17.cool@163.com>
X-Mailer: git-send-email 1.7.9.5
X-CM-TRANSID: DNGowAAX70KfmeZbl86zAA--.73S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF15GryDWF1DJFWUKF45KFg_yoWxKFc_Za
        1xJrWqvw45tF4Fgw4jyF47Gw1rJr1IkrW8u3WYq3Wvy3WfXFZxtayktay5ZF4xWF4xua45
        Zr97GrZrXr17KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbRwZ3UUUUU==
X-Originating-IP: [221.0.93.75]
X-CM-SenderInfo: 5orqwi2xof00ro6rljoofrz/1tbizQ76F1c7DKJepAAAsW
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
index 4b1a2a8..3d59d6a 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -440,3 +440,4 @@ zidoo	Shenzhen Zidoo Technology Co., Ltd.
 zii	Zodiac Inflight Innovations
 zte	ZTE Corp.
 zyxel	ZyXEL Communications Corp.
+whwave	Shenzhen whwave Electronics crop
-- 
1.7.9.5


