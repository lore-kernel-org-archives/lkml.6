Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751453AbeBVTGt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 14:06:49 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:48980 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbeBVTGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 14:06:45 -0500
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: arnd@arndb.de, geert@linux-m68k.org, horms@verge.net.au,
        magnus.damm@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] arm64: dts: renesas: r8a77965: Remove stale reg property
Date: Thu, 22 Feb 2018 20:06:07 +0100
Message-Id: <1519326370-15805-4-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519326370-15805-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1519326370-15805-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove "reg" property from cache-controller-0 device node as it does not
have any unit address.

This silences the following DTC compiler warning:
Warning (unit_address_vs_reg): Node /cpus/cache-controller-0 has a reg
or ranges property, but no unit name

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index ab46cd2..be4f25c 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -47,7 +47,6 @@
 
 		L2_CA57: cache-controller-0 {
 			compatible = "cache";
-			reg = <0>;
 			power-domains = <&sysc 12>;
 			cache-unified;
 			cache-level = <2>;
-- 
2.7.4
