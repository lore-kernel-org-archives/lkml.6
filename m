Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752583AbeEQSEN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 14:04:13 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:42054 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751984AbeEQSBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 14:01:14 -0400
X-Google-Smtp-Source: AB8JxZqK02wpWViWME+OxOSQPzv/apjndludYQhntTH6C7S8ZNYaMv1UvuysqcfmEyUrhyHPxV0+Ow==
From: Dmitry Osipenko <digetx@gmail.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH v1 01/11] cpufreq: tegra20: Change module description
Date: Thu, 17 May 2018 21:00:46 +0300
Message-Id: <20180517180056.13336-2-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180517180056.13336-1-digetx@gmail.com>
References: <20180517180056.13336-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change module description to be in line with the other Tegra drivers, just
for consistency.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/cpufreq/tegra20-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
index 2bd62845e9d5..10793498355e 100644
--- a/drivers/cpufreq/tegra20-cpufreq.c
+++ b/drivers/cpufreq/tegra20-cpufreq.c
@@ -210,7 +210,7 @@ static void __exit tegra_cpufreq_exit(void)
 
 
 MODULE_AUTHOR("Colin Cross <ccross@android.com>");
-MODULE_DESCRIPTION("cpufreq driver for Nvidia Tegra2");
+MODULE_DESCRIPTION("NVIDIA Tegra20 cpufreq driver");
 MODULE_LICENSE("GPL");
 module_init(tegra_cpufreq_init);
 module_exit(tegra_cpufreq_exit);
-- 
2.17.0
