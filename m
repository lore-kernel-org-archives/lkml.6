Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7B4C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BFFF20A8B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="CMA9DqMf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BFFF20A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbeHVUzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 16:55:43 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:42934 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbeHVUzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 16:55:43 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alex Smith <alex@alex-smith.me.uk>
Cc:     od@zcrc.me, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/4] dt-bindings: memory: jz4780-nemc: Add compatible string for JZ4725B
Date:   Wed, 22 Aug 2018 19:29:50 +0200
Message-Id: <20180822172953.11281-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1534958995; bh=oKoxQmI+td0MHXpY4cTloQmktiTku/GiPqWMsS7ioVw=; h=From:To:Cc:Subject:Date:Message-Id; b=CMA9DqMfmw/0HFX19PtWuh9oZQy09ummRlMksQuvWgel2HBgKnuKJsRG6IGjYnzcxDBJewsG5rUN3wm8oet1BMsnfoNCk/WPkT7Pz6ZAjnkE8lquugUVjhzeItOzSw7KHEcPeLV+g9O9wMYQx1oDSmcoj6gNwnIO2Ajkc+FH4yQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The jz4780-nemc driver was modified to be compatible with the JZ4725B
SoC.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 .../bindings/memory-controllers/ingenic,jz4780-nemc.txt          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/ingenic,jz4780-nemc.txt b/Documentation/devicetree/bindings/memory-controllers/ingenic,jz4780-nemc.txt
index f936b5589b19..7cce6d761f2d 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ingenic,jz4780-nemc.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/ingenic,jz4780-nemc.txt
@@ -5,6 +5,7 @@ controller in Ingenic JZ4780
 
 Required properties:
 - compatible: Should be set to one of:
+    "ingenic,jz4725b-nemc" (JZ4725B)
     "ingenic,jz4780-nemc" (JZ4780)
 - reg: Should specify the NEMC controller registers location and length.
 - clocks: Clock for the NEMC controller.
-- 
2.18.0

