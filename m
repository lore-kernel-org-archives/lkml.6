Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052C6C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C3A20842
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549993891;
	bh=NyxhR5dXXzyoh4cqtUxYRU9DEg1XlBZLgGW29D8rAYg=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y0jp8/BCzEkuIwJKR5DH01ibnzUYhdx1sJ2o8KBhpaArxRZOLkxJWAqOQvC3cuqhq
	 GZ1DrNJdC077NvgMnR3Rj76uCOhSa7J0jC81a3bgyu3sxQTj+J1iRYdPGztz3trO8c
	 C5i0MqO1W9zfCVsvs2e9H0NBKLRS5hv2lFGpPsEI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731464AbfBLRva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:51:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:55308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728462AbfBLRvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:51:05 -0500
Received: from localhost.localdomain (unknown [194.230.155.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A5FB222C4;
        Tue, 12 Feb 2019 17:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549993864;
        bh=NyxhR5dXXzyoh4cqtUxYRU9DEg1XlBZLgGW29D8rAYg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PLsKNffXY8xzKrWg74tBL+OiUxN1G0dk0i41czphoNzEENImPHwkx2Rr9QExZcZ+C
         4duOcPE2wEPZeJTOJQEET8/LaRhrj4DFeXqor8v0xiJXBQa3E9+duEcP6ZhgJK4DyC
         FjjxKuzt9mMDpm9VK4cCvp0OFgfapnjn9KNcXBGw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: clock: exynos: Put CLK_UART3 in order
Date:   Tue, 12 Feb 2019 18:50:49 +0100
Message-Id: <20190212175052.6310-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212175052.6310-1-krzk@kernel.org>
References: <20190212175052.6310-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Order the CLK_UART3 by ID.  No change in functionality.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 include/dt-bindings/clock/exynos5410.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/exynos5410.h b/include/dt-bindings/clock/exynos5410.h
index f179eabbcdb7..5b911ede0534 100644
--- a/include/dt-bindings/clock/exynos5410.h
+++ b/include/dt-bindings/clock/exynos5410.h
@@ -36,6 +36,7 @@
 #define CLK_UART0		257
 #define CLK_UART1		258
 #define CLK_UART2		259
+#define CLK_UART3		260
 #define CLK_I2C0		261
 #define CLK_I2C1		262
 #define CLK_I2C2		263
@@ -44,7 +45,6 @@
 #define CLK_USI1		266
 #define CLK_USI2		267
 #define CLK_USI3		268
-#define CLK_UART3		260
 #define CLK_PWM			279
 #define CLK_MCT			315
 #define CLK_WDT			316
-- 
2.17.1

