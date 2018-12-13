Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF38C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2042720989
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VY6J5Oo2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2042720989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbeLMKOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:14:22 -0500
Received: from m50-133.163.com ([123.125.50.133]:57826 "EHLO m50-133.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728207AbeLMKOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 05:14:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=T1JcgVeqmUPxldq7rv
        enuP+gmdiGK4qJoCqXAjKbQYA=; b=VY6J5Oo273gB1Bdvc5iNLGXo7ul/p5u5G6
        KudE08mbQKzjeJHzXrYg6SKU5AHsrGCAzAOt4bBUDY7r9uo9gsIPXsCHPfKqRzHb
        ORnr+iyJn9/b6D6sZTGO08JRHInYzw6NzrZ7ze5g5ekvfAuuNH4Yrsjfaf4YHJ/I
        O+t9eyiK4=
Received: from localhost.localdomain (unknown [221.0.93.75])
        by smtp3 (Coremail) with SMTP id DdGowAD3P+LcMBJcePuXAA--.86S2;
        Thu, 13 Dec 2018 18:13:53 +0800 (CST)
From:   Dianlong Li <long17.cool@163.com>
To:     robh@kernel.org
Cc:     alexandre.belloni@bootlin.com, a.zummo@towertech.it,
        mark.rutland@arm.com, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dianlong Li <long17.cool@163.com>
Subject: [PATCH 1/3] dt-bindings: define vendor prefix for whwave, Inc.
Date:   Thu, 13 Dec 2018 18:13:48 +0800
Message-Id: <1544696030-17159-1-git-send-email-long17.cool@163.com>
X-Mailer: git-send-email 1.7.9.5
X-CM-TRANSID: DdGowAD3P+LcMBJcePuXAA--.86S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr4rKw1UtF4UWw4ktw1fWFg_yoW3ZFg_Xa
        1xA34kZFW5tF4Fgw4qkF4xG345Gr1akFWku3WYq3Z5A3W8WasxtayktayUCr47CF4I9a47
        urn3GrZrXrnrKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1cAw3UUUUU==
X-Originating-IP: [221.0.93.75]
X-CM-SenderInfo: 5orqwi2xof00ro6rljoofrz/1tbiyAEcF1p65N4H+AAAsn
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce vendor prefix for whwave, Inc.
for SD3078 rtc device.

Signed-off-by: Dianlong Li <long17.cool@163.com>
---
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 4b1a2a8..89403c7 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -423,6 +423,7 @@ vot	Vision Optical Technology Co., Ltd.
 wd	Western Digital Corp.
 wetek	WeTek Electronics, limited.
 wexler	Wexler
+whwave  Shenzhen whwave Electronics, Inc.
 wi2wi	Wi2Wi, Inc.
 winbond Winbond Electronics corp.
 winstar	Winstar Display Corp.
-- 
1.7.9.5


