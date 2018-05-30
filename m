Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753658AbeE3MSJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 08:18:09 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47713 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752653AbeE3MQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 08:16:35 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180530121633euoutp01cf8941a9cd3e71275b239fd519ec4d18~zazmF48h20899308993euoutp010
X-AuditID: cbfec7f4-b4fc79c0000043e4-8e-5b0e961e512e
From: Maciej Purski <m.purski@samsung.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH v2 09/10] ARM: dts: exynos5250: add DSI node
Date: Wed, 30 May 2018 14:16:00 +0200
Message-id: <1527682561-1386-10-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1527682561-1386-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzVSa0hTURzv7N67ex1OLlPzZKIxkFJITYIOKmrghwslRBaUQjr1ptKmsutM
        M0oUzQfa3DJNQ0XMaj7KKVq+8j1Mc4rii3SSKD6SEjUaSLaHfvud35M/HAoT5RLOVEJiCitP
        lEjFfAHePmLUX3R9aRfho9nyQovNEwQqmhjloay8HQK1lH8gUPWQiZs5+MVHKoMSRxvLUzh6
        vrqNIb3+I4m+Zf0kUX5JHYm0q7MEmu58zUfl+l4eqtlcxFHT0BKJ3sxN8VBOzxCJytWbfGTs
        rMKDHZnGqkbATBcX8ZjPFUskU5n3imC0mnw+0/FnhWAMhToe01r3lClu0wBmT+t6QxAuCIhl
        pQmprNw7MEoQ3509iyWPCNJ2S9+CTDBIFQAbCtKXYcfwF9KMRfQ7AGuVsAAITHgPwJqFFezE
        dKSeAVahHkDdqJGwPo4AXKnuNykUxac9YeOzSDPvQGsAbJ3fsSQwupSAk9XbhLnKng6AXboV
        C8Zpd9inzLJMCOkQOKHfJa1zrnBhIh8zl9qY+IbuQHMPpNUkPCipJ6yeEDiyoeVZsT3c0rUd
        Z13gtLoQt+IkmLO+esynwd6iseOsPxzUTVkwRttBVXuZZQvSQpiXK7JaGNg19QK3HlkG4HpD
        PVCCMzXglAY4sQpOFsdyvonsQy9OIuMUiXFeMUkyLTD9jrF/uv1PoPMwegDQFBDbCn3uCCNE
        hCSVS5cNAEhhYgehosc2QiSMlaQ/YuVJkXKFlOUGwFkKFzsJ7114Ei6i4yQp7AOWTWblJyqP
        snHOBLfGH4f6X8kJG3YKDvLsaDV6+zU7hu+/b8GqBieXr0eWXIUYUVmYoepT+Hq4ZJx3d5lz
        MzRJvx76y/gSFVn5o3Y/2+durbzppiyULb3v4WewDXOZDOKxMWF7Ydtrdyu+R+PJnGYtajjz
        3O2/CkOMAR/vn5z/fRoLcLuGxcnkYpyLl1zyxOSc5D8aa1CDGQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsVy+t/xy7qy0/iiDb7/k7S4te4cq0XvuZNM
        Fk0db1ktNs5Yz2ox/whQ7MrX92wWk+5PYLF4ce8ii0X/49fMFufPb2C3ONv0ht2ic+ISdotN
        j6+xWlzeNYfNYsb5fUwWC17eYrFYe+Quu8XS6xeZLFr3HmG3mDH5JZvFz13zWBxEPdbMW8Po
        cbmvl8lj56y77B6zO2ayemxa1cnmsf3bA1aP+93HmTw2L6n36NuyitHj8ya5AK4oLpuU1JzM
        stQifbsErow9zdeYC45xVXycupyxgfEwRxcjJ4eEgInE/8lXGLsYuTiEBJYwSrw9fpoJwmlk
        klgxfQJLFyMHB5uAlsSa9niQuIjAKkaJqX/vsIM4zAKzWSVePZrACDJKWMBGYvfxB6wgNouA
        qsSBCU3MIDavgIvEufMf2SHWyUncPNfJDDKUEyi+eo8dSFhIwFliX0sn4wRGngWMDKsYRVJL
        i3PTc4uN9IoTc4tL89L1kvNzNzECA3/bsZ9bdjB2vQs+xCjAwajEw2sQwRstxJpYVlyZe4hR
        goNZSYS3dC9PtBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe8waVUUIC6YklqdmpqQWpRTBZJg5O
        qQZGwab6Z31+Pt6nw94ssfz5bk3MKcaDO6Ja+8S6C95rbzZI2uj1t0de4dOSh+b991hviIos
        50h9vVi6y6G3heXP6sAgs9auuvaLmff9Xi0z9TMzPXpp/xyT9cWi+cqJ7skC5tv/ra3b4JPw
        WUagz15hktMdu68VM7tns7OnWTyasDw3b8m59wxKLMUZiYZazEXFiQB5Xt1teAIAAA==
X-CMS-MailID: 20180530121629eucas1p2cc1a8c3f5a8e704f4d6f3cf75834cf00
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180530121629eucas1p2cc1a8c3f5a8e704f4d6f3cf75834cf00
References: <1527682561-1386-1-git-send-email-m.purski@samsung.com>
        <CGME20180530121629eucas1p2cc1a8c3f5a8e704f4d6f3cf75834cf00@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrzej Hajda <a.hajda@samsung.com>

The patch adds common part of DSI node for Exynos5250 platforms
and a required mipi-phy node.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 arch/arm/boot/dts/exynos5250.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 2daf505..9965eca 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -733,6 +733,27 @@
 			#phy-cells = <0>;
 		};
 
+		mipi_phy: video-phy@10040710 {
+			compatible = "samsung,s5pv210-mipi-video-phy";
+			reg = <0x10040710 0x100>;
+			#phy-cells = <1>;
+			syscon = <&pmu_system_controller>;
+		};
+
+		dsi_0: dsi@14500000 {
+			compatible = "samsung,exynos4210-mipi-dsi";
+			reg = <0x14500000 0x10000>;
+			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+			samsung,power-domain = <&pd_disp1>;
+			phys = <&mipi_phy 3>;
+			phy-names = "dsim";
+			clocks = <&clock CLK_DSIM0>, <&clock CLK_SCLK_MIPI1>;
+			clock-names = "bus_clk", "sclk_mipi";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		adc: adc@12d10000 {
 			compatible = "samsung,exynos-adc-v1";
 			reg = <0x12D10000 0x100>;
-- 
2.7.4
