Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C0EC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F9C21976
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArfnOegC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00F9C21976
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390102AbeHGS3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 14:29:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:50736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389018AbeHGS3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 14:29:20 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 916222198F;
        Tue,  7 Aug 2018 16:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533658459;
        bh=UWIMPARWjXuko9U89CPeO2mjr3Kvp8ai9qzM0U0hbFw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ArfnOegCuqMeSoV6B3vg36Z+oLJo/buDn3o5he5s6hHt+cuq6gORpDtmrvicf07S+
         Kk3WO38nOluRwWCQw/nzvHQiAu3aAtaFMoJSBz0Uij7PUnyItV89+NTZ1F5O7WKiWl
         R+PBGsfdPm//OuUrTqVVGwxcxmZbkZobDoxzC068=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sangbeom Kim <sbkim73@samsung.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH 3/4] mfd: sec-core: Fix indentation of Kconfig description
Date:   Tue,  7 Aug 2018 18:11:24 +0200
Message-Id: <20180807161125.18155-3-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180807161125.18155-1-krzk@kernel.org>
References: <20180807161125.18155-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The indentation should be a tab followed by two spaces.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mfd/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index f3fa516011ec..5810e6ff81f7 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1029,10 +1029,10 @@ config MFD_SEC_CORE
 	select REGMAP_I2C
 	select REGMAP_IRQ
 	help
-	 Support for the Samsung Electronics MFD series.
-	 This driver provides common support for accessing the device,
-	 additional drivers must be enabled in order to use the functionality
-	 of the device
+	  Support for the Samsung Electronics MFD series.
+	  This driver provides common support for accessing the device,
+	  additional drivers must be enabled in order to use the functionality
+	  of the device
 
 config MFD_SI476X_CORE
 	tristate "Silicon Laboratories 4761/64/68 AM/FM radio."
-- 
2.14.1

