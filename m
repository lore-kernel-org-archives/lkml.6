Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938405AbeBUPbX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 10:31:23 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38540 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935044AbeBUP3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 10:29:43 -0500
X-Google-Smtp-Source: AH8x227GKhCB+jOX6dH6bHDTUyI+yMdHlaWdGCXpQzl3FmR/ti98vJN9aukIrMB3SWGHLnee+0W1Qg==
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: edubezval@gmail.com
Cc: kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, amit.kachhap@gmail.com,
        linux-kernel@vger.kernel.org, javi.merino@kernel.org,
        rui.zhang@intel.com, daniel.thompson@linaro.org,
        linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
        Philippe Ombredanne <pombredanne@nexb.com>
Subject: [PATCH V2 2/7] thermal/drivers/cpu_cooling: Add Software Package Data Exchange (SPDX)
Date: Wed, 21 Feb 2018 16:29:23 +0100
Message-Id: <1519226968-19821-3-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519226968-19821-1-git-send-email-daniel.lezcano@linaro.org>
References: <1519226968-19821-1-git-send-email-daniel.lezcano@linaro.org>
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
