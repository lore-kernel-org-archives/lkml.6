Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752490AbeEKD3d (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 23:29:33 -0400
Received: from regular1.263xmail.com ([211.150.99.130]:42919 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752096AbeEKD3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 23:29:32 -0400
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
X-UNIQUE-TAG: <712d2e19563ed0501acbe5f5e1ef8e9e>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Elaine Zhang <zhangqing@rock-chips.com>
To: heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, rjw@rjwysocki.net, khilman@kernel.org,
        ulf.hansson@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        wxt@rock-chips.com, xxx@rock-chips.com, xf@rock-chips.com,
        huangtao@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>
Subject: [PATCH v1 12/13] dt-bindings: add binding for px30 power domains
Date: Fri, 11 May 2018 11:34:46 +0800
Message-Id: <1526009686-5790-1-git-send-email-zhangqing@rock-chips.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526009458-28579-1-git-send-email-zhangqing@rock-chips.com>
References: <1526009458-28579-1-git-send-email-zhangqing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for the power domains
found on Rockchip PX30 SoCs.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
---
 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt b/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
index affe36dcfa17..5d49d0a2ff29 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
+++ b/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
@@ -5,6 +5,7 @@ powered up/down by software based on different application scenes to save power.
 
 Required properties for power domain controller:
 - compatible: Should be one of the following.
+	"rockchip,px30-power-controller" - for PX30 SoCs.
 	"rockchip,rk3036-power-controller" - for RK3036 SoCs.
 	"rockchip,rk3128-power-controller" - for RK3128 SoCs.
 	"rockchip,rk3228-power-controller" - for RK3228 SoCs.
@@ -20,6 +21,7 @@ Required properties for power domain controller:
 
 Required properties for power domain sub nodes:
 - reg: index of the power domain, should use macros in:
+	"include/dt-bindings/power/px30-power.h" - for PX30 type power domain.
 	"include/dt-bindings/power/rk3036-power.h" - for RK3036 type power domain.
 	"include/dt-bindings/power/rk3128-power.h" - for RK3128 type power domain.
 	"include/dt-bindings/power/rk3228-power.h" - for RK3228 type power domain.
@@ -99,6 +101,7 @@ Node of a device using power domains must have a power-domains property,
 containing a phandle to the power device node and an index specifying which
 power domain to use.
 The index should use macros in:
+	"include/dt-bindings/power/px30-power.h" - for px30 type power domain.
 	"include/dt-bindings/power/rk3036-power.h" - for rk3036 type power domain.
 	"include/dt-bindings/power/rk3128-power.h" - for rk3128 type power domain.
 	"include/dt-bindings/power/rk3128-power.h" - for rk3228 type power domain.
-- 
1.9.1
