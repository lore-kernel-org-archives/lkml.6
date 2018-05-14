Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752324AbeENDZG (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 23:25:06 -0400
Received: from regular1.263xmail.com ([211.150.99.139]:41495 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752151AbeENDZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 23:25:04 -0400
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
X-UNIQUE-TAG: <89a145d37861abd1f27f0164970335ee>
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
Subject: [PATCH v2 06/13] dt-bindings: add binding for rk3128 power domains
Date: Mon, 14 May 2018 11:30:26 +0800
Message-Id: <1526268626-11855-1-git-send-email-zhangqing@rock-chips.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526268455-9133-1-git-send-email-zhangqing@rock-chips.com>
References: <1526268455-9133-1-git-send-email-zhangqing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for the power domains
found on Rockchip RK3128 SoCs.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt b/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
index 79924ee9ae86..9a3f5fd36a80 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
+++ b/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
@@ -6,6 +6,7 @@ powered up/down by software based on different application scenes to save power.
 Required properties for power domain controller:
 - compatible: Should be one of the following.
 	"rockchip,rk3036-power-controller" - for RK3036 SoCs.
+	"rockchip,rk3128-power-controller" - for RK3128 SoCs.
 	"rockchip,rk3288-power-controller" - for RK3288 SoCs.
 	"rockchip,rk3328-power-controller" - for RK3328 SoCs.
 	"rockchip,rk3366-power-controller" - for RK3366 SoCs.
@@ -19,6 +20,7 @@ Required properties for power domain controller:
 Required properties for power domain sub nodes:
 - reg: index of the power domain, should use macros in:
 	"include/dt-bindings/power/rk3036-power.h" - for RK3036 type power domain.
+	"include/dt-bindings/power/rk3128-power.h" - for RK3128 type power domain.
 	"include/dt-bindings/power/rk3288-power.h" - for RK3288 type power domain.
 	"include/dt-bindings/power/rk3328-power.h" - for RK3328 type power domain.
 	"include/dt-bindings/power/rk3366-power.h" - for RK3366 type power domain.
@@ -96,6 +98,7 @@ containing a phandle to the power device node and an index specifying which
 power domain to use.
 The index should use macros in:
 	"include/dt-bindings/power/rk3036-power.h" - for rk3036 type power domain.
+	"include/dt-bindings/power/rk3128-power.h" - for rk3128 type power domain.
 	"include/dt-bindings/power/rk3288-power.h" - for rk3288 type power domain.
 	"include/dt-bindings/power/rk3328-power.h" - for rk3328 type power domain.
 	"include/dt-bindings/power/rk3366-power.h" - for rk3366 type power domain.
-- 
1.9.1
