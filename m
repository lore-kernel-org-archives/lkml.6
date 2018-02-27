Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752943AbeB0KXz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 05:23:55 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:49963 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752909AbeB0KXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 05:23:53 -0500
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: geert@linux-m68k.org, horms@verge.net.au,
        sergei.shtylyov@cogentembedded.com, magnus.damm@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/10] arm64: dts: renesas: r8a77995: Set EtherAVB phy mode to "rgmii"
Date: Tue, 27 Feb 2018 11:22:52 +0100
Message-Id: <1519726974-23160-9-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519726974-23160-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1519726974-23160-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the "phy-mode" property of EtherAVB device to "rgmii" and let board
files override it if the installed PHY layer provides delays for the
RX/TX channels.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a77995.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
index cd3c6a3..fc48677 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
@@ -512,7 +512,7 @@
 			clocks = <&cpg CPG_MOD 812>;
 			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
 			resets = <&cpg 812>;
-			phy-mode = "rgmii-txid";
+			phy-mode = "rgmii";
 			iommus = <&ipmmu_ds0 16>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.7.4
