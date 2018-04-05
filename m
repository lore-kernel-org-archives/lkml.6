Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751705AbeDEQRI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 12:17:08 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54699 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751352AbeDEQQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 12:16:57 -0400
X-Google-Smtp-Source: AIpwx48NCyMzmlq4urabV8OFpGKket2S8FpGfR6oCuOAbCV7mFnrYrbsaqCKRmP6Fy7CrKs05ogMfA==
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: viresh.kumar@linaro.org, edubezval@gmail.com
Cc: kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        javi.merino@kernel.org, rui.zhang@intel.com,
        daniel.thompson@linaro.org, linux-pm@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>
Subject: [PATCH v3 1/7] thermal/drivers/cpu_cooling: Fixup the header and copyright
Date: Thu,  5 Apr 2018 18:16:38 +0200
Message-Id: <1522945005-7165-2-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522945005-7165-1-git-send-email-daniel.lezcano@linaro.org>
References: <1522945005-7165-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The copyright format does not conform to the format requested by
Linaro: https://wiki.linaro.org/Copyright

Fix it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index dc63aba..42110ee 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -2,9 +2,11 @@
  *  linux/drivers/thermal/cpu_cooling.c
  *
  *  Copyright (C) 2012	Samsung Electronics Co., Ltd(http://www.samsung.com)
- *  Copyright (C) 2012  Amit Daniel <amit.kachhap@linaro.org>
  *
- *  Copyright (C) 2014  Viresh Kumar <viresh.kumar@linaro.org>
+ *  Copyright (C) 2012-2018 Linaro Limited.
+ *
+ *  Authors:	Amit Daniel <amit.kachhap@linaro.org>
+ *		Viresh Kumar <viresh.kumar@linaro.org>
  *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *  This program is free software; you can redistribute it and/or modify
-- 
2.7.4
