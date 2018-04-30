Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754506AbeD3OsI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 10:48:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42856 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754460AbeD3OsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 10:48:06 -0400
From: Colin King <colin.king@canonical.com>
To: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: s3c2440: fix spelling mistake: "divsiors" -> "divisors"
Date: Mon, 30 Apr 2018 15:48:01 +0100
Message-Id: <20180430144801.6727-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in s3c_freq_dbg debug message text.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/cpufreq/s3c2440-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/s3c2440-cpufreq.c b/drivers/cpufreq/s3c2440-cpufreq.c
index d0d75b65ddd6..d2f67b7a20dd 100644
--- a/drivers/cpufreq/s3c2440-cpufreq.c
+++ b/drivers/cpufreq/s3c2440-cpufreq.c
@@ -143,7 +143,7 @@ static void s3c2440_cpufreq_setdivs(struct s3c_cpufreq_config *cfg)
 {
 	unsigned long clkdiv, camdiv;
 
-	s3c_freq_dbg("%s: divsiors: h=%d, p=%d\n", __func__,
+	s3c_freq_dbg("%s: divisors: h=%d, p=%d\n", __func__,
 		     cfg->divs.h_divisor, cfg->divs.p_divisor);
 
 	clkdiv = __raw_readl(S3C2410_CLKDIVN);
-- 
2.17.0
