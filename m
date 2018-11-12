Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB67C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A3421722
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HzXgl9Z0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A3421722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731576AbeKLPwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 10:52:53 -0500
Received: from m50-134.163.com ([123.125.50.134]:37732 "EHLO m50-134.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728269AbeKLPwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 10:52:53 -0500
X-Greylist: delayed 916 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Nov 2018 10:52:51 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=eNjDgxNxK94FlpUWlU
        xJYqyvAyZnHYY+ffr6ToADmNU=; b=HzXgl9Z0h6OsTxEeMitLganH90Vbk45K7h
        M7LanwQZXYyMntXljLgqKxKbOJuu0ZOhr3A0EohfoK2wyZzRuGpINbEkfsMtHr1a
        JgcMPmF/HGchj30f/+owxhUAjfwpuEc+BMQM5IYMVSxi/OjjYWKpzzF5tMqlgB6v
        hwnwhHAaM=
Received: from localhost.localdomain (unknown [221.0.93.75])
        by smtp4 (Coremail) with SMTP id DtGowAAXHkZsE+lb52OQAQ--.34S2;
        Mon, 12 Nov 2018 13:45:38 +0800 (CST)
From:   zoro <long17.cool@163.com>
To:     alexandre.belloni@bootlin.com
Cc:     a.zummo@towertech.it, mark.rutland@arm.com,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, zoro <long17.cool@163.com>
Subject: [PATCH 1/4] dt-bindings: define vendor prefix for whwave, Inc.
Date:   Mon, 12 Nov 2018 13:45:12 +0800
Message-Id: <1542001514-8167-1-git-send-email-long17.cool@163.com>
X-Mailer: git-send-email 1.7.9.5
X-CM-TRANSID: DtGowAAXHkZsE+lb52OQAQ--.34S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF15GryDWF1DJFWUKF45KFg_yoW3Zrb_Xa
        1xA34kZF45tF4Fgw4qyF4xGw1rGr1a9FW8u3Z0q3Z5A3W8Xasxtaykt3yUZrsruF4xua47
        urn3GrZrWrnrKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1FfO3UUUUU==
X-Originating-IP: [221.0.93.75]
X-CM-SenderInfo: 5orqwi2xof00ro6rljoofrz/1tbiVwL8F1etZpUkUAAAsD
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


