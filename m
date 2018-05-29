Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934683AbeE2NSI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 09:18:08 -0400
Received: from foss.arm.com ([217.140.101.70]:40026 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934753AbeE2NQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 09:16:30 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, robert.walker@arm.com,
        coresight@lists.linaro.org, devicetree@vger.kernel.org,
        robh@kernel.org, frowand.list@gmail.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v2 07/12] dts: juno: Add scatter-gather support for all revisions
Date: Tue, 29 May 2018 14:15:32 +0100
Message-Id: <1527599737-28408-8-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527599737-28408-1-git-send-email-suzuki.poulose@arm.com>
References: <1527599737-28408-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Advertise that the scatter-gather is properly integrated on
all revisions of Juno board.

Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
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
