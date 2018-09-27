Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20989C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D061721582
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nng9vfb1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D061721582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbeI0XYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:24:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:56030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbeI0XYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:24:00 -0400
Received: from localhost.localdomain (unknown [178.38.103.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 355AE21564;
        Thu, 27 Sep 2018 17:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538067887;
        bh=iTEQoqo6Kp+c2VPx9OCpMFIitifui7n3tLhcvyrhke8=;
        h=From:To:Subject:Date:From;
        b=nng9vfb1zSPZkowHNHvNAOSCVoNBr2ufb4Xn3rKaZ3nfV+cLJ4DGppIt4iyFn3HXc
         9mqnMhyCngumjhkxpluh/vfX/TtGZkThtD/1jlmbF6C4G7DnVJHGKZ7srYGHuLR147
         dNu6m0Ev7tdwA4/Tyh3YYZPztK3/BxxfJDSJEb50=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [RESEND] dt-bindings: thermal: samsung: Add SPDX license identifier
Date:   Thu, 27 Sep 2018 19:04:40 +0200
Message-Id: <20180927170440.12985-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace GPL license statement with SPDX license identifier (GPL-2.0+).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

We postponed this patch because in previous discussion [1] Bartlomiej
expressed willingness to change the license... which did not happen
since July 2018.  In such case let's take this.

[1] https://patchwork.kernel.org/patch/10533191/
---
 include/dt-bindings/thermal/thermal_exynos.h | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/include/dt-bindings/thermal/thermal_exynos.h b/include/dt-bindings/thermal/thermal_exynos.h
index 0646500bca69..642e4e7f4084 100644
--- a/include/dt-bindings/thermal/thermal_exynos.h
+++ b/include/dt-bindings/thermal/thermal_exynos.h
@@ -1,19 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * thermal_exynos.h - Samsung EXYNOS TMU device tree definitions
  *
  *  Copyright (C) 2014 Samsung Electronics
  *  Lukasz Majewski <l.majewski@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
  */
 
 #ifndef _EXYNOS_THERMAL_TMU_DT_H
-- 
2.17.1

