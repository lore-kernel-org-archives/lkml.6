Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752509AbeEQSCO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 14:02:14 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43179 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752312AbeEQSBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 14:01:22 -0400
X-Google-Smtp-Source: AB8JxZpaE1SCPQJd6u2Y0iXt1PcItA8Vb7uZRDtaVo9hYvrS8lb1ATAwaL5SKH2ByK+Bw5fyrV0NPA==
From: Dmitry Osipenko <digetx@gmail.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH v1 08/11] cpufreq: tegra20: Remove unneeded variable initialization
Date: Thu, 17 May 2018 21:00:53 +0300
Message-Id: <20180517180056.13336-9-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180517180056.13336-1-digetx@gmail.com>
References: <20180517180056.13336-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded variable initialization solely for consistency.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/cpufreq/tegra20-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
index 797c61c74b65..c0a7b5a78aa6 100644
--- a/drivers/cpufreq/tegra20-cpufreq.c
+++ b/drivers/cpufreq/tegra20-cpufreq.c
@@ -84,7 +84,7 @@ static int tegra_target(struct cpufreq_policy *policy, unsigned int index)
 {
 	unsigned long rate = freq_table[index].frequency;
 	unsigned int ifreq = clk_get_rate(pll_p_clk) / 1000;
-	int ret = 0;
+	int ret;
 
 	/*
 	 * target freq == pll_p, don't need to take extra reference to pll_x_clk
-- 
2.17.0
