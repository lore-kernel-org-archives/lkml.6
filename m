Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9Qa84sa"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B81D260767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932683AbeFFKBm (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 06:01:42 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54868 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932576AbeFFKAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 06:00:32 -0400
X-Google-Smtp-Source: ADUXVKKo8hpHRNQHm+yx+bUjbhJZjL/C5JdXBorJcwNGcZm35+gxwjr3PaR8kmXtFYYi5TxNXx3zjg==
From: Marek Vasut <marek.vasut@gmail.com>
X-Google-Original-From: Marek Vasut <marek.vasut+renesas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v5 09/14] mfd: da9063: Add DA9063L type
Date: Wed,  6 Jun 2018 11:59:58 +0200
Message-Id: <20180606100003.17067-9-marek.vasut+renesas@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180606100003.17067-1-marek.vasut+renesas@gmail.com>
References: <20180606100003.17067-1-marek.vasut+renesas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add type for DA9063L, which is a reduced variant of the DA9063
without RTC block and with less regulators.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
---
V2: No change
V3: No change
V4: No change
V5: No change
---
 include/linux/mfd/da9063/core.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mfd/da9063/core.h b/include/linux/mfd/da9063/core.h
index 9e36097adc42..71b09154e2db 100644
--- a/include/linux/mfd/da9063/core.h
+++ b/include/linux/mfd/da9063/core.h
@@ -33,6 +33,7 @@
 
 enum da9063_type {
 	PMIC_TYPE_DA9063 = 0,
+	PMIC_TYPE_DA9063L,
 };
 
 enum da9063_variant_codes {
-- 
2.16.2
