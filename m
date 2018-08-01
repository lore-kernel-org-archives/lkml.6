Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10379C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFED9208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cz8y1tzA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFED9208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbeHAV5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 17:57:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:35844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727679AbeHAV5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 17:57:30 -0400
Received: from thinkpad.chello.pl (89-70-51-62.dynamic.chello.pl [89.70.51.62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82DD1208A3;
        Wed,  1 Aug 2018 20:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533154201;
        bh=LMaKiizpXhbMxl2KpWt/AjaZOs9G6+4XJGBv+t2YzMo=;
        h=From:To:Cc:Subject:Date:From;
        b=cz8y1tzA3Ewof5R3F0T1TcHmFEGUu1f0aPA+QtkQVtd9deAq8tHJ8kReG/u0Tcqrh
         5xtfErWnP6esJleVZfm+yLZmx41JpJY08Ns9l8KZShSeBHgKZIYKD2936pzSfq7Kv2
         L0UdlHC31au9g3F2KLHAYcCviqh4XT83OzPcI+pk=
From:   snawrocki@kernel.org
To:     broonie@kernel.org
Cc:     sboyd@kernel.org, mchehab@kernel.org, krzk@kernel.org,
        m.szyprowski@samsung.com, linux-kernel@vger.kernel.org,
        cw00.choi@samsung.com, bzolnierkie@samsung.com,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH] MAINTAINERS: Update my e-mail address
Date:   Wed,  1 Aug 2018 22:09:49 +0200
Message-Id: <1533154189-23311-1-git-send-email-snawrocki@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sylwester Nawrocki <snawrocki@kernel.org>

I won't have access to my s.nawrocki@samsung.com account for some time
so replace that address with the kernel.org one.
Also a related entry to the .mailmap file is added.

Signed-off-by: Sylwester Nawrocki <snawrocki@kernel.org>
---
 .mailmap    |  1 +
 MAINTAINERS | 14 +++++++-------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/.mailmap b/.mailmap
index 29ddeb1..b8d05a2 100644
--- a/.mailmap
+++ b/.mailmap
@@ -177,6 +177,7 @@ Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
 Subhash Jadavani <subhashj@codeaurora.org>
 Sudeep Holla <sudeep.holla@arm.com> Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
 Sumit Semwal <sumit.semwal@ti.com>
+Sylwester Nawrocki <snawrocki@kernel.org> <s.nawrocki@samsung.com>
 Tejun Heo <htejun@gmail.com>
 Thomas Graf <tgraf@suug.ch>
 Thomas Pedersen <twp@codeaurora.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index 03ab73c..4ccab9d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10520,7 +10520,7 @@ F:	Documentation/devicetree/bindings/media/i2c/ov7740.txt
 OMNIVISION OV9650 SENSOR DRIVER
 M:	Sakari Ailus <sakari.ailus@linux.intel.com>
 R:	Akinobu Mita <akinobu.mita@gmail.com>
-R:	Sylwester Nawrocki <s.nawrocki@samsung.com>
+R:	Sylwester Nawrocki <snawrocki@kernel.org>
 L:	linux-media@vger.kernel.org
 T:	git git://linuxtv.org/media_tree.git
 S:	Maintained
@@ -11290,7 +11290,7 @@ F:	drivers/pinctrl/sh-pfc/
 PIN CONTROLLER - SAMSUNG
 M:	Tomasz Figa <tomasz.figa@gmail.com>
 M:	Krzysztof Kozlowski <krzk@kernel.org>
-M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
+M:	Sylwester Nawrocki <snawrocki@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-samsung-soc@vger.kernel.org (moderated for non-subscribers)
 Q:	https://patchwork.kernel.org/project/linux-samsung-soc/list/
@@ -12460,7 +12460,7 @@ F:	include/media/saa7146*
 SAMSUNG AUDIO (ASoC) DRIVERS
 M:	Krzysztof Kozlowski <krzk@kernel.org>
 M:	Sangbeom Kim <sbkim73@samsung.com>
-M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
+M:	Sylwester Nawrocki <snawrocki@kernel.org>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
 F:	sound/soc/samsung/
@@ -12512,7 +12512,7 @@ F:	Documentation/devicetree/bindings/regulator/samsung,s5m*.txt
 F:	Documentation/devicetree/bindings/clock/samsung,s2mps11.txt
 
 SAMSUNG S3C24XX/S3C64XX SOC SERIES CAMIF DRIVER
-M:	Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
+M:	Sylwester Nawrocki <snawrocki@kernel.org>
 L:	linux-media@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org (moderated for non-subscribers)
 S:	Maintained
@@ -12551,14 +12551,14 @@ F:	drivers/crypto/s5p-sss.c
 
 SAMSUNG S5P/EXYNOS4 SOC SERIES CAMERA SUBSYSTEM DRIVERS
 M:	Kyungmin Park <kyungmin.park@samsung.com>
-M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
+M:	Sylwester Nawrocki <snawrocki@kernel.org>
 L:	linux-media@vger.kernel.org
 Q:	https://patchwork.linuxtv.org/project/linux-media/list/
 S:	Supported
 F:	drivers/media/platform/exynos4-is/
 
 SAMSUNG SOC CLOCK DRIVERS
-M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
+M:	Sylwester Nawrocki <snawrocki@kernel.org>
 M:	Tomasz Figa <tomasz.figa@gmail.com>
 M:	Chanwoo Choi <cw00.choi@samsung.com>
 S:	Supported
@@ -12597,7 +12597,7 @@ F:	drivers/thermal/samsung/
 
 SAMSUNG USB2 PHY DRIVER
 M:	Kamil Debski <kamil@wypas.org>
-M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
+M:	Sylwester Nawrocki <snawrocki@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/phy/samsung-phy.txt
-- 
2.7.4

