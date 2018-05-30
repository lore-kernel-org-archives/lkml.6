Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753884AbeE3PLx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 11:11:53 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41991 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753553AbeE3PK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 11:10:26 -0400
X-Google-Smtp-Source: ADUXVKLc9Q60G40NkYHOlBBEg581d4ahlmJkZSiQUUQjw9UEMbN3Sr6Xu6Ew/EXKgqbD1q8AcTD5xQ==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/4] ARM: dts: tegra20: Add interrupt to External Memory Controller
Date: Wed, 30 May 2018 18:06:44 +0300
Message-Id: <20180530150646.19030-3-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180530150646.19030-1-digetx@gmail.com>
References: <20180530150646.19030-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interrupt entry into the EMC DT node.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 983dd5c14794..3cd3cb28cfd9 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -609,6 +609,7 @@
 	memory-controller@7000f400 {
 		compatible = "nvidia,tegra20-emc";
 		reg = <0x7000f400 0x200>;
+		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
-- 
2.17.0
