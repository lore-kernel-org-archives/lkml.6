Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752450AbeERUHf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 16:07:35 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:45125 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752296AbeERUHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 16:07:21 -0400
X-Google-Smtp-Source: AB8JxZp0SmsXLHxYWstg5mfREwdIWXvY5CpKjTJPpaDezEx+SYLkG+ypMb2r2Vu89owZsslJZJMliw==
From: Dmitry Osipenko <digetx@gmail.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH v2 03/11] cpufreq: tegra20: Clean up included headers
Date: Fri, 18 May 2018 23:06:34 +0300
Message-Id: <20180518200642.24815-4-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518200642.24815-1-digetx@gmail.com>
References: <20180518200642.24815-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused/unneeded headers and sort them in the alphabet order.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/cpufreq/tegra20-cpufreq.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
index dd8a76a64a8e..bec1a50a8138 100644
--- a/drivers/cpufreq/tegra20-cpufreq.c
+++ b/drivers/cpufreq/tegra20-cpufreq.c
@@ -16,16 +16,12 @@
  *
  */
 
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/sched.h>
+#include <linux/clk.h>
 #include <linux/cpufreq.h>
-#include <linux/delay.h>
-#include <linux/init.h>
 #include <linux/err.h>
-#include <linux/clk.h>
-#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/types.h>
 
 static struct cpufreq_frequency_table freq_table[] = {
 	{ .frequency = 216000 },
-- 
2.17.0
