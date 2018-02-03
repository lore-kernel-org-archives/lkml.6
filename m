Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752690AbeBCPvA (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 10:51:00 -0500
Received: from vegas.theobroma-systems.com ([144.76.126.164]:56589 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752607AbeBCPuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 10:50:44 -0500
From: Klaus Goger <klaus.goger@theobroma-systems.com>
To: linux-rockchip@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Klaus Goger <klaus.goger@theobroma-systems.com>
Subject: [PATCH v2 1/2] arm64: dts: rockchip: add i2s0-2ch-bus pins on rk3399
Date: Sat,  3 Feb 2018 16:50:15 +0100
Message-Id: <20180203155016.51909-2-klaus.goger@theobroma-systems.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180203155016.51909-1-klaus.goger@theobroma-systems.com>
References: <20180203155016.51909-1-klaus.goger@theobroma-systems.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pin definition for I2S0 if used as a 2-channel only bus.

Signed-off-by: Klaus Goger <klaus.goger@theobroma-systems.com>

---

Changes in v2: None

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 7aa2144e0d47..3092700768e2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -2043,6 +2043,16 @@
 		};
 
 		i2s0 {
+			i2s0_2ch_bus: i2s0-2ch-bus {
+				rockchip,pins =
+					<3 24 RK_FUNC_1 &pcfg_pull_none>,
+					<3 25 RK_FUNC_1 &pcfg_pull_none>,
+					<3 26 RK_FUNC_1 &pcfg_pull_none>,
+					<3 27 RK_FUNC_1 &pcfg_pull_none>,
+					<3 31 RK_FUNC_1 &pcfg_pull_none>,
+					<4 0 RK_FUNC_1 &pcfg_pull_none>;
+			};
+
 			i2s0_8ch_bus: i2s0-8ch-bus {
 				rockchip,pins =
 					<3 24 RK_FUNC_1 &pcfg_pull_none>,
-- 
2.11.0
