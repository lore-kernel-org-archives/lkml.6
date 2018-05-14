Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752177AbeENDXO (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 23:23:14 -0400
Received: from regular1.263xmail.com ([211.150.99.132]:54717 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751953AbeENDXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 23:23:12 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-IP-DOMAINF: 1
X-RL-SENDER: zhangqing@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: zhangqing@rock-chips.com
X-UNIQUE-TAG: <b92a870d5b3b2ef3f3620f11759d40d9>
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
Subject: [PATCH v2 01/13] dt-bindings: power: add RK3036 SoCs header for power-domain
Date: Mon, 14 May 2018 11:28:21 +0800
Message-Id: <1526268501-9200-1-git-send-email-zhangqing@rock-chips.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526268455-9133-1-git-send-email-zhangqing@rock-chips.com>
References: <1526268455-9133-1-git-send-email-zhangqing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Caesar Wang <wxt@rock-chips.com>

According to a description from TRM, add all the power domains.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 include/dt-bindings/power/rk3036-power.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 include/dt-bindings/power/rk3036-power.h

diff --git a/include/dt-bindings/power/rk3036-power.h b/include/dt-bindings/power/rk3036-power.h
new file mode 100644
index 000000000000..59e09f1c5af7
--- /dev/null
+++ b/include/dt-bindings/power/rk3036-power.h
@@ -0,0 +1,27 @@
+/*
+ * Copyright (c) 2017 Rockchip Electronics Co. Ltd.
+ * Author: Caesar Wang <wxt@rock-chips.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
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
