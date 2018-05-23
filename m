Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754088AbeEWGn3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 02:43:29 -0400
Received: from regular1.263xmail.com ([211.150.99.132]:38575 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753985AbeEWGnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 02:43:25 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: zhangqing@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: zhangqing@rock-chips.com
X-UNIQUE-TAG: <eb61fb999325c9e9068c5c0fed640709>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Elaine Zhang <zhangqing@rock-chips.com>
To: heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, rjw@rjwysocki.net, khilman@kernel.org,
        ulf.hansson@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        wxt@rock-chips.com, xxx@rock-chips.com, xf@rock-chips.com,
        huangtao@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v3 01/13] dt-bindings: power: add RK3036 SoCs header for power-domain
Date: Wed, 23 May 2018 14:48:37 +0800
Message-Id: <1527058129-10260-2-git-send-email-zhangqing@rock-chips.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527058129-10260-1-git-send-email-zhangqing@rock-chips.com>
References: <1527058129-10260-1-git-send-email-zhangqing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Caesar Wang <wxt@rock-chips.com>

According to a description from TRM, add all the power domains.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 include/dt-bindings/power/rk3036-power.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 include/dt-bindings/power/rk3036-power.h

diff --git a/include/dt-bindings/power/rk3036-power.h b/include/dt-bindings/power/rk3036-power.h
new file mode 100644
index 000000000000..0bc6b5d5075e
--- /dev/null
+++ b/include/dt-bindings/power/rk3036-power.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DT_BINDINGS_POWER_RK3036_POWER_H__
+#define __DT_BINDINGS_POWER_RK3036_POWER_H__
+
+#define RK3036_PD_MSCH		0
+#define RK3036_PD_CORE		1
+#define RK3036_PD_PERI		2
+#define RK3036_PD_VIO		3
+#define RK3036_PD_VPU		4
+#define RK3036_PD_GPU		5
+#define RK3036_PD_SYS		6
+
+#endif
-- 
1.9.1
