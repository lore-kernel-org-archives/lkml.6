Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751762AbeFEGCZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 02:02:25 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:36561 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751601AbeFEGCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 02:02:23 -0400
From: Nishanth Menon <nm@ti.com>
To: Santosh Shilimkar <ssantosh@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>
CC: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tony Lindgren <tony@atomide.com>, Vignesh R <vigneshr@ti.com>,
        Tero Kristo <t-kristo@ti.com>, Russell King <linux@armlinux.org.uk>,
        Sudeep Holla <sudeep.holla@arm.com>, Nishanth Menon <nm@ti.com>
Subject: [RFC PATCH 2/6] arm64: Add support for TI's K3 Multicore SoC architecture
Date: Tue, 5 Jun 2018 01:01:21 -0500
Message-ID: <20180605060125.9518-3-nm@ti.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180605060125.9518-1-nm@ti.com>
References: <20180605060125.9518-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Texas Instrument's K3 Multicore SoC architecture
processors.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/Kconfig.platforms | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index d5aeac351fc3..52df25bf4f8c 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -71,6 +71,13 @@ config ARCH_EXYNOS
 	help
 	  This enables support for ARMv8 based Samsung Exynos SoC family.
 
+config ARCH_K3
+	bool "Texas Instruments Inc. K3 multicore SoC architecture"
+	select PM_GENERIC_DOMAINS if PM
+	help
+	  This enables support for Texas Instruments' K3 multicore SoC
+	  architecture.
+
 config ARCH_LAYERSCAPE
 	bool "ARMv8 based Freescale Layerscape SoC family"
 	select EDAC_SUPPORT
-- 
2.15.1
