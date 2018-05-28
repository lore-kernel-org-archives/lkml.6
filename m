Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754516AbeE1Jyx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:54:53 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42969 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754348AbeE1Jyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:54:49 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180528095446euoutp02b4a7883a95950b963265f622a3ae5682~yxlPHgxsV1797017970euoutp025
X-AuditID: cbfec7f4-6f9ff700000043e4-7b-5b0bd1e51fd4
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
Subject: [PATCH 10/12] ARM: dts: exynos5250: add DSI node
Date: Mon, 28 May 2018 11:54:32 +0200
Message-id: <1527501272-16365-1-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1527500833-16005-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0iTYRTHfbb35nTxNjWfrKSWgQlqWdQTRWiovJ9CQkMmtFa+qOVUNjWN
        SBG8zPuFdJq3xC7q1FIzU1QwdZjoWt5KWEqaNZf4QTNvrDY3v/3///M75zwHHooryMRdqKiY
        eFYWI4kWEjysc3hr3POH1i7szOKmG5ptGcdR3vgIB6VlreDojbIVRzWDpmzyzyqBiucKMfTr
        mxZDBQsGLtJoXpNoLO03iRRF9SRqW5jG0UR3JYGUmj4OqtXPYqh5UEei5zNaDkrvHSSRskRP
        oK3uaszXiVFVqwAzkZ/HYd5X6EjmaVY5zrQ1Kgjm3cY8zszlqDlMe30Kk9/RCJi1Ntcgnoh3
        JZyNjkpkZd5Xb/Miq/uXsbhhKkmn8EsFW0Q2sKUgfR5OVSyR2YBHCehXAGrUQ1yLWQOwsrkc
        36dWq/oxS+EFgA2bw1bzD8CWv7mmFooiaA+oyhSbc0e6EcD2LyvAbLj0Exx+qjHsjXKgL8Hh
        BsXecow+BccMZaRZ82l/+HJbSVrWucKv4wquWdvSAXCiN4MwD4J0AQkNP/WYBfKHkyWl1vc5
        wGV1h7X5KJwoybEysTB9acGaJ8G+vFErfxl+UGv3NJc+AIs7y/YugDQfZmUILAgDi2fqgOVK
        JYBFWSNYIThcC2wagTObIJdGsHKfGPaBl1wilSfERHjdjZW2AdP3GDWq17tA9+6dAUBTQGjP
        T93hhQlwSaI8WToAIMUVOvJ5nqaIHy5JfsjKYsWyhGhWPgCOUJjQmX/L/bFIQEdI4tn7LBvH
        yvarHMrWJRWckLmEtXsl1zWlEZ6ioEUn+1B36TXDpF+i8KNq2y1ePHdsZKRBlzEtuuB9Oio4
        pHZn1e54YsjnXLr0oIO29bq+f7dGtjZv7KkLkFb1+Uyds0ktoIxSQc+9ouZnTWnG76Ibby9u
        BvreTFnv6toIPBkKB0r1h6KVYsOjYNWQsZAjxOSRkrMeXJlc8h/de/8eGgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsVy+t/xq7pPLnJHG8zvM7O4te4cq0XvuZNM
        Fk0db1ktNs5Yz2ox/whQ7MrX92wWk+5PYLF4ce8ii0X/49fMFufPb2C3ONv0ht2ic+ISdotN
        j6+xWlzeNYfNYsb5fUwWC17eYrFYe+Quu8XS6xeZLFr3HmG3mDH5JZvFz13zWBxEPdbMW8Po
        cbmvl8lj56y77B6zO2ayemxa1cnmsf3bA1aP+93HmTw2L6n36NuyitHj8ya5AK4oLpuU1JzM
        stQifbsErox5+1+xFBzjqLjb6djA+JOti5GTQ0LAROL93P0sXYxcHEICSxglju6ezAThNDJJ
        HGt8xtrFyMHBJqAlsaY9HiQuIrCKUWLq3zvsIA6zwGxWiVePJjCCjBIWsJQ4trITbCyLgKrE
        2dfT2UFsXgEXieW/ZrBDrJOTuHmukxnE5hRwlbi8tw2sXgioZnvjLJYJjDwLGBlWMYqklhbn
        pucWG+kVJ+YWl+al6yXn525iBAb+tmM/t+xg7HoXfIhRgINRiYdX4ydXtBBrYllxZe4hRgkO
        ZiURXi5doBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe8waVUUIC6YklqdmpqQWpRTBZJg5OqQbG
        fLmY3fF3yo+aLJn7w5WdJzzEx2DeCXvb+zvW7tWK3bLi56No78mzzA8w/dNW1c3+oB6ztFU6
        ft3v+R8eMrLnnJaauSZVQTR2tt7dJZ9eLTJZ9792AV/N3qn1ujEB5gxu7SGXb935HrSeYdfh
        H/pfl7nH31Tk6S1cepI3Vm12tbyh9fSjt7n5lViKMxINtZiLihMBR/Px/ngCAAA=
X-CMS-MailID: 20180528095444eucas1p222e4054b8fb8997258182e501f37a10b
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180528095444eucas1p222e4054b8fb8997258182e501f37a10b
References: <1527500833-16005-1-git-send-email-m.purski@samsung.com>
        <CGME20180528095444eucas1p222e4054b8fb8997258182e501f37a10b@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch adds common part of DSI node for Exynos5250 platforms.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 arch/arm/boot/dts/exynos5250.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index a63b655..7403b96 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -739,6 +739,20 @@
 			syscon = <&pmu_system_controller>;
 		};
 
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
