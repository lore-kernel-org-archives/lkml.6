Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752489AbeERQkw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 12:40:52 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56118 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752201AbeERQjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 12:39:49 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        robh@kernel.org, sudeep.holla@arm.com, frowand.list@gmail.com,
        coresight@lists.linaro.org, mark.rutland@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 07/11] dts: juno: Add scatter-gather support for all revisions
Date: Fri, 18 May 2018 17:39:23 +0100
Message-Id: <1526661567-4578-8-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526661567-4578-1-git-send-email-suzuki.poulose@arm.com>
References: <1526661567-4578-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Advertise that the scatter-gather is properly integrated on
all revisions of Juno board.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/boot/dts/arm/juno-base.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index eb749c5..6ce9090 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -198,6 +198,7 @@
 		clocks = <&soc_smc50mhz>;
 		clock-names = "apb_pclk";
 		power-domains = <&scpi_devpd 0>;
+		arm,scatter-gather;
 		port {
 			etr_in_port: endpoint {
 				slave-mode;
-- 
2.7.4
