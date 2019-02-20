Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6AEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73DB420880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfBTMHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:07:38 -0500
Received: from unicorn.mansr.com ([81.2.72.234]:44766 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbfBTMHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 07:07:37 -0500
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 6DC5A15632; Wed, 20 Feb 2019 12:07:36 +0000 (GMT)
From:   Mans Rullgard <mans@mansr.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM: dts: sun7i: add pinctrl for missing uart mux options
Date:   Wed, 20 Feb 2019 12:07:17 +0000
Message-Id: <20190220120717.30650-1-mans@mansr.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190216182132.12895-1-mans@mansr.com>
References: <20190216182132.12895-1-mans@mansr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds pinctrl settings for various missing uart options.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
Changed in v2:
- add /omit-if-no-ref/ tags to new nodes
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 54 ++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index af5b067a5f83..76d0c961f01e 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -944,6 +944,36 @@
 				function = "uart0";
 			};
 
+			/omit-if-no-ref/
+			uart0_pf_pins: uart0-pf-pins {
+				pins = "PF2", "PF4";
+				function = "uart0";
+			};
+
+			/omit-if-no-ref/
+			uart1_pa_pins: uart1-pa-pins {
+				pins = "PA10", "PA11";
+				function = "uart1";
+			};
+
+			/omit-if-no-ref/
+			uart1_cts_rts_pa_pins: uart1-cts-rts-pa-pins {
+				pins = "PA12", "PIA13";
+				function = "uart2";
+			};
+
+			/omit-if-no-ref/
+			uart2_pa_pins: uart2-pa-pins {
+				pins = "PIA2", "PIA3";
+				function = "uart2";
+			};
+
+			/omit-if-no-ref/
+			uart2_cts_rts_pa_pins: uart2-cts-rts-pa-pins {
+				pins = "PA0", "PIA1";
+				function = "uart2";
+			};
+
 			uart2_pi_pins: uart2-pi-pins {
 				pins = "PI18", "PI19";
 				function = "uart2";
@@ -969,6 +999,12 @@
 				function = "uart3";
 			};
 
+			/omit-if-no-ref/
+			uart3_cts_rts_ph_pins: uart3-cts-rts-ph-pins {
+				pins = "PH2", "PH3";
+				function = "uart3";
+			};
+
 			uart4_pg_pins: uart4-pg-pins {
 				pins = "PG10", "PG11";
 				function = "uart4";
@@ -979,16 +1015,34 @@
 				function = "uart4";
 			};
 
+			/omit-if-no-ref/
+			uart5_ph_pins: uart5-ph-pins {
+				pins = "PH6", "PH7";
+				function = "uart5";
+			};
+
 			uart5_pi_pins: uart5-pi-pins {
 				pins = "PI10", "PI11";
 				function = "uart5";
 			};
 
+			/omit-if-no-ref/
+			uart6_pa_pins: uart6-pa-pins {
+				pins = "PA12", "PA13";
+				function = "uart6";
+			};
+
 			uart6_pi_pins: uart6-pi-pins {
 				pins = "PI12", "PI13";
 				function = "uart6";
 			};
 
+			/omit-if-no-ref/
+			uart7_pa_pins: uart7-pa-pins {
+				pins = "PA14", "PA15";
+				function = "uart7";
+			};
+
 			uart7_pi_pins: uart7-pi-pins {
 				pins = "PI20", "PI21";
 				function = "uart7";
-- 
2.20.1

