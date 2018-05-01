Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754769AbeEAJLm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 05:11:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44146 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751676AbeEAJLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 05:11:37 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, robert.walker@arm.com, mark.rutland@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com, sudeep.holla@arm.com,
        frowand.list@gmail.com, robh@kernel.org, john.horley@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v2 11/27] dts: juno: Add scatter-gather support for all revisions
Date: Tue,  1 May 2018 10:10:41 +0100
Message-Id: <1525165857-11096-12-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
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
index eb749c5..34ae303 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -198,6 +198,7 @@
 		clocks = <&soc_smc50mhz>;
 		clock-names = "apb_pclk";
 		power-domains = <&scpi_devpd 0>;
+		scatter-gather;
 		port {
 			etr_in_port: endpoint {
 				slave-mode;
-- 
2.7.4
