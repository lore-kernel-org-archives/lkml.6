Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752825AbeFEXKo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 19:10:44 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38318 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752713AbeFEXKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 19:10:40 -0400
X-Google-Smtp-Source: ADUXVKKANZ8Q6U/lmDv3SHJWiK2aav42+f+P/7/f6vhtw8KGaYR7KDhjcVKXDJWSqufy0UmW/qX5Ow==
From: Marek Vasut <marek.vasut@gmail.com>
X-Google-Original-From: Marek Vasut <marek.vasut+renesas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v4 07/12] mfd: da9063: Add DA9063L type
Date: Wed,  6 Jun 2018 01:10:08 +0200
Message-Id: <20180605231013.1803-7-marek.vasut+renesas@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180605231013.1803-1-marek.vasut+renesas@gmail.com>
References: <20180605231013.1803-1-marek.vasut+renesas@gmail.com>
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
---
 include/linux/mfd/da9063/core.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mfd/da9063/core.h b/include/linux/mfd/da9063/core.h
index 6caf23483e8e..c9b0adfcb068 100644
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
