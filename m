Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752595AbeERUKe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 16:10:34 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35550 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752234AbeERUHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 16:07:20 -0400
X-Google-Smtp-Source: AB8JxZrY9VBTgGOGpIuuXUx4PuR4Cnn7H1RgTB6Om3BsUn148P+lFv0/qF0fnvbgn0vXUiqIDyWlLQ==
From: Dmitry Osipenko <digetx@gmail.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH v2 02/11] cpufreq: tegra20: Clean up whitespaces in the code
Date: Fri, 18 May 2018 23:06:33 +0300
Message-Id: <20180518200642.24815-3-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518200642.24815-1-digetx@gmail.com>
References: <20180518200642.24815-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded blank line and replace whitespaces with a tab in the code
for consistency.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/cpufreq/tegra20-cpufreq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
index 10793498355e..dd8a76a64a8e 100644
--- a/drivers/cpufreq/tegra20-cpufreq.c
+++ b/drivers/cpufreq/tegra20-cpufreq.c
@@ -203,12 +203,11 @@ static int __init tegra_cpufreq_init(void)
 
 static void __exit tegra_cpufreq_exit(void)
 {
-        cpufreq_unregister_driver(&tegra_cpufreq_driver);
+	cpufreq_unregister_driver(&tegra_cpufreq_driver);
 	clk_put(emc_clk);
 	clk_put(cpu_clk);
 }
 
-
 MODULE_AUTHOR("Colin Cross <ccross@android.com>");
 MODULE_DESCRIPTION("NVIDIA Tegra20 cpufreq driver");
 MODULE_LICENSE("GPL");
-- 
2.17.0
