Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751616AbeDEQRH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 12:17:07 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34025 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751179AbeDEQQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 12:16:59 -0400
X-Google-Smtp-Source: AIpwx4/qm/ezeAInSogvDTpnQX8oYk7/TE/3/DZ2pFRyyNkWw5oeS/0b/87Ms0tt+RcHJdsBYj14Mw==
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: viresh.kumar@linaro.org, edubezval@gmail.com
Cc: kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        javi.merino@kernel.org, rui.zhang@intel.com,
        daniel.thompson@linaro.org, linux-pm@vger.kernel.org,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>
Subject: [PATCH v3 2/7] thermal/drivers/cpu_cooling: Add Software Package Data Exchange (SPDX)
Date: Thu,  5 Apr 2018 18:16:39 +0200
Message-Id: <1522945005-7165-3-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522945005-7165-1-git-send-email-daniel.lezcano@linaro.org>
References: <1522945005-7165-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For license auditing purpose, let's add the SPDX tag.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Philippe Ombredanne <pombredanne@nexb.com>
---
 drivers/thermal/cpu_cooling.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 42110ee..d7528bc 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  linux/drivers/thermal/cpu_cooling.c
  *
@@ -8,21 +9,6 @@
  *  Authors:	Amit Daniel <amit.kachhap@linaro.org>
  *		Viresh Kumar <viresh.kumar@linaro.org>
  *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; version 2 of the License.
- *
- *  This program is distributed in the hope that it will be useful, but
- *  WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 #include <linux/module.h>
 #include <linux/thermal.h>
-- 
2.7.4
