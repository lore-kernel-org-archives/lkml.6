Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAB1C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 20:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 321A620821
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 20:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="IUP1CQdY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfBCUNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 15:13:34 -0500
Received: from mout01.posteo.de ([185.67.36.65]:54230 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbfBCUNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 15:13:34 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 06BEF16005F
        for <linux-kernel@vger.kernel.org>; Sun,  3 Feb 2019 21:13:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1549224812; bh=HLhtPbdxNBMblezpVEklFWq8I9KVAzSbfbExthvu8SU=;
        h=Subject:From:To:Cc:Date:From;
        b=IUP1CQdYhgs/UqgdA/5i1NhMR8dqQjrfo8HfM7A8kYRoYFihqOEmGR7VJm/PrNluK
         fzeB71NUpKB4OrQ3EvhFkUOQCVs8CazDuyANRuSXm8ChK0ANU1rsntBnahg3N5Yrvv
         +pPfFEHlBJ+WUZQhO69CdbihMq5X8FIyvfxgpia03D8PTkjmUeurxkHT9K1GofWX06
         I3HRuzCOa+WSUM3oys1vxFaebaaEHaC8vXndMSzvStvafay0JhT0ZTPKryiF5oX/Pr
         0KXJEPYvvgFFfIWnNYqPeBML+i4wnVYo/1//j+IJ6Hi38StcjHC3q6t0ZC1S8VqYb5
         28U7k/AhfIOaA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 43t28q2J1fz6tm6;
        Sun,  3 Feb 2019 21:13:31 +0100 (CET)
Message-ID: <bb0903e066484e02f5dcd0e9cbe94a491a179fba.camel@posteo.de>
Subject: [PATCH] ARM: dts: exynos: Fix spelling mistake of EXYNOS5420
From:   Benjamin Drung <bdrung@posteo.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 03 Feb 2019 21:13:30 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SoC name EXYNOS5420 was misspelled.

Signed-off-by: Benjamin Drung <bdrung@posteo.de>
---
 arch/arm/boot/dts/exynos5420.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index aaff15880761..5fb2326875dc 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -5,7 +5,7 @@
  * Copyright (c) 2013 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
- * SAMSUNG EXYNOS54200 SoC device nodes are listed in this file.
+ * SAMSUNG EXYNOS5420 SoC device nodes are listed in this file.
  * EXYNOS5420 based board files can include this file and provide
  * values for board specfic bindings.
  */
-- 
2.19.1

