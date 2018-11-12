Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E22C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA4C22419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="S22mm35P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA4C22419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730289AbeKMENi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 23:13:38 -0500
Received: from m50-133.163.com ([123.125.50.133]:50817 "EHLO m50-133.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727976AbeKMENh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 23:13:37 -0500
X-Greylist: delayed 923 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Nov 2018 23:13:36 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=eNjDgxNxK94FlpUWlU
        xJYqyvAyZnHYY+ffr6ToADmNU=; b=S22mm35Pr3GityhX5e29oD3ZbipylrFnLv
        njZqctVLv5zQ4P8aHCddoUQb78305otyFJRIsC48NK4FQmH8VMI+VXs/Ncebxs75
        ILik6hj98wkHlqIeaNh0X+3ubuTjA2h8ZzHv0XLYROnEZOLY79RpD59yJYzbaLQT
        C9xRxLCQY=
Received: from localhost.localdomain (unknown [221.0.93.75])
        by smtp3 (Coremail) with SMTP id DdGowAAn9rRxwOlbdDskAA--.3624S2;
        Tue, 13 Nov 2018 02:03:37 +0800 (CST)
From:   zoro <long17.cool@163.com>
To:     alexandre.belloni@bootlin.com
Cc:     a.zummo@towertech.it, mark.rutland@arm.com,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, zoro <long17.cool@163.com>
Subject: [PATCH 1/3] dt-bindings: define vendor prefix for whwave, Inc.
Date:   Tue, 13 Nov 2018 02:03:24 +0800
Message-Id: <1542045806-32349-1-git-send-email-long17.cool@163.com>
X-Mailer: git-send-email 1.7.9.5
X-CM-TRANSID: DdGowAAn9rRxwOlbdDskAA--.3624S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF15GryDWF1DJFWUKF45KFg_yoW3Zrb_Xa
        1xA34kZF45tF4Fgw4qyF4xGw1rGr1a9FW8u3Z0q3Z5A3W8Xasxtaykt3yUZrsruF4xua47
        urn3GrZrWrnrKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8XzVUUUUUU==
X-Originating-IP: [221.0.93.75]
X-CM-SenderInfo: 5orqwi2xof00ro6rljoofrz/1tbiVxn8F1etZpvktwAAsx
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


